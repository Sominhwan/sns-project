<%@page import="java.io.PrintWriter"%>
<%@page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="shortcut icon" type="image/x-icon" href="images/loginLogo.png" />
    <link rel="stylesheet" href="css/adminMailPage.css" />
    <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
    <title>관리자페이지 - Photalk</title>
    <script type="text/javascript" src="../smarteditor/js/HuskyEZCreator.js" charset="utf-8"></script>
    <script type="text/javascript">
   		var emailArr = new Array(); // input 에 입력된 이메일을 담는 배열
   		var allEmailArr = new Array(); // input 에 입력된 이메일을 담는 배열
   		var tdArr = new Array(); // 주소록 이메일 담는 배열
    	let oEditors = []

   		smartEditor = function() {
      		console.log("Naver SmartEditor")
      		nhn.husky.EZCreator.createInIFrame({
       			oAppRef: oEditors,
        		elPlaceHolder: "editorTxt",
        		sSkinURI: "../smarteditor/SmartEditor2Skin.html",
        		htParams : { 
            		// 툴바 사용 여부 (true:사용/ false:사용하지 않음) 
            			bUseToolbar : true, 
            			// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음) 
            			bUseVerticalResizer : false, 
            			// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음) 
            			bUseModeChanger : true
            	},
        		fCreator: "createSEditor2"     		
      		})
    	}
	
    	$(document).ready(function() {
      		smartEditor()
    	})
    	
    	submitPost = function() {
  			oEditors.getById["editorTxt"].exec("UPDATE_CONTENTS_FIELD", [])
 			let content = document.getElementById("editorTxt").value

  			if(content == "") {
    			alert("내용을 입력해주세요.")
    			oEditors.getById["editorTxt"].exec("FOCUS")
    			return
  			} else {
   				console.log(content);
   				alert(content);
  			}
		}
    	
    	/* 주소록 보이기 감추기 기능 */
    	function offDisplay(){
    		// 주소록 화면 끌시 모든 체크박스 해제
    		document.getElementById("addrCheckBox").checked = false; 
    		changeAllColor();
    		if(document.getElementById("addressList").style.display =="none"){
    			document.getElementById("addressList").style.display = "block";
    		} else{
    			document.getElementById("addressList").style.display = "none";
    		}
    	}
    	
    	/* 주소록 검색 */
    	function searchFunction(){	  		
    		$.ajax({
                url : "UserEmailSearch?userEmail="+document.getElementById("userEmail").value,
                type : "post",
                dataType : "json",
                success : function(obj){
                	var result = obj.result; 
                	searchProcess(result);
                },
                error : function(xhr, status, error){
    				alert("통신 실패");
                }
            });
    	}
    	
    	function searchProcess(result){
    		var table = document.getElementById("ajaxTable");
    		table.innerHTML = "";
    	   	$.each(result , function(i){
    	   		table.innerHTML += '<tr><td class="chk"><input type="checkbox" name= "myCheck" id="myCheck" class="myCheck" onclick="changeColor();"/></td>' 
    	   		+ '<td class="addr">' + result[i].userEmail + '</td></tr>';
    	    });		
    	}
    	
    	/* 체크박스 체크시 색상 변경 */
		function changeColor(){
			 $("input[name=myCheck]").each(function(i){
				 var tr = $("input[name=myCheck]").parent().parent().eq(i);
					var td = tr.children();
				    if( $(this).is(":checked") == true ){
				    	td.eq(0).css({"background-color":"#F5F5F5","color":"#000"});
						td.eq(1).css({"background-color":"#F5F5F5","color":"#000"});
				    }else{
				    	td.eq(0).css({"background-color":"#fff","color":"#000"});
						td.eq(1).css({"background-color":"#fff","color":"#000"});
				    }
		    });
    	};
    	
    	/* 모든 체크박스 색상 변경 */
    	function changeAllColor(){
    		if($("#addrCheckBox").is(":checked")) {
    			$("input[name=myCheck]").prop("checked", true);
    			changeColor();
    		}
    		else {
    			$("input[name=myCheck]").prop("checked", false);
    			changeColor();
    		}
    	}
    	
    	/* 주소록 정보 가져오기 */
	 	$(function(){
			$("#addrInputBtn").click(function(){
				var checkbox = $("input[name=myCheck]:checked");
				// 체크된 체크박스 값을 가져온다
				checkbox.each(function(i) {
					var tr = checkbox.parent().parent().eq(i);
					var td = tr.children();
					var postId = td.eq(1).text();
					var postIdAll = "";
					
					tdArr.push(postId);	
				});
				if(tdArr==''){
					alert("선택한 정보가 없습니다.");
				} else{
					// TODO 선택한 이메일 정보 받는 사람에게 넣기
					if(tdArr.length<11){
						// 중복된 값 제거
						allEmailArr.push(tdArr);
						var set = new Set(tdArr);
						//set.add();
						allEmailArr = Array.from(set);
						console.log(set);
						var emailInput = document.getElementById("emailWrap");
						emailInput.innerHTML = '';
						for(let i=0;i<allEmailArr.length;i++){	
							//emailInput.innerHTML += '<span id="sendEmail">'+tdArr[i]+ '<button class="emailCancel" id="emailCancel'+ emailInput.childElementCount +'" onclick="deleteEmail('+emailInput.childElementCount+')"></button></span>';	
							emailInput.innerHTML += '<span id="sendEmail">'+allEmailArr[i]+ '<button class="emailCancel" id="emailCancel'+ emailInput.childElementCount +'" onclick="deleteEmail('+emailInput.childElementCount+')"></button></span>';	
						}
						//$('#userAllEmail').val(tdArr); // input에 보낼 이메일 넣기
						offDisplay();
					} else {
						alert("최대 10명한테만 전송이 가능합니다.");
						document.getElementById("addrCheckBox").checked = false; 
			    		changeAllColor();
					} // else2
				} // else1	
		    });
		});
    	
    	/* 받는사람 이메일 입력 기능 */
	 	function inputEmail(){
	 		var emailInput = document.getElementById("emailWrap");
	 		emailInput.innerHTML = '';
	 		allEmailArr.push($('#emailInput').val());
	 		var set = new Set(allEmailArr);
	 		allEmailArr = Array.from(set);
	 		for(let i=0;i<allEmailArr.length;i++){	
				//emailInput.innerHTML += '<span id="sendEmail">'+tdArr[i]+ '<button class="emailCancel" id="emailCancel'+ emailInput.childElementCount +'" onclick="deleteEmail('+emailInput.childElementCount+')"></button></span>';	
				emailInput.innerHTML += '<span id="sendEmail">'+allEmailArr[i]+ '<button class="emailCancel" id="emailCancel'+ emailInput.childElementCount +'" onclick="deleteEmail('+emailInput.childElementCount+')"></button></span>';	
			}
	 		//emailInput.innerHTML += '<span id="sendEmail">'+$('#emailInput').val()+ '<button class="emailCancel" id="emailCancel'+ emailInput.childElementCount +'" onclick="deleteEmail('+emailInput.childElementCount+')"></button></span>';			
	 		//emailArr.push($('#emailInput').val());
	 		console.log(emailArr);
	 		$('#emailInput').val(''); // 이메일 입력란 엔터후 input 값 초기화
	 		
	 	}
    	/* 선택된 이메일 삭제 */
	 	function deleteEmail(num){
	 		//var emailInput = document.getElementById("emailWrap");
	 		//$("#emailCancel").parent("#sendEmail") = '';
	 		
	 		$("#emailCancel"+num).parent("#sendEmail").remove();
	 		//$('#userAllEmail').val.splice(num);
	 		
	 		
	 		//emailArr = $('#userAllEmail').value;
	 		console.log(emailArr);
	 		//alert($('#userAllEmail').value);
	 		//emailInput.innerHTML = '';
	 		//$('#userAllEmail').val('');
	 	}
    	
    	/* 메일 보내기 */
    	function sendEmail(){
    		/* TODO 아무것도 입력하지 않을시 예외처리 작성하기 */
    		$("#mailFrm").attr("action","UserAdEmailSend").submit();
    		
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
          <a href="adminPage.jsp" class="icon"
            ><img src="adminImages/adminProfile.svg" alt="userImg" /><span
              class="sideText"
              >회원</span
            >
            관리</a
          >
        </li>
        <li>
          <a href="adminPost.jsp"
            ><img
              src="adminImages/adminPost.svg"
              alt="postImg"
              class="icon"
            /><span class="sideText">게시물 관리</span></a
          >
        </li>
        <li>
          <a href="adminMail.jsp"
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
          /><span class="sideText"><a href="#" id="logout" onclick="logout()"
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
    <!-- 메일 네비게이션 바 -->
    <nav id="navbar">
        <span id = "adminMailLogo">
        <img src="adminImages/adminMailLogo.svg" />
        </span>
        <span id="adminMailLogo-text">메일 보내기</span>    
    </nav>
    <!-- 메일 보내기, SMS 보내기 컨텐츠 -->
    <div class="mailTable">
        <span id="mailSend">
            메일 보내기
        </span>
        <span id="receiver">받는사람</span>
        <span id="title">제목</span>
        <button id="addressBtn" onclick="offDisplay()">주소록</button>
        <div id="addressList" style="display: none">
			<table class="addressTable">
            	<thead id="head">
               		<tr> 
                    	<th scope="cols" id="select"><input type="checkbox" id="addrCheckBox" name="addrCheckBox" onclick="changeAllColor()"/></th>
                    	<th scope="cols" id="address">주소<label id="cancel" onclick="offDisplay()">x</label></th>       
               		</tr>
           		</thead>
           	 	<tbody id="ajaxTable">
        		</tbody>
        	</table>
        	<div id="bottom-select">
        		<div id="searchBox">
            		<input class="search" name="search" id="userEmail" onkeyup="searchFunction()" 
            		type="text" placeholder="이메일을 입력하세요" maxlength="30" autocomplete="off"/>
            		<button type="button" class="searchBtn" onclick="searchFunction();"></button>
        		</div>
        		<input type="button" id="addrInputBtn" value="확인"/>
        	</div>  
            
        </div>
        <span id="attached-file">파일첨부</span>
        <label id="myPC">내 PC</label>
        <div id="emailWrap"><!-- <div id="sendEmail">thalsghks@naver.com<button id="emailCancel"></button></div> --></div>
        <form action="" method="POST" name="mailFrm" id="mailFrm">	
        	<input id="emailInput" name="emailInput" type="text" maxlength="30" autocomplete="false"
        	onkeypress="if(window.event.keyCode==13){inputEmail()}"/>
        	<!-- <div id="sendEmail">thalsghks@naver.com<button id="emailCancel"></button></div> -->
        	<input id="titleInput" name="titleInput" type="text" maxlength="40" autocomplete="false"/>
        	<input id="attached-file-Input" name="attached-file-Input" readonly/>
        	<!-- 스마트 에디터 -->
        	<div id="smarteditor">
            <textarea name="editorTxt" id="editorTxt" 
                  rows="20" cols="10" 
                  placeholder="내용을 입력해주세요"></textarea>   
            </div>
            <input type="button" id="mailSendBtn" value="보내기" onclick="sendEmail()"/>
            <input type="hidden" id="userAllEmail" value="" name="userAllEmail"/>
        </form>
        
           
         <!-- <span id="smsSend">
            SMS 보내기
        </span> -->
    </div>
    
 
  </body>
</html>
