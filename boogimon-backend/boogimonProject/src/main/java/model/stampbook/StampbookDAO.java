package model.stampbook;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import boogimon.BoogiException;
import model.OperationResult;

public class StampbookDAO {
	
	private Connection conn;
	private Statement stmt;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private PreparedStatement pstmt2;
	private ResultSet rs2;
	private String sql;
	
	public StampbookDAO() {
		String jdbc_driver = "oracle.jdbc.driver.OracleDriver";
		String jdbc_url = "jdbc:oracle:thin:@localhost:1521:XE";
		
		try {
			Class.forName(jdbc_driver);
			conn = DriverManager.getConnection(jdbc_url, "scott", "tiger");
		}
		catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	/** 스탬프북 전체 리스트 요청 */
	public ArrayList<StampbookDO> getAllStampbook(){
		ArrayList<StampbookDO> stampbookList = new ArrayList<StampbookDO>();
		StampbookDO stampbook = null;
		
		this.sql = "SELECT stb.stampbook_id, stb.title, stb.description, bt.nickname, bt.profile_img, to_char(stb.stampbook_regdate, 'YYYY-MM-DD HH24:MI:SS') as stampbookRegdate, stb.likeCount "
				+ "FROM stampbook stb INNER JOIN boogiTrainer bt ON stb.user_id = bt.user_id WHERE stb.deleted = 0";
		
		try {
			stmt = this.conn.createStatement();
			rs = stmt.executeQuery(sql);
			
			while(rs.next()) {
				stampbook = new StampbookDO();
				
				stampbook.setStampbookId(rs.getInt("stampbook_id"));
				stampbook.setTitle(rs.getString("title"));
				stampbook.setDescription(rs.getString("description"));
				stampbook.setNickname(rs.getString("nickname"));
				stampbook.setProfileImg(rs.getString("profile_img"));
				stampbook.setStampbookRegdate(rs.getString("stampbookRegdate"));
				stampbook.setLikeCount(rs.getInt("likeCount"));
				
				stampbookList.add(stampbook);
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally {
			try {
				if(!stmt.isClosed()) {
					stmt.close();
				}
			}
			catch(Exception e) {
				e.printStackTrace();
			}
		}
		
		return stampbookList;
	}
	
	/** 로그인한 사용자의 메인페이지 스탬프북 리스트 출력 */
	public ArrayList<StampbookDO> getAllStampbook(String user_id) throws Exception{
		ArrayList<StampbookDO> stampbookList = new ArrayList<StampbookDO>();
		StampbookDO stampbook = null;
		boolean notExists = false;
		boolean isDeleted = false;
		
		try {
			// 회원 체크
			this.sql = "SELECT deleted FROM boogiTrainer WHERE user_id = ?";
			this.pstmt = this.conn.prepareStatement(sql);
			this.pstmt.setString(1, user_id);
			rs = pstmt.executeQuery();
			
			// 회원이 존재하고
			if(rs.next()) {
				// 탈퇴한 회원이 아닐때 쿼리 실행
				if(rs.getInt("deleted") == 0) {
					this.sql = "SELECT stb.stampbook_id, stb.title, stb.description, bt.nickname, bt.profile_img, to_char(stb.stampbook_regdate, 'YYYY-MM-DD HH24:MI:SS') AS stampbookRegdate, stb.likeCount, "
							+ "nvl2(ul.user_id, 1, 0) AS isLike "
							+ "FROM stampbook stb "
							+ "INNER JOIN boogiTrainer bt ON stb.user_id = bt.user_id "
							+ "LEFT OUTER JOIN user_like ul ON ul.stampbook_id = stb.stampbook_id AND ul.user_id = ? "
							+ "WHERE stb.deleted = 0";
					
					this.pstmt = this.conn.prepareStatement(sql);
					this.pstmt.setString(1, user_id);
					rs = pstmt.executeQuery();
					
					while(rs.next()) {
						stampbook = new StampbookDO();
						
						stampbook.setStampbookId(rs.getInt("stampbook_id"));
						stampbook.setTitle(rs.getString("title"));
						stampbook.setDescription(rs.getString("description"));
						stampbook.setNickname(rs.getString("nickname"));
						stampbook.setProfileImg(rs.getString("profile_img"));
						stampbook.setStampbookRegdate(rs.getString("stampbookRegdate"));
						stampbook.setLikeCount(rs.getInt("likeCount"));
						stampbook.setLiked(rs.getInt("isLike"));
						
						stampbookList.add(stampbook);
					}
				}
				else {
					// 탈퇴한 회원
					isDeleted = true;
				}
			}
			else {
				// 존재하지 않는 회원
				notExists = true;
			}
			
		}
		catch(Exception e){
			e.printStackTrace();
			throw e;
		}
		finally {
			try {
				if(!pstmt.isClosed()) {
					pstmt.close();
				}
			}
			catch(Exception e) {
				e.printStackTrace();
			}
		}
		
		if(isDeleted) {
			throw new BoogiException(OperationResult.DELETED_USER_ERROR);
		}
		if(notExists) {
			throw new BoogiException(OperationResult.NON_EXISTENT_USER_ERROR);
		}
		
		return stampbookList;
	}
	
	/** my페이지(내 스탬프북)의 스탬프북 리스트 요청 */
	public ArrayList<StampbookDO> getUsersStampbook(String user_id) throws Exception{
		ArrayList<StampbookDO> stampbookList = new ArrayList<StampbookDO>();
		StampbookDO stampbook = null;
		boolean notExists = false;
		boolean isDeleted = false;
		
		try {
			// 회원 체크
			this.sql = "SELECT deleted FROM boogiTrainer WHERE user_id = ?";
			this.pstmt = this.conn.prepareStatement(sql);
			this.pstmt.setString(1, user_id);
			rs = pstmt.executeQuery();
			
			// 회원이 존재하고
			if(rs.next()) {
				// 탈퇴한 회원이 아닐때 쿼리 실행
				if(rs.getInt("deleted") == 0) {
					this.sql = "SELECT stb.stampbook_id, stb.title, stb.description, bt.nickname, bt.profile_img, "
							+ "to_char(stb.stampbook_regdate, 'YYYY-MM-DD HH24:MI:SS') AS stampbookRegdate, up.complete_date, stb.likeCount, "
							+ "nvl2(ul.user_id, 1, 0) AS isLike "
							+ "FROM user_pick up "
							+ "INNER JOIN stampbook stb ON up.stampbook_id = stb.stampbook_id "
							+ "INNER JOIN boogiTrainer bt ON stb.user_id = bt.user_id "
							+ "LEFT OUTER JOIN user_like ul ON ul.stampbook_id = stb.stampbook_id AND ul.user_id = up.user_id "
							+ "WHERE up.user_id = ?";
					
					this.pstmt = this.conn.prepareStatement(sql);
					this.pstmt.setString(1, user_id);
					rs = pstmt.executeQuery();
					
					while(rs.next()) {
						stampbook = new StampbookDO();
						
						stampbook.setStampbookId(rs.getInt("stampbook_id"));
						stampbook.setTitle(rs.getString("title"));
						stampbook.setDescription(rs.getString("description"));
						stampbook.setNickname(rs.getString("nickname"));
						stampbook.setProfileImg(rs.getString("profile_img"));
						stampbook.setStampbookRegdate(rs.getString("stampbookRegdate"));
						stampbook.setCompleteDate(rs.getString("complete_date"));
						stampbook.setLikeCount(rs.getInt("likeCount"));
						stampbook.setLiked(rs.getInt("isLike"));
						
						stampbookList.add(stampbook);
					}
				}
				else {
					// 탈퇴한 회원
					isDeleted = true;
				}
			}
			else {
				// 존재하지 않는 회원
				notExists = true;
			}
		}
		catch(Exception e){
			e.printStackTrace();
			throw e;
		}
		finally {
			try {
				if(!pstmt.isClosed()) {
					pstmt.close();
				}
			}
			catch(Exception e) {
				e.printStackTrace();
			}
		}
		
		if(isDeleted) {
			throw new BoogiException(OperationResult.DELETED_USER_ERROR);
		}
		if(notExists) {
			throw new BoogiException(OperationResult.NON_EXISTENT_USER_ERROR);
		}
		
		return stampbookList;
	}
	
	/** 스탬프북 상세 설명 요청 */
	public StampbookDO getStampbook(int stampbook_id){
		StampbookDO stampbook = new StampbookDO();
		
		this.sql = "SELECT stampbook_id, title, description, bt.nickname, bt.profile_img, to_char(stampbook_regdate, 'YYYY-MM-DD HH24:MI:SS') as stampbookRegdate, likeCount FROM stampbook " +
					"INNER JOIN boogiTrainer bt ON stampbook.user_id = bt.user_id " + 
					"WHERE stampbook_id = ? AND stampbook.deleted = 0";
		
		try {
			this.pstmt = this.conn.prepareStatement(sql);
			
			this.pstmt.setInt(1, stampbook_id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				stampbook.setStampbookId(rs.getInt("stampbook_id"));
				stampbook.setTitle(rs.getString("title"));
				stampbook.setDescription(rs.getString("description"));
				stampbook.setNickname(rs.getString("nickname"));
				stampbook.setProfileImg(rs.getString("profile_img"));				
				stampbook.setStampbookRegdate(rs.getString("stampbookRegdate"));
				stampbook.setLikeCount(rs.getInt("likeCount"));
			}
			else {
				// 해당 스탬프북이 없을 때 예외 발생
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally {
			try {
				if(!pstmt.isClosed()) {
					pstmt.close();
				}
			}
			catch(Exception e) {
				e.printStackTrace();
			}
		}
		
		return stampbook;
	}
	
	/** 로그인한 유저의 스탬프북 상세 설명 요청 
	 * @throws Exception */
	public StampbookDO getStampbook(int stampbookId, String userId) throws Exception{
		StampbookDO stampbook = new StampbookDO();
		
		boolean invalidUser = false;
		boolean notExists = false;
		
		try {
			// 회원 체크
			this.sql = "SELECT deleted FROM boogiTrainer WHERE user_id = ?";
			this.pstmt = this.conn.prepareStatement(sql);
			this.pstmt.setString(1, userId);
			rs = pstmt.executeQuery();
			
			// 회원이 존재하고
			if(rs.next()) {
				// 탈퇴한 회원이 아닐때 쿼리 실행
				if(rs.getInt("deleted") == 0) {
					
					this.sql = "SELECT stb.stampbook_id, stb.title, stb.description, bt.nickname, bt.profile_img, to_char(stampbook_regdate, 'YYYY-MM-DD HH24:MI:SS') as stampbookRegdate, likeCount, "
							+ "nvl2(ul.user_id, 1, 0) AS isLike, "
							+ "nvl2(up.pick_date, 1, 0) AS isPick "
							+ "FROM stampbook stb "
							+ "INNER JOIN boogiTrainer bt ON stb.user_id = bt.user_id "
							+ "LEFT OUTER JOIN user_like ul ON ul.stampbook_id = stb.stampbook_id AND ul.user_id = ? "
							+ "LEFT OUTER JOIN user_pick up ON up.stampbook_id = stb.stampbook_id AND up.user_id = ? "
							+ "WHERE stb.stampbook_id = ?";
					
					this.pstmt = this.conn.prepareStatement(sql);
					
					this.pstmt.setString(1, userId);
					this.pstmt.setString(2, userId);
					this.pstmt.setInt(3, stampbookId);
					rs = pstmt.executeQuery();
					
					if(rs.next()) {
						stampbook.setStampbookId(rs.getInt("stampbook_id"));
						stampbook.setTitle(rs.getString("title"));
						stampbook.setDescription(rs.getString("description"));
						stampbook.setNickname(rs.getString("nickname"));
						stampbook.setProfileImg(rs.getString("profile_img"));				
						stampbook.setStampbookRegdate(rs.getString("stampbookRegdate"));
						stampbook.setLikeCount(rs.getInt("likeCount"));
						stampbook.setLiked(rs.getInt("isLike"));
						stampbook.setPicked(rs.getInt("isPick"));
					}
					else {
						// 존재하지 않는 스탬프북
						notExists = true;
					}
				}
				else {
					// 잘못된 회원 요청
					invalidUser = true;
				}
			}
			else {
				// 잘못된 회원 요청
				invalidUser = true;
			}
		}
		catch(Exception e){
			e.printStackTrace();
			throw e;
		}
		finally {
			try {
				if(!pstmt.isClosed()) {
					pstmt.close();
				}
			}
			catch(Exception e) {
				e.printStackTrace();
			}
		}
		
		if(invalidUser) {
			throw new BoogiException(OperationResult.INVALID_USER_ERROR);
		}
		if(notExists) {
			throw new BoogiException(OperationResult.NON_EXISTENT_STAMPBOOK_ERROR);
		}
		
		return stampbook;
	}
	
	/** 스탬프북 담기 기능 */ 
	public int pickStampbook(int stampbook_id, String user_id) throws Exception {
		int rowCount = 0;
		boolean idDeleted = false;
		boolean pickStampbookFailure = false;
		
		try {
			this.conn.setAutoCommit(false);
			
			// 담기 전 삭제된 스탬프북인지 확인
			this.sql = "SELECT STAMPBOOK_ID FROM STAMPBOOK WHERE stampbook_id = ? AND deleted = 0";
			
			this.pstmt = this.conn.prepareStatement(sql);
			this.pstmt.setInt(1, stampbook_id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				// 삭제된 스탬프북이 아니라면 담기
				this.sql = "INSERT INTO USER_PICK (USER_ID, STAMPBOOK_ID) "
						 + "VALUES (?, ?)";
				
				this.pstmt = this.conn.prepareStatement(sql);
				
				this.pstmt.setString(1, user_id);
				this.pstmt.setInt(2, stampbook_id);
				rowCount = pstmt.executeUpdate();
				
				if(rowCount == 1) {
					this.conn.commit();
				}
				else {
					pickStampbookFailure = true;
					this.conn.rollback();
				}
			}
			else {
				idDeleted = true;
				this.conn.rollback();
			}
			
		}
		catch(Exception e) {
			this.conn.rollback();
			e.printStackTrace();
		}
		finally {
			try {
				this.conn.setAutoCommit(true);
				
				if(!pstmt.isClosed()) {
					pstmt.close();
				}
			}
			catch(Exception e) {
				e.printStackTrace();
			}
		}
		
		if(idDeleted) {
			throw new BoogiException(OperationResult.DELETED_STAMPBOOK_ERROR);
		}
		if(pickStampbookFailure) {
			throw new BoogiException(OperationResult.STAMPBOOK_PICK_FAILED_ERROR);
		}
		
		return rowCount;
	}
	
	/** 스탬프북 테이블에서 해당 스탬프북 삭제 처리(deleted = 1) 
	 * 	TODO: 사용자에 따른 예외처리 (원작자 검색: 잘못된 사용자 요청) 
	 * @throws Exception */
	public int deleteStampbook(int stampbook_id, String userId) throws Exception {
		
		int rowCount = 0;
		
		try {
			this.sql = "UPDATE STAMPBOOK "
					 + "SET deleted = 1 "
					 + "WHERE stampbook_id = ? AND user_id = ?";
			
			this.pstmt = this.conn.prepareStatement(sql);
			this.pstmt.setInt(1, stampbook_id);
			this.pstmt.setString(2, userId);
			
			rowCount = pstmt.executeUpdate();
		}
		catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
		finally {
			try {
				if(!pstmt.isClosed()) {
					pstmt.close();
				}
			}
			catch(Exception e) {
				e.printStackTrace();
			}
		}
		
		return rowCount;
	}
	
	/** 담기 취소. 스탬프북 원작자가 아닌 사용자가 마이페이지에서 담긴 스탬프북을 삭제할 때 처리 */
	public int unpickStampbook(String user_id, int stampbook_id) throws Exception {
		int rowCount = 0;
		
		try {
			this.conn.setAutoCommit(false);
			
			// 담은 스탬프북에 연결된 사용자의 스탬프 모두 삭제
			this.sql = "DELETE FROM user_stamp_history WHERE user_id = ? AND stampbook_id = ?";
			this.pstmt = this.conn.prepareStatement(sql);
			
			this.pstmt.setString(1, user_id);
			this.pstmt.setInt(2, stampbook_id);
			pstmt.executeUpdate();
			
			
			// 담은 스탬프북 삭제
			this.sql = "DELETE FROM user_pick WHERE user_id = ? AND stampbook_id = ?";
			this.pstmt = this.conn.prepareStatement(sql);
			
			this.pstmt.setString(1, user_id);
			this.pstmt.setInt(2, stampbook_id);
			rowCount = pstmt.executeUpdate();
			
			this.conn.commit();
			
		}
		catch(Exception e) {
			this.conn.rollback();
			e.printStackTrace();
			throw e;
		}
		finally {
			try {
				this.conn.setAutoCommit(true);
				
				if(!pstmt.isClosed()) {
					pstmt.close();
				}
			}
			catch(Exception e) {
				e.printStackTrace();
			}
		}
		
		return rowCount;
	}
	
	/** 스탬프북 좋아요 기능*/
	public int likeStampbook(int stampbook_id, String user_id) throws Exception {
		int rowCount = 0;
		boolean isDuplicate = false;
		boolean isDeleted = false;
		boolean notExists = false;
		boolean insertFailure = false;
		boolean updateFailure = false;
		
		try {
			this.conn.setAutoCommit(false);
			
			// 이미 좋아요 한 스탬프북인지 확인
			this.sql = "SELECT stb.deleted, ul.user_id FROM stampbook stb "
					 + "LEFT OUTER JOIN user_like ul ON ul.stampbook_id = stb.stampbook_id AND ul.user_id = ? "
					 + "WHERE stb.stampbook_id = ?";
			
			this.pstmt = this.conn.prepareStatement(sql);
			this.pstmt.setString(1, user_id);
			this.pstmt.setInt(2, stampbook_id);
			rs = pstmt.executeQuery();
			
			// rs.next() 가 있어야 stampbook에 존재하는 스탬프북
			// rs.getInt("deleted") == 0 : 삭제된 스탬프북이 아니며 
			// rs.getString("user_id") == null : 사용자가 좋아요를 하지 않은 상태여야만 (중복검사)
			if(rs.next() && rs.getInt("deleted") == 0 && rs.getString("user_id") == null) {
				// user_like 테이블에 삽입
				this.sql = "INSERT INTO USER_LIKE (USER_ID, STAMPBOOK_ID) "
						 + "VALUES (?, ?)";
				this.pstmt = this.conn.prepareStatement(sql);
				this.pstmt.setString(1, user_id);
				this.pstmt.setInt(2, stampbook_id);
				rowCount = pstmt.executeUpdate();
				
				// 삽입된 내용이 하나가 아니라면 오류 //?? 그런데 insert 는 1, 0 외에 있을 수가 있나 
				if(!(rowCount == 1)) {
					insertFailure = true;
					this.conn.rollback();
				}
				else {
					// 정상적으로 입력되었다면 stampbook의 likeCount 증가
					this.sql = "UPDATE stampbook SET likeCount = likeCount + 1 WHERE stampbook_id = ?";
					this.pstmt = this.conn.prepareStatement(sql);
					this.pstmt.setInt(1, stampbook_id);
					rowCount = pstmt.executeUpdate();
					
					//아무튼 잘못 삽입되면 롤백
					if(rowCount != 1) {
						updateFailure = true;
						this.conn.rollback();
					}
					
					this.conn.commit();
				}
			}
			else if(rs.getString("user_id") != null){
				isDuplicate = true;
				this.conn.rollback();
			}
			else if(rs.getInt("deleted") == 1) {
				isDeleted = true;
				this.conn.rollback();
			}
			else {
				notExists = true;
				this.conn.rollback();
			}
		}
		catch(Exception e) {
			this.conn.rollback();
			e.printStackTrace();
		}
		finally {
			try {
				this.conn.setAutoCommit(true);
				
				if(!pstmt.isClosed()) {
					pstmt.close();
				}
			}
			catch(Exception e) {
				e.printStackTrace();
			}
		}
		
		if(isDuplicate) {
			// 중복된 요청 
			throw new BoogiException(OperationResult.DUPLICATE_REQUEST_ERROR);
		}
		if(isDeleted) {
			// 삭제된 스탬프북
			throw new BoogiException(OperationResult.DELETED_STAMPBOOK_ERROR);
		}
		if(notExists) {
			// 존재하지 않는 스탬프북
			throw new BoogiException(OperationResult.NON_EXISTENT_STAMPBOOK_ERROR);
		}
		if(insertFailure) {
			throw new BoogiException(OperationResult.LIKE_PROCESSING_FAILED_ERROR);
		}
		if(updateFailure) {
			throw new BoogiException(OperationResult.LIKE_COUNT_INCREMENT_FAILED_ERROR);
		}
		
		return rowCount;
	}
	
	/** 스탬프북 좋아요 취소 기능 
	 *  TODO: 중복된 요청인지 예외처리 */
	public int unlikeStampbook(int stampbook_id, String user_id) throws Exception {
		int rowCount = 0;
		boolean deleteFailure = false;
		boolean updateFailure = false;
		
		try {
			this.conn.setAutoCommit(false);
			
			// user_like 테이블에 삽입
			this.sql = "DELETE FROM user_like WHERE user_id = ? AND stampbook_id = ?";
			this.pstmt = this.conn.prepareStatement(sql);
			this.pstmt.setString(1, user_id);
			this.pstmt.setInt(2, stampbook_id);
			rowCount = pstmt.executeUpdate();
			
			// 삭제된 내용이 하나가 아니라면 오류로 rollback
			if(!(rowCount == 1)) {
				deleteFailure = true;
				this.conn.rollback();
			}
			else {
				// 정상적으로 삭제되었다면 stampbook의 likeCount 감소
				this.sql = "UPDATE stampbook SET likeCount = likeCount - 1 WHERE stampbook_id = ?";
				this.pstmt = this.conn.prepareStatement(sql);
				this.pstmt.setInt(1, stampbook_id);
				rowCount = pstmt.executeUpdate();
				
				//아무튼 잘못 삽입되면 롤백
				if(rowCount != 1) {
					updateFailure = true;
					this.conn.rollback();
				}
				
				this.conn.commit();
			}
		
		}
		catch(Exception e) {
			this.conn.rollback();
			e.printStackTrace();
		}
		finally {
			try {
				this.conn.setAutoCommit(true);
				
				if(!pstmt.isClosed()) {
					pstmt.close();
				}
			}
			catch(Exception e) {
				e.printStackTrace();
			}
		}
		
		if(deleteFailure) {
			throw new BoogiException(OperationResult.UNLIKE_PROCESSING_FAILED_ERROR);
		}
		if(updateFailure) {
			throw new BoogiException(OperationResult.LIKE_COUNT_DECREMENT_FAILED_ERROR);
		}
		
		return rowCount;
	}
	
	/** 회원이 만든 스탬프북 삽입 
	 * @throws Exception */
	public int insertStampbook(StampbookDO stampbook, String userId) throws Exception {
		int rowCount = 0;
		
		boolean notExists = false;
		boolean isDeleted = false;
		boolean insertStampbookFailure = false;
		boolean insertStampFailure = false;
		boolean pickStampbookFailure = false;
		
		try {
			// 회원 체크
			this.sql = "SELECT deleted FROM boogiTrainer WHERE user_id = ?";
			this.pstmt = this.conn.prepareStatement(sql);
			this.pstmt.setString(1, userId);
			rs = pstmt.executeQuery();
			
			// 회원이 존재하고
			if(rs.next()) {
				// 탈퇴한 회원이 아닐때 쿼리 실행
				if(rs.getInt("deleted") == 0) {
					this.conn.setAutoCommit(false);
					
					// 스탬프북 생성 쿼리
					this.sql = "INSERT INTO STAMPBOOK (STAMPBOOK_ID, TITLE, DESCRIPTION, USER_ID) "
							 + "VALUES (seq_stampbook_id.nextval, ?, ?, ?)";
					
					this.pstmt = this.conn.prepareStatement(sql);
					this.pstmt.setString(1, stampbook.getTitle());
					this.pstmt.setString(2, stampbook.getDescription());
					this.pstmt.setString(3, userId);
					rowCount = pstmt.executeUpdate();
					
					if(rowCount == 1) {
						for(StampDO stamp : stampbook.getStampList()) {
							// 스탬프 생성 쿼리
							this.sql = "INSERT INTO STAMP (STAMPBOOK_ID, STAMPNO, PLACE_ID) "
									 + "VALUES (seq_stampbook_id.currval, ?, ?)";
							
							this.pstmt = this.conn.prepareStatement(sql);
							this.pstmt.setInt(1, stamp.getStampNo());
							this.pstmt.setInt(2, stamp.getPlaceId());
							rowCount = pstmt.executeUpdate();
							
							if(rowCount != 1) {
								// 스탬프 생성 실패
								this.conn.rollback();
								insertStampFailure = true;
								break;
							}
						}
						
						// 스탬프 생성도 정상으로 끝났다면
						if(!insertStampbookFailure) {
							// 스탬프북 작성자에게 자동으로 스탬프북 담기
							this.sql = "INSERT INTO USER_PICK (USER_ID, STAMPBOOK_ID) "
									+ "VALUES (?, seq_stampbook_id.currval)";
							
							this.pstmt = this.conn.prepareStatement(sql);
							this.pstmt.setString(1, userId);
							rowCount = pstmt.executeUpdate();
							
							// 정상적으로 pick된다면
							if(rowCount == 1) {
								this.conn.commit();
							}
							else {
								this.conn.rollback();
								pickStampbookFailure = true;
							}
						}
					}
					else {
						// 스탬프북 생성 실패
						this.conn.rollback();
						insertStampbookFailure = true;
					}
				}
				else {
					// 탈퇴한 회원
					isDeleted = true;
				}
			}
			else {
				// 존재하지 않는 회원
				notExists = true;
			}
		}
		catch(Exception e){
			e.printStackTrace();
			this.conn.rollback();
			throw e;
		}
		finally {
			try {
				this.conn.setAutoCommit(true);
				if(!pstmt.isClosed()) {
					pstmt.close();
				}
			}
			catch(Exception e) {
				e.printStackTrace();
			}
		}
		
		if(isDeleted) {
			throw new BoogiException(OperationResult.DELETED_USER_ERROR);
		}
		if(notExists) {
			throw new BoogiException(OperationResult.NON_EXISTENT_USER_ERROR);
		}
		if(insertStampbookFailure) {
			throw new BoogiException(OperationResult.STAMPBOOK_CREATION_FAILED_ERROR);
		}
		if(insertStampFailure) {
			throw new BoogiException(OperationResult.STAMP_CREATION_FAILED_ERROR);
		}
		if(pickStampbookFailure) {
			throw new BoogiException(OperationResult.STAMPBOOK_PICK_FAILED_ERROR);
		}
		
		return rowCount; 
	}
	
	
	/** 스탬프북 전체 리스트 요청 with 스탬프 이미지 */
	public ArrayList<StampbookDO> getAllStampbookWS(){
		ArrayList<StampbookDO> stampbookList = new ArrayList<StampbookDO>();
		ArrayList<StampDO> stampList = null;
		StampbookDO stampbook = null;
		StampDO stamp = null;
		String sub = "";
		
		this.sql = "SELECT stb.stampbook_id, stb.title, stb.description, bt.nickname, bt.profile_img, to_char(stb.stampbook_regdate, 'YYYY-MM-DD HH24:MI:SS') as stampbookRegdate, stb.likeCount "
				+ "FROM stampbook stb INNER JOIN boogiTrainer bt ON stb.user_id = bt.user_id WHERE stb.deleted = 0";
		
		try {
			stmt = this.conn.createStatement();
			rs = stmt.executeQuery(sql);
			
			while(rs.next()) {
				stampbook = new StampbookDO();
				
				stampbook.setStampbookId(rs.getInt("stampbook_id"));
				stampbook.setTitle(rs.getString("title"));
				stampbook.setDescription(rs.getString("description"));
				stampbook.setNickname(rs.getString("nickname"));
				stampbook.setProfileImg(rs.getString("profile_img"));
				stampbook.setStampbookRegdate(rs.getString("stampbookRegdate"));
				stampbook.setLikeCount(rs.getInt("likeCount"));
				
				// 스탬프북 썸네일
				sub = "SELECT st.stampno, p.name, p.thumbnail "
						+ "FROM STAMP st "
						+ "JOIN PLACE p ON st.place_id = p.place_id "
						+ "WHERE st.stampbook_id = ? "
						+ "ORDER BY st.stampno";
				
				this.pstmt2 = this.conn.prepareStatement(sub);
				this.pstmt2.setInt(1, stampbook.getStampbookId());
				rs2 = pstmt2.executeQuery();
				stampList = new ArrayList<StampDO>();
				while(rs2.next()) {
					stamp = new StampDO();
					
					stamp.setStampNo(rs2.getInt("stampno"));
					stamp.setName(rs2.getString("name"));
					stamp.setThumbnail(rs2.getString("thumbnail"));
					
					stampList.add(stamp);
				}
				stampbook.setStampList(stampList);
				
				stampbookList.add(stampbook);
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally {
			try {
				if(!stmt.isClosed()) {
					stmt.close();
				}
			}
			catch(Exception e) {
				e.printStackTrace();
			}
		}
		
		return stampbookList;
	}
	
	/** 로그인한 사용자의 메인페이지 스탬프북 리스트 출력 with 스탬프 이미지 */
	public ArrayList<StampbookDO> getAllStampbookWS(String user_id) throws Exception{
		ArrayList<StampbookDO> stampbookList = new ArrayList<StampbookDO>();
		ArrayList<StampDO> stampList = null;
		StampbookDO stampbook = null;
		StampDO stamp = null;
		String sub = "";
		
		boolean notExists = false;
		boolean isDeleted = false;
		
		try {
			// 회원 체크
			this.sql = "SELECT deleted FROM boogiTrainer WHERE user_id = ?";
			this.pstmt = this.conn.prepareStatement(sql);
			this.pstmt.setString(1, user_id);
			rs = pstmt.executeQuery();
			
			// 회원이 존재하고
			if(rs.next()) {
				// 탈퇴한 회원이 아닐때 쿼리 실행
				if(rs.getInt("deleted") == 0) {
					this.sql = "SELECT stb.stampbook_id, stb.title, stb.description, bt.nickname, bt.profile_img, to_char(stb.stampbook_regdate, 'YYYY-MM-DD HH24:MI:SS') AS stampbookRegdate, stb.likeCount, "
							+ "nvl2(ul.user_id, 1, 0) AS isLike, "
							+ "nvl2(up.pick_date, 1, 0) AS isPick "
							+ "FROM stampbook stb "
							+ "INNER JOIN boogiTrainer bt ON stb.user_id = bt.user_id "
							+ "LEFT OUTER JOIN user_like ul ON ul.stampbook_id = stb.stampbook_id AND ul.user_id = ? "
							+ "LEFT OUTER JOIN user_pick up ON up.stampbook_id = stb.stampbook_id AND up.user_id = ? "
							+ "WHERE stb.deleted = 0";
					
					this.pstmt = this.conn.prepareStatement(sql);
					this.pstmt.setString(1, user_id);
					this.pstmt.setString(2, user_id);
					rs = pstmt.executeQuery();
					
					while(rs.next()) {
						stampbook = new StampbookDO();
						
						stampbook.setStampbookId(rs.getInt("stampbook_id"));
						stampbook.setTitle(rs.getString("title"));
						stampbook.setDescription(rs.getString("description"));
						stampbook.setNickname(rs.getString("nickname"));
						stampbook.setProfileImg(rs.getString("profile_img"));
						stampbook.setStampbookRegdate(rs.getString("stampbookRegdate"));
						stampbook.setLikeCount(rs.getInt("likeCount"));
						stampbook.setLiked(rs.getInt("isLike"));
						stampbook.setPicked(rs.getInt("isPick"));
						
						// 스탬프북 썸네일 
						sub = "SELECT st.stampno, p.name, p.thumbnail "
								+ "FROM STAMP st "
								+ "JOIN PLACE p ON st.place_id = p.place_id "
								+ "WHERE st.stampbook_id = ? "
								+ "ORDER BY st.stampno";
						
						this.pstmt2 = this.conn.prepareStatement(sub);
						this.pstmt2.setInt(1, stampbook.getStampbookId());
						rs2 = pstmt2.executeQuery();
						stampList = new ArrayList<StampDO>();
						while(rs2.next()) {
							stamp = new StampDO();
							
							stamp.setStampNo(rs2.getInt("stampno"));
							stamp.setName(rs2.getString("name"));
							stamp.setThumbnail(rs2.getString("thumbnail"));
							
							stampList.add(stamp);
						}
						stampbook.setStampList(stampList);
						
						stampbookList.add(stampbook);
					}
				}
				else {
					// 탈퇴한 회원
					isDeleted = true;
				}
			}
			else {
				// 존재하지 않는 회원
				notExists = true;
			}
			
		}
		catch(Exception e){
			e.printStackTrace();
			throw e;
		}
		finally {
			try {
				if(!pstmt.isClosed()) {
					pstmt.close();
				}
				if(!pstmt2.isClosed()) {
					pstmt2.close();
				}
			}
			catch(Exception e) {
				e.printStackTrace();
			}
		}
		
		if(isDeleted) {
			throw new BoogiException(OperationResult.DELETED_USER_ERROR);
		}
		if(notExists) {
			throw new BoogiException(OperationResult.NON_EXISTENT_USER_ERROR);
		}
		
		return stampbookList;
	}
	
	/** my페이지(내 스탬프북)의 스탬프북 리스트 요청 with 스탬프 이미지 */
	public ArrayList<StampbookDO> getUsersStampbookWS(String user_id) throws Exception{
		ArrayList<StampbookDO> stampbookList = new ArrayList<StampbookDO>();
		ArrayList<StampDO> stampList = null;
		StampbookDO stampbook = null;
		StampDO stamp = null;
		String sub = "";
		
		boolean notExists = false;
		boolean isDeleted = false;
		
		try {
			// 회원 체크
			this.sql = "SELECT deleted FROM boogiTrainer WHERE user_id = ?";
			this.pstmt = this.conn.prepareStatement(sql);
			this.pstmt.setString(1, user_id);
			rs = pstmt.executeQuery();
			
			// 회원이 존재하고
			if(rs.next()) {
				// 탈퇴한 회원이 아닐때 쿼리 실행
				if(rs.getInt("deleted") == 0) {
					this.sql = "SELECT stb.stampbook_id, stb.title, stb.description, bt.nickname, bt.profile_img, "
							+ "to_char(stb.stampbook_regdate, 'YYYY-MM-DD HH24:MI:SS') AS stampbookRegdate, up.complete_date, stb.likeCount, "
							+ "nvl2(ul.user_id, 1, 0) AS isLike "
							+ "FROM user_pick up "
							+ "INNER JOIN stampbook stb ON up.stampbook_id = stb.stampbook_id "
							+ "INNER JOIN boogiTrainer bt ON stb.user_id = bt.user_id "
							+ "LEFT OUTER JOIN user_like ul ON ul.stampbook_id = stb.stampbook_id AND ul.user_id = up.user_id "
							+ "WHERE up.user_id = ?";
					
					this.pstmt = this.conn.prepareStatement(sql);
					this.pstmt.setString(1, user_id);
					rs = pstmt.executeQuery();
					
					while(rs.next()) {
						stampbook = new StampbookDO();
						
						stampbook.setStampbookId(rs.getInt("stampbook_id"));
						stampbook.setTitle(rs.getString("title"));
						stampbook.setDescription(rs.getString("description"));
						stampbook.setNickname(rs.getString("nickname"));
						stampbook.setProfileImg(rs.getString("profile_img"));
						stampbook.setStampbookRegdate(rs.getString("stampbookRegdate"));
						stampbook.setCompleteDate(rs.getString("complete_date"));
						stampbook.setLikeCount(rs.getInt("likeCount"));
						stampbook.setLiked(rs.getInt("isLike"));
						stampbook.setPicked(1); // user_pick에서 불러옴으로 무조건 pick
						
						// 스탬프북 썸네일 
						sub = "SELECT st.stampno, st.place_id, p.name, p.lat, p.lon, p.thumbnail, ush.user_id, ush.upload_img, to_char(ush.stamped_date, 'YYYY-MM-DD HH24:MI:SS') as stamped_date "
								+ "FROM STAMP st JOIN PLACE p ON st.place_id = p.place_id "
								+ "LEFT OUTER JOIN USER_STAMP_HISTORY ush ON ush.stampbook_id = st.stampbook_id AND ush.stampno = st.stampno AND ush.user_id = ? "
								+ "WHERE st.stampbook_id = ? "
								+ "ORDER BY st.stampno";
						
						this.pstmt2 = this.conn.prepareStatement(sub);
						this.pstmt2.setString(1, user_id);
						this.pstmt2.setInt(2, stampbook.getStampbookId());
						rs2 = pstmt2.executeQuery();
						stampList = new ArrayList<StampDO>();
						while(rs2.next()) {
							stamp = new StampDO();
							
							stamp.setStampNo(rs2.getInt("stampno"));
							stamp.setName(rs2.getString("name"));
							
							if(rs2.getString("upload_img") != null) {
								stamp.setThumbnail(rs2.getString("upload_img"));
								stamp.setStampedDate(rs2.getString("stamped_date"));
							}
							else {
								stamp.setThumbnail(rs2.getString("thumbnail"));
							}
							
							stampList.add(stamp);
						}
						stampbook.setStampList(stampList);
						
						stampbookList.add(stampbook);
					}
				}
				else {
					// 탈퇴한 회원
					isDeleted = true;
				}
			}
			else {
				// 존재하지 않는 회원
				notExists = true;
			}
		}
		catch(Exception e){
			e.printStackTrace();
			throw e;
		}
		finally {
			try {
				if(!pstmt.isClosed()) {
					pstmt.close();
				}
				if(!pstmt2.isClosed()) {
					pstmt2.close();
				}
			}
			catch(Exception e) {
				e.printStackTrace();
			}
		}
		
		if(isDeleted) {
			throw new BoogiException(OperationResult.DELETED_USER_ERROR);
		}
		if(notExists) {
			throw new BoogiException(OperationResult.NON_EXISTENT_USER_ERROR);
		}
		
		return stampbookList;
	}
	
	public void closeConn() {
		if(conn != null) {
			try {
				conn.close();
			}
			catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
}
