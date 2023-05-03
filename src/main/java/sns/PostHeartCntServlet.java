package sns;
//하트 올려주기
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;


/**
 * Servlet implementation class PostHeartCntServlet
 */
@WebServlet("/sns/PostHeartCntServlet")
public class PostHeartCntServlet extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
	    response.setContentType("application/json;charset=UTF-8");
	    int postId = Integer.parseInt(request.getParameter("postId"));
		String userEmail=request.getParameter("userEmail");
		PostMgr pmgr = new PostMgr();
		PostlikeMgr plmgr=new PostlikeMgr();
		
		pmgr.upHCnt(postId);
		System.out.println("추가중:"+userEmail+":"+postId);
		plmgr.insertPostlike(userEmail, postId);
		JSONObject jsonResponse = new JSONObject();
	    jsonResponse.put("status", "success");
	    System.out.println("cdel에서 작용");
	    // Send the JSON response back to the client
	    PrintWriter out = response.getWriter();
	    out.print(jsonResponse.toString());
	    out.flush();
	}

}
