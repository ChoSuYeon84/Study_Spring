package com.hanul.iot;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import board.BoardPage;
import board.BoardServiceImpl;

@Controller
public class BoardController {
	@Autowired private BoardServiceImpl service;
	@Autowired private BoardPage page;
	
	//방명록 신규 작성 화면 요청
	@RequestMapping("/new.bo")
	public String board() {
		//방명록 글쓰기화면으로 연결
		return "board/new";
	}
	
	//방명록 목록화면 요청
	@RequestMapping("/list.bo")
	public String list(HttpSession session, Model model, @RequestParam(defaultValue = "1") int curPage, String search, String keyword) {
		//DB에서 방명록 정보를 조회해와 목록화면에 출력
		session.setAttribute("category", "bo");
		page.setCurPage(curPage);
		page.setSearch(search);
		page.setKeyword(keyword);
		model.addAttribute("page", service.board_list(page));
		
		return "board/list";
	}
}
