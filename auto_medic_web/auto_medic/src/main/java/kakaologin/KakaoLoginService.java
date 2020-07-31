package kakaologin;

import java.util.HashMap;

public interface KakaoLoginService {
	//로그인시 DB에 정보가 없다면 회원정보 저장
	void kakao_insert(KakaoLoginVO vo);
	//로그인시 DB에 정보가 있다면 회원정보 확인
	KakaoLoginVO kakao_select(String id);
	//로그인처리(확인필요)
	KakaoLoginVO kakao_login(HashMap<String, String> map);

}
