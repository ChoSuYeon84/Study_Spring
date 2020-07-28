package naverlogin;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class NaverLoginServiceImpl implements NaverLoginService {
	@Autowired private NaverLoginDAO dao;
	
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
