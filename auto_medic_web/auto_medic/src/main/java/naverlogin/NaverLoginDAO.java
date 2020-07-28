package naverlogin;

import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class NaverLoginDAO implements NaverLoginService {
	@Autowired private SqlSession sql;

	@Override
	public void naver_insert(NaverLoginVO vo) {
		// TODO Auto-generated method stub

	}

	@Override
	public NaverLoginVO naver_select(String id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public NaverLoginVO naver_login(HashMap<String, String> map) {
		// TODO Auto-generated method stub
		return null;
	}

}
