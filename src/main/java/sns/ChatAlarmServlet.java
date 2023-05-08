package sns;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/sns/ChatAlarmServlet")
public class ChatAlarmServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;


	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String userEmail = request.getParameter("userEmail");
		int alarmNum = 0;
		ArrayList<ChatRoomBean> MLC = getMyListCheck(userEmail);
		ArrayList<ChatRoomBean> ALC = getAnotherListCheck(userEmail);
		for(int i=0;i<MLC.size();i++) {
		//	System.out.println("ALC:"+ALC.get(i).getLastCheck());
		//	System.out.println("MLC:"+MLC.get(i).getLastCheck());
			int addNum = ALC.get(i).getLastCheck() - MLC.get(i).getLastCheck();
		//	System.out.println("addNum:" + addNum);
			if(addNum > 0) {
				alarmNum = alarmNum+addNum;
		//		System.out.println("if문 진입 alarmNum:"+alarmNum);
			}
		}
		System.out.println("alarmNum:"+alarmNum);
		response.getOutputStream().write(String.valueOf(alarmNum).getBytes("UTF-8"));
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
