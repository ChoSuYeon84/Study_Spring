package com.hanul.automedic;

import java.io.IOException;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.scribejava.core.model.OAuth2AccessToken;

import naverlogin.NaverLoginBO;
import naverlogin.NaverLoginServiceImpl;
import naverlogin.NaverLoginVO;

@Controller
public class NLoginController {
	/* NaverLoginBO */
	private NaverLoginBO naverLoginBO;
	private String apiResult = null;
	
	@Autowired private NaverLoginServiceImpl service;
	
	@Autowired
	private void setNaverLoginBO(NaverLoginBO naverLoginBO) {
		this.naverLoginBO = naverLoginBO;
	}

	//로그인 첫 화면 요청 메소드
		@RequestMapping(value = "/Nlogin", method = { RequestMethod.GET, RequestMethod.POST })
		public String Nlogin(Model model, HttpSession session) {
			
			System.out.println("네이버로그인");
			/* 네이버아이디로 인증 URL을 생성하기 위하여 naverLoginBO클래스의 getAuthorizationUrl메소드 호출 */
			String naverAuthUrl = naverLoginBO.getAuthorizationUrl(session);
			
			//https://nid.naver.com/oauth2.0/authorize?response_type=code&client_id=sE***************&
			//redirect_uri=http%3A%2F%2F211.63.89.90%3A8090%2Flogin_project%2Fcallback&state=e68c269c-5ba9-4c31-85da-54c16c658125
			System.out.println("네이버:" + naverAuthUrl);
			
			//네이버 
			model.addAttribute("url", naverAuthUrl);

			/* 생성한 인증 URL을 View로 전달 */
			return "social/Nlogin";
		}
		
		//네이버 로그인 성공시 callback호출 메소드
		@RequestMapping(value = "/callback", method = { RequestMethod.GET, RequestMethod.POST })
		public String callback(Model model, @RequestParam String code, @RequestParam String state, HttpSession session)
				throws IOException {
			System.out.println("여기는 callback");
			OAuth2AccessToken oauthToken;
	        oauthToken = naverLoginBO.getAccessToken(session, code, state);
	        //로그인 사용자 정보를 읽어온다.
		    apiResult = naverLoginBO.getUserProfile(oauthToken);
		    
		    try {
			    JSONObject obj = (JSONObject)new JSONParser().parse( apiResult );
			    obj = (JSONObject)obj.get("response");
			    HashMap<String, String> map = new HashMap<String, String>(); 
			    map.put("id",  obj.get("email").toString());
			    map.put("name", obj.get("name").toString());
			    model.addAttribute("Naverlogin", map);
			    
			    //사용자가 네이버 로그인시, DB에 정보가 존재하면 로그인처리,
			    NaverLoginVO vo= service.naver_login(map);
			    if(vo == null) {
			    	vo = new NaverLoginVO();
			    	vo.setNaver_email(obj.get("email").toString());
			    	vo.setNaver_nickname(obj.get("name").toString());
			    	service.naver_insert(vo);
			    }
			    session.setAttribute("Naverlogin", vo);
			    			    
			    //DB에 정보가 존재하지 않으면 회원가입후 로그인처리
			    
			    
		    }catch(Exception e) {
		    	System.out.println(e.getMessage());
		    }
			model.addAttribute("result", apiResult);
			
	        /* 네이버 로그인 성공 페이지 View 호출 */
			
			return "redirect:/";
		}

}
