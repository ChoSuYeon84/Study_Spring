package notice;

import java.util.List;

import org.springframework.stereotype.Component;

import common.PageVO;

@Component //데이터를 담아놓을 하나의 컴포넌트
public class NoticePage extends PageVO {
	private List<NoticeVO> list;

	public List<NoticeVO> getList() {
		return list;
	}

	public void setList(List<NoticeVO> list) {
		this.list = list;
	}	
	
}
