package service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import dao.AdminDAO;
import dto.MemberDTO;
import dto.PostDTO;
import jakarta.servlet.http.HttpSession;

@Service("adminservice")
public class AdminService {
	
	@Autowired
	@Qualifier("admindao")
	private AdminDAO adminDAO;

	@Autowired
	private MemberService memberService;
	
	//전체 게시글 조회
	public List<PostDTO> findAllPosts() {
		List<PostDTO> posts = adminDAO.findAllPosts();
		return posts;
	}

	//게시물 아이디로 검색
	public PostDTO findPostByIdx(int postIdx) {
		PostDTO post = adminDAO.findPostByIdx(postIdx);
		return post;
	}

	//게시물 삭제
	public void deletePost(int postIdx) {
		adminDAO.deletePost(postIdx);
	}

	/**
	 * 관리자 인증
	 * 
	 * @param session
	 * @return
	 */
	public boolean validateAdmin(HttpSession session) {
		// 세션에서 멤버 아이디 받아오기
		Integer memberIdx = Integer.parseInt((String) session.getAttribute("memberIdx"));
		// 멤버 아디디로 멤버 정보 가져오기
		MemberDTO member = memberService.findMemberByIdx(memberIdx);
		if (member != null) {
			// 멤버 이메일 가져오기
			String email = member.getEmail();

			// 이메일이 관리자 소유인지 확인
			// 관리자일 때
			if (isEmailAdmin(email)) {
				return true;

				// 관리자가 아닐 때
			} else {
				return false;
			}
			// 멤버가 존재하지 않는 경우
		} else {
			return false;
		}
	}

	/**
	 * 관리자 인증 (이메일 검사)
	 * 
	 * @param email
	 * @return
	 */
	public boolean isEmailAdmin(String email) {
		// 이메일 주소에서 '@' 이후의 문자열을 추출
		int atIndex = email.indexOf('@');

		if (atIndex != -1) {
			String domain = email.substring(atIndex + 1);
			// '@' 이후의 문자열에 'admin'이 포함되어 있는지 확인
			return domain.contains("admin");
		}

		// '@'이 포함되지 않은 이메일 주소는 관리자가 아님
		return false;
	}
}
