package service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import dao.SearchPostListDAO;
import dto.PostDTO;
import dto.ReadPostAllDTO;

@Service("searchpostlistservice")
public class SearchPostListService {
	
	@Autowired
	@Qualifier("searchpostlistdao")
	SearchPostListDAO dao;
	
	//검색어에 해당하는 postIdx들 추출
	public List<Integer> getReadPostAllIdx(String question) {
		//검색어를 포함하는 모든 postIdx 저장용 변수
		List<Integer> postAllIdx = new ArrayList<Integer>();
		
		//제목 검색 통합
		postAllIdx.addAll(getReadPostTitleIdx(question));
		
		//제목에서 추출한 idx와 태그에서 추출한 idx가 겹치는 것들은 제외
		List<Integer> readPostTagIdxs = getReadPostTagIdx(question);
		for(int i=0; i<postAllIdx.size(); i++) {
			if(readPostTagIdxs.contains(postAllIdx.get(i))) {
				//포함되어있는 위치의 인덱스 저장
				int index = readPostTagIdxs.indexOf(postAllIdx.get(i));
				//해당 인덱스 삭제
				readPostTagIdxs.remove(index);
			}
		}
		postAllIdx.addAll(readPostTagIdxs);
		
		return postAllIdx; 
	}
	
	//제목에 해당 검색어가 포함되는 경우
	private List<Integer> getReadPostTitleIdx(String question) {
		//제목이 검색어(question)에 해당하는 postIdxs
		List<Integer> titlePostIdxs = dao.selectTitlePostIdx(question);
		
		return titlePostIdxs;
	}
	
	//태그에 해당 검색어가 포함되는 경우
	private List<Integer> getReadPostTagIdx(String question) {
		//태그가 검색어(question)에 해당하는 postIdx
		List<Integer> tagPostIdxs = dao.selectTagPostIdx(question);
		
		return tagPostIdxs;
	}
	
	//게시글 하나에 대한 정보 조회
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
