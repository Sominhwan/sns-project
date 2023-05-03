package sns;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

//댓글삭제
@WebServlet("/sns/cdel")
public class cdel extends HttpServlet {
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
	    response.setContentType("application/json;charset=UTF-8");
	    int commentId = Integer.parseInt(request.getParameter("commentId"));
	    int postId = Integer.parseInt(request.getParameter("postId"));
	    
	    CommentMgr cmgr = new CommentMgr();
	    PostMgr pmgr = new PostMgr();
	    cmgr.deletePReply(commentId);
	    pmgr.downComment(postId);
	    
	    
	    JSONObject jsonResponse = new JSONObject();
	    jsonResponse.put("status", "success");
	    PrintWriter out = response.getWriter();
	    out.print(jsonResponse.toString());
	    out.flush();
	}
	

}
