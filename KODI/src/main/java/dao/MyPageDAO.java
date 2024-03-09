package dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import dto.FlagDTO;
import dto.MemberDTO;
import dto.PostDTO;
import dto.PostImageDTO;

@Repository("mypagedao")
@Mapper
public interface MyPageDAO {
	
	//나의 전체글 가져오기 SQL문
	List<PostDTO> readMyPosts(int memberIdx);
	//친구 정보 조회
	List<MemberDTO> friendInfo(List<Integer> friendList);
	//전체국가조회
  List<FlagDTO> allFlags();
	//전체 이미지 조회
	List<PostImageDTO> allImages();
}
