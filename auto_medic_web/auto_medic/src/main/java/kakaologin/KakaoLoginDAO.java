package kakaologin;

import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class KakaoLoginDAO implements KakaoLoginService {
	@Autowired private SqlSession sql;

	@Override
	public KakaoLoginVO kakao_select(String id) {
		// TODO Auto-generated method stub
		return null;
	}
	
	@Override
	public KakaoLoginVO kakao_login(HashMap<String, String> map) {
		return sql.selectOne("kakao.mapper.login", map);
	}

	@Override
	public boolean kakao_insert(KakaoLoginVO vo) {
		return sql.insert("kakao.mapper.join", vo) == 0 ? false : true;
	}

}
