package controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import dto.CommentDTO;
import dto.CommentMemberDTO;
import dto.CommentRq;
import dto.DeletePostRq;
import dto.MarkingInfoDTO;
import dto.PostLikeDTO;
import dto.ReadPostOneDTO;
import jakarta.servlet.http.HttpSession;
import service.ReadPostOneService;

@Controller
@RequestMapping("/api")
public class ReadPostOneController {
	@Autowired
	@Qualifier("readpostoneservice")
	ReadPostOneService service;
	
	/**
	 * 게시글 데이터 조회 API
	 * @param postIdx
	 * @return 게시글 데이터
	 */
	@GetMapping("/post/{postIdx}")
	public ModelAndView readPostOne(HttpSession session, @PathVariable int postIdx) {
		ReadPostOneDTO readPostOne = service.getReadPostOne(postIdx);
		
		List<CommentMemberDTO> commentMemberInfo = new ArrayList<>();
		
		for (CommentDTO dto : readPostOne.getComments()) {
			commentMemberInfo.add(service.selectCommentMemberName(dto.getMemberIdx()));
		}

		ModelAndView mv = new ModelAndView();
		
		if(session.getAttribute("memberIdx") == null) {
        	mv.addObject("isSession", false);
		} else {
        	mv.addObject("isSession", true);
		}
		
		mv.addObject("readPostOne", readPostOne);
		mv.addObject("commentMemberInfo", commentMemberInfo);
				
		mv.setViewName("ReadPostOne");
		
		return mv;
	}
	
	/**
	 * 게시글 좋아요 클릭 여부 조회 API
	 * @param like
	 * @return 클릭 여부(1|0)
	 */
	@PostMapping("/post/like/isclick")
	@ResponseBody
	public int isClickLike(@RequestBody PostLikeDTO like) {
		return service.isClickLike(like.getPostIdx(), like.getMemberIdx());
	}

	/**
	 * 게시글 좋아요 클릭 API
	 * @param like
	 * @return 좋아요 수
	 */
	@PostMapping("/post/like")
	@ResponseBody
	public int clickLike(@RequestBody PostLikeDTO like) {
		int isClick = service.isClickLike(like.getPostIdx(), like.getMemberIdx());
		
		if(isClick > 0) {
			service.deleteLike(like.getPostIdx(), like.getMemberIdx());
		} else {
			service.insertLike(like.getPostIdx(), like.getMemberIdx());
		}
				
		return service.selectLikeCnt(like.getPostIdx());
	}
	
	/**
	 * 과거 마킹 여부 확인 API
	 * @param marking
	 * @return 마킹 여부(1|0)
	 */
	@PostMapping("/post/ismarking")
	@ResponseBody
	public int isClickMarking(@RequestBody MarkingInfoDTO marking) {		
		return service.isClickMarking(marking.getPostIdx(), marking.getMemberIdx());
	}
	
	/**
	 * 기존 마킹 삭제 API
	 * @param marking
	 * @return
	 */
	@PostMapping("/post/deletemarking")
	@ResponseBody
	public int deleteMarking(@RequestBody MarkingInfoDTO marking) {		
		return service.deleteMarking(marking.getPostIdx(), marking.getMemberIdx());
	}
	
	/**
	 * 마킹 등록 API
	 * @param marking
	 */
	@PostMapping("/post/insertmarking")
	@ResponseBody
	public int insertMarking(@RequestBody MarkingInfoDTO marking) {		
		return service.insertMarking(marking.getPostIdx(), marking.getMemberIdx());
	}
	
	/**
	 * 댓글 저장 API
	 * @param comment
	 * @return 댓글 저장 성공 여부(1|0)
	 */
	@PostMapping("/post/comment")
	@ResponseBody
	public int insertComment(@RequestBody CommentRq comment) {
		return service.insertComment(comment.getContent(), comment.getPostIdx(), comment.getMemberIdx());
	}
	
	/**
	 * 댓글 삭제 API
	 * @param commentId
	 * @return 댓글 삭제 성공 여부(1|0)
	 */
	@PostMapping("/post/comment/delete")
	@ResponseBody
	public int deleteComment(int commentIdx) {
		return service.deleteComment(commentIdx);
	}
	
	/**
	 * 게시글 삭제 API
	 * @param postIdx
	 * @return 게시글 삭제 성공 여부 (1|0)
	 */
	@PostMapping("/post/delete")
	@ResponseBody
	public int deletePost(@RequestBody DeletePostRq req) {
		return service.deletePost(req.getPostIdx());
	}
}
