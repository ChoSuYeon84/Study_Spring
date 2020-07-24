package com.hanul.automedic;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import member.MemberServiceImpl;
import member.MemberVO;

@Controller
public class MemberController {
	@Autowired private MemberServiceImpl service;
	
	//회원가입화면 요청
		@RequestMapping("/member")
		public String member(HttpSession session) {
			session.setAttribute("category", "join");
			return "member/join";
		}
	
	//로그아웃 요청
		@ResponseBody @RequestMapping("/logout")
		public void logout(HttpSession session) {
			session.removeAttribute("login_info");
		}
	
	//로그인요청
	@ResponseBody @RequestMapping("/login") //ResponseBody : 이것 자체가 응답이 되는것
	public String login( String id, String pw, HttpSession session) {
		//public String login( @RequestParam("id")  String member_email, @RequestParam("pw") String member_password, HttpSession session) {
		//화면에서 입력한 아이디와 비밀번호가 
		//일치하는 회원정보가 DB에 있는지 확인하여
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("member_email",  id);
		map.put("member_password", pw);
		MemberVO vo = service.member_login(map);
		//일치하는 회원정보가 있다면 회원정보를 세션에 담는다
		session.setAttribute("login_info", vo);
		return vo == null ? "false" : "true";
	}
}
