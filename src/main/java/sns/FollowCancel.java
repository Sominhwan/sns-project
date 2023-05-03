package sns;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/sns/FollowCancel")
public class FollowCancel extends HttpServlet {
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String userEmail = request.getParameter("userEmail");
        String friendEmail = request.getParameter("friendEmail");
        FriemdmanagerMgr fmgr = new FriemdmanagerMgr();
        fmgr.delFriend(userEmail, friendEmail);
        response.setContentType("text/plain");
        response.setCharacterEncoding("UTF-8");
        response.sendRedirect("follow.jsp");
	}

}
