package dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import dto.PostDTO;

@Repository("admindao")
@Mapper
public interface AdminDAO {
  
  //전체 게시물 가져오기
	List<PostDTO> findAllPosts();

	//게시물 아이디로 검색하기
	PostDTO findPostByIdx(int postIdx);
  
	//게시물 삭제하기
	int deletePost(int postIdx);
}
