package dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Repository("mapdao")
@Mapper
public interface MapDAO {
	
	//내가 저장한 게시글 idx 호출
	//@param myMemberIdx
	//@return 게시글 postIdx의 list
	public List<Integer> selectMyPostIdx(int myMemberIdx);
	
	//
	public String selectPostAddress(int postIdx);
	
	//
	public List<Integer> selectFriendMemberIdx(int myMemberIdx);
	
	//
	public boolean selectIsFriend(int memberIdx, int myMemberIdx);
	
	//
	public List<Integer> selectFriendPostIdx(int memberIdx);
	
	//
	public void deleteMarkingInfo(int memberIdx, int postIdx);
	
}
