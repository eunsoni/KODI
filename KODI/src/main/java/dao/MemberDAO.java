package dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import dto.MemberDTO;

@Repository("memberdao")
@Mapper
public interface MemberDAO {
	//회원등록 SQL문
	int registerMember(MemberDTO memberDTO);

	//이메일로 회원탐색 SQL문
	MemberDTO findMemberByEmail(String email);

	//아이디로 회원탐색 SQL문
	MemberDTO findMemberByIdx(int memberIdx);

	//회원탈퇴 SQL문
	int withdrawMember(int memberIdx);

	//회원정보 업데이트 SQL문
	int updateMemberInfo(MemberDTO memberDTO);

	//전체 회원 조회
	List<MemberDTO> findAllMembers();
	
	//유저 이름 조회
  String findMemberName(String memberName);
}
