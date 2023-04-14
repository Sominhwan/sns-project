package sns;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class loginServlet
 */
@WebServlet("/sns/loginChange")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
  
    public LoginServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	HttpSession session = request.getSession();
    	session.invalidate();
    	String url = "login.jsp"; // '/'는 context root부터 시작을 의미
		response.sendRedirect(url);
	}
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String userEmail = null;
		String userPwd = null;
		request.setCharacterEncoding("UTF-8"); 
		PrintWriter script = response.getWriter();
				
		HttpSession session = request.getSession();
		
		if(request.getParameter("userEmail")!=null){
			userEmail = request.getParameter("userEmail");
		}
		if(request.getParameter("password")!=null){
			userPwd = request.getParameter("password");
		}
		
		UserMgr userMgr = new UserMgr();
		boolean loginCheck = userMgr.userLogin(userEmail, userPwd);
		if(loginCheck){
			session.setAttribute("userEmail", userEmail); 
			session.setAttribute("userPwd",userPwd);				
			String url = "login.jsp"; // '/'는 context root부터 시작을 의미
			response.sendRedirect(url);
		} else{
			script.println("<script>");
			script.println("alert('이메일 또는 비밀번호가 다릅니다.');");
			script.println("history.back();");
			script.println("</script>");
			script.close();
		}
	}

}
