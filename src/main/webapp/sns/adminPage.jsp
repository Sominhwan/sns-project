<%@page import="java.io.PrintWriter"%>
<%@page contentType="text/html; charset=UTF-8"%>
<%
	PrintWriter script = response.getWriter();

	if(session.getAttribute("adminId")!=null){
		String adminId = (String)session.getAttribute("adminId");
		if(adminId.equals("admin")){
			script.println("<script>");
			script.println("alert('관리자 페이지 진입.');");
			script.println("</script>");	
		} else {
			session.invalidate();
			script.println("<script>");
			script.println("history.back();");
			script.println("</script>");
			script.close();		
		}
	} else {
		session.invalidate();
		script.println("<script>");
		script.println("history.back();");
		script.println("</script>");
		script.close();
	}
	session.invalidate();
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
    			var j = 0;
    			
    			for(var i = 0; i<result.length; i++){
    				var row = table.insertRow(0);
    				var cell = row.insertCell(0);
    				cell.innerHTML = `<input type="checkbox" id="myCheck"/>`;		
    				for (j = 1; j < result[i].length; j++) {
						var cell = row.insertCell(j);
						cell.innerHTML = result[i][j].value;					
					}			
    				cell.innerHTML = `<button class="checkBtn">삭제</button>`;
    			}
    		}
    	}
    	
    	/* 회원정보 삭제 */
        // 버튼 클릭시 Row 값 가져오기
		$(document).on('click', '.checkBtn', function(){
			var checkBtn = $(this);
			var tr = checkBtn.parent().parent();
			var td = tr.children();
			var userEmail = td.eq(4).text(); // 이메일 선택
			
		    deleteUser(userEmail);
		});
	   	
    	function deleteUser(userEmail) {
    		var request = new XMLHttpRequest();
    		request.open("Post", "UserInfoDelete?userEmail=" +userEmail,true);
    		request.onreadystatechange = deleteProcess;
    		request.send(null);
		};
	 	function deleteProcess(){
    		// 통신 성공시
    		if(request.readyState == 4 && request.status == 200){	
    			searchFunction();
    			alert('삭제 성공!');
    		} 
    	}
	 		 	
	/*   	$(document).on('click', 'tr', function(){ 				
	 			var tr = $(this);
	 			var td = tr.children();
	 			alert(td.eq(3).text());
	 			td.each(function(i){
	 				//tdArr.push(td.eq(i).text());	
	 				td.eq(i).css({"background-color":"#FBFBFB","color":"#000"});
	 			});
	 			
	 	});	 
 */ 
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
            <input class="search" name="search" id="userName" onkeyup="searchFunction()" type="text" placeholder="성명을 입력하세요" maxlength="30"/>
            <button type="button" class="searchBtn" onclick="searchFunction();"></button>
        </div>
        <!-- 회원정보 테이블 -->
        <div class="userTable-scroll">
        <div class="userTable-content">
        <table class="userTable">
            <thead id="head">
                <tr> 
                    <th scope="cols">선택</th>
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
            </tbody>
        </table>
        </div>
        </div>
        <img src="adminImages/delete.svg" alt="deleteBtn" id="deleteBtn">
    </div>
  </body>
</html>
