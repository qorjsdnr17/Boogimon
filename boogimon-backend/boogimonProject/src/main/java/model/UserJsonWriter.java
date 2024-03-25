package model;

import org.json.simple.JSONObject;

import boogimon.BoogiException;
import model.user.NicknameAPI;
import model.user.UserDAO;
import model.user.UserDO;

public class UserJsonWriter extends JsonWriter{
	private UserDAO userDAO;
	
	public UserJsonWriter() {
	}
	
	public UserJsonWriter(UserDAO userDAO) {
		this.userDAO = userDAO;
	}
	
	public void setUserDAO(UserDAO userDAO) {
		this.userDAO = userDAO;
	}
	
	@SuppressWarnings("unchecked")
	public String getUserInfo(UserDO user) {
		JSONObject jsonObj = null;
		JSONObject userObj = new JSONObject();
		
		try {
			user = userDAO.getUser(user.getUserId());
			jsonObj = OperationResult.NORMAL_CODE.getResponseJsonObj();
			
			userObj.put("nickname", user.getNickname());
			userObj.put("regdate", user.getRegdate());
			userObj.put("exp", user.getExp());
			userObj.put("profileImg", user.getProfileImg());
			userObj.put("userTotalVisit", user.getUserTotalVisit());
			userObj.put("userLikeCount", user.getUserLikeCount());
			userObj.put("ranking", user.getRanking());
			
			jsonObj.put("user", userObj);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			jsonObj = BoogiException.getResult(e).getResponseJsonObj();
		}
		
		return jsonObj.toJSONString();
	}
	
	/** 로그인 체크 */
	public String authLogin(UserDO user) {
		JSONObject jsonObj = null;
		if(userDAO.loginCheck(user)) {
			jsonObj = OperationResult.NORMAL_CODE.getResponseJsonObj();
		}
		else {
			jsonObj = OperationResult.INVALID_USER_ERROR.getResponseJsonObj();
		}
		
		return jsonObj.toJSONString();
	}
	
	/** 랜덤 닉네임 생성 */
	@SuppressWarnings("unchecked")
	public String getRandomNickname() {
		JSONObject jsonObj = null;
		
		try {
			String nickname = NicknameAPI.getNicknameAPI("json", 10);
			
			if(!nickname.isEmpty()) {
				jsonObj = OperationResult.NORMAL_CODE.getResponseJsonObj();
				JSONObject userObj = new JSONObject();
				userObj.put("nickname", nickname);
				jsonObj.put("user", userObj);
			}
			else {
				jsonObj = OperationResult.RANDOM_NICKNAME_GENERATION_FAILED_ERROR.getResponseJsonObj();
			}
		}
		catch (Exception e) {
			// TODO: handle exception
			jsonObj = BoogiException.getResult(e).getResponseJsonObj();
		}
		
		return jsonObj.toJSONString();
	}
	
	/** 패스워드 발급 */
	@SuppressWarnings("unchecked")
	public String getNewPasswd(UserDO user) {
		JSONObject jsonObj = null;
		
		try {
			String newPasswd = userDAO.getNewPasswd(user);
			
			if(!newPasswd.isEmpty()) {
				jsonObj = OperationResult.NORMAL_CODE.getResponseJsonObj();
				JSONObject userObj = new JSONObject();
				userObj.put("newPasswd", newPasswd);
				jsonObj.put("user", userObj);
			}
			else {
				jsonObj = OperationResult.UNKNOWN_ERROR.getResponseJsonObj();
			}
		}
		catch (Exception e) {
			// TODO: handle exception
			jsonObj = BoogiException.getResult(e).getResponseJsonObj();
		}
		
		return jsonObj.toJSONString();
	}
}
