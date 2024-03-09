package dao;

import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Repository("writepostdao")
@Mapper
public interface WritePostDAO {
	
	//작성한 게시글 내용 저장
	//@param map
	public void insertPostInfo(HashMap<String, Object> map);
	
	//가장 최근에 작성한 게시글idx 호출
	//@param myMemberIdx
	//@return 최근 게시글 postIdx
	public int selectPostIdx(int myMemberIdx);
	
	//게시글의 태그 저장
	//@param map
	public void insertPostTags(HashMap<String, Object> map);

	//게시글의 이미지 저장
	//@param map
	public void insertPostImages(HashMap<String, Object> map);
}
