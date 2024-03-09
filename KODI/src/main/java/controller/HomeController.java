package controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import dto.HomeAllChatDTO;
import dto.VehicleDTO;
import jakarta.servlet.http.HttpSession;
import service.HomeService;
import service.PapagoService;

@Controller
@RequestMapping("/api")
public class HomeController {
	@Autowired
	@Qualifier("homeservice")
	HomeService service;
	
	@Autowired
	@Qualifier("papagoservice")
	PapagoService papagoService;
	
	/**
	 * 홈페이지 API
	 * @return 교통수단 비용 리스트
	 * @throws JsonProcessingException 
	 * @throws JsonMappingException 
	 */
	@GetMapping("/home")
	public ModelAndView home(HttpSession session) throws JsonMappingException, JsonProcessingException {
		List<VehicleDTO> vehicleList = service.getVehicleList();
		List<HomeAllChatDTO> allChatMsg = service.selectAllChatMsg();
		
		int memberIdx;
		ModelAndView mv = new ModelAndView();
		
		if(session.getAttribute("memberIdx") == null) {
        	mv.addObject("isSession", false);
		} else {
        	mv.addObject("isSession", true);

			memberIdx = Integer.parseInt(String.valueOf(session.getAttribute("memberIdx")));			
		
			int n = 0;
			
			for (HomeAllChatDTO oneChat : allChatMsg) {	
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
		mv.addObject("vehicleList", vehicleList);
		
		mv.setViewName("Home");
		
		return mv;
	}
	
	/**
	 * WebSocket 메시지 DB 저장 및 삭제 API
	 * @param chatMsgRq
	 * @return DB 저장, 삭제 여부(1|0)
	 */
	@PostMapping("/home/savemsg")
	@ResponseBody
	public int saveMsg(int memberIdx, String content) {
		if(service.getChatMsgCnt() >= 30) {
			service.removeChatMsg();
		}
		return service.saveChatMsg(memberIdx, content);
	}
	
	@GetMapping("/nonhome")
	public ModelAndView nonhome() {
		List<VehicleDTO> vehicleList = service.getVehicleList();

		ModelAndView mv = new ModelAndView();
		
		mv.addObject("vehicleList", vehicleList);
		mv.setViewName("/Nonmember/NonmemberHome");
		
		return mv;
	}
	
}
