package com.hanul.iot;

import java.io.File;
import java.util.HashMap;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import common.CommonService;
import member.MemberServiceImpl;
import member.MemberVO;
import qna.QnaPage;
import qna.QnaServiceImp;
import qna.QnaVO;

@Controller
public class QnaController {
	@Autowired private QnaServiceImp service;
	@Autowired private CommonService common;
	
	//문의글 수정처리 요청
	@RequestMapping("/update.qa")
	public String update(HttpSession session, String attach, QnaVO vo, MultipartFile file) {
		
		//원래 문의글의 첨부파일 관련정보를 조회
		QnaVO qna = service.qna_detail(vo.getId());
		String uuid = session.getServletContext().getRealPath("resources");
		
		//파일을 첨부한 경우 - 없었는데 첨부 / 있던 파일을 바꿔서 첨부
		if( !file.isEmpty() ) {
			vo.setFilename( file.getOriginalFilename());
			vo.setFilepath( common.upload("qna", file, session));
			
			//원래 있던 첨부파일은 서버에서 삭제
			if( qna.getFilename() != null) {
				File f = new File(uuid);
				if( f.exists() ) f.delete();
			}
		} else {
			//원래 있던 첨부파일을 삭제하거나 원래부터 첨부파일이 없었던 경우
			if( attach.isEmpty() ) {
				//원래 있던 첨부파일은 서버에서 삭제
				if( qna.getFilename() != null) {
					File f = new File(uuid);
					if( f.exists() ) f.delete();
				}
			} else {
				//원래 있던 첨부파일을 그대로 사용하는 경우
				vo.setFilename( qna.getFilename() );
				vo.setFilepath( qna.getFilepath() );
			}
			
		}
		
		//화면에서 변경입력한 정보를 DB에 저장한 후 상세화면으로 연결
		service.qna_update(vo);
		return "redirect:detail.qa?id="+vo.getId();
	}
	
	//문의글 수정화면 요청
	@RequestMapping("/modify.qa")
	public String modify(int id, Model model) {
		//선택한 공지글 정보를 DB에서 조회한뒤 수정화면에 출력
		model.addAttribute("vo", service.qna_detail(id));
		return "qna/modify";
	}
	
	//문의글 삭제처리 요청
	@RequestMapping("/delete.qa")
	public String delete(int id, HttpSession session) {
		//선택한 문의글에 첨부된 파일이 있다면 서버의 물리적 영역에서 해당 파일도 삭제한다.
		QnaVO vo = service.qna_detail(id);
		if(vo.getFilepath() != null) {
			File file = new File(session.getServletContext().getRealPath("resources")+vo.getFilepath());
			if ( file.exists() ) file.delete();
		}
		
		//선택한 문의글을 DB에서 삭제한 후 목록화면으로 연결
		service.qna_delete(id);
		return "redirect:list.qa";
	}
	
	//첨부파일 다운로드 요청
	@ResponseBody @RequestMapping("/download.qa")
	public void download(int id, HttpSession session, HttpServletResponse response ) {
		QnaVO vo = service.qna_detail(id);
		common.download(vo.getFilename(), vo.getFilepath(), session, response);
	}
	
	//신규 문의글 상세화면 요청
	@RequestMapping("/detail.qa")
	public String detail(int id, Model model) {
		//선택한 문의글에 대한 조회수 증가 처리
		service.qna_read(id);
		
		//선택한 문의글 정보를 DB에서 조회한 뒤 상세화면에 출력
		model.addAttribute("vo", service.qna_detail(id));
		model.addAttribute("crlf", "\r\n");
		return "qna/detail";
	}
	
	//신규 문의글 저장처리 요청
	@RequestMapping("/insert.qa")
	public String insert(MultipartFile file, QnaVO vo, HttpSession session ) {
		//첨부한 파일을 서버시스템에 업로드 하는 처리
		if( !file.isEmpty()) {
			vo.setFilepath( common.upload("qna", file, session) );
			vo.setFilename( file.getOriginalFilename() );
		}
		
		vo.setWriter( ((MemberVO)session.getAttribute("login_info")).getId() );
		//화면에서 입력한 정보를 DB에 저장한 후
		service.qna_insert(vo);
		//목록화면으로 연결
		return "redirect:list.qa";
		
	}

	//신규 문의글 작성 화면 요청
	@RequestMapping("/new.qa")
	public String qna() {
		return "qna/new";
	}
	
	
	@Autowired private MemberServiceImpl member;
	@Autowired private QnaPage page;
	//QnA 목록화면 요청
	@RequestMapping("/list.qa")
	public String list(Model model, HttpSession session, @RequestParam(defaultValue = "1") int curPage) {//defaultValue = "1": 공지사항 페이지 클릭시 기본이 첫페이지가 되게함 / curPage : 내가 누른 페이지가 됨
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("id", "admin");
		map.put("pw", "manager");
		
		session.setAttribute("login_info", member.member_login(map) );
		session.setAttribute("category", "qa");

		//DB에서 공지글 목록을 조회해와 목록화면에 출력
		page.setCurPage(curPage);	//현재 페이지를 qna 페이지에 담고
		model.addAttribute("page", service.qna_list(page)); //그 주소를 담아둠
		
		return "qna/list";
	}
}
