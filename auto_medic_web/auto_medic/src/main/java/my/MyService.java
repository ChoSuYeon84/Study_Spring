package my;


import member.MemberVO;

public interface MyService {
	
	//마이페이지에서 회원정보 확인
	MemberVO my_select(String member_email);
	
	//마이페이지에서 회원정보 변경저장
	boolean my_update(MemberVO vo);
	//회원정보탈퇴
	boolean my_delete(String member_email);
}
