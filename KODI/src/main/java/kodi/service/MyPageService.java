package kodi.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kodi.dao.MyPageDAO;
import kodi.dto.FlagDTO;
import kodi.dto.MemberDTO;
import kodi.dto.PostDTO;
import kodi.dto.PostImageDTO;

@Service("mypageservice")
public class MyPageService {
  @Autowired
  private MyPageDAO myPageDAO;
  //나의 게시물
  public List<PostDTO> readMyPosts(int memberIdx){
    List<PostDTO> myPosts = myPageDAO.readMyPosts(memberIdx);
    return myPosts;
  }
 
  //친구정보 조회
  public List<MemberDTO> friendInfo (List<Integer> friendList){
    List<MemberDTO> friendInfo = myPageDAO.friendInfo(friendList);
    return friendInfo;
  }
  //전체 국가 조회
  public List<FlagDTO> allFlags() {
    return myPageDAO.allFlags();
  }
  //전체 이미지 조회
  public List<PostImageDTO> allImages() {
    return myPageDAO.allImages();
  }

}
