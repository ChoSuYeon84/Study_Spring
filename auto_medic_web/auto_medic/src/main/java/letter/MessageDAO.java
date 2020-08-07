package letter;

public interface MessageDAO {

	public void create(MessageVO vo);
	public MessageVO readMessage(int mid);
	public void updateMessage(int mid);
}
