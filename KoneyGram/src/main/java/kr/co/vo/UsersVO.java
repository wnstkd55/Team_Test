package kr.co.vo;

public class UsersVO {
	private String userId;
	private String userPwd;
	private String userName;
	private int userAge;
	private String userEmail;
	private String userIntro;
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserPwd() {
		return userPwd;
	}
	public void setUserPwd(String userPwd) {
		this.userPwd = userPwd;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public int getUserAge() {
		return userAge;
	}
	public void setUserAge(int userAge) {
		this.userAge = userAge;
	}
	public String getUserEmail() {
		return userEmail;
	}
	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}
	public String getUserIntro() {
		return userIntro;
	}
	public void setUserIntro(String userIntro) {
		this.userIntro = userIntro;
	}
	@Override
	public String toString() {
		return "UsersVO [userId=" + userId + ", userPwd=" + userPwd + ", userName=" + userName + ", userAge=" + userAge
				+ ", userEmail=" + userEmail + ", userIntro=" + userIntro + "]";
	}
	
	
}
