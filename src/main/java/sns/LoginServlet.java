package sns;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/sns/loginChange")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
  
    public LoginServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	HttpSession session = request.getSession();
    	session.invalidate();
    	String url = "login.jsp";
		response.sendRedirect(url);
	}
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String userEmail = null;
		String userPwd = null;
		String userNickName = null;
		String userImage = null;
		request.setCharacterEncoding("UTF-8"); 
				
		HttpSession session = request.getSession();
		
		if(request.getParameter("userEmail")!=null){
			userEmail = request.getParameter("userEmail");
		}
		if(request.getParameter("password")!=null){
			userPwd = request.getParameter("password");
		}
		
		UserMgr userMgr = new UserMgr();
		boolean loginCheck = userMgr.userLogin(userEmail, userPwd);
		if(loginCheck){ // 로그인 성공일 경우
			userNickName = userMgr.getUserNickName(userEmail);
			userImage = userMgr.getUserImage(userEmail);
			
			session.setAttribute("userEmail", userEmail); 				
			session.setAttribute("userNickName", userNickName); 				
			session.setAttribute("userImage", userImage); 				
			String url = "login.jsp"; 
			response.sendRedirect(url);
		} else{ // 로그인 실패한 경우 
			session.setAttribute("alertContent", "true");
			String url = "login.jsp"; 
			response.sendRedirect(url);
		}
	}
}
