package model;

import org.json.simple.JSONObject;

public enum OperationResult {
	
	NORMAL_CODE(0, "정상"),
	DB_ERROR(1, "DB에러"),
	UPDATE_FAILED_ERROR(2, "DB업데이트 실패"),
	INVALID_REQUEST_ERROR(10, "잘못된 요청"),
	INVALID_REQUEST_PARAMETER_ERROR(11, "잘못된 파라미터 값"),
	NO_MANDATORY_REQUEST_PARAMETERS_ERROR(12, "필수 파라미터 누락"),
	DUPLICATE_REQUEST_ERROR(13, "중복된 요청"),
	NON_EXISTENT_USER_ERROR(20, "존재하지 않는 사용자"),
	INVALID_USER_ERROR(21, "잘못된 사용자 요청"),
	DUPLICATE_USERID_ERROR(22, "중복된 사용자ID"),
	DUPLICATE_NICKNAME_ERROR(23, "중복된 닉네임"),
	DELETED_USER_ERROR(24, "탈퇴한 회원"),
	RANDOM_NICKNAME_GENERATION_FAILED_ERROR(25, "랜덤 닉네임 생성 실패"),
	USER_EXP_CHANGE_FAILED(26, "경험치 증감 처리 실패"),
	NON_EXISTENT_STAMPBOOK_ERROR(30, "존재하지 않는 스탬프북"),
	DELETED_STAMPBOOK_ERROR(31, "삭제된 스탬프북"),
	LIKE_PROCESSING_FAILED_ERROR(32, "좋아요 작업 실패"),
	UNLIKE_PROCESSING_FAILED_ERROR(33, "좋아요 취소 작업 실패"),
	LIKE_COUNT_INCREMENT_FAILED_ERROR(34, "좋아요수 가산 실패"),
	LIKE_COUNT_DECREMENT_FAILED_ERROR(35, "좋아요수 감산 실패"),
	ALREADY_PICKED_STAMPBOOK_ERROR(36, "사용자가 이미 담은 스탬프북"),
	UNPICKED_STAMPBOOK_ERROR(37, "사용자가 담지 않은 스탬프북"),
	STAMPBOOK_CREATION_FAILED_ERROR(38, "스탬프북 생성 실패"),
	STAMPBOOK_PICK_FAILED_ERROR(39, "스탬프북 담기 실패"),
	STAMPBOOK_COMPLETE_PROCESS_FAILED_ERROR(40, "스탬프북 컴플리트 처리 실패"),
	NON_EXISTENT_STAMP_ERROR(50, "존재하지 않는 스탬프"),
	STAMP_CREATION_FAILED_ERROR(51, "스탬프 생성 실패"),
	STAMP_UPLOAD_FAILED_ERROR(52, "스탬프 업로드 실패"),
	NON_EXISTENT_PLACE_ERROR(60, "존재하지 않는 명소"),
	UNKNOWN_ERROR(99, "기타 에러");
	
	private final int resultCode;
	private final String msg;
	
	private OperationResult(int resultCode, String msg) {
		this.resultCode = resultCode;
		this.msg = msg;
	}
	
	public int getResultCode() {
		return this.resultCode;
	}
	
	public String getMsg() {
		return this.msg;
	}
	
	@SuppressWarnings("unchecked")
	public JSONObject getResponseJsonObj() {
		JSONObject headerObj = new JSONObject();
		
		// resultCode에 맞는 헤더 생성
		headerObj.put("resultCode", String.format("%02d", this.resultCode));
		headerObj.put("resultMsg", this.msg);
		
		return headerObj;
	}
	
	/** ResultCode와 msg를 jsonObject로 반환 */
	@SuppressWarnings("unchecked")
	public static JSONObject getResponseJsonObj(OperationResult or) {
		JSONObject headerObj = new JSONObject();
		
		// resultCode에 맞는 헤더 생성
		headerObj.put("resultCode", String.format("%02d", or.resultCode));
		headerObj.put("resultMsg", or.msg);
		
		return headerObj;
	}
}