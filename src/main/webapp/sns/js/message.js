const modal = document.querySelector(".modal-wrapper");
var lastID = 0;
let timerId = null;
let timerId2 = null;
let timerId3 = null;
let timerroomId = null;
var userEmail= "";
var Audience ="";
var sendMsgRoomId = "";
var roomdata;
var roomimgdata;
var myName;
/* ----------------- ajax 함수 ----------------- */

function submitFunction(userEmail){	// 채팅 입력시 서블릿 연결후 db 업데이트
	var chatName = myName//$('#chatName').val();
	var chatContent = $('#chatContent').val();
	console.log(sendMsgRoomId);
	$.ajax({
		type: "POST",
		url: "./ChatSubmitServlet",
		data: {
			chatName: encodeURIComponent(chatName),
			chatContent: encodeURIComponent(chatContent),
			sendMsgRoom: encodeURIComponent(sendMsgRoomId),
		},
		success: function(result) {
	//		console.log("리절트" + result)

		}
	});
		$('#chatContent').val('');
	}


function chatInviteList(userEmail){
	$.ajax({
		type: "POST",
		url: "./chatRoomListImageServlet",
		data: {
			userEmail:userEmail,
		},
		success: function(data){
			if(data=="") return;
			var parsed = JSON.parse(data);
			for(var i = 0; i<parsed.length; i++){
				addInviteList(parsed[i].userName, parsed[i].userImage, parsed[i].userEmail);
			}
			
		}
	})
}

function chatInviteFunction(userEmail,Email){
	console.log("초대할 사람:"+Email);
	$.ajax({
		type: "POST",
		url: "./ChatInvite",
		data: {
			myEmail:userEmail,
			Email:Email,
		},
		success: function(data){
			inviteChat(data, Email)
		}
	})
}

function chatListFunction(type,roomId,userEmail){	// 서블릿 연결후 채팅 db연결하여 채팅 리스트 뿌리기
		$.ajax({
			type: "POST",
			url: "./ChatListServlet",
			data: {
				listType: type,
				roomList: roomId,
				userEmail: userEmail,
			},
			success: function(data) {
				if(data == "0") {
					lastID = 0;
			//		console.log("빈채팅방")
					return
					};
				var parsed = JSON.parse(data);
		//		console.log(parsed);
				var result = parsed.result;
		//		console.log(data)
				for(var i = 0; i < result.length; i++) {
					if(myName==result[i][0].value){
						addMyChat(result[i][0].value, result[i][1].value, result[i][2].value)
					}else{
						addChat(result[i][0].value, result[i][1].value, result[i][2].value);
					}
				}
				lastID = Number(parsed.last);
			//	console.log(lastID);
			}
		});
	}
	
function chatRoomListFunction(userEmail){
	$.ajax({
		type: "POST",
		url: "./ChatRoomListServlet",
		data: {
			listType: userEmail,
		},
		success: function(data){
			if(data=="") return;
			//console.log("룸data:"+data);
			var parsed = JSON.parse(data);
			//console.log("룸parsed"+parsed);
		//	console.log("chatRoomListFunction진입:"+data);
			roomdata = parsed;
			console.log("chatRoomListFunction진입:"+roomdata);
	//		for(var i = 0; i<parsed.length; i++){
	//			addRoomId(parsed[i].roomId,parsed[i].userEmail);
	//		}
		}
	})
}

function recentChat(){
	$.ajax({
		type: "POST",
		url: "./ChatRecentServlet",
		data: {
			
		},
		success: function(data){
			if(data=="") return;
			var parsed = JSON.parse(data);
			for(var i = 0; i<parsed.length; i++){
				addRecentChat(parsed[i].roomId, parsed[i].message);
			}
			
		}
	})
}

function chatRoomListImage(userEmail){
	$.ajax({
		type: "POST",
		url: "./chatRoomListImageServlet",
		data: {
			userEmail:userEmail,
		},
		success: function(data){
			if(data=="") return;
			var parsed = JSON.parse(data);
		//	console.log("이미지:"+data);
			roomimgdata = parsed
			console.log("chatRoomListFunction진입:"+roomimgdata);
	//		for(var i = 0; i<parsed.length; i++){
	//			addRoomImage(parsed[i].userEmail, parsed[i].userImage);
	//		}
		}
	})
}

function alarmFunction(userEmail){
	$.ajax({
		type: "POST",
		url: "./ChatAlarmServlet",
		data: {
			userEmail: userEmail,
		},
		success: function(data){
			if(data=="0"){
				addAlarmNumZero();
				return
			}
			addAlarmNum(data);
		}
	})
}


function roomAlarmFunction(userEmail){
	$.ajax({
		type: "POST",
		url: "ChatAnotherServlet",
		data: {
			userEmail: userEmail,
		},
		success: function(data){
			console.log("data:"+data);
			var parsed = JSON.parse(data);
			console.log("룸알람:"+parsed);
			for(var i = 0; i<parsed.length; i++){
				if(parsed[i].lastCheck == 0){
					zeroRoomAlarmNum(parsed[i].roomId);
				}else{
					addRoomAlarmNum(parsed[i].roomId,parsed[i].lastCheck)
				}
			}
			
		}
	})
}



/* ----------------- append 함수 ----------------- */

function addAudienceID(chatName){
		if($('#audienceId').length == 0){
			$('audience').append(
			'<p id="audienceId">'+
			chatName+
			'<p>'
			)
		} 
}

// 상대 채팅 내용 불러오기/추가
function addChat(chatName, chatContent, chatTime) {
		$('#chatList').append(
			'<div id=chatListContent class="chatListContent" style = " font-weight: bold;">'+
			'<p>'+
			chatName+
			'</p>'+
			'<span class="balloon">'+
			chatContent+
			'</span>'+
			'</div>'
		);
		$('#chatList').scrollTop($('#chatList')[0].scrollHeight);
	}
	
// 내 채팅 내용 불러오기/추가
function addMyChat(chatName, chatContent, chatTime) {
		$('#chatList').append(
			'<div id=MychatListContent class="MychatListContent">'+
			'<p>'+
			'</p>'+
			'<span class="Myballoon">'+
			chatContent+
			'</span>'+
			'</div>'
		);
		$('#chatList').scrollTop($('#chatList')[0].scrollHeight);
	} 

function addInviteList(name,image,Email){
	$('#inviteFollow').append(
		'<div id="inviteList" style="height:55px;">'+
		'<div id= "imgarea" style="float:left";width: 55px; height:55px;>'+
		'<img src = "'+image+'" style="width: 55px; height:55px; border-radius:50%;">'+
		'</div>'+
		'<div id="email" style="margin-left:63px">'+
		name+
		'<img src="images/messageInviteBtn.svg" id="'+Email+'" onclick="chatInviteFunction(userEmail, this.id)" style="float: right;">'+
		'</div>'+
		'</div>'+
		'<hr style="background-color: rgba(0,0,0,0.1); border:none; height : 3px;">'
		
	)
}

// 채팅방 리스트 불러오기
function addRoomId(roomId,Email,image,name){
  console.log(roomId);
  $('#chatRoomList').append(
	'<div id ="'+Email+'profileImg" style = "float:left; width: 58px; height:58px;">' +
	'<img src = "'+image+'" style = "border-radius : 50%; width: 58px; height:58px; border: solid 2px #dedede;">'+
	'</div>' +
    '<div id="'+roomId+'" class="'+name+'" onclick="handleChatClick(event)" style = "margin-left:80px;>'+
    '<div id="roomName">'+name+ 
    	'<div id="'+roomId+'roomAlarm" style="float:right;"></div>'+
    '</div>'+
    '<div id="'+roomId+'recentContent" style="height: 21px; margin-top: 16px;margin-bottom: 16px;  margin-left:80px; color: #a4a4a4;"></div>'+
    '</div>'+
    '<hr style="background-color: rgba(0,0,0,0.1); border:none; height : 3px;">'
  );
}	

/*function addRoomImage(Email, userImage){
	setTimeout(function(){
		console.log(Email);
		console.log(userImage);
		$('#'+Email+'profileImg').append(
			'<img src = "'+userImage+'" style = "border-radius : 50%; width: 58px; height:58px; border: solid 2px #dedede;">'
		);
	},100);

}*/

// 채팅방 리스트에서 각 방에서의 제일 최근 메세지 표시
function addRecentChat(roomId, recentChat){
	$('#'+roomId+'recentContent *').remove();
	$('#'+roomId+'recentContent').append(
	'<p>'+
	recentChat+
	'</p>'
	);
}

// 각 방의 새로운 메세지 알림
function addRoomAlarmNum(roomId, roomAlarmNum){
	console.log("알람 있음");
	$('#'+roomId+'roomAlarm *').remove();
	$('#'+roomId+'roomAlarm').append(
		'<span class="roomAlarmBalloon">'+
		roomAlarmNum+
		'</span>'
	)
}

// 각 방의 새로운 메세지가 없을때 or 전부 확인 했을 경우
function zeroRoomAlarmNum(roomId, roomAlarmNum){
	console.log("제로 알람");
	$('#'+roomId+'roomAlarm *').remove();
}

// 새로운 메세지가 없을 경우 or 전부 확인 했을 경우
function addAlarmNumZero(){
	$('#alarm *').remove();
}

// 방 전부의 새로온 메세지 알람
function addAlarmNum(AlarmNum){
	$('#alarm *').remove();
	$('#alarm').append(
		'<span class="alarmBalloon">'+
		AlarmNum+
		'</span>'
	)
}

function deletInviteList(){
	$('#inviteFollow *').remove();
}

function deleteRoomId(){
  $('#chatRoomList *').remove();
}



/* ----------------- 함수 반복, 정지 ----------------- */

function stratRecentChat(){
 timerId2 = setInterval(function(){
	 recentChat();
 },500);
}

function stratAddRoomAlarmNum(userEmail){
 timerId3 = setInterval(function(){
	 roomAlarmFunction(userEmail);
 },1000);
}

	// 채팅 리스트를 0.2초마다 새로고침 시작하는 함수	
	function startChat(roomId){
		console.log("확인용 :"+roomId);
		sendMsgRoomId = roomId;
		chatListFunction('ten',roomId,userEmail);
		setTimeout(	function getInfiniteChat() {
	timerId = setInterval(function() {
			chatListFunction(lastID,roomId,userEmail);
	//		console.log("반복중");
		}, 200);
	}, 500)
	}
	
	
	function ready(id, mName){
		userEmail = id;
		myName = mName;
		console.log(myName);
		chatRoomListFunction(userEmail);
		chatRoomListImage(userEmail);
		alarmFunction(userEmail);
		setInterval(function(){
    alarmFunction(userEmail); // 1초마다 실행
  }, 1000);
	}
	
	
// 창이 켜지면 실행 - 알람 관련 함수

	
	
	
//	function getInfiniteChat() {
//	timerId = setInterval(function() {
//			chatListFunction(lastID);
//			console.log("반복중")
//		}, 200);
//	}
	
	// 각 방의 알람 함수 정지
	function stopAddRoomAlarmNum() {
 	 clearInterval(timerId3);
	}
	// 각 방의 최근의 메세지 함수 정지
	function stopRecentChat() {
 	 clearInterval(timerId2);
	}
	// 채팅방 통신 정지
	function stopInfiniteChat() {
 	 clearInterval(timerId);
	}
	
	// 엔터키 클릭 이벤트 - 채팅 보내기
    function mykeydown() {
        if(window.event.keyCode==13) //enter 일 경우
        {
        	submitFunction();
        }
    }



function semdMsg() {
//  var msgContent = document.getElementById("msgContent").value;
//  document.getElementById("msgContent").clear;
//  word.innerHTML = msgContent;
	submitFunction(userEmail);
}


/* ----------------- 각종 핸들러 함수 ----------------- */
function allChatsearchList(){
	var input = document.getElementById("search").value.trim();
	deleteRoomId();
	for(var i = 0; i<roomdata.length; i++){
		for(var j=0; j<roomimgdata.length; j++){
			if(roomdata[i].userEmail==roomimgdata[j].userEmail){
				if(input != ""){
						console.log(input+" - 필터링");
						if(roomimgdata[j].userName.indexOf(input) !== -1){
						addRoomId(roomdata[i].roomId,roomdata[i].userEmail,roomimgdata[j].userImage,roomimgdata[j].userName);
					}
				}else{
				console.log("공백");
				addRoomId(roomdata[i].roomId,roomdata[i].userEmail,roomimgdata[j].userImage,roomimgdata[j].userName);	
			}

			}
		}
	}

}

function allInvitesearchList(){
	var input = document.getElementById("search").value.trim();
	deletInviteList()
		for(var j=0; j<roomimgdata.length; j++){
				if(input != ""){
						console.log(input+" - 필터링");
						if(roomimgdata[j].userName.indexOf(input) !== -1){
						addInviteList(roomimgdata[j].userName, roomimgdata[j].userImage, roomimgdata[j].userEmail);
					}
				}else{
				console.log("공백");
				addInviteList(roomimgdata[j].userName, roomimgdata[j].userImage, roomimgdata[j].userEmail);	
			}	
		}
}

// 상단바의 채팅 아이콘 클릭시 실행되는 함수
function clickChatBtn(id) {	// 말풍선 버튼 클릭시 채팅목록 모달창
  var image = document.getElementById('mainMessageButtonfalse');
  var followImage = document.getElementById('mainAlarmFalse');
  userEmail = id;
 
  if (image.src.match("images/mainMessageFalse.png")) {
    image.src = "images/mainMessageTrue.svg";
    if(followImage.src.match("images/mainLikeTrue.svg")){
	followImage.src = "images/mainAlarmFalse.png";
	closeFollow();
	}
    // modal.style.display = "flex";
	openModal();
	chatRoomListFunction(userEmail);
	chatRoomListImage(userEmail);
	recentChat();
	allChatList(userEmail);
	roomAlarmFunction(userEmail);
	stratRecentChat();
	stratAddRoomAlarmNum(userEmail)
   	} else {
    image.src = "images/mainMessageFalse.png";
    // modal.style.display = "none";
    closeModal();
  }
}

// 채팅 아이콘 한번더 클릭시 실행되는 함수 
function closeModal() {	
  stopInfiniteChat();
  stopRecentChat();
  stopAddRoomAlarmNum();
//  lastID = 0;
  modal.innerHTML = '';
}


function allChatList(){
		setTimeout(function(){
	console.log("allchat진입-roomip:"+ roomdata);
	console.log("allchat진입-roomimgdata:"+ roomimgdata);
	for(var i = 0; i<roomdata.length; i++){
		for(var j=0; j<roomimgdata.length; j++){
			if(roomdata[i].userEmail==roomimgdata[j].userEmail){
				addRoomId(roomdata[i].roomId,roomdata[i].userEmail,roomimgdata[j].userImage,roomimgdata[j].userName);
			}
		}
	}
	},150)	
}


// 채팅방 초대창에서 뒤로가기 눌렀을때 실행되는 함수
function inviteBack(userEmail){
	openModal();
	chatRoomListFunction(userEmail);
	chatRoomListImage(userEmail);
 	allChatList();
	recentChat();
	stratRecentChat();
	roomAlarmFunction(userEmail);
	stratAddRoomAlarmNum(userEmail);
}

// 채팅방에서 뒤로가기 버튼을 눌렀을때 실행되는 함수
function roomBackModal(userEmail) {
  stopInfiniteChat();
  openModal();
  chatRoomListFunction(userEmail);
  chatRoomListImage(userEmail);
  allChatList();
  recentChat();
  stratRecentChat();
  roomAlarmFunction(userEmail);
  stratAddRoomAlarmNum(userEmail);
 // lastID = 0;
}

// 채팅방 진입시 실행되는 함수
function handleChatClick(event) {
  const email = event.currentTarget.classList[0];
  const id = event.currentTarget.id;
  chat(email);
  startChat(id);
  stopRecentChat();
  stopAddRoomAlarmNum();
}

function inviteChat(roomId, email){
  chat(email);
  startChat(roomId);
}

/* ----------------- 모달 창 열기 ----------------- */

function openModal() {
  modal.innerHTML = `
  <link href="css/profile.css" rel="stylesheet">
    <div class="modal">
      <div class="modal-content">
      <div class="header">
        <h2>채팅</h2>
         <button type="button" class="messageInvite" id ="messageInvite" onclick="chatInvite();stopRecentChat();stopAddRoomAlarmNum();chatInviteList(userEmail)"><img id="messageBackBtn" src="images/messageInvite.svg"></button>
        </div>
        <div class="search">
       		 <img id = "searchimg" src="images/search.svg">
       		 <input type="text" id="search" oninput="allChatsearchList()" placeholder="대화상대 검색" autocomplete="off" style="padding-left:35px;">
		</div>
		<div id="chatRoomList" style = "margin-top:20px;"> 
        </div>
      </div>
    </div>
  `;
}

function chatInvite() {
  modal.innerHTML = `
  <link href="css/profile.css" rel="stylesheet">
    <div class="modal">
      <div class="modal-content">
      <div class="header">
        <h2>대화상대 초대</h2>
         <button type="button" class="messageBack" id ="messageBack" onclick="inviteBack(userEmail)"><img id="messageBackBtn" src="images/messageBackBtn.svg"></button>
        </div>
        <div class="search">
       		 <img id = "searchimg" src="images/search.svg">
 			 <input type="text" id="search" oninput="allInvitesearchList()" placeholder="대화상대 검색" autocomplete="off" style="padding-left:35px;">
		</div>
		<div id="inviteFollow" style = "margin-top:20px;">
        </div>
      </div>
    </div>
  `;
}

function chat(Email) {
  modal.innerHTML = `
  <link href="css/profile.css" rel="stylesheet">
    <div class="modal">
      <div class="header">
        <h4 id="audience">`+
        Email+
        `</h4>
        <button type="button" class="messageBack" id ="messageBack" onclick="roomBackModal(userEmail)"><img id="messageBackBtn" src="images/messageBackBtn.svg"></button>
        </div>
        <div>
        <hr style="background-color: rgba(0,0,0,0.1); border:none; height : 3px;">
        </div>
        <div id="chatList">
        </div>
        <div class="sendMsgBox">
             <hr style="background-color: rgba(0,0,0,0.1); border:none; height : 3px;">
         	 <div class="msgBox">
 			 <input type="text" class="chatContent" id="chatContent" onkeyup="if(window.event.keyCode==13){semdMsg()}">
 			 <button type="button" class="semdMsgButton" id ="semdMsgButton" onclick="semdMsg()"><img id="messageSendInsertIcon"src="images/messageSendInsertIcon.svg" ></button>
 			 </div>
		</div>
    </div>
  `;
}

/* ----------------- 여기서 부터 팔로워 모달창 ----------------- */

function chatFollowAcceptListList(userEmail){
	$.ajax({
		type: "POST",
		url: "./FollowAcceptListServlet",
		data: {
			userEmail:userEmail,
		},
		success: function(data){
			if(data=="") return;
			console.log("미수락:"+data);
			var parsed = JSON.parse(data);
			for(var i = 0; i<parsed.length; i++){
				addFollowerList(parsed[i].userName, parsed[i].userImage, parsed[i].userEmail);
			}
			
		}
	})
}

function updateFollowerFunction(userEmail, Email){
	$.ajax({
		type: "POST",
		url: "./FollowAcceptServlet",
		data: {
			myEmail:userEmail,
			Email:Email,
		},
		success: function(data){
			console.log("친구수락:"+ data);
			succeceFollwer();
			chatFollowAcceptListList(userEmail);
		}
	})
}

function addFollowerList(name,image,Email){
	$('#followerList').append(
		'<div id="'+name+'invite" style="height:55px;">'+
		'<div id= "imgarea" style="float:left";width: 55px; height:55px;>'+
		'<img src = "'+image+'" style="width: 55px; height:55px; border-radius:50%;">'+
		'</div>'+
		'<div id="email" style="margin-left:63px">'+
		name+
		'<img src="images/alarmFollowBtn.svg" id="'+Email+'" onclick="updateFollowerFunction(userEmail, this.id)" style="float: right;">'+
		'</div>'+
		'</div>'+
		'<hr>'
		
	)
}

function succeceFollwer(){
	$('#followerList *').remove();
}



function clickFollowBtn(){
	var msgImage = document.getElementById('mainMessageButtonfalse');
	var followImage = document.getElementById('mainAlarmFalse');
	if(followImage.src.match("images/mainAlarmFalse.png")){
	if(msgImage.src.match("images/mainMessageTrue.svg")){
		msgImage.src = "images/mainMessageFalse.png";
		closeModal();
	}
	console.log("켜짐");
	followImage.src = "images/mainLikeTrue.svg";
	openFollower();
	chatFollowAcceptListList(userEmail);
	}else{
	console.log("꺼짐");
	followImage.src = "images/mainAlarmFalse.png";
	closeFollow();
	}
}

function closeFollow(){
	modal.innerHTML = '';
}





/* ----------------- 팔로워 모달 창 열기 ----------------- */
function openFollower(){
	modal.innerHTML = `
  <link href="css/profile.css" rel="stylesheet">
    <div class="modal">
      <div class="modal-content">
      <div class="header">
        <h2>알림</h2>
        </div>
		<div id="followerList"> 
        </div>
      </div>
    </div>
  `;
}
