<%@ page contentType="application/json; charset=UTF-8"
		 import="com.oreilly.servlet.*, com.oreilly.servlet.multipart.*"
		 import="java.util.*, boogimon.*, model.*, model.stampbook.*"
%>

<jsp:useBean id="stbdDAO" class="model.stampbook.StampbookDetailDAO" scope="application"/>
<jsp:useBean id="stampDO" class="model.stampbook.StampDO" />

<%
	response.setHeader("Access-Control-Allow-Origin","*");
	out.clearBuffer();
	
	// String directory = request.getServletContext().getRealPath("/images/upload/user/stamp/");
	// 테스트 환경의 절대경로 입력
	String directory = "/Users//projects/boogimon/boogimonProject/src/main/webapp/images/upload/user/stamp/";
	int sizeLimit = 1024 * 1024 * 5;		// 5MB 제한
	MultipartRequest multi = new MultipartRequest(request, directory, sizeLimit, "UTF-8", new BoogiFileRenamePolicy());
	
	StampbookJsonWriter stbJson = new StampbookJsonWriter();
	stbJson.setStampbookDetailDAO(stbdDAO);
	String command = (String)multi.getParameter("command");
	OperationResult or = OperationResult.NORMAL_CODE;
	String jsonStr = "";
	
	if(command != null) {
		// 회원의 스탬프 업로드
		if(command.equals("newStamp")){
			
			String userId = (String)multi.getParameter("userId");
			int stampbookId = Integer.parseInt(multi.getParameter("stampbookId"));
			stampDO.setStampNo(Integer.parseInt(multi.getParameter("stampNo")));
			
			if(multi.getFileNames().hasMoreElements()){
				stampDO.setUploadImg("/boogimon/images/upload/user/stamp/" + multi.getFilesystemName((String)multi.getFileNames().nextElement()));
				
				try {
					or = stbdDAO.setStampImg(userId, stampbookId, stampDO) == 1 ? OperationResult.NORMAL_CODE : OperationResult.UPDATE_FAILED_ERROR;
				}
				catch (Exception e){
					or = BoogiException.getResult(e);
				}
			}
			else{
				or = OperationResult.NO_MANDATORY_REQUEST_PARAMETERS_ERROR;
			}
			jsonStr = stbJson.getGeneralResponse(or);
		}
	}
	
	if(jsonStr.isEmpty()){
		jsonStr = stbJson.getGeneralResponse(OperationResult.INVALID_REQUEST_ERROR);
	}
	out.println(jsonStr);
	out.flush();
	
%>