package sns;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.google.gson.JsonIOException;

@WebServlet("/sns/UserProfileSearch")
public class UserProfileSearchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
/*	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8"); 
		response.setContentType("text/html; charset=utf-8"); 
		String userInputNickName = request.getParameter("userInputNickName");
		System.out.println(userInputNickName);
		if(userInputNickName!=null) {
			response.getWriter().write(getJSON2(userInputNickName));
		}
	}*/
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8"); 
		response.setContentType("text/html; charset=utf-8"); 
		String userNickName = request.getParameter("userNickName");
		if(userNickName!=null) {
			response.getWriter().write(getJSON(userNickName));
		}
	}
	
	@SuppressWarnings("unchecked")
	public String getJSON(String userNickName) {
		if(userNickName==null) 
			userNickName = "";
	
		UserMgr mgr = new UserMgr();
		ArrayList<UserinfoBean> userProfileList = mgr.getUserProfile(userNickName);
		JSONObject sendObject = new JSONObject();
		JSONArray sendArray = new JSONArray();
		try {
		    for(int i = 0; i < userProfileList.size(); i++ ){
		    	JSONObject informationObject = new JSONObject();
		        informationObject.put("userNickName",userProfileList.get(i).getUserNickName());
		        informationObject.put("userEmail",userProfileList.get(i).getUserEmail());
		        informationObject.put("userImage",userProfileList.get(i).getUserImage());
		        sendArray.add(informationObject);
		    }
		    sendObject.put("result",sendArray);
		} catch (JsonIOException e) {
		    e.printStackTrace();
		}	
		return sendObject.toString();
	}

/*	@SuppressWarnings("unchecked")
	public String getJSON2(String userInputNickName) {
		if(userInputNickName==null) 
			userInputNickName = "";
	
		UserMgr mgr = new UserMgr();
		String userEmail = mgr.getSearchUserEmail(userInputNickName);
		JSONObject sendObject = new JSONObject();
		JSONArray sendArray = new JSONArray();
		try {
		    JSONObject informationObject = new JSONObject();
		    informationObject.put("userEmail",userEmail);
		    sendObject.put("result",sendArray);
		} catch (JsonIOException e) {
		    e.printStackTrace();
		}	
		return sendObject.toString();
	}*/
}
