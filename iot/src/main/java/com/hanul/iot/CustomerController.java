package com.hanul.iot;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import customer.CustomerServiceImpl;
import customer.CustomerVO;

@Controller
public class CustomerController {
	@Autowired private CustomerServiceImpl service;
	
	//고객정보삭제처리 요청
	@RequestMapping("/delete.cu")
	public String delete(int id) {
		//선택한 고객정보를 DB에서 삭제한 후
		service.customer_delete(id);
		//목록화면으로 연결
		return "redirect:list.cu";
	}
	
	//고객정보수정저장처리 요청
	@RequestMapping("/update.cu")
	public String update(CustomerVO vo) {
		//화면에서 수정입력한 정보를 DB에 저장한 후
		service.customer_update(vo);
		//상세(디테일)화면으로 연결
		return "redirect:detail.cu?id="+vo.getId();
	}
	
	//고객정보수정화면 요청
	@RequestMapping("/modify.cu")
	public String modify(int id, Model model) {
		//선택한 고객의 정보를 DB에서 조회해온 후
		//수정화면에 출력할 수 있도록 Model에 담는다
		model.addAttribute("vo", service.customer_detail(id));
		return "customer/modify";
	}
	
	//신규고객등록처리 요청
	@RequestMapping("/insert.cu")
	public String insert(CustomerVO vo) {
		//화면에서 입력한 정보를 DB에 저장한 후
		service.customer_insert(vo);
		//목록화면으로 연결
		
		return "redirect:list.cu";	//주소 변경을 customer폴더 밑list.jsp로 보내기 위해 리다이렉트를 설정하는데 그거에 매핑된게 list.cu임
	}
	
	//신규고객등록화면 요청
	@RequestMapping("/new.cu")
	public String customer() {
		return "customer/new";
	}
	
	
	//고객상세화면
	@RequestMapping("/detail.cu")
	public String detail(int id, Model model) {
		//선택한 고객정보를 DB에서 조회해와
		CustomerVO vo = service.customer_detail(id);
		//화면에 출력할 수 있도록 Model에 담는다.
		model.addAttribute("vo", vo);
		return "customer/detail";
	}
	
	//고객관리목록 화면
	@RequestMapping("/list.cu")
	public String list(HttpSession session, Model model) {
		session.setAttribute("category", "cu");
		List<CustomerVO> list = service.customer_list();
		model.addAttribute("list", list);
		return "customer/list";
	}
}
