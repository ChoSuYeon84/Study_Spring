package com.hanul.iot;

import java.io.File;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
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
	
	//방명록 삭제처리 요청
	@RequestMapping("/delete.bo")
	public String delete(int id, Model model) {
		//선택한 방명록 글을 DB에서 삭제한 후 목록화면으로 연결
		service.board_delete(id);
		model.addAttribute("url", "list.bo");
		model.addAttribute("id", id);
		model.addAttribute("page", page);
		
		return "board/redirect";
	}
	
	//방명록 수정처리 요청
	@RequestMapping("/update.bo")
	public String update(BoardVO vo, MultipartFile file, HttpSession session, String attach, Model model) {
		//화면에서 입력한 정보를 DB에 변경저장한 후 상세화면으로 연결
		BoardVO board = service.board_detail(vo.getId());
		String uuid = session.getServletContext().getRealPath("resources") + board.getFilepath();
		//파일을 첨부한 경우 - 없었는데 새로 첨부, 있었는데 바꿔 첨부
		if (! file.isEmpty()) {
			vo.setFilename(file.getOriginalFilename());
			vo.setFilepath(common.upload("board", file, session));
			
			if( board.getFilename() != null) {
				File f = new File(uuid);
				if( f.exists() ) f.delete();
			}
		} else {
		//파일 첨부가 없는 경우 - if원래 없었고, 있었는데 삭제한 경우, else있었는데 그대로 사용하는경우
			if( attach.isEmpty() ) {
				if( board.getFilename() != null) { // 파일이 존재하면 삭제
					File f = new File(uuid);
					if( f.exists() ) f.delete();
				}
			} else {
				vo.setFilename(board.getFilename());
				vo.setFilepath(board.getFilepath());
			}
		}
		service.board_update(vo);
		
		//return "redirect:detail.bo?id="+vo.getId();
		model.addAttribute("url", "detail.bo");
		model.addAttribute("id", vo.getId());
		return "board/redirect";
	}
	
	//방명록 수정화면 요청
	@RequestMapping("/modify.bo")
	public String modify(int id, Model model) {
		//선택한 방명록 글의 정보를 DB에서 조회해와 수정화면에 출력
		model.addAttribute( "vo", service.board_detail(id) ); 
		return "board/modify";
	}
	
	//방명록 첨부파일 다운로드 요청
	@ResponseBody @RequestMapping("/download.bo")
	public void download(int id, HttpSession session, HttpServletResponse response) {
		//해당 글의 첨부파일 정보를 조회해와 다운로드 한다.
		BoardVO vo = service.board_detail(id);
		common.download(vo.getFilename(), vo.getFilepath(), session, response);
	}
	
	//방명록 상세 화면 요청
	@RequestMapping("/detail.bo")
	public String detail(int id, Model model) {
		//선택한 방명록 글을 DB에서 조회해와 상세 화면에 출력
		service.board_read(id);
		model.addAttribute("vo", service.board_detail(id));
		model.addAttribute("page", page);
		model.addAttribute("crlf", "\r\n"); /* 캐리지리턴라인피드 */
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
