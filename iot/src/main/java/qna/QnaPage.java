package qna;

import java.util.List;

import org.springframework.stereotype.Component;

import common.PageVO;

@Component //데이터를 담아놓을 하나의 컴포넌트
public class QnaPage extends PageVO{
	private List<QnaVO> list;
	
	public List<QnaVO> getList(){
		return list;
	}
	
	public void setList(List<QnaVO> list) {
		this.list = list;
	}
}
