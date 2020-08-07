package common;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.mail.EmailAttachment;
import org.apache.commons.mail.HtmlEmail;
import org.apache.commons.mail.MultiPartEmail;
import org.apache.commons.mail.SimpleEmail;
import org.json.JSONObject;
import org.json.XML;
import org.springframework.stereotype.Service;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

@Service
public class CommonService {

	public String json_list(StringBuilder url) {
		System.out.println("여기 들어왔냐용?");
		
		/*String result = xml_list(url);
		 * org.json.JSONObject xmlJSONObj = XML.toJSONObject(result); String
		 * xmlJSONObjString = xmlJSONObj.toString(); //=> xmlJSONObjString 는 xml를
		 * json형태로 변환한 것을 말한다.
		 */		
		JSONObject json = null;
		try {
			System.out.println("try들어옴");
			
//			json = (JSONObject)new JSONParser().parse( xml_list(url) );
			json = XML.toJSONObject(xml_list(url) );
			//System.out.println("try들어옴2 : "+json);
			json = (JSONObject)json.get("response");
			json = (JSONObject)json.get("body");
			//items 가 데이터를 갖고 있어서 JSONObject 타입으로 형변환가능한 경우만
			int count 
			= json.get("totalCount")==null ? 0 : 
				Integer.parseInt(json.get("totalCount").toString());
			if( json.get("items") instanceof JSONObject) {
				json = (JSONObject)json.get("items");
			}
			json.put("count", count);
			System.out.println("트라이마지막문");
		}catch(Exception e) {
			System.out.println(e.getMessage());
		}
		System.out.println(json.toString());
//		return  json.toJSONString();
		return  json.toString();
	}
	
	//공공데이터 REST API 요청처리
	public String xml_list(StringBuilder url) {
		String result = url.toString();
		try {
			HttpURLConnection conn = (HttpURLConnection)new URL(result).openConnection();
			conn.setRequestMethod("GET");
			conn.setRequestProperty("content-type", "application/json");
			  BufferedReader rd;
		        if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
		            rd = new BufferedReader(new InputStreamReader(conn.getInputStream(), "utf-8"));
		        } else {
		            rd = new BufferedReader(new InputStreamReader(conn.getErrorStream(), "utf-8"));
		        }
		        StringBuilder sb = new StringBuilder();
		        String line;
		        while ((line = rd.readLine()) != null) {
		            sb.append(line);
		        }
		        rd.close();
		        conn.disconnect();
		        
		        result = sb.toString();
		       // System.out.println(result);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return result;
	}
	
	//첨부파일 다운로드처리
	public File download(String filename, String filepath
							, HttpSession session
							, HttpServletResponse response) {
		File file = new File( session.getServletContext()
					.getRealPath("resources") + filepath );
		String mime 
			= session.getServletContext().getMimeType(filename);
		
		response.setContentType(mime);
		
		try {
		
			filename = URLEncoder.encode(filename, "utf-8")
								.replaceAll("\\+", "%20");
			response.setHeader("content-disposition"
						, "attachment; filename="+ filename );
			
			ServletOutputStream out = response.getOutputStream();
			FileCopyUtils.copy( new FileInputStream(file), out);
			out.flush();
			
		}catch(Exception e) {
			System.out.println(e.getMessage());
		}
		return file;
	}
			
	//첨부파일 업로드처리
	public String upload(String category, MultipartFile file, HttpSession session) {
		//서버의 업로드할 물리적 위치
		//workspace/.metadata/....../wtpwebapps/iot/resources
		String resources 
		= session.getServletContext().getRealPath("resources");
		String upload = resources + "/upload";
		
		//업로드할 파일의 형태: .../upload/notice/2020/07/13/abc.txt
		String folder = upload + "/"+ category + "/"
				+ new SimpleDateFormat("yyyy/MM/dd").format(new Date());
		//폴더가 없다면 폴더를 생성
		File f = new File(folder);
		if( !f.exists() ) f.mkdirs();
		
		//동시다발적 동일명의 파일업로드를 위한 고유ID 부여: afd324adfa_abc.txt
		String uuid = UUID.randomUUID().toString() 
						+ "_" + file.getOriginalFilename();
		try {
			file.transferTo( new File(folder, uuid) );
		
		}catch(Exception e) {
			System.out.println(e.getMessage());
		}
		
		// /upload/ .../ afafd_abc.txt
		// folder.replace(resources, "")
		return folder.substring(resources.length()) + "/" + uuid;
	}
		
	//이메일전송처리
	public void sendEmail(HttpSession session, String email, String name) {
		//1.기본이메일전송처리
		//sendSimple(email, name);
		
		//2.첨부파일있는 이메일전송처리
		sendAttach(session, email, name);
		
		//3.HTML 태그 이메일전송처리
		sendHtml(session, email, name);
	}
	
	private void sendHtml(HttpSession session, String email, String name) {
		HtmlEmail mail = new HtmlEmail();
		mail.setHostName("smtp.naver.com");//메일전송서버지정
		mail.setCharset("utf-8");
		mail.setDebug(true);//메일전송과정 로그확인
		
		mail.setAuthentication("ojink2", "1234");
		mail.setSSLOnConnect(true);
		
		try {
			mail.setFrom("ojink2@naver.com", "한울관리자");
			mail.addTo(email, name);
			
			mail.setSubject("한울 IoT과정-HTML");
			
			StringBuffer msg = new StringBuffer();
			msg.append("<html>");
			msg.append("<body>");
			msg.append("<a href='https://mvnrepository.com/'><img src='https://mvnrepository.com/assets/images/392dffac024b9632664e6f2c0cac6fe5-logo.png' /></a>");
			msg.append("<hr>");
			msg.append("<h3>한울 IoT과정 가입축하</h3>");
			msg.append("<p>가입을 축하합니다</p>");
			msg.append("<p>프로젝트까지 마무리하고 취업에 성공하시길 바랍니다~</p>");
			msg.append("</body>");
			msg.append("</html>");
			mail.setHtmlMsg(msg.toString());
			
			EmailAttachment file = new EmailAttachment();
			file.setPath(session.getServletContext()
					.getRealPath("resources/css/common.css"));
			mail.attach(file);
			
			file = new EmailAttachment();
			file.setURL(new URL("https://www.google.co.kr/images/branding/googlelogo/1x/googlelogo_color_272x92dp.png"));
			mail.attach(file);
			
			mail.send();
			
		}catch(Exception e) {
			System.out.println(e.getMessage());
		}
	}
	
	private void sendAttach(HttpSession session, String email, String name) {
		MultiPartEmail mail = new MultiPartEmail();
		mail.setHostName("smtp.naver.com");//메일전송서버지정
		mail.setCharset("utf-8");
		mail.setDebug(true);//메일전송과정 로그확인
		
		mail.setAuthentication("ojink2", "1234");
		mail.setSSLOnConnect(true);
		
		try {
			mail.setFrom("ojink2@naver.com", "한울관리자");//메일송신자
			mail.addTo(email,name);//메일수신자
			
			mail.setSubject("한울 IoT과정-첨부파일");
			mail.setMsg("한울 IoT과정 가입 축하! 첨부파일 확인 요망!");
			
			//파일첨부하기
			
			EmailAttachment file = new EmailAttachment();
			//물리적 디스크내  파일첨부
			file.setPath("D:\\좌석배치도(20200306).xlsx");
			mail.attach(file);
			
			//프로젝트 내의 파일첨부
			file = new EmailAttachment();
			file.setPath(session.getServletContext()
							.getRealPath("resources/images/hanul.logo.png"));
			mail.attach(file);

			//URL을 통해 파일첨부
			file = new EmailAttachment();
			file.setURL( new URL("https://mvnrepository.com/assets/images/392dffac024b9632664e6f2c0cac6fe5-logo.png") );
			mail.attach(file);
			
			mail.send();
		
		}catch(Exception e) {
			System.out.println(e.getMessage());
		}
		
	}
	
	private void sendSimple(String email, String name) {
		SimpleEmail mail = new SimpleEmail();
		
		mail.setHostName("smtp.naver.com");//메일전송서버지정
		mail.setCharset("utf-8");
		mail.setDebug(true);//메일전송과정 로그확인
		
		mail.setAuthentication("ojink2", "1234");
		mail.setSSLOnConnect(true);
		
		try {
			mail.setFrom("ojink2@naver.com", "한울관리자");//메일송신자
			mail.addTo(email,name);//메일수신자
			
			mail.setSubject("한울 IoT과정");//메일제목
			mail.setMsg(name+"님! IoT과정 회원가입을 축하합니다!");
			
			mail.send(); //메일발송버튼클릭
			
		}catch(Exception e) {
			System.out.println(e.getMessage());
		}
		
		
		
		
		
		
		
		
		
		
	}
	
}
