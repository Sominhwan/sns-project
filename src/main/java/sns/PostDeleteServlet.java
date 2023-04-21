package sns;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/sns/PostDelete")
public class PostDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8"); 
		response.setContentType("text/html; charset=utf-8"); 
		String postId = null;
		String postIdAll = null;
		if(request.getParameter("postId")!=null) {
			postId = request.getParameter("postId");
			AdminMgr mgr = new AdminMgr();
			mgr.deleteUserInfo(postId);		
		}
		
		if(request.getParameter("postIdAll")!=null) { 
			postIdAll = request.getParameter("postIdAll"); 
			String[] postId2 = postIdAll.split(",");
			AdminMgr mgr = new AdminMgr();
			for(int i =0; i<postId2.length;i++)
				mgr.deleteUserInfo(postId2[i]);    
		}		
	}

}
