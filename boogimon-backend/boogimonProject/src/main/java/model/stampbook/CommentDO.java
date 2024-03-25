package model.stampbook;

public class CommentDO {
	private int commentId;
	private String nickname;
	private String userId;	// insert용
	private String comment;
	private String writeDate;
	private String profileImg;
	
	public CommentDO() {
		
	}

	public int getCommentId() {
		return commentId;
	}

	public void setCommentId(int commentId) {
		this.commentId = commentId;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	public String getWriteDate() {
		return writeDate;
	}

	public void setWriteDate(String writeDate) {
		this.writeDate = writeDate;
	}

	public String getProfileImg() {
		return profileImg;
	}

	public void setProfileImg(String profileImg) {
		this.profileImg = profileImg;
	}
	
	public String toString() {
		return String.format("commentId: %d / nickname: %d / writeDate: %s \ncomment: %s\nprofileImg: %s\n", 
				this.commentId, this.nickname, this.writeDate, this.comment, this.profileImg);
	}
}
