package sns;

public class PostBean {
	private int postId;
	private String userEmail;
	private int likeNum;
	private String imageName;
	private String videoName;
	private int shareNum;
	private int commentNum;
	private String creationDate;
	private int postReport;
	public int getPostReport() {
		return postReport;
	}
	public void setPostReport(int postReport) {
		this.postReport = postReport;
	}
	public int getPostId() {
		return postId;
	}
	public void setPostId(int postId) {
		this.postId = postId;
	}
	public String getUserEmail() {
		return userEmail;
	}
	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}
	public int getLikeNum() {
		return likeNum;
	}
	public void setLikeNum(int likeNum) {
		this.likeNum = likeNum;
	}
	public String getImageName() {
		return imageName;
	}
	public void setImageName(String imageName) {
		this.imageName = imageName;
	}
	public String getVideoName() {
		return videoName;
	}
	public void setVideoName(String videoName) {
		this.videoName = videoName;
	}
	public int getShareNum() {
		return shareNum;
	}
	public void setShareNum(int shareNum) {
		this.shareNum = shareNum;
	}
	public int getCommentNum() {
		return commentNum;
	}
	public void setCommentNum(int commentNum) {
		this.commentNum = commentNum;
	}
	public String getCreationDate() {
		return creationDate;
	}
	public void setCreationDate(String creationDate) {
		this.creationDate = creationDate;
	}
	
}
