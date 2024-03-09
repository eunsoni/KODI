package service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import dao.ChatListDAO;
import dto.ChatListDTO;
import dto.ChatListFriendDTO;
import dto.ChatListRoomDTO;

@Service("chatlistservice")
public class ChatListService {
	@Autowired
	@Qualifier("chatlistdao")
	ChatListDAO dao;
	
	@Autowired
	@Qualifier("papagoservice")
	PapagoService papagoService;
	
	/**
	 * 채팅 리스트 정보 조회
	 * @param memberIdx
	 * @return 전체 친구 리스트, 채팅방 리스트
	 */
	public ChatListDTO getChatListInfo(int memberIdx) {
		
		// 전체 친구 리스트
		List<Integer> allFriendMemberIdx = dao.selectFriendMemberIdx(memberIdx);
		List<ChatListFriendDTO> chatListFriendDTO = new ArrayList<>();
				
		for (Integer friendIdx : allFriendMemberIdx) {
			HashMap<String, Object> map = new HashMap<String, Object>();

			map.put("friendIdx", friendIdx);
			map.put("memberIdx", memberIdx);
			
			// 서로이웃 여부 확인
			int isFriendByMe = dao.selectIsFriendByMe(map);
			int isFriendByOther = dao.selectIsFriendByOther(map);

			if(isFriendByMe == 1 && isFriendByOther == 1) {
				String friendMemberName = dao.selectFriendMemberName(friendIdx);
				
				ChatListFriendDTO friendInfo = new ChatListFriendDTO(friendIdx, friendMemberName);
				chatListFriendDTO.add(friendInfo);
			}
		}
		
		// 채팅방 리스트
		List<Integer> allChatIdx = dao.selectChatList(memberIdx);
		List<ChatListRoomDTO> chatListRoomDTO = new ArrayList<>();
		
		for (Integer chatIdx : allChatIdx) {
			int chatMemberIdx1 = dao.selectChatMemberOneIdx(chatIdx);
			int chatMemberIdx2 = dao.selectChatMemberTwoIdx(chatIdx);
			
			if(chatMemberIdx1 == memberIdx) {
				String friendMemberName = dao.selectFriendMemberName(chatMemberIdx2);
				boolean compareLang = papagoService.compareLang(memberIdx, chatMemberIdx2);
				
				String content;
				
				if(compareLang == false) { // 같은 언어를 쓰는 사람들이면 메시지 그대로 전달
					content = "{\"message\":{\"result\":{\"srcLangType\":\"ko\",\"tarLangType\":\"ko\",\"translatedText\":\""+ dao.selectContent(chatIdx) +"\"}}}";
				} else { // 다른 언어를 쓰면 번역해서 전달
					content = papagoService.translateMsg(memberIdx, chatMemberIdx2, dao.selectContent(chatIdx));
				}

				ChatListRoomDTO chatInfo = new ChatListRoomDTO(chatIdx, chatMemberIdx2, friendMemberName, content);
				chatListRoomDTO.add(chatInfo);
			} else {
				String friendMemberName = dao.selectFriendMemberName(chatMemberIdx1);
				boolean compareLang = papagoService.compareLang(memberIdx, chatMemberIdx1);
				
				String content;
				
				if(compareLang == false) { // 같은 언어를 쓰는 사람들이면 메시지 그대로 전달
					content = "{\"message\":{\"result\":{\"srcLangType\":\"ko\",\"tarLangType\":\"ko\",\"translatedText\":\""+ dao.selectContent(chatIdx) +"\"}}}";
				} else { // 다른 언어를 쓰면 번역해서 전달
					content = papagoService.translateMsg(memberIdx, chatMemberIdx1, dao.selectContent(chatIdx));
				}
				
				ChatListRoomDTO chatInfo = new ChatListRoomDTO(chatIdx, chatMemberIdx1, friendMemberName, content);
				chatListRoomDTO.add(chatInfo);
			}
		}
		
		return new ChatListDTO(memberIdx, chatListFriendDTO, chatListRoomDTO);
	}

	/**
	 * 채팅방 여부 조회
	 * @param memberIdx
	 * @param friendMemberIdx
	 * @return 채팅방 여부
	 */
	public boolean selectChatRoom(int memberIdx, int friendMemberIdx) {
		HashMap<String, Integer> map = new HashMap<String, Integer>();

		map.put("memberIdx", memberIdx);
		map.put("friendMemberIdx", friendMemberIdx);
		
		int result1 = dao.selectChatRoom1(map);
		int result2 = dao.selectChatRoom2(map);

		if(result1 == 1 || result2 == 1) {
			return true;
		} else {
			return false;
		}
	}

	/**
	 * 채팅방 번호 조회
	 * @param memberIdx
	 * @param friendMemberIdx
	 * @return 채팅방 번호
	 */
	public int selectChatIdx(int memberIdx, int friendMemberIdx) {
		HashMap<String, Integer> map = new HashMap<String, Integer>();

		map.put("memberIdx", memberIdx);
		map.put("friendMemberIdx", friendMemberIdx);
		
		if(dao.selectChatIdxCnt(map) == 0) {
			return dao.selectChatIdx2(map);
		} else {
			return dao.selectChatIdx1(map);
		}
	}

	/**
	 * 새로운 채팅방 생성
	 * @param memberIdx
	 * @param friendMemberIdx
	 */
	public void createChatRoom(int memberIdx, int friendMemberIdx) {
		HashMap<String, Integer> map = new HashMap<String, Integer>();

		map.put("memberIdx", memberIdx);
		map.put("friendMemberIdx", friendMemberIdx);
		
		dao.insertChat(map);
	}

	/**
	 * 친구 검색
	 * @param memberIdx
	 * @param friendName
	 * @return 친구 정보
	 */
	public List<ChatListFriendDTO> searchFriend(int memberIdx, String friendName) {
		List<ChatListFriendDTO> chatListFriend = new ArrayList<>();

		HashMap<String, Object> map = new HashMap<String, Object>();

		map.put("friendName", friendName);
		map.put("memberIdx", memberIdx);
		
		List<ChatListFriendDTO> friendList = dao.selectFriendInfo(map);
		
		for (ChatListFriendDTO chatListFriendDTO : friendList) {
			map.put("friendIdx", chatListFriendDTO.getFriendMemberIdx());
			
			if(dao.searchFriendByFriendIdx(map) == 1){
				String friendMemberName = dao.selectFriendMemberName(chatListFriendDTO.getFriendMemberIdx());

				ChatListFriendDTO friendInfo = new ChatListFriendDTO(chatListFriendDTO.getFriendMemberIdx(), friendMemberName);
				chatListFriend.add(friendInfo);
			}
		}
		
		return chatListFriend;
	}

	/**
	 * 채팅방 삭제
	 * @param chatIdx
	 * @return 삭제 여부(1|0)
	 */
	public int deleteChat(int chatIdx) {
		return dao.deleteChat(chatIdx);
	}

}
