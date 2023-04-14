<%@page import="java.io.PrintWriter"%>
<%@page import="sns.SHA256"%>
<%@page import="sns.UserMgr"%>
<%@page contentType="text/html; charset=UTF-8"%>
<%
	String code = null;
	if(request.getParameter("code")!=null){
		code = request.getParameter("code");
	}
	
	UserMgr userMgr = new UserMgr();
	
	String userEmail = userMgr.getUserEmail(code);

	 PrintWriter script = response.getWriter();
	 if(userEmail!=null){
	 	 userMgr.setEmailcertification(userEmail); 
		 script.println("<script>");
		 script.println("alert('인증에 성공했습니다.');");
		 script.println("location.href = 'login.jsp'");
		 script.println("</script>");
		 script.close();
		 return; 
	 } else{
		 script.println("<script>");
		 script.println("alert('유효하지 않은 코드입니다.');");
		 script.println("location.href = 'login.jsp'");
		 script.println("</script>");
		 script.close();
		 return;
	 }	  
%>