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
    <link rel="stylesheet" href="css/adminPage.css" />
    <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
    <title>관리자페이지 - Photalk</title>
    <script type="text/javascript">
    	var request = new XMLHttpRequest();
    	function searchFunction(){
    		request.open("Post", "UserSearch?userName=" + encodeURIComponent(document.getElementById("userName").value),true);
    		request.onreadystatechange = searchProcess;
    		request.send(null);
    	}
    	function searchProcess(){
    		var table = document.getElementById("ajaxTable");
    		table.innerHTML = "";
    		// 통신 성공시
    		if(request.readyState == 4 && request.status == 200){
    			var object = eval('(' +request.responseText + ')');
    			var result = object.result;
    			for(var i = 0; i<result.length; i++){
    				var row = table.insertRow(0);
    				for (var j = 0; j < result[i].length; j++) {
						var cell = row.insertCell(j);
						cell.innerHTML = result[i][j].value;	
					}
    			}
    		}
    	}
    	window.onload = function(){
    		searchFunction();
    	}
    </script>
  </head>
  <body>
    <div class="left-side">
    <aside>
      <div id="side-logo">
        <img src="adminImages/adminLogo.png" alt="logo" /><a
          href="adminPage.jsp"
          id="adminLogo"
          >PhoTalk</a
        >
      </div>
      <ul>
        <li>
          <a href="login.jsp" class="icon"
            ><img src="adminImages/adminProfile.svg" alt="userImg" /><span
              class="sideText"
              >회원</span
            >
            관리</a
          >
        </li>
        <li>
          <a href="#news"
            ><img
              src="adminImages/adminPost.svg"
              alt="postImg"
              class="icon"
            /><span class="sideText">게시물 관리</span></a
          >
        </li>
        <li>
          <a href="#contact"
            ><img
              src="adminImages/adminMail.svg"
              alt="messageImg"
              class="icon"
            /><span class="sideText">메일 보내기</span></a
          >
        </li>
      </ul>
      <!-- 로그아웃 -->
      <div id="logout">
        <img
            src="adminImages/adminLogout.svg"
            alt="logoutImg"
            class="icon"
            style="width: 25px;"
          /><span class="sideText"><a href="#contact" id="logout"
            >로그아웃</span></a
        >
      </div>
      <!-- 푸터 시작 -->
      <footer class="sidebar-footer">
        <div class="footer-inner">
            <span class="footer_info"><a href="#">소개</a></span>
            <span class="footer_info"><a href="#">채용안내</a></span>
            <span class="footer_info"><a href="#">이용약관</a></span>
            <span class="footer_info"><a href="#">도움말</a></span>
            <span class="footer_info"><a href="#">운영정책</a></span>
            <span class="footer_info"><a href="#">위치</a></span>
            <span class="footer_info"><a href="#">인기 계정</a></span>
            <span class="footer_info"><a href="login.jsp">사이트맵</a></span>
            <span class="footer_info"><a>&copy;2023 Social Net Work Project</a></span>
      </div>
        </div>
      </footer>
    </aside>
</div>
    <!-- 회원정보 네비게이션 바 -->
    <nav id="navbar">
        <span id = "adminProfileLogo">
        <img src="adminImages/adminProfileLogo.svg" />
        </span>
        <span id="adminProfile-text">회원 관리</span>    
    </nav>
    <!-- 회원정보 컨텐츠 -->
    <div class="userTable">
        <div id="userManage">
            회원관리
        </div>
        <div id="searchBox">
            <input class="search" name="search" id="userName" onkeyup="searchFunction()" type="text" placeholder="성명을 입력하세요"/>
            <button type="button" class="searchBtn" onclick="searchFunction();"></button>
        </div>
        <!-- 회원정보 테이블 -->
        <div class="userTable-content">
        <table class="userTable">
            <thead id="head">
                <tr>
                    <th scope="cols">번호</th>
                    <th scope="cols">성명</th>
                    <th scope="cols">닉네임</th>
                    <th scope="cols">이메일 주소</th>
                    <th scope="cols">id값</th>
                    <th scope="cols">휴대폰 번호</th>
                    <th scope="cols">주소</th>
                    <th scope="cols">이메일 인증</th>
                    <th scope="cols">소셜 로그인</th>
                    <th scope="cols">가입일</th>
                    <th scope="cols" style="color: #fd3c56;">삭제</th>          
                </tr>
            </thead>
            <tbody id="ajaxTable">
               <!--  <tr>     
                    <td>1</td>
                    <td>홍길동</td>
                    <td>abcd1234</td>
                    <td>sby4006@gmail.com</td>
                    <td>RmYrsHJswnQrcwcsaf</td>
                    <td>01011111111</td>
                    <td>부산광역시 승학로</td>
                    <td>1</td>
                    <td>일반</td>
                    <td>2023.01.01</td>
                    <td class="delete"><a onclick="location.href('login.html')" style="cursor: pointer;">삭제</a></td>
                </tr> -->
                </tbody>
        </table>
        </div>
    </div>
  </body>
</html>
