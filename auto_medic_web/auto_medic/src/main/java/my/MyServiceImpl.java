package my;



import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;



import member.MemberVO;

@Service
public class MyServiceImpl implements MyService {
	@Autowired private MyDAO dao;

	@Override
	public MemberVO my_select(String member_email) {
		
		return dao.my_select(member_email);
	}

	@Override
	public int my_update(MemberVO vo) {
		
		return dao.my_update(vo);		
	}
	
	@Override
	public boolean my_update2(MemberVO vo) {
		
		return  dao.my_update2(vo);	
	}


	@Override
	public void my_delete(String member_email) {
		dao.my_delete(member_email);
		
	}

	@Override
	public List<CalendarVO> my_calendar(String day) {
		
		return dao.my_calendar(day);
	}

	@Override
	public List<CalendarVO> my_calendar2() {
		
		return dao.my_calendar2();
	}

}
