<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="java.util.Vector,sns.*"%>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="umgr" class="sns.UserinfoMgr"/>
<jsp:useBean id="cmgr" class="sns.CommentMgr"/>
<jsp:useBean id="fmgr" class="sns.FriemdmanagerMgr"/>
<jsp:useBean id="pmgr" class="sns.PostlikeMgr"/>
<!-- 닉네임으로 검색하거나 aaa박스에서 유저사진을 클릭햇을경우 그사람의 게시글보기 -->
<%
	
	String searchWord = null;
	if(request.getParameter("searchWord")!=null){
		searchWord = (String) request.getParameter("searchWord");
		System.out.println("searchword from parameter is :" + searchWord);
	}
	if(session.getAttribute("searchWord")!=null){
		searchWord = (String) session.getAttribute("searchWord");
		System.out.println("searchword from session is :" + searchWord);
	}
	if (searchWord == null) {
		  String userEmail = request.getParameter("userEmail");
		  UserinfoBean abean=umgr.getPMember(userEmail);
		  searchWord = abean.getUserNickName();
	}
	UserinfoBean mbean = umgr.getsearchPMember(searchWord);
	Vector<UserinfoBean> uilist = umgr.listsearchPMember(searchWord);
	Vector<PostBean> uplist=fmgr.friendlist(mbean.getUserEmail());
	System.out.println(searchWord);
		
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pho talk</title>
    <link rel="shortcut icon" type="image/x-icon" href="./images/mainLogo.png" />
    <link href="profile.css" rel="stylesheet" type="text/css"/>
    <link type="text/css" rel="stylesheet" href="style.css"></link>
    <script src="https://code.jquery.com/jquery-3.4.1.js"></script>
 	<script src="https://cdn.jsdelivr.net/npm/cropperjs@1.5.12/dist/cropper.min.js"></script>
 	<script type="text/JavaScript" src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>
</head>
<body>

<form method="post" name="frm1" action="Main.jsp">
	<input type="hidden" name="gid">
</form>
    <nav>
    <div class = "navbar">
        <a href="javascript:goURL('Main.jsp','')"><img src="./images/mainLogo.png"  alt="Image Button"/></a>
	    <a id = "PhoTalk" class = "navbar-brand" href="Main.jsp">PhoTalk</a>
	    <form method="post" action="searched.jsp">
        	<span><input type="text" class = "InputBase" placeholder="검색" name="searchWord"></span>
        </form>
        <!-- 모달창 -->
        
        <img id = "mainMessageFalse" src="./images/mainMessageFalse.png" alt="Image Button"/>
        <img id = "mainAlarmFalse" src="./images/mainAlarmFalse.png" alt="Image Button"/>
    	<img id = "mainProfile2" src="./images/mainProfile2.png" alt="Image Button"/>
    </div>
</nav>
    <ul>
        <li>
            <a href="#">
                <img class = "homeTrue" src="./images/mainHomeTrue.png"  alt="Image Button" width="25" >
                <span class = "sidebar">홈</span>
            </a>
        </li>
        <li><a href="follow.jsp"><img src="./images/mainFollowFalse.png" alt="Image Button" width="25"><span class = "sidebar">팔로우</span></a></li>
        <li><a href="quest.jsp"><img src="./images/mainExploreFalse.png" alt="Image Button" width="25" ><span class = "sidebar">탐색</span></a></li>
        <li><a href="#" id="make-post"><img src="./images/mainMakePostFalse.png" alt="Image Button" width="25" class="makeimage"><span class="sidebar">만들기</span></a></li>
        <li><a href="#"><img src="./images/mainProfile2.png" alt="Image Button" width="25" ><span class = "sidebar">프로필</span></a></li>
        <%
        	for(int i=0; i<23; i++){
        		%>
        		<br>
        		<%
        	}
        %>
        <dt>
        	&nbsp;
        	<a href="#소개"><span class="leftintroduce">소개</span></a>
        	<a href="#채용"><span class="leftintroduce">채용안내</span></a>
        	<a href="#이용"><span class="leftintroduce">이용약관</span></a>
        	<a href="#도움"><span class="leftintroduce">도움말</span></a>
        	<a href="#운영"><span class="leftintroduce">운영정책</span></a>
        	<a href="#위치"><span class="leftintroduce">위치</span></a>
        </dt>
        <dt>
        	&nbsp;
        	<span class="leftintroduce">사이트맵 © 2023 Social Net Work Project</span>
        </dt>
        
    </ul>
    <!-- <div style="overflow:scroll; height:1900px;"> -->
<div data-role="page">
    <div class="aaa">
    	<table>
		<tr>
		<%
				for(int i=0;i<uilist.size();i++){
					UserinfoBean ubean = uilist.get(i);//정보에 뜰 사람들
		%>
			<td width="100">
				<div class="box1">
					<a href="javascript:goURL('searched.jsp?userEmail=<%=ubean.getUserEmail()%>','<%=ubean.getUserEmail()%>')"><!-- 여기에 jsp파일 -->
						<img class="profileimage" src="./photo/<%=ubean.getUserImage()%>">
					</a>
				</div>
				<div>
					<h4><%=ubean.getUserNickName()%></h4>
				</div>
			</td>
		<%}%>	
		</tr>
		</table>
    </div>
    <div class="bbb">
    	<h3>회원님을 위한 추천</h3>
    	<hr>
    	<table>
    	<%
				for(int i=0;i<uilist.size();i++){
					UserinfoBean ubean = uilist.get(i);
		%>
		<tr>	
			<td width="50">
				<div class="boxnored">		
						<img class="profileimage" src="./photo/<%=ubean.getUserImage()%>">
				</div>
				
			</td>
			<td>
			<div class="box2">
					<h4 class="Nick-State"><%=ubean.getUserNickName()%></h4>
					<p class="Text-State">회원님을 팔로우합니다 </p>
			</div>
			</td>
			<td>
				<%
					if(fmgr.friendCheck(ubean.getUserEmail(), mbean.getUserEmail())){
						%>
						<a href="javascript:deletefriend('<%=ubean.getUserEmail() %>,<%=mbean.getUserEmail() %>')" class="followdelbtn">팔로워</a><% 
					}
					else {
						%><a href="javascript:dofriend('<%=ubean.getUserEmail() %>,<%=mbean.getUserEmail() %>')" class="follow-btn">팔로우</a><% 
					}
				%>
				
			</td>
		<%}%>	
		</tr>
		</table>
    </div>
    <div class="socialproject">
    	<h5>© 2023 Social Net Work Project</h5>
    </div>
    <%
				for(int i=0;i<uplist.size();i++){
					PostBean pbean = uplist.get(i);
					UserinfoBean uibean = umgr.getPMember(pbean.getUserEmail());
					Vector<CommentBean> clist = cmgr.listPReply(pbean.getPostId());
					int commentCount = clist.size();
					
	%>
    <div class="ccc">
    <table>
		<tr>
			<td width="30">
				<div class="box3">
					<img class="profile" src="./photo/<%=uibean.getUserImage()%>" width="35" height="35">
				</div>
			</td>
			<td width="250"><b><%=uibean.getUserNickName()%></b></td>
			<td><a href="javascript:hamberger('<%=pbean.getUserEmail()%>')" class="ham">
					<img src="./img/postCategory.svg">
						
				</a>
			</td>
			
		</tr>
		<tr>
			<td colspan="3">
			<!-- 이미지가 null이면 영상불러오기 -->
				<%if (pbean.getImageName() == null || pbean.getImageName().equals("NULL")){ %>
					<embed src="photo/<%=pbean.getVideoName()%>" width="515" height="480">
				<%} else {%>
					<img src="photo/<%=pbean.getImageName()%>" width="515" height="480">
				<%} %>
			</td>
		</tr>
		<tr>
			<td colspan="2">
			
			
				<%if (pmgr.postLike(mbean.getUserEmail(), pbean.getPostId())){ %>
					<a href="javascript:heartdel('<%=pbean.getPostId()%>,<%=mbean.getUserEmail() %>')" id="ddd">
					<img src="./img/postLikeTrue.svg" align="top">
					</a>
				<%}else if(!pmgr.postLike(mbean.getUserEmail(), pbean.getPostId())){ %>
					<a href="javascript:heart('<%=pbean.getPostId()%>,<%=mbean.getUserEmail() %>')" id="ddd">				
					<img src="./img/heart.jpg" align="top">
					</a>
				<%} %> 
			<a href="javascript:chat('<%=pbean.getPostId()%>')" id="ddd">
				<img src="./img/postMessageFalse.svg" align="top">
			</a>
			<a href="javascript:share('<%=pbean.getPostId()%>')" id="ddd" class="sharebtn">
				<img src="./img/postShare.svg" align="top">
			</a>
			</td>
			<td align="center"><a href="javascript:del('<%=pbean.getPostId()%>')">DEL</a></td>
		</tr>
		<tr>
			<td width="250"><%=uibean.getUserNickName() %>님 외 <b><%=pbean.getLikeNum() %>명</b>이 좋아합니다.</td>
		</tr>
		<tr class="commenter" stlye="height:<%=commentCount*50%>px;">
			<td colspan="3" width="500"> 
				<%
				for(int j=0;j<clist.size();j++){
					CommentBean cbean = clist.get(j);
					if(cbean.getCommentParrent()!=null){
						
				%>	
				<c><%=cbean.getUserEmail()%></c>&nbsp;<c class="commentDetail"><%=cbean.getCommentDetail()%></c>
				<br>
				<c>&nbsp;&nbsp;&nbsp;&nbsp;<%=cbean.getCommentDate()%>&nbsp;&nbsp; 
				<%if(mbean.getUserEmail().equals(cbean.getUserEmail())){%><!-- 덧글이메일과 로그인 이메일같으면 -->
				<a href="javascript:cup('<%=cbean.getCommentId()%>')" id="box<%=cbean.getCommentId()%>">수정</a><%}%>&nbsp;
				<%if(mbean.getUserEmail().equals(cbean.getUserEmail())){%><!-- 덧글이메일과 로그인 이메일같으면 -->
				<a href="javascript:cdel('<%=cbean.getCommentId()%>,<%=pbean.getPostId()%>')">삭제</a></c><%}%>&nbsp;
				<br>
				<%} else {%>
					<b><%=cbean.getUserEmail()%></b>&nbsp;<c class="commentDetail"><%=cbean.getCommentDetail()%></c>
				<br>
				<b>&nbsp;&nbsp;&nbsp;&nbsp;<%=cbean.getCommentDate()%>&nbsp;&nbsp; 
				<a href="javascript:creply('<%=cbean.getCommentParrent()%>,<%=mbean.getUserEmail()%>,<%=pbean.getPostId()%>,<%=cbean.getCommentId()%>')" id="rep<%=cbean.getCommentId()%>">답글</a> &nbsp;
				<%if(mbean.getUserEmail().equals(cbean.getUserEmail())){%><!-- 덧글이메일과 로그인 이메일같으면 -->
				
				<a href="javascript:cup('<%=cbean.getCommentId()%>')" id="box<%=cbean.getCommentId()%>">수정</a><%}%>&nbsp;
				
				<%if(mbean.getUserEmail().equals(cbean.getUserEmail())){%><!-- 덧글이메일과 로그인 이메일같으면 -->
				<a href="javascript:cdel('<%=cbean.getCommentId()%>,<%=pbean.getPostId()%>')">삭제</a></b><%}%>&nbsp;
				<br>
				<%} %>
			
		<%}%>
			</td>
		</tr>
		
		<tr>
		
			<td colspan="3" width="500">
				<br>
				<div class="asdf">
				
				<img src="./img/postLikeCount.svg">&nbsp;<%=pbean.getLikeNum() %>&nbsp;
				
				<img src="./img/postMessageCount.svg">&nbsp;댓글<%=pbean.getCommentNum() %>&nbsp;개
				<%
				for(int j=0;j<38;j++){
					%>
					&nbsp;
					<% 
				}
				%>
				공유하기 <%=pbean.getShareNum() %> 회
				</div>
				<hr>
			</td>
			
		</tr>
		
		<tr>	
			<td colspan="3" width="500">
				<img src="./img/postMessageProfile.svg" class="postMessageProfile">&nbsp;
				<input class="postTextbox" id="postTextbox" placeholder="댓글을 입력하세요." data-postid="<%=pbean.getPostId()%>" data-userEmail="<%=mbean.getUserEmail() %>"/>
			</td>

		</tr>
		<tr>
			<td colspan="3"></td>
		</tr>
		
	</table>
	
	</div>
	<!-- 햄버거모달 -->
	<div class="modal">
    			<div>
        			<a href="javascript:report('<%=pbean.getPostId()%>')"><span id="main-modal-text">신고하기</span></a><br>
        			<hr>
        			<a href="javascript:share('<%=pbean.getPostId()%>')" class="sharebtn"><span id="main-modal-text">공유하기</span></a><br>
        			<hr>
        			<a href="javascript:copyUrl('<%=pbean.getPostId()%>')"><span id="main-modal-text">링크복사</span></a><br>
        			<hr>
        			<span id="main-modal-text" class="modal_close">취소</span>
    			</div>
	</div>
	<%}%>
	
</div>
<!-- 화면꺼지게 -->

<div class="overlay">
	<!-- 만들기모달 -->
	<div class="makemodal">
		<div class="maketexttitle">
				<b>게시물 만들기</b><img src="./img/makePostCancelBtn.svg" class="makecancel">	
		</div>
		<hr>
		<div class="makebody">
			<img src="./img/makePostImage.svg" class="imageposition">
			<img src="./img/makePostVideo.svg" class="imageposition2"><br>
			<h5 class="makebodytext">사진과 동영상을 선택하세요</h5>
			<img src="./img/makePostSelectImage.svg" class="imageposition3">
			<img src="./img/makePostSelectVideo.svg" class="imageposition4">
		</div> 				
  	</div>
  	<!-- 편집하기모달 -->
  	<form name="postFrm" method="post" action="PostInsertServlet" enctype="multipart/form-data" >
  	<div class="fixmodal">
		<div class="maketexttitle">
		&nbsp;&nbsp;<b>편집하기</b><img src="./img/makePostBackBtn.svg" class="makeBackBtn">
		</div>
		<hr>
		<div class="makebody">
			<b class="makepostBefore">Before</b>
			<b class="makepostAfter">After</b>
			<div class="choicepicture">
				<!-- 크롭될이미지 -->
				<input type="file" accept="image/*" class="imageInput" name="imageName">
			</div>
			<div class="choiceafterpicture">
        			<img id="croppedImage" src="" alt="Cropped Image">
			</div>
			<img src="./img/makePostInsertBtn.svg" class="makepostInsert">
		</div>				
  	</div>
  	</form>
  	<!-- 동영상모달 -->
  	<form name="videoFrm" method="post" action="VideoPostInsertServlet" enctype="multipart/form-data" >
  	<div class="videomodal">
		<div class="maketexttitle">
		&nbsp;&nbsp;<b>동영상모달</b><img src="./img/makePostBackBtn.svg" class="makevideoBackBtn">
		</div>
		<hr>
		<div class="makebody">
			<h5 class="videotitle">동영상을 선택하세요</h5>
			<div class="choicevideo">
				<input type="file" accept="image/*" id="videoElement" name="videoElement">
			</div>
			<img src="./img/makePostInsertBtn.svg" class="videopostInsert">
		</div>				
  	</div>
  	</form>
  	<!-- 게시물완료모달 -->
  	<div class="postcomplete">
		<div class="maketexttitle">
			<b class="postcomtitle">게시물이 올라갔습니다.</b>
		</div>
		<hr>
		<div class="makebody">
			<img src="./img/makePostCheckIcon.svg" class="makepostComple">
			<br>
			<b class="bodycomple">게시물이 올라갔습니다.</b>
			<br>
			<img src="./img/makePostCheckBtn.svg" class="makepostCheck">
		</div>				
  	</div>
</div>

<!-- 공유하기모달 -->
<div class="sharemodal">
  <div class="share-header">
    <span>공유하기</span>
    <div class="sharecancel">x</div>
  </div>
  <hr>
  	<a href="#" class="naver-share-link" target="_blank" alt="Share on Naver">
  		<img src="./img/postShareNaver.jpg" class="postShareNaver" />
	</a>
  
  	<a href="#" id="btnKakao" onclick="postShareKakao()">
  		<img src="./img/postShareKakao.jpg" class="postShareKakao"/>
  	</a>
</div>
<div class="updateComment">
	
</div>
<form method="post" name="frm">
		<input type="hidden" name="userNickName">
		<input type="hidden" name="postId">
		<input type="hidden" name="commentId">
		<input type="hidden" name="userEmail">
		<input type="hidden" name="friendEmail">
		<input type="hidden" name="comment">
</form>
<script type="text/javascript">
		var request=new XMLHttpRequest();
		//크롭
		const imageInput = document.querySelector('.imageInput');
		imageInput.addEventListener('change', function (event) {
  			const selectedImage = event.target.files[0];
  			const image = document.createElement('img');
  			const choicepicture = document.querySelector('.choicepicture');
  			choicepicture.appendChild(image);
  			image.onload = function () {
    			const MAX_WIDTH = 150;
    			const MAX_HEIGHT = 150;
    			const aspectRatio = image.width / image.height;
    			let newWidth = image.width;
    			let newHeight = image.height;
    			if (newWidth > MAX_WIDTH || newHeight > MAX_HEIGHT) {
      				if (newWidth / newHeight > aspectRatio) {
        				newWidth = MAX_WIDTH;
        				newHeight = newWidth / aspectRatio;
      				} else {
        				newHeight = MAX_HEIGHT;
        				newWidth = newHeight * aspectRatio;
      					}
    				}
    			const canvas = document.createElement('canvas');
    			const context = canvas.getContext('2d');
    			canvas.width = newWidth;
    			canvas.height = newHeight;
    			context.drawImage(image, 0, 0, newWidth, newHeight);
    			const resizedImage = document.createElement('img');
    			resizedImage.src = canvas.toDataURL();
    			choicepicture.removeChild(image);
    			choicepicture.appendChild(resizedImage);
    			const cropper = new Cropper(resizedImage, {
      				aspectRatio: 1,
      				viewMode: 2, 
      				crop(event) {
      					const croppedImageData = cropper.getCroppedCanvas().toDataURL();
        				const croppedImage = document.getElementById('croppedImage');
        				croppedImage.src = croppedImageData;//After이미지
        				cropper.destroy();
      			      	imageInput.value = '';
      					},
    				});
  				};
  				image.src = URL.createObjectURL(selectedImage);
  			});
 		function goURL(url, gid) {
			document.frm1.action=url;
			document.frm1.gid.value=gid;
			document.frm1.submit();
		}
 		function heart(emailpostid){//햇음 하트누르면 하트올라가기
 			const sentence=emailpostid;
 			const [postId,userEmail]=sentence.split(",");
			$.ajax({
			    url: "PostHeartCntServlet", 
			    type: "POST",
			    dataType: "json",
			    data: { postId: postId,
			    		userEmail:userEmail
			    },
			    
			    success: function(result) {
			      	console.log("main에서작용");
			        location.reload();
			      },
			    error: function(xhr, status, error) {
			    	console.error("Error:", error);
			    }
			    
			  }
 			);
 		}
 		function heartdel(emailpostid){
 			const sentence=emailpostid;
 			const [postId,userEmail]=sentence.split(",");
			$.ajax({
			    url: "PostHeartdeleteServlet", 
			    type: "POST",
			    dataType: "json",
			    data: { postId: postId,
			    		userEmail:userEmail
			    },
			    
			    success: function(result) {
			      	console.log("main에서작용");
			        location.reload();
			      },
			    error: function(xhr, status, error) {
			    	console.error("Error:", error);
			    }
			    
			  }
 			);
 		}
 		function cdel(postemail){//햇음 코멘트삭제
			const sentence=postemail;
 			const [commentId,postId]=sentence.split(",");
 			$.ajax({
			    url: "cdel", 
			    type: "POST",
			    dataType: "json",
			    data: { commentId: commentId,
			    		postId:postId
			    },
			    
			    success: function(result) {
			      	console.log("main에서작용");
			        location.reload();
			      },
			    error: function(xhr, status, error) {
			    	console.error("Error:", error);
			    }
			    
			  }
 			);
		}
 		//수정
 		var isInputBoxAdded = false;
 		function cup(commentId) {
 		  const parentElement = document.getElementById("box"+commentId);
 		  if (!isInputBoxAdded) {
 		    const inputBox = document.createElement('input');
 		    inputBox.type = 'text';
 		    const deleteButton = document.createElement('input');
 		    deleteButton.type = 'button';
 		    deleteButton.value = '취소';
 		    deleteButton.onclick = function() {
 		    	parentElement.innerHTML = "수정"; 
 		      	isInputBoxAdded = true;
 		      	location.reload();
 		    };
 		    const saveButton = document.createElement('input');
 		    saveButton.type = 'button';
 		    saveButton.value = '저장';
 		    saveButton.onclick = function() {
 		    	var updatedComment = inputBox.value;
 		      	$.ajax({
 		        	url: 'CommentUpdate',
 		        	type: 'POST',
 		        	data: { commentId: commentId, commentDetail: updatedComment },
 		        	success: function(result) {
 		        	console.log('댓글수정완료');
 		 			location.reload();
 		        },
 		        error: function(xhr, status, error) {
 		        }
 		      });
 		    };
 		   	parentElement.innerHTML = '';
 		    parentElement.appendChild(inputBox);
 		    parentElement.appendChild(saveButton);
 		    parentElement.appendChild(deleteButton);
 		    isInputBoxAdded = true;
 		  }
 		}

 		
 		function hamberger(userEmail){//햄버거 모달 스크립트 완료
			const modal = document.querySelector('.modal');
		    const hams = document.querySelectorAll('.ham');
		    const cancelBtn = document.querySelector('.modal_close');
		    for(var i=0; i<hams.length; i++){
		    hams[i].addEventListener('click', () => {
		    	modal.style.display = 'block';
		    	});
		    }
		    cancelBtn.addEventListener('click', () => {
		        modal.style.display = 'none';
		    });
		}
 		function share(postId){//공유하기모달 반쯤완료
 			const modal = document.querySelector('.modal');
 			const sharebtns=document.querySelectorAll('.sharebtn');
 			const sharecancel=document.querySelector('.sharecancel');
 			const sharemodal=document.querySelector('.sharemodal');
 			for (var i = 0; i <sharebtns.length ; i++) {
 			sharebtns[i].addEventListener('click', () => {
 				sharemodal.style.display='block';
 			 	modal.style.display = 'none';
 			
 			    const currentURL = encodeURIComponent(window.location.href);
 			    const naverShareLink = document.querySelector('.naver-share-link');
 			    naverShareLink.href = 'http://share.naver.com/web/shareView.nhn?url=' + currentURL + '&title=' + encodeURIComponent(document.title);
 			});
			}
 			sharecancel.addEventListener('click', () => {
 				sharemodal.style.display='none';
 			});
		}
 		//카카오공유
 		function postShareKakao() {

 			Kakao.init("22e95823c2f2830c0d276cb7b53d5dad");
 	        Kakao.Link.sendCustom({
 	            templateId: 93282
 	        });
 		}
 		function dofriend(email){//팔로우
 			const sentence=email;
 			const [friendEmail,userEmail]=sentence.split(",");
 			
			const followBtns = document.querySelectorAll(".follow-btn");
			$.ajax({
				    url: "FollowServlet", 
				    type: "POST",
				    data: { friendEmail: friendEmail,
				    		userEmail:userEmail
				    },
				    success: function(result) {
				    	console.log("팔로우신청");
				    	location.reload();
				        },
				    error: function(xhr, status, error) {
				    }
				  });
 		}
 		function friendtext(email){
 			var formData = new FormData();
 			$.ajax({
 				type : "get",
 				url : "reply?boardIdx=${boardInfo.boardIdx}&writer=${boardInfo.userIdx}",
 					dataType : "text",
 					data : formData, 
 					contentType: false, 
 					processData: false, 
 					cache : false,
 					success : function(data) {
 		           		 // C에서 받아온 데이터로 새로 뿌려주기
 						var html = jQuery('<div>').html(data);
 						var contents1 = html.find("div#replyList").html();
 						var contents2 = html.find("div#replyCount").html();
 						$("#replyList").html(contents1);
 						$("#replyCount").html(contents2);
 					},
 					error : function(){
 		                alert("통신실패");
 		            }
 				});
 		}
 		function deletefriend(email){
 			const sentence=email;
 			const [friendEmail,userEmail]=sentence.split(",");
			const followdelbtns = document.querySelectorAll(".followdelbtn");
			$.ajax({
				    url: "DelFollowServlet", 
				    type: "POST",
				    data: { friendEmail: friendEmail,
				    		userEmail:userEmail
				    },
				    success: function(result) {
				    	console.log("팔로우헤제");
				    	location.reload();
				    },
				    error: function(xhr, status, error) {
				    }
			});
 		}
 		
 		var nowUrl = window.location.href;//링크 url따오기 완료
 		function copyUrl(){
 			const modal = document.querySelector('.modal');
 			navigator.clipboard.writeText(nowUrl).then(res=>{
 				  alert("주소가 복사되었습니다!");
 				  modal.style.display='none';
 				})
 		}
 		function report(postId){//신고하기 버튼 누르면 report 숫자올라가기 완료
 			const modal = document.querySelector('.modal');
 			  $.ajax({
 				    url: "postReport", 
 				    type: "POST",
 				    data: { postId: postId },
 				    success: function(result) {
 				    	modal.style.display = 'none';
 				    },
 				    error: function(xhr, status, error) {
 				    }
 				  });
 		}
 		//댓글달기
 		document.addEventListener('DOMContentLoaded', function() {
  		var inputs = document.querySelectorAll('.postTextbox');
  
  		inputs.forEach(function(input) {
    		var postId = input.dataset.postid;
    		var userEmail = '';
    
    		if (input.hasAttribute('data-userEmail')) {
    			userEmail = input.getAttribute('data-userEmail');
    		}
    
    		input.addEventListener('keydown', function(event) {
      			if (event.key === 'Enter') {
        			addComment(postId, userEmail, input.value);
      			}
    		});
  		});
		});

		function addComment(postId, userEmail, commentDetail) {
  		$.ajax({
    		url: "commentAdd",
    		type: "POST",
    		data: {
      		postId: postId,
      		commentDetail: commentDetail,
      		userEmail: userEmail
    	},
    		success: function(result) {
      		var inputs = document.querySelectorAll('.postTextbox');
      		inputs.forEach(function(input) {
        		input.value = "";
      		});
      		location.reload();
    		},
    		error: function(xhr, status, error) {
      		console.error("Error:", error);
    		}
  		});
		}
		//답글
		var isReplyBoxAdded = false;
 		function creply(idemail) {
 			const sentence=idemail;
 			const [commentParrent,userEmail,postId,commentId]=sentence.split(",");
 		  	const parentElement = document.getElementById("rep"+commentId);
 		  	if (!isReplyBoxAdded) {
 		    	const replyBox = document.createElement('input');
 		   		replyBox.type = 'text';
 		   		replyBox.onclick = function(event) {
 		       		event.stopPropagation();
 		     	};
 		    	const replydelete = document.createElement('input');
 		   		replydelete.type = 'button';
 		  		replydelete.value = '취소';
 		 		replydelete.onclick = function() {
 		    		parentElement.innerHTML = "답글"; 
 		    		isReplyBoxAdded = true;
 		    		location.reload();
 		    	};
 		    	const replysave = document.createElement('input');
 		   		replysave.type = 'button';
 		  		replysave.value = '저장';
 		 		replysave.onclick = function() {
 		    		var replyDetail = replyBox.value;
 		      		$.ajax({
 		        		url: 'CommentReply',
 		        		type: 'POST',
 		        		data: { 
 		        			commentParrent: commentParrent, 
 		        			commentDetail: replyDetail,
 		        			userEmail: userEmail,
 		        			postId: postId,
 		        			commentId: commentId
 		        			},
 		        		success: function(result) {
 		        		console.log('답글완료');
 		 				location.reload();
 		        	},
 		        	error: function(xhr, status, error) {
 		        	}
 		      	});
 		   	 };
 		   		parentElement.innerHTML = '';
 		    	parentElement.appendChild(replyBox);
 		    	parentElement.appendChild(replysave);
 		   	 	parentElement.appendChild(replydelete);
 		   	 	isInputBoxAdded = true;
 		   		replyBox.focus();
 		  		}
 			}
		
 		//만들기버튼 기능들
 		const makePostButton = document.querySelector('#make-post');
 		const overlay = document.querySelector('.overlay');
		const makemodal=document.querySelector('.makemodal');
		const makecancel=document.querySelector('.makecancel');
		const imageposition3=document.querySelector('.imageposition3');
		const imageposition4=document.querySelector('.imageposition4');
		const fixmodal=document.querySelector('.fixmodal');//사진모달
		const videomodal = document.querySelector('.videomodal');//동영상모달
		const makeBackBtn=document.querySelector('.makeBackBtn');//사진뒤로가기
		const makevideoBackBtn=document.querySelector('.makevideoBackBtn');//동영상뒤로가기
		const makepostInsert=document.querySelector('.makepostInsert');//사진완료
		const videopostInsert=document.querySelector('.videopostInsert');//영상완료
		const postcomplete=document.querySelector('.postcomplete');
		const makepostCheck=document.querySelector('.makepostCheck');
 		makePostButton.addEventListener('click', () => {
 			overlay.classList.toggle('active');
 		 	overlay.style.display='block';
 		  	makemodal.style.display='block';
 		  	$(".makeimage").attr("src", "./images/mainMakePostTrue.svg");
 		});
 		makecancel.addEventListener('click', ()=>{
 			overlay.classList.toggle('active');
 			overlay.style.display = 'none';
 			makemodal.style.display='none';
 			$(".makeimage").attr("src", "./images/mainMakePostFalse.png");
 		});
 		imageposition3.addEventListener('click', ()=>{
 			makemodal.style.display = 'none';
 			fixmodal.style.display = 'block';
 		});
 		imageposition4.addEventListener('click', ()=>{
 			makemodal.style.display='none';
 			videomodal.style.display='block';
 		});
 		makeBackBtn.addEventListener('click', ()=>{
 			fixmodal.style.display='none';
 			makemodal.style.display='block';
 		});
 		makevideoBackBtn.addEventListener('click',()=>{
 			videomodal.style.display='none';
 			makemodal.style.display='block';
 		})
 		makepostInsert.addEventListener('click',()=>{
 			fixmodal.style.display='none';
 			postcomplete.style.display='block';
 			const userEmail="jseok@aaa.com";//유저 이메일 받아오기
 			const croppedImage = document.getElementById('croppedImage');
 			const croppedFile = dataURLtoFile(croppedImage.src, 'croppedImage.jpg');
 			const formData = new FormData();
 			formData.append('userEmail', userEmail);
 			formData.append('imageName', croppedFile);
 			$.ajax({
				    url: "PostInsertServlet", 
				    type: "POST",
				    data:formData,
				    contentType: false,
				    processData: false,
				    success: function(result) {
				    	console.log("main에서작용");
				        location.reload();
				    },   
				    error: function(xhr, status, error) {
				    }
				  });
 		});
 		function dataURLtoFile(dataURL, fileName) {
 			  const arr = dataURL.split(',');
 			  const mime = arr[0].match(/:(.*?);/)[1];
 			  const bstr = atob(arr[1]);
 			  let n = bstr.length;
 			  const u8arr = new Uint8Array(n);
 			  while (n--) {
 			    u8arr[n] = bstr.charCodeAt(n);
 			  }
 			  return new File([u8arr], fileName, { type: mime });
 			}
 		makepostCheck.addEventListener('click',()=>{
 			overlay.classList.toggle('active');
 			overlay.style.display = 'none';
 			$(".makeimage").attr("src", "./images/mainMakePostFalse.png");
 			postcomplete.style.display='none';
 		})
 		//영상
 		document.addEventListener('DOMContentLoaded', function() {
    const videopostInsert = document.querySelector('.videopostInsert');
    videopostInsert.addEventListener('click', function() {
        const videomodal = document.querySelector('.videomodal');
        const postcomplete = document.querySelector('.postcomplete');
        const userEmail = "jseok@aaa.com";
        const videoElement = document.getElementById('videoElement');
        const videoFile = videoElement.files[0];
        const formData = new FormData();
        formData.append('userEmail', userEmail);
        formData.append('video', videoFile);
        $.ajax({
            url: "VideoPostInsertServlet",
            type: "POST",
            data: formData,
            contentType: false,
            processData: false,
            success: function(result) {
                console.log("action in main");
                location.reload();
            },
            error: function(xhr, status, error) {
            }
        });
    });
});

		
 		
	
	
 	</script>

</script>
</body>
</html>