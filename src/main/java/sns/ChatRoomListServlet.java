package sns;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;


@WebServlet("/sns/ChatRoomListServlet")
public class ChatRoomListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String userEmail = request.getParameter("listType");
		Gson gson = new Gson();
		String json = gson.toJson(getRoomList(userEmail));
		response.getWriter().write(json);
	}
	
	public ArrayList<ChatRoomBean> getRoomList(String userEmail) {
		ChatMessagerMgr dao = new ChatMessagerMgr();
		ArrayList<ChatRoomBean> chatRoomId = dao.getChatRoomId(userEmail);
		
		return chatRoomId;
	}

}
