function show(){
	document.querySelector(".background").className = "background show"
}

function popupclose () { 
    document.querySelector(".background").className = "background";
}

function popupclose2 () { 
    document.querySelector(".background2").className = "background2";
}

function popupclose4 () { 
  document.querySelector(".background").className = "background";
}

document.querySelector("#show").addEventListener('click', show);
document.querySelector("#popupclose").addEventListener('click', popupclose);
document.querySelector("#popupclose2").addEventListener('click', popupclose2);
document.querySelector("#popupclose4").addEventListener('click', popupclose4);

// -----------------------------------------------------

function show2(){
	document.querySelector(".background2").className = "background2 show"
}

function popupclose3 () { 
    document.querySelector(".background2").className = "background2";
}

function check2 () { 
  document.querySelector(".background2").className = "background2";
}

document.querySelector("#show2").addEventListener('click', show2);
document.querySelector("#popupclose3").addEventListener('click', popupclose3);
//document.querySelector("#check2").addEventListener('click', check2);

//-----------------------------------------------------------------

function show3(){
	document.querySelector(".background3").className = "background3 show"
}

function popupclose5 () { 
    document.querySelector(".background3").className = "background3";
}

function popupclose6 () { 
    document.querySelector(".background3").className = "background3";
}

document.querySelector("#show3").addEventListener('click', show3);
document.querySelector("#popupclose5").addEventListener('click', popupclose5);
document.querySelector("#popupclose6").addEventListener('click', popupclose6);

// ----------------------------------------------------------------------

/*function show4(){
	document.querySelector(".background4").className = "background4 show"
}

function popupclose5 () { 
    document.querySelector(".background4").className = "background4";
}


document.querySelector("#show4").addEventListener('click', show4);
document.querySelector("#popupclose5").addEventListener('click', popupclose5);*/

// 프로필 사진 //
$("#img__preview").on("change", function(e){
		var f=e.target.files[0];
		if(!f.type.match("image*")){
			alert("이미지만 첨부할 수 있습니다..");
			$("#img__preview").val('');
			return;
		}

		// f.size = 1024*1024*2
		if(f.size>1024*1024*2){
			alert("2mb까지의 사진만 업데이트 할 수 있습니다.");
			$("#img__preview").val('');
			return;
		}
		var reader=new FileReader();

		reader.onload=function(e){
			$("#img__wrap").attr("src",e.target.result);
		}
		reader.readAsDataURL(f); //비동기적 진행(파일 읽기)
	});
	
// 배경 사진 //
$("#img__preview2").on("change", function(e){
		var f=e.target.files[0];
		if(!f.type.match("image*")){
			alert("이미지만 첨부할 수 있습니다..");
			$("#img__preview2").val('');
			return;
		}

		// f.size = 1024*1024*2
		if(f.size>1024*1024*2){
			alert("2mb까지의 사진만 업데이트 할 수 있습니다.");
			$("#img__preview2").val('');
			return;
		}
		var reader=new FileReader();

		reader.onload=function(e){
			$("#img__wrap2").attr("src",e.target.result);
		}
		reader.readAsDataURL(f); //비동기적 진행(파일 읽기)
	});