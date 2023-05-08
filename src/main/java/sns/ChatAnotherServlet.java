package sns;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;


@WebServlet("/sns/ChatAnotherServlet")
public class ChatAnotherServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String userEmail = request.getParameter("userEmail");
		Gson gson = new Gson();
		ArrayList<ChatRoomBean> MLC = getMyListCheck(userEmail);
		ArrayList<ChatRoomBean> ALC = getAnotherListCheck(userEmail);
		for(int i=0;i<MLC.size();i++) {
			int roomNewChat = ALC.get(i).getLastCheck() - MLC.get(i).getLastCheck();
			if(roomNewChat > 0) {
				ALC.get(i).setLastCheck(roomNewChat);
			}else {
				ALC.get(i).setLastCheck(0);
			}
		}
		String json = gson.toJson(ALC);
		System.out.println(json);
		response.getWriter().write(json);
	}

	
	public ArrayList<ChatRoomBean> getMyListCheck(String userEmail) {
		ChatMessagerMgr dao = new ChatMessagerMgr();
		ArrayList<ChatRoomBean> myListCheck = new ArrayList<ChatRoomBean>();
		myListCheck = dao.getMyChatRoomId(userEmail);
		return myListCheck;
	}
	
	public ArrayList<ChatRoomBean> getAnotherListCheck(String userEmail){
		ChatMessagerMgr dao = new ChatMessagerMgr();
		ArrayList<ChatRoomBean> anotherListCheck = new ArrayList<ChatRoomBean>();
		anotherListCheck = dao.getChatRoomId(userEmail);
		return anotherListCheck;
	}
	
}
