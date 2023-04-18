<%@page import="java.io.PrintWriter"%>
<%@page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="mgr" class="sns.UserMgr"/>
<jsp:useBean id="bean" class="sns.UserinfoBean" scope="page"/>
<%
	request.setCharacterEncoding("UTF-8"); 
	String userEmail = null;
	if(request.getParameter("userEmail")!=null){
		userEmail = request.getParameter("userEmail");
	}
	PrintWriter script = response.getWriter();
	
	if((bean = mgr.getUserEmailCheck(userEmail))==null){
		script.println("<script>");
		script.println("alert('해당된 계정 정보가 없습니다.');");
		script.println("location.replace('findPwd.jsp');");
		script.println("</script>");
	} else {
		if(bean.getUserInfoType()!=null){
			if(bean.getUserInfoType().equals("naver")){		
				script.println("<script>");
				script.println("alert('네이버로 가입된 계정입니다.');");
				script.println("location.replace('findPwd.jsp');");
				script.println("</script>");
				script.close();
				return;		
			}else if(bean.getUserInfoType().equals("kakao")){
				script.println("<script>");
				script.println("alert('카카오로 가입된 계정입니다.');");
				script.println("location.replace('findPwd.jsp');");
				script.println("</script>");
				script.close();
				return;	
			}
		} else {
			session.setAttribute("userEmail", userEmail);
			script.println("<script>");
			script.println("location.replace('findPwdChange.jsp');");
			script.println("</script>");
			script.close();
			return;	
		}
	}
%>
<div>안녕</div>