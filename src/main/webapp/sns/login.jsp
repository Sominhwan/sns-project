<%@page contentType="text/html; charset=UTF-8"%>
<%
		
%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="shortcut icon" type="image/x-icon" href="images/loginLogo.png" />
    <link rel="stylesheet" href="css/loginPage.css" />
    <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
    <title>PhoTalk</title>
  </head>
  <body>
    <div class="content">
      <div class="left-content">
        <div id="mockUp">
          <div id="imac">
            <img src="images/imacMockUP.png" />
          </div>
          <div id="iphone">
            <img src="images/iphoneMocUp.png" />
          </div>
          <div class="fade_container">
            <img class="active" src="images/iphoneScreen1.png" alt="image1" />
            <img src="images/iphoneScreen2.png" alt="image2" />
            <img src="images/iphoneScreen3.png" alt="image3" />
          </div>
        </div>
      </div>
      <!-- 로그인 컨테이너 -->
      <div class="login_container" id="login_container">
        <img src="images/loginLogo.png" />
        <span id="logo_text">PhoTalk</span>
        <form action="" method="POST">
          <div class="input-box">
            <input
              id="userEmail"
              type="text"
              name="userEmail"
              placeholder="이메일을 입력해 주세요"
              maxlength="60"
            />
            <label for="userEmail">이메일을 입력해 주세요</label>
            <span id="userEmailClear">
              <img src="images/loginEmailCancelBtn.svg" alt="emailCancel" />
            </span>
          </div>
          <div class="input-box">
            <input
              class="password"
              id="password"
              type="password"
              name="password"
              placeholder="비밀번호를 입력해 주세요"
              maxlength="50"
              autocomplete="false"
            />
            <label for="password">비밀번호를 입력해 주세요</label>
            <span id="keyShow">
              <img src="images/pwdEyeBtnFalse.svg" alt="eye" />
            </span>
          </div>
          <input
            class="loginBtn"
            id="loginBtn"
            name="loginBtn"
            type="button"
            disabled
            value="로그인"
            onclick="loginOK()"
          />
        </form>
        <input type="checkbox" id="myCheck" />
        <label for="myCheck"></label>
        <span id="auto_login_text">자동 로그인</span>

        <input type="checkbox" id="popup" />
        <label for="popup"></label>
        <div>
          <div>
            <label for="popup"></label>
          </div>
          <label for="popup"></label>
        </div>
        <div id="popup">
          <a href="#" class="btn-open" onClick="javascript:popOpen();">
            <img
              src="images/exclamation-circle-line.svg"
              style="cursor: help"
              alt="eye"
            />
          </a>
        </div>
        <!-- modal 영역 -->
        <div class="modal-bg" onClick="javascript:popClose();"></div>
        <div class="modal-wrap">
          <span id="modal_text"
            >개인정보 보호를 위해 개인 기기에서만 사용해 주세요.</span
          >
          <span id="cancelBtn" onclick="javascript:popClose();">
            <img src="images/makePostCancelBtn.svg" />
          </span>
        </div>
        <span class="id_pwd" id="id_find"><a href="findId.html">ID</a></span>
        <span class="id_pwd" id="idPwd">/</span>
        <span class="id_pwd" id="pass_find"
          ><a href="findPwd.html">PASS 찾기</a></span
        >
        <span id="kakaoLogin"
          ><a href="#"><img src="images/kakaoLoginBtn.svg" /></a
        ></span>
        <span id="naverLogin"
          ><a href="#"><img src="images/naverLoginBtn.svg" /></a
        ></span>
        <span id="signUp">아직도 회원이 아닌가요?</span>
        <span id="signUpTag"><a href="signUp.jsp">회원가입</a></span>
      </div>
      <!-- 로그인 완료 컨테이너 -->
      <div class="loginOK_container" id="loginOK_container" hidden>
        <img src="images/loginLogo.png" />
        <span id="logo2_text">PhoTalk</span>
        <!-- TODO 프로필 이미지 넣기 -->
        <img class="profile" src="images/profile.svg" />
        <form action="" method="POST">
          <input
            class="loginOKBtn"
            id="loginOKBtn"
            name="loginOKBtn"
            type="button"
            disabled
            value="... 님으로 계속"
            onclick=""
          />
        </form>
        <span id="login">... 님이 아닌가요?</span>
        <span id="loginTag"><a href="#" onclick="loginOK()">계정 변경</a></span>
      </div>
    </div>
    <!-- 푸터 -->
    <footer class="login_footer">
      <div class="footer_inner">
        <span class="footer_info"><a href="#">소개</a></span>
        <span class="footer_info">|</span>
        <span class="footer_info"><a href="#">채용안내</a></span>
        <span class="footer_info">|</span>
        <span class="footer_info"><a href="#">이용약관</a></span>
        <span class="footer_info">|</span>
        <span class="footer_info"><a href="#">도움말</a></span>
        <span class="footer_info">|</span>
        <span class="footer_info"><a href="#">운영정책</a></span>
        <span class="footer_info">|</span>
        <span class="footer_info"><a href="#">위치</a></span>
        <span class="footer_info">|</span>
        <span class="footer_info"><a href="#">인기 계정</a></span>
        <span class="footer_info">|</span>
        <span class="footer_info"><a href="login.jsp">사이트맵</a></span>
        <br />
        <span class="footer_info2">(주) 자바A_Project </span>
        <span class="footer_info2"
          >부산광역시 부산진구 엄광로 176(가야동)
        </span>
        <span class="footer_info2">전화: 010-1111-1111</span>
        <br />
        <span class="footer_info3">E-mail: thalsghks@naver.com</span>
        <span class="footer_info3">사업자등록번호: 111-11-11111호</span>
        <br />
        <span class="footer_info4">&copy;2023 Social Net Work Project</span>
      </div>
    </footer>
  </body>
  <script src="js/login.js"></script>
</html>
