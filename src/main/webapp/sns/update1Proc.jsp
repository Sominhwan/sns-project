<%@page import="sns.UserMgr"%>
<%@page import="sns.UserinfoBean"%>
<%@page contentType="text/html; charset=UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
		String nickname = null;
		String school = null;
		String social = null;
		String member_addr = null;
		String member_post = null;
		String userAddress = null;
		if(request.getParameter("nickname")!=null){
			nickname = request.getParameter("nickname");	
		}

		if(request.getParameter("school")!=null){
			school = request.getParameter("school");	
		}
		if(request.getParameter("social")!=null){
			social = request.getParameter("social");	
		}
		if(request.getParameter("member_post")!=null && request.getParameter("member_addr")!=null){
			member_post = request.getParameter("member_post");	
			member_addr = request.getParameter("member_addr");	
			userAddress = member_post + " " + member_addr;
		}
		UserMgr userMgr = new UserMgr();
		String email = (String)session.getAttribute("userEmail");
		userMgr.updateuserInfo(new UserinfoBean(nickname,school,userAddress,social), email); 
		 
%>
<script>
window.location.replace("update.jsp");
</script>
