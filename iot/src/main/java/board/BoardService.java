package board;

public interface BoardService {
	//CRUD
		int board_insert(BoardVO vo);
		BoardPage board_list(BoardPage page);
		BoardVO board_detail(int id);
		void board_read(int id);
		int board_update(BoardVO vo);
		int board_delete(int id);
}
