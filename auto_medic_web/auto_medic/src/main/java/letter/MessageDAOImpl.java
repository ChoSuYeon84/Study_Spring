package letter;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

@Repository
public class MessageDAOImpl implements MessageDAO {
    @Inject
    SqlSession sqlSession;

    // 메시지 작성
    @Override
    public void create(MessageVO vo) {
    	System.out.println("매퍼 전까지들어옴!");
    	System.out.println("보낸이=> "+vo.getSender());
    	System.out.println("받는이=> "+vo.getTargetid());
    	System.out.println("메세지=> "+vo.getMessage());
        sqlSession.insert("message.create", vo);
    }
    // 메시지 열람
    @Override
    public MessageVO readMessage(int mid) {

        return null;
    }
    // 메시지 열람시간 갱신
    @Override
    public void updateMessage(int mid) {

    }

}