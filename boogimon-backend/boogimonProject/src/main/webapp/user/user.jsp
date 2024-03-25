<%@ page contentType="application/json; charset=UTF-8" 
		 import="java.util.*, boogimon.*, model.*"
%>

<% request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean id="userDAO" class="model.user.UserDAO" scope="application"/>

<jsp:useBean id="userDO" class="model.user.UserDO" />
<jsp:setProperty name="userDO" property="*" />

<%
	response.setHeader("Access-Control-Allow-Origin","*");
	out.clearBuffer();
	UserJsonWriter userJson = new UserJsonWriter(userDAO);
	String command = request.getParameter("command");
	int resultCode = 0;
	String jsonStr = "";
	
	if(request.getMethod().equals("GET")){
		if(command == null){
			// 회원 정보 조회
			if(userDO.getUserId() != null){
				jsonStr = userJson.getUserInfo(userDO);	
			}
			else {
				// 필수 파라미터 누락
				jsonStr = userJson.getGeneralResponse(OperationResult.NO_MANDATORY_REQUEST_PARAMETERS_ERROR);
			}
		}
		if(command != null && command.equals("randomNickname")){
			jsonStr = userJson.getRandomNickname();
		}
		if(command != null && command.equals("newPasswd")){
			if(userDO.getUserId() != null){
				jsonStr = userJson.getNewPasswd(userDO);
			}
			else{
				jsonStr = userJson.getGeneralResponse(OperationResult.NO_MANDATORY_REQUEST_PARAMETERS_ERROR);
			}
		}
	}
	
	if(request.getMethod().equals("POST")){
		// 로그인 처리
		if(command != null && command.equals("login")){
			try{
				jsonStr = userJson.authLogin(userDO);
			}
			catch(Exception e){
				jsonStr = BoogiException.getResult(e).getResponseJsonObj().toJSONString();
			}
		}
		// 회원 가입
		else if(command != null && command.equals("join")){
			try {
				jsonStr = userDAO.joinUser(userDO) == 1 ? 
						OperationResult.NORMAL_CODE.getResponseJsonObj().toJSONString() 
						: OperationResult.UPDATE_FAILED_ERROR.getResponseJsonObj().toJSONString();
			}
			catch (Exception e){
				jsonStr = BoogiException.getResult(e).getResponseJsonObj().toJSONString();
			}
		}
		// 닉네임 수정 
		else if(command != null && command.equals("changeNickname")){
			System.out.println(userDO.getUserId());
			System.out.println(userDO.getNewNickname());
			// 필수 파라미터 검사
			if(userDO.getUserId() != null && userDO.getNewNickname() != null){
				try {
					jsonStr = userDAO.changeNickname(userDO) == 1 ? 
							OperationResult.NORMAL_CODE.getResponseJsonObj().toJSONString() 
							: OperationResult.UPDATE_FAILED_ERROR.getResponseJsonObj().toJSONString();
				}
				catch (Exception e){
					jsonStr = BoogiException.getResult(e).getResponseJsonObj().toJSONString();
				}
			}
			else{
				jsonStr = userJson.getGeneralResponse(OperationResult.NO_MANDATORY_REQUEST_PARAMETERS_ERROR);
			}
		}
		// 패스워드 수정 
		else if(command != null && command.equals("changePasswd")){
			// 필수 파라미터 검사
			if(userDO.getUserId() != null && userDO.getNewPasswd() != null){
				try {
					jsonStr = userDAO.changePasswd(userDO) == 1 ? 
							OperationResult.NORMAL_CODE.getResponseJsonObj().toJSONString() 
							: OperationResult.UPDATE_FAILED_ERROR.getResponseJsonObj().toJSONString();
				}
				catch (Exception e){
					jsonStr = BoogiException.getResult(e).getResponseJsonObj().toJSONString();
				}
			}
			else{
				jsonStr = userJson.getGeneralResponse(OperationResult.NO_MANDATORY_REQUEST_PARAMETERS_ERROR);
			}
		}
		// 회원 탈퇴 
		else if(command != null && command.equals("delete")){
			// 필수 파라미터 검사
			if(userDO.getUserId() != null){
				try {
					jsonStr = userDAO.deleteUser(userDO.getUserId()) == 1 ? 
							OperationResult.NORMAL_CODE.getResponseJsonObj().toJSONString() 
							: OperationResult.UPDATE_FAILED_ERROR.getResponseJsonObj().toJSONString();
				}
				catch (Exception e){
					jsonStr = BoogiException.getResult(e).getResponseJsonObj().toJSONString();
				}
			}
			else{
				jsonStr = userJson.getGeneralResponse(OperationResult.NO_MANDATORY_REQUEST_PARAMETERS_ERROR);
			}
		}
	}
	
	// 잘못된 요청
	if(jsonStr.isEmpty()){
		jsonStr = userJson.getGeneralResponse(OperationResult.INVALID_REQUEST_ERROR);
	}
	
	out.println(jsonStr);
	out.flush();
%>