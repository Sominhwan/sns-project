package sns;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

@WebServlet(name = "NaverLoginOkServlet", urlPatterns = { "/sns/naverLoginOk" })
public class NaverLoginOkServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public NaverLoginOkServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String clientId = "8k6tTgl_X5mXWraZ1X4k";// 애플리케이션 클라이언트 아이디값";
		String clientSecret = "kLBl4kvJts";// 애플리케이션 클라이언트 시크릿값";
		String code = request.getParameter("code");
		String state = request.getParameter("state");
		String redirectURI = URLEncoder.encode("http://localhost:8081/sns-project/sns/termsService.jsp", "UTF-8");
		String apiURL;
		String token = ""; // 네이버 로그인 접근 토큰;
		String id = "";
		String name = "";
		String gender = "";
		String email = "";
		String mobile = "";
		String userEmail = null;
		String userNickName = null;
		String userImage = null;
		request.setCharacterEncoding("UTF-8"); 
	    	
		HttpSession session = request.getSession();
		
		apiURL = "https://nid.naver.com/oauth2.0/token?grant_type=authorization_code&";
		apiURL += "client_id=" + clientId;
		apiURL += "&client_secret=" + clientSecret;
		apiURL += "&redirect_uri=" + redirectURI;
		apiURL += "&code=" + code;
		apiURL += "&state=" + state;

		try {
			URL url = new URL(apiURL);
			HttpURLConnection con = (HttpURLConnection) url.openConnection();
			con.setRequestMethod("GET");
			int responseCode = con.getResponseCode();
			BufferedReader br;
			if (responseCode == 200) { // 정상 호출
				br = new BufferedReader(new InputStreamReader(con.getInputStream()));
			} else { // 에러 발생
				br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
			}
			String inputLine;
			StringBuffer res = new StringBuffer();
			while ((inputLine = br.readLine()) != null) {
				res.append(inputLine);
			}
			br.close();
			if (responseCode == 200) {
				JSONParser parsing = new JSONParser();
				Object obj = parsing.parse(res.toString());
				JSONObject jsonObj = (JSONObject) obj;
				token = (String) jsonObj.get("access_token");
			}
		} catch (Exception e) {
			System.out.println(e);
		}
		
		String header = "Bearer " + token; // Bearer 다음에 공백 추가
		String apiURL2 = "https://openapi.naver.com/v1/nid/me";

		Map<String, String> requestHeaders = new HashMap<>();
		requestHeaders.put("Authorization", header);
		String responseBody = get(apiURL2, requestHeaders);

		System.out.println(responseBody);
		System.out.println();
		String jsonData = responseBody;
		// reader를 Object로 parse
		JSONParser parser = new JSONParser();
		Object obj;
		try {
			obj = parser.parse(jsonData);
			JSONObject jsonObj = (JSONObject) obj;
			JSONObject response_obj = (JSONObject) jsonObj.get("response");
			// response의 개인 정보 파싱		
			id = (String) response_obj.get("id");
			name = (String) response_obj.get("name");
	        gender = (String) response_obj.get("gender");
			email = (String) response_obj.get("email");
			mobile = (String) response_obj.get("mobile");
		} catch (ParseException e) {
			e.printStackTrace();
		}
		UserMgr userMgr = new UserMgr();
		boolean loginCheck = userMgr.userNaverLogin(id);	
		if(loginCheck) {
			userEmail = userMgr.getUserSnsEmail(id);
			userNickName = userMgr.getUserNickName(userEmail);
			userImage = userMgr.getUserImage(userEmail);
			
			session.setAttribute("userEmail", userEmail);
			session.setAttribute("userNickName", userNickName);
			session.setAttribute("userImage", userImage);
			String url = "login.jsp"; 
			response.sendRedirect(url);	
		} else {	
			//session.setAttribute("alertContent", "true");
			session.invalidate();
			request.setAttribute("id", id);
			request.setAttribute("name", name);
			request.setAttribute("gender", gender);
			request.setAttribute("email", email);
			request.setAttribute("mobile", mobile);
			RequestDispatcher re = request.getRequestDispatcher("termsService.jsp");
			re.forward(request, response);
		}
	}

	private static String get(String apiUrl, Map<String, String> requestHeaders) {
		HttpURLConnection con = connect(apiUrl);
		try {
			con.setRequestMethod("GET");
			for (Map.Entry<String, String> header : requestHeaders.entrySet()) {
				con.setRequestProperty(header.getKey(), header.getValue());
			}

			int responseCode = con.getResponseCode();
			if (responseCode == HttpURLConnection.HTTP_OK) { // 정상 호출
				return readBody(con.getInputStream());
			} else { // 에러 발생
				return readBody(con.getErrorStream());
			}
		} catch (IOException e) {
			throw new RuntimeException("API 요청과 응답 실패", e);
		} finally {
			con.disconnect();
		}
	}

	private static HttpURLConnection connect(String apiUrl) {
		try {
			URL url = new URL(apiUrl);
			return (HttpURLConnection) url.openConnection();
		} catch (MalformedURLException e) {
			throw new RuntimeException("API URL이 잘못되었습니다. : " + apiUrl, e);
		} catch (IOException e) {
			throw new RuntimeException("연결이 실패했습니다. : " + apiUrl, e);
		}
	}

	private static String readBody(InputStream body) {
		InputStreamReader streamReader = new InputStreamReader(body);

		try (BufferedReader lineReader = new BufferedReader(streamReader)) {
			StringBuilder responseBody = new StringBuilder();

			String line;
			while ((line = lineReader.readLine()) != null) {
				responseBody.append(line);
			}

			return responseBody.toString();
		} catch (IOException e) {
			throw new RuntimeException("API 응답을 읽는데 실패했습니다.", e);
		}
	}
}
