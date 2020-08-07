package my;


import java.util.List;

import member.MemberVO;


public interface MyService {
	
	//마이페이지에서 회원정보 확인
	MemberVO my_select(String member_email);	
	
	//달력에서 일정확인
	List<CalendarVO> my_calendar(String date);
	
	List<CalendarVO> my_calendar2();
		
	//마이페이지에서 회원정보 변경저장
	int my_update(MemberVO vo);
	//마이페이지에서 회원정보 변경저장2
	boolean my_update2(MemberVO vo);
	//회원정보탈퇴
	void my_delete(String member_email);
}
