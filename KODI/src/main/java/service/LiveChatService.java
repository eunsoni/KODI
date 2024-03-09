package service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import dao.LiveChatDAO;
import dto.AllChatDTO;
import dto.ChatMsgDTO;

@Service("livechatservice")
public class LiveChatService {
	@Autowired
	@Qualifier("livechatdao")
	LiveChatDAO dao;
	
	/**
	 * 과거 채팅방 메시지 조회
	 * @param chatIdx
	 * @return 과거 채팅방 메시지 리스트
	 */
	public List<AllChatDTO> selectAllChatMsg(int chatIdx) {		
		List<ChatMsgDTO> chatMsgDTO = dao.selectAllChatMsg(chatIdx);
		
		List<AllChatDTO> allChatDTO = new ArrayList<>();
		
		for (ChatMsgDTO dto : chatMsgDTO) {
			String memberName = dao.selectMemberName(dto.getMemberIdx());
			
			allChatDTO.add(new AllChatDTO(dto, memberName));
		}

		return allChatDTO;
	}
	
	/**
	 * 채팅방 권한 조회
	 * @param memberIdx
	 * @param chatIdx
	 * @return 채팅방 권한 여부(1|0)
	 */
	public int verifyMember(int memberIdx, int chatIdx) {
		HashMap<String, Integer> map = new HashMap<>();
		
		map.put("memberIdx", memberIdx);
		map.put("chatIdx", chatIdx);
		
		return dao.verifyMember(map);
	}

	/**
	 * WebSocket 메시지 DB 저장
	 * @param memberIdx
	 * @param chatIdx
	 * @param content
	 * @return DB 저장 성공 여부(1|0)
	 */
	public int saveChatMsg(int memberIdx, int chatIdx, String content) {
		HashMap<String, Object> map = new HashMap<>();
		
		map.put("memberIdx", memberIdx);
		map.put("chatIdx", chatIdx);
		map.put("content", content);
		
		return dao.insertChatMsg(map);
	}

	/**
	 * 메시지 작성자명 조회
	 * @param memberIdx
	 * @return 메시지 작성자명
	 */
	public String showMemberName(int memberIdx) {
		return dao.selectMemberName(memberIdx);
	}
}
