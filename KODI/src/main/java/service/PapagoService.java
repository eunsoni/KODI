package service;

//네이버 Papago Text Translation API 예제
import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import dao.LiveChatDAO;

@Service("papagoservice")
public class PapagoService{
	
	@Autowired
	@Qualifier("livechatdao")
	LiveChatDAO dao;
	
	@Value("${papago.client.id}")
	private String clientId;
	
	@Value("${papago.client.secret}")
	private String clientSecret;
	
	/**
	 * 메시지 보낸 사람과 현재 사용자의 국적 비교
	 * @param memberIdx
	 * @param msgMemberIdx
	 * @return 국적이 같은지(false) 다른지(true) 여부
	 */
	public boolean compareLang(int memberIdx, int msgMemberIdx) {
		String srcLangType; // 메시지 보낸 친구 국적
		String tarLangType; // 내 국적
		
		String friendCountry = dao.selectCountry(msgMemberIdx);
		String myCountry = dao.selectCountry(memberIdx);
		
		if(friendCountry.equals("South Korea")) {
			srcLangType = "ko";
		} else if (friendCountry.equals("Japan")) {
			srcLangType = "ja";
		} else if (friendCountry.equals("China")) {
			srcLangType = "zh-TW";
		} else if (friendCountry.equals("Vietnam")) {
			srcLangType = "vi";
		} else if (friendCountry.equals("Thailand")) {
			srcLangType = "th";
		} else if (friendCountry.equals("Indonesia")) {
			srcLangType = "id";
		} else if (friendCountry.equals("France")) {
			srcLangType = "fr";
		} else if (friendCountry.equals("Spain")) {
			srcLangType = "es";
		} else if (friendCountry.equals("Russia")) {
			srcLangType = "ru";
		} else if (friendCountry.equals("Germany")) {
			srcLangType = "de";
		} else if (friendCountry.equals("Italy")) {
			srcLangType = "it";
		} else {
			srcLangType = "en";
		}
		
		if(myCountry.equals("South Korea")) {
			tarLangType = "ko";
		} else if (myCountry.equals("Japan")) {
			tarLangType = "ja";
		} else if (myCountry.equals("China")) {
			tarLangType = "zh-TW";
		} else if (myCountry.equals("Vietnam")) {
			tarLangType = "vi";
		} else if (myCountry.equals("Thailand")) {
			tarLangType = "th";
		} else if (myCountry.equals("Indonesia")) {
			tarLangType = "id";
		} else if (myCountry.equals("France")) {
			tarLangType = "fr";
		} else if (myCountry.equals("Spain")) {
			tarLangType = "es";
		} else if (myCountry.equals("Russia")) {
			tarLangType = "ru";
		} else if (myCountry.equals("Germany")) {
			tarLangType = "de";
		} else if (myCountry.equals("Italy")) {
			tarLangType = "it";
		} else {
			tarLangType = "en";
		}
		
		if(srcLangType == tarLangType) {
			return false;
		} else {
			return true;
		}
	}
	

	/**
	 * 채팅방 메시지 국적에 따라 번역
	 * @param text
	 * @return 번역한 내용
	 */
	public String translateMsg(int memberIdx, int msgMemberIdx, String text) {
		String result = "";
		
		try {
			// request
			text = URLEncoder.encode(text, "UTF-8");
			String apiURL = "https://naveropenapi.apigw.ntruss.com/nmt/v1/translation";
			URL url = new URL(apiURL);
			HttpURLConnection con = (HttpURLConnection) url.openConnection();
			con.setRequestMethod("POST");
			con.setRequestProperty("X-NCP-APIGW-API-KEY-ID", clientId);
			con.setRequestProperty("X-NCP-APIGW-API-KEY", clientSecret);
			
			// post request
			String srcLangType; // 메시지 보낸 친구 국적
			String tarLangType; // 내 국적
			
			String friendCountry = dao.selectCountry(msgMemberIdx);
			String myCountry = dao.selectCountry(memberIdx);
			
			if(friendCountry.equals("South Korea")) {
				srcLangType = "ko";
			} else if (friendCountry.equals("Japan")) {
				srcLangType = "ja";
			} else if (friendCountry.equals("China")) {
				srcLangType = "zh-TW";
			} else if (friendCountry.equals("Vietnam")) {
				srcLangType = "vi";
			} else if (friendCountry.equals("Thailand")) {
				srcLangType = "th";
			} else if (friendCountry.equals("Indonesia")) {
				srcLangType = "id";
			} else if (friendCountry.equals("France")) {
				srcLangType = "fr";
			} else if (friendCountry.equals("Spain")) {
				srcLangType = "es";
			} else if (friendCountry.equals("Russia")) {
				srcLangType = "ru";
			} else if (friendCountry.equals("Germany")) {
				srcLangType = "de";
			} else if (friendCountry.equals("Italy")) {
				srcLangType = "it";
			} else {
				srcLangType = "en";
			}
			
			if(myCountry.equals("South Korea")) {
				tarLangType = "ko";
			} else if (myCountry.equals("Japan")) {
				tarLangType = "ja";
			} else if (myCountry.equals("China")) {
				tarLangType = "zh-TW";
			} else if (myCountry.equals("Vietnam")) {
				tarLangType = "vi";
			} else if (myCountry.equals("Thailand")) {
				tarLangType = "th";
			} else if (myCountry.equals("Indonesia")) {
				tarLangType = "id";
			} else if (myCountry.equals("France")) {
				tarLangType = "fr";
			} else if (myCountry.equals("Spain")) {
				tarLangType = "es";
			} else if (myCountry.equals("Russia")) {
				tarLangType = "ru";
			} else if (myCountry.equals("Germany")) {
				tarLangType = "de";
			} else if (myCountry.equals("Italy")) {
				tarLangType = "it";
			} else {
				tarLangType = "en";
			}
			
			String postParams = "source="+srcLangType+"&target="+tarLangType+"&text=" + text;
			con.setDoOutput(true);
			DataOutputStream wr = new DataOutputStream(con.getOutputStream());
			wr.writeBytes(postParams);
			wr.flush();
			wr.close();
			
			// response
			int responseCode = con.getResponseCode();
			BufferedReader br;
			if (responseCode == 200) {
				br = new BufferedReader(new InputStreamReader(con.getInputStream()));
			} else {
				br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
			}
			String inputLine;
			StringBuffer response = new StringBuffer();
			while ((inputLine = br.readLine()) != null) {
				response.append(inputLine);
			}
			br.close();
			System.out.println(response.toString());
			
			result = response.toString();
		} catch (Exception e) {
			System.out.println(e);
		}
		
		return result;
	}

}