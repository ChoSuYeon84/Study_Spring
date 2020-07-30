package info;

import java.util.List;

import org.springframework.stereotype.Component;

import common.PageVO;

@Component
public class InfoPage extends PageVO {
	private List<InfoVO> list;

	public List<InfoVO> getList() {
		return list;
	}

	public void setList(List<InfoVO> list) {
		this.list = list;
	}
}
