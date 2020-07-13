package com.hanul.iot;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import common.CommonService;
import member.MemberServiceImpl;
import member.MemberVO;

@Controller
public class MemberController {
	@Autowired private MemberServiceImpl service;
	@Autowired private CommonService common;
	
	//회원가입처리 요청
	@ResponseBody @RequestMapping(value="/join", produces="text/html; charset=utf-8")	//산출물(produces)에 대한 캐릭터 셋을 설정
	public String join(HttpSession session, MemberVO vo, HttpServletRequest request) {
		String msg = "<script type = 'text/javascript'>";
		//화면에서 입력한 정보를 DB에 저장한 후 홈화면으로 연결
		if( service.member_insert(vo) ) {
			//메일전송
			common.sendEmail(session, vo.getEmail(), vo.getName());
			msg += "alert('회원가입 축하^^'); location='"+ request.getContextPath() +"'";
			
		}else {
			msg += "alert('회원가입 실패ㅠㅠ'); history.go(-1)"; 
			
		}
		msg += "</script>";
		return msg;
	}
	
	//아이디 중복확인 요청
	@ResponseBody @RequestMapping("/id_check")
	public boolean id_check(String id) {
		return service.member_id_check(id);
	}
	
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
	public String login(String id, String pw, HttpSession session) {
		//화면에서 입력한 아이디와 비밀번호가 
		//일치하는 회원정보가 DB에 있는지 확인하여
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("id", id);
		map.put("pw", pw);
		MemberVO vo = service.member_login(map);
		//일치하는 회원정보가 있다면 회원정보를 세션에 담는다
		session.setAttribute("login_info", vo);
		return vo == null ? "false" : "true";
	}
}
