package controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import dto.FlagDTO;
import dto.MemberDTO;
import dto.MemberFlagDTO;
import dto.PostDTO;
import dto.PostMemberDTO;
import jakarta.servlet.http.HttpSession;
import service.AdminService;
import service.MemberService;
import service.MyPageService;
import service.SearchMemberListService;
import service.SearchPostListService;

@Controller
@RequestMapping("/api/admin")
public class AdminController {

	/**
	 * GET 전체 유저 조회 (/api/admin/allmembers) DATA: X
	 * GET 전체 게시물 조회 (/api/admin/allposts) DATA: X
	 * POST 유저 삭제 (/api/admin/deletemember) DATA: 삭제할 멤버 아이디
	 * POST 포스트 삭제 (/api/admin/deletepost) DATA: 삭제할 포스트 아이디
	 */

	@Autowired
	private MemberService memberService;

	@Autowired
	private AdminService adminService;

	@Autowired
	private MyPageService myPageService;

	@Autowired
	@Qualifier("searchpostlistservice")
	SearchPostListService postservice;

	@Autowired
	@Qualifier("searchmemberlistservice")
	SearchMemberListService memberservice;

	/**
	 * 전체 유저 조회
	 * 
	 * @return
	 */
	@GetMapping("/allmembers")
	public ModelAndView findAllMemebers(HttpSession session) {
		
		if(session.getAttribute("adminLanguage") == null) {
			session.setAttribute("adminLanguage", "ko");			
		}
		
		if (adminService.validateAdmin(session)) {
			// 전체 멤버 가져오기
			List<MemberDTO> members = memberService.findAllMembers();
			List<FlagDTO> flags = myPageService.allFlags();
			ModelAndView mv = new ModelAndView();
			mv.addObject("members", members);
			mv.addObject("flags", flags);
			mv.setViewName("/Admin/Admin-Member");
			return mv;
			// 유저가 관리자가 아니거나 유저정보가 없을 때
		} else {
			return null;
		}
	}

	/**
	 * 전체 글 조회
	 * 
	 * @return
	 */
	@GetMapping("/allposts")
	public ModelAndView findAllPosts(HttpSession session) {
		ModelAndView mv = new ModelAndView();
		
		if(session.getAttribute("adminLanguage") == null) {
			session.setAttribute("adminLanguage", "ko");			
		}
		
		// 유저가 관리자일 때
		if (adminService.validateAdmin(session)) {
			// 전체 게시물 가져오기

			List<PostDTO> posts = adminService.findAllPosts();
			List<MemberDTO> members = memberService.findAllMembers();
			mv.addObject("members", members);
			mv.addObject("posts", posts);
			mv.setViewName("/Admin/Admin-Post");
			return mv;
			// 유저가 관리자가 아니거나 유저정보가 없을 때
		} else {
			return null;
		}
	}

	/**
	 * 회원 삭제
	 * 
	 * @return
	 */
	@GetMapping("/deletemember/{memberIdx}")
	@ResponseBody
	public MemberFlagDTO deleteMember(@PathVariable Integer memberIdx, HttpSession session) {
		// 유저가 관리자일 때
		if (adminService.validateAdmin(session)) {
			// 회원삭제
			memberService.withdrawMember(memberIdx);
			// 삭제 후 유저리스트를 보여줌
		}
		List<MemberDTO> members = memberService.findAllMembers();
		List<FlagDTO> flags = myPageService.allFlags();
		MemberFlagDTO memberFlag = new MemberFlagDTO(members, flags);
		return memberFlag;
	}

	/**
	 * 게시물 삭제
	 * 
	 * @return
	 */
	@GetMapping("/deletepost/{postIdx}")
	@ResponseBody
	public PostMemberDTO deletePost(@PathVariable Integer postIdx, HttpSession session) {
		// 유저가 관리자일 때
		if (adminService.validateAdmin(session)) {
			// 게시물이 존재할 때
			if (adminService.findPostByIdx(postIdx) != null) {
				// 게시물 삭제 진행
				adminService.deletePost(postIdx);
			}
		}
		List<PostDTO> posts = adminService.findAllPosts();
		List<MemberDTO> members = memberService.findAllMembers();
		PostMemberDTO postMember = new PostMemberDTO(posts, members);
		return postMember;
	}
	
	@PostMapping("/adminlanguage")
	@ResponseBody
	public void adminLanguageFunc(HttpSession session, String language) {
		session.setAttribute("adminLanguage", language);
	}
}
