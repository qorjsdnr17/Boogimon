package model.stampbook;

import java.util.ArrayList;

public class StampbookDO {
	private int stampbookId;
	private String title;
	private String description;
	private String nickname;	// author
	private String profileImg;	// author
	private String stampbookRegdate;
	private int likeCount;
	private boolean liked;
	private boolean picked;
	private String completeDate;
	private ArrayList<StampDO> stampList;
	private ArrayList<CommentDO> commentList;
	
	public StampbookDO() {
	}

	public int getStampbookId() {
		return stampbookId;
	}

	public void setStampbookId(int stampbookId) {
		this.stampbookId = stampbookId;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getProfileImg() {
		return profileImg;
	}

	public void setProfileImg(String profileImg) {
		this.profileImg = profileImg;
	}

	public String getStampbookRegdate() {
		return stampbookRegdate;
	}

	public void setStampbookRegdate(String stampbookRegdate) {
		this.stampbookRegdate = stampbookRegdate;
	}

	public int getLikeCount() {
		return likeCount;
	}

	public void setLikeCount(int likeCount) {
		this.likeCount = likeCount;
	}

	public boolean getLiked() {
		return liked;
	}

	public void setLiked(int isLike) {
		if(isLike == 1) {
			this.liked = true;
		}
		else {
			this.liked = false;
		}
	}
	
	public boolean getPicked() {
		return picked;
	}

	public void setPicked(int isPick) {
		if(isPick == 1) {
			this.picked = true;
		}
		else {
			this.picked = false;
		}
	}
	
	public String getCompleteDate() {
		return completeDate;
	}

	public void setCompleteDate(String completeDate) {
		this.completeDate = completeDate;
	}

	public void setLiked(boolean liked) {
		this.liked = liked;
	}

	public ArrayList<StampDO> getStampList() {
		return stampList;
	}

	public void setStampList(ArrayList<StampDO> stampList) {
		this.stampList = stampList;
	}

	public ArrayList<CommentDO> getCommentList() {
		return commentList;
	}

	public void setCommentList(ArrayList<CommentDO> commentList) {
		this.commentList = commentList;
	}
	
	public String toString() {
		String result = String.format("stampbookId: %d / title: %s / description: %s \nnickname: %s / nickname: %s / stampbookRegdate: %s / completeDate: %s \nlikeCount: %d / liked: %b\n", 
				this.stampbookId, this.title, this.description, this.nickname, this.profileImg, this.stampbookRegdate, this.completeDate, this.likeCount, this.liked);
		
		if(this.stampList != null && !(this.stampList.isEmpty())) {
			result += String.format("========== stampList ==========\n");
			for(StampDO stamp : this.stampList) {
				result += stamp.toString();
				result += String.format("-------------------------------\n");
			}
		}
		
		if(this.commentList != null && !(this.commentList.isEmpty())) {
			result += String.format("========== commentList ==========\n");
			for(CommentDO comment : this.commentList) {
				result += comment.toString();
				result += String.format("-------------------------------\n");
			}
		}
		
		return result;
	}
}
