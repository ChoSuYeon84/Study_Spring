package com.hanul.automedic;

import java.io.IOException;
import java.net.URLEncoder;

import javax.inject.Inject;
import javax.xml.parsers.ParserConfigurationException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.xml.sax.SAXException;

import common.CommonService;
import info.InfoPage;
import info.dao;
import letter.MessageService;
import letter.MessageVO;

@Controller
public class LetterController {
	@Inject
    MessageService service;

	@RequestMapping("/receive")
	public String send() {
		System.out.println("쪽지 보관함 들어왔엉");
		//service.readMessage(userid, mid)
		return "letter/receive";
	}
	@RequestMapping("/send")
	public String send(String sender,String receiver,String message) {
		System.out.println(sender);
		System.out.println(receiver);
		System.out.println(message);
		
		MessageVO vo = new MessageVO();
		vo.setSender(sender);
		vo.setTargetid(receiver);
		vo.setMessage(message);
		
		//model.addAttribute("vo",vo);
		
		service.addMessage(vo);
		
		System.out.println("쪽지 전송!");
		return "home";
	}
	    
	    // ResponseEntity    : HTTP상태코드 + 데이터  전달
	    // @RequestBody        : 클라이언트 => 서버 (json 데이터가 입력될 때)
	    // @ResponsetBody    : 서버 => 클라이언트 (json) RestController에서는 생략가능
	    @RequestMapping(value="/letter")
	    public String addMessage(MessageVO vo){
	    	System.out.println("매핑 들어옴~");
	        ResponseEntity<String> entity = null;
	        try {
	            service.addMessage(vo);
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        return "letter/letter";
	    }

}
