package sns;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/sns/ProfileServlet")
public class ProfileServlet extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		ProfileMgr pMgr = new ProfileMgr();
		String idKey = request.getParameter("userEmail");
		String gbComment = request.getParameter("contents");
		System.out.println(idKey);
		System.out.println(gbComment);
		pMgr.insertGuest(idKey, gbComment);
		response.sendRedirect("profile.jsp");
	}

}
