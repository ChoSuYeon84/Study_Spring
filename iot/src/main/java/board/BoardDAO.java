package board;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class BoardDAO implements BoardService {
	@Autowired private SqlSession sql;
	
	
	@Override
	public int board_insert(BoardVO vo) {
		return sql.insert("board.mapper.insert", vo);
	}

	@Override
	public BoardPage board_list(BoardPage page) {
		page.setTotalList( (Integer)sql.selectOne("board.mapper.total", page) ); //총페이지 갯수를 가져와
		page.setList( sql.selectList("board.mapper.list", page));	// 한페이지에 몇페이지씩 출력할지를 결정
		return page;
	}

	@Override
	public BoardVO board_detail(int id) {
		return sql.selectOne("board.mapper.detail", id);
	}

	@Override
	public void board_read(int id) {
		sql.update("board.mapper.read", id);

	}

	@Override
	public int board_update(BoardVO vo) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int board_delete(int id) {
		// TODO Auto-generated method stub
		return 0;
	}

}
