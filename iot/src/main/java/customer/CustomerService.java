package customer;

import java.util.List;

public interface CustomerService {
	//CRUD(Create/Read/Update/Delete)
	//고객정보삽입저장 
	void customer_insert(CustomerVO vo);
	//목록조회 
	List<CustomerVO> customer_list();
	//상세(1건)조회
	CustomerVO customer_detail(int id);
	//고객정보변경저장
	void customer_update(CustomerVO vo);
	//고객정보삭제
	void customer_delete(int id);
}
