package service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import dao.ReadPostOneDAO;
import dto.CommentDTO;
import dto.CommentMemberDTO;
import dto.PostDTO;
import dto.ReadPostOneDTO;

@Service("readpostoneservice")
public class ReadPostOneService {
	@Autowired
	@Qualifier("readpostonedao")
	ReadPostOneDAO dao;
	
	/**
	 * 게시글 상세 정보 조회
	 * 
	 * @param postIdx
	 * @return 게시글 상세 정보
	 */
	public ReadPostOneDTO getReadPostOne(int postIdx) {
		PostDTO postInfo = dao.selectPostInfo(postIdx);

		int flagIdx = dao.selectFlagIdx(postInfo.getMemberIdx());
		String flag = dao.selectFlag(flagIdx);

		String memberName = dao.selectMemberName(postInfo.getMemberIdx());
		List<String> postImages = dao.selectPostImages(postIdx);

		int likeCnt = dao.selectLikeCnt(postIdx);
		List<String> postTags = dao.selectPostTags(postIdx);
		List<CommentDTO> comments = dao.selectComment(postIdx);

		return new ReadPostOneDTO(postInfo, flag, memberName, postImages, likeCnt, postTags, comments);
	}
	
	/**
	 * 댓글 작성자 조회
	 * @param memberIdx
	 * @return 댓글 작성자 DTO
	 */
	public CommentMemberDTO selectCommentMemberName(int memberIdx) {
		return new CommentMemberDTO(memberIdx, dao.selectMemberName(memberIdx));
	}

	/**
	 * 게시글에 대한 현재 사용자의 좋아요 수 조회
	 * 
	 * @param postIdx
	 * @param memberIdx
	 * @return 게시글에 대한 현재 사용자의 좋아요 수
	 */
	public int isClickLike(int postIdx, int memberIdx) {
		HashMap<String, Integer> map = new HashMap<String, Integer>();

		map.put("postIdx", postIdx);
		map.put("memberIdx", memberIdx);

		return dao.isClickLike(map);
	}

	/**
	 * 좋아요 삭제
	 * 
	 * @param postIdx
	 * @param memberIdx
	 */
	public void deleteLike(int postIdx, int memberIdx) {
		HashMap<String, Integer> map = new HashMap<String, Integer>();

		map.put("postIdx", postIdx);
		map.put("memberIdx", memberIdx);

		dao.deleteLike(map);
	}

	/**
	 * 좋아요 저장
	 * 
	 * @param postIdx
	 * @param memberIdx
	 */
	public void insertLike(int postIdx, int memberIdx) {
		HashMap<String, Integer> map = new HashMap<String, Integer>();

		map.put("postIdx", postIdx);
		map.put("memberIdx", memberIdx);

		dao.insertLike(map);
	}

	/**
	 * 좋아요 수 조회
	 * 
	 * @param postIdx
	 * @return 좋아요 수
	 */
	public int selectLikeCnt(int postIdx) {
		return dao.selectLikeCnt(postIdx);
	}

	/**
	 * 과거 마킹 여부 조회
	 * 
	 * @param postIdx
	 * @param memberIdx
	 * @return 마킹 여부(1|0)
	 */
	public int isClickMarking(int postIdx, int memberIdx) {
		HashMap<String, Integer> map = new HashMap<String, Integer>();

		map.put("postIdx", postIdx);
		map.put("memberIdx", memberIdx);

		return dao.isClickMarking(map);
	}

	/**
	 * 기존 마킹 삭제
	 * 
	 * @param postIdx
	 * @param memberIdx
	 * @return
	 */
	public int deleteMarking(int postIdx, int memberIdx) {
		HashMap<String, Integer> map = new HashMap<String, Integer>();

		map.put("postIdx", postIdx);
		map.put("memberIdx", memberIdx);

		return dao.deleteMarking(map);
	}

	/**
	 * 마킹 등록
	 * 
	 * @param postIdx
	 * @param memberIdx
	 */
	public int insertMarking(int postIdx, int memberIdx) {
		HashMap<String, Integer> map = new HashMap<String, Integer>();

		map.put("postIdx", postIdx);
		map.put("memberIdx", memberIdx);

		return dao.insertMarking(map);
	}

	/**
	 * 댓글 저장
	 * 
	 * @param content
	 * @param postIdx
	 * @param memberIdx
	 * @return 댓글 저장 성공 여부(1|0)
	 */
	public int insertComment(String content, int postIdx, int memberIdx) {
		HashMap<String, Object> map = new HashMap<String, Object>();

		map.put("content", content);
		map.put("postIdx", postIdx);
		map.put("memberIdx", memberIdx);

		return dao.insertComment(map);
	}

	/**
	 * 댓글 삭제
	 * 
	 * @param commentIdx
	 * @return 댓글 삭제 성공 여부(1|0)
	 */
	public int deleteComment(int commentIdx) {
		return dao.deleteComment(commentIdx);
	}

	/**
	 * 게시글 삭제
	 * 
	 * @param postIdx
	 * @return
	 */
	public int deletePost(int postIdx) {
		return dao.deletePost(postIdx);
	}

}
