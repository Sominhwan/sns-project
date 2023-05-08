<%@page contentType="text/html; charset=UTF-8"%>
<%
	String userSchool = null;
	String userEmail = null;
	String userNickName = null;
	String usersocial = null;
	String userSocialId = null;
	if(request.getParameter("nickname")!=null){
		userNickName = request.getParameter("nickname");	
	}
	if(request.getParameter("email")!=null){
		userNickName = request.getParameter("email");	
	}
	if(request.getParameter("school")!=null){
		userNickName = request.getParameter("school");	
	}
	if(request.getParameter("social")!=null){
		userNickName = request.getParameter("social");	
	}

	if(request.getParameter("member_post")!=null){
		userNickName = request.getParameter("member_post");	
	}
	if(request.getParameter("member_addr")!=null){
		userNickName = request.getParameter("member_addr");	
	}
%>