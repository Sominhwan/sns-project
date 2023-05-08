<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="sns.UserinfoBean"%>
<jsp:useBean id="mgr" class="sns.UserMgr"/>


<%
	String Name = (String)session.getAttribute("idKey");
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
    <link rel="stylesheet" href="./css/profile.css"/>
    <link rel="stylesheet" href="./css/update.css" />
    <link rel="stylesheet" href="./css/modal.css" />
    <script src="js/navbar.js"></script>
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
    <title>회원수정 - PhoTalk</title>
  </head>
  <body>
    <hr />
    <hr class="line1" />
    <hr class="line2" />
    <hr class="line3" />
    <hr class="line4" />
    <hr class="line5" />
    <hr class="line6" />
    <hr class="line7" />

    <span class="Text-Name"> 성명 </span>
    <span class="Text-Nickname">닉네임</span>
    <span class="Text-Email">이메일 주소</span>
    <span class="Text-Phone">핸드폰 번호</span>
    <span class="Text-School">학교</span>
    <span class="Text-Address">집 주소</span>
    <span class="Text-Social">소셜 정보</span>
    <span class="Text-Info">개인 정보</span>
    <span class="Text-Update">탈퇴하기</span>
    <span class="gaininfo">개인정보</span>
    <div class="Text-Update2">
      <a href="update1.jsp" id="update2">수정하기</a>
    </div>
	
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

    <span class="Text-Name1"> <%=bean.getUserName() %> </span>
    <span class="Text-Nickname1"><%=bean.getUserNickName() %></span>
    <span class="Text-Email1"><%=bean.getUserEmail() %></span>
    <span class="Text-Phone1"><%=bean.getUserPN() %></span>
    <span class="Text-School1"><%=bean.getUserSchool() %></span>
    <span class="Text-Address1"><%=bean.getUserAddress() %></span>
    <span class="Text-Socail1" style= "font-family: MalgunGothic;
  position:absolute;
  left: 800px;
  top: 634px;
  font-size: 16px;
  line-height: 1.88;
  letter-spacing: normal;
  text-align: left;
  font-weight: norma;
  color: var(--black); " ><%=bean.getUserSocial() %></span>
	
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
    
    <div class="side-bar" style="
	position:fixed;
	bottom:0px;
	top: 0px;
	left: 0px;
    width: 360px;
    height: 100%;
    background-color: #e0e0e0;"></div>
    
    

    <div class="Info">
      <img src="./images/InfoIcon.svg" alt="정보" />
    </div>

    <div class="Update">
      <img src="./images/Update.svg" alt="수정" />
    </div>

    <div class="Info-Update">
      <img src="./images/infoUpdate.svg" alt="수정" />
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
</html>
