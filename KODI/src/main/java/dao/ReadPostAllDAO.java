package dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import dto.PostDTO;

@Repository("readpostalldao")
@Mapper
public interface ReadPostAllDAO {
	
	/*
	 * 카테고리에 해당하는 게시글 idx 전부 조회
	 */
	public List<Integer> selectPostIdx(String category);
	
	/*
	 * 게시글 하나의 데이터 전부 조회
	 * @param category
	 * @return 게시글 하나의 데이터
	 */
	public PostDTO selectPostInfo(int postIdx);
	
	/*
	 * 게시글 이미지 조회(가장 첫번째 사진)
	 *  @param postIdx
	 *  @return 게시글 이미지 src
	 */
	public String selectPostImage(int postIdx);
	
	/*
	 * 게시글 좋아요 수 조회
	 * @param postIdx
	 * @return 게시글 좋아요 수 count
	 */
	public int selectLikeCnt(int postIdx);
	
	/*
	 * 게시글 작성자 이름 조회
	 * @param memberIdx
	 * @return 게시글 작성자 이름 member_name
	 */
	public String selectMemberName(int memberIdx);
	
	/* --------------------------------------------------
	 * 게시글 국기 idx 조회
	 * @param memberIdx
	 * @return 국기 idx
	 */
	public int selectFlagIdx(int memberIdx);
	/*
	 * 게시글 국기 나라 이름 조회
	 * @param flagIdx
	 * @return 국기 country
	 */
	public String selectFlagCountry(int flagIdx);
	/*
	 * 게시글 국기 이미지 조회
	 * @param flagIdx
	 * @return 국기 src
	 */
	public String selectFlag(int flagIdx);
	// --------------------------------------------------
	
	/*
	 * 게시글 태그 리스트 조회
	 * @param postIdx
	 * @return 게시글 태그 content
	 */
	public List<String> selectPostTags(int postIdx);
}
