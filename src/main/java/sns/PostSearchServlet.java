package sns;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/sns/PostSearch")
public class PostSearchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8"); 
		response.setContentType("text/html; charset=utf-8"); 
		String userEmail = request.getParameter("userEmail");
		System.out.println(userEmail);
		response.getWriter().write(getJSON(userEmail));
	}	
	
	public String getJSON(String userEmail) {
		if(userEmail==null) 
			userEmail = "";
		StringBuffer result = new StringBuffer("");
		result.append("{\"result\":["); 
		AdminMgr mgr = new AdminMgr();
		ArrayList<PostBean> postList = mgr.searchPost(userEmail);
		for (int i = 0; i < postList.size(); i++) {
			result.append("[{\"value\": \"" + "" + "\"},");
			result.append("{\"value\": \"" + (i+1) + "\"},");
			result.append("{\"value\": \"" + postList.get(i).getPostId() + "\"},");
			result.append("{\"value\": \"" + postList.get(i).getUserEmail() + "\"},");
			result.append("{\"value\": \"" + postList.get(i).getImageName() + "\"},");
			result.append("{\"value\": \"" + postList.get(i).getVideoName() + "\"},");
			result.append("{\"value\": \"" + postList.get(i).getCommentNum() + "\"},");
			result.append("{\"value\": \"" + postList.get(i).getLikeNum() + "\"},");
			result.append("{\"value\": \"" + postList.get(i).getShareNum() + "\"},");
			result.append("{\"value\": \"" + postList.get(i).getPostReport() + "\"},");
			result.append("{\"value\": \"" + postList.get(i).getCreationDate() + "\"},");
			result.append("{\"value\": \"" + "" + "\"}],");
		}
		result.append("]}");
		return result.toString();
	}

}
