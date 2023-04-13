package sns;

public class ChatMessagerBean {
	private int chatMessagerId;
	private String userEmail;
	private String message;
	private String creationDate;
	public int getChatMessagerId() {
		return chatMessagerId;
	}
	public void setChatMessagerId(int chatMessagerId) {
		this.chatMessagerId = chatMessagerId;
	}
	public String getUserEmail() {
		return userEmail;
	}
	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public String getCreationDate() {
		return creationDate;
	}
	public void setCreationDate(String creationDate) {
		this.creationDate = creationDate;
	}
	
}
