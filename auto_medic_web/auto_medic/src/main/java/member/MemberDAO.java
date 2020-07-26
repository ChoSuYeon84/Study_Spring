package member;

import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MemberDAO implements MemberService {
	@Autowired private SqlSession sql;

	@Override
	public boolean member_insert(MemberVO vo) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public MemberVO member_select(String id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public MemberVO member_login(HashMap<String, String> map) {
		return sql.selectOne("member.mapper.login", map);
	}

	@Override
	public boolean member_id_check(String id) {
		return (Integer) sql.selectOne("member.mapper.id_check", id) == 0 ? true : false;
	}

	@Override
	public boolean member_update(MemberVO vo) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean member_delete(String id) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean member_nick_check(String nickname) {
		return (Integer) sql.selectOne("member.mapper.nickname_check", nickname) == 0 ? true : false;
	}

}
