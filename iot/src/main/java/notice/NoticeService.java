package notice;

import java.util.List;

public interface NoticeService {
	//CRUD
	void notice_insert(NoticeVO vo);	//공지글 저장
	List<NoticeVO> notice_list();	//공지글 목록조회
	NoticeVO notice_detail(int id);	//공지글 상세조회
	void notice_update(NoticeVO vo); 	//공지글 변경저장
	void notice_delete(int id);			//공지글 삭제
}
