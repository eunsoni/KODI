package service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import dao.SearchMemberListDAO;
import dto.ReadMemberAllDTO;

@Service("searchmemberlistservice")
public class SearchMemberListService {
	
	@Autowired
	@Qualifier("searchmemberlistdao")
	SearchMemberListDAO dao;
	
	//검색어에 해당하는 memberIdx들 조회
	public List<Integer> getReadMemberAllIdx(String question) {
		//검색어를 포함하는 member_name들에 대한 memberIdx들
		List<Integer> memberIdxs = dao.selectMemberIdx(question);
		
		return memberIdxs;
	}
	
	//멤버 하나에 대한 필요 정보 조회
	public ReadMemberAllDTO getReadMemberAll(int memberIdx, int myMemberIdx) {
		//멤버 이름 조회
		String memberName = dao.selectMemberName(memberIdx);
		
		//해당 멤버의 flag_idx 조회
		int flagIdx = dao.selectFlagIdx(memberIdx);
		//조회한 flag_idx의 국가이름(country) 조회
		String country = dao.selectMemberCountry(flagIdx);
		String flag = dao.selectFlag(flagIdx);
		
		//내가 친구요청을 보낸 사람인지 확인하기 위한 나의 friendMemberIdx 리스트 조회
		List<Integer> friendMemberIdx = dao.selectFriendMemberIdx(myMemberIdx);
		
		//친구 상태 확인 메세지
		String friendState = "";
		//만약 나의 friendMemberIdx 리스트에 조회 요청한 해당 memberIdx가 있다면
		if(friendMemberIdx.contains(memberIdx)) {
			//member_idx가 myMemberIdx이고, friend_member_idx가 memberIdx인 칼럼의 friend_idx값 조회 
			int friendIdx = dao.selectFriendIdx(myMemberIdx, memberIdx);
			
			//조회한 friendIdx의 isFriend가 true인지 false인지 조회
			boolean isFriend = dao.selectIsFriend(friendIdx);
			if(isFriend == true) {
				//member_idx가 memberIdx이고, friend_member_idx가 myMemberIdx인 칼럼의 friend_idx값 조회
				friendIdx = dao.selectFriendIdx(memberIdx, myMemberIdx);
				
				isFriend = dao.selectIsFriend(friendIdx);
				//둘다 is_friend가 true인 경우
				if(isFriend == true) {
					friendState = "서로 친구"; 
				}
				//나만 is_friend가 true인 경우
				else {
					friendState = "내가 추가한 친구";
				}
			}
			//나는 is_friend가 false인 경우
			else{
				friendState = "나를 추가한 친구";
			}
		}
		else {
			friendState = "친구 신청 가능";
		}
		
		return new ReadMemberAllDTO(memberIdx, memberName, country, friendState, flag);
	}
	
	public String deleteFriend(int memberIdx, int friendMemberIdx, String clickstate) {
		//친구 신청을 한 상태인지 확인하기
		List<Integer> friendIdxs = new ArrayList<>();
		friendIdxs.add(dao.selectFriendIdx(memberIdx, friendMemberIdx));
		friendIdxs.add(dao.selectFriendIdx(friendMemberIdx, memberIdx));
		
		if(friendIdxs.get(0) == null && friendIdxs.get(1) == null) {
			if(clickstate.equals("친구 삭제")) {
				return "이미 친구 삭제가 완료된 대상입니다.";
			}
			if(clickstate.equals("요청 취소")) {
				return "이미 친구 요청 취소한 대상입니다.";
			}
			else {
				return "이미 요청을 거절한 대상입니다.";
			}
		}
		
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		//나의 member_idx = member_idx / 상대의 member_idx = friend_member_idx
		map.put("friendMemberIdx", friendMemberIdx);
		map.put("memberIdx", memberIdx);
		dao.deleteFriend(map);
		
		//나의 member_idx = friend_member_idx / 상대의 member_idx = member_idx
		map.clear();
		map.put("friendMemberIdx", memberIdx);
		map.put("memberIdx", friendMemberIdx);
		dao.deleteFriend(map);
		
		if(clickstate.equals("친구 삭제")) {
			return "친구 삭제를 완료하였습니다.";
		}
		if(clickstate.equals("요청 취소")) {
			return "친구 요청을 취소하였습니다.";
		}
		else {
			return "친구 요청을 거절하였습니다.";
		}
	}

	public void delete_Friend(int memberIdx, int friendMemberIdx) {
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		//나의 member_idx = member_idx / 상대의 member_idx = friend_member_idx
		map.put("friendMemberIdx", friendMemberIdx);
		map.put("memberIdx", memberIdx);
		dao.deleteFriend(map);
		
		//나의 member_idx = friend_member_idx / 상대의 member_idx = member_idx
		map.clear();
		map.put("friendMemberIdx", memberIdx);
		map.put("memberIdx", friendMemberIdx);
		dao.deleteFriend(map);
	}
	
	//친구가 아닌 사용자에게 친구 요청하기
	public String insertFriendRequest(int memberIdx, int friendMemberIdx) {
		//친구 신청을 한 상태인지 확인하기
		List<Integer> friendIdxs = new ArrayList<>();
		friendIdxs.add(dao.selectFriendIdx(memberIdx, friendMemberIdx));
		friendIdxs.add(dao.selectFriendIdx(friendMemberIdx, memberIdx));
		
		if(friendIdxs.get(0) != null && friendIdxs.get(1) != null) {
			return "이미 친구신청을 한 상태입니다.";
		}
		HashMap<String, Object> map = new HashMap<String, Object>();
		//나의 member_idx = member_idx / 상대의 member_idx = friend_member_idx
		boolean isFriend = true;
		map.put("friendMemberIdx", friendMemberIdx);
		map.put("isFriend", isFriend);
		map.put("memberIdx", memberIdx);
		dao.insertFriendRequest(map);
		//나의 member_idx = friend_member_idx / 상대의 member_idx = member_idx
		isFriend = false;
		map.clear();
		map.put("friendMemberIdx", memberIdx);
		map.put("isFriend", isFriend);
		map.put("memberIdx", friendMemberIdx);
		dao.insertFriendRequest(map);
		
		return "친구신청을 완료하였습니다.";
	}
	
	//내가 받은 친구 요청 수락하기
	public String updateFriendRequest(int memberIdx, int friendMemberIdx) {
		//변경된 사항이 없는지 검증을 위한 friend_idx 추출
		Integer friendIdx = dao.selectFriendIdx(memberIdx, friendMemberIdx);
		boolean isFriend = false;
		if(friendIdx == null) {
			return "이미 친구 요청을 거절하셨습니다.";
		}
		else {
			isFriend = dao.selectIsFriend(friendIdx);
		}
		
		//요청받은 is_friend의 값이 true인 경우
		if(isFriend) {
			return "이미 친구 요청을 수락하셨습니다.";
		}
		
		dao.updateFriendRequest(memberIdx, friendMemberIdx);
		return "친구 요청을 수락하셨습니다.";
	}
	
	//관리자 계정 탐색
	public List<Integer> getReadAdminAllIdx(String admin) {
		return dao.selectAdminAllIdx(admin);
	}
	
}
