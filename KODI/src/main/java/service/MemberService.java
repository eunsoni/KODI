package service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.MemberDAO;
import dto.MemberDTO;

@Service("memberservice")
public class MemberService {
	
	@Autowired
	private MemberDAO memberDAO;
	
	//회원등록
	public void registerMember(MemberDTO memberDTO) {
		memberDAO.registerMember(memberDTO);
	}

	//회원 탈퇴
	public void withdrawMember(int memberIdx){
		memberDAO.withdrawMember(memberIdx);
	}

	public List<MemberDTO> findAllMembers(){
		List<MemberDTO> members = memberDAO.findAllMembers();
		return members;
	}
	
	//이메일로 회원찾기
	public MemberDTO findMemberByEmail(String email) {
		MemberDTO findedMember = memberDAO.findMemberByEmail(email);
		return findedMember;
	}

	//아이디로 회원찾기
	public MemberDTO findMemberByIdx(int memberIdx) {
		MemberDTO findedMember = memberDAO.findMemberByIdx(memberIdx);
		return findedMember;
	}

	//회원정보 업데이트 하기
	public void updateMemberInfo(MemberDTO memberDTO) {
		memberDAO.updateMemberInfo(memberDTO);
	}

	public String findMemberName(String memberName) {
		return memberDAO.findMemberName(memberName);
	}
}
