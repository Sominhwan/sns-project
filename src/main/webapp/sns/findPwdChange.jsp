<%@page import="java.io.PrintWriter"%>
<%@page contentType="text/html; charset=UTF-8"%>
<%
	if((String)session.getAttribute("userEmail")==null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('세션이 만료되었습니다.');");
		script.println("location.replace('login.jsp');");
		script.println("</script>");
		script.close();
	}
    String pwdAlert = null;	
	String userEmail = (String)session.getAttribute("userEmail");
	session.invalidate();
%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="css/findPwdChangePage.css" />
    <link rel="shortcut icon" type="image/x-icon" href="images/loginLogo.png" />
    <title>비밀번호 찾기 - PhoTalk</title>
    <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
    <script>
     var spinner;
      jQuery(function () {
        spinner = new Spinner().spin().el;
        jQuery(document.body).append(spinner);
        jQuery(spinner).css("display", "none");
      });
      window.onbeforeunload = function (e) {
        if (e != null && e != undefined) {
          jQuery(spinner).css("display", "");
        }
      }; 
      /* 비밀번호 유효성 검사 */
      function pwdForm_check(){
    	  var pwd = document.getElementById("userNewPwd");
    	  var repwd = document.getElementById("userNewPwdCheck");
    	  if(pwd.value!=repwd.value){
    		  document.getElementById("pwdCheck2").style.display='none';
    		  document.getElementById("pwdCheck1").style.display='block';
    		  pwd.value=null;
    		  repwd.value=null;
    		  pwd.focus();		  
    		  return false;
    	  }
    	  
    	  var pwdCheck = /^(?=.*[a-zA-Z])(?=.*[0-9]).{8,20}$/;
    	  if(!pwdCheck.test(pwd.value) || !pwdCheck.test(repwd.value)){
    		  document.getElementById("pwdCheck1").style.display='none';
    		  document.getElementById("pwdCheck2").style.display='block';
    		  pwd.value=null;
    		  repwd.value=null;
    		  pwd.focus();	  
    		  return false;
    	  } 
    	  document.findPwd_frm.action = "findPwdChangeProc.jsp"
          document.findPwd_frm.submit();  
      }
    </script>
  </head>
  <body>
    <nav id="navbar">
      <img src="images/joinLogo.png" id="signUpOkLogo" />
      <a href="login.jsp" id="logo">PhoTalk</a>
      <ul>
        <li><a href="signUp.jsp" class="signUp">회원가입</a></li>
        <li>|</li>
        <li><a href="login.jsp" class="signUp">로그인</a></li>
      </ul>
    </nav>
    <!-- 비밀번호 재설정 텍스트 -->
    <div class="findPwdInfo-text">
      <span id="findPwd-text">비밀번호 찾기</span>
    </div>
    <!-- 비밀번호 재설정 컨텐츠 -->
    <div class="findPwd-content">
      <div id="findPwdComment">새로운 비밀번호를 재설정해주세요.</div>
      <!-- 새 비밀번호 입력 폼 -->
      <div class="findPwdInput-container">
        <form method="POST" name="findPwd_frm" id = "findPwd_frm">
          <span class="idText">아이디</span>
          <span class="idText2"><%=userEmail%></span>
          <span class="pwdText">새 비밀번호</span>
          <input -webkit-autofill
            id="userNewPwd"
            type="text"
            name="userNewPwd"
            placeholder="영문 숫자 포함 8자 이상"
            maxlength="60"
            autocomplete="false"
            style="-webkit-box-shadow: 0 0 0 1000px #f9f9f9 inset"
          />
          <span class="pwdTextCheck">새 비밀번호 확인</span>
          <input
            id="userNewPwdCheck"
            type="password"
            name="userNewPwdCheck"
            placeholder="새 비밀번호 확인"
            maxlength="60"
            autocomplete="false"
          />
          <input name="userEmail" type="hidden" value="<%=userEmail%>">
          	<span id="pwdCheck1"style="display:none; position:absolute;left: 200px;top: 173px;color:#ed4956;font-size: 12px">
          		* 비밀번호가 일치하지 않습니다.
          	</span>
        
          	<span id="pwdCheck2" style="display:none; position:absolute;left: 200px;top: 173px;color:#ed4956;font-size: 12px">
          		* 비밀번호 양식이 틀립니다.
          	</span> 
        
          <button
            type="button"
            class="findPwdCheckBtn"
            id="findPwdCheckBtn"
            disabled
            onclick="pwdForm_check()"
          >
            확인
          </button>
        </form>
      </div>
    </div>
    <!-- 푸터 시작 -->
    <footer class="signUp_footer">
      <div class="footer_inner">
        <span class="footer_info">&copy;2023 Social Net Work Project</span>
      </div>
    </footer>
  </body>
  <script src="js/findPwdChange.js"></script>
  <script src="js/spin.js"></script>
</html>
