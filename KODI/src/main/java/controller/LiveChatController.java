package controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import dto.AllChatDTO;
import dto.ChatMsgRq;
import jakarta.servlet.http.HttpSession;
import service.LiveChatService;
import service.PapagoService;

@Controller
@RequestMapping("/api")
public class LiveChatController {
	@Autowired
	@Qualifier("livechatservice")
	LiveChatService liveChatService;
	
	@Autowired
	@Qualifier("papagoservice")
	PapagoService papagoService;
	
	/**
	 * 과거 채팅방 메시지 조회 API
	 * @param chatIdx
	 * @return 과거 채팅방 메시지 리스트
	 * @throws JsonProcessingException 
	 * @throws JsonMappingException 
	 */
	@GetMapping("/chatroom/{chatIdx}")
	public ModelAndView liveChat(HttpSession session, @PathVariable int chatIdx) throws JsonMappingException, JsonProcessingException {
		List<AllChatDTO> allChatMsg = liveChatService.selectAllChatMsg(chatIdx);

		ModelAndView mv = new ModelAndView();
		int memberIdx;

		if(session.getAttribute("memberIdx") == null) {
        	mv.addObject("isSession", false);
		} else {
        	mv.addObject("isSession", true);

			memberIdx = Integer.parseInt(String.valueOf(session.getAttribute("memberIdx")));			
			
			int n = 0;
			
			for (AllChatDTO oneChat : allChatMsg) {	
				boolean compareLang = papagoService.compareLang(memberIdx, oneChat.getChatMsgDTO().getMemberIdx());
				String msg;
				
				if(compareLang == false) { // 같은 언어를 쓰는 사람들이면 메시지 그대로 전달
					msg = "{\"message\":{\"result\":{\"srcLangType\":\"ko\",\"tarLangType\":\"ko\",\"translatedText\":\""+ oneChat.getChatMsgDTO().getContent() +"\"}}}";
				} else { // 다른 언어를 쓰면 번역해서 전달
					msg = papagoService.translateMsg(memberIdx, oneChat.getChatMsgDTO().getMemberIdx(), oneChat.getChatMsgDTO().getContent());
				}
				
				ObjectMapper mapper = new ObjectMapper();
				JsonNode jsonNode = mapper.readValue(msg, JsonNode.class);
				
				String content = jsonNode.findValue("translatedText").toString();
				
				if(content.contains("\"")) {
					content = content.replace("\"", "");
				}
				
				if(content.contains("'")) {
					content = content.replace("'", "\\'");
				}
							
				allChatMsg.get(n).getChatMsgDTO().setContent(content);
				n++;
			}
		}
				
		mv.addObject("allChatMsg", allChatMsg);
		mv.addObject("chatIdx", chatIdx);
		
		mv.setViewName("LiveChat");
		
		return mv;
	}
	
	/**
	 * 채팅방 권한 조회 API
	 * @param memberIdx
	 * @param chatIdx
	 * @return 채팅방 권한 여부(1|0)
	 */
	@PostMapping("/chatroom/verifymember")
	@ResponseBody
	public int verifyMember(int memberIdx, int chatIdx) {		
		return liveChatService.verifyMember(memberIdx, chatIdx);
	}
	
	/**
	 * WebSocket 메시지 DB 저장 API
	 * @param chatMsgRq
	 * @return DB 저장 성공 여부(1|0)
	 */
	@PostMapping("/chatroom/savemsg")
	@ResponseBody
	public int saveMsg(@RequestBody ChatMsgRq chatMsgRq) {
		return liveChatService.saveChatMsg(chatMsgRq.getMemberIdx(), chatMsgRq.getChatIdx(), chatMsgRq.getContent());
	}
	
	/**
	 * 메시지 작성자명 조회 API
	 * @param memberIdx
	 * @return 메시지 작성자명
	 */
	@PostMapping("/chatroom/showmembername")
	@ResponseBody
	public String showMemberName(int memberIdx) {
		return liveChatService.showMemberName(memberIdx);
	}
	
	/**
	 * 실시간 통신하는 메시지 자동번역
	 * @param session
	 * @param msg
	 * @param sendMemberIdx
	 * @return 국적별로 자동번역한 메시지 내용
	 * @throws JsonProcessingException 
	 * @throws JsonMappingException 
	 */
	@PostMapping("/chatroom/translatemsg")
	@ResponseBody
	public String translateMsg(HttpSession session, String msg, int sendMemberIdx) throws JsonMappingException, JsonProcessingException {
		int memberIdx = Integer.parseInt(String.valueOf(session.getAttribute("memberIdx")));
		
		boolean compareLang = papagoService.compareLang(memberIdx, sendMemberIdx);
		String message;
		
		if(compareLang == false) { // 같은 언어를 쓰는 사람들이면 메시지 그대로 전달
			message = "{\"message\":{\"result\":{\"srcLangType\":\"ko\",\"tarLangType\":\"ko\",\"translatedText\":\""+ msg +"\"}}}";
		} else { // 다른 언어를 쓰면 번역해서 전달
			message = papagoService.translateMsg(memberIdx, sendMemberIdx, msg);
		}
		
		ObjectMapper mapper = new ObjectMapper();
		JsonNode jsonNode = mapper.readValue(message, JsonNode.class);
		
		String content = jsonNode.findValue("translatedText").toString();
		
		if(content.contains("\"")) {
			content = content.replace("\"", "");
		}
		
		if(content.contains("'")) {
			content = content.replace("'", "\\'");
		}
		
		return content;
	}
}
