package sns;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/sns/adminLogin")
public class adminLoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
  
    public adminLoginServlet() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String adminId = null;
		String adminPwd = null;
		if(request.getParameter("adminId")!=null) {
			adminId = request.getParameter("adminId");
		}
		if(request.getParameter("adminPwd")!=null) {
			adminPwd = request.getParameter("adminPwd");
		}
		
		UserMgr mgr = new UserMgr();
		boolean adminCheck = mgr.adminLogin(adminId, adminPwd);
		if(adminCheck) { // 로그인 성공할 시 
			RequestDispatcher re = request.getRequestDispatcher("adminPage.jsp");
			re.forward(request, response);
		} else { // 로그인 실패 시
			RequestDispatcher re = request.getRequestDispatcher("adminLogin.jsp");
			re.forward(request, response);
		}
	}

}
