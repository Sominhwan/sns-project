<%@page contentType="text/html; charset=UTF-8"%>
<%
	String userEmail = null;
	String userRegDate = null;
	if(session.getAttribute("userEmail")!=null){
		userEmail = (String)session.getAttribute("userEmail");
	}
	if(session.getAttribute("userRegDate")!=null){
		userRegDate = (String)session.getAttribute("userRegDate");
	}
	session.invalidate();
%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="css/loading.css" />
    <link rel="stylesheet" href="css/findIdOkPage.css" />
    <link rel="shortcut icon" type="image/x-icon" href="images/loginLogo.png" />
    <title>아이디 찾기 - PhoTalk</title>
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
    <!-- 아이디 찾기 텍스트 -->
    <div class="findIdInfo-text">
      <img src="images/idFindLogo.png" id="idFindLogo" />
      <span id="findId-text">아이디 찾기</span>
    </div>
    <!-- 아이디 찾기 컨텐츠 -->
    <div class="findId-content">
      <div id="findIdComment">고객님의 정보와 일치하는 ID 입니다.</div>
      <div class="findId-box">
        <span id="email"><%=userEmail%></span>
        <span id="joinDate">가입일 : <%=userRegDate%></span>
      </div>
      <button
        type="submit"
        class="loginBtn"
        id="loginBtn"
        onclick="location.replace('login.jsp')"
      >
        로그인 하기
      </button>
      <button type="submit" class="findPwdBtn" id="findPwdBtn" onclick="">
        비밀번호 찾기
      </button>
    </div>
    <!-- 푸터 시작 -->
    <footer class="signUp_footer">
      <div class="footer_inner">
        <span class="footer_info">&copy;2023 Social Net Work Project</span>
      </div>
    </footer>
  </body>
  <script src="js/findId.js"></script>
  <script src="js/spin.js"></script>
</html>
