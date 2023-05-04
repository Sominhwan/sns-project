<!-- 친구들의 게시물 사진들 보여주기 -->
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="java.util.Vector,sns.*"%>
<jsp:useBean id="umgr" class="sns.UserinfoMgr"/>
<jsp:useBean id="cmgr" class="sns.CommentMgr"/>
<jsp:useBean id="fmgr" class="sns.FriemdmanagerMgr"/>
<jsp:useBean id="pmgr" class="sns.PostMgr"/>
<%
		String email = (String)session.getAttribute("userEmail");
		//String email="jseok@aaa.com";
		if(email==null) {
			response.sendRedirect("login.jsp");
		}
		UserinfoBean mbean = umgr.getPMember(email);
		Vector<UserinfoBean> uilist = umgr.listPMember(email);
		Vector<FriendmanagerBean> flist=fmgr.friendpost(email);//프렌드sign이 1인애들 가져오기
		Vector<PostBean> uplist=fmgr.friendlist(email);
		
		ArrayList<PostBean> userImageList = pmgr.getRandomImage(); // 랜덤으로 사진 30개 가져오기
		String [] arr = new String[30];		
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Photalk</title>
    <link rel="shortcut icon" type="image/x-icon" href="./images/mainLogo.png" />
    <link href="profile.css" rel="stylesheet" type="text/css"/>
    <link type="text/css" rel="stylesheet" href="style.css"></link>
    <link type="text/css" rel="stylesheet" href="css/navbar.css"></link>
    <link type="text/css" rel="stylesheet" href="quest.css"></link>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script type="text/javascript">

    </script>
    
</head>
<body>
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
        <li><a href="follow.jsp"><img src="./images/mainFollowFalse.png" alt="Image Button" width="25"><span class = "sidebar">팔로우</span></a></li>
        <li><a href="quest.jsp"><img src="./images/mainExploreTrue.svg" alt="Image Button" width="25" ><span class = "sidebar">탐색</span></a></li>
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
    <div class="quest-content">
    <div class="gallerylist">
    <!-- 검색 창 -->
	<div id="userSearchContent" style="">
		<table class="userTable">
	          <tbody id="ajaxTable">
	          	<tr>
	          		<td>안녕</td>
	          	</tr>
	          	<tr>
	          		<td>안녕</td>
	          	</tr>
	          	<tr>
	          		<td>안녕</td>
	          	</tr>
	          	<tr>
	          		<td>안녕</td>
	          	</tr>
	          	<tr>
	          		<td>안녕</td>
	          	</tr>
	          	<tr>
	          		<td>안녕</td>
	          	</tr>
	          	<tr>
	          		<td>안녕</td>
	          	</tr>
	          	<tr>
	          		<td>안녕</td>
	          	</tr>	          		          		          		          		          		          		          	
	          </tbody>
	    </table>
	 </div>  
	 
	    <ul class="gallery-ul">
	        <h5 class="quest">탐색</h5>
	    	<li class="gallery-li">
	    		<a href="">
	    			<div class="screen">
	    				<div class="top"><img src="images/exploreLinkCopyBtn.svg"></div>
	    				<img src="photo/photo1.jpg" style="width: 350px; height: 350px;">
					</div>
	    		</a>
	    	</li>	
	    <% for(int i=0; i<userImageList.size(); i++) { 
			arr[i] = userImageList.get(i).getImageName();
			if(arr[i]!=null){
		%>
	    	<li class="gallery-li">
	    		<a href="#">
	    			<div class="screen">
	    				<div class="top"><img src="images/exploreLinkCopyBtn.svg"></div>
	    				<img src="<%=arr[i]%>" id="copyImg<%=i%>"  style="width: 350px; height: 350px;">
					</div>
	    		</a>
	    	</li>
	      <%} %>
	    <% } %>	    		    		    		    		    		    	    	
	    </ul>	
	</div>	
	</div>
<%--     <table>
        <% for (int i=0; i < flist.size(); i+=3) { %>
            <tr>
                <% for (int j=i; j < Math.min(i+3, flist.size()); j++) { 
           	
                %>
                    <td>
                        <div class="imagebox">
                        	<%	FriendmanagerBean bean=flist.get(j);
                        		PostBean pbean=pmgr.postImage(bean.getFriendEmail());
                        	%>
                        	<img src="./photo/<%=pbean.getImageName()%>" width="320" height="320">
                        </div>
                    </td>
                <% } %>
            </tr>
        <% } %>
   </table> --%>
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