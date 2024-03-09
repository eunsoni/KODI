package controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import dto.ChatListDTO;
import dto.ChatListFriendDTO;
import dto.ChatRq;
import dto.FriendRq;
import jakarta.servlet.http.HttpSession;
import service.ChatListService;

@Controller
@RequestMapping("/api")
public class ChatListController {
	@Autowired
	@Qualifier("chatlistservice")
	ChatListService service;

	/**
	 * 채팅 리스트 정보 조회 API
	 * @param memberIdx
	 * @return 전체 친구 리스트, 채팅방 리스트
	 */
	@GetMapping("/chatlist/{memberIdx}")
	public ModelAndView chatList(HttpSession session, @PathVariable int memberIdx) {
		ChatListDTO chatListInfo = service.getChatListInfo(memberIdx);
		
		int sessionMemberIdx;
		ModelAndView mv = new ModelAndView();

		if(session.getAttribute("memberIdx") == null) {
        	mv.addObject("isSession", false);
        	sessionMemberIdx = 0;
		} else {
        	mv.addObject("isSession", true);
			sessionMemberIdx = Integer.parseInt(String.valueOf(session.getAttribute("memberIdx")));
		}

		if(sessionMemberIdx == memberIdx) {
			mv.addObject("verifyMemberIdx", true);
		} else {
			mv.addObject("verifyMemberIdx", false);
		}
		
		mv.addObject("chatListInfo", chatListInfo);
		mv.setViewName("ChatList");
		
		return mv;
	}
	
	/**
	 * 채팅방 여부 조회 API
	 * @param clickChatInfo
	 * @return 채팅방 여부
	 */
	@PostMapping("/chatlist/clickchat")
	@ResponseBody
	public boolean clickChat(@RequestBody ChatRq chatInfo) {		
		return service.selectChatRoom(chatInfo.getMemberIdx(), chatInfo.getFriendMemberIdx());
	}
	
	/**
	 * 채팅방 번호 조회 API
	 * @param chatInfo
	 * @return 채팅방 번호
	 */
	@PostMapping("/chatlist/chatidx")
	@ResponseBody
	public int searchChatIdx(@RequestBody ChatRq chatInfo) {		
		return service.selectChatIdx(chatInfo.getMemberIdx(), chatInfo.getFriendMemberIdx());
	}
	
	/**
	 * 새로운 채팅방 생성 후 채팅방 번호 조회 API
	 * @param chatInfo
	 * @return 생성한 채팅방 번호
	 */
	@PostMapping("/chatlist/createchatroom")
	@ResponseBody
	public int createChatRoom(@RequestBody ChatRq chatInfo) {		
		service.createChatRoom(chatInfo.getMemberIdx(), chatInfo.getFriendMemberIdx());
		return service.selectChatIdx(chatInfo.getMemberIdx(), chatInfo.getFriendMemberIdx());
	}
	
	/**
	 * 친구 검색 API
	 * @param friendRq
	 * @return
	 */
	@PostMapping("/chatlist/search")
	@ResponseBody
	public List<ChatListFriendDTO> searchFriend(@RequestBody FriendRq friendRq) {		
		return service.searchFriend(friendRq.getMemberIdx(), friendRq.getFriendName());
	}
	
	/**
	 * 채팅방 삭제 API
	 * @param chatIdx
	 * @return 삭제 여부(1|0)
	 */
	@PostMapping("/chatlist/deletechat")
	@ResponseBody
	public int deleteChat(int chatIdx) {
		return service.deleteChat(chatIdx);
	}
}
