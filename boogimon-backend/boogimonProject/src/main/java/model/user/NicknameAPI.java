package model.user;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

public class NicknameAPI {

	static public String getNicknameAPI(String format, int count) throws Exception {
		String nickname = null;

		StringBuilder urlBuilder = new StringBuilder("https://nickname.hwanmoo.kr/?");

		urlBuilder.append("format=" + format);
		urlBuilder.append("&count=" + count);

		URL url = new URL(urlBuilder.toString());
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();

		conn.setRequestMethod("GET");
		// 타입 설정(json),Request Body 전달시 application/json로 서버 전달.
		conn.setRequestProperty("Content-type", "application/json");

		BufferedReader rd = null;

		try {
			
			if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
				rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			} else {
				rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
			}

			StringBuilder sb = new StringBuilder();
			String line;
			while ((line = rd.readLine()) != null) {
				sb.append(line);
			}

			if (sb.length() > 0 && sb.toString().startsWith("{")) {
				JSONParser parser = new JSONParser();
				JSONObject jsonObject = (JSONObject) parser.parse(sb.toString());

				JSONArray nicknames = (JSONArray) jsonObject.get("words");

				UserDAO userDAO = new UserDAO();

				if (nicknames != null && nicknames.size() > 0) {
					for (int i = 0; i < nicknames.size(); i++) {
						nickname = (String) nicknames.get(i);

						try {
							if (userDAO.isNicknameUnique(nickname)) {
								return nickname;
							}
						} catch (Exception e) {
							throw e;
						}
					}
				}

			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rd != null) {
				rd.close();
			}
			conn.disconnect();
		}
		
		return "";
	}
}
