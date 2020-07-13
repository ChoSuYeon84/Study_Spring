package com.hanul.iot;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import common.CommonService;
import member.MemberServiceImpl;
import member.MemberVO;
import notice.NoticeServiceImpl;
import notice.NoticeVO;

@Controller
public class NoticeController {
	@Autowired private NoticeServiceImpl service;
	@Autowired private CommonService common;
	
	
	
	//신규 공지글 저장처리 요청
	@RequestMapping("/insert.no")
	public String insert( MultipartFile file, NoticeVO vo, HttpSession session ) {	//name이 file인 정보가 멀티파트에 담기게 된다 (MultipartFile file)
		//첨부한 파일을 서버시스템에 업로드하는 처리
		if( !file.isEmpty()) {
			vo.setFilepath( common.upload("notice", file, session) );
			vo.setFilename( file.getOriginalFilename() );
		}
		
		vo.setWriter( ((MemberVO)session.getAttribute("login_info")).getId() );
		//화면에서 입력한 정보를 DB에 저장한 후
		service.notice_insert(vo);
		//목록화면으로 연결
		return "redirect:list.no";
	}
	
	//신규 공지글 작성 화면 요청
	@RequestMapping("/new.no")
	public String notice() {
		return "notice/new";
	}
	
	@Autowired private MemberServiceImpl member;
	
	//공지사항 목록화면 요청
	@RequestMapping("/list.no")
	public String list(Model model, HttpSession session) {
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("id", "admin");
		map.put("pw", "manager");
		session.setAttribute("login_info", member.member_login(map) );
		session.setAttribute("category", "no");
		
		//DB에서 공지글 목록을 조회해와 목록화면에 출력
		model.addAttribute("list", service.notice_list());
		
		return "notice/list";
	}
}
