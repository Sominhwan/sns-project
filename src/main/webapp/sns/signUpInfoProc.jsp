<%@page import="sns.UserMgr"%>
<%@page import="sns.UserinfoBean"%>
<%@page import="sns.SHA256"%>
<%@page import="java.util.regex.Matcher"%>
<%@page import="java.util.regex.Pattern"%>
<%@page import="java.io.PrintWriter"%>
<%@page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8"); 
	PrintWriter script = response.getWriter();
	String userEmail = null;
	String userName = null;;
	String userGender = null;
	String userNickName = null;
	String userPhoneNum = null;
	String userPwd = null;
	String agreement = null;
	int userAd = 0;
	String userImage = "images/profile.svg";

	if(request.getParameter("userEmail")!=null){
		userEmail = request.getParameter("userEmail");
		Pattern emailPattern1 = Pattern.compile("^[_a-z0-9-]+(.[_a-z0-9-]+)*@(?:\\w+\\.)+\\w+$");
		Matcher emailMatcher1 = emailPattern1.matcher(userEmail);
		if(!emailMatcher1.find()){
			script.println("<script>");
			script.println("alert('이메일을 양식에 맞게 입력해주세요.');");
			script.println("history.back();");
			script.println("</script>");
			script.close();
			return;
		  }
	}
	if(request.getParameter("userName")!=null){
		userName = request.getParameter("userName");
	}
	if(request.getParameter("userGender")!=null){
		userGender = request.getParameter("userGender");
		Pattern genderPattern1 = Pattern.compile("^[ㄱ-ㅎ가-힣]*$");
		Matcher genderMatcher1 = genderPattern1.matcher(userGender);
		if(!genderMatcher1.find()){
			script.println("<script>");
			script.println("alert('성병을 입력해주세요.');");
			script.println("history.back();");
			script.println("</script>");
			script.close();
			return;
		  }
	}
	if(request.getParameter("userNickName")!=null){
		userNickName = request.getParameter("userNickName");
	}
	if(request.getParameter("userPhoneNum")!=null){
		userPhoneNum = request.getParameter("userPhoneNum");
		Pattern phoneNumPattern1 = Pattern.compile("^01(?:0|1|[6-9])(?:\\d{3}|\\d{4})\\d{4}$");
		Matcher phoneNumMatcher1 = phoneNumPattern1.matcher(userPhoneNum);
		if(!phoneNumMatcher1.find()){
			script.println("<script>");
			script.println("alert('휴대폰 번호 - 없이 입력해주세요.');");
			script.println("history.back();");
			script.println("</script>");
			script.close();
			return;
		  }
	}
	if(request.getParameter("password")!=null){
		userPwd = request.getParameter("password");
		//비밀번호 : 영문 숫자 포함 8자 이상
		Pattern passPattern1 = Pattern.compile("^(?=.*[a-zA-Z])(?=.*\\d).{8,20}$");
		Matcher passMatcher1 = passPattern1.matcher(userPwd);
		if(!passMatcher1.find()){
			script.println("<script>");
			script.println("alert('비밀번호를 양식에 맞게 입력해주세요.');");
			script.println("history.back();");
			script.println("</script>");
			script.close();
			return;
		  }
	}
	if(request.getParameter("agreement")!=null){
		agreement = request.getParameter("agreement");
		if(agreement.equals("1"))
			userAd = 1;
		else
			userAd = 0;	
	}
	if(userEmail == null || userName == null || userGender == null || userNickName == null || 
			userPhoneNum == null || userPwd == null || agreement == null){
		script.println("<script>");
		script.println("alert('입력이 안 된 사항이 있습니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	}
	
  	UserMgr userMgr = new UserMgr();

	boolean result = userMgr.join(new UserinfoBean(userName, userGender, userNickName, userEmail, userPwd, userPhoneNum, SHA256.getSHA256(userEmail), userImage, userAd));
 	if(result) {
		script.println("<script>");
		script.println("alert('정상적인 로그인방식입니다..');");
		script.println("location.replace('login.jsp')");
		script.println("</script>");
		script.close();
		return;
	} else if(result==false) {
		script.println("<script>");
		script.println("alert('이미 존재하는 아이디입니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	} 
	
%>
<div>
<%=userName%>
<%=userGender%>
<%=userNickName%>
<%=userEmail%>
<%=userPwd%>
<%=userPhoneNum%>
<%=SHA256.getSHA256(userEmail)%>
<%=userImage%>
<%=userAd%>
<br>
<%=result %>
</div>
