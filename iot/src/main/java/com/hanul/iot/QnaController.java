package com.hanul.iot;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import common.CommonService;
import member.MemberServiceImpl;
import qna.QnaServiceImp;

@Controller
public class QnaController {
	@Autowired private QnaServiceImp service;
	@Autowired private CommonService common;

	@Autowired private MemberServiceImpl member;
	
	//QnA 목록화면 요청
	@RequestMapping("/list.qa")
	public String list(Model model, HttpSession session) {
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("id", "admin");
		map.put("pw", "manager");
		
		session.setAttribute("login_info", member.member_login(map) );
		session.setAttribute("category", "qa");

		//DB에서 공지글 목록을 조회해와 목록화면에 출력
		model.addAttribute("list", service.qna_list());
		
		return "qna/list";
	}
}
