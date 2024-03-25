<%@page import="model.stampbook.StampDO"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.parser.JSONParser"%>
<%@page import="org.json.simple.JSONObject"%>
<%@ page contentType="application/json; charset=UTF-8" 
		 import="java.util.*, boogimon.*, model.*"
%>

<% request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean id="stbDAO" class="model.stampbook.StampbookDAO" scope="application"/>
<jsp:useBean id="stbdDAO" class="model.stampbook.StampbookDetailDAO" scope="application"/>

<jsp:useBean id="stampbookListDO" class="model.stampbook.StampbookListDO" />
<jsp:useBean id="stampbookDO" class="model.stampbook.StampbookDO" />
<jsp:setProperty name="stampbookDO" property="*" />
<jsp:useBean id="userDO" class="model.user.UserDO" />
<jsp:setProperty name="userDO" property="*" />

<%
	response.setHeader("Access-Control-Allow-Origin","*");
	out.clearBuffer();
	StampbookJsonWriter stbJson = new StampbookJsonWriter(stbDAO, stbdDAO);
	String command = request.getParameter("command");
	String jsonStr = "";
	OperationResult or = OperationResult.NORMAL_CODE;
	
	if(request.getMethod().equals("GET")){
		// 스탬프북의 상세 정보 요청
		if(command == null) {
			if(request.getParameter("stampbookId") != null){
				try{
					int stampbookId = Integer.parseInt(request.getParameter("stampbookId"));
					
					if(userDO.getUserId() != null) { 	// 로그인유저
						// 스탬프북DO에 요청받은 정보 탑재
						stampbookDO = stbDAO.getStampbook(stampbookId, userDO.getUserId());
						stampbookDO.setStampList(stbdDAO.getStamp(stampbookId, userDO.getUserId()));
						stampbookDO.setCommentList(stbdDAO.getComments(stampbookId));
					}
					else { 								// 비 로그인유저
						// 스탬프북DO에 요청받은 정보 탑재
						stampbookDO = stbDAO.getStampbook(stampbookId);
						stampbookDO.setStampList(stbdDAO.getStamp(stampbookId));
						stampbookDO.setCommentList(stbdDAO.getComments(stampbookId));
					}
					jsonStr = stbJson.getStampbookDetailJson(stampbookDO);
				}
				catch(Exception e) {
					jsonStr = stbJson.getGeneralResponse(BoogiException.getResult(e));
				}
			}
			else {
				jsonStr = stbJson.getGeneralResponse(OperationResult.NO_MANDATORY_REQUEST_PARAMETERS_ERROR);
			}
		}
		// 스탬프북 리스트 요청
		if(command != null && command.equals("list")){
			try{
				if(userDO.getUserId() == null){
					// 비로그인 유저
					stampbookListDO.setStampbookList(stbDAO.getAllStampbookWS());
				}
				else{
					// 로그인 한 사용자라면 각 스탬프북 좋아요 여부 포함한 리스트 반환
					stampbookListDO.setStampbookList(stbDAO.getAllStampbookWS(userDO.getUserId()));
				}
				
				jsonStr = stbJson.getStampbookListJson(stampbookListDO);
			}
			catch(Exception e){
				jsonStr = stbJson.getGeneralResponse(BoogiException.getResult(e));
			}
		}
		// 사용자의 마이페이지 스탬프북 리스트 요청
		if(command != null && command.equals("mylist")){
			if(userDO.getUserId() != null){
				try{
					// 잘못된 사용자 id가 입력되었을때 예외처리 DAO 수정 (아이디 확인)
					stampbookListDO.setStampbookList(stbDAO.getUsersStampbookWS(userDO.getUserId()));
					jsonStr = stbJson.getStampbookListJson(stampbookListDO);
				}
				catch(Exception e){
					jsonStr = stbJson.getGeneralResponse(BoogiException.getResult(e));
				}
			}
			else {
				// 필수 파라미터 누락
				jsonStr = stbJson.getGeneralResponse(OperationResult.NO_MANDATORY_REQUEST_PARAMETERS_ERROR);
			}
		}
		// 스탬프북 담기 취소
		if(command != null && command.equals("unpick")){
			if(request.getParameter("stampbookId") != null && userDO.getUserId() != null){
				try{
					or = stbDAO.unpickStampbook(userDO.getUserId(), stampbookDO.getStampbookId()) == 1 ? OperationResult.NORMAL_CODE : OperationResult.UPDATE_FAILED_ERROR;
				}
				catch(Exception e){
					or = BoogiException.getResult(e);
				}
			}
			else {
				// 필수 파라미터 누락
				or = OperationResult.NO_MANDATORY_REQUEST_PARAMETERS_ERROR;
			}
			jsonStr = stbJson.getGeneralResponse(or);
		}
		// 스탬프북 삭제
		if(command != null && command.equals("delete")){
			if(request.getParameter("stampbookId") != null && userDO.getUserId() != null){
				try{
					or = stbDAO.deleteStampbook(stampbookDO.getStampbookId(), userDO.getUserId()) == 1 ? OperationResult.NORMAL_CODE : OperationResult.UPDATE_FAILED_ERROR;
				}
				catch(Exception e){
					or = BoogiException.getResult(e);
				}
			}
			else {
				// 필수 파라미터 누락
				or = OperationResult.NO_MANDATORY_REQUEST_PARAMETERS_ERROR;
			}
			jsonStr = stbJson.getGeneralResponse(or);
		}
		// 스탬프북 좋아요
		if(command != null && command.equals("like")){
			if(request.getParameter("stampbookId") != null && userDO.getUserId() != null){
				try{
					or = stbDAO.likeStampbook(stampbookDO.getStampbookId(), userDO.getUserId()) == 1 ? OperationResult.NORMAL_CODE : OperationResult.UPDATE_FAILED_ERROR;
				}
				catch(Exception e){
					or = BoogiException.getResult(e);
				}
			}
			else {
				// 필수 파라미터 누락
				or = OperationResult.NO_MANDATORY_REQUEST_PARAMETERS_ERROR;
			}
			jsonStr = stbJson.getGeneralResponse(or);
		}
		// 스탬프북 좋아요 취소
		if(command != null && command.equals("unlike")){
			if(request.getParameter("stampbookId") != null && userDO.getUserId() != null){
				try{
					or = stbDAO.unlikeStampbook(stampbookDO.getStampbookId(), userDO.getUserId()) == 1 ? OperationResult.NORMAL_CODE : OperationResult.UPDATE_FAILED_ERROR;
				}
				catch(Exception e){
					or = BoogiException.getResult(e);
				}
			}
			else {
				// 필수 파라미터 누락
				or = OperationResult.NO_MANDATORY_REQUEST_PARAMETERS_ERROR;
			}
			jsonStr = stbJson.getGeneralResponse(or);
		}
	}
	
	if(request.getMethod().equals("POST")){
		// 스탬프북 생성
		if(command != null && command.equals("insert")) {
			
			if(userDO.getUserId() != null && stampbookDO.getTitle() != null && stampbookDO.getDescription() != null && request.getParameter("rStampList") != null){
				JSONParser jparser = new JSONParser();
				JSONArray jsonArr = (JSONArray) jparser.parse(request.getParameter("rStampList"));
				stampbookDO.setStampList(StampDO.JsonArrayToStampList(jsonArr));
				
				try {
					or = stbDAO.insertStampbook(stampbookDO, userDO.getUserId()) == 1 ? OperationResult.NORMAL_CODE : OperationResult.UPDATE_FAILED_ERROR;
				}
				catch (Exception e){
					or = BoogiException.getResult(e);
				}
			}
			else {
				// 필수 파라미터 누락
				or = OperationResult.NO_MANDATORY_REQUEST_PARAMETERS_ERROR;
			}
			
			jsonStr = stbJson.getGeneralResponse(or);
		}
		// 스탬프북 담기
		else if(command.equals("pick")){
			if(request.getParameter("stampbookId") != null && userDO.getUserId() != null){
				try{
					or = stbDAO.pickStampbook(stampbookDO.getStampbookId(), userDO.getUserId()) == 1 ? OperationResult.NORMAL_CODE : OperationResult.UPDATE_FAILED_ERROR;
				}
				catch (Exception e){
					or = BoogiException.getResult(e);
				}
			}
			else {
				// 필수 파라미터 누락
				or = OperationResult.NO_MANDATORY_REQUEST_PARAMETERS_ERROR;
			}
			
			jsonStr = stbJson.getGeneralResponse(or);
		}
	}
	
	// 잘못된 요청
	if(jsonStr.isEmpty()){
		jsonStr = stbJson.getGeneralResponse(OperationResult.INVALID_REQUEST_ERROR);
	}
	
	out.println(jsonStr);
	out.flush();
%>