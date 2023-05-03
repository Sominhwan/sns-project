package sns;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/sns/CommentUpdateServlet")
public class CommentUpdateServlet extends HttpServlet {
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String comment = request.getParameter("commentDetail");
		int postId = Integer.parseInt(request.getParameter("postId"));
		String userEmail = request.getParameter("userEmail");
		int commentId=Integer.parseInt(request.getParameter("commentId"));
		UserinfoBean ubean=new UserinfoBean();
		CommentMgr cmgr = new CommentMgr();
		cmgr.updateComment(commentId,comment);
		String gid = request.getParameter("gid");
		if(gid==null)
			response.sendRedirect("Main.jsp");
		
	}

}
