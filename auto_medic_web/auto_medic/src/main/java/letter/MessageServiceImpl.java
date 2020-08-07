package letter;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class MessageServiceImpl implements MessageService {
	 @Inject
	    MessageDAOImpl daoim;

	    

	    // 메시지 작성(DB저장, 포인트적립)
	    @Transactional // 트랜잭션처리 대상 메서드
	    @Override
	    public void addMessage(MessageVO vo) {
	        // 공통업무 - 로그 확인

	        // 핵심업무 - 메시지 저장, 회원 포인트 적립
	        // 메시지를 테이블에 저장
	    	daoim.create(vo);
	        // 메시지를 발송한 사용자에게 10포인트 적립

	    }
	    // 메시지 열람
	    @Override
	    public MessageVO readMessage(String userid, int mid) {

	        return null;
	    }
}
