package com.hanul.automedic;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Random;

import javax.inject.Inject;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailSender;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import member.MemberServiceImpl;
import member.MemberVO;

@Controller
public class MemberController {
	@Autowired private MemberServiceImpl service;
	@Autowired private JavaMailSender MailSender;
	
	//메일 전송
	@RequestMapping(value = "/send_email", method=RequestMethod.POST)
	public ModelAndView sendMail(HttpServletRequest request, String e_mail, HttpServletResponse response_email) throws IOException {
		
		Random r = new Random();
        int dice = r.nextInt(4589362) + 49311; //이메일로 받는 인증코드 부분 (난수)
        
        String setfrom = "automedic0724@gamil.com";
        String tomail = request.getParameter("e_mail"); // 받는 사람 이메일
        String title = "회원가입 인증 이메일 입니다."; // 제목
        String content =
                        
                " 오토메딕 회원가입 인증번호는 " +dice+ " 입니다. "
                +System.getProperty("line.separator")+ //한줄씩 줄간격을 두기위해 작성
                System.getProperty("line.separator")+
                
                "받으신 인증번호를 홈페이지에 입력해 주세요!"; // 내용
		
        try {
            MimeMessage message = MailSender.createMimeMessage();
            MimeMessageHelper messageHelper = new MimeMessageHelper(message,
                    true, "UTF-8");

            messageHelper.setFrom(setfrom); // 보내는사람 생략하면 정상작동을 안함
            messageHelper.setTo(tomail); // 받는사람 이메일
            messageHelper.setSubject(title); // 메일제목은 생략이 가능하다
            messageHelper.setText(content); // 메일 내용
            
            MailSender.send(message);
        } catch (Exception e) {
            System.out.println(e);
        }
        
        ModelAndView mv = new ModelAndView();    //ModelAndView로 보낼 페이지를 지정하고, 보낼 값을 지정한다.
        mv.setViewName("/member/join");     //뷰의이름
        mv.addObject("dice", dice);
        
        System.out.println("mv : "+mv);

        response_email.setContentType("text/html; charset=UTF-8");
        PrintWriter out_email = response_email.getWriter();
        out_email.println("<script>alert('이메일이 발송되었습니다. 인증번호를 입력해주세요.');</script>");
        out_email.flush();
        
        return mv;
	}

	//닉네임 중복확인 요청
		@ResponseBody @RequestMapping("/nickname_check")
		public boolean nickname_check(String nickname) {
			return service.member_nick_check(nickname);
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
	public String login( String id, String pw, HttpSession session) {
		//public String login( @RequestParam("id")  String member_email, @RequestParam("pw") String member_password, HttpSession session) {
		//화면에서 입력한 아이디와 비밀번호가 
		//일치하는 회원정보가 DB에 있는지 확인하여
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("member_email",  id);
		map.put("member_password", pw);
		MemberVO vo = service.member_login(map);
		//일치하는 회원정보가 있다면 회원정보를 세션에 담는다
		session.setAttribute("login_info", vo);
		return vo == null ? "false" : "true";
	}
}
