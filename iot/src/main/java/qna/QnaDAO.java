package qna;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class QnaDAO implements QnaService {
	@Autowired private SqlSession sql;

	@Override
	public void qna_insert(QnaVO vo) {
		sql.insert("qna.mapper.insert", vo);

	}

	@Override
	public List<QnaVO> qna_list() {
		return sql.selectList("qna.mapper.list");
	}

	@Override
	public QnaVO qna_detail(int id) {
		return sql.selectOne("qna.mapper.detail", id);
	}

	@Override
	public void qna_update(QnaVO vo) {
		sql.update("qna.mapper.update", vo);
	}

	@Override
	public void qna_delete(int id) {
		sql.delete("qna.mapper.delete", id);
	}

	@Override
	public void qna_read(int id) {
		sql.update("qna.mapper.read", id);
	}

	@Override
	public QnaPage qna_list(QnaPage page) {
		page.setTotalList((Integer)sql.selectOne("qna.mapper.totalList", page));	//총 건수를 알아와야함
		page.setList( sql.selectList("qna.mapper.list", page)); //쿼리문에 파라미터를 여러건 보낼수 없으므로 엔드리스트, 비긴리스트를 두개 보낼수 없으므로 page를 보냄
		return page;
	}

	@Override
	public void qna_reply_insert(QnaVO vo) {
		sql.insert("qna.mapper.reply_insert", vo);
	}

	
}
