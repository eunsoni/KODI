package dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import dto.HomeChatMsgDTO;
import dto.VehicleDTO;

@Repository("homedao")
@Mapper
public interface HomeDAO {
	
	/**
	 * 교통수단 비용 리스트 조회
	 * @return 교통수단 비용 리스트
	 */
	List<VehicleDTO> selectVehicleList();

	/**
	 * 메시지 개수 조회
	 * @return 저장된 메시지 개수
	 */
	int searchChatMsgCnt();

	/**
	 * 가장 오래된 메시지 삭제
	 * @return 삭제 성공 여부(1|0)
	 */
	int deleteChatMsg();

	/**
	 * 메시지 저장
	 * @param memberIdx
	 * @param content
	 * @return 저장 성공 여부(1|0)
	 */
	int insertChatMsg(HashMap<String, Object> map);

	/**
	 * 모든 메시지 조회
	 * @return 모든 메시지 리스트
	 */
	List<HomeChatMsgDTO> selectAllChatMsg();

	/**
	 * 메시지 작성자명 조회
	 * @param memberIdx
	 * @return 메시지 작성자명
	 */
	String selectMemberName(int memberIdx);

}
