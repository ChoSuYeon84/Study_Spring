package kakaologin;

import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class KakaoLoginDAO implements KakaoLoginService {
	@Autowired private SqlSession sql;

	@Override
	public void kakao_insert(KakaoLoginVO vo) {
		// TODO Auto-generated method stub
		
	}
	
	@Override
	public KakaoLoginVO kakao_select(String id) {
		// TODO Auto-generated method stub
		return null;
	}
	
	@Override
	public KakaoLoginVO kakao_login(HashMap<String, String> map) {
		// TODO Auto-generated method stub
		return null;
	}

}
