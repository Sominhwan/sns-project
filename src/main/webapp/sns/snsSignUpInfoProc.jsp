<%@page import="sns.UserinfoBean"%>
<%@page import="sns.UserMgr"%>
<%@page import="java.io.PrintWriter"%>
<%@page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8"); 
	PrintWriter script = response.getWriter();
	String userName = null;
	String userGender = null;
	String userNickName = null;
	String userEmail = null;
	String userPN = null;
	String userSocialId = null;
	int emailcertification = 1;
	String userImage = "images/profile.svg";	
	int agreement = 0;
	String userInfoType = null;
	
	if(request.getParameter("userName")!=null){
		userName = request.getParameter("userName");
	}
	if(request.getParameter("userGender")!=null){
		userGender = request.getParameter("userGender");
	}
	if(request.getParameter("userNickName")!=null){
		userNickName = request.getParameter("userNickName");
	}
	if(request.getParameter("userEmail")!=null){
		userEmail = request.getParameter("userEmail");
	}
	if(request.getParameter("userPhoneNum")!=null){
		userPN = request.getParameter("userPhoneNum");
	}
	if(request.getParameter("userSocialId")!=null){
		userSocialId = request.getParameter("userSocialId");
	}
	if(request.getParameter("userAd")!=null){
		agreement = Integer.parseInt(request.getParameter("userAd"));
	}
	if(request.getParameter("userInfoType")!=null){
		userInfoType = request.getParameter("userInfoType");
	}
	
 	UserMgr userMgr = new UserMgr();
	boolean result = userMgr.naverJoin(new UserinfoBean(userName, userGender, userNickName, userEmail,
			userPN, userSocialId, emailcertification, userImage, agreement, userInfoType));
	if(result){
		session.invalidate();
		script.println("<script>");
		script.println("location.replace('snsSignUpOk.html')");
		script.println("</script>");
	}else{
		script.println("<script>");
		script.println("alert('이미 존재하는 닉네임입니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	} 
%>