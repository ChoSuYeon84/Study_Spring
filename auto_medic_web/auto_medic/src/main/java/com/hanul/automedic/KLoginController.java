package com.hanul.automedic;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import java.util.HashMap;
import javax.servlet.http.HttpSession;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kakaologin.KakaoLoginServiceImpl;
import kakaologin.KakaoLoginVO;

@Controller
public class KLoginController {
	
	@Autowired KakaoLoginServiceImpl service;
	
	@ResponseBody @RequestMapping("/kakaoLogin")
	public boolean kakaoLogin(Model model, HttpSession session, String kakao_email, String kakao_nickname) {
		HashMap<String, String> map = new HashMap<String, String>(); 
		map.put("kakao_email",  kakao_email);
		map.put("kakao_nickname", kakao_nickname);
		model.addAttribute("Kakaologin", map);
		    
		//사용자가 카카오 로그인시, DB에 정보가 존재하면 로그인처리
		KakaoLoginVO vo = service.kakao_login(map);
		System.out.println(vo);
		if(vo == null) {
			vo = new KakaoLoginVO();
			vo.setKakao_email(kakao_email);
			vo.setKakao_nickname(kakao_nickname);
			service.kakao_insert(vo);
		}
		session.setAttribute("Kakaologin", vo);
		return vo == null ? false : true;
	}
	
	//로그아웃 요청
		@ResponseBody @RequestMapping("/Klogout")
		public void Nlogout(HttpSession session) {
			session.removeAttribute("Kakaologin");
		}
	
}