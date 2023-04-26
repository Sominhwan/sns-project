var allEmailArr = []; // send할 이메일을 담는 배열		
let oEditors = []

		/* 스마트 에디터 기능*/
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
				var tdArr = new Array(); // 주소록 이메일 담는 배열
				
				checkbox.each(function(i) {		
					var tr = checkbox.parent().parent().eq(i);
					var td = tr.children();
					var postId = td.eq(1).text();
					tdArr.push(postId);		
				});
				if(tdArr==''){
					alert("선택한 정보가 없습니다.");
				} else{
					var emailSet = new Set(tdArr);
					for(let i=0;i<allEmailArr.length;i++)
						emailSet.add(allEmailArr[i]);		
					allEmailArr = Array.from(emailSet);
				
					var emailInput = document.getElementById("emailWrap");
						emailInput.innerHTML = '';
							
				 		let regex = new RegExp('[a-z0-9]+@[a-z]+\.[a-z]{2,3}');
				 		for(let i=0;i<allEmailArr.length;i++){	
				 			if(regex.test(allEmailArr[i])){ // 정규검사식 참일 경우
				 				emailInput.innerHTML += '<span id="sendEmail" style="background-color: #0073E633;">'+allEmailArr[i]+ '<button class="emailCancel" id="emailCancel'+ emailInput.childElementCount +'" onclick="deleteEmail('+emailInput.childElementCount+')"></button></span>';	
				 			} else{
				 				emailInput.innerHTML += '<span id="sendEmail" style="background-color: #fc193c33;">'+allEmailArr[i]+ '<button class="emailCancel" id="emailCancel'+ emailInput.childElementCount +'" onclick="deleteEmail('+emailInput.childElementCount+')"></button></span>';	
				 			}
				 		}
						offDisplay();		
				} // else1	
		    });
		});
    	
    	/* 받는사람 이메일 입력 기능 */
	 	function inputEmail(){
	 		var emailInput = document.getElementById("emailWrap");
	 		emailInput.innerHTML = '';
	 		
	 		if($('#emailInput').val()!=''){ // 입력된 값이 공백이 아닐때만 처리
	 		allEmailArr.push($('#emailInput').val());
	 		}
	 		var set = new Set(allEmailArr);
	 		allEmailArr = Array.from(set);
	 		
	 		let regex = new RegExp('[a-z0-9]+@[a-z]+\.[a-z]{2,3}');
	 		for(let i=0;i<allEmailArr.length;i++){	
	 			if(regex.test(allEmailArr[i])){ // 정규검사식 참일 경우
	 				emailInput.innerHTML += '<span id="sendEmail" style="background-color: #0073E633;">'+allEmailArr[i]+ '<button class="emailCancel" id="emailCancel'+ emailInput.childElementCount +'" onclick="deleteEmail('+emailInput.childElementCount+')"></button></span>';	
	 			} else{
	 				emailInput.innerHTML += '<span id="sendEmail" style="background-color: #fc193c33;">'+allEmailArr[i]+ '<button class="emailCancel" id="emailCancel'+ emailInput.childElementCount +'" onclick="deleteEmail('+emailInput.childElementCount+')"></button></span>';	
	 			}			
			}
	 		$('#emailInput').val(''); // 이메일 입력란 엔터후 input 값 초기화	
	 	}
    	
    	/* input 포커스 벗어날시 자동 등록 */
	 	$(function(){
	 		$('#emailInput').blur(function(){
	 			var emailInput = document.getElementById("emailWrap");
	 			emailInput.innerHTML = '';
	 			
	 			if($('#emailInput').val()!=''){ // 입력된 값이 공백이 아닐때만 처리
	 		 		allEmailArr.push($('#emailInput').val());
	 		 	}
	 			var set = new Set(allEmailArr);
	 			allEmailArr = Array.from(set);
	 			
		 		let regex = new RegExp('[a-z0-9]+@[a-z]+\.[a-z]{2,3}');
		 		for(let i=0;i<allEmailArr.length;i++){	
		 			if(regex.test(allEmailArr[i])){ // 정규검사식 참일 경우
		 				emailInput.innerHTML += '<span id="sendEmail" style="background-color: #0073E633;">'+allEmailArr[i]+ '<button class="emailCancel" id="emailCancel'+ emailInput.childElementCount +'" onclick="deleteEmail('+emailInput.childElementCount+')"></button></span>';	
		 			} else{
		 				emailInput.innerHTML += '<span id="sendEmail" style="background-color: #fc193c33;">'+allEmailArr[i]+ '<button class="emailCancel" id="emailCancel'+ emailInput.childElementCount +'" onclick="deleteEmail('+emailInput.childElementCount+')"></button></span>';	
		 			}
		 		}
	 			
	 			$('#emailInput').val(''); // 이메일 입력란 엔터후 input 값 초기화	
	 		});
	 	});
    	
    	/* 선택된 이메일 삭제 */
	 	function deleteEmail(num){
	 		const select = $("#emailCancel"+num).parent().text(); // 해당 이메일 주소 추출	
	 		let i = allEmailArr.indexOf(select); // 특정 배열 인덱스 번호 추출
	 		allEmailArr.splice(i, 1); // 해당 배열 삭제
	 		$("#emailCancel"+num).parent("#sendEmail").remove();  	
	 	}
    	
    	window.onload = function(){
    		searchFunction();
    	}
    	
    	
    	