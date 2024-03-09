package service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import dao.ReadPostAllDAO;
import dto.PostDTO;
import dto.ReadPostAllDTO;

@Service("readpostallservice")
public class ReadPostAllService {
	
	@Autowired
	@Qualifier("readpostalldao")
	ReadPostAllDAO dao;
	
	/* 
	 * 
	 */
	public List<Integer> getReadPostAllIdx(String category) {
		
		//카테고리에 해당하는 postidx들
		List<Integer> postIdxs = dao.selectPostIdx(category);
		
		return postIdxs;
	}
	
	/*
	 * 게시글 하나에 대해 필요한 정보 조회
	 * @param postIdx
	 * @return 게시글 정보
	 */
	public ReadPostAllDTO getReadPostAll(int postIdx) {
		
		PostDTO postInfo = dao.selectPostInfo(postIdx);
		
		String postImage = dao.selectPostImage(postIdx);
		
		int likeCnt = dao.selectLikeCnt(postIdx);
		
		String memberName = dao.selectMemberName(postInfo.getMemberIdx());
		
		int flagIdx = dao.selectFlagIdx(postInfo.getMemberIdx());
		String country = dao.selectFlagCountry(flagIdx);
		String flag = dao.selectFlag(flagIdx);
		
		List<String> postTags = dao.selectPostTags(postIdx);
		
		return new ReadPostAllDTO(postInfo, postImage, memberName, likeCnt, country, flag, postTags);
	}
}
