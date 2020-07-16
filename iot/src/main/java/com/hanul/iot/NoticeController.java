package com.hanul.iot;

import java.io.File;
import java.util.HashMap;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.swing.filechooser.FileNameExtensionFilter;

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
import notice.NoticePage;
import notice.NoticeServiceImpl;
import notice.NoticeVO;

@Controller
public class NoticeController {
	@Autowired private NoticeServiceImpl service;
	@Autowired private CommonService common;
	
	//공지글 신규답글저장 처리요청
	@RequestMapping("/reply_insert.no")
	public String reply_insert(NoticeVO vo, MultipartFile file, HttpSession session) {
		if( !file.isEmpty()) {
			vo.setFilename(file.getOriginalFilename());
			vo.setFilepath(common.upload("notice", file, session));
		}
		
		vo.setWriter( ((MemberVO) session.getAttribute("login_info")).getId() );
		
		//화면에서 입력한 정보를 DB에 저장한 후 목록화면으로 연결
		service.notice_reply_insert(vo);
		return "redirect:list.no";
	}
	
	
	//공지글 답글쓰기 화면 요청
	@RequestMapping("/reply.no")
	public String reply(Model model, int id) {
		//원글의 정보를 답글쓰기 화면에서 알 수 있도록 한다.
		model.addAttribute("vo", service.notice_detail(id));
		return "notice/reply";
	}
	
	//공지글 수정처리 요청
	@RequestMapping("/update.no")
	public String update(HttpSession session, String attach, NoticeVO vo, MultipartFile file) {
		
		//원래 공지글의 첨부파일 관련정보를 조회
		NoticeVO notice = service.notice_detail(vo.getId());
		String uuid = session.getServletContext().getRealPath("resources") + notice.getFilepath();
		
		//파일을 첨부한 경우 - 없었는데 첨부 / 있던 파일을 바꿔서 첨부
		if( !file.isEmpty() ) {
			vo.setFilename( file.getOriginalFilename() );
			vo.setFilepath( common.upload("notice", file, session));
			
			//원래 있던 첨부파일은 서버에서 삭제
			if( notice.getFilename() != null ) {
				File f = new File(uuid);
				if( f.exists() ) f.delete();
			}
			
		}else {
			//원래 있던 첨부파일을 삭제하거나 원래부터 첨부파일이 없었던 경우
			if( attach.isEmpty() ) {
				//원래 있던 첨부파일은 서버에서 삭제
				if( notice.getFilename() != null ) {
					File f = new File(uuid);
					if( f.exists() ) f.delete();
				}	
			}else {
			//원래있던 첨부파일을 그대로 사용하는 경우
				vo.setFilename( notice.getFilename() );
				vo.setFilepath( notice.getFilepath() );
			}
		}
		
		//화면에서 변경입력한 정보를 DB에 저장한 후 상세화면으로 연결
			service.notice_update(vo);
		return "redirect:detail.no?id="+vo.getId();
	}
	
	//공지글 수정화면 요청
	@RequestMapping("/modify.no")
	public String medify(int id, Model model) {
		//선택한 공지글 정보를 DB에서 조회한뒤 수정화면에 출력
		model.addAttribute("vo", service.notice_detail(id));
		return "notice/modify";
	}
	
	//공지글 삭제처리 요청
	@RequestMapping("/delete.no")
	public String delete(int id, HttpSession session) {
		//선택한 공지글에 첨부된 파일이 있다면 서버의 물리적 영역에서 해당 파일도 삭제한다.
		NoticeVO vo = service.notice_detail(id);
		if( vo.getFilepath() != null) {
			File file = new File(session.getServletContext().getRealPath("resources")+vo.getFilepath());
			if ( file.exists() ) file.delete();
		}
		
		//선택한 공지글을 DB에서 삭제한 후 목록화면으로 연결
		service.notice_delete(id);
		return "redirect:list.no";
	}
	
	//첨부파일 다운로드 요청
	@ResponseBody @RequestMapping("/download.no")
	public void download(int id, HttpSession session, HttpServletResponse response) {
		NoticeVO vo = service.notice_detail(id);
		common.download(vo.getFilename(), vo.getFilepath(), session, response);
	}
	
	//공지글 상세화면 요청
	@RequestMapping("/detail.no")
	public String detail(int id, Model model) {
		//선택한 공지글에 대한 조회수 증가 처리
		service.notice_read(id);
		//선택한 공지글 정보를 DB에서 조회한뒤 상세화면에 출력
		model.addAttribute("vo", service.notice_detail(id));
		model.addAttribute("crlf", "\r\n");
		return "notice/detail";
	}
	
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
	@Autowired private NoticePage page;
	
	//공지사항 목록화면 요청
	@RequestMapping("/list.no")
	public String list(Model model, HttpSession session, @RequestParam(defaultValue = "1") int curPage) {	//defaultValue = "1": 공지사항 페이지 클릭시 기본이 첫페이지가 되게함 / curPage : 내가 누른 페이지가 됨
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("id", "admin");
		map.put("pw", "manager");
		session.setAttribute("login_info", member.member_login(map) );
		session.setAttribute("category", "no");
		
		//DB에서 공지글 목록을 조회해와 목록화면에 출력
		page.setCurPage(curPage);	//현재 페이지를 notice 페이지에 담고
		model.addAttribute("page", service.notice_list(page)); //그 주소를 담아둠
		
		return "notice/list";
	}
}
