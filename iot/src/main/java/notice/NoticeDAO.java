package notice;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class NoticeDAO implements NoticeService {
	@Autowired private SqlSession sql;

	@Override
	public void notice_insert(NoticeVO vo) {
		sql.insert("notice.mapper.insert", vo);
	}

	@Override
	public List<NoticeVO> notice_list() {
		return sql.selectList("notice.mapper.list");
	}

	@Override
	public NoticeVO notice_detail(int id) {
		return sql.selectOne("notice.mapper.detail", id);
	}

	@Override
	public void notice_update(NoticeVO vo) {
		sql.update("notice.mapper.update", vo);
	}

	@Override
	public void notice_delete(int id) {
		sql.delete("notice.mapper.delete", id);

	}

	@Override
	public void notice_read(int id) {
		sql.update("notice.mapper.read", id);
	}

	@Override
	public NoticePage notice_list(NoticePage page) {
		page.setTotalList((Integer)sql.selectOne("notice.mapper.totalList"));	//총 건수를 알아와야함
		page.setList( sql.selectList("notice.mapper.list", page)); //쿼리문에 파라미터를 여러건 보낼수 없으므로 엔드리스트, 비긴리스트를 두개 보낼수 없으므로 page를 보냄
		return page;
	}

	@Override
	public void notice_reply_insert(NoticeVO vo) {
		sql.insert("notice.mapper.reply_insert", vo);
	}

}
