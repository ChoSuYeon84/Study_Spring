package com.hanul.automedic;

import java.io.IOException;
import java.net.URLEncoder;

import javax.xml.parsers.ParserConfigurationException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.xml.sax.SAXException;

import common.CommonService;
import info.InfoPage;
import info.dao;

@Controller
public class InfoController {

	private String key = "MkSdYE%2Buv%2FKUgV4R8rVZr59Xn0XNCfABz8mQYa9xFwt%2BCigtvqcl2JmkBmpycrnmTdX%2B%2B50a8UNgMqqrB5qvOg%3D%3D";
	@Autowired private CommonService common;
	@Autowired private InfoPage page;
	dao dao = new dao();

	// 약 상세화면
	@RequestMapping("/detail.if")
	public String detail(@RequestParam("code") int code, String name, Model model,String kind,String com,String date,String insurance) throws IOException, ParserConfigurationException, SAXException {
		String[] arr = new String[7];
		arr = dao.searchMedicine(name);
		/*
		 * System.out.println("배열[0]에 찍히는 값 => "+arr[0]);
		 * System.out.println("배열[1]에 찍히는 값 => "+arr[1]);
		 * System.out.println("배열[2]에 찍히는 값 => "+arr[2]);
		 */
		System.out.println("보험코드값: "+insurance);
		
		name = name.replace("퍼센트","%");
		
		model.addAttribute("appear", arr[0]);
		model.addAttribute("ingredient", arr[1]);
		model.addAttribute("keep",arr[2] );
		model.addAttribute("valid",arr[3] );
		model.addAttribute("effect",arr[4] );
		model.addAttribute("eat", arr[5]);
		model.addAttribute("caution",arr[6] );
		
		model.addAttribute("code", code);
		model.addAttribute("name", name);
		model.addAttribute("kind",kind );
		model.addAttribute("com",com );
		model.addAttribute("date", date);
		model.addAttribute("insurance",insurance );
		return "info/detail";
	}

	// 약 사진추출 요청
	@ResponseBody @RequestMapping(value = "/data/image", produces = "application/json; charset=utf-8")
	public String drug_image(int code) {
		System.out.println("image에서의 코드값:" + code);
		StringBuilder url = new StringBuilder(
				"http://apis.data.go.kr/1470000/MdcinGrnIdntfcInfoService/getMdcinGrnIdntfcInfoList?ServiceKey=MkSdYE%2Buv%2FKUgV4R8rVZr59Xn0XNCfABz8mQYa9xFwt%2BCigtvqcl2JmkBmpycrnmTdX%2B%2B50a8UNgMqqrB5qvOg%3D%3D&item_seq="+code);
		try {
			System.out.println("사진 주소:" + url);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return common.json_list(url);
	}

	// 약 검색 정보조회 요청
	@ResponseBody
	@RequestMapping(value = "/data/search", produces = "application/json; charset=utf-8")
	public String drugSearch_list(@RequestParam("keyword") String keyword) {
		System.out.println("검색들어옴");
		StringBuilder url = new StringBuilder(
				"http://apis.data.go.kr/1471057/MdcinPrductPrmisnInfoService/getMdcinPrductItem");
		try {
			System.out.println("검색 트라이 들어옴");
			url.append("?ServiceKey=" + key);
			System.out.println("키워드 => "+keyword);
			 url.append("&item_name="+ URLEncoder.encode(keyword,"utf-8"));
			 
			/*
			 * url.append("&_type=json");
			 */
			//url.append("&pageNo="+pageNo); 
			//url.append("&numOfRows="+rows);
			
			System.out.println("주소:" + url);
		} catch (Exception e) {
			
		}
		return common.json_list(url);
	}
	
	// 약 정보조회 요청
	@ResponseBody
	@RequestMapping(value = "/data/medicine", produces = "application/json; charset=utf-8")
	public String drug_list(int pageNo) {
		StringBuilder url = new StringBuilder(
				"http://apis.data.go.kr/1471057/MdcinPrductPrmisnInfoService/getMdcinPrductItem");
		try {
			url.append("?ServiceKey=" + key);
			// url.append("&item_name="+ URLEncoder.encode("게보린","utf-8"));
			/*
			 * url.append("&_type=json");
			 */
			  url.append("&pageNo="+pageNo); 
			  url.append("&item_name=");
			  //url.append("&numOfRows="+rows);
			 
			System.out.println("주소:" + url);
		} catch (Exception e) {

		}
		return common.json_list(url);
	}
	
	
	
	/*
	 * @RequestMapping("/search.if") public String search(@RequestParam("medicine")
	 * String medicineName) { System.out.println("매핑진입:"+medicineName);
	 * if(dao.search(medicineName) != null) { String[] list =
	 * dao.search(medicineName); }else { System.out.println("검색결과없음"); } return
	 * "info/drug"; }
	 */

	@RequestMapping("/drug.if")
	// 약 목록화면 요청
	public String list(Model model, @RequestParam(defaultValue = "1") int curPage, String search, String keyword, @RequestParam(defaultValue = "10") int pageList, @RequestParam(defaultValue = "list") String viewType) {
		System.out.println("이거찍히나?");
		
		page.setKeyword(keyword); 
		page.setViewType(viewType);
		page.setPageList(pageList); 
		page.setCurPage(curPage);
		model.addAttribute("page", page);
		 
		
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
	// 지도화면으로 돌아가는 매핑
	public String map() {

		return "info/map";
	}

}
