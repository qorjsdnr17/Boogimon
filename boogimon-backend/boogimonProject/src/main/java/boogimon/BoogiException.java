package boogimon;

import java.sql.SQLException;

import model.OperationResult;

@SuppressWarnings("serial")
public class BoogiException extends Exception {
	private final OperationResult or;

	public BoogiException() {
		this(OperationResult.UNKNOWN_ERROR);
	}
	
	public BoogiException(OperationResult or) {
		super(or.getMsg());
		this.or = or;
	}
	
	public int getErrCode() {
		return this.or.getResultCode();
	}
	
	/** Exception객체의 OperationResult를 반환 */
	static public OperationResult getResult(Exception e) {
		return (e instanceof BoogiException) ? ((BoogiException) e).or : 
			(e instanceof SQLException) ? OperationResult.DB_ERROR : 
				OperationResult.UNKNOWN_ERROR;
	}
	
//	static public int getErrCode(Exception e) {
//		return (e instanceof BoogiException) ? ((BoogiException) e).getErrCode() : 
//			(e instanceof SQLException) ? OperationResult.DB_ERROR.getResultCode() : 
//				OperationResult.UNKNOWN_ERROR.getResultCode();
//	}
}
