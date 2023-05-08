<%@page import="java.io.PrintWriter"%>
<%@page import="sns.UserinfoBean"%>
<%@page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="mgr" class="sns.UserMgr" />

<%
String Name = (String) session.getAttribute("idKey");
String email = (String)session.getAttribute("userEmail");
UserinfoBean bean = mgr.getMember(email);

%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet" href="./css/email.css" />
<link rel="stylesheet" href="./css/profile.css"/>
<link rel="stylesheet" href="./css/modal.css"/>
<style>
		body {
			overflow: hidden;
		}
	</style>
<title>이메일 인증</title>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script>
	function frmSubmit() {
		document.userInfo_frm.submit();
	}
	
	function resend() {
		alert("재전송 완료");
        $.ajax({
            url : "Resend",
            type:'POST',
            data: '재전송 완료',
            dataType:'text',

            success:function(data){

            },error:function(){
                alert("재전송 실패!");
            }
        });
	}
</script>
<link
      rel="shortcut icon"
      type="image/x-icon"
      href="./images/loginLogo.png"
    />
</head>
<body>
<nav>
      <div class="navbar">
        <img src="./images/mainLogo.png" alt="Image Button" />
        <a id="PhoTalk" class="navbar-brand" href="profile.html">PhoTalk</a>
        <span><input class="InputBase" placeholder="검색" /></span>
        <img
          id="mainMessageFalse"
          src="./images/mainMessageFalse.png"
          alt="Image Button"
        />
        <img
          id="mainAlarmFalse"
          src="./images/mainAlarmFalse.png"
          alt="Image Button"
        />
        <img
          id="mainProfile2"
          src="./images/mainProfile2.png"
          alt="Image Button"
        />
      </div>
    </nav>
    <!-- 모달창 -->
<div id="modal" class="modal">
  <div class="modal-content">
    <span class="close">&times;</span>
    <div class="modal-body">
    <a href =profile.jsp style="text-decoration: none; color: black;"><img class= "Profile"src="./images/mainProfileModalProfile.svg"><span class="Profile-T">프로필 보기</span></a>
    <a href =update.jsp style="text-decoration: none; color: black;"><img class= "N-Info"src="./images/mainProfileModalInfo.svg"><span class="Info-T">개인 정보</span><br></a>
    <a href =help.jsp style="text-decoration: none; color: black;"><img class= "Help"src="./images/mainProfileModalHelp.svg"><span class="Help-T">도움말</span><br></a>
    <a href =login.jsp style="text-decoration: none; color: black;"><img class= "Logout" src="./images/mainProfileModalLogout.svg"><span class="Logout-T">로그아웃</span><br></a>
  </div>
  </div>
</div>
		<script>
		// 모달창 보이기
		document.getElementById("mainProfile2").addEventListener("click", function() {
		  document.getElementById("modal").style.display = "block";
		});
		// 모달창 외부를 클릭하면 모달창 닫기
		window.onclick = function(event) {
		  if (event.target == document.getElementById("modal")) {
		    document.getElementById("modal").style.display = "none";
		  }
		}
		</script>
<div class=parent> 
	<span class="Text-Info">개인 정보</span>
	<span class="Text-Update">탈퇴하기</span>
	<span class="main">회원 탈퇴를 위한 </span>
	<span class="main1">이메일 인증 </span>
	<span class="main2">을 해주세요 </span>
	<span class="small-main"><%=bean.getUserEmail()%> 로 보내드린 인증 메일을 확인해주세요.</span>
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
    z-index: -10;
    background-color:
 #e0e0e0;"></div>

	<div class="popup-container">
		<div class="popup-content">
			<span class="popup-real">정말 탈퇴하시겠어요?</span> <span class="pupup-info">탈퇴
				버튼 선택 시 , 계정은 삭제되며 복구되지 않습니다.</span>
			<button id="pupup-button-cencel">취소</button>
			<button id="pupup-button-delete" onclick="document.emailCode.submit();">탈퇴</button>
		</div>
	</div>
	<form action="emailSendproc2.jsp" name="emailCode" id="emailCode">
		<div class="num-box">
			<input id="num" type="text" name="num" placeholder="인증번호 입력"
				maxlength="10" autocomplete="false" /> 
				<!-- onclick 에 재전송 함수 호출 -->
		    
		    
			<span id="popup-button">확인</span>
		</div>
	</form>
	<form method="post">
	<button class="resend" onclick="resend()">재전송</button>
	</form>
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

<script src="./js/email.js"></script>
</html>
