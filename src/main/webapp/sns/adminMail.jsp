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
    var fileList = []; //파일 정보를 담아 둘 배열
    $(function(){

        //드래그앤드랍
        $("#fileDrop").on("dragenter", function(e){
            e.preventDefault();
            e.stopPropagation();
        }).on("dragover", function(e){
            e.preventDefault();
            e.stopPropagation();
            $(this).css("border", "solid 1px #0073e6");
        }).on("dragleave", function(e){
            e.preventDefault();
            e.stopPropagation();
            $(this).css("border", "solid 1px #e3e3e3");
        }).on("drop", function(e){
            e.preventDefault();

            var files = e.originalEvent.dataTransfer.files;
            if(files != null && files != undefined){
                var tag = "";
                for(i=0; i<files.length; i++){
                    var f = files[i];
                    fileList.push(f);
                    var fileName = f.name;
                    var fileSize = f.size / 1024 / 1024;
                    fileSize = fileSize < 1 ? fileSize.toFixed(3) : fileSize.toFixed(1);
                    tag += 
                            "<div class='fileList'>" +
                                "<span class='fileName'>"+fileName+"</span>" +
                                "<span class='fileSize'>"+fileSize+" MB</span>" +
                                "<span class='clear'></span>" +
                            "</div>";
                }
                $(this).append(tag);
            }

            $(this).css("border", "solid 1px #e3e3e3");
        });

        //저장
/*         $(document).on("click", "#mailSendBtn", function(){
            var formData = new FormData($("#mailFrm")[0]);
            if(fileList.length > 0){
                fileList.forEach(function(f){
                    formData.append("fileList", f);
                });
            }         

            $.ajax({
                url : "UserAdEmailSend",
                data : formData,
                type:'POST',
                enctype:'multipart/form-data',
                processData:false,
                contentType:false,
                dataType:'json',
                cache:false,
                success:function(res){
                    alert("저장에 성공하셨습니다.");
                },error:function(res){
                    alert("오류 발생.\n관리자에게 문의해주세요.");
                }
            });
        }); */
    });
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
        <label id="myPC" onclick="onClickUpload();">내 PC</label>
        <div id="emailWrap"></div>
        <form action="" method="POST" name="mailFrm" id="mailFrm" enctype="multipart/form-data>	<!--  enctype="multipart/form-data" -->
        	<input id="emailInput" name="emailInput" type="text" maxlength="30" autocomplete="false"
        	onkeypress="if(window.event.keyCode==13){inputEmail()}"/>
        	<input id="titleInput" name="titleInput" type="text" maxlength="40" autocomplete="false"/>
        	<div id="fileDrop" class="fileDrop"></div>
        	<input type="file" id="attached-file-Input" name="attached-file-Input" onchange="fileUpload()" multiple/>
        	<!-- 스마트 에디터 -->
        	<div id="smarteditor">
            <textarea name="editorTxt" id="editorTxt" 
                  rows="20" cols="10" 
                  placeholder="내용을 입력해주세요"></textarea>   
            </div>
            <input type="button" id="mailSendBtn" value="보내기" onclick="sendEmail()"/> 
           <!--  <input type="button" id="mailSendBtn" value="보내기"/> -->
            <input type="hidden" id="userAllEmail" value="" name="userAllEmail"/>
            <input type="hidden" id="fileName" value="" name="fileName"/>     
        </form>
        
           
         <!-- <span id="smsSend">
            SMS 보내기
        </span> -->
    </div>
    
 
  </body>
  <script src="js/adminMail.js"></script>
</html>
