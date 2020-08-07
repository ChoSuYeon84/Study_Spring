package my;



import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import member.MemberVO;

@Repository
public class MyDAO implements MyService {
	@Autowired private SqlSession sql;

	@Override
	public MemberVO my_select(String member_email) {
		
		return sql.selectOne("my.mapper.mypage", member_email);
	}

	@Override
	public int my_update(MemberVO vo) {
		 return sql.update("my.mapper.update", vo);
		
		
	}
	@Override
	public boolean my_update2(MemberVO vo) {
		return sql.update("my.mapper.update2", vo)>0? true:false;		
	}

	@Override
	public void my_delete(String member_email) {
		sql.delete("my.mapper.delete", member_email);
		
	}

	@Override
	public List<CalendarVO> my_calendar(String day) {
		
		return sql.selectList("my.mapper.calendar", day);
	}
	@Override
	public List<CalendarVO> my_calendar2() {
		
		return sql.selectList("my.mapper.calendar2");
		
	}

	
	
	
	
	
	
	 
}
