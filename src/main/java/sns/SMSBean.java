package sns;

public class SMSBean {
	private String userPN;
	private String content;
	private String userRegTime;
		
	public SMSBean() {
		super();
	}

	public SMSBean(String userPN, String content) {
		super();
		this.userPN = userPN;
		this.content = content;
	}
	
	public String getUserPN() {
		return userPN;
	}
	public void setUserPN(String userPN) {
		this.userPN = userPN;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getUserRegTime() {
		return userRegTime;
	}
	public void setUserRegTime(String userRegTime) {
		this.userRegTime = userRegTime;
	}
}
