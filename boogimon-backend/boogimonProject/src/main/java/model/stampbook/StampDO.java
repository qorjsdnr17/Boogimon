package model.stampbook;

import java.util.ArrayList;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

public class StampDO {
	private int stampNo;
	private int placeId;
	private String name;
	private String addr;
	private String lat;
	private String lon;
	private String thumbnail;
	private String uploadImg;
	private String stampedDate;
	private String lastVisitDate;
	private int totalVisitCount;
	
	public StampDO() {
		
	}
	
	public StampDO(int stampNo, int placeId) {
		this.stampNo = stampNo;
		this.placeId = placeId;
	}

	public int getStampNo() {
		return stampNo;
	}

	public void setStampNo(int stampNo) {
		this.stampNo = stampNo;
	}

	public int getPlaceId() {
		return placeId;
	}

	public void setPlaceId(int placeId) {
		this.placeId = placeId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getAddr() {
		return addr;
	}

	public void setAddr(String addr) {
		this.addr = addr;
	}
	
	public String getLat() {
		return lat;
	}

	public void setLat(String lat) {
		this.lat = lat;
	}

	public String getLon() {
		return lon;
	}

	public void setLon(String lon) {
		this.lon = lon;
	}

	public String getThumbnail() {
		return thumbnail;
	}

	public void setThumbnail(String thumbnail) {
		this.thumbnail = thumbnail;
	}

	public String getUploadImg() {
		return uploadImg;
	}

	public void setUploadImg(String uploadImg) {
		this.uploadImg = uploadImg;
	}

	public String getStampedDate() {
		return stampedDate;
	}

	public void setStampedDate(String stampedDate) {
		this.stampedDate = stampedDate;
	}

	public String getLastVisitDate() {
		return lastVisitDate;
	}

	public void setLastVisitDate(String lastVisitDate) {
		this.lastVisitDate = lastVisitDate;
	}

	public int getTotalVisitCount() {
		return totalVisitCount;
	}

	public void setTotalVisitCount(int totalVisitCount) {
		this.totalVisitCount = totalVisitCount;
	}
	
	static public ArrayList<StampDO> JsonArrayToStampList(JSONArray jsonArr) {
		ArrayList<StampDO> stampList = new ArrayList<StampDO>();
		
		for(int i = 0; i < jsonArr.size(); i++) {
			stampList.add(
					new StampDO(
							Integer.parseInt(String.valueOf(((JSONObject)jsonArr.get(i)).get("stampNo"))), 
							Integer.parseInt(String.valueOf(((JSONObject)jsonArr.get(i)).get("placeId"))))
					);
		}
		return stampList;
	}
	
	public String toString() {
		return String.format("stampNo: %d / placeId: %d / placeName: %s \naddr: %s\nlat: %s / lon: %s\nthumbnail: %s\nuploadImg: %s\nstampedDate: %s / lastVisitDate: %s / totalVisitCount: %d\n", 
				this.stampNo, this.placeId, this.name, this.addr, this.lat, this.lon, this.thumbnail, this.uploadImg, this.stampedDate, this.lastVisitDate, this.totalVisitCount);
	}
}
