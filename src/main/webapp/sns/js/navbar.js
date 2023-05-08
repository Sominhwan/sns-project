/* 네브바 검색 기능 */
function searchUser(){	
	if(window.event.keyCode == 13){ //javascript에서는 13이 enter키를 의미함
        searhUserNickName($('.InputBase').val());
        return false; //formname에 사용자가 지정한 form의 name입력
    }			
	$.ajax({
		url : "UserProfileSearch?userNickName="+$('.InputBase').val(),
        type : "post",
        dataType : "json",
        global: false,
        success : function(obj){
			var result = obj.result; 
            searchProcess(result);
            return false;
        },
        error : function(xhr, status, error){
    		alert("통신 실패");
        }
   });	

}

function searchProcess(result){
	if($('.InputBase').val()===""){
		var con = document.getElementById("userTable"); 	
		con.style.display = 'none';
	} else{
	    var con = document.getElementById("userTable"); 	
		con.style.display = 'block';	
	}
	
	var table = document.getElementById("ajaxTable");
    table.innerHTML = "";
   	$.each(result , function(i){
		   table.innerHTML += '<tr onmouseover="this.style.background=\'#f5f5f5\'" onmouseout="this.style.background=\'#fff\'" onclick="getUserNickName()"><td class="photoTd"><img src="' + result[i].userImage + '" style="width: 35px; border-radius: 70%; border: solid 1px #eee;"></td>' 
    	   		+ '<td><div class="nickNameTd" id="nickNameVal">' + result[i].userNickName + '</div><div class="emailTd">' + result[i].userEmail + '</div></td></tr>';    	   		
    });		
}

/* 선택한 유저 닉네임 값 가져오기 */
function getUserNickName(){
	$(".userTable > tbody > tr").click(function(){
		//var userNickName = $(this).children().eq(1).children().eq(0).text();
		var userEmail = $(this).children().eq(1).children().eq(1).text();
		var searchProfile = "profile.jsp?id=" + userEmail;
		$("#navSearch").attr("action",searchProfile).submit();
	});
}

/* 네브바 검색창 submit */
function searhUserNickName(userNickName){
	$.ajax({
		url : "UserProfileInputSearch?userInputNickName="+userNickName,
        type : "post",
        dataType : "json",
        global: false,
        success : function(obj){
			var result = obj.userEmail; 
			searchProcess2(result);
        },
        error : function(xhr, status, error){
    		alert("통신 실패");
        }
   });	
}

function searchProcess2(result){
	if(result==null){
		alert("존재하지 않은 닉네임입니다.");
	} else{
		var searchProfile = "profile.jsp?id=" + result;
		$("#navSearch").attr("action",searchProfile).submit();		
	}

}

/* 프로필 모달창 이벤트 */
function profileModal(){
	var profile_modal = document.getElementById("profile-modal");
	if(profile_modal.style.display == 'none' )
		profile_modal.style.display = 'block';
	else if (profile_modal.style.display == 'block' )
		profile_modal.style.display = 'none';
}

// 외부영역 클릭 시 프로필 팝업 닫기
$(document).mouseup(function (e){
	var LayerPopup = $("#profile-modal");
	if(LayerPopup.has(e.target).length === 0){
		LayerPopup.hide();
	}
});

/*$(document).ready(function () {
});*/