<%@ page contentType="application/json; charset=UTF-8" 
		 import="java.util.*, boogimon.*, model.*, model.stampbook.*"
%>

<% request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean id="stbdDAO" class="model.stampbook.StampbookDetailDAO" scope="application"/>

<jsp:useBean id="commentDO" class="model.stampbook.CommentDO" />
<jsp:setProperty name="commentDO" property="*" />
<jsp:useBean id="stampbookDO" class="model.stampbook.StampbookDO" />
<jsp:setProperty name="stampbookDO" property="*" />
<jsp:useBean id="userDO" class="model.user.UserDO" />
<jsp:setProperty name="userDO" property="*" />

<%
	response.setHeader("Access-Control-Allow-Origin","*");
	out.clearBuffer();
	StampbookJsonWriter stbJson = new StampbookJsonWriter();
	stbJson.setStampbookDetailDAO(stbdDAO);
	String command = request.getParameter("command");
	OperationResult or = OperationResult.NORMAL_CODE;
	String jsonStr = "";

	if(request.getMethod().equals("GET")){
		// 특정 스탬프북의 코멘트 리스트 요청
		if(command != null && command.equals("list")){
			if(request.getParameter("stampbookId") != null){
				jsonStr = stbJson.getCommentListJson(stampbookDO.getStampbookId());
			}
			else{
				// stampbookId 필수 파라미터 누락
				jsonStr = stbJson.getGeneralResponse(OperationResult.NO_MANDATORY_REQUEST_PARAMETERS_ERROR);
			}
		}
		if(command != null && command.equals("delete")){
			if(commentDO.getUserId() != null && request.getParameter("commentId") != null){
				try {
					or = stbdDAO.deleteComment(commentDO) == 1 ? OperationResult.NORMAL_CODE : OperationResult.UPDATE_FAILED_ERROR;
				}
				catch(Exception e){
					or = BoogiException.getResult(e);
				}
			}
			else{
				// stampbookId 필수 파라미터 누락
				or = OperationResult.NO_MANDATORY_REQUEST_PARAMETERS_ERROR;
			}
			jsonStr = stbJson.getGeneralResponse(or);
		}
	}
	
	if(request.getMethod().equals("POST")){
		// 댓글 작성
		// 공백 불가 검사를 프론트에서..
		if(commentDO.getUserId() != null && commentDO.getComment() != null && commentDO.getComment().length() <= 250) {
			try {
				or = stbdDAO.insertComment(commentDO, stampbookDO.getStampbookId()) == 1 ? OperationResult.NORMAL_CODE : OperationResult.UPDATE_FAILED_ERROR;
			}
			catch(Exception e){
				or = BoogiException.getResult(e);
			}
		}
		else if(commentDO.getUserId() == null || commentDO.getComment() == null) {
			or = OperationResult.NO_MANDATORY_REQUEST_PARAMETERS_ERROR;
		}
		else {
			or = OperationResult.INVALID_REQUEST_PARAMETER_ERROR;
		}
		jsonStr = stbJson.getGeneralResponse(or);
	}
	
	if(jsonStr.isEmpty()){
		jsonStr = stbJson.getGeneralResponse(OperationResult.INVALID_REQUEST_ERROR);
	}
	
	out.println(jsonStr);
	out.flush();
%>