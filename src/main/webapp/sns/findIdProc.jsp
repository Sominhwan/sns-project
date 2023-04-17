<%@page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8"); 
	String userName = null;
	String userNickName = null;
	if(request.getParameter("userName")!=null){
		userName = request.getParameter("userName");
	}
	if(request.getParameter("userNickName")!=null){
		userNickName = request.getParameter("userNickName");
	}
%>