package model;

import java.util.ArrayList;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import boogimon.BoogiException;
import model.stampbook.CommentDO;
import model.stampbook.StampDO;
import model.stampbook.StampbookDAO;
import model.stampbook.StampbookDO;
import model.stampbook.StampbookDetailDAO;
import model.stampbook.StampbookListDO;

public class StampbookJsonWriter extends JsonWriter{
	private StampbookDAO stbDAO;
	private StampbookDetailDAO stbdDAO;
	
	public StampbookJsonWriter() {
		
	}
	
	public StampbookJsonWriter(StampbookDAO stampbookDAO, StampbookDetailDAO stampbookDetailDAO) {
		this.stbDAO = stampbookDAO;
		this.stbdDAO = stampbookDetailDAO;
	}
	
	public void setStampbookDAO(StampbookDAO stampbookDAO) {
		this.stbDAO = stampbookDAO;
	}
	
	public void setStampbookDetailDAO(StampbookDetailDAO stampbookDetailDAO) {
		this.stbdDAO = stampbookDetailDAO;
	}
	
	/** 특정 스탬프북의 상세정보 반환 */
	@SuppressWarnings("unchecked")
	public String getStampbookDetailJson(StampbookDO stampbook) {
		
		JSONObject stbObj = new JSONObject();
		
		// 헤더 탑재
		JSONObject jsonObj = OperationResult.NORMAL_CODE.getResponseJsonObj();
		
		// stampbook 객체 생성
		stbObj = getStampbookJsonObj(stampbook);
		
		// stampbook 객체에 stampList 객체 탑재
		stbObj.put("stampList", stampListJsonBuilder(stampbook.getStampList()));
		// stampbook 객체에 commentList 객체 탑재
		stbObj.put("commentList", commentListJsonBuilder(stampbook.getCommentList()));
		
		// 완성된 stampbook 객체를 jsonObj에 탑재
		jsonObj.put("stampbook", stbObj);
		
		return jsonObj.toJSONString();
	}

	/** 스탬프북 JsonObject 생성*/
	@SuppressWarnings("unchecked")
	private JSONObject getStampbookJsonObj(StampbookDO stampbook) {
		JSONObject jsonObj = new JSONObject();
		JSONObject stObj = null;
		JSONArray jsonArr = new JSONArray();
		
		
		jsonObj.put("stampbookId", stampbook.getStampbookId());
		jsonObj.put("title", stampbook.getTitle());
		jsonObj.put("description", stampbook.getDescription());
		jsonObj.put("nickname", stampbook.getNickname());
		jsonObj.put("profileImg", stampbook.getProfileImg());
		jsonObj.put("stampbookRegdate", stampbook.getStampbookRegdate());
		jsonObj.put("completeDate", stampbook.getCompleteDate());
		jsonObj.put("likeCount", stampbook.getLikeCount());
		jsonObj.put("isLike", stampbook.getLiked());
		jsonObj.put("isPick", stampbook.getPicked());
		
		if(!stampbook.getStampList().isEmpty()) {
			for(StampDO stamp : stampbook.getStampList()) {
				stObj = new JSONObject();
				
				stObj.put("stampNo", stamp.getStampNo());
				stObj.put("name", stamp.getName());
				stObj.put("thumbnail", stamp.getThumbnail());
				stObj.put("stampedDate", stamp.getStampedDate());
				stObj.put("isStamped", stamp.getStampedDate() != null ? true : false);
				
				jsonArr.add(stObj);
			}
		}
		
		jsonObj.put("stampList", jsonArr);
		
		return jsonObj;
	}
	
	/** 받은 StampbookListDO의 json 스트링 반환 */
	@SuppressWarnings("unchecked")
	public String getStampbookListJson(StampbookListDO stampbookList) {
		
		// StampbookList jsonArray에 탑재
		JSONArray jsonArr = new JSONArray();
		for(StampbookDO stampbook : stampbookList.getStampbookList()) {
			jsonArr.add(this.getStampbookJsonObj(stampbook));
		}
		
		JSONObject jsonObj = OperationResult.NORMAL_CODE.getResponseJsonObj();
		jsonObj.put("stampbookList", jsonArr);
		
		return jsonObj.toJSONString();
	}
	
	@SuppressWarnings("unchecked")
	public String getCommentListJson(int stampbookId) {
		ArrayList<CommentDO> commentList = new ArrayList<CommentDO>();
		JSONObject jsonObj = null;
		JSONArray jsonArr = new JSONArray();
		
		try {
			commentList = stbdDAO.getComments(stampbookId);
			jsonArr = commentListJsonBuilder(commentList);
			
			jsonObj = OperationResult.NORMAL_CODE.getResponseJsonObj();
			jsonObj.put("commentList", jsonArr);
		}
		catch (Exception e) {
			jsonObj = BoogiException.getResult(e).getResponseJsonObj();
		}
		
		return jsonObj.toJSONString();
	}
	
	/** commentList JSONArray 객체 생성 */
	@SuppressWarnings("unchecked")
	public JSONArray commentListJsonBuilder(ArrayList<CommentDO> commentList) {
		
		JSONObject cmtObj = null;
		JSONArray jsonArr = new JSONArray();

		for(CommentDO comment : commentList) {
			cmtObj = new JSONObject();
			
			cmtObj.put("commentId", comment.getCommentId());
			cmtObj.put("nickname", comment.getNickname());
			cmtObj.put("comment", comment.getComment());
			cmtObj.put("writeDate", comment.getWriteDate());
			cmtObj.put("profileImg", comment.getProfileImg());
			
			jsonArr.add(cmtObj);
		}

		return jsonArr;
	}
	
	@SuppressWarnings("unchecked")
	public String getStampListJson(int stampbookId, String userId) {
		ArrayList<StampDO> stampList = new ArrayList<StampDO>();
		
		JSONObject jsonObj = null;
		JSONArray jsonArr = null;
		
		try {
			if(userId != null) { 
				stampList = stbdDAO.getStamp(stampbookId, userId);
			}
			else {
				stampList = stbdDAO.getStamp(stampbookId);
			}	
			jsonArr = stampListJsonBuilder(stampList);
			
			jsonObj = OperationResult.NORMAL_CODE.getResponseJsonObj();
			jsonObj.put("stampList", jsonArr);
		}
		catch (Exception e) {
			jsonObj = BoogiException.getResult(e).getResponseJsonObj();
		}
		
		return jsonObj.toJSONString();
	}
	
	/** stampList JSONArray 객체 생성 */
	@SuppressWarnings("unchecked")
	public JSONArray stampListJsonBuilder(ArrayList<StampDO> stampList) {
		
		JSONObject stObj = null;
		JSONArray jsonArr = new JSONArray();
		
		for(StampDO stamp : stampList) {
			stObj = new JSONObject();
			
			stObj.put("stampNo", stamp.getStampNo());
			stObj.put("placeId", stamp.getPlaceId());
			stObj.put("placeName", stamp.getName());
			stObj.put("lat", stamp.getLat());
			stObj.put("lon", stamp.getLon());
			stObj.put("thumbnail", stamp.getThumbnail());
			
			if(stamp.getStampedDate() != null) {
				stObj.put("isStamped", true);
				stObj.put("uploadImg", stamp.getUploadImg());
				stObj.put("stampedDate", stamp.getStampedDate());
			}
			else {
				stObj.put("isStamped", false);
			}
			
			jsonArr.add(stObj);
		}
		
		return jsonArr;
	}
}
