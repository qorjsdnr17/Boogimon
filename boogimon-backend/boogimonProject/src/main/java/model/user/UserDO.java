package model.user;

public class UserDO {

	private String userId;
	private String passwd;
	private String newPasswd;
	private String nickname;
	private String newNickname;
	private String regdate;
	private int exp;
	private String profileImg;
	private int userTotalVisit;
	private int userLikeCount;
	private int ranking;
	
	public UserDO(){
		
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getPasswd() {
		return passwd;
	}

	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}

	public String getNewPasswd() {
		return newPasswd;
	}

	public void setNewPasswd(String newPasswd) {
		this.newPasswd = newPasswd;
	}
	
	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getNewNickname() {
		return newNickname;
	}

	public void setNewNickname(String newNickname) {
		this.newNickname = newNickname;
	}
	
	public String getRegdate() {
		return regdate;
	}

	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}

	public int getExp() {
		return exp;
	}

	public void setExp(int exp) {
		this.exp = exp;
	}

	public String getProfileImg() {
		return profileImg;
	}

	public void setProfileImg(String profileImg) {
		this.profileImg = profileImg;
	}

	public int getUserTotalVisit() {
		return userTotalVisit;
	}

	public void setUserTotalVisit(int userTotalVisit) {
		this.userTotalVisit = userTotalVisit;
	}

	public int getUserLikeCount() {
		return userLikeCount;
	}

	public void setUserLikeCount(int userLikeCount) {
		this.userLikeCount = userLikeCount;
	}

	public int getRanking() {
		return ranking;
	}

	public void setRanking(int ranking) {
		this.ranking = ranking;
	}
	
	public String toString() {
		return String.format("userId: %s / nickname: %s / regdate: %s / exp: %d \nprofileImg: %s \nuserTotalVisit: %d / userLikeCount: %d \nranking: %d \n", 
				this.userId, this.nickname, this.regdate, this.exp, this.profileImg, this.userTotalVisit, this.userLikeCount, this.ranking);
	}
}
