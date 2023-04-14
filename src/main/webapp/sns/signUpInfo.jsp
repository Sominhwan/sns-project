<%@page contentType="text/html; charset=UTF-8"%>
<%
	
	String [] value = request.getParameterValues("agreement");	
	int agreement = 0;
	if(value.length==3){
		agreement = 1;	
	}	
	
%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="css/signUpInfoPage.css" />
    <link rel="shortcut icon" type="image/x-icon" href="images/loginLogo.png" />
    <title>가입하기 - PhoTalk</title>
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
      
      var selectBox = function(value){
    	  document.getElementById('userGender').value = value;
    	}
      /* 페이지 전환 */
      
      function change(){
    	  if(signUp.gender.value ==""){ 
    		  alert("성별을 선택하세요.."); 
    		  signUp.gender.focus(); 
    		  return false; 
    	  } 
    	  document.signUp.submit(); 
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
    <!-- 가입정보 입력 컨텐츠 -->
    <div class="signUpInfo-text">
      <span id="signUp-text">가입정보를 입력해주세요.</span>
    </div>
    <!-- 가입정보 입력 폼 -->
    <div class="signUpInfo-content">
      <form action="signUpInfoProc.jsp" method="POST" name="signUp">
        <div class="input-box">
          <input
            id="userEmail"
            type="text"
            name="userEmail"
            placeholder="이메일을 입력해 주세요"
            maxlength="60"
            autocomplete="false"
          />
          <label for="userEmail">이메일을 입력해 주세요</label>
        </div>
        <div class="input-box">
          <input
            id="userName"
            class="userName"
            type="text"
            name="userName"
            placeholder="성명"
            maxlength="60"
            autocomplete="false"
          />
          <label for="userName">성명</label>
        </div>
        <select name="gender" id="select-box" onchange="selectBox(this.value)" >
          <option value="" selected disabled>=성별=</option>
          <option value="남자">남성</option>
          <option value="여자">여성</option>
        </select>

        <div class="input-box">
          <input
            id="userNickName"
            type="text"
            name="userNickName"
            placeholder="닉네임"
            maxlength="60"
            autocomplete="false"
          />
          <label for="userNickName">닉네임</label>
        </div>
        <div class="input-box">
          <input
            id="userPhoneNum"
            type="text"
            name="userPhoneNum"
            placeholder="휴대폰 번호('-' 없이)"
            maxlength="60"
            autocomplete="false"
          />
          <label for="userPhoneNum">휴대폰 번호('-' 없이)</label>
        </div>
        <div class="input-box">
          <input
            class="password"
            id="password"
            type="password"
            name="password"
            placeholder="비밀번호를 입력해 주세요 (8자 이상)"
            maxlength="50"
            autocomplete="false"
          />
          <label for="password">비밀번호를 입력해 주세요(영문,숫자 포함 8자 이상)</label>
          <span id="keyShow">
            <img src="images/pwdEyeBtnFalse.svg" alt="eye" />
          </span>
        </div>
        <input type="hidden" id="userGender" name="userGender">
        <input type="hidden" name="agreement" value="<%=agreement%>">
        <input
          class="next-button"
          id="next-button"
          name="next-button"
          type="button"
          disabled
          value="다음"
          onclick="change()"
        />
      </form>
    </div>
    <!-- 푸터 시작 -->
    <footer class="signUp_footer">
      <div class="footer_inner">
        <span class="footer_info">&copy;2023 Social Net Work Project</span>
      </div>
    </footer>
  </body>
  <script src="js/signUpInfo.js"></script>
  <script src="js/spin.js"></script>
</html>

