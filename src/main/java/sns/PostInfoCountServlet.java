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


@WebServlet("/sns/PostInfoCount")
public class PostInfoCountServlet extends HttpServlet {
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
	// 게시물 정보 
	public String getJSON() throws Exception {
		AdminMgr mgr = new AdminMgr();
		ArrayList<PostBean> postList = mgr.getLikeInfo();
			
		JSONObject obj = new JSONObject();
		JSONArray array = new JSONArray();
		for(int i=0; i<postList.size(); i++) {
			JSONObject sendPostList = new JSONObject();
			sendPostList.put("postId", postList.get(i).getPostId());
			sendPostList.put("userEmail", postList.get(i).getUserEmail());
			sendPostList.put("likeNum", postList.get(i).getLikeNum());
			sendPostList.put("shareNum", postList.get(i).getShareNum());
			sendPostList.put("commentNum", postList.get(i).getCommentNum());
			sendPostList.put("postReport", postList.get(i).getPostReport());
			array.add(sendPostList);
		}
		obj.put("result", array);
		return obj.toString();
	}
}
