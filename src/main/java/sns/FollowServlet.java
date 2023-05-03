package sns;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;


@WebServlet("/sns/FollowServlet")
public class FollowServlet extends HttpServlet {
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
	    response.setContentType("application/json;charset=UTF-8");
	    String userEmail=request.getParameter("userEmail");
		String followEmail=request.getParameter("friendEmail");
		
		FriemdmanagerMgr fmgr=new FriemdmanagerMgr();
		fmgr.followfirend(userEmail,followEmail);
		JSONObject jsonResponse = new JSONObject();
	    jsonResponse.put("status", "success");
	    PrintWriter out = response.getWriter();
	    out.print(jsonResponse.toString());
	    out.flush();
	}

	
	
	

}
