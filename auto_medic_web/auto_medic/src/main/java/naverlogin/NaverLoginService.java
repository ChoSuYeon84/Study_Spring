package naverlogin;

import java.util.HashMap;

public interface NaverLoginService {
	//로그인시 DB에 정보가 없다면 회원정보 저장
	void naver_insert(NaverLoginVO vo);
	//로그인시 DB에 정보가 있다면 회원정보 확인
	NaverLoginVO naver_select(String id);
	//로그인처리(확인필요)
	NaverLoginVO naver_login(HashMap<String, String> map);

}
