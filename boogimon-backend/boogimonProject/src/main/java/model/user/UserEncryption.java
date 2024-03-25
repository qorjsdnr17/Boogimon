package model.user;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;

public class UserEncryption {
	
	private final int SALT_SIZE = 16;
	
	public UserEncryption() {
		
	}
	
	public String sha256(String passwd) throws NoSuchAlgorithmException {
		MessageDigest md;
		md = MessageDigest.getInstance("SHA-256");
		md.update(passwd.getBytes());
		return byteToString(md.digest());
	}
	
	public String hashing(String passwd, String salt) {
		
		MessageDigest md;
		byte[] tempByte = null;
		try { // SHA-256 해시함수를 사용 
			md = MessageDigest.getInstance("SHA-256");
			
			// key-stretching
			for(int i = 0; i < 50000; i++) {
				String temp = salt + passwd; 
				md.update(temp.getBytes()); 
				tempByte = md.digest();
				
				passwd = byteToString(tempByte);
			}
		} 
		catch (Exception e) {
			e.printStackTrace();
		}	
 
		return byteToString(tempByte);
	}
	
	public String getSalt(){
		SecureRandom sr = new SecureRandom();
		byte[] temp = new byte[SALT_SIZE];
		sr.nextBytes(temp);
		
		return byteToString(temp);
	}
	
	private String byteToString(byte[] temp) {
		StringBuilder sb = new StringBuilder();
		for(byte a : temp) {
			sb.append(String.format("%02x", a));
		}
		return sb.toString();
	}
}

