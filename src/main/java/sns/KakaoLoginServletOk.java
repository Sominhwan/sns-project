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

@WebServlet("/sns/kakaoLoginOk")
public class KakaoLoginServletOk extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
  
    public KakaoLoginServletOk() {
        super();
    }
   
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = null;
		String userEmail = null;
		String userNickName = null;
		String userImage = null;
		String email = null;
		String nickname = null;
		String gender = null;
		request.setCharacterEncoding("UTF-8"); 
				
		HttpSession session = request.getSession();
		
		if(request.getParameter("id")!=null){			
			id = request.getParameter("id");
		}
		if(request.getParameter("email")!=null){
			email = request.getParameter("email");
		}
		if(request.getParameter("nickname")!=null){
			nickname = request.getParameter("nickname");
		}
		if(request.getParameter("gender")!=null){
			gender = request.getParameter("gender");
		}

		UserMgr userMgr = new UserMgr();
		boolean loginCheck = userMgr.userNaverLogin(id);
		
		if(loginCheck){ // 로그인 성공일 경우
			userEmail = userMgr.getUserSnsEmail(id);
			userNickName = userMgr.getUserNickName(userEmail);
			userImage = userMgr.getUserImage(userEmail);
			
			session.setAttribute("userEmail", userEmail); 				
			session.setAttribute("userNickName", userNickName); 				
			session.setAttribute("userImage", userImage); 				
			String url = "login.jsp"; 
			response.sendRedirect(url);
		} else{ // 카카오 가입이 되지 않은 경우	
			session.invalidate();
			request.setAttribute("kakaoid", id);
			request.setAttribute("email", email);
			request.setAttribute("nickname", nickname);
			request.setAttribute("gender", gender);
			RequestDispatcher re = request.getRequestDispatcher("termsService.jsp");
			re.forward(request, response);
		}
	}
}
