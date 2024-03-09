package dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import dto.CommentDTO;
import dto.PostDTO;

@Repository("readpostonedao")
@Mapper
public interface ReadPostOneDAO {

	/**
	 * 게시글 상세 정보 조회
	 * @param postIdx
	 * @return 게시글 상세 정보
	 */
	public PostDTO selectPostInfo(int postIdx);

	/**
	 * 게시글 작성자 이름 조회
	 * @param memberIdx
	 * @return 게시글 작성자 이름
	 */
	public String selectMemberName(int memberIdx);

	/**
	 * 게시글 이미지 리스트 조회
	 * @param postIdx
	 * @return 게시글 이미지 리스트
	 */
	public List<String> selectPostImages(int postIdx);

	/**
	 * 게시글 좋아요 수 조회
	 * @param postIdx
	 * @return 게시글 좋아요 수
	 */
	public int selectLikeCnt(int postIdx);

	/**
	 * 게시글 태그 리스트 조회
	 * @param postIdx
	 * @return 게시글 태그 리스트
	 */
	public List<String> selectPostTags(int postIdx);

	/**
	 * 댓글 리스트 조회
	 * @param postIdx
	 * @return 댓글 리스트
	 */
	public List<CommentDTO> selectComment(int postIdx);

	/**
	 * 게시글 작성자 국기 고유값 조회
	 * @param memberIdx
	 * @return 국기 고유값
	 */
	public int selectFlagIdx(int memberIdx);

	/**
	 * 게시글 작성자 국기 조회
	 * @param flagIdx
	 * @return 국기
	 */
	public String selectFlag(int flagIdx);

	/**
	 * 게시글에 대한 현재 사용자의 좋아요 수 조회
	 * @param map
	 * @return 게시글에 대한 현재 사용자의 좋아요 수(클릭했으면 1, 아니면 0)
	 */
	public int isClickLike(HashMap<String, Integer> map);

	/**
	 * 좋아요 삭제
	 * @param map
	 */
	public void deleteLike(HashMap<String, Integer> map);

	/**
	 * 좋아요 저장
	 * @param map
	 */
	public void insertLike(HashMap<String, Integer> map);

	/**
	 * 과거 마킹 여부 확인
	 * @param map
	 * @return 마킹 여부(1|0)
	 */
	public int isClickMarking(HashMap<String, Integer> map);

	/**
	 * 기존 마킹 삭제
	 * @param map
	 * @return 
	 */
	public int deleteMarking(HashMap<String, Integer> map);

	/**
	 * 마킹 등록
	 * @param map
	 */
	public int insertMarking(HashMap<String, Integer> map);

	/**
	 * 댓글 저장
	 * @param map
	 * @return 댓글 저장 성공 여부(1|0)
	 */
	public int insertComment(HashMap<String, Object> map);

	/**
	 * 댓글 삭제
	 * @param commentIdx
	 * @return 댓글 삭제 성공 여부(1|0)
	 */
	public int deleteComment(int commentIdx);

	/**
	 * 게시글 삭제
	 * @param postIdx
	 * @return 게시글 삭제 성공 여부(1|0)
	 */
	public int deletePost(int postIdx);
	
}
