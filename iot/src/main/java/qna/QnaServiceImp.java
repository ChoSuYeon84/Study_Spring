package qna;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class QnaServiceImp implements QnaService {
	@Autowired private QnaDAO dao;
	
	@Override
	public void qna_insert(QnaVO vo) {
		// TODO Auto-generated method stub

	}

	@Override
	public List<QnaVO> qna_list() {
		return dao.qna_list();
	}

	@Override
	public QnaVO qna_detail(int id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void qna_update(QnaVO vo) {
		// TODO Auto-generated method stub

	}

	@Override
	public void qna_delete(int id) {
		// TODO Auto-generated method stub

	}

	@Override
	public void qna_read(int id) {
		// TODO Auto-generated method stub

	}

}
