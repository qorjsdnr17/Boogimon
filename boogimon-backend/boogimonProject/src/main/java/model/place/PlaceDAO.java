package model.place;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import boogimon.BoogiException;
import model.OperationResult;
import model.stampbook.StampDO;

public class PlaceDAO {

	private Connection conn;
	private Statement stmt;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private String sql;
	
	public PlaceDAO() {
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
	
	//getAllBoogiDex
	public ArrayList<StampDO> getAllBoogiBook(String userId) {
		
		ArrayList<StampDO> boogiBookList = new ArrayList<StampDO>();
		this.sql ="SELECT PLACE.PLACE_ID, PLACE.NAME, USER_STAMP_HISTORY.UPLOAD_IMG, MAX(USER_STAMP_HISTORY.STAMPED_DATE) AS LAST_VISIT_DATE, COUNT(USER_STAMP_HISTORY.STAMPNO) AS TOTAL_VISIT_COUNT "+
				  "FROM USER_STAMP_HISTORY "+
				  "JOIN STAMP ON USER_STAMP_HISTORY.STAMPBOOK_ID = STAMP.STAMPBOOK_ID AND USER_STAMP_HISTORY.STAMPNO = STAMP.STAMPNO "+
				  "JOIN PLACE ON STAMP.PLACE_ID = PLACE.PLACE_ID "+
				  "WHERE USER_STAMP_HISTORY.USER_ID = ? "+
				  "GROUP BY PLACE.PLACE_ID, PLACE.NAME, USER_STAMP_HISTORY.UPLOAD_IMG "+
				  "UNION ALL "+
				  "SELECT PLACE.PLACE_ID, PLACE.NAME, PLACE.THUMBNAIL AS UPLOAD_IMG, NULL AS LAST_VISIT_DATE, NULL AS TOTAL_VISIT_COUNT "+
				  "FROM PLACE ";
		
		try {
			pstmt = conn.prepareStatement(this.sql);
			pstmt.setString(1, userId);
			rs = pstmt.executeQuery();
			StampDO boogiBook = null;
			
			while(rs.next()) {
				boogiBook = new StampDO();
				
				boogiBook.setPlaceId(rs.getInt("PLACE_ID"));
				boogiBook.setThumbnail(rs.getString("UPLOAD_IMG"));
				boogiBook.setName(rs.getString("NAME"));
				boogiBook.setLastVisitDate(rs.getString("LAST_VISIT_DATE"));
				boogiBook.setTotalVisitCount(rs.getInt("TOTAL_VISIT_COUNT"));
				
				boogiBookList.add(boogiBook);
			}
		}
		
		catch(Exception e) {
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
		
		return boogiBookList;
	}
	
	/** getBoogiBook */
	public ArrayList<StampDO> getBoogiBook(int placeId, String name) {
	    ArrayList<StampDO> boogiBookDetailList = new ArrayList<StampDO>();
	    this.sql = "SELECT PLACE.PLACE_ID, PLACE.NAME, USER_STAMP_HISTORY.UPLOAD_IMG, USER_STAMP_HISTORY.STAMPED_DATE " +
	               "FROM USER_STAMP_HISTORY " +
	               "JOIN STAMP ON USER_STAMP_HISTORY.STAMPBOOK_ID = STAMP.STAMPBOOK_ID AND USER_STAMP_HISTORY.STAMPNO = STAMP.STAMPNO " +
	               "JOIN PLACE ON STAMP.PLACE_ID = PLACE.PLACE_ID " +
	               "WHERE USER_STAMP_HISTORY.USER_ID = ? AND PLACE.PLACE_ID = ?" +
	               "ORDER BY USER_STAMP_HISTORY.STAMPED_DATE DESC ";

	    try {
	        pstmt = conn.prepareStatement(this.sql);

	        // Set the parameters
	        pstmt.setString(1, name);
	        pstmt.setInt(2, placeId);

	        rs = pstmt.executeQuery();
	        while (rs.next()) {
	            StampDO boogiBookDetail = new StampDO();

	            boogiBookDetail.setPlaceId(rs.getInt("PLACE_ID"));
	            boogiBookDetail.setName(rs.getString("NAME"));
	            boogiBookDetail.setUploadImg(rs.getString("UPLOAD_IMG"));
	            boogiBookDetail.setStampedDate(rs.getString("STAMPED_DATE"));

	            boogiBookDetailList.add(boogiBookDetail);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        try {
	            if (!pstmt.isClosed()) {
	                pstmt.close();
	            }
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	    }

	    return boogiBookDetailList;
	}

	/** 명소의 상세 정보를 반환 */
	public PlaceDetailDO getPlaceDetail(int place_id) throws Exception {
		PlaceDetailDO placeDetail = null;
		boolean exists = true;
		
		this.sql = "SELECT name, addr, type, contents_id FROM place where place_id = ?";
		
		try {
			this.pstmt = this.conn.prepareStatement(sql);
			this.pstmt.setInt(1, place_id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				// place type이 900번대일 경우 = 부기몬이 제공하는 place detail 제공
				if((rs.getInt("type") / 100) == 9) {
					this.sql = "SELECT p.name, p.addr, pd.tel, pd.detail, pd.pay, pd.traffic, pd.img, pd.homepage, pd.open, pd.close, pd.facility FROM place p "
							+ "JOIN place_detail pd ON p.place_id = pd.place_id WHERE p.place_id = ?";
					this.pstmt = this.conn.prepareStatement(sql);
					this.pstmt.setInt(1, place_id);
					rs = pstmt.executeQuery();
					
					if(rs.next()) {
						placeDetail = new PlaceDetailDO();
						
						placeDetail.setName(rs.getString("name"));
						placeDetail.setAddr(rs.getString("addr"));
						placeDetail.setTel(rs.getString("tel"));
						placeDetail.setDetail(rs.getString("detail"));
						placeDetail.setPay(rs.getString("pay"));
						placeDetail.setTraffic(rs.getString("traffic"));
						placeDetail.setImg(rs.getString("img"));
						placeDetail.setHomepage(rs.getString("homepage"));
						placeDetail.setOpen(rs.getString("open"));
						placeDetail.setClose(rs.getString("close"));
						placeDetail.setFacility(rs.getString("facility"));
					}
				}
				// 그 이외일 경우 공공데이터 API 요청으로 데이터 제공
				else {
					OpenData openData = new OpenData();
					placeDetail = openData.getOpenDataAPI(rs.getInt("type"), rs.getString("contents_id"), "kr");
					placeDetail.setName(rs.getString("name"));
					placeDetail.setAddr(rs.getString("addr"));
				}
			}
			// 해당 place_id로 db검색했는데 없다??
			else {
				exists = false;
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
		
		if(!exists) {
			throw new BoogiException(OperationResult.NON_EXISTENT_PLACE_ERROR);
		}
		
		return placeDetail;
	}
	
	/** 주소와 명칭으로 검색된 명소 리스트 반환 */
	public ArrayList<StampDO> searchPlace(String keyword){
		ArrayList<StampDO> stampList = new ArrayList<StampDO>();
		StampDO stamp = null;
		
		this.sql = "SELECT * FROM place "
				 + "WHERE name LIKE ? OR addr LIKE ?";
		
		try {
			this.pstmt = this.conn.prepareStatement(sql);
			this.pstmt.setString(1, "%" + keyword + "%");
			this.pstmt.setString(2, "%" + keyword + "%");
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				stamp = new StampDO();
				
				stamp.setPlaceId(rs.getInt("place_id"));
				stamp.setName(rs.getString("name"));
				stamp.setAddr(rs.getString("addr"));
				stamp.setLat(rs.getString("lat"));
				stamp.setLon(rs.getString("lon"));
				stamp.setThumbnail(rs.getString("thumbnail"));
				
				stampList.add(stamp);
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
		
		return stampList;
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
