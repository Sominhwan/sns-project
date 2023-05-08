<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="java.util.Vector,sns.*"%>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="umgr" class="sns.UserinfoMgr"/>
<jsp:useBean id="cmgr" class="sns.CommentMgr"/>
<jsp:useBean id="fmgr" class="sns.FriemdmanagerMgr"/>
<jsp:useBean id="pmgr" class="sns.PostlikeMgr"/>
<%
		String email = (String)session.getAttribute("userEmail");
		//String email="jseok@aaa.com";
		if(email==null) {
			response.sendRedirect("login.jsp");
		}
		UserinfoBean mbean = umgr.getPMember(email);//유저정보 불러오기(유저이메일,이름,프로파일,별명저장)
		Vector<UserinfoBean> uilist = umgr.listPMember(email);//본인을 제외한 5명리스트 불러오기(유저이메일 별명,유저이미지저장)
		Vector<PostBean> uplist=fmgr.friendlist(email);
		
		
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Photalk</title>
    <link rel="shortcut icon" type="image/x-icon" href="./images/mainLogo.png" />
    <!-- 네브바 추가할것 !!!! -->    
    <link type="text/css" rel="stylesheet" href="css/navbar.css"></link>
    <link type="text/css" rel="stylesheet" href="css/sidebar.css"></link>
    <link type="text/css" rel="stylesheet" href="style.css"></link>

 	<script src="https://cdn.jsdelivr.net/npm/cropperjs@1.5.12/dist/cropper.min.js"></script>
 	<script type="text/JavaScript" src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>
 	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
 	<script src="js/navbar.js"></script>
</head>
<div class="modal-wrapper"></div>
<body style="overflow-x: hidden">

<form method="post" name="frm1" action="Main.jsp">
	<input type="hidden" name="gid">
</form>
    <nav>
    <div class = "navbar">
        <img src="images/mainLogo.png" alt="Image Button"/>
	    <a id = "PhoTalk" class = "navbar-brand" href="Main.jsp">PhoTalk</a>
	    <img src="images/mainSearch.svg" alt="mainSearch" style="position:relative; left:180px;"/>
	    	    
	    <form method="post" id="navSearch" >
        	<span><input type="text" class = "InputBase"  placeholder="검색" name="searchWord" onkeyup="searchUser()" autocomplete="off"></span>
        	<input type="text" style="display:none;"/>
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
    <!-- 검색 창 -->
    <!-- 네브바 추가할것 !!!! -->
	<table class="userTable" id="userTable">
		<tbody id="ajaxTable">
	          	         	         		          		          		          		          		          		          		          		          		          		          		          		          		          		          		          	
	    </tbody>
	</table>
<!-------------------- 사이드바 --------------------->
    <ul class = "sideUl">
        <li class = "sideLi">
            <a class = "home" href="Main.jsp">
                <img class = "homeTrue" src="./images/mainHomeTrue.png"  alt="Image Button" width="25" >
                <span class = "sidebar" style="font-weight: bold">홈</span>
            </a>
        </li>
        <li class = "sideLi">
            <a class = "follow" href="follow.jsp">
                <img src="images/mainFollowFalse.png" alt="Image Button" width="25">
                <span class = "sidebar">팔로우</span>
            </a>
        </li>
        <li class = "sideLi">
            <a  class = "search" href="quest.jsp">
                <img src="images/mainExploreFalse.png" alt="Image Button" width="25" >
                <span class = "sidebar">탐색</span>
            </a>
        </li>      
        <li class = "sideLi">
            <a  id="make-post" href="#">
                <img src="images/mainMakePostFalse.png" alt="Image Button" width="25" >
                <span class = "sidebar">만들기</span>
            </a>
        </li>    
        <li class = "sideLi"> 
            <a  class = "profile" href="profile.jsp">
                <img src="images/mainProfile2.png" alt="Image Button" width="25">
                <span class = "sidebar">프로필</span>
            </a>
        </li>                      
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
	<!-- 프로필 모달 -->
	<table class="profile-modal" id="profile-modal" style="display: none">
		<tbody id="innerProfile">
			<tr onclick="location.href='profile.jsp'">
				<td class="profile-td"><img class= "Profile"src="./images/mainProfileModalProfile.svg"></td>
				<td class="profile-td2">프로필 보기</td>		
    		</tr>   	   				
			<tr onclick="location.href='update.jsp'">
				<td class="profile-td"><img class= "N-Info"src="./images/mainProfileModalInfo.svg"></td>
				<td class="profile-td2">개인 정보</td>		
    		</tr> 		
			<tr>
				<td class="profile-td"><img class= "Help"src="./images/mainProfileModalHelp.svg"><span class="Help-T"></td>
				<td class="profile-td2">도움말</td>		
    		</tr> 	
			<tr>
				<td class="profile-td"><img class= "Logout" src="./images/mainProfileModalLogout.svg"></td>
				<td class="profile-td2">로그아웃</td>		
    		</tr> 	    					  	         	         		          		          		          		          		          		          		          		          		          		          		          		          		          		          		          	
	    </tbody>
	</table>    
    <!-- <div style="overflow:scroll; height:1900px;"> -->
<div data-role="page">
    <div class="aaa">
    	<table style="height: 100px">
		<tr>
		<%
				for(int i=0;i<uilist.size();i++){
					UserinfoBean ubean = uilist.get(i);//정보에 뜰 사람들
		%>
			<td width="100">
				<div class="box1">
					<a href="javascript:goURL('searched.jsp?userEmail=<%=ubean.getUserEmail()%>','<%=ubean.getUserEmail()%>')"><!-- 여기에 jsp파일 -->
						<img class="profileimage" src="<%=ubean.getUserImage()%>">
					</a>
				</div>
				<div>
					<span style="position:relative; font-size: 14px; color: #303030; top:10px; left: 3px;"><%=ubean.getUserNickName()%></span>
				</div>
			</td>
		<%}%>	
		</tr>
		</table>
    </div>
    <div class="bbb">
    	<h3 style="color: #868E96; font-size: 18px;">회원님을 위한 추천</h3>
    	<hr>
    	<table>
    	<%
				for(int i=0;i<uilist.size();i++){
					UserinfoBean ubean = uilist.get(i);
		%>
		<tr>	
			<td width="50">
				<div class="boxnored">		
						<img class="profileimage" src="<%=ubean.getUserImage()%>">
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
						<a href="javascript:deletefriend('<%=ubean.getUserEmail() %>,<%=mbean.getUserEmail() %>')" class="followdelbtn" style="color:#1877F2;font-size: 14px;">팔로워</a><% 
					}
					else {
						%><a href="javascript:dofriend('<%=ubean.getUserEmail() %>,<%=mbean.getUserEmail() %>')" class="follow-btn" style="color:#1877F2;font-size: 14px;">팔로우</a><% 
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
		<tr style="width: 517px; display: inline-block;">
			<td style="padding-left: 10px; width: 50px;">
				<div class="box3" style="display: inline-block;">
					<img class="profile" src="<%=uibean.getUserImage()%>">
					
				</div>
						
			</td>
			<td style="width: 100px">
			<div style="font-size: 15px; color: #303030; display: inline-block;"><b><%=uibean.getUserNickName()%></b></div>
			</td>		
			<td><a href="javascript:hamberger('<%=pbean.getUserEmail()%>')" class="ham" style="margin-left: 320px;">
					<img src="./img/postCategory.svg">				
				</a>
			</td>
			
		</tr>
		<tr>
			<td colspan="3" style="border-bottom: solid 1px #eee;"	>
			<!-- 이미지가 null이면 영상불러오기 -->
				<%if (pbean.getImageName() == null || pbean.getImageName().equals("NULL")){ %>
					<embed src="photo/<%=pbean.getVideoName()%>" width="535" height="480">
				<%} else {%>
					<img src="photo/<%=pbean.getImageName()%>" width="535" height="480">
				<%} %>
			</td>
		</tr>
		<tr style="float:left; height: 25px; padding-top: 15px;">
			<td style="padding-left: 10px;">
				<%if (pmgr.postLike(mbean.getUserEmail(), pbean.getPostId())){ %>
					<a href="javascript:heartdel('<%=pbean.getPostId()%>,<%=mbean.getUserEmail() %>')" id="ddd">
					<img src="./img/postLikeTrue.svg" align="top">
					</a>
				<%}else if(!pmgr.postLike(mbean.getUserEmail(), pbean.getPostId())){ %>
					<a href="javascript:heart('<%=pbean.getPostId()%>,<%=mbean.getUserEmail() %>')" id="ddd">				
					<img src="./img/postLikeFalse.svg" align="top">
					</a>
				<%} %> 
			</td>
			<td>
			<a href="javascript:chat('<%=pbean.getPostId()%>')" id="ddd">
				<img src="./img/postMessageFalse.svg" align="top">
			</a>
			</td>
			<td>
			<a href="javascript:share('<%=pbean.getPostId()%>')" id="ddd" class="sharebtn">
				<img src="./img/postShare.svg" align="top">
			</a>
			</td>							
		</tr>
		<tr>
			<td width="250" style="padding-left:10px;"><%=uibean.getUserNickName() %>님 외 <b><%=pbean.getLikeNum() %>명</b>이 좋아합니다.</td>
		</tr>
		<tr class="commenter" stlye="height:<%=commentCount*50%>px;">
			<td colspan="3" width="500" style="padding-left:10px;"> 
				<%
				for(int j=0;j<clist.size();j++){
					CommentBean cbean = clist.get(j);
					if(cbean.getCommentParrent()!=null){
						
				%>
				<div id="myDIV<%=cbean.getCommentParrent()%>" style="display:none; padding-top: 10px;">	
				<c><%=cbean.getUserEmail()%></c>&nbsp;<c class="commentDetail"><%=cbean.getCommentDetail()%></c>
				<br>
				<c>&nbsp;&nbsp;&nbsp;&nbsp;<c style="font-size: 90%; color: #8e8e8e;"><%=cbean.getCommentDate()%></c>&nbsp;&nbsp; 
				<%if(email.equals(cbean.getUserEmail())){%><!-- 덧글이메일과 로그인 이메일같으면 -->
				<a href="javascript:cup('<%=cbean.getCommentId()%>')" id="box<%=cbean.getCommentId()%>" style="font-size: 90%; color: #8e8e8e;">수정</a><%}%>&nbsp;
				<%if(email.equals(cbean.getUserEmail())){%><!-- 덧글이메일과 로그인 이메일같으면 -->
				<a href="javascript:cdel('<%=cbean.getCommentId()%>,<%=pbean.getPostId()%>')" style="font-size: 90%; color: #8e8e8e;">삭제</a></c><%}%>&nbsp;
				<br>
				</div>
				<%} else {%>
					<b><%=cbean.getUserEmail()%></b>&nbsp;<c class="commentDetail" ><%=cbean.getCommentDetail()%></c>
				<br>
				<%if (cmgr.replycheck(cbean.getCommentId())) {%><a href="javascript:doDisplay('<%=cbean.getCommentId()%>');" style="font-size: 90%; color: #8e8e8e;" id="linkText<%=cbean.getCommentId()%>"><img src="img/postMessageReplyBtn.svg"/> 답글보기</a><%}%>&nbsp;<c style="font-size: 90%; color: #8e8e8e;"><%=cbean.getCommentDate()%></c>&nbsp;&nbsp; 
				<a href="javascript:creply('<%=cbean.getCommentParrent()%>,<%=mbean.getUserEmail()%>,<%=pbean.getPostId()%>,<%=cbean.getCommentId()%>')" id="rep<%=cbean.getCommentId()%>" style="font-size: 90%; color: #8e8e8e;">답글</a> &nbsp;
				<%if(email.equals(cbean.getUserEmail())){%><!-- 덧글이메일과 로그인 이메일같으면 -->
				
				<a href="javascript:cup('<%=cbean.getCommentId()%>')" id="box<%=cbean.getCommentId()%>" style="font-size: 90%; color: #8e8e8e;">수정</a><%}%>&nbsp;
				
				<%if(email.equals(cbean.getUserEmail())){%><!-- 덧글이메일과 로그인 이메일같으면 -->
				<a href="javascript:cdel('<%=cbean.getCommentId()%>,<%=pbean.getPostId()%>')" style="font-size: 90%; color: #8e8e8e;">삭제</a></b><%}%>&nbsp;
				<br>
				<%} %>
			
		<%}%>
			</td>
		</tr>
		
		<tr>
		
			<td colspan="3" width="500">
				<br>
				<div class="asdf" style="padding-left: 10px">
				
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
				<hr style="background-color: #d8d8d8">
			</td>
			
		</tr>
		
		<tr>	
			<td colspan="3" width="500" style="padding-top: 15px;">
				<img src="./img/postMessageProfile.svg" class="postMessageProfile">&nbsp;
				<input class="postTextbox" id="postTextbox" placeholder="댓글을 입력하세요." data-postid="<%=pbean.getPostId()%>" data-userEmail="<%=mbean.getUserEmail() %>"/>
			</td>

		</tr>

		
	</table>
	
	</div>
	<!-- 햄버거모달 -->
	<div class="modal">
    			<div>
        			<a href="javascript:report('<%=pbean.getPostId()%>')"><span id="main-modal-text" style="color: #fd3c56; font-weight: bold;">신고하기</span></a><br>
        			<hr style="background: #d8d8d8; height: 1px; border: 0;">
        			<a href="javascript:share('<%=pbean.getPostId()%>')" class="sharebtn"><span id="main-modal-text">공유하기</span></a><br>
        			<hr style="background: #d8d8d8; height: 1px; border: 0;">
        			<a href="javascript:copyUrl('<%=pbean.getPostId()%>')"><span id="main-modal-text">링크복사</span></a><br>
        			<hr style="background: #d8d8d8; height: 1px; border: 0;">
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
  	<input type="hidden" name="userEmail" value="<%=mbean.getUserEmail()%>">
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
		<input type="hidden" name="email" name="" value="<%=email%>">
</form>
    <!-- js 추가 -->
  	<script src="js/main.js"></script>
</body>
</html>