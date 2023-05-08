package sns;

import java.io.IOException;
import java.net.URLDecoder;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/sns/ChatSubmitServlet")
public class ChatSubmitServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	System.out.println("서블");
   
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String chatName = URLDecoder.decode(request.getParameter("chatName"), "UTF-8");
		String chatContent = URLDecoder.decode(request.getParameter("chatContent"), "UTF-8");
		String sendMsgRoom = URLDecoder.decode(request.getParameter("sendMsgRoom"),"UTF-8");
		System.out.println(sendMsgRoom);
		int sendMsgRoomId = Integer.parseInt(sendMsgRoom);
		System.out.println(sendMsgRoomId);
		if (chatName == null || chatName.equals("") || chatContent == null || chatContent.equals("")) {
			response.getWriter().write("0");
		} else { 
			response.getWriter().write(new ChatMessagerMgr().submit(sendMsgRoomId, chatName, chatContent));
		}  

	}

}
