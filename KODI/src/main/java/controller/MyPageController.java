package controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import dto.FlagDTO;
import dto.MemberDTO;
import dto.PostDTO;
import dto.PostImageDTO;
import dto.ReadMemberAllDTO;
import jakarta.servlet.http.HttpSession;
import service.MemberService;
import service.MyPageService;
import service.SearchMemberListService;

@Controller
@RequestMapping("/api")
public class MyPageController {

	/**
	 * POST 비밀번호 인증 (/api/verifyPw) DATA: 유저 입력 비밀번호 POST 회원탈퇴
	 * (/api/withdrawMember)DATA: X POST 회원정보 수정 (/api/updateMemberInfo) DATA: 변경할
	 * 비밀번호, 닉네임, 국적 GET 마이페이지 요청 (/api/myPage) DATA: X
	 */

	@Autowired
	private MemberService memberService;

	@Autowired
	private MyPageService myPageService;

	@Autowired
	@Qualifier("searchmemberlistservice")
	SearchMemberListService searchService;

	@PostMapping("/verifyPw")
	public ResponseEntity<String> verifyPw(HttpSession session, @RequestBody MemberDTO memberDTO) {
		String memberSessionIdx = (String) session.getAttribute("memberIdx");

		// 세션에 로그인이 되어있는지 확인
		// 로그인이 안되어 있을 때
		if (memberSessionIdx == null) {
			return new ResponseEntity<>("로그인 정보가 없습니다", HttpStatus.BAD_REQUEST);

			// 로그인이 되어 있을 때
		} else {

			// 비밀번호를 받아옴
			Integer memberIdx = Integer.parseInt(memberSessionIdx);
			MemberDTO member = memberService.findMemberByIdx(memberIdx);

			// 클라이언트에서 전달된 비밀번호
			String clientPassword = memberDTO.getPw();

			// 클라이언트에서 전달된 비밀번호가 null인 경우
			if (clientPassword == null) {
				return new ResponseEntity<>("비밀번호를 입력하세요", HttpStatus.BAD_REQUEST);
			}

			// 비밀번호가 일치하는 경우
			if (clientPassword.equals(member.getPw())) {
				return new ResponseEntity<>("회원정보 확인 완료", HttpStatus.OK);

				// 비밀번호가 불일치하는 경우
			} else {
				return new ResponseEntity<>("비밀번호가 일치하지 않습니다", HttpStatus.UNAUTHORIZED);
			}
		}
	}

	/**
	 * 회원탈퇴 처리
	 * 
	 * @param session
	 * @return
	 */
	@PostMapping("/withdrawMember")
	public ResponseEntity<String> withdrawMember(HttpSession session) {

		// 세션에 바운딩된 유저아이디를 받아옴
		Integer memberIdx = Integer.parseInt((String) session.getAttribute("memberIdx"));

		// 세션에 유저아이디가 있고, 실제로 DB에 존재하는 경우
		if (memberIdx != null && memberService.findMemberByIdx(memberIdx) != null) {
			memberService.withdrawMember(memberIdx);
			return new ResponseEntity<>("회원탈퇴가 완료되었습니다", HttpStatus.OK);
			// 세션에 유저아이디가 없거나 DB에 존재하지 않는 경우
		} else {
			return new ResponseEntity<>("회원이 존재하지 않습니다", HttpStatus.BAD_REQUEST);
		}
	}

	/**
	 * 회원 수정창 요청
	 * 
	 * @param memberDTO
	 * @param session
	 * @return
	 */
	@GetMapping("/update")
	public ModelAndView updateModal(HttpSession session) {
		ModelAndView mv = new ModelAndView();
		List<FlagDTO> allFlags = myPageService.allFlags();
		mv.addObject("flags", allFlags);

		String memberIdx = (String) session.getAttribute("memberIdx");
		MemberDTO member = memberService.findMemberByIdx(Integer.parseInt(memberIdx));
		mv.addObject("member", member);
		mv.setViewName("/MyPage/Modify");
		return mv;
	}

	/**
	 * 회원정보 수정
	 * 
	 * @param memberDTO
	 * @param session
	 * @return
	 */
	@PostMapping("/updateMemberInfo")
	public ResponseEntity<String> updateMemberInfo(@RequestBody MemberDTO memberDTO, HttpSession session) {

		// 세션에 바운딩된 유저아이디를 받아옴
		Integer memberIdx = Integer.parseInt((String) session.getAttribute("memberIdx"));

		// 세션에 유저아이디가 있고, 실제로 DB에 존재하는 경우
		if (memberIdx != null && memberService.findMemberByIdx(memberIdx) != null) {
			// 기존 비밀번호 유지 처리
			if ("unchanged".equals(memberDTO.getPw())) {
				// 기존 비밀번호를 가져와서 설정
				String existingPassword = memberService.findMemberByIdx(memberIdx).getPw();
				memberDTO.setPw(existingPassword);
			}

			memberDTO.setMemberIdx(memberIdx);
			memberService.updateMemberInfo(memberDTO);
			return new ResponseEntity<>("회원정보가 업데이트 되었습니다", HttpStatus.OK);

		} else {
			// 세션에 유저아이디가 없거나 DB에 존재하지 않는 경우
			return new ResponseEntity<>("회원이 존재하지 않습니다", HttpStatus.BAD_REQUEST);
		}
	}

	/**
	 * 마이페이지 요청
	 * 
	 * @param session
	 * @return
	 */
	@GetMapping("/mypage")
	public ModelAndView readMyPosts(HttpSession session) {
	    ModelAndView mv = new ModelAndView();
	    String memberIdStr = (String) session.getAttribute("memberIdx");

	    if (memberIdStr != null) {
	        try {
	            Integer memberIdx = Integer.parseInt(memberIdStr);
	            MemberDTO member = memberService.findMemberByIdx(memberIdx);
	            if (member != null) {
	                // 나의 전체글 가져오기
	                List<PostDTO> posts = myPageService.readMyPosts(memberIdx);
	                if (posts != null) {
	                    mv.addObject("posts", posts);
	                }
	                List<PostImageDTO> images = myPageService.allImages();
	                mv.addObject("images", images);
	                mv.addObject("isSession", true);
	            } else {
	                // 세션에는 사용자 아이디가 있지만, DB에서 해당 회원 정보가 없는 경우
	                mv.addObject("isSession", false);
	            }
	        } catch (NumberFormatException e) {
	            // 세션에 저장된 사용자 아이디가 정수로 파싱할 수 없는 형태인 경우
	            mv.addObject("isSession", false);
	        }
	    } else {
	        // 세션에 사용자 아이디가 없는 경우
	        mv.addObject("isSession", false);
	    }

	    mv.setViewName("/MyPage/MyPage");
	    return mv;
	}



	/**
	 * 나를 추가한 친구
	 * 
	 * @param session
	 * @return
	 */
	@GetMapping("/follower")
	public ModelAndView follower(HttpSession session) {
		ModelAndView mv = new ModelAndView();
		List<ReadMemberAllDTO> readMemberAll = getFriendList(session, "나를 추가한 친구");
		mv.addObject("members", readMemberAll);
		mv.setViewName("/MyPage/FollowerFriendList");
		return mv;
	}

	/**
	 * 내가 추가한 친구
	 * 
	 * @param session
	 * @return
	 */
	@GetMapping("/following")
	public ModelAndView following(HttpSession session) {
		ModelAndView mv = new ModelAndView();
		List<ReadMemberAllDTO> readMemberAll = getFriendList(session, "내가 추가한 친구");
		mv.addObject("members", readMemberAll);
		mv.setViewName("/MyPage/FollowingFriendList");
		return mv;
	}

	/**
	 * 서로친구
	 * @param session
	 * @return
	 */
	@GetMapping("/pair")
	public ModelAndView pair(HttpSession session) {
		ModelAndView mv = new ModelAndView();
		List<ReadMemberAllDTO> readMemberAll = getFriendList(session, "서로 친구");
		mv.addObject("members", readMemberAll);
		mv.setViewName("/MyPage/PairFriendList");
		return mv;
	}

	/**
	 * 서로친구 삭제
	 * @param memberIdx
	 * @param session
	 * @return
	 */
	@GetMapping("/pair/delete/{memberIdx}")
	@ResponseBody
	public List<ReadMemberAllDTO> pairDelete(@PathVariable Integer memberIdx, HttpSession session) {
		Integer member_Idx = Integer.parseInt((String) session.getAttribute("memberIdx"));
		searchService.delete_Friend(member_Idx, memberIdx);
		return getFriendList(session, "서로 친구");
	}

	/**
	 * 팔로잉 삭제
	 * @param memberIdx
	 * @param session
	 * @return
	 */
	@GetMapping("/following/delete/{memberIdx}")
	@ResponseBody
	public List<ReadMemberAllDTO> deleteFollowing(@PathVariable Integer memberIdx, HttpSession session) {
		Integer member_Idx = Integer.parseInt((String) session.getAttribute("memberIdx"));
		searchService.delete_Friend(member_Idx, memberIdx);
		return getFriendList(session, "내가 추가한 친구");
	}

	/**
	 * 팔로워 수락
	 * @param memberIdx
	 * @param session
	 * @return
	 */
	@GetMapping("/follower/accept/{memberIdx}")
	@ResponseBody
	public List<ReadMemberAllDTO> acceptFollower(@PathVariable Integer memberIdx, HttpSession session) {
		Integer member_Idx = Integer.parseInt((String) session.getAttribute("memberIdx"));
		searchService.updateFriendRequest(member_Idx, memberIdx);
		return getFriendList(session, "나를 추가한 친구");
	}

	/**
	 * 팔로워 거절
	 * @param memberIdx
	 * @param session
	 * @return
	 */
	@GetMapping("/follower/delete/{memberIdx}")
	@ResponseBody
	public List<ReadMemberAllDTO> deleteFollower(@PathVariable Integer memberIdx, HttpSession session) {
		Integer member_Idx = Integer.parseInt((String) session.getAttribute("memberIdx"));
		searchService.delete_Friend(member_Idx, memberIdx);
		return getFriendList(session, "나를 추가한 친구");
	}

	/**
	 * 서로 친구, 내가 추가한 친구, 나를 추가한 친구를 조회하는 메서드
	 * 
	 * @param session
	 * @param friendState 친구 상태 ("서로 친구", "내가 추가한 친구", "나를 추가한 친구")
	 * @return
	 */
	private List<ReadMemberAllDTO> getFriendList(HttpSession session, String friendState) {
		Integer memberIdx = Integer.parseInt((String) session.getAttribute("memberIdx"));

		List<Integer> resultList1 = new ArrayList<>();
		List<MemberDTO> memberList = memberService.findAllMembers();
		for (int i = 0; i < memberList.size(); i++) {
			resultList1.add(memberList.get(i).getMemberIdx());
		}

		{
			List<ReadMemberAllDTO> readMemberAll = new ArrayList<ReadMemberAllDTO>();
			for (int i = 0; i < resultList1.size(); i++) {
				// 나에 대한 검색은 제외
				if (resultList1.get(i) != memberIdx) {
					ReadMemberAllDTO readMemberAllone = searchService.getReadMemberAll(resultList1.get(i), memberIdx);
					readMemberAll.add(readMemberAllone);
				}
			}
			for (int i = 0; i < readMemberAll.size(); i++) {
				if (!friendState.equals(readMemberAll.get(i).getFriendState())) {
					readMemberAll.remove(i);
					i--;
				}
			}
			return readMemberAll;
		}
	}
}