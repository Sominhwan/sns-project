package sns;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class FollowAllow
 */
@WebServlet("/sns/FollowAllow")
public class FollowAllow extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 	String userEmail = request.getParameter("userEmail");
	        String friendEmail = request.getParameter("friendEmail");
	        FriemdmanagerMgr fmgr = new FriemdmanagerMgr();
	        fmgr.friendallow(userEmail, friendEmail);
	        
	        response.setContentType("text/plain");
	        response.setCharacterEncoding("UTF-8");
	        response.sendRedirect("follow.jsp");
		}
	

}
