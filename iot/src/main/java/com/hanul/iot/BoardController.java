package com.hanul.iot;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import board.BoardPage;
import board.BoardServiceImpl;
import board.BoardVO;
import common.CommonService;
import member.MemberVO;

@Controller
public class BoardController {
	@Autowired private BoardServiceImpl service;
	@Autowired private BoardPage page;
	@Autowired private CommonService common;
	
	//방명록 상세 화면 요청
	@RequestMapping("/detail.bo")
	public String detail() {
		//선택한 방명록 글을 DB에서 조회해와 상세 화면에 출력
		return "board/detail";
	}
	
	//신규방명록 저장처리 요청
	@RequestMapping("/insert.bo")
	public String insert(BoardVO vo, MultipartFile file, HttpSession session) {
		//화면에서 입력한 정보를 DB에 저장한 후 목록화면으로 연결
		if( !file.isEmpty() ) {
			vo.setFilename( file.getOriginalFilename() );
			vo.setFilepath( common.upload("board", file, session));
		}
		
		vo.setWriter( ((MemberVO)session.getAttribute("login_info")).getId() );
		service.board_insert(vo);
		return "redirect:list.bo";
	}
	
	//방명록 신규 작성 화면 요청
	@RequestMapping("/new.bo")
	public String board() {
		//방명록 글쓰기화면으로 연결
		return "board/new";
	}
	
	//방명록 목록화면 요청
	@RequestMapping("/list.bo")
	public String list(HttpSession session, Model model, @RequestParam(defaultValue = "1") int curPage, 
			String search, String keyword, @RequestParam(defaultValue = "list") String viewType,
			@RequestParam(defaultValue = "10") int pageList) {
		//DB에서 방명록 정보를 조회해와 목록화면에 출력
		session.setAttribute("category", "bo");
		page.setCurPage(curPage);
		page.setSearch(search);
		page.setKeyword(keyword);
		page.setViewType(viewType);
		page.setPageList(pageList);
		model.addAttribute("page", service.board_list(page));
		
		return "board/list";
	}
}
