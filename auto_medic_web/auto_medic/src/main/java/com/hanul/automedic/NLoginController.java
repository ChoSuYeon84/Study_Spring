package com.hanul.automedic;

import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.XML;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import naverlogin.NaverLoginServiceImpl;
import naverlogin.NaverLoginVO;
import naverlogin.Utils;

@Controller
public class NLoginController {
	
	@Autowired private NaverLoginServiceImpl service;
	
	private static final String mydomain = "http%3A%2F%2Flocalhost%2Fautomedic%2Fcallback";
	private static final String clientId = "przzu6N6M4M9BvGyF5QG";
	private static final String clientSecret = "1lG22iUMlW";
	private static final String requestUrl = "https://nid.naver.com/oauth2.0/authorize?client_id=" + clientId + "&response_type=code&redirect_uri="+ mydomain + "&state="; 
	 
	 
	@RequestMapping(value = "/Nlogin")
	 public String naverLogin(HttpSession session) {
	  String state = Utils.generateState();     //토큰을 생성합니다.
	  session.setAttribute("state", state);      //세션에 토큰을 저장합니다.
	  return "redirect:" + requestUrl + state;   //만들어진 URL로 인증을 요청합니다.
	 
	 }
	 
	private static final String userProfileUrl = "https://apis.naver.com/nidlogin/nid/getUserProfile.xml";
	@RequestMapping("/callback")
	 public String callback(Model model, @RequestParam String state, @RequestParam String code, HttpServletRequest request, HttpSession session) throws UnsupportedEncodingException {
	  String storedState = (String) request.getSession().getAttribute("state");  //세션에 저장된 토큰을 받아옵니다.
	  System.out.println("세션저장토큰 :" +state);
	  System.out.println("인증요청받은토큰 : " + storedState);
	  if (!state.equals(storedState)) {             //세션에 저장된 토큰과 인증을 요청해서 받은 토큰이 일치하는지 검증합니다.
	   System.out.println("401 unauthorized");   //인증이 실패했을 때의 처리 부분입니다.
	   return "redirect:/";
	  }
	  String data = Utils.getHtml(getAccessUrl(state, code), null);           //AccessToken을 요청하고 그 값을 가져옵니다.
	  Map<String,String> map = Utils.JSONStringToMap(data);               //JSON의 형태로 받아온 값을 Map으로 저장합니다.
	  System.out.println(data);
	  String accessToken = map.get("access_token");
	  String tokenType = map.get("token_type"); 
	  
		String profileDataXml = Utils.getHtml(userProfileUrl, tokenType + " " + accessToken);
		// tokentype 와 accessToken을 조합한 값을 해더의 Authorization에 넣어 전송합니다. 결과 값은 xml로
		// 출력됩니다.
		System.out.println("xml : "+profileDataXml);
		org.json.JSONObject jsonObject = XML.toJSONObject(profileDataXml); // xml을 json으로 파싱합니다.
		org.json.JSONObject responseData = jsonObject.getJSONObject("data");
		// json의 구조가 data 아래에 자식이 둘인 형태여서 map으로 파싱이 안됩니다. 따라서 자식 노드로 접근합니다.
		Map<String, String> userMap = Utils.JSONStringToMap(responseData.get("response").toString());
		// 사용자 정보 값은 자식노드 중에 response에 저장되어 있습니다. response로 접근하여 그 값들은 map으로 파싱합니다.
		
			String email= userMap.get("email");
			String name = userMap.get("name");
			
			System.out.println(email);
			System.out.println(name);
			
			HashMap<String, String> navermap = new HashMap<String, String>(); 
		    navermap.put("naver_email",  email);
		    navermap.put("naver_nickname", name);
		    model.addAttribute("Naverlogin", navermap);
		    System.out.println(navermap);
		    
		    //사용자가 네이버 로그인시, DB에 정보가 존재하면 로그인처리,
		    NaverLoginVO vo= service.naver_login(navermap);
		    if(vo == null) {
		    	vo = new NaverLoginVO();
		    	vo.setNaver_email(email);
		    	vo.setNaver_nickname(name);
		    	service.naver_insert(vo);
		    }
		    session.setAttribute("Naverlogin", vo);
		
	  return "redirect:/";
	 }
	
	
	private String getAccessUrl(String state, String code) {
		  String accessUrl = "https://nid.naver.com/oauth2.0/token?client_id=" + clientId + "&client_secret=" + clientSecret
		    + "&grant_type=authorization_code" + "&state=" + state + "&code=" + code;
		  return accessUrl;
	}
	
	//로그아웃 요청
	@ResponseBody @RequestMapping("/Nlogout")
	public void Nlogout(HttpSession session) {
		session.removeAttribute("Naverlogin");
	}
	
}
