package com.hanul.automedic;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import member.MemberVO;
import my.MyServiceImpl;

@Controller
public class MyController {
   @Autowired private MyServiceImpl service;
   
 //상세정보화면으로 가기
   @RequestMapping("/mypage.my")
   public String member(Model model,String member_email, MemberVO vo) {
	   
	   model.addAttribute("vo", service.my_select(member_email));
	   return "my/mypage";
   }
   @RequestMapping("/navigation.my")
   public String navigation() {  
	  
	   return "my/navigation";
   }
   @RequestMapping("/delete.my")
   public String delete(String member_email) {  
		  
	   return "redirect:automedic";
   }
}
