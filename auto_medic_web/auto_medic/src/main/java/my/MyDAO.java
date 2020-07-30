package my;



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
	public boolean my_update(MemberVO vo) {
		
		return false;
	}

	@Override
	public boolean my_delete(String member_email) {
		
		return false;
	}

}
