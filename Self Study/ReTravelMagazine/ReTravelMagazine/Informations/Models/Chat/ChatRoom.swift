//
//  ChatRoom.swift
//  ReTravelMagazine
//
//  Created by user on 6/3/24.
//

//트래블톡 화면에서 사용할 데이터 구조체
struct ChatRoom {
    let chatroomId: Int //채팅방 고유 ID
    let chatroomImage: [String] //채팅방에 속한 유저 이미지
    let chatroomName: String //채팅방 이름
    var chatList: [Chat] = [] //채팅 화면에서 사용할 데이터
    
    var chatRoomUsers: String {
        return chatList.reduce("") { $0 + $1.user.rawValue }
    }
    
    var chatRoomMessages: String {
        return chatList.reduce("") { $0 + $1.message }
    }
    
    var chatRoomThumbnail: String {
        return chatroomImage.last ?? "dummyImage"
    }
    
    var chatRoomLastMessage: String {
        return chatList.last?.message ?? "새로운 채팅방입니다"
    }
}

