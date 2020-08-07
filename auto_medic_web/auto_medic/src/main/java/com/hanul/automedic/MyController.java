package com.hanul.automedic;



import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import common.CommonService;
import member.MemberVO;
import my.CalendarVO;
import my.MyServiceImpl;

@Controller
public class MyController {
   @Autowired private MyServiceImpl service;
   @Autowired private CommonService common;
   
   //메인화면으로 가기
   @RequestMapping("/automedic")
   public String gohome(Model model, String member_nickname, MemberVO vo, HttpSession session) {
	   session.setAttribute("info", vo.getMember_nickname());
	   session.removeAttribute("login_info");
	   return "redirect:/";
   }
   
   //상세정보화면으로 가기
   @RequestMapping("/mypage.my")
   public String member(Model model,String member_email, MemberVO vo) {
	   
	   model.addAttribute("vo", service.my_select(member_email));
	   
	   return "my/mypage";
   }  
   
   //바꾸는 과정
    @RequestMapping("/update.my")
   /*attach: 수정화면에서 name이 attach인거 가져오기 */
   public String update( MemberVO vo,String member_email,
		   Model model,HttpSession session, String attach
		   ,MultipartFile file) {
	   //화면에서 입력한 정보를 DB에 변경저장한 후 상세화면으로 연결
	   MemberVO member=service.my_select(member_email);
	  // UUID는 범용 고유 식별자(universally unique identifier)로써,
	  //고유한 값을 생성 
	   String uuid=session.getServletContext()
			   .getRealPath("resources")+member.getMember_profile();
	 
	   
	   //파일을 첨부한 경우-없었는데 새로 첨부   
	   if(!file.isEmpty()) {	 
		   vo.setMember_profile(common.upload("My",file,session));
		   
		    //있던 파일을 바꿔서 첨부	
		   if(member.getMember_profile()!=null) {
			   File f=new File(uuid);
				  if(f.exists())f.delete();
			   
		   }
		 
	   }else { //파일 첨부가 없는 경우- if 없었고, 있었는데 삭제한경우 
		   
		   if(attach.isEmpty()) {
			   File f=new File(uuid);
				  if(f.exists())f.delete();
		   }else {
		    //, else 있었는데 그대로 사용하는 경우
		   vo.setMember_profile(member.getMember_profile());
		   }
	   }
	   member.getMember_nickname();
	   vo.getMember_nickname();
	   service.my_update(vo);
	   //네비게이션 페이지로 갈때 필요한 이메일 넣기
	   model.addAttribute("member_email", member_email);
	   model.addAttribute("url","navigation.my");
		 
		 return "my/redirect"; 
   }

	 //바꾸는 과정	 
	/* @RequestMapping("/update2.my") 
	 public String update( MemberVO vo,String
	 member_email, Model model) {
		 
		 service.my_update2(vo);
		 model.addAttribute("member_email", member_email);
		 model.addAttribute("url","navigation.my");
		 
		 return "my/redirect"; 
		 
	 }*/
	 
	//바꾸는 과정	 
   @ResponseBody @RequestMapping(value="/update2.my",produces="text/html; charset=utf-8") 
		 public String update( MemberVO vo,String member_email,
				 Model model,HttpServletRequest request) {
			 String msg="<script type='text/javascript'>";
			 model.addAttribute("member_email", member_email);
			 if(service.my_update2(vo)==true) {
				 msg+="alert('수정이 완료되었습니다.^^'); location='"
	                     +request.getContextPath() +"'";
			 }else {
				 msg+="alert('수정이 실패되었습니다.'); history.go(-1)";
			 }
			
			
			//model.addAttribute("url","navigation.my");
			 
			 msg+="</script>";
			return msg;
			 
		 }
   //전화번호 바꾸기
   @RequestMapping("/tel.my")
   public String tel(Model model,String member_email, MemberVO vo) {
	   
	   model.addAttribute("vo", service.my_select(member_email));
	   
	   return "my/tel";
   }
   //패스워드 바꾸기
   @RequestMapping("/password.my")
   public String passwrod(Model model,String member_email, MemberVO vo) {
	   
	   model.addAttribute("vo", service.my_select(member_email));
	   return "my/password";
   }
   //목록페이지
   @RequestMapping("/calendar.my")
	public String calender(Model model) {  
	/*List<CalendarVO> list=service.my_calendar2();
	model.addAttribute("list", list);*/
	   return "my/calendar";
   }
   //선택한 날짜의 일정
   @ResponseBody @RequestMapping("/select.calendar.my")
   public List<CalendarVO> select_calender(String day) {  
	   List<CalendarVO> list=service.my_calendar( day);
	   return list;
   }
 	
   @RequestMapping("/navigation.my")
   public String navigation(Model model,String member_email, MemberVO vo) {  
	  
	   model.addAttribute("vo", service.my_select(member_email));
	   
	   return "my/navigation";
   }
   //탈퇴하기
   @RequestMapping("/delete.my")
   public String delete(String member_email,HttpSession session) {  
		service.my_delete(member_email);
		//세션을 지움
		session.invalidate();		
	   return "redirect:/";
   }
}
