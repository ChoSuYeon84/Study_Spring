package naverlogin;

import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class NaverLoginDAO implements NaverLoginService {
	@Autowired private SqlSession sql;

	@Override
	public NaverLoginVO naver_select(String id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public NaverLoginVO naver_login(HashMap<String, String> map) {
		return sql.selectOne("naver.mapper.login", map);
	}

	@Override
	public boolean naver_insert(NaverLoginVO vo) {
		return sql.insert("naver.mapper.join", vo) == 0 ? false : true;
	}

}
