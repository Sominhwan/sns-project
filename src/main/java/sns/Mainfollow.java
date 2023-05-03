package sns;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/sns/Mainfollow")
public class Mainfollow extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PostMgr pMgr = new PostMgr();
		int postId = Integer.parseInt(request.getParameter("postId"));
		pMgr.upHCnt(postId);
		String gid = request.getParameter("gid");
		if(gid==null)
			response.sendRedirect("Main.jsp");
		else 
			response.sendRedirect("Main.jsp?gid="+gid);
	}

}
