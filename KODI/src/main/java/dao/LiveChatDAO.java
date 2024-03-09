package dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import dto.ChatMsgDTO;

@Repository("livechatdao")
@Mapper
public interface LiveChatDAO {

	/**
	 * 과거 채팅방 메시지 조회
	 * @param chatIdx
	 * @return 과거 채팅방 메시지 리스트
	 */
	List<ChatMsgDTO> selectAllChatMsg(int chatIdx);
	
	/**
	 * 채팅방 권한 조회
	 * @param memberIdx
	 * @param chatIdx
	 * @return 채팅방 권한 여부(1|0)
	 */
	int verifyMember(HashMap<String, Integer> map);
	
	/**
	 * 채팅 작성자 조회
	 * @param memberIdx
	 * @return 채팅 작성자명
	 */
	String selectMemberName(int memberIdx);

	/**
	 * WebSocket 메시지 DB 저장
	 * @param map
	 * @return DB 저장 성공 여부(1|0)
	 */
	int insertChatMsg(HashMap<String, Object> map);

	/**
	 * 국적 조회
	 * @param memberIdx
	 */
	String selectCountry(int memberIdx);

}
