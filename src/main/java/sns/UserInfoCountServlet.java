package sns;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;


@WebServlet("/sns/UserInfoCount")
public class UserInfoCountServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8"); 
		response.setContentType("text/html; charset=utf-8"); 
		PrintWriter out = response.getWriter();
		
		if(request.getParameter("post")!=null) {
			try {
				out.print(getJSON2());
			} catch (Exception e) {
				e.printStackTrace();
			}
			out.close();
		}
		
    	try {
			out.print(getJSON());
		} catch (Exception e) {
			e.printStackTrace();
		}
    	out.close();			
	}
	// 회원가입 수 
	public String getJSON() throws Exception {
		AdminMgr mgr = new AdminMgr();
		int [] count = new int[12];
		for(int i = 0; i<12; i++)
			count[i] = mgr.getUserCount(i+1);
		
		JSONObject obj = new JSONObject();
		JSONArray array = new JSONArray();
		for(int j=0; j<12; j++) {
			JSONObject obj2 = new JSONObject();
			obj2.put("result", count[j]);
			array.add(obj2);
		}
		obj.put("count", array);
		return obj.toString();
	}
	// 게시물 수
	public String getJSON2() throws Exception {
		AdminMgr mgr = new AdminMgr();
		int [] count = new int[12];
		for(int i = 0; i<12; i++)
			count[i] = mgr.getPostCount(i+1);
		
		JSONObject obj = new JSONObject();
		JSONArray array = new JSONArray();
		for(int j=0; j<12; j++) {
			JSONObject obj2 = new JSONObject();
			obj2.put("result", count[j]);
			array.add(obj2);
		}
		obj.put("count", array);
		return obj.toString();
	}	
}
