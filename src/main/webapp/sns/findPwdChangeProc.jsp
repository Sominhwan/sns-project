<%@page import="java.io.PrintWriter"%>
<%@page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="mgr" class="sns.UserMgr"/>
<%
	request.setCharacterEncoding("UTF-8"); 
	String userPwd = null;
	String userEmail = null;
	if(request.getParameter("userNewPwd")!=null){
		userPwd = request.getParameter("userNewPwd");
	}
	if(request.getParameter("userEmail")!=null){
		userEmail = request.getParameter("userEmail");
	}
	PrintWriter script = response.getWriter();
	
	String password = mgr.getUserPwd(userEmail);
	if(password.equals(userPwd)){
		script.println("<script>");
		script.println("alert('이전과 동일한 비밀번호입니다.');");
		script.println("location.replace('findPwd.jsp');");
		script.println("</script>");
	}
	if(mgr.setPassword(userEmail, userPwd)){
		script.println("<script>");
		script.println("location.replace('findPwdOk.html');");
		script.println("</script>");
	} else{
		script.println("<script>");
		script.println("alert('해당된 아이디 정보가 없습니다.');");
		script.println("</script>");
	}
%>

