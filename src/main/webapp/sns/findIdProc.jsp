<%@page import="java.io.PrintWriter"%>
<%@page import="sns.UserinfoBean"%>
<%@page import="java.util.Vector"%>
<%@page import="sns.UserMgr"%>
<%@page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="mgr" class="sns.UserMgr"/>
<jsp:useBean id="bean" class="sns.UserinfoBean" scope="session"/>
<%
	request.setCharacterEncoding("UTF-8"); 
	String userName = null;
	String userNickName = null;
	PrintWriter script = response.getWriter();
	
	if(request.getParameter("userName")!=null){
		userName = request.getParameter("userName");
	}
	if(request.getParameter("userNickName")!=null){
		userNickName = request.getParameter("userNickName");
	}
	
	if((bean = mgr.getID(userName, userNickName))==null){
		script.println("<script>");
		script.println("alert('해당된 아이디 정보가 없습니다.');");
		script.println("location.replace('findId.jsp');");
		script.println("</script>");
	} else {
		if(bean.getUserInfoType()!=null){
			if(bean.getUserInfoType().equals("naver")){		
				script.println("<script>");
				script.println("alert('네이버로 가입된 계정입니다.');");
				script.println("location.replace('findId.jsp');");
				script.println("</script>");
				script.close();
				return;		
			}else if(bean.getUserInfoType().equals("kakao")){
				script.println("<script>");
				script.println("alert('카카오로 가입된 계정입니다.');");
				script.println("location.replace('findId.jsp');");
				script.println("</script>");
				script.close();
				return;	
			}
		} else {
			String userEmail = bean.getUserEmail();
			String userRegDate = bean.getUserRegDate();
			session.setAttribute("userEmail", userEmail);
			session.setAttribute("userRegDate", userRegDate);
		
			script.println("<script>");
			script.println("location.replace('findIdOk.jsp');");
			script.println("</script>");
			script.close();
			return;	
		}
	}
	
	
	
%>