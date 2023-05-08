package sns;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class ChatInvite
 */
@WebServlet("/sns/ChatInvite")
public class ChatInvite extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
  
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String myEmail = request.getParameter("myEmail");
		String Email = request.getParameter("Email");
		int roomId = checkRoomId(myEmail, Email);
		if(roomId != 0) {
			response.getOutputStream().write(String.valueOf(roomId).getBytes("UTF-8"));
		}else {
			roomId = inviteChat(myEmail, Email);
			response.getOutputStream().write(String.valueOf(roomId).getBytes("UTF-8"));
		}
	}
	
	public int checkRoomId(String myEmail, String Email) {
		ChatMessagerMgr dao = new ChatMessagerMgr();
		int roomId = dao.checkRoom(myEmail, Email);
		return roomId;
	}
	
	public int inviteChat(String myEmail, String Email) {
		ChatMessagerMgr dao = new ChatMessagerMgr();
		int roomId = dao.inviteChat(myEmail, Email);
		return roomId;
	}
	
}