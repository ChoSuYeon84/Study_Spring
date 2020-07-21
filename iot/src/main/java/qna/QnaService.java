package qna;

import java.util.List;

public interface QnaService {
	//CRUD
	void qna_insert(QnaVO vo);	//qna글 저장
	List<QnaVO> qna_list();		//qna글 목록조회
	QnaPage qna_list(QnaPage page); //페이지처리된 qna글 목록조회
	QnaVO qna_detail(int id); 	//qna글 상세조회
	void qna_update(QnaVO vo);	//qna글 변경저장
	void qna_delete(int id);	//qna글 삭제
	void qna_read(int id);		//조회수 증가 처리
	void qna_reply_insert(QnaVO vo);	//답글저장
}
