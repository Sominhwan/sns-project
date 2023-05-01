<%@page import="sns.SMSBean"%>
<%@page import="sns.UserinfoBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="sns.AdminMgr"%>
<%@page import="java.io.PrintWriter"%>
<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="sns.SMS" %>
<%
	AdminMgr mgr = new AdminMgr();
	ArrayList<UserinfoBean> userPNList = mgr.getUserPN();	
	ArrayList<SMSBean> smsList = mgr.getSMS();
%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="shortcut icon" type="image/x-icon" href="images/loginLogo.png" />
    <link rel="stylesheet" href="css/adminMailPage.css" />
    <link rel="stylesheet" href="css/adminSmsPage.css" />
    <link rel="stylesheet" href="css/loading.css" />
    <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
    <title>관리자페이지 - Photalk</title>
    <script type="text/javascript" src="../smarteditor/js/HuskyEZCreator.js" charset="utf-8"></script>
    <script type="text/javascript">
    $(document).ready(function () {
        $("#input_file").bind("change", function () {
          selectFile(this.files);
          //this.files[0].size gets the size of your file.
          //alert(this.files[0].size);
        });
      });
      // 파일 리스트 번호
      var fileIndex = 0;
      // 등록할 전체 파일 사이즈
      var totalFileSize = 0;
      // 파일 리스트
      var fileList = new Array();
      // 파일 사이즈 리스트
      var fileSizeList = new Array();
      // 등록 가능한 파일 사이즈 MB
      var uploadSize = 50;
      // 등록 가능한 총 파일 사이즈 MB
      var maxUploadSize = 500;
      $(function () {
        // 파일 드롭 다운
        fileDropDown();
      });
      // 파일 드롭 다운
      function fileDropDown() {
        var dropZone = $("#dropZone");
        //Drag기능
        dropZone.on("dragenter", function (e) {
          e.stopPropagation();
          e.preventDefault();
          // 드롭다운 영역 css
          dropZone.css("border", "solid 1px #0073e6");
        });
        dropZone.on("dragleave", function (e) {
          e.stopPropagation();
          e.preventDefault();
          // 드롭다운 영역 css
          dropZone.css("border", "solid 1px #e3e3e3");
        });
        dropZone.on("dragover", function (e) {
          e.stopPropagation();
          e.preventDefault();
          // 드롭다운 영역 css
          dropZone.css("border", "solid 1px #0073e6");
        });
        dropZone.on("drop", function (e) {
          e.preventDefault();
          // 드롭다운 영역 css
          dropZone.css("border", "solid 1px #e3e3e3");
          var files = e.originalEvent.dataTransfer.files;
          if (files != null) {
            if (files.length < 1) {
              /* alert("폴더 업로드 불가"); */
              console.log("폴더 업로드 불가");
              return;
            } else {
              selectFile(files);
            }
          } else {
            alert("ERROR");
          }
        });
      }
      // 파일 선택시
      function selectFile(fileObject) {
        var files = null;
        if (fileObject != null) {
          // 파일 Drag 이용하여 등록시
          files = fileObject;
        } else {
          // 직접 파일 등록시
          files = $("#multipaartFileList_" + fileIndex)[0].files;
        }
        // 다중파일 등록
        if (files != null) {
          if (files != null && files.length > 0) {
            $("#fileDragDesc").hide();
            $("fileListTable").show();
          } else {
            $("#fileDragDesc").show();
            $("fileListTable").hide();
          }
          for (var i = 0; i < files.length; i++) {
            // 파일 이름
            var fileName = files[i].name;
            var fileNameArr = fileName.split("\.");
            // 확장자
            var ext = fileNameArr[fileNameArr.length - 1];
            var fileSize = files[i].size; // 파일 사이즈(단위 :byte)
            console.log("fileSize=" + fileSize);
            if (fileSize <= 0) {
              console.log("0kb file return");
              return;
            }
            var fileSizeKb = fileSize / 1024; // 파일 사이즈(단위 :kb)
            var fileSizeMb = fileSizeKb / 1024; // 파일 사이즈(단위 :Mb)
            var fileSizeStr = "";
            if (1024 * 1024 <= fileSize) {
              // 파일 용량이 1메가 이상인 경우
              console.log("fileSizeMb=" + fileSizeMb.toFixed(2));
              fileSizeStr = fileSizeMb.toFixed(2) + " Mb";
            } else if (1024 <= fileSize) {
              console.log("fileSizeKb=" + parseInt(fileSizeKb));
              fileSizeStr = parseInt(fileSizeKb) + " kb";
            } else {
              console.log("fileSize=" + parseInt(fileSize));
              fileSizeStr = parseInt(fileSize) + " byte";
            }
            /* if ($.inArray(ext, [ 'exe', 'bat', 'sh', 'java', 'jsp', 'html', 'js', 'css', 'xml' ]) >= 0) {
                            // 확장자 체크
                            alert("등록 불가 확장자");
                            break; */
            if (
              $.inArray(ext, [
                "hwp",
                "doc",
                "docx",
                "xls",
                "xlsx",
                "ppt",
                "pptx",
                "txt",
                "png",
                "pdf",
                "jpg",
                "jpeg",
                "gif",
                "zip",
                "svg",
              ]) <= 0
            ) {
              // 확장자 체크
              /* alert("등록이 불가능한 파일 입니다.");
                            break; */
              alert("등록이 불가능한 파일 입니다.(" + fileName + ")");
            } else if (fileSizeMb > uploadSize) {
              // 파일 사이즈 체크
              alert("용량 초과\n업로드 가능 용량 : " + uploadSize + " MB");
              break;
            } else {
              // 전체 파일 사이즈
              totalFileSize += fileSizeMb;
              // 파일 배열에 넣기
              fileList[fileIndex] = files[i];
              // 파일 사이즈 배열에 넣기
              fileSizeList[fileIndex] = fileSizeMb;
              // 업로드 파일 목록 생성
              addFileList(fileIndex, fileName, fileSizeStr);
              // 파일 번호 증가
              fileIndex++;
            }
          }
        } else {
          alert("ERROR");
        }
      }
      // 업로드 파일 목록 생성
      function addFileList(fIndex, fileName, fileSizeStr) {
        /* if (fileSize.match("^0")) {
                    alert("start 0");
                } */
        var html = "";
        html += "<tr id='fileTr_" + fIndex + "'>";
        html += "    <td id='dropZone' class='left' style='padding-left: 10px; margin-top: -10px; font-size: 13px; height='20px''>";
        html +=         "<button class='fileCancel' onclick='deleteFile(" +
        fIndex +
        "); return false;' style='padding-top: 10px; width: 5px;'></button>"+
          fileName +
          " (" +
          fileSizeStr +
          ") " ;
        html += "    </td>";
        html += "</tr>";
        $("#fileTableTbody").append(html);
      }
      // 업로드 파일 삭제
      function deleteFile(fIndex) {
        console.log("deleteFile.fIndex=" + fIndex);
        // 전체 파일 사이즈 수정
        totalFileSize -= fileSizeList[fIndex];
        // 파일 배열에서 삭제
        delete fileList[fIndex];
        // 파일 사이즈 배열 삭제
        delete fileSizeList[fIndex];
        // 업로드 파일 테이블 목록에서 삭제
        $("#fileTr_" + fIndex).remove();
        console.log("totalFileSize=" + totalFileSize);
        if (totalFileSize > 0) {
          $("#fileDragDesc").hide();
          $("fileListTable").show();
        } else {
          $("#fileDragDesc").show();
          $("fileListTable").hide();
        }
      }
      // 파일 등록
      function uploadFile() {
        var uploadFileList = Object.keys(fileList);
        var emailTitle = $('#titleInput').val();
        $('#userAllEmail').val(allEmailArr);
  	  oEditors.getById["editorTxt"].exec("UPDATE_CONTENTS_FIELD", []);
  	  let content = document.getElementById("editorTxt").value;   
  	  $('#mailContent').val(content);
        // 받는 이메일 주소가 존재하는지 체크
        if (allEmailArr.length == 0){
            alert("이메일 주소를 입력하세요.");
            return;
        }
        // 이메일 제목이 존재하는지 체크
        if (emailTitle==null || emailTitle==''){
            alert("제목을 입력하세요.");
            return;
        }      
        // 용량을 500MB를 넘을 경우 업로드 불가
        if (totalFileSize > maxUploadSize) {
          // 파일 사이즈 초과 경고창
          alert("총 용량 초과\n총 업로드 가능 용량 : " + maxUploadSize + " MB");
          return;
        }
  	  // 메일 내용이 존재하는지 체크
  	  if(content == "" || content==null || content=='&nbsp;' || content=='<p>&nbsp;</p>') {
  		  alert("내용을 입력해주세요.");
  	      oEditors.getById["editorTxt"].exec("FOCUS")
  		  return;
  	  } 
  		
        if (confirm("메일을 전송 하시겠습니까?")) {
          // 등록할 파일 리스트를 formData로 데이터 입력
          //var form = $("#uploadForm");
          var formData = new FormData($("#uploadForm")[0]);
          for (var i = 0; i < uploadFileList.length; i++) {
            formData.append("files", fileList[uploadFileList[i]]);    
          }
          // 전송 후 입력폼 초기화
          $('#titleInput').val('');
          $('#emailInput').val('');
          allEmailArr = [];
  		var emailWrap = document.getElementById("emailWrap");
  		emailWrap.innerHTML = '';
          oEditors.getById["editorTxt"].exec("SET_IR", [""]);
  		document.getElementById("fileTableTbody").innerHTML = "";
          fileList = [];
          fileSizeList = [];
          
          $.ajax({
              url : "UserAdEmailSend",
              data : formData,
              type:'POST',
              enctype:'multipart/form-data',
              processData:false,
              contentType:false,
              dataType:'json',
              cache:false,
              success:function(obj){
                  var result = obj.result;
              	alert(result);
              },error:function(){
                  alert("메일 전송 실패");
              }
          });
        }
      }
      
	  /* 로그아웃 */
	  function logout(){
		  if (confirm("로그아웃 하시겟습니까?") == true){ 
			  location.replace('login.jsp');
		  } else{
			  return ;
		  } 		
	 }      
    </script>
  </head>
  <!-- 로딩바 -->
    <div id="loading" style="display: none">
      <div id="loading_bar">
        <!-- 로딩바의 경로를 img 태그안에 지정해준다. -->
        <img src="adminImages/Spin-loading.gif" style="width: 100px;"/>
      </div>
    </div>
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
        <img src="adminImages/adminMailLogo.svg" id="navLogo"/>
        </span>
        <span id="adminMailLogo-text">메일 보내기</span>          
    <!--     <span id="adminSMSLogo-text">SMS 보내기</span>   -->  
        <img src="adminImages/smsBtn.svg" id="smsBtn" onclick="changePage()"/>
        <img src="adminImages/mailBtn.svg" id="mailBtn" onclick="changePage()"/>
    </nav>
    <!-- 메일 보내기 컨텐츠 -->
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
        <div id="emailWrap"></div>
    	<div class="upload-btn-wrapper">
      	<input type="file" id="input_file" multiple="multiple" style="height: 100%; cursor: pointer;"/>
      	<button class="upload-btn" style="cursor: pointer;">내 PC</button>
    	</div>

        <form name="uploadForm" id="uploadForm" enctype="multipart/form-data" method="post">
      		<input id="emailInput" name="emailInput" type="text" onkeyup="if(window.event.keyCode==13){inputEmail2()}" maxlength="30" autocomplete="false"/>
        	<input id="titleInput" name="titleInput" type="text" maxlength="40" autocomplete="false"/>
        	<!-- 스마트 에디터 -->
        	<div id="smarteditor">
            <textarea name="editorTxt" id="editorTxt" 
                  rows="20" cols="10" 
                  placeholder="내용을 입력해주세요"></textarea>   
            </div>	   		
      		<div id="dropZone" style="position:absolute; left: 120px; top:245px; width: 354px; height: 50px; 
      			border: solid 1px #e3e3e3; border-radius: 5px; overflow-y: auto">
        	<div id="fileDragDesc"><img src="adminImages/file.svg" id="fileIcon" alt="file" style="width: 11px; margin-right: -17px; margin-top: 5px;"/>
        		파일을 드래그 해주세요.</div>
        	<table id="fileListTable" style="width=100%; height=100%; border=0px; font-size: 12px;">
          		<tbody id="fileTableTbody"></tbody>
        	</table>
      		</div>
      		<input type="hidden" id="mailContent" name="mailContent"/>
      		<input type="hidden" id="userAllEmail" value="" name="userAllEmail"/>
    	</form>
    	<div class="sendMail-Content">
    	<input type="button" onclick="uploadFile();" id="mailSendBtn" value="보내기"/>
    	</div> 
    </div>
    
    <!-- SMS 보내기 컨텐츠 -->
    <div class="smsTable">
     	<span id="smsSend">
            SMS 보내기
        </span> 
        	<img alt="iphone" src="adminImages/iphone.png" id="iphone">
        	<form method="post" name="smsForm">
        	<table class="table" style="border: 1px solid #eeeee">
        		<thead>
        			<tr>
        				<th style="text-align: left; color: #fff; padding-left: 7px;">문자 전송 양식</th>
        			</tr>
        		</thead>
        		<tbody>
        			<tr>
        				<td style="text-align: center;">   
    						<p class="textCount">0</p>
    						<p class="textTotal">/45자</p>			
        					<textarea class="form-control" id="msg" maxlength="45" name="msg" placeholder="보낼 내용"></textarea>
        				</td>
        			</tr>
        			<tr>
        				<td style="padding-left: 7px; color: #fff; font-size: 14px;">
        					<span>보내는 번호</span>
        					<input class="receiveInput" type="text" readonly value="010-1111-1111" style="padding-left: 3px;"/>
        				</td>
        			</tr>           			
        			<tr>
        				<td style="padding-left: 7px; color: #fff; font-size: 14px">
        					<div>받는 번호 <span style="font-size: 11px; color: #E5F6FF"> * 010-0000-0000과 같이 입력해주세요.</span></div>
        					<input class="form-control" type="text" name="rphone" value="">
							<button id="openBtn" type="button" onclick="userPhoneList()" style="cursor: pointer;">회원 휴대폰번호</button>
            					
        				</td>
        			</tr>        
        			<tr id="count">
        			</tr>         				
        			<tr>
        				<td style="text-align: left; padding-left: 7px;">
        					<input type="hidden" name="action"  value="go">
        					<input type="hidden" name="sphone1" value="010">
        					<input type="hidden" name="sphone2" value="4662">
        					<input type="hidden" name="sphone3" value="7527">
        					<input class="sendBtn" type="button" value="전송하기" onclick="sendSms()">
        				</td>
        			</tr>         			     			 			
        		</tbody>
        	</table>
    		</form>
         	<div id="userPhone-content" style="display: none">
				<table class="userPhoneTable" style="text-align: center;">
           			<tbody id="ajaxTable2">
           				<% for(int i=0;i<userPNList.size();i++){ %>
            				<tr>
           						<td><%=userPNList.get(i).getUserPN()%></td>
           	 				</tr>							   	          				
           				<% } %>          	 			           	 			       	 			           	 			
        			</tbody>
       			</table>
       		</div>   
       		<!-- sms 메시지 보관함 -->
       		<div class="sms-log-table">
       			<span class="smsSendLog">SMS 전송 내역</span>		
       			<button id="excelBtn" type="button" onclick="" style="cursor: pointer;">엑셀 다운로드</button>
				<table class="smsLogTable" id="smsLogTable">
            		<thead id="smsHead">
               			<tr> 
                    		<th scope="cols" id="phone">전화번호</th>       
                    		<th scope="cols" id="content">내용</th>       
                    		<th scope="cols" id="date">보낸시간</th>       
               			</tr>
           			</thead>
           	 		<tbody id="ajaxTable3">
           	 		<% for(int i=0;i<smsList.size();i++) { %>
            			<tr>
           					<td scope="row" id="phone-row"><%=smsList.get(i).getUserPN()%></td>
           					<td scope="row" id="content-row"><%=smsList.get(i).getContent()%></td>
           					<td scope="row" id="date-row"><%=smsList.get(i).getUserRegTime()%></td>      					
           	 			</tr>	
           	 		<% } %>               	 			       	 		
        			</tbody>
        		</table>  
        		<div class="smsCount" id="smsCount">
        		</div>     		
       		</div> 		  		      		
    	</div>             
  </body>
  <APM_DO_NOT_TOUCH>
  <script src="js/adminMail.js"></script>
  <script src="js/adminSms.js"></script>
  <script type="text/javascript" src="/TSPD/0853a021f8ab20004ce16954474b4eb6ec765da1c130ccc822f9ab76985e173c293e33c8ec870e68?type=9"></script>
  <!-- Sheet JS -->
  <script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.14.3/xlsx.full.min.js"></script>
  <!--FileSaver savaAs 이용 -->
  <script src="https://cdnjs.cloudflare.com/ajax/libs/FileSaver.js/1.3.8/FileSaver.min.js"></script>
  <script src="js/loading.js"></script>
</html>
