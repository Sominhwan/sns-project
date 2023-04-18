package sns;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
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
    	Cookie[] cookies = request.getCookies() ;
    	session.invalidate();
		if(cookies != null){
			for(int i=0; i < cookies.length; i++){					
				if(cookies[i].getName().equals("loginCookie")) {
					// 쿠키의 유효시간을 0으로 설정하여 만료시킨다
					cookies[i].setMaxAge(0) ;
					System.out.println(cookies[i].getName());
					// 응답 헤더에 추가한다
					response.addCookie(cookies[i]) ;
				}
			}
		}
    	
    	String url = "login.jsp";
		response.sendRedirect(url);
	}
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String userEmail = null;
		String userPwd = null;
		String userNickName = null;
		String userImage = null;
		String autoLogin = null;
		request.setCharacterEncoding("UTF-8"); 
				
		HttpSession session = request.getSession();
		
		if(request.getParameter("userEmail")!=null){
			userEmail = request.getParameter("userEmail");
		}
		if(request.getParameter("password")!=null){
			userPwd = request.getParameter("password");
		}	
		if(request.getParameter("myCheck")!=null) {
			autoLogin = request.getParameter("myCheck");
		}
		
		UserMgr userMgr = new UserMgr();
		int loginCheck = userMgr.userLogin(userEmail, userPwd);
		if(loginCheck==1){ // 로그인 성공일 경우
			userNickName = userMgr.getUserNickName(userEmail);
			userImage = userMgr.getUserImage(userEmail);
			
			session.setAttribute("userEmail", userEmail); 				
			session.setAttribute("userNickName", userNickName); 				
			session.setAttribute("userImage", userImage); 	
			
			if(autoLogin!=null) { // 자동 로그인 체크시 쿠키 값 저장
				Cookie loginCookie = new Cookie("loginCookie", userEmail);	
				loginCookie.setPath("/");
				loginCookie.setMaxAge(60*60);
				response.addCookie(loginCookie);
				System.out.println("자동로그인 쿠키값 저장");
			} 
			String url = "login.jsp"; 
			response.sendRedirect(url);
		} else if(loginCheck==0){ // 로그인 실패한 경우 
			session.setAttribute("alertContent", "true");
			String url = "login.jsp"; 		
			response.sendRedirect(url);
		} else if(loginCheck==2) { // 관리자 로그인
			userNickName = userMgr.getUserNickName(userEmail);
			userImage = userMgr.getUserImage(userEmail);
			
			session.setAttribute("userEmail", userEmail); 				
			session.setAttribute("userNickName", userNickName); 				
			session.setAttribute("userImage", userImage); 
			session.setAttribute("adminCheck", "1");
			String url = "login.jsp"; 
			response.sendRedirect(url);
		}
	}
}
