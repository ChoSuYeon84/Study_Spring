package my;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;



import member.MemberVO;

@Service
public class MyServiceImpl implements MyService {
	@Autowired private MyDAO dao;

	@Override
	public MemberVO my_select(String member_email) {
		
		return dao.my_select(member_email);
	}

	@Override
	public boolean my_update(MemberVO vo) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean my_delete(String member_email) {
		// TODO Auto-generated method stub
		return false;
	}


}
