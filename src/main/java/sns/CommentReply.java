package sns;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;


@WebServlet("/sns/CommentReply")
public class CommentReply extends HttpServlet {
	
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
	    response.setContentType("application/json;charset=UTF-8");
		String commentDetail = request.getParameter("commentDetail");
		int postId = Integer.parseInt(request.getParameter("postId"));
		String userEmail = request.getParameter("userEmail");
		String commentParrent = request.getParameter("commentParrent");
		String commentId=request.getParameter("commentId");
		CommentBean cbean = new CommentBean();
		cbean.setPostId(postId);
		cbean.setUserEmail(userEmail);
		cbean.setCommentDetail(commentDetail);
		cbean.setCommentParrent(commentId);
		cbean.setCommentChild("1");
		cbean.setCommentCorrect("");
		CommentMgr cmgr = new CommentMgr();
		PostMgr pmgr=new PostMgr();
		cmgr.insertReply(cbean);
		pmgr.upComment(postId);
		JSONObject jsonResponse = new JSONObject();
	    jsonResponse.put("status", "success");
	    PrintWriter out = response.getWriter();
	    out.print(jsonResponse.toString());
	    out.flush();
	}

}
