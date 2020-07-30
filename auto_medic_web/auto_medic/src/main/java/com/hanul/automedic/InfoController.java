package com.hanul.automedic;
import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;


import common.CommonService;
import info.InfoDAO;
import info.InfoPage;
import info.InfoVO;


@Controller
public class InfoController {
	InfoDAO dao = new InfoDAO();
	 private InfoPage page;
	 private CommonService common;
	/*
	 * @RequestMapping("/search.if") public String search(@RequestParam("medicine")
	 * String medicineName) { System.out.println("매핑진입:"+medicineName);
	 * if(dao.search(medicineName) != null) { String[] list =
	 * dao.search(medicineName); }else { System.out.println("검색결과없음"); } return
	 * "info/drug"; }
	 */
	
	@RequestMapping("/drug.if")
	//방명록 목록화면 요청
	public String list() {
			
			
			return "info/drug";
		}
	
	/*
	 * //방명록 목록화면 요청
	 * 
	 * @RequestMapping("/list.bo") public String list(HttpSession session, Model
	 * model , @RequestParam(defaultValue = "1") int curPage , String search, String
	 * keyword , @RequestParam(defaultValue = "10") int pageList
	 * , @RequestParam(defaultValue = "list") String viewType) { //DB에서 방명록 정보를 조회해와
	 * 목록화면에 출력 session.setAttribute("category", "bo"); page.setCurPage(curPage);
	 * page.setSearch(search); page.setKeyword(keyword); page.setViewType(viewType);
	 * page.setPageList(pageList); model.addAttribute("page",
	 * service.board_list(page));
	 * 
	 * return "board/list"; }
	 */
	
	@RequestMapping("/map.if")
	//지도화면으로 돌아가는 매핑
	public String map() {
		
		return  "info/map";
	}
	
}
