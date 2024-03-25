package model.user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import boogimon.BoogiException;
import model.OperationResult;

public class UserDAO {

	private Connection conn;
	private Statement stmt;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private String sql;
	private UserEncryption ue;
	
	public UserDAO() {
		String jdbc_driver = "oracle.jdbc.driver.OracleDriver";
		String jdbc_url = "jdbc:oracle:thin:@localhost:1521:XE";
		ue = new UserEncryption();
		
		try {
			Class.forName(jdbc_driver);
			conn = DriverManager.getConnection(jdbc_url, "scott", "tiger");
		}
		catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	//joinUser
	public int joinUser(UserDO boogiTrainer) throws Exception {
		int rowCount = 0;
	
		boolean isIdDuplicate = false;
		boolean isNicknameDuplicate = false;
		
		try {
			this.conn.setAutoCommit(false);
			
			this.sql = "select USER_ID from BoogiTrainer where USER_ID = ? union select NICKNAME from BoogiTrainer where NICKNAME = ?";
			
			pstmt = conn.prepareStatement(sql);			
			pstmt.setString(1, boogiTrainer.getUserId());
			pstmt.setString(2, boogiTrainer.getNickname());
			this.rs = pstmt.executeQuery();
			
			if(!rs.next()) {
				this.sql = "insert into BoogiTrainer (USER_ID, PASSWD, SALT, NICKNAME, PROFILE_IMG) values (?, ?, ?, ?, ?)";
				
				String salt = ue.getSalt();
				String pw = boogiTrainer.getPasswd();
				
				pstmt = conn.prepareStatement(sql);			
				pstmt.setString(1, boogiTrainer.getUserId());
				pstmt.setString(2, ue.hashing(pw, salt));
				pstmt.setString(3, salt);;
				pstmt.setString(4, boogiTrainer.getNickname());
				pstmt.setString(5, boogiTrainer.getProfileImg());
				
				rowCount = pstmt.executeUpdate();
				this.conn.commit();
			}
			else {
				isIdDuplicate = true;
				isNicknameDuplicate = true;
				this.conn.rollback();
			}
			
		}
		catch(Exception e) {
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
		
		if(isIdDuplicate) {
			throw new BoogiException(OperationResult.DUPLICATE_USERID_ERROR);
		}
		
		if(isNicknameDuplicate) {
			throw new BoogiException(OperationResult.DUPLICATE_NICKNAME_ERROR);
		}

		return rowCount;
	}
	
	public boolean loginCheck(UserDO user) {
		boolean result = false;
		
		sql = "select PASSWD, SALT, NICKNAME from BoogiTrainer where USER_ID = ? AND deleted = 0";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user.getUserId().toLowerCase());
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				String tempPw = rs.getString("PASSWD");
				String tempSalt = rs.getString("SALT");
				
				if(tempPw.equals(ue.hashing(user.getPasswd(), tempSalt))) {
					result = true;
				}
			}
			
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		finally {
			if(pstmt != null){
				try{
					pstmt.close();
				}
				catch(Exception e) {
					e.printStackTrace();
				}
			}
		}
		
		return result;
	}
	
	/** 회원 정보 요청 
	 * @throws Exception */
	public UserDO getUser(String userId) throws Exception {
		UserDO user = new UserDO();
		boolean notExists = false;
		
		try {
			// 사용자의 닉네임, 프로필 이미지, 가입일, 경험치, 스탬프 찍은 횟수, 받은 좋아요 수, 랭킹순위
			this.sql = "SELECT u.nickname, u.profile_img, TO_CHAR(u.regdate, 'YYYY-MM-DD HH24:MI:SS') AS regdate, u.exp, "
					+ "COUNT(ush.stamped_Date) AS totalVisit, nvl(likeCount, 0) AS likeCount, ur.rnum AS ranking "
					+ "FROM boogiTrainer u "
					+ "LEFT OUTER JOIN user_stamp_history ush ON u.user_id = ush.user_id "
					+ "LEFT OUTER JOIN (SELECT stb.user_id AS origin, COUNT(stb.user_id) AS likeCount "
					+ "FROM stampbook stb "
					+ "JOIN user_like ul ON ul.stampbook_id = stb.stampbook_id "
					+ "WHERE stb.user_id = ? "
					+ "GROUP BY stb.user_id) ON origin = u.user_id "
					+ "JOIN user_ranking ur ON ur.user_id = u.user_id "
					+ "WHERE u.user_id = ? "
					+ "GROUP BY u.nickname, u.profile_img, regdate, u.exp, likeCount, rnum";
			
			this.pstmt = conn.prepareStatement(sql);
			
			this.pstmt.setString(1, userId);
			this.pstmt.setString(2, userId);
			rs = this.pstmt.executeQuery();
			
			if(this.rs.next()) {
				user.setNickname(rs.getString("nickname"));
				user.setProfileImg(rs.getString("profile_img"));
				user.setRegdate(rs.getString("regdate"));
				user.setExp(rs.getInt("exp"));
				user.setUserTotalVisit(rs.getInt("totalVisit"));
				user.setUserLikeCount(rs.getInt("likeCount"));
				user.setRanking(rs.getInt("ranking"));
			}
			else {
				notExists = true;
			}
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
		
		if(notExists) {
			throw new BoogiException(OperationResult.NON_EXISTENT_USER_ERROR);
		}
		
		return user;
	}
	
	/** 닉네임 중복 체크 */
	public boolean isNicknameUnique(String nickname) throws Exception{
		boolean isNicknameUnique = true;
		
		this.sql = "select NICKNAME from BoogiTrainer where NICKNAME = ?";

	    try {
	    	  this.pstmt = conn.prepareStatement(sql);
	          this.pstmt.setString(1, nickname);
	          rs = pstmt.executeQuery();
	          
	          if(rs.next()) {
	        	  isNicknameUnique = false;
	          }
	         
	    } catch (Exception e) {
	        e.printStackTrace();
	        throw e;
	    }

	    return isNicknameUnique;
	}
	
	/** 회원 닉네임 수정 
	 * @throws Exception */
	public int changeNickname(UserDO BoogiTrainer) throws Exception {
	    int rowCount = 0;
	    this.sql = "update BoogiTrainer set NICKNAME = ? WHERE USER_ID = ?"; 

	    try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, BoogiTrainer.getNewNickname());
			pstmt.setString(2, BoogiTrainer.getUserId());
			rowCount = pstmt.executeUpdate(); 
		} 
	    catch (Exception e) {
	        e.printStackTrace();
	        throw e;
	    } finally {
	        try {
	            if (pstmt != null && !pstmt.isClosed()) {
	                pstmt.close();
	            }
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	    }

	    return rowCount;
	}
	
	/** 비밀번호 변경
	 *  비밀번호 변경은 변경되는 비밀번호와 salt를 새로 발급받아 같이 저장해야함
	 *  비밀번호 검증은 모두 front-end에서 수행
	 * @throws Exception */		
	public int changePasswd(UserDO user) throws Exception{
		int rowCount = 0;
		boolean notExists = false;
		
		try {
			this.conn.setAutoCommit(false);
			
			this.sql = "SELECT user_id FROM boogiTrainer WHERE user_id = ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user.getUserId());
			this.rs = pstmt.executeQuery();
			
			if(rs.next()) {

				this.sql = "UPDATE boogiTrainer SET passwd = ?, salt = ? WHERE user_id = ?";
				
				String salt = ue.getSalt();
				String pw = user.getNewPasswd();

				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, ue.hashing(pw, salt));
				pstmt.setString(2, salt);
				pstmt.setString(3, user.getUserId());
				
				rowCount = pstmt.executeUpdate();
				this.conn.commit();
			}
			else {
				notExists = true;
			}
		}
		catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
		finally {
			this.conn.setAutoCommit(true);
			try {
				if(!pstmt.isClosed()) {
					pstmt.close();
				}
			}
			catch(Exception e) {
				e.printStackTrace();
			}
		}
		
		if(notExists) {
			throw new BoogiException(OperationResult.NON_EXISTENT_USER_ERROR);
		}
		
		return rowCount;
	}
	
	/** 새 비밀번호 발급
	 *  비밀번호 변경은 변경되는 비밀번호와 salt를 새로 발급받아 같이 저장해야함
	 * @throws Exception */		
	public String getNewPasswd(UserDO user) throws Exception{
		int rowCount = 0;
		boolean notExists = false;
		String pw = ue.getSalt().substring(0, 8);
		
		try {
			this.conn.setAutoCommit(false);
			
			this.sql = "SELECT user_id FROM boogiTrainer WHERE user_id = ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user.getUserId());
			this.rs = pstmt.executeQuery();
			
			if(rs.next()) {

				this.sql = "UPDATE boogiTrainer SET passwd = ?, salt = ? WHERE user_id = ?";
				
				String salt = ue.getSalt();

				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, ue.hashing(ue.sha256(pw), salt));
				pstmt.setString(2, salt);
				pstmt.setString(3, user.getUserId());
				
				rowCount = pstmt.executeUpdate();
				
				if(rowCount == 1) {
					this.conn.commit();
				}
				else {
					throw new BoogiException(OperationResult.UPDATE_FAILED_ERROR);
				}

			}
			else {
				notExists = true;
			}
		}
		catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
		finally {
			this.conn.setAutoCommit(true);
			try {
				if(!pstmt.isClosed()) {
					pstmt.close();
				}
			}
			catch(Exception e) {
				e.printStackTrace();
			}
		}
		
		if(notExists) {
			throw new BoogiException(OperationResult.NON_EXISTENT_USER_ERROR);
		}
		
		return pw;
	}

	/** 회원 탈퇴 처리 (deleted = 1) 
	 * @throws Exception */
	public int deleteUser(String userId) throws Exception {
		int rowCount = 0;
		boolean notExists = false;
		
		try {
			this.conn.setAutoCommit(false);
			
			this.sql = "SELECT deleted FROM boogiTrainer WHERE user_id = ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userId);
			this.rs = pstmt.executeQuery();
			
			if(rs.next()) {
				if(rs.getInt("deleted") == 0) {
					this.sql = "UPDATE boogiTrainer SET deleted = 1 WHERE user_id = ?";
					
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, userId);
					rowCount = pstmt.executeUpdate();
					this.conn.commit();
				}
				else {
					/* TODO 이미 탈퇴한 유저에 대해 예외처리 */
				}
			}
			else {
				notExists = true;
			}
		}	
		catch(Exception e) {
			if(!pstmt.isClosed()) {
				pstmt.close();
			}
			this.conn.setAutoCommit(true);
			this.conn.rollback();
			e.printStackTrace();
			throw e;
		}
		finally {
			this.conn.setAutoCommit(true);
			try {
				if(!pstmt.isClosed()) {
					pstmt.close();
				}
			}
			catch(Exception e) {
				e.printStackTrace();
			}
		}
		
		if(notExists) {
			throw new BoogiException(OperationResult.NON_EXISTENT_USER_ERROR);
		}
		
		return rowCount;
	}
	
	/** 사용자 프로필 사진 교체 
	 * @throws Exception */
	public int changeImg(UserDO user) throws Exception {
		int rowCount = 0;
		
		boolean notExists = false;
		
		try {
			this.conn.setAutoCommit(false);
			
			this.sql = "SELECT user_id FROM boogiTrainer WHERE user_id = ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user.getUserId());
			this.rs = pstmt.executeQuery();
			
			if(rs.next()) {
				this.sql = "UPDATE boogiTrainer SET profile_img = ? WHERE user_id = ?";
				
				pstmt = conn.prepareStatement(sql);			
				pstmt.setString(1, user.getProfileImg());
				pstmt.setString(2, user.getUserId());
				
				rowCount = pstmt.executeUpdate();
				this.conn.commit();
			}
			else {
				notExists = true;
			}
			
		}
		catch(Exception e) {
			e.printStackTrace();
			this.conn.rollback();
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
				this.conn.rollback();
			}
		}
		
		if(notExists) {
			throw new BoogiException(OperationResult.NON_EXISTENT_USER_ERROR);
		}

		return rowCount;
	}
	
	public void closeConn() {
		try {
			if(!conn.isClosed()) {
				conn.close();
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
	}

}