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
		return sql.insert("member.mapper.join", vo) == 0 ? false : true;
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
	public boolean member_id_check(String member_email) {
		return (Integer) sql.selectOne("member.mapper.id_check", member_email) == 0 ? true : false;
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
	public boolean member_nick_check(String member_nickname) {
		return (Integer) sql.selectOne("member.mapper.nickname_check", member_nickname) == 0 ? true : false;
	}

	@Override
	public void member_pw_update(MemberVO vo) {
		sql.update("member.mapper.update", vo);
	}

	@Override
	public boolean member_email_chk(String member_email) {
		String result = sql.selectOne("member.mapper.member_email_chk", member_email).toString();
		if(result.equals("0")) {
			return false;
		}else {
			return true;
		}
	}

	
}
