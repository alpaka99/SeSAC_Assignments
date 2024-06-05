//
//  MovieRankingViewController.swift
//  Day17Assignment
//
//  Created by user on 6/5/24.
//

import UIKit

import Alamofire

final class MovieRankingViewController: UIViewController {
    private let textField: UITextField = UITextField()
    private let divider: UIView = UIView()
    private let searchButton: UIButton = UIButton()
    private let tableView: UITableView = UITableView()
    
    
    private var boxOfficeResponse: BoxOfficeResponse = BoxOfficeResponse(boxOfficeResult: BoxOfficeResult(dailyBoxOfficeList: [])) {
        didSet {
            tableView.reloadData()
        }
    }
    
    private let urlPrefix: String = "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=f5eef3421c602c6cb7ea224104795888&targetDt="
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        configureHierarchy()
        configureLayout()
        configureUI()
    }
    
    private func configureHierarchy() {
        view.addSubview(textField)
        view.addSubview(divider)
        view.addSubview(searchButton)
        view.addSubview(tableView)
    }
    
    private func configureLayout() {
        textField.snp.makeConstraints { make in
            make.leading.top.equalTo(view.safeAreaLayoutGuide)
                .offset(8)
        }
        
        divider.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom)
                .offset(8)
            make.horizontalEdges.equalTo(textField.snp.horizontalEdges)
            make.height.equalTo(2)
        }
        
        searchButton.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.top)
            make.leading.equalTo(textField.snp.trailing)
                .offset(16)
            make.trailing.equalTo(view.safeAreaLayoutGuide)
                .inset(8)
            make.bottom.equalTo(divider.snp.bottom)
            make.width.equalTo(view.snp.width)
                .multipliedBy(0.15)
            make.height.equalTo(view.snp.height)
                .multipliedBy(0.05)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(divider.snp.bottom)
                .offset(16)
            
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
                .inset(16)
        }
    }
    
    private func configureUI() {
        view.backgroundColor = .black
        
        textField.textColor = .white
        textField.attributedPlaceholder = NSAttributedString(string: "날짜를 검색해보세요(ex. 20240605)", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        textField.addTarget(self, action: #selector(textFieldSubmitted), for: .editingDidEndOnExit)
        
        searchButton.backgroundColor = .systemBlue
        searchButton.setTitle("검색", for: .normal)
        searchButton.setTitleColor(.black, for: .normal)
        searchButton.backgroundColor = .white
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        
        divider.backgroundColor = .white
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.identifier)
        tableView.register(MovieRankingCell.self, forCellReuseIdentifier: MovieRankingCell.identifier)
        tableView.backgroundColor = .black // change to gradient
        tableView.separatorStyle = .none
    }
    
    private func fetchData() {
        if let date = textField.text {
            let url = urlPrefix+date
            AF.request(url).response { [weak self] response in
                switch response.result {
                case .success(_):
                    if let data = response.data, let decodedData = try? JSONDecoder().decode(BoxOfficeResponse.self, from: data) {
                        if decodedData.boxOfficeResult.dailyBoxOfficeList.isEmpty {
                            // show unsupported date alert
                            self?.showAlert(.unsupportedDate)
                            print("unsupported date")
                        } else {
                            self?.boxOfficeResponse = decodedData
                        }
                    } else {
                        // show unknonw error alert
                        self?.showAlert(.unknown)
                        print("unknown error")
                    }
                case .failure(let error):
                    // show unknonw error alert
//                    print("unknown error")
                    self?.showAlert(.unknown)
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    @objc
    private func textFieldSubmitted(_ sender: UITextField) {
        fetchData()
        view.endEditing(true)
    }
    
    @objc
    private func searchButtonTapped(_ sender: UIButton) {
        fetchData()
        view.endEditing(true)
    }
    
    private func showAlert(_ type: FailAlertType) {
        let ac = UIAlertController(title: type.title, message: type.message, preferredStyle: .alert)
        
        let conform = UIAlertAction(title: "확인", style: .default)
        ac.addAction(conform)
        
        present(ac, animated: true)
    }
}

extension MovieRankingViewController: UITableViewDelegate, UITableViewDataSource {
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return boxOfficeResponse.boxOfficeResult.dailyBoxOfficeList.count
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieRankingCell.identifier, for: indexPath) as? MovieRankingCell else { return UITableViewCell() }
        
        let data = boxOfficeResponse.boxOfficeResult.dailyBoxOfficeList[indexPath.row]
        cell.configureData(data)
        
        return cell
    }
    
    internal func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

enum FailAlertType {
    case unknown
    case unsupportedDate
    case notIntError
    
    var title: String {
        switch self {
        case .unknown, .unsupportedDate, .notIntError:
            return "알림"
        }
    }
    
    var message: String {
        switch self {
        case .unknown:
            return "알 수 없는 에러가 발생했습니다. 다시 시도해주세요"
        case .unsupportedDate:
            return "데이터가 없는 날짜입니다. 다른 날짜를 검색해주세요"
        case .notIntError:
            return "정수값을 입력해주세요"
        }
    }
}

//{
//    "rnum":"1",
//    "rank":"1",
//    "rankInten":"0",
//    "rankOldAndNew":"OLD",
//    "movieCd":"20112207",
//    "movieNm":"미션임파서블:고스트프로토콜",
//    "openDt":"2011-12-15",
//    "salesAmt":"2776060500",
//    "salesShare":"36.3",
//    "salesInten":"-415699000",
//    "salesChange":"-13",
//    "salesAcc":"40541108500",
//    "audiCnt":"353274",
//    "audiInten":"-60106",
//    "audiChange":"-14.5",
//    "audiAcc":"5328435",
//    "scrnCnt":"697",
//    "showCnt":"3223"
//}
