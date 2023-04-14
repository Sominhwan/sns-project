<%@page import="sns.UserMgr"%>
<%@page import="java.io.PrintWriter"%>
<%@page contentType="text/html; charset=UTF-8"%>
<%
	String userEmail = null;
	String userPwd = null;
	request.setCharacterEncoding("UTF-8"); 
	PrintWriter script = response.getWriter();
			
	if(request.getParameter("userEmail")!=null){
		userEmail = request.getParameter("userEmail");
	}
	if(request.getParameter("password")!=null){
		userPwd = request.getParameter("password");
	}
	
	UserMgr userMgr = new UserMgr();
	boolean loginCheck = userMgr.userLogin(userEmail, userPwd);
	if(loginCheck){
		
	} else{
		script.println("<script>");
		script.println("alert('이메일 또는 비밀번호가 다릅니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
	}
%>
