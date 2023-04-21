package sns;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet("/sns/UserInfoDelete")
public class UserInfoDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
        
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8"); 
		response.setContentType("text/html; charset=utf-8"); 
		String userEmail = null;
		String userEmailAll = null;
		if(request.getParameter("userEmail")!=null) {
			userEmail = request.getParameter("userEmail");
			AdminMgr mgr = new AdminMgr();
			mgr.deleteUserInfo(userEmail);		
		}
		
		if(request.getParameter("userEmailAll")!=null) { 
			userEmailAll = request.getParameter("userEmailAll"); 
			String[] userEmail2 = userEmailAll.split(",");
			AdminMgr mgr = new AdminMgr();
			for(int i =0; i<userEmail2.length;i++)
				mgr.deleteUserInfo(userEmail2[i]);    
		}		 			
	}
}
