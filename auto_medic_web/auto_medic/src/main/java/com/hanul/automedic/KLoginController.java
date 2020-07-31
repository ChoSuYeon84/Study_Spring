package com.hanul.automedic;

import org.springframework.stereotype.Controller;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.codehaus.jackson.map.ObjectMapper;
import org.omg.CORBA.NameValuePair;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.fasterxml.jackson.databind.JsonNode;

import kakaologin.HttpConnection;

@Controller
public class KLoginController {
	
	  HttpConnection conn = HttpConnection.getInstance();
	  
	  @RequestMapping(value = "/Klogin", method = RequestMethod.GET) 
	  public String kakao() { StringBuffer loginUrl = new StringBuffer();
		  loginUrl.append("https://kauth.kakao.com/oauth/authorize?client_id=");
		  loginUrl.append("ef0fde12cdb2634a56685939df6aa859"); //카카오 앱에 있는 REST KEY
		  loginUrl.append("&redirect_uri=");
		  loginUrl.append("http://192.168.0.22/automedic/"); //카카오 앱에 등록한 redirect URL
		  loginUrl.append("&response_type=code");
		  
		  return "redirect:"+loginUrl.toString(); 
	  }
//	  
//	  @RequestMapping(value = "/kakaoLogin", method = RequestMethod.GET) public
//	  String redirect(@RequestParam String code, HttpSession session) throws IOException {
//	  
//		  //code //사용자가 취소 누르면 error 파라메터를 받음 // 그때 여기서 구분해야할듯 
//		  Map<String, String> map = new HashMap<String, String>(); 
//		  map.put("grant_type", "=authorization_code"); 
//		  map.put("client_id", "=ef0fde12cdb2634a56685939df6aa859"); //카카오 앱에 있는 REST KEY
//		  map.put("redirect_uri", "=http://192.168.0.22/automedic/"); //카카오 앱에 등록한 redirect URL 
//		  map.put("code", "="+code);
//		  
//		  String out = conn.HttpPostConnection("https://kauth.kakao.com/oauth/token",
//		  map).toString();
//		  
//		  ObjectMapper mapper = new ObjectMapper(); 
//		  KakaoLoginOutput output = mapper.readValue(out, KakaoLoginOutput.class);
//		  
//		  System.out.println(output); 
//		  session.setAttribute("access_token",output.getAccess_token());
//		  
//		  return "redirect:/"; 
//	  
//	  }
	  
	  
//	  @RequestMapping(value="/logout")
//		public String access(HttpSession session) throws IOException {
//			
//			String access_token = (String)session.getAttribute("access_token");
//			Map<String, String> map = new HashMap<String, String>();
//			map.put("Authorization", "Bearer "+ access_token);
//			
//			String result = conn.HttpPostConnection("https://kapi.kakao.com/v1/user/logout", map).toString();
//			System.out.println(result);
//			
//			return "redirect:/";
//		}
}