package service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import dao.MapDAO;
import dao.WritePostDAO;
import dto.WritePostDTO;

@Service("mapservice")
public class MapService {
	
	@Autowired
	@Qualifier("mapdao")
	MapDAO dao;
	
	public List<Integer> selectMyPostIdx(int myMemberIdx) {
		List<Integer> postIdxs = dao.selectMyPostIdx(myMemberIdx);
		
		return postIdxs;
	}
	
	public String selectPostAddress(int postIdx) {
		String postAddress = dao.selectPostAddress(postIdx);
		
		return postAddress;
	}
	
	public List<Integer> selectMyFriendIdx(int myMemberIdx) {
		//member_idx가 나의 idx이면서 isFriend가 1인 friend_member_idx들
		List<Integer> friendIdxs = dao.selectFriendMemberIdx(myMemberIdx);
		List<Integer> realFriend = new ArrayList<Integer>();
		
		for(Integer idx : friendIdxs) {
			//member_idx가 친구의 idx이면서 friend_member_idx가 나의 idx인 것들의 is_friend의 값
			boolean isFriend = dao.selectIsFriend(idx, myMemberIdx);
			//isFriend가 true(1)인 경우
			if(isFriend == true) {
				//서로 친구인 친구의 member_idx값을 저장
				realFriend.add(idx);
			}
		}
		return realFriend;
	}
	
	public List<Integer> selectFriendPostIdx(int memberIdx) {
		List<Integer> postIdxs = dao.selectFriendPostIdx(memberIdx);
		
		return postIdxs;
	}
	
	public void deleteMarking(int memberIdx, int postIdx) {
		dao.deleteMarkingInfo(memberIdx, postIdx);
	}
	
	
	
}
