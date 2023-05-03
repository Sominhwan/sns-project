package sns;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;


@WebServlet("/sns/PostHeartdeleteServlet")
public class PostHeartdeleteServlet extends HttpServlet {
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
	    response.setContentType("application/json;charset=UTF-8");
	    int postId = Integer.parseInt(request.getParameter("postId"));
		String userEmail=request.getParameter("userEmail");
		PostMgr pmgr = new PostMgr();
		PostlikeMgr plmgr=new PostlikeMgr();
		System.out.println(postId);
		pmgr.minusHCnt(postId);
		plmgr.deletePostlike(userEmail, postId);
		System.out.println("하트삭제중");
		JSONObject jsonResponse = new JSONObject();
	    jsonResponse.put("status", "success");
	    PrintWriter out = response.getWriter();
	    out.print(jsonResponse.toString());
	    out.flush();
	}

}
