package com.hanul.iot;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import common.CommonService;

@Controller
public class DataController {
	private String key
	= "FPgj2NXbJw46TcGkmAfZEiYFDbxilys7KLjk3KaB7AfeJE00ZhPNM0M8unwbsI69fSmT8SNfVEimE6ZZ2U14hA%3D%3D"; 
	@Autowired private CommonService common;
	
	
	//약국정보조회 요청
	@ResponseBody @RequestMapping("/data/pharmacy")
	public String pharmarcy_list() {
		StringBuilder url = new StringBuilder("http://apis.data.go.kr/B551182/pharmacyInfoService/getParmacyBasisList");
		url.append("?ServiceKey=" + key);
		return common.xml_list(url);
	}
	
	@RequestMapping("/list.da")
	public String data(HttpSession session) {
		session.setAttribute("category", "da");
		return "data/list";
	}

}
