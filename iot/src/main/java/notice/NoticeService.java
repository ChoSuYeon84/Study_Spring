package notice;

import java.util.List;

public interface NoticeService {
	//CRUD
	void notice_insert(NoticeVO vo);	//공지글 저장
	List<NoticeVO> notice_list();	//공지글 목록조회
	NoticePage notice_list(NoticePage page);	//페이지처리된 공지글 목록조회
	NoticeVO notice_detail(int id);	//공지글 상세조회
	void notice_update(NoticeVO vo); 	//공지글 변경저장
	void notice_delete(int id);			//공지글 삭제
	void notice_read(int id);	//조회수증가처리
}
