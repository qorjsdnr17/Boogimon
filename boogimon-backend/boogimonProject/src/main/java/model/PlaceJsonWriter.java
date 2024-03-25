package model;

import java.util.ArrayList;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import boogimon.BoogiException;
import model.place.PlaceDAO;
import model.place.PlaceDetailDO;
import model.stampbook.StampDO;

public class PlaceJsonWriter extends JsonWriter{

	private PlaceDAO placeDAO;
	
	public PlaceJsonWriter() {
	}
	
	public PlaceJsonWriter(PlaceDAO placeDAO) {
		this.placeDAO = placeDAO;
	}
	
	@SuppressWarnings("unchecked")
	public String getBoogiBookJson(String userId) {
		ArrayList<StampDO> boogiBookList = this.placeDAO.getAllBoogiBook(userId);
		
		JSONArray boogiArray = new JSONArray();
		JSONObject boogi = null;
		
		for(StampDO place : boogiBookList) {
			boogi = new JSONObject();
			
			if(place.getThumbnail() != null) {
				boogi.put("thumbnail", place.getThumbnail());
			}
			else {
				boogi.put("thumbnail", "/boogimon/images/placeThumnailSample.png");
			}
			
			boogi.put("name", place.getName());
			boogi.put("lastVisitDate", place.getLastVisitDate());
			boogi.put("totalVisitCount", place.getTotalVisitCount());
			
			boogiArray.add(boogi);
		}
		
		JSONObject jsonObj = OperationResult.NORMAL_CODE.getResponseJsonObj();
		jsonObj.put("boogiBook", boogiArray);
		
		return jsonObj.toJSONString();
	}
	

	//getBoogiDex	
	@SuppressWarnings("unchecked")
	public String getBoogiBookDetailJson(int placeId, String userId) {
	    ArrayList<StampDO> boogiBookDetailList = this.placeDAO.getBoogiBook(placeId, userId);
	    
	    JSONArray boogiArray = new JSONArray();
	    JSONObject boogi = null;

	    for (StampDO place : boogiBookDetailList) {
	    	boogi = new JSONObject();

	    	boogi.put("name", place.getName());
	    	boogi.put("uploadImg", place.getUploadImg());
	    	boogi.put("stampedDate", place.getStampedDate());

	        boogiArray.add(boogi);
	    }
	    
	    JSONObject jsonObj = OperationResult.NORMAL_CODE.getResponseJsonObj();
		jsonObj.put("boogiBookDetail", boogiArray);

	    return jsonObj.toJSONString();
	}

	@SuppressWarnings("unchecked")
	public String searchPlaceJson(String keyword) {
	    ArrayList<StampDO> searchList = this.placeDAO.searchPlace(keyword);
	    
	    JSONArray jsonArr = new JSONArray();
	    JSONObject stObj = null;

	    for (StampDO place : searchList) {
	    	stObj = new JSONObject();

	    	stObj.put("placeId", place.getPlaceId());
	    	stObj.put("name", place.getName());
	    	stObj.put("addr", place.getAddr());
	    	stObj.put("lat", place.getLat());
	    	stObj.put("lon", place.getLon());
	    	stObj.put("thumbnail", place.getThumbnail());

	    	jsonArr.add(stObj);
	    }
	    
	    JSONObject jsonObj = OperationResult.NORMAL_CODE.getResponseJsonObj();
		jsonObj.put("searchList", jsonArr);

	    return jsonObj.toJSONString();
	}
	
	@SuppressWarnings("unchecked")
	public String getPlaceDetailJson(int placeId) {
		JSONObject jsonObj = null;
	    JSONObject pdObj = null;
		
	    try {
			PlaceDetailDO placeDetail = this.placeDAO.getPlaceDetail(placeId);
			
			pdObj = new JSONObject();
			pdObj = placeDetail.getJSONObject();
		    
		    jsonObj = OperationResult.NORMAL_CODE.getResponseJsonObj();
			jsonObj.put("placeDetail", pdObj);
		} 
	    catch (Exception e) {
	    	jsonObj = BoogiException.getResult(e).getResponseJsonObj();
		}
	    
	    return jsonObj.toJSONString();
	}
}

