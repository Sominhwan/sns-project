<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="java.util.Vector,sns.*"%>
<jsp:useBean id="umgr" class="sns.UserinfoMgr"/>
<jsp:useBean id="cmgr" class="sns.CommentMgr"/>
<jsp:useBean id="fmgr" class="sns.FriemdmanagerMgr"/>
<%
		//String email = (String)session.getAttribute("idKey");
		String email="jseok@aaa.com";
		//if(email==null) {
			//response.sendRedirect("login.jsp");
		//}
		UserinfoBean mbean = umgr.getPMember(email);
		Vector<UserinfoBean> uilist = umgr.listPMember(email);
		Vector<FriendmanagerBean> flist=fmgr.listfMember(email);
		Vector<FriendmanagerBean> fcommand=fmgr.friend(email);
		
		
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
    <link type="text/css" rel="stylesheet" href="follow.css"></link>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script type="text/javascript">
    	function follow(emailnick){
    		const followmodal = document.querySelector('.followmodal');
            const followBtns=document.querySelectorAll('.followBtn');
            const followCheck=document.querySelector('.followCheck');
            const sentence=emailnick;
 			const [friendEmail,nickName,userEmail]=sentence.split(",");
 			document.frm.friendEmail.value=friendEmail;
 			document.frm.nickName.value=nickName;
 			document.frm.userEmail.value=userEmail;
            document.querySelector("#followNickName").textContent = nickName;
            for (var i = 0; i <followBtns.length ; i++) {
                followBtns[i].addEventListener('click', () => {
                	$.ajax({
                	    url: 'FollowAllow',
                	    type: 'POST',
                	    data: {
                	        userEmail: userEmail,
                	        friendEmail: friendEmail
                	    },
                	    success: function(response) {
                	        console.log(response);
                	        followmodal.style.display = 'block';
                	        location.reload()
                	    },
                	    error: function(xhr, status, error) {
                	        console.log("Error: " + error);
                	    }
                	});
                });
            }
            followCheck.addEventListener('click', () => {
                followmodal.style.display = 'none';
            });
    	}
    	function followCancel(emailnick){
    		const followCancelBtns=document.querySelectorAll('.followCancelBtn');
            const sentence=emailnick;
 			const [friendEmail,nickName,userEmail]=sentence.split(",");
 			document.frm.friendEmail.value=friendEmail;
 			document.frm.nickName.value=nickName;
 			document.frm.userEmail.value=userEmail;
            document.querySelector("#followNickName").textContent = nickName;
            for (var i = 0; i <followCancelBtns.length ; i++) {
            	followCancelBtns[i].addEventListener('click', () => {
                	$.ajax({
                	    url: 'FollowCancel',
                	    type: 'POST',
                	    data: {
                	        userEmail: userEmail,
                	        friendEmail: friendEmail
                	    },
                	    success: function(response) {
                	        console.log(response);
                	        location.reload()
                	    },
                	    error: function(xhr, status, error) {
                	        console.log("Error: " + error);
                	    }
                	});
                });
            }
    	}
    	
    </script>
    
</head>
<body>

<form method="post" name="frm1" action="Main.jsp">
	<input type="hidden" name="gid">
</form>
    <nav>
    <div class = "navbar">
         <a href="javascript:goURL('Main.jsp','')"><img src="./images/mainLogo.png"  alt="Image Button"/></a>
	     <a id = "PhoTalk" class = "navbar-brand" href="Main.jsp">PhoTalk</a>
        <span><input class = "InputBase" placeholder="검색"></span>
        <img id = "mainMessageFalse" src="./images/mainMessageFalse.png" alt="Image Button"/>
        <img id = "mainAlarmFalse" src="./images/mainAlarmFalse.png" alt="Image Button"/>
        <img id = "mainProfile2" src="./images/mainProfile2.png" alt="Image Button"/>
    </div>
</nav>
    <ul>
        <li>
            <a href="Main.jsp">
                <img class = "homeTrue" src="./images/mainHomeFalse.png"  alt="Image Button" width="25" >
                <span class = "sidebar">홈</span>
            </a>
        </li>
        <li><a href="follow.jsp"><img src="./images/mainFollowTrue.svg" alt="Image Button" width="25"><span class = "sidebar">팔로우</span></a></li>
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
    
    <div data-role="page">
    	<div class="followtext">
    		<h5>팔로우 요청</h5>
    	</div>
    </div>
    
    <table>
    <tr>
    <% for (int i = 0; i <flist.size() ; i++) { 
    	FriendmanagerBean fbean = flist.get(i);
		UserinfoBean uibean = umgr.getPMember(fbean.getFriendEmail());
    	%>
    	<td>
    		<div class="followrequest">
    			<!-- friendSign이 0일때 보이게 -->
    			<%if (fmgr.friendCheck(uibean.getUserEmail(),mbean.getUserEmail())) {%>
    			<div class="followimage">
    				<img src="./photo/<%=uibean.getUserImage()%>" width="220" height="200" >
    			</div>
    			<div class="followidtext">
    				<p><br>&nbsp;&nbsp;<%=uibean.getUserNickName() %></p>
    				
    				<a href="javascript:follow('<%=uibean.getUserEmail()%>,<%=uibean.getUserNickName()%>,<%=mbean.getUserEmail()%>')"><img src="./img/followBtn.svg" class="followBtn"></a>
    				<a href="javascript:followCancel('<%=uibean.getUserEmail()%>,<%=uibean.getUserNickName()%>,<%=mbean.getUserEmail()%>')"><img src="./img/followCancelBtn.svg" class="followCancelBtn"></a>
    				<!-- 팔로우 모달 -->
					<div class="followmodal">
    					<div>
    						<br>
        					<h5><strong id="followNickName"></strong>님을 <c>팔로우</c> 하였습니다.</h5>
    					</div>
    					<div>
    						<img src="./img/followModalCheckBtn.svg" class="followCheck">
    					</div>
					</div>
    			</div>
    		</div>
    		<%} %>
    	</td>
    	<% } %>
    	<td>
    	</td>
    </tr>
    </table>
    <hr>
    
    <div data-role="page">
    	<div class="followtext">
    		<h5>추천 팔로우</h5>
    	</div>
    </div>
    <table>
    <tr>
    <% for (int i = 0; i <flist.size(); i++) { 
    	FriendmanagerBean fbean = fcommand.get(i);
		UserinfoBean uibean = umgr.followrecommend(fbean.getFriendEmail(), email);
    	%>
    	<td>
    		<div class="followrequest">
    			<div class="followimage">
    				<img src="./photo/<%=uibean.getUserImage()%>" width="220" height="200" >
    			</div>
    			<div class="followidtext">
    				<p><br>&nbsp;&nbsp;<%=uibean.getUserNickName() %></p>
    				<a href="javascript:follow('<%=uibean.getUserEmail()%>,<%=uibean.getUserNickName()%>,<%=mbean.getUserEmail()%>')"><img src="./img/followBtn.svg" class="followBtn"></a>
    				<img src="./img/followCancelBtn.svg" class="followCancelBtn">
    			</div>
    		</div>
    	</td>
    	<% } %>
    	<td>
    	</td>
    </tr>
    </table>
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
			<img src="./img/makePostSelectVideo.svg">
		</div> 				
  	</div>
  	<!-- 편집하기모달 -->
  	<div class="fixmodal">
		<div class="maketexttitle">
		&nbsp;&nbsp;<b>편집하기</b><img src="./img/makePostBackBtn.svg" class="makeBackBtn">
		</div>
		<hr>
		<div class="makebody">
			<b class="makepostBefore">Before</b>
			<b class="makepostAfter">After</b>
			<div class="choicepicture">
				<input type="file" accept="image/*" class="imageInput">
			</div>
			<div class="choiceafterpicture">
				 <img id="croppedImage" src="" alt="Cropped Image">
			</div>
			<img src="./img/makePostInsertBtn.svg" class="makepostInsert">
		</div>				
  	</div>
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
<form method="post" name="frm">
		<input type="hidden" name="userEmail">
		<input type="hidden" name="friendEmail">
		<input type="hidden" name="nickName">
</form>
<script>
//만들기버튼 기능들
	const makePostButton = document.querySelector('#make-post');
	const overlay = document.querySelector('.overlay');
const makemodal=document.querySelector('.makemodal');
const makecancel=document.querySelector('.makecancel');
const imageposition3=document.querySelector('.imageposition3');
const fixmodal=document.querySelector('.fixmodal');
const makeBackBtn=document.querySelector('.makeBackBtn');
const makepostInsert=document.querySelector('.makepostInsert');
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
	makeBackBtn.addEventListener('click', ()=>{
		fixmodal.style.display='none';
		makemodal.style.display='block';
	});
	makepostInsert.addEventListener('click',()=>{
		fixmodal.style.display='none';
		postcomplete.style.display='block';
	});
	makepostCheck.addEventListener('click',()=>{
		overlay.classList.toggle('active');
		overlay.style.display = 'none';
		$(".makeimage").attr("src", "./images/mainMakePostFalse.png");
		postcomplete.style.display='none';
	})
	 // Get the image input element
const imageInput = document.querySelector('.imageInput');

// Create a Cropper instance when an image is selected
imageInput.addEventListener('change', function (event) {
const selectedImage = event.target.files[0];

// Create an <img> element to display the selected image
const image = document.createElement('img');
const choiceafterpicture = document.querySelector('.choiceafterpicture');
choiceafterpicture.appendChild(image);

// Initialize the Cropper instance once the image is loaded
image.onload = function () {
const cropper = new Cropper(image, {
aspectRatio: 1, // Set the desired aspect ratio for cropping
viewMode: 2, // Set the view mode to restrict the crop box within the container

// Define the crop event handler
crop(event) {
  // Get the cropped image data as a base64-encoded string
  const croppedImageData = cropper.getCroppedCanvas().toDataURL();

  // Set the cropped image as the source of the "croppedImage" element
  const croppedImage = document.getElementById('croppedImage');
  croppedImage.src = croppedImageData;
}
});

// Destroy the Cropper instance when the modal is closed
const makecancel = document.querySelector('.makeBackBtn');
makecancel.addEventListener('click', function () {
cropper.destroy();
imageInput.value = ''; // Reset the input fields
choiceafterpicture.removeChild(image); // Remove the preview image
});
};

// Set the source of the selected image file
image.src = URL.createObjectURL(selectedImage);
});
</script>    
</body>
</html>