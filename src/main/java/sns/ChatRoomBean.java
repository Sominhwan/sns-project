package sns;

public class ChatRoomBean {
	private int roomId;
	private String userEmail;
	private String createTime;
	private int lastCheck;
	
	
	
	public int getLastCheck() {
		return lastCheck;
	}
	public void setLastCheck(int lastCheck) {
		this.lastCheck = lastCheck;
	}
	public int getRoomId() {
		return roomId;
	}
	public void setRoomId(int roomId) {
		this.roomId = roomId;
	}
	public String getUserEmail() {
		return userEmail;
	}
	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}
	public String getCreateTime() {
		return createTime;
	}
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}
	
}
