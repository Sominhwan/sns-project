<%@page contentType="text/html; charset=UTF-8"%>
<%
		
%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="css/findPwdPage.css" />
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
    <!-- 비밀번호 찾기 텍스트 -->
    <div class="findPwdInfo-text">
      <span id="findPwd-text">비밀번호 찾기</span>
    </div>
    <!-- 비밀번호 찾기 컨텐츠 -->
    <div class="findPwd-content">
      <div id="findPwdComment">비밀번호 찾기를 위한 ID를 입력해주세요.</div>
      <!-- 비밀번호 폼 -->
      <form action="findPwdProc.jsp" method="POST">
        <div class="input-box">
          <input -webkit-autofill
            id="userEmail"
            type="text"
            name="userEmail"
            placeholder="이메일을 입력해주세요"
            maxlength="60"
            autocomplete="false"
            style="-webkit-box-shadow: 0 0 0 1000px #fff inset"
          />
          <label for="userEmail">이메일을 입력해주세요</label>
        </div>
        <button
          type="submit"
          class="findPwdBtn"
          id="findPwdBtn"
          disabled
        >
          다음
        </button>
      </form>
    </div>
    <!-- 푸터 시작 -->
    <footer class="signUp_footer">
      <div class="footer_inner">
        <span class="footer_info">&copy;2023 Social Net Work Project</span>
      </div>
    </footer>
  </body>
  <script src="js/findPwd.js"></script>
  <script src="js/spin.js"></script>
</html>
