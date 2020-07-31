package com.hanul.automedic;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ContactusController {
	
	//오시는길 클릭시 해당 페이지로 연결
	@RequestMapping("/contactus")
	public String Contactus() {
		return "contactus/road";
	}
	
}
