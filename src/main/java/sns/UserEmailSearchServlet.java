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


@WebServlet("/sns/UserEmailSearch")
public class UserEmailSearchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8"); 
		response.setContentType("text/html; charset=utf-8"); 
		String userEmail = request.getParameter("userEmail");
		System.out.println(userEmail);
		response.getWriter().write(getJSON(userEmail));
		 
	}
	
	@SuppressWarnings("unchecked")
	public String getJSON(String userEmail) {
		if(userEmail==null) 
			userEmail = "";
	
		AdminMgr mgr = new AdminMgr();
		ArrayList<UserinfoBean> userEmailList = mgr.searchUserEmail(userEmail);
		JSONObject sendObject = new JSONObject();
		JSONArray sendArray = new JSONArray();
		try {
		    for(int i = 0; i < userEmailList.size(); i++ ){
		    	JSONObject informationObject = new JSONObject();
		        informationObject.put("userEmail",userEmailList.get(i).getUserEmail());
		        sendArray.add(informationObject);
		    }
		    sendObject.put("result",sendArray);
		} catch (JsonIOException e) {
		    e.printStackTrace();
		}	
		return sendObject.toString();
	}
}
