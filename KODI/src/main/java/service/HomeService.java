package service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import dao.HomeDAO;
import dto.AllChatDTO;
import dto.ChatMsgDTO;
import dto.HomeAllChatDTO;
import dto.HomeChatMsgDTO;
import dto.VehicleDTO;

@Service("homeservice")
public class HomeService {
	@Autowired
	@Qualifier("homedao")
	HomeDAO dao;

	/**
	 * 교통수단 비용 리스트 조회
	 * @return 교통수단 비용 리스트
	 */
	public List<VehicleDTO> getVehicleList() {
		return dao.selectVehicleList();
	}

	/**
	 * 메시지 개수 조회
	 * @return 저장된 메시지 개수
	 */
	public int getChatMsgCnt() {
		return dao.searchChatMsgCnt();
	}

	/**
	 * 가장 오래된 메시지 삭제
	 */
	public void removeChatMsg() {
		dao.deleteChatMsg();
	}

	/**
	 * 메시지 저장
	 * @param memberIdx
	 * @param content
	 * @return 저장 성공 여부(1|0)
	 */
	public int saveChatMsg(int memberIdx, String content) {
		HashMap<String, Object> map = new HashMap<>();
		
		map.put("memberIdx", memberIdx);
		map.put("content", content);
		
		return dao.insertChatMsg(map);	
	}

	/**
	 * 모든 메시지 조회
	 * @return 모든 메시지 리스트
	 */
	public List<HomeAllChatDTO> selectAllChatMsg() {
		List<HomeChatMsgDTO> chatMsgDTO = dao.selectAllChatMsg();
		
		List<HomeAllChatDTO> allChatDTO = new ArrayList<>();
		
		for (HomeChatMsgDTO dto : chatMsgDTO) {
			String memberName = dao.selectMemberName(dto.getMemberIdx());
			
			allChatDTO.add(new HomeAllChatDTO(dto, memberName));
		}

		return allChatDTO;
	}
	
}
