<%@page import="java.io.PrintWriter"%>
<%@page import="java.math.BigInteger"%>
<%@page import="java.security.SecureRandom"%>
<%@page import="java.net.URLEncoder"%>
<%@page contentType="text/html; charset=UTF-8"%>
<%
	/* 네이버 회원가입 */
	String clientId = "8k6tTgl_X5mXWraZ1X4k";//애플리케이션 클라이언트 아이디값";
	String redirectURI = URLEncoder.encode("http://localhost:8081/sns-project/sns/naverLogin", "UTF-8");
	SecureRandom random = new SecureRandom();
	String state = new BigInteger(130, random).toString();
	String apiURL = "https://nid.naver.com/oauth2.0/authorize?response_type=code";
	apiURL += "&client_id=" + clientId;
	apiURL += "&redirect_uri=" + redirectURI;
	apiURL += "&state=" + state;
	session.setAttribute("state", state);	
	
	request.setCharacterEncoding("UTF-8"); 
	PrintWriter script = response.getWriter();
	
	if(request.getAttribute("userEmail")!=null){
		script.println("<script>");
		script.println("alert('이미 존재하는 계정입니다.');");
		//script.println("history.back();");
		script.println("</script>");
		//script.close();
	}
%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="css/loading.css" />
    <link rel="stylesheet" href="css/signUpPage.css" />
    <link rel="shortcut icon" type="image/x-icon" href="images/loginLogo.png" />
    <title>가입하기 - PhoTalk</title>
    <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
    <script src="js/spin.js"></script>
    <script src="js/login.js"></script>
    <script type="text/javascript" src="https://developers.kakao.com/sdk/js/kakao.js"></script>
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
      
      /* 카카오 회원가입 */
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
  <body>
    <nav id="navbar">
      <img src="images/joinLogo.png" id="joinLogo" />
      <a href="login.jsp" id="logo">PhoTalk</a>
      <ul>
        <li><a href="signUp.jsp" class="signUp">회원가입</a></li>
        <li>|</li>
        <li><a href="login.jsp" class="signUp">로그인</a></li>
      </ul>
    </nav>
    <div class="signUp-logo">
      <img src="images/joinWelcomeLogo.png" id="logo2" />
      <span id="signUp-text">Welcome to PhoTalk</span>
      <span id="signUp-select">회원가입 방식을 선택하세요.</span>
    </div>
    <!-- 회원가입 버튼 -->
    <div class="signUp-Btn">
      <hr />
      <div id="signUpBtn_false">
        <a href="termsService.jsp"
          ><img
            src="images/emailBtn.svg"
            onmouseover="this.src='images/emailBtnTrue.svg'"
            onmouseout="this.src='images/emailBtn.svg'"
            id="emailBtn"
          />
        </a>
      </div>
      <div id="naverSignUpBtn_false">
        <a href="<%=apiURL%>"
          ><img
            src="images/naverBtn.svg"
            onmouseover="this.src='images/naverBtnTrue.svg'"
            onmouseout="this.src='images/naverBtn.svg'"
            id="naverBtn"
        /></a>
      </div>
      <div id="kakaoSignUpBtn_false">
        <a href="javascript:loginWithKakao()"
          ><img
            src="images/kakaoBtn.svg"
            onmouseover="this.src='images/kakaoBtnTrue.svg'"
            onmouseout="this.src='images/kakaoBtn.svg'"
            id="kakaoBtn"
        /></a>
      </div>
    </div>
    <!-- 카카오 개인정보 저장 폼 -->
    <form name="kakaologin" method="post" action="termsService.jsp">
  	<input type="hidden" name="id"/>
  	<input type="hidden" name="email"/>
	<input type="hidden" name="nickname"/>
	<input type="hidden" name="gender"/>
  </form>
    <!-- 푸터 시작 -->
    <footer class="signUp_footer">
      <div class="footer_inner">
        <span class="footer_info">&copy;2023 Social Net Work Project</span>
      </div>
    </footer>
  </body>
</html>
