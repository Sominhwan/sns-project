package sns;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;


@WebServlet("/sns/CommentUpdate")
public class CommentUpdate extends HttpServlet {
	

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
	    response.setContentType("application/json;charset=UTF-8");
	    int commentId = Integer.parseInt(request.getParameter("commentId"));
	    String commentDetail=request.getParameter("commentDetail");
	    CommentMgr cmgr = new CommentMgr();
	    cmgr.updateComment(commentId, commentDetail);
	    // You can construct a JSON response indicating the success status
	    JSONObject jsonResponse = new JSONObject();
	    jsonResponse.put("status", "success");
	    // Send the JSON response back to the client
	    PrintWriter out = response.getWriter();
	    out.print(jsonResponse.toString());
	    out.flush();
	}

}
