package sns;

public class CommentBean {
	private int commentId;
	private int postId;
	private String userEmail;
	private String commentDetail;
	private String commentParrent;
	private String commentChild;
	private String commentDate;
	private String commentCorrect;
	public int getCommentId() {
		return commentId;
	}
	public void setCommentId(int commentId) {
		this.commentId = commentId;
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
	public String getCommentDetail() {
		return commentDetail;
	}
	public void setCommentDetail(String commentDetail) {
		this.commentDetail = commentDetail;
	}
	public String getCommentParrent() {
		return commentParrent;
	}
	public void setCommentParrent(String commentParrent) {
		this.commentParrent = commentParrent;
	}
	public String getCommentChild() {
		return commentChild;
	}
	public void setCommentChild(String commentChild) {
		this.commentChild = commentChild;
	}
	public String getCommentDate() {
		return commentDate;
	}
	public void setCommentDate(String commentDate) {
		this.commentDate = commentDate;
	}
	public String getCommentCorrect() {
		return commentCorrect;
	}
	public void setCommentCorrect(String commentCorrect) {
		this.commentCorrect = commentCorrect;
	}
}
