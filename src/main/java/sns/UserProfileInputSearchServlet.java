package sns;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.google.gson.JsonIOException;

@WebServlet("/sns/UserProfileInputSearch")
public class UserProfileInputSearchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8"); 
		response.setContentType("text/html; charset=utf-8"); 
		String userInputNickName = request.getParameter("userInputNickName");
		if(userInputNickName!=null) {
			response.getWriter().write(getJSON(userInputNickName));
		}
	}

    @SuppressWarnings("unchecked")
	public String getJSON(String userInputNickName) {
		if(userInputNickName==null) 
			userInputNickName = "";
	
		UserMgr mgr = new UserMgr();
		String userEmail = mgr.getSearchUserEmail(userInputNickName);
		System.out.println(userEmail);
		JSONObject sendObject = new JSONObject();
		try {
			sendObject.put("userEmail",userEmail);
		} catch (JsonIOException e) {
		    e.printStackTrace();
		}			
		return sendObject.toString();
	}
}
