package letter;

public interface MessageService {
	
	public void addMessage(MessageVO vo);
	public MessageVO readMessage(String userid, int mid);
}
