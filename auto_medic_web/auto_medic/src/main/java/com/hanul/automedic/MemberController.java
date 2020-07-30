package com.hanul.automedic;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;
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
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
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
	
	//회원가입처리 요청
		@ResponseBody @RequestMapping(value="/join", produces="text/html; charset=utf-8")	//산출물(produces)에 대한 캐릭터 셋을 설정
		public String join(HttpSession session, MemberVO vo, HttpServletRequest request) {
			String msg = "<script type = 'text/javascript'>";
			//화면에서 입력한 정보를 DB에 저장한 후 홈화면으로 연결
			if( service.member_insert(vo) ) {
				msg += "alert('회원가입을 축하드립니다! 로그인을 진행해주세요!'); location='"+ request.getContextPath() +"'";
				
			}else {
				msg += "alert('회원가입에 실패하였습니다. 다시한번 시도해주세요!'); history.go(-1)"; 
				
			}
			msg += "</script>";
			return msg;
		}
	
	//비밀번호 이메일 전송
	@RequestMapping("/send_pw")
	public String send_pw (@RequestParam("userMail") String email, HttpServletResponse response_email) throws IOException {
		System.out.println(email);
		//고객이 요청한 메일주소가 DB에 존재하는지 확인한뒤
		boolean exist = service.member_id_check(email) ;
		System.out.println(exist);
		
		//메일주소가 존재한다면 DB에서 비밀번호를 조회해와 메일을 전송함
		if ( !exist ) {
			System.out.println(email);
			
			String setfrom = "automedic0724@gamil.com";
			String title = "오토메딕 - 임시비밀번호를 확인해주세요!"; // 제목
			String newCode = EmailCode();
			String content =

					" 오토메딕  임시비밀번호는 " + newCode + " 입니다. " + System.getProperty("line.separator") + // 한줄씩 줄간격을 두기위해 작성
							System.getProperty("line.separator") +

							"해당 번호로 로그인을 한뒤, 비밀번호를 변경해주세요!"; // 내용

			try {
				MimeMessage message = MailSender.createMimeMessage();
				MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");

				messageHelper.setFrom(setfrom); // 보내는사람 생략하면 정상작동을 안함
				messageHelper.setTo(email); // 받는사람 이메일
				messageHelper.setSubject(title); // 메일제목은 생략이 가능하다
				messageHelper.setText(content); // 메일 내용

				MailSender.send(message);
			} catch (Exception e) {
				System.out.println(e);
			}
			
			MemberVO vo = new MemberVO();
			vo.setMember_email(email);
			vo.setMember_password(newCode);
			service.member_pw_update(vo);
		}
		return "redirect:/";
	}
	
	//비밀번호찾기시 이메일 존재여부 확인
	@ResponseBody @RequestMapping("/userMail_chk")
	public boolean userMail_check(@RequestParam("userMail") String member_email) {
		return service.member_email_chk(member_email);
	}
	
	//비밀번호 찾기 요청
	@RequestMapping("/findPw")
	public String findPw() {
		return "member/findPw";
	}
	
	//닉네임 중복확인 요청
		@ResponseBody @RequestMapping("/nickname_check")
		public boolean nickname_check(String member_nickname) {
			return service.member_nick_check(member_nickname);
		}
	
	//아이디 중복확인 요청
		@ResponseBody @RequestMapping("/id_check")
		public int id_check(String member_email, HttpSession session,  HttpServletRequest request, HttpServletResponse response_email) throws Exception{
			boolean exist = service.member_id_check(member_email) ;
			//멤버id가 존재하지 않는다면(사용가능한 id면) 인증번호 메일전송
			int authNo = -1;
			if( exist ) {
//				session.setAttribute("authNo", sendMail( id, response_email) );
				authNo = sendMail( member_email, response_email) ;
			}
			return authNo;
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
	
	//인증번호메일 전송
	public int sendMail(String toMail, HttpServletResponse response_email) throws IOException {

		Random r = new Random();
		int dice = r.nextInt(4589362) + 49311; // 이메일로 받는 인증코드 부분 (난수)

		String setfrom = "automedic0724@gamil.com";
		String title = "오토메딕 - 이메일 인증을 진행해 주세요!"; // 제목
		String content =

				" 오토메딕 회원가입 인증번호는 " + dice + " 입니다. " + System.getProperty("line.separator") + // 한줄씩 줄간격을 두기위해 작성
						System.getProperty("line.separator") +

						"받으신 인증번호를 홈페이지에 입력해 주세요!"; // 내용

		try {
			MimeMessage message = MailSender.createMimeMessage();
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");

			messageHelper.setFrom(setfrom); // 보내는사람 생략하면 정상작동을 안함
			messageHelper.setTo(toMail); // 받는사람 이메일
			messageHelper.setSubject(title); // 메일제목은 생략이 가능하다
			messageHelper.setText(content); // 메일 내용

			MailSender.send(message);
		} catch (Exception e) {
			System.out.println(e);
		}
		return dice;
	}
	
	public String EmailCode() { //이메일 인증코드 생성
        String[] str = {"a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s",
                "t", "u", "v", "w", "x", "y", "z", "1", "2", "3", "4", "5", "6", "7", "8", "9"};
        String newCode = new String();

        for (int x = 0; x < 8; x++) {
            int random = (int) (Math.random() * str.length);
            newCode += str[random];
        }

        return newCode;
    }
	
	
	
}
