package sns;

public class UserinfoBean {
	private String userName;
	private String userGender;
	private String userNickName;
	private String userEmail;
	private String userPwd;
	private String userPN;
	private String userSchool;
	private String userAddress;
	private String userSocial;
	private String userSocialId;
	private String emailHash;
	private int emailcertification;
	private String userImage;
	private String userRegDate;
	private int userAd;
	private String userRegTime;
	private String userInfoType;
	
	public UserinfoBean(String userName, String userGender, String userNickName, String userEmail, String userPwd,
			String userPN, String emailHash, String userImage, int userAd) {
		super();
		this.userName = userName;
		this.userGender = userGender;
		this.userNickName = userNickName;
		this.userEmail = userEmail;
		this.userPwd = userPwd;
		this.userPN = userPN;
		this.emailHash = emailHash;
		this.userImage = userImage;
		this.userAd = userAd;
	}
	
	public UserinfoBean(String userName, String userGender, String userNickName, String userEmail, String userPN,
			String userSocialId, int emailcertification, String userImage, int userAd, String userInfoType) {
		super();
		this.userName = userName;
		this.userGender = userGender;
		this.userNickName = userNickName;
		this.userEmail = userEmail;
		this.userPN = userPN;
		this.userSocialId = userSocialId;
		this.emailcertification = emailcertification;
		this.userImage = userImage;
		this.userAd = userAd;
		this.userInfoType = userInfoType;
	}

	public String getUserInfoType() {
		return userInfoType;
	}

	public void setUserInfoType(String userInfoType) {
		this.userInfoType = userInfoType;
	}

	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getUserGender() {
		return userGender;
	}
	public void setUserGender(String userGender) {
		this.userGender = userGender;
	}
	public String getUserNickName() {
		return userNickName;
	}
	public void setUserNickName(String userNickName) {
		this.userNickName = userNickName;
	}
	public String getUserEmail() {
		return userEmail;
	}
	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}
	public String getUserPwd() {
		return userPwd;
	}
	public void setUserPwd(String userPwd) {
		this.userPwd = userPwd;
	}
	public String getUserPN() {
		return userPN;
	}
	public void setUserPN(String userPN) {
		this.userPN = userPN;
	}
	public String getUserSchool() {
		return userSchool;
	}
	public void setUserSchool(String userSchool) {
		this.userSchool = userSchool;
	}
	public String getUserAddress() {
		return userAddress;
	}
	public void setUserAddress(String userAddress) {
		this.userAddress = userAddress;
	}
	public String getUserSocial() {
		return userSocial;
	}
	public void setUserSocial(String userSocial) {
		this.userSocial = userSocial;
	}
	public String getUserSocialId() {
		return userSocialId;
	}
	public void setUserSocialId(String userSocialId) {
		this.userSocialId = userSocialId;
	}
	public String getEmailHash() {
		return emailHash;
	}
	public void setEmailHash(String emailHash) {
		this.emailHash = emailHash;
	}
	public int getEmailcertification() {
		return emailcertification;
	}
	public void setEmailcertification(int emailcertification) {
		this.emailcertification = emailcertification;
	}
	public String getUserImage() {
		return userImage;
	}
	public void setUserImage(String userImage) {
		this.userImage = userImage;
	}
	public String getUserRegDate() {
		return userRegDate;
	}
	public void setUserRegDate(String userRegDate) {
		this.userRegDate = userRegDate;
	}
	public int getUserAd() {
		return userAd;
	}
	public void setUserAd(int userAd) {
		this.userAd = userAd;
	}
	public String getUserRegTime() {
		return userRegTime;
	}
	public void setUserRegTime(String userRegTime) {
		this.userRegTime = userRegTime;
	}
	
}
