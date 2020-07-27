package mailing;

import javax.servlet.http.HttpSession;

import org.apache.commons.mail.SimpleEmail;
import org.springframework.stereotype.Service;

@Service
public class MailingService {
	
	//이메일전송처리
	public void sendEmail(HttpSession session, String email) {
		sendSimple(email);
	}
	
	private void sendSimple(String email) {
		SimpleEmail mail = new SimpleEmail();
		mail.setCharset("utf-8");	//인코딩지정
		mail.setDebug(true);	//콘솔에 메일을 보내는 과정이 쭉 나옴 (메일전송과정 로그 확인)
		
		mail.setHostName("smtp.gmail.com");	//메일전송서버 지정 (smtp넣어줄것)
		
		mail.setAuthentication("automedic0724", "gksdnf123");	//해당 사이트의 아이디와 비번 지정
		mail.setSSLOnConnect(true);	//로그인 하기위한 연결을 요청
		
		try {
			mail.setFrom("automedic0724@gmail.com", "오토메딕관리자");	//메일송신자
			mail.addTo(email);	//메일수신자
			
			mail.setSubject("오토메딕");	//메일제목
			mail.setMsg("IOT과정 회원가입을 축하합니다!");
			mail.send();	//메일 발송버튼 클릭
			
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
	}	

}
