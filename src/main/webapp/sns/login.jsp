<%@page import="java.math.BigInteger"%>
<%@page import="java.security.SecureRandom"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="sns.UserMgr"%>
<%@page import="java.io.PrintWriter"%>
<%@page contentType="text/html; charset=UTF-8"%>
  <%
   /* 일반 로그인 */
	request.setCharacterEncoding("UTF-8"); 
	PrintWriter script = response.getWriter();
	
	String userEmail = null;
	String userNickName = null;
	String userImage = null;
	String alertContent = null;

	Cookie[] cs = request.getCookies();
	
	if(session.getAttribute("userEmail")!=null){
		userEmail = (String)session.getAttribute("userEmail");
		for(Cookie c : cs){
			if(c.getName().equals("loginCookie")){
				System.out.println("안녕");
				userEmail = c.getValue();
			}
		}
	}
	
	if(session.getAttribute("userNickName")!=null){
		userNickName = (String)session.getAttribute("userNickName");
	}
	
	if(session.getAttribute("userImage")!=null){
		userImage = (String)session.getAttribute("userImage");	
	}
	
	if(session.getAttribute("alertContent")!=null){
		alertContent = (String)session.getAttribute("alertContent");
	}
	
	/* 네이버 로그인 */
	String clientId = "8k6tTgl_X5mXWraZ1X4k";//애플리케이션 클라이언트 아이디값";
	String redirectURI = URLEncoder.encode("http://localhost:8081/sns-project/sns/naverLoginOk", "UTF-8");
	SecureRandom random = new SecureRandom();
	String state = new BigInteger(130, random).toString();
	String apiURL = "https://nid.naver.com/oauth2.0/authorize?response_type=code";
	apiURL += "&client_id=" + clientId;
	apiURL += "&redirect_uri=" + redirectURI;
	apiURL += "&state=" + state;
	session.setAttribute("state", state);	
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
    <script type="text/javascript" src="https://developers.kakao.com/sdk/js/kakao.js"></script>
    <title>PhoTalk</title>
    <script type="text/javascript">
      /* 로그인 확인 폼 제출 */
      function loginFrm(){
    	  document.login_frm.submit();       	
      }
      /* 로그인 폼 엔터키로 이벤트 발생 */
      function onEnterLogin(){
   		var keyCode = window.event.keyCode;
   		if (keyCode == 13) { //엔테키 이면
	   		document.login_frm.submit(); 
   		}
  	  }   
      /* 메인화면 이동 검증 */
      function checkEmail(){
      <% 
      	 UserMgr userMgr = new UserMgr();
         int userEmailCertification = userMgr.getEmailcertification(userEmail); 
      %>
   		if(<%=userEmailCertification%>==1){
   			alert('이메일 검증 확인');
   			/* document.loginOk_frm.submit(); */	
   		}else{
   			alert('이메일 인증을 하지 않은 계정입니다.');
   		}
  	  }
      
      /* 카카오 로그인 */
      Kakao.init('7b282dfd5c5c643acd7323bd051ec42b');
		function loginWithKakao() {
     	 Kakao.Auth.login({
          success: function (authObj) {
              console.log(authObj); // access토큰 값
              Kakao.Auth.setAccessToken(authObj.access_token); // access토큰값 저장
              getInfo();
          },
          fail: function (err) {
              console.log(err);
          }
     	 });
  	   }
		function getInfo() {
          Kakao.API.request({
              url: '/v2/user/me',
              success: function (res) {
            	  var id = res.id;  
            	  var email = res.kakao_account.email;      
                  var nickname = res.kakao_account.profile.nickname;
                  var gender = res.kakao_account.gender;
                  f = document.kakaologin;
          		  f.id.value = id; 
          		  f.email.value = email;
          		  f.nickname.value = nickname;
          		  f.gender.value = gender;
          		  f.submit();
              },
              fail: function (error) {
                  alert('카카오 로그인에 실패했습니다. 관리자에게 문의하세요.' + JSON.stringify(error));
              }
          });
       }
    </script>
  </head>
  <body onkeydown="javascript:onEnterLogin();">
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
    <% if(userEmail==null){ %>
      <div class="login_container" id="login_container">
        <img src="images/loginLogo.png" />
        <span id="logo_text">PhoTalk</span>
        <form action="loginChange" method="POST" name="login_frm" id = "login_frm">
          <div class="input-box">
            <input -webkit-autofill
              id="userEmail"
              type="text"
              name="userEmail"
              placeholder="이메일을 입력해 주세요"
              maxlength="60"
              style="-webkit-box-shadow: 0 0 0 1000px #fff inset"
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
              <img src="https://velog.velcdn.com/images/thalsghks/post/7910658e-94d5-4e16-b24a-a19ad98f6e70/image.svg" alt="eye" />
            </span>
          </div>      
          <input type="checkbox" id="myCheck" name="myCheck" />
        <label for="myCheck"></label>
        <span id="auto_login_text">자동 로그인</span>

        <input type="checkbox" id="popup" name="myCheck"/>
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
          <input
            class="loginBtn"
            id="loginBtn"
            name="loginBtn"
            type="button"
            disabled
            value="로그인"
            onclick="loginFrm()"
          />
        </form>
        
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
        <span class="id_pwd" id="id_find"><a href="findId.jsp">ID</a></span>
        <span class="id_pwd" id="idPwd">/</span>
        <span class="id_pwd" id="pass_find"
          ><a href="findPwd.jsp">PASS 찾기</a></span
        >
        <span id="kakaoLogin"
          ><a href="javascript:loginWithKakao()"><img src="images/kakaoLoginBtn2.svg" /></a
        ></span>
        <span id="naverLogin"
          ><a href="<%=apiURL%>"><img src="images/naverLoginBtn.svg" /></a
        ></span>
        <!-- 카카오 개인정보 저장 폼 -->
        <form name="kakaologin" method="post" action="kakaoLoginOk">
  	    <input type="hidden" name="id"/>
  	    <input type="hidden" name="email"/>
		<input type="hidden" name="nickname"/>
		<input type="hidden" name="gender"/>
	    </form>
	    <!-- 로그인 실패시 뜨는 문구 -->
        <%if(alertContent!=null){ //session.invalidate(); %>
           <span style="position: absolute; left: 71px; top: 530px;
           color:#ed4956; font-size:14px">* 로그인에 실패하였습니다.</span>
         <%}%>   
           
        <span id="signUp">아직도 회원이 아닌가요?</span>
        <span id="signUpTag"><a href="signUp.jsp">회원가입</a></span>
      </div>
     <% } else { %>
      <!-- 로그인 완료 컨테이너 --> 
      <div class="loginOK_container" id="loginOK_container">
        <img src="images/loginLogo.png" />
        <span id="logo2_text">PhoTalk</span>
        <img class="profile" src="<%=userImage%>" />
        <!-- form action 에 메인 페이지 주소 넣기 -->
        <form action="" method="POST" name="loginOk_frm" id = "loginOk_frm">
          <input
            class="loginOKBtn"
            id="loginOKBtn"
            name="loginOKBtn"
            type="button"
            value="<%=userNickName%> 님으로 계속"
            onclick="checkEmail()"
            style="cursor: pointer;"
          />
           <span id="login" style="position: absolute;height: 18px;width: 519.5px;font-size: 18px;
           color: #868e96;top: 450px;left:25%;transform: translate(0%, 0%);"><%=userNickName%> 님이 아닌가요? <a href="#" 
        style="text-decoration: none;color: #1877f2;"
        onclick="location.replace('loginChange')">계정 변경</a></span>
        </form>
       
      </div>
      <% } %>
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

