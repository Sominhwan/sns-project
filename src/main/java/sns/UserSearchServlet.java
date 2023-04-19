package sns;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/sns/UserSearch")
public class UserSearchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8"); 
		response.setContentType("text/html; charset=utf-8"); 
		String userName = request.getParameter("userName");
		response.getWriter().write(getJSON(userName));
	}	
	
	public String getJSON(String userName) {
		if(userName==null) 
			userName = "";
		StringBuffer result = new StringBuffer("");
		result.append("{\"result\":["); 
		AdminMgr mgr = new AdminMgr();
		ArrayList<UserinfoBean> userList = mgr.search(userName);
		for (int i = 0; i < userList.size(); i++) {
			result.append("[{\"value\": \"" + (i+1) + "\"},");
			result.append("{\"value\": \"" + userList.get(i).getUserName() + "\"},");
			result.append("{\"value\": \"" + userList.get(i).getUserNickName() + "\"},");
			result.append("{\"value\": \"" + userList.get(i).getUserEmail() + "\"},");
			result.append("{\"value\": \"" + userList.get(i).getUserSocialId() + "\"},");
			result.append("{\"value\": \"" + userList.get(i).getUserPN() + "\"},");
			result.append("{\"value\": \"" + userList.get(i).getUserAddress() + "\"},");
			result.append("{\"value\": \"" + userList.get(i).getEmailcertification() + "\"},");
			result.append("{\"value\": \"" + userList.get(i).getUserInfoType() + "\"},");
			result.append("{\"value\": \"" + userList.get(i).getUserRegDate() + "\"},");
			result.append("{\"value\": \"" + "<a>삭제</a>" + "\"}],");
		}
		result.append("]}");
		return result.toString();
	}

}
