package sns;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/sns/postReport")
public class postReport extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PostMgr mgr=new PostMgr();
		int postId = Integer.parseInt(request.getParameter("postId"));
		mgr.upReport(postId);
		String gid = request.getParameter("gid");
		if(gid==null)
			response.sendRedirect("Main.jsp");
	}

}
