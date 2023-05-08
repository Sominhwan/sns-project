package sns;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/sns/ChatListServlet")
public class ChatListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String listType = request.getParameter("listType");
		String roomList = request.getParameter("roomList");
		String userEmail= request.getParameter("userEmail");
		int roomId = Integer.parseInt(roomList);
		if(listType == null || listType.equals("")) response.getWriter().write("");
		else if(listType.equals("ten")) response.getWriter().write(getTen(roomId));
		else {
			try { 
				Integer.parseInt(listType);
				lastCheck(roomId, userEmail);
				response.getWriter().write(getID(listType,roomId));
			} catch (Exception e) {
				response.getWriter().write("");
			}
		}
	}
	
	public void lastCheck(int roomId, String userEamil) {
		ChatMessagerMgr dao = new ChatMessagerMgr();
		int maxNum = dao.getMaxcahtId(roomId);
		int lastCheckNum = dao.lastCheck(roomId, userEamil);
		if(maxNum == lastCheckNum || maxNum == 0) {
			return;
		}
		dao.insertLastCheck(maxNum, roomId, userEamil);
		return;
	}
	
	
	public String getTen(int roomId) {
		StringBuffer result = new StringBuffer("");
		result.append("{\"result\":[");
		ChatMessagerMgr dao = new ChatMessagerMgr();
		ArrayList<ChatMessagerBean> chatList = dao.getChatListByRecent(10, roomId);

//		String json = new Gson().toJson(chatList);
//		return json;
		for(int i = 0; i < chatList.size(); i++) {
			result.append("[{\"value\": \"" + chatList.get(i).getUserEmail() + "\"},");
			result.append("{\"value\": \"" + chatList.get(i).getMessage() + "\"},");
			result.append("{\"value\": \"" + chatList.get(i).getCreationDate() + "\"}]");
			if(i != chatList.size() -1) result.append(",");
		}
		if(chatList.size()==0) {
			return "0";
		}
		result.append("], \"last\":\"" +  chatList.get(chatList.size() - 1).getChatMessagerId() + "\"}");
		return result.toString();
	}
	
	public String getID(String chatID, int roomId) {
		StringBuffer result = new StringBuffer("");
		result.append("{\"result\":[");
		ChatMessagerMgr dao = new ChatMessagerMgr();
		ArrayList<ChatMessagerBean> chatList = dao.getChatListByRecent(chatID, roomId);
//		String json = new Gson().toJson(chatList);
//		return json;
		
		for(int i = 0; i < chatList.size(); i++) {
			result.append("[{\"value\": \"" + chatList.get(i).getUserEmail() + "\"},");
			result.append("{\"value\": \"" + chatList.get(i).getMessage() + "\"},");
			result.append("{\"value\": \"" + chatList.get(i).getCreationDate() + "\"}]");
			if(i != chatList.size() -1) result.append(",");
		}

		result.append("], \"last\":\"" +  chatList.get(chatList.size() - 1).getChatMessagerId() + "\"}");
		return result.toString();
		
		
	}

}
