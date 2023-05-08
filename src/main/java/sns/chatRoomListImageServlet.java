package sns;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Vector;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

/**
 * Servlet implementation class chatRoomListImageServlet
 */
@WebServlet("/sns/chatRoomListImageServlet")
public class chatRoomListImageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		Gson gson = new Gson();
		String userEmail = request.getParameter("userEmail");
		
		Vector<String> followList = followEmail(userEmail);
		System.out.println("vector:"+followList);
		
		ArrayList<UserinfoBean> followImg = followImage(followList);
		System.out.println("ArrayList:"+followImg);
		
		String json = gson.toJson(followImg);
		System.out.println("json:"+json);
		response.getWriter().write(json);
	}

	
	public Vector<String> followEmail(String userEmail){
		ProfileMgr pmgr = new ProfileMgr();
		Vector<String> followList = pmgr.followInfo(userEmail);
		return followList;
	}

	public ArrayList<UserinfoBean> followImage(Vector<String> followList){
		ProfileMgr pmgr = new ProfileMgr();
		ArrayList<UserinfoBean> followImg = new ArrayList<UserinfoBean>();
		for(int i=0;followList.size() > i; i++) {
			followImg.add(pmgr.getInfo(followList.get(i)));
		}
		return followImg;
	}
	
}












