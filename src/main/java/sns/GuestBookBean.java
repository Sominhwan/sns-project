package sns;

public class GuestBookBean {
	private String userEmail;
	private String gbComment;
	private String gbBackGroundImage;
	public String getUserEmail() {
		return userEmail;
	}
	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}
	public String getGbComment() {
		return gbComment;
	}
	public void setGbComment(String gbComment) {
		this.gbComment = gbComment;
	}
	public String getGbBackGroundImage() {
		return gbBackGroundImage;
	}
	public void setGbBackGroundImage(String gbBackGroundImage) {
		this.gbBackGroundImage = gbBackGroundImage;
	}
	
}
