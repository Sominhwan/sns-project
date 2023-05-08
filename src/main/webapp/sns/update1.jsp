<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="sns.UserinfoBean"%>
<jsp:useBean id="mgr" class="sns.UserMgr"/>

<%
request.setCharacterEncoding("UTF-8");  
	String Name = (String)session.getAttribute("idKey");
	String email = (String)session.getAttribute("userEmail");
	UserinfoBean bean = mgr.getMember(email);
	String userInfoType = bean.getUserInfoType();
	if(userInfoType == null){
		userInfoType = "1";
	}
	System.out.print(userInfoType);
%>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link type="text/css" rel="stylesheet" href="css/navbar.css"></link>    
    <link rel="stylesheet" href="./css/update1.css" />
    <link rel="stylesheet" href="./css/profile.css"/>
    <link rel="stylesheet" href="./css/modal.css"/>
    <title>회원 정보 변경</title>
    <link
      rel="shortcut icon"
      type="image/x-icon"
      href="./images/loginLogo.png"
    />
     <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script src="js/navbar.js"></script>      
    <script>
    function frmSubmit(){
        var nickname = document.getElementById('nickname').value;
        var email = document.getElementsByClassName('email').value;
        var school = document.getElementById('school').value;
        var social = document.getElementById('social').value;
        var post = document.getElementById('member_post').value;
        
     // 입력값이 없는 경우 오류 메시지 출력
        if (nickname === '') {
          alert('닉네임을 입력해주세요.');
          return false;
        }
        if (email === '') {
          alert('이메일을 입력해주세요.');
          return false;
        }
        if (school === '') {
          alert('학교명을 입력해주세요.');
          return false;
        }
        if (post === ''){
          alert('주소를 입력해주세요.')
          return false;
        }
        if (social === '') {
          alert('소셜주소를 입력해주세요.');
          return false;
        }
        
        document.userInfo_frm.action="update1Proc.jsp";
        document.userInfo_frm.submit();
      }

        function findAddr() {
            new daum.Postcode({
              oncomplete: function (data) {
                console.log(data);
                var roadAddr = data.roadAddress; // 도로명 주소 변수
                var jibunAddr = data.jibunAddress; // 지번 주소 변수
                document.getElementById("member_post").value = data.zonecode;
                if (roadAddr !== "") {
                  document.getElementById("member_addr").value = roadAddr;
                } else if (jibunAddr !== "") {
                  document.getElementById("member_addr").value = jibunAddr;
                }
              },
            }).open();
          }
        function openPopup() {
	    	  var url = "search.jsp"; // 열고자 하는 페이지 URL
	    	  var name = "searchWindow"; // 팝업 창 이름
	    	  var option = "width=500, height=500, top=100, left=100, resizable=no, scrollbars=no"; // 팝업 창 옵션
	    	  window.open(url, name, option);
	    	}
        
        
    </script>
    <style>
		body {
			overflow: hidden;
		}
	</style>

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


<button style="z-index: 1000;
position: absolute;
position:absolute;
    left: 995px;
    top: 505px;
    cursor: pointer;
    background-color: #303030;
    color: white; " onclick="openPopup()">학교 검색</button>
    <hr />
    <hr class="line1" />
    <hr class="line2" />
    <hr class="line3" />
    <hr class="line4" />
    <hr class="line5" />
    <hr class="line6" />
    <hr class="line7" />
   
	<span class="Text-Name1"> <%=bean.getUserName() %> </span>
	<span class="Text-Phone1"><%=bean.getUserPN() %></span>
    <span class="Text-Name"> 성명 </span> 
    <span class="Text-Nickname">닉네임</span>
    <span class="Text-Email">이메일 주소</span>
    <span class="Text-Phone">핸드폰 번호</span>
    <span class="Text-School">학교</span>
    <span class="Text-Address">집 주소</span>
    <span class="Text-Socail">소셜 정보</span>
    <span class="Text-Info">개인 정보</span>
    <span class="Text-Update">탈퇴하기</span>
    <span class="gaininfo">개인정보</span>
    <div class="Text-back">
      <a href="update.jsp" id="back">뒤로가기</a>
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

    <form method="POST" name="userInfo_frm">
      <div class="nickname-box">
        <input
          id="nickname"
          type="text"
          name="nickname"
          placeholder="닉네임을 입력하세요"
          maxlength="10"
          autocomplete="false"
        />
        <!-- <label for="userEmail">닉네임을 입력해주세요</label> -->
      </div>

      <div class="email-box">
        <input
        <%if(userInfoType.equals("naver")||userInfoType.equals("kakao")) { %>
          
          value="<%=bean.getUserEmail() %>"
          style="background-color: #efefef4d;
          color: #aaa;"
          id="email2" 
          readonly
     	  <%} else if(userInfoType.equals("1")) { %>
          id="email"
          <%} %>           
          type="text"
          name="email"
          placeholder="이메일을 입력하세요." 
          maxlength="30"
          autocomplete="false"
          
        />
      </div>
      
<input type="hidden" name="selectedUni" value="<%= request.getParameter("selectedUni") %>">
<input
    id="school"
    type="text"
    name="school"
    placeholder="학교명을 입력하세요"
    maxlength="10"
    autocomplete="false"
    value=""
    readonly
/>


      <div class="social-box">
        <input
          id="social"
          type="text"
          name="social"
          placeholder="소셜주소를 입력하세요"
          maxlength="30"
          autocomplete="false"
        />
      </div>
    <input id="member_post" type="text" name="member_post" placeholder="우편번호" readonly />
    <input id="member_addr" type="text" name="member_addr" placeholder="주소" readonly />

      <button
        class="change"
        type="submit"
        id="re"
        onclick="frmSubmit()"
      >
        변경하기
      </button>

      
    </form>
    


    <br />
    <button class="address" onclick="findAddr()">우편 번호</button>

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
