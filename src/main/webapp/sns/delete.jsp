<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="sns.UserinfoBean"%>
<jsp:useBean id="mgr" class="sns.UserMgr"/>
<%

	String Name = (String)session.getAttribute("id");
	String email = (String)session.getAttribute("userEmail");
	UserinfoBean bean = mgr.getMember(email);


%>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link type="text/css" rel="stylesheet" href="css/navbar.css"></link>    
    <link rel="stylesheet" href="./css/delete.css" />
    <link rel="stylesheet" href="./css/profile.css"/>
    <link rel="stylesheet" href="./css/modal.css"/>
    <script src="js/navbar.js"></script>    
    <title>회원 탈퇴</title>
    <style>
		body {
			overflow: hidden;
		}
	</style>
	<link
      rel="shortcut icon"
      type="image/x-icon"
      href="./images/loginLogo.png"
    />
  </head>
  <body>
	<nav>
    	<div class = "navbar">
         	<a href="javascript:goURL('Main.jsp','')"><img src="./images/mainLogo.png"  alt="Image Button"/></a>
	     	<a id = "PhoTalk" class = "navbar-brand" href="Main.jsp">PhoTalk</a>
	        <img src="images/mainSearch.svg" alt="mainSearch" style="position:relative; left:180px;"/>	     	
	     	<!-- 네브바 추가할것 !!!! -->
		    <form method="post" action="searched.jsp">
	        	<span><input type="text" class = "InputBase" placeholder="검색" name="searchWord" onkeyup="searchUser()" autocomplete="off"></span>
	        </form>
	        <!-- 모달창 -->
	        <div class="absol">
	        <img id = "mainMessageFalse" src="./images/mainMessageFalse.png" alt="Image Button" style="cursor: pointer"/>
	        <div id="alarm" class="alarm">
	        <span class="alarmBalloon"></span>
	        </div>
	        </div>             
	        <img id = "mainAlarmFalse" src="./images/mainAlarmFalse.png" alt="Image Button" style="cursor: pointer"/>
	    	<img id = "mainProfile2" src="./images/mainProfile2.png" alt="Image Button" onclick="profileModal()" style="cursor: pointer"/>
    	</div>
	</nav>

      <div class="go-update">
      <a href="update.jsp" id="go" style="
    z-index: 200;
    position: absolute;
	left: 0px;
    top: 150px;
	width: 360px;
  	height: 60px;"></a>
    </div>
    
    <div class="go-delete">
    <a href="delete.jsp" id="go-delete" style="
 	z-index: 200;
    position: absolute;
	left: 0px;
    top: 210px;
	width: 360px;
  	height: 60px;">
    </a>
    </div>
    
  <style>
input[type="checkbox"] + label {
	z-index : 10;
    position: absolute;
    top: 676px;
    left: 782px;
    width: 19.1px;
    height: 19.1px;
    background: url("./images/withdrawCheckBoxFalse.svg") no-repeat 0 0px /
      contain;
    cursor: pointer;
  }
  	input[type="checkbox"] {
  	display: none;
	}
  
  input[type="checkbox"]:checked + label {
    background: url("./images/withdrawCheckBoxTrue.svg") no-repeat 0 0px / contain;
    cursor: pointer;
  }
</style>
    <span class="Text-Info">개인 정보</span>
    <span class="Text-Update">탈퇴하기</span>
    <span class="big-delete" >회원 탈퇴</span>
    <span class="long"
      >지금까지 PhoTalk 서비스를 이용해주셔서 감사합니다.<br />
      회원을 탈퇴하면 내 계정 정보 및 모든 서비스 정보 내역이 삭제되고 복구 할
      수 없습니다</span
    >
    <div class="empty-box"></div>
    <span class="email">회원 이메일</span>
    <span class="email1"><%=bean.getUserEmail() %></span>
    <span class="sign-date">가입일 : <%=bean.getUserRegDate() %></span>
    <span class="agree">위 내용을 숙지하였으며 동의합니다.</span>

    <div class="Info">
      <img src="./images/InfoIcon.svg" alt="정보" />
    </div>

    <div class="Update">
      <img src="./images/Update.svg" alt="탈퇴" />
    </div>

    <div class="side-bar" style="
	position:fixed;
	bottom:0px;
	top: 0px;
	left: 0px;
    width: 360px;
    height: 100%;
    background-color: #e0e0e0;"></div>

    <div class="container"></div>
    <img id="withdrawCheckBox" name="withdrawCheckBox" src="./images/withdrawCheckBoxFalse.svg" />
    
    
<form action="emailProc.jsp" method="post">
  <input type="checkbox" id="withdrawCheckbox" name="withdrawCheckbox">
  <label for="withdrawCheckbox"></label>

  <button id="aButton" style="position: absolute;
  left: 782px;
  top: 729px;
  background-color:  #e7e7e7;
  width: 608px;
  height: 59px;
  font-family: MalgunGothic;
  color: #a4a4a4;
  text-align: center;
  font-size: 25px;
  border: none;
  line-height: 50px;" disabled>회원 탈퇴</button>
</form>

<script>
const withdrawCheckbox = document.getElementById('withdrawCheckbox');
const aButton = document.getElementById('aButton');
  
withdrawCheckbox.addEventListener('change', () => {
  if (withdrawCheckbox.checked) {
    aButton.removeAttribute('disabled');
    aButton.style.backgroundColor = '#303030';
    aButton.style.color = '#ffffff';
    aButton.style.cursor = 'pointer';
    
  } else {
    aButton.setAttribute('disabled', true);
    aButton.style.backgroundColor = '#e7e7e7';
    aButton.style.color = '#a4a4a4';
    aButton.style.border = 'none';
  }
});
</script>
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
  
  
</html>
