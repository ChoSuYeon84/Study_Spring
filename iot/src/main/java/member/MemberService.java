package member;

import java.util.HashMap;

public interface MemberService {
	//회원가입시 회원정보 저장
	boolean member_insert(MemberVO vo);
	//마이페이지에서 회원정보 확인
	MemberVO member_select(String id);
	//로그인처리
	MemberVO member_login(HashMap<String, String> map);
	//아이디중복확인
	boolean member_id_check(String id);
	//마이페이지에서 회원정보변경저장
	boolean member_update(MemberVO vo);
	//회원정보탈퇴
	boolean member_delete(String id);
}
