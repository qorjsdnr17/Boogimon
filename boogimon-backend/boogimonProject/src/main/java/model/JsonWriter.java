package model;

public class JsonWriter {
	
	JsonWriter() {
	}
	
	public String getGeneralResponse(OperationResult or) {
		return or.getResponseJsonObj().toJSONString();
	}
}
