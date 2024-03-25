package model.place;

import org.json.simple.JSONObject;

public class PlaceDetailDO {
	private String name;
	private String addr;
	private String tel;
	private String detail;
	private String pay;
	private String traffic;
	private String img;
	private String homepage;
	private String open;
	private String close;
	private String facility;
	
	public PlaceDetailDO() {
		
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

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public String getDetail() {
		return detail;
	}

	public void setDetail(String detail) {
		this.detail = detail;
	}

	public String getPay() {
		return pay;
	}

	public void setPay(String pay) {
		this.pay = pay;
	}

	public String getTraffic() {
		return traffic;
	}

	public void setTraffic(String traffic) {
		this.traffic = traffic;
	}

	public String getImg() {
		return img;
	}

	public void setImg(String img) {
		this.img = img;
	}

	public String getHomepage() {
		return homepage;
	}

	public void setHomepage(String homepage) {
		this.homepage = homepage;
	}

	public String getOpen() {
		return open;
	}

	public void setOpen(String open) {
		this.open = open;
	}

	public String getClose() {
		return close;
	}

	public void setClose(String close) {
		this.close = close;
	}

	public String getFacility() {
		return facility;
	}

	public void setFacility(String facility) {
		this.facility = facility;
	}

	@SuppressWarnings("unchecked")
	public JSONObject getJSONObject() {
		JSONObject jsonObj = new JSONObject();
		
		jsonObj.put("name", this.name);
		jsonObj.put("addr", this.addr);
		jsonObj.put("tel", this.tel);
		jsonObj.put("detail", this.detail);
		jsonObj.put("pay", this.pay);
		jsonObj.put("traffic", this.traffic);
		jsonObj.put("img", this.img);
		jsonObj.put("homepage", this.homepage);
		jsonObj.put("open", this.open);
		jsonObj.put("close", this.close);
		jsonObj.put("facility", this.facility);
		
		return jsonObj;
	}
	
	public String toString() {
		return String.format("Name: %s / Addr: %s / Tel: %s \nDetail: %s \nPay: %s / Traffic: %s \nImg: %s \nHomepage: %s \nOpen: %s / Close: %s \nFacility: %s \n", 
				this.name, this.addr, this.tel, this.detail, this.pay, this.traffic, this.img, this.homepage, this.open, this.close, this.facility);
	}
}
