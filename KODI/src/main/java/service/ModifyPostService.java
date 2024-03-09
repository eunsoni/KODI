package service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import dao.ModifyPostDAO;
import dto.WritePostDTO;

@Service("modifypostservice")
public class ModifyPostService {
	
	@Autowired
	@Qualifier("modifypostdao")
	ModifyPostDAO dao;
	
	//게시글 수정
	//@return 게시글 수정 성공 여부(1|0)
	public String updatePost(WritePostDTO writePostDTO, List<String> postImages, int myMemberIdx) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		int postIdx = writePostDTO.getPostIdx();
		String title = writePostDTO.getTitle();
		String content = writePostDTO.getContent();
		String address = writePostDTO.getAddress();
		String category = writePostDTO.getCategory();
		double grade = writePostDTO.getGrade();
		List<String> postTags = writePostDTO.getPostTags();
		
		//수정 실패 요건 확인
		if(title.isBlank()) {
			return "제목이 비어있어 수정에 실패하였습니다.";
		}
		else if(content.isBlank()) {
			return "내용이 비어있어 수정에 실패하였습니다.";
		}
		else if(address.isBlank()) {
			return "주소가 비어있어 수정에 실패하였습니다.";
		}
		
		map.put("postIdx", postIdx); 
		map.put("category", category);
		map.put("grade", grade);
		map.put("title", title);
		map.put("content", content);
		map.put("address", address);
		//카테고리, 평점, 제목, 내용, 주소 업데이트
		dao.updatePost(map);
		
		//기존에 저장되어있는 태그의 tag_idx값들 저장
		List<Integer> tagIdxs = dao.selectTag(postIdx);
		//기존에 저장되어있던 해당 게시글의 태그 수
		int tagsNum = dao.selectTagNum(postIdx);
		//태그 수정
		updateTag(map, postIdx, postTags, tagIdxs, tagsNum);
		
		//파일이 있는 경우(파일 선택에 파일이 들어가 있는 경우)
		if(postImages.size() != 0) {
			//게시글 이미지 저장
			for(int i=0; i<postImages.size(); i++) {
				map.clear();
				map.put("postIdx", postIdx);
				map.put("postImages", postImages.get(i));
				dao.insertImages(map);
			}
		}
		
		return "수정을 완료하였습니다.";
	}
	
	private void updateTag(HashMap<String, Object> map, int postIdx, List<String> tags, 
			List<Integer> tagIdxs, int tagsNum) {
		//insert용 update용 delete용 tag 리스트들 구분
		String insertTags;
		String updateTags;
		Integer deleteTags;
		
		//tags.size null인 경우 0으로 변환
		int tagsSize = 0;
		if(tags != null) {
			tagsSize = tags.size();
		}
		
		//새로 저장할 태그 수(tags.size)와 기존에 저장되어있는 태그 수(tagsNum)를 비교
		if(tagsSize > tagsNum) { //새로 저장할 태그가 더 많은 경우
			//기존의 태그에는 update
			for(int i=0; i<tagsNum; i++) {
				updateTags = tags.get(i);
				map.clear();
				map.put("tagIdxs", tagIdxs.get(i));
				map.put("updateTags", updateTags);
				dao.updateTag(map);
			}
			//추가된 태그에는 insert
			for(int i=tagsNum; i<tagsSize; i++) {
				insertTags = tags.get(i);
				map.clear();
				map.put("postIdx", postIdx);
				map.put("insertTags", insertTags);
				dao.insertTag(map);
			} 
		}
		else if(tagsSize == tagsNum && tagsSize != 0){ //새로 저장할 태그와 기존의 태그의 수가 같은 경우
			//기존의 태그와 수가 같으므로 update
			for(int i=0; i<tagsNum; i++) {
				updateTags = tags.get(i);
				map.clear();
				map.put("tagIdxs", tagIdxs.get(i));
				map.put("updateTags", updateTags);
				System.out.println(tagIdxs.get(i));
				System.out.println(updateTags);
				dao.updateTag(map);
			}
		}
		else {
			//기존의 태그에는 update
			for(int i=0; i<tagsSize; i++) {
				updateTags = tags.get(i);
				map.clear();
				map.put("tagIdxs", tagIdxs.get(i));
				map.put("updateTags", updateTags);
				dao.updateTag(map);
			}
			//남은 태그에는 delete
			for(int i=tagsSize; i<tagsNum; i++) {
				deleteTags = tagIdxs.get(i); 
				map.clear();
				map.put("deleteTags", deleteTags);
				dao.deleteTag(map);
			}
		}
	}
	
	public void deleteImageSrc(int postIdx, String imageSrc) {
		HashMap<String, Object> map = new HashMap<>();
		
		map.put("postIdx", postIdx);
		map.put("imageSrc", imageSrc);
		dao.deleteImageSrc(map);
	}
	
}
