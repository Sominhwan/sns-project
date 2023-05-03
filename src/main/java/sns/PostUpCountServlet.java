package sns;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

@WebServlet("/sns/PostUpCount")
public class PostUpCountServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8"); 
		response.setContentType("text/html; charset=utf-8"); 
		PrintWriter out = response.getWriter();	
    	try {
			out.print(getJSON());
		} catch (Exception e) {
			e.printStackTrace();
		}
    	out.close();
	}
	// 특정 유저가 올린 게시물 횟수 
	public String getJSON() throws Exception {
		AdminMgr mgr = new AdminMgr();
		ArrayList<UserPostInfoBean> postList = mgr.getPostInfo();
		int count = mgr.getPostAllCount();
			
		JSONObject obj = new JSONObject();
		JSONArray array = new JSONArray();
		for(int i=0; i<postList.size(); i++) {
			JSONObject sendPostList = new JSONObject();
			sendPostList.put("userEmail", postList.get(i).getUserEmail());
			sendPostList.put("userPostCount", postList.get(i).getUserPostCount());
			array.add(sendPostList);
		}
		obj.put("result", array);
		obj.put("count", count);
		System.out.println(obj.toString());
		return obj.toString();
	}	




}
