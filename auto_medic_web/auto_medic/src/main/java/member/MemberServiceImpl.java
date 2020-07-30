package member;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MemberServiceImpl implements MemberService {
	@Autowired private MemberDAO dao;

	@Override
	public boolean member_insert(MemberVO vo) {
		return dao.member_insert(vo);
	}

	@Override
	public MemberVO member_select(String id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public MemberVO member_login(HashMap<String, String> map) {
		return dao.member_login(map);
	}

	@Override
	public boolean member_id_check(String member_email) {
		return dao.member_id_check(member_email);
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
		return dao.member_nick_check(member_nickname);
	}

	@Override
	public void member_pw_update(MemberVO vo) {
		dao.member_pw_update(vo);
		
	}
	
	
}
