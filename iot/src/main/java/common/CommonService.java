package common;

import org.apache.commons.mail.MultiPartEmail;
import org.apache.commons.mail.SimpleEmail;
import org.springframework.stereotype.Service;

@Service
public class CommonService {
	public void sendEmail(String email, String name) {
		//1. 기본 이메일 전송 처리
		//sendSimple(email, name);
		
		//2.첨부파일있는 이메일 전송처리
		sendAttach(email, name);
	}
	private void sendAttach(String email, String name) {
		MultiPartEmail mail = new MultiPartEmail();
		
		mail.setHostName("smtp.naver.com");	//메일전송서버 지정
		mail.setCharset("utf-8");	//인코딩지정
		mail.setSSLOnConnect(true);	//로그인 하기위한 연결을 요청
		
		mail.setAuthentication("내네이버아이디", "내네이버비번");
		mail.setSSLOnConnect(true);
		
		try {
			mail.setFrom("suyeoniz@naver.com", "오토메딕관리자");
			mail.addTo(email, name);
			
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
	}
	
	private void sendSimple(String email, String name) {
		SimpleEmail mail = new SimpleEmail();
		mail.setCharset("utf-8");	//인코딩지정
		mail.setDebug(true);	//콘솔에 메일을 보내는 과정이 쭉 나옴 (메일전송과정 로그 확인)
		
		mail.setHostName("smtp.naver.com");	//메일전송서버 지정 (smtp넣어줄것)
		
		mail.setAuthentication("내네이버아이디", "내네이버비번");	//해당 사이트의 아이디와 비번 지정
		mail.setSSLOnConnect(true);	//로그인 하기위한 연결을 요청
		
		try {
			mail.setFrom("suyeoniz@naver.com", "오토메딕관리자");	//메일송신자
			mail.addTo(email, name);	//메일수신자
			
			mail.setSubject("한울 IOT과정");	//메일제목
			mail.setMsg(name+"님! IOT과정 회원가입을 축하합니다!");
			mail.send();	//메일 발송버튼 클릭
			
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
	}
}
