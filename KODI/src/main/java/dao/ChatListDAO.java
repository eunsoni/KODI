package dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import dto.ChatListFriendDTO;

@Repository("chatlistdao")
@Mapper
public interface ChatListDAO {
	
	/**
	 * 전체 친구 고유 값정보 조회
	 * @param memberIdx
	 * @return 전체 친구 고유값 리스트
	 */
	List<Integer> selectFriendMemberIdx(int memberIdx);

	/**
	 * 친구 이름 조회
	 * @param friendIdx
	 * @return 친구 이름
	 */
	String selectFriendMemberName(int friendIdx);

	/**
	 * 내가 친구를 추가했는지 여부
	 * @param map
	 * @return 나의 친구신청 여부(1|0)
	 */
	int selectIsFriendByMe(HashMap<String, Object> map);

	/**
	 * 친구가 나를 추가했는지 여부
	 * @param map
	 * @return 친구의 친구신청 여부(1|0)
	 */
	int selectIsFriendByOther(HashMap<String, Object> map);

	/**
	 * 채팅방 리스트 조회
	 * @param memberIdx
	 * @return 채팅방 고유값 리스트
	 */
	List<Integer> selectChatList(int memberIdx);

	/**
	 * 채팅방 친구1 고유값 조회
	 * @param memberIdx
	 * @return 채팅방 친구1 고유값
	 */
	int selectChatMemberOneIdx(int chatIdx);
	
	/**
	 * 채팅방 친구2 고유값 조회
	 * @param memberIdx
	 * @return 채팅방 친구2 고유값
	 */
	int selectChatMemberTwoIdx(int chatIdx);

	/**
	 * 채팅방의 가장 최근 메시지 조회
	 * @param chatIdx
	 * @return 최근 메시지 내용
	 */
	String selectContent(Integer chatIdx);

	/**
	 * 채팅방 여부 조회
	 * @param memberIdx
	 * @param friendMemberIdx
	 * @return 채팅방 여부 (1|0)
	 */
	int selectChatRoom1(HashMap<String, Integer> map);
	
	/**
	 * 채팅방 여부 조회
	 * @param memberIdx
	 * @param friendMemberIdx
	 * @return 채팅방 여부 (1|0)
	 */
	int selectChatRoom2(HashMap<String, Integer> map);

	/**
	 * 채팅방 개수 조회
	 * @param map
	 * @return 채팅방 번호
	 */
	int selectChatIdxCnt(HashMap<String, Integer> map);
	
	/**
	 * 채팅방 번호 조회
	 * @param map
	 * @return 채팅방 번호
	 */
	int selectChatIdx1(HashMap<String, Integer> map);
	
	/**
	 * 채팅방 번호 조회
	 * @param map
	 * @return 채팅방 번호
	 */
	int selectChatIdx2(HashMap<String, Integer> map);

	/**
	 * 새로운 채팅방 생성
	 * @param map
	 */
	void insertChat(HashMap<String, Integer> map);
	
	/**
	 * 친구 검색
	 * @param map
	 * @return 친구 정보
	 */
	List<ChatListFriendDTO> selectFriendInfo(HashMap<String, Object> map);

	/**
	 * 채팅방 삭제
	 * @param chatIdx
	 * @return 삭제 여부(1|0)
	 */
	int deleteChat(int chatIdx);

	/**
	 * 검색한 친구 리스트 검색
	 * @param friendMemberIdx
	 * @return 검색한 친구 리스트
	 */
	int searchFriendByFriendIdx(HashMap<String, Object> map);

}