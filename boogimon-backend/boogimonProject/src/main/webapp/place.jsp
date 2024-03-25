<%@ page contentType="application/json; charset=UTF-8" 
		 import="java.util.*, boogimon.*, model.*"
%>

<jsp:useBean id="placeDAO" class="model.place.PlaceDAO" scope="application"/>
<jsp:useBean id="userDO" class="model.user.UserDO" />
<jsp:setProperty name="userDO" property="*" />

<%
	response.setHeader("Access-Control-Allow-Origin","*");
	out.clearBuffer();
	PlaceJsonWriter placeJson = new PlaceJsonWriter(placeDAO);
	String command = request.getParameter("command");
	String jsonStr = "";
	int placeId = -1;
	
	if(request.getParameter("placeId") != null) {
		placeId = Integer.parseInt(request.getParameter("placeId"));
	}

	if(request.getMethod().equals("GET")){
		// 명소의 상세 정보 요청
		if(command == null && request.getParameter("placeId") != null) {
			jsonStr = placeJson.getPlaceDetailJson(placeId);
		}
		// 명소 목록 요청
		if(command != null && command.equals("list")){
			if(request.getParameter("keyword") != null){
				jsonStr = placeJson.searchPlaceJson((String)request.getParameter("keyword"));
			}
			else{
				jsonStr = placeJson.getGeneralResponse(OperationResult.NO_MANDATORY_REQUEST_PARAMETERS_ERROR); 
			}
		}
		// 사용자의 부기도감 리스트 요청
		if(command != null && command.equals("boogibook") && userDO.getUserId() != null){
			jsonStr = placeJson.getBoogiBookJson(userDO.getUserId());
		}
		// 사용자의 부기도감 히스토리 요청
		if(command != null && command.equals("boogibookDetail")){
			if(userDO.getUserId() != null && placeId != -1) {
				jsonStr = placeJson.getBoogiBookDetailJson(placeId, userDO.getUserId());
			}
			else {
				jsonStr = placeJson.getGeneralResponse(OperationResult.NO_MANDATORY_REQUEST_PARAMETERS_ERROR); 
			}
		}
	}
	
	// 잘못된 요청
	if(jsonStr.isEmpty()){
		jsonStr = placeJson.getGeneralResponse(OperationResult.INVALID_REQUEST_ERROR);
	}
	
	out.println(jsonStr);
	out.flush();
%>