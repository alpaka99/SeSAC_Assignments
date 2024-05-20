//
//  MusicPlayerViewController.swift
//  Day5Assignment
//
//  Created by user on 5/20/24.
//

import UIKit

class MusicPlayerViewController: UIViewController {
    @IBOutlet var titleImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var titleSubLabel: UILabel!
    
    @IBOutlet var albumImageView: UIImageView!
    @IBOutlet var likeView: UIButton!
    @IBOutlet var followView: UIButton!
    @IBOutlet var instagramIconView: UIButton!
    
    @IBOutlet var lyricLabel: UILabel!
    @IBOutlet var playLoopButton: UIButton!
    @IBOutlet var playShuffleButton: UIButton!
    
    lazy var middleButtons: [UIButton] = [
        playLoopButton,
        playShuffleButton
    ]
    
    @IBOutlet var listButton: UIButton!
    @IBOutlet var volumeButton: UIButton!
    
    lazy var bottomOuterButtons: [UIButton] = [
        listButton,
        volumeButton
    ]
    
    @IBOutlet var previousButton: UIButton!
    @IBOutlet var playButton: UIButton!
    @IBOutlet var nextButton: UIButton!
    
    lazy var bottomInnerButtons: [UIButton] = [
        previousButton,
        playButton,
        nextButton
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // set title area
        
        // set album image area
        
        // set lyric label
        
        // set progress area
        
        // set bottom area
    }

}

private enum MiddleButtonType: CaseIterable {
    case playLoop
    case playShuffle
}

private enum BottomOuterButtonType: CaseIterable {
    case list
    case volume
}

private enum BottomInnerButtonType: CaseIterable {
    case previous
    case play
    case next
}
