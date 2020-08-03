package kakaologin;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class KakaoLoginServiceImpl implements KakaoLoginService {
	@Autowired private KakaoLoginDAO dao;

	@Override
	public KakaoLoginVO kakao_select(String id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public KakaoLoginVO kakao_login(HashMap<String, String> map) {
		return dao.kakao_login(map);
	}

	@Override
	public boolean kakao_insert(KakaoLoginVO vo) {
		return dao.kakao_insert(vo);
	}

}
