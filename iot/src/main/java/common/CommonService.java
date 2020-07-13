package common;

import java.io.File;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.apache.commons.mail.EmailAttachment;
import org.apache.commons.mail.HtmlEmail;
import org.apache.commons.mail.MultiPartEmail;
import org.apache.commons.mail.SimpleEmail;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Service
public class CommonService {
	//첨부파일업로드처리
	public String upload(String category, MultipartFile file, HttpSession session) {
		//서버의 업로드할 물리적 위치
		//workspace/.metadata/...../wtpwebapps/iot/resources(D:\Study_Web\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\iot\resources)
		String resources = session.getServletContext().getRealPath("resources");
		String upload = resources + "/upload";
		
		//업로드할 파일의 형태 : .../upload/notice/2020/07/13/abc.txt
		String folder = upload + "/" + category + "/" + new SimpleDateFormat("yyyy/MM/dd").format(new Date());
		//폴더가 없다면 폴더를 생성
		File f = new File(folder);
		if( !f.exists() ) f.mkdirs();
		
		//동시다발적 동일명의 파일업로드를 위한 고유ID 부여: afd324adfa
		String uuid = UUID.randomUUID().toString() + "_" + file.getOriginalFilename();
		try {
			file.transferTo( new File(folder, uuid));
			
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		// /upload/ ... / afafd_abc.txt
		// return folder.replace(resources, "")+ "/" + uuid; 또는 아래처럼 사용가능
		return folder.substring(resources.length()) + "/" + uuid;
		
	}
	
	
	//이메일전송처리
	public void sendEmail(HttpSession session, String email, String name) {
		//1. 기본 이메일 전송 처리
		//sendSimple(email, name);
		
		//2.첨부파일있는 이메일 전송처리
		//sendAttach(session, email, name);
		
		//3.HTML 태그 이메일 전송처리
		sendHtml(session, email, name);
	}
	
	private void sendHtml(HttpSession session, String email, String name) {
		HtmlEmail mail = new HtmlEmail();
		
		mail.setHostName("smtp.naver.com");	//메일전송서버 지정
		mail.setCharset("utf-8");	//인코딩지정
		mail.setDebug(true);	//콘솔에 메일을 보내는 과정이 쭉 나옴 (메일전송과정 로그 확인)
		
		mail.setAuthentication("suyeoniz", "네이버비번");
		mail.setSSLOnConnect(true);
		
		try {
			mail.setFrom("suyeoniz@naver.com", "한울관리자");
			mail.addTo(email, name);
			
			mail.setSubject("한울 IOT과정-HTML");
			
			StringBuffer msg = new StringBuffer();
			msg.append("<html>");
			msg.append("<body>");
			msg.append("<a href='https://mvnrepository.com/'><img src='https://postfiles.pstatic.net/20160330_218/misstake99_1459336967494zLW3o_JPEG/%BE%C6%B8%DE%B8%AE%C4%AB%B3%EB1.jpg?type=w2'></a>");
			msg.append("<hr>");
			msg.append("<h3>한울 IOT과정 가입축하</h3>");
			msg.append("<p>가입을 축하합니다.</p>");
			msg.append("</body>");
			msg.append("</html>");
			mail.setHtmlMsg(msg.toString());	//내용을 문자화 시킴
			
			EmailAttachment file = new EmailAttachment();
			file.setPath(session.getServletContext().getRealPath("resources/css/common.css"));
			mail.attach(file);
			
			file = new EmailAttachment();
			file.setURL(new URL("https://lh3.googleusercontent.com/proxy/G6eAv2iqvqhjTOaMI4Og3cavWiF_Jr-K5YrF7VQaJmw9qHeD7QPUH1l7BpUxhA73WUcPfVOPalyEybIxS-zk6sETnARjPU6SWmQgyW3Gg-jbL6Tr8JH7YxtvuZw9WwGTvSGbG-wIyGr8pF4uQnUCO1PfPIeOfkSG7aJ4uNZw5xof2WAKjug"));
			mail.attach(file);
			
			//메일보내기
			mail.send();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		
	}
	
	private void sendAttach(HttpSession session, String email, String name) {
		MultiPartEmail mail = new MultiPartEmail();
		
		mail.setHostName("smtp.naver.com");	//메일전송서버 지정
		mail.setCharset("utf-8");	//인코딩지정
		mail.setDebug(true);	//콘솔에 메일을 보내는 과정이 쭉 나옴 (메일전송과정 로그 확인)
		
		mail.setAuthentication("suyeoniz", "네이버비번");
		mail.setSSLOnConnect(true);
		
		try {
			mail.setFrom("suyeoniz@naver.com", "오토메딕관리자");	//메일송신자
			mail.addTo(email, name);	//메일수신자
			
			mail.setSubject("한울 IOT과정-첨부파일");
			mail.setMsg("한울 IOT과정 가입 축하! 첨부파일 확인 요망!");
			
			//파일 첨부하기
			EmailAttachment file = new EmailAttachment();
			
			//물리적 디스크내 파일 첨부
			file.setPath("D:\\2차원 배열.png");
			mail.attach(file);
			
			//프로젝트 내의 파일첨부
			file = new EmailAttachment();
			file.setPath(session.getServletContext().getRealPath("resources/images/hanul.logo.png"));
			mail.attach(file);
			
			//URL을 통해 파일첨부
			file = new EmailAttachment();
			file.setURL(new URL("https://postfiles.pstatic.net/20160330_218/misstake99_1459336967494zLW3o_JPEG/%BE%C6%B8%DE%B8%AE%C4%AB%B3%EB1.jpg?type=w2"));
			mail.attach(file);
			
			//메일보내기
			mail.send();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
	}
	
	private void sendSimple(String email, String name) {
		SimpleEmail mail = new SimpleEmail();
		mail.setCharset("utf-8");	//인코딩지정
		mail.setDebug(true);	//콘솔에 메일을 보내는 과정이 쭉 나옴 (메일전송과정 로그 확인)
		
		mail.setHostName("smtp.naver.com");	//메일전송서버 지정 (smtp넣어줄것)
		
		mail.setAuthentication("suyeoniz", "네이버비번");	//해당 사이트의 아이디와 비번 지정
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
