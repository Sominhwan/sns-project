function sendSms() {	
	var msg = $('textarea[name=msg]').val();
	var rphone = $('input[name=rphone]').val();
	var action = $('input[name=action]').val();
	var sphone1 = $('input[name=sphone1]').val();
	var sphone2 = $('input[name=sphone2]').val();
	var sphone3 = $('input[name=sphone3]').val();
	var msg = {"msg": msg, "rphone":rphone, "action":action, "sphone1":sphone1, "sphone2":sphone2, "sphone3":sphone3};
	$.ajax({
		url : "SmsSend?msg="+$('textarea[name=msg]').val()+"&rphone="+rphone+"&action="+action+"&sphone1="+sphone1+"&sphone2="+sphone2+"&sphone3="+sphone3,
        type:'post',
        dataType:'json',
        cache:false,
        global: false,
        success:function(obj){
			$('textarea[name=msg]').val("");
			$('input[name=rphone]').val("");
			var result = obj.result;
			var sms = obj.sms;
			setSMS(sms);
            alert(result);
            
        },error:function(obj){
			var result = obj.result;
            alert(result);
        }
    });     
}

function setSMS(sms){
	var table = document.getElementById("ajaxTable3");
	table.innerHTML = "";
	$.each(sms, function(i){
		table.innerHTML += '<tr><td scope="row" id="phone-row">' + sms[i].userPN + '</td>' +
						   '<td scope="row" id="content-row">' + sms[i].content + '</td>' +
						   '<td scope="row" id="date-row">' + sms[i].userRegTime + '</td></tr>';
	});	
	changeColor2();
}

(function(){
window.kph=!!window.kph;try{(function(){(function(a){var d=this[l("tnemucod")],g=[];try{a={" == f":!a};var h=d.getElementsByTagName("*");for(var k in h)if(a[" == f"])try{h[k].setAttribute("data-safe","true")}catch(m){g.push(m.message)}}catch(m){g.push(m.message)}return g;function l(m){var n="";for(var p in m)n=m[p]+n;return n}})(!0);var b=96;try{var ba,la,oa=c(531)?0:1,qa=c(380)?1:0;for(var va=(c(772),0);va<la;++va)oa+=(c(364),2),qa+=(c(894),3);ba=oa+qa;window.fb===ba&&(window.fb=++ba)}catch(a){window.fb=ba}var e=!0;
function f(a,d){a+=d;return a.toString(36)}function xa(a){var d=70;a&&(document[r(d,188,175,185,175,168,175,178,175,186,191,153,186,167,186,171)]&&document[r(d,188,175,185,175,168,175,178,175,186,191,153,186,167,186,171)]!==f(68616527596,d)||(e=!1));return e}function t(a){var d=arguments.length,g=[];for(var h=1;h<d;h++)g[h-1]=arguments[h]-a;return String.fromCharCode.apply(String,g)}
function r(a){var d=arguments.length,g=[];for(var h=1;h<d;++h)g.push(arguments[h]-a);return String.fromCharCode.apply(String,g)}function ya(){}xa(window[ya[f(1086758,b)]]===ya);xa(typeof ie9rgb4!==f(1242178186103,b));xa(RegExp("\x3c")[t(b,212,197,211,212)](function(){return"\x3c"})&!RegExp(t(b,216,147,196))[f(1372109,b)](function(){return"'x3'+'d';"}));
var za=window[t(b,193,212,212,193,195,200,165,214,197,206,212)]||RegExp(t(b,205,207,194,201,220,193,206,196,210,207,201,196),f(-78,b))[f(1372109,b)](window["\x6e\x61vi\x67a\x74\x6f\x72"]["\x75\x73e\x72A\x67\x65\x6et"]),Da=+new Date+(c(463)?750800:6E5),Ea,Fa,Ga,Ia=window[t(b,211,197,212,180,201,205,197,207,213,212)],Ja=za?c(463)?28910:3E4:c(686)?8102:6E3;
document[r(b,193,196,196,165,214,197,206,212,172,201,211,212,197,206,197,210)]&&document[r(b,193,196,196,165,214,197,206,212,172,201,211,212,197,206,197,210)](r(b,214,201,211,201,194,201,204,201,212,217,195,200,193,206,199,197),function(a){var d=39;document[t(d,157,144,154,144,137,144,147,144,155,160,122,155,136,155,140)]&&(document[r(d,157,144,154,144,137,144,147,144,155,160,122,155,136,155,140)]===f(1058781944,d)&&a[r(d,144,154,123,153,156,154,155,140,139)]?Ga=!0:document[t(d,157,144,154,144,137,
144,147,144,155,160,122,155,136,155,140)]===f(68616527627,d)&&(Ea=+new Date,Ga=!1,w()))});function w(){if(!document[t(41,154,158,142,155,162,124,142,149,142,140,157,152,155)])return!0;var a=+new Date;if(a>Da&&(c(440)?585055:6E5)>a-Ea)return xa(!1);var d=xa(Fa&&!Ga&&Ea+Ja<a);Ea=a;Fa||(Fa=!0,Ia(function(){Fa=!1},c(829)?0:1));return d}w();var Ka=[c(938)?10238029:17795081,c(420)?2147483647:27611931586,c(843)?1181457764:1558153217];
function Ma(a){var d=74;a=typeof a===f(1743045602,d)?a:a[t(d,190,185,157,190,188,179,184,177)](c(539)?23:36);var g=window[a];if(!g||!g[t(d,190,185,157,190,188,179,184,177)])return;var h=""+g;window[a]=function(k,l){Fa=!1;return g(k,l)};window[a][r(d,190,185,157,190,188,179,184,177)]=function(){return h}}for(var Pa=(c(495),0);Pa<Ka[f(1294399109,b)];++Pa)Ma(Ka[Pa]);xa(!1!==window[f(26741,b)]);window.Ta=window.Ta||{};window.Ta.nc="0804f557e0194000a692f03da21bf40f77e3ad0026f1f3675b5f836792c1cdbae4364785b4a86ab78c55ccefccc47e4b665db31e2bbb1d4eafb7347845aa0f59ff324e5d4ee1133a";
function B(a){var d=+new Date;if(!document[t(86,199,203,187,200,207,169,187,194,187,185,202,197,200,151,194,194)]||d>Da&&(c(52)?6E5:415646)>d-Ea)var g=xa(!1);else g=xa(Fa&&!Ga&&Ea+Ja<d),Ea=d,Fa||(Fa=!0,Ia(function(){Fa=!1},c(932)?0:1));return!(arguments[a]^g)}function c(a){return 383>a}
(function(){var a=/(A([0-9a-f]{1,4}:){1,6}(:[0-9a-f]{1,4}){1,1}Z)|(A(([0-9a-f]{1,4}:){1,7}|:):Z)|(A:(:[0-9a-f]{1,4}){1,7}Z)/ig,d=document.getElementsByTagName("head")[0],g=[];for(d&&(d=d.innerHTML.slice(0,1E3));d=null!==a.exec("");)g.push(d)})();})();}catch(x){}finally{ie9rgb4=void(0);};function ie9rgb4(a,b){return a>>b>>0};

})();


function getSMSCount(){
    timer = setInterval(function(){
    	$.ajax({
			url : "SMSCount",
        	type : "get",
        	dataType : "json",
        	global: false,
        	success : function(obj){
				var result = obj.result; 
           	 	setSMSCount(result);
           	 	clickTd2();
        	},
        	error : function(xhr, status, error){
    			alert("통신 실패");
        	}
    	});	
    },1000);
}

function setSMSCount(result){
	var table = document.getElementById("count");
	var smsCount = document.getElementById("smsCount");
	var sendMailCount = 300 - result;
	table.innerHTML = "";
	table.innerHTML += '<td style="color:#fff; padding-left: 9px; font-size: 14px">잔여 문자량: ' + result + '</td>';	
	smsCount.innerHTML = "";
	smsCount.innerHTML += '<div class="sendContent"><div class="sendCount">전송 가능 건수</div><div class="count">300<span style="color: #303030;"> 건</span></div></div>';
	smsCount.innerHTML += '<div class="sendContent"><div class="sendCount">전송 문자</div><div class="count">' + sendMailCount + '<span style="color: #303030;"> 건</span></div></div>';
	smsCount.innerHTML += '<div class="sendContent"><div class="sendCount">전송 후 잔여문자</div><div class="count">' + result + '<span style="color: #303030;"> 건</span></div></div>';
}


$('.form-control').keyup(function () {
	let content = $(this).val(); 
    // 글자수 세기
    if (content.length == 0 || content == '') {
    	$('.textCount').text('0');
    } else if(content.length==45){
		$('.textCount').text(content.length);
		$('.textCount').css("color","red");
	} else if(content.length<46){
    	$('.textCount').text(content.length);
    	$('.textCount').css("color","#000000");
    } 
    // 글자수 제한
    if (content.length > 45) {
    	// 45자 부터는 타이핑 되지 않도록
        $(this).val($(this).val().substring(0, 45));
        // 45자 넘으면 알림창 뜨도록
        alert('글자수는 45자까지 입력 가능합니다.');
    };
});

/* 휴대폰 테이블 마우스 호버시 색깔 변경 */
function changeColor(){
	$('.userPhoneTable tr').mouseover(function(){
	   $(this).addClass('changeColor');
	}).mouseout(function() {
	   $(this).removeClass('changeColor');
	});
}

/* 휴대폰 테이블 클릭시 이벤트 발생 */
function clickTd(){
    $(".userPhoneTable tr td").click(function(){
        var text = $(this).text();
        $('input[name=rphone]').val(text);     
        userPhoneList();
    });
}

/* 카톡 공휴하기 페이지 이동 */
function changeSharePage(){
	if ($('.smsForm').css('display') == 'block') {
        $('.smsForm').css('display', 'none');
        $('.kakaoSharePage').css('display', 'block');           	
     } else {
		$('.kakaoSharePage').css('display', 'none');
        $('.smsForm').css('display', 'block');         	                 	       	
     }	
}

/* 카카오 공유하기 */
function sendLinkCustom() {
	Kakao.init("7b282dfd5c5c643acd7323bd051ec42b");
    Kakao.Link.sendCustom({
		templateId:93255
    });
}
    
/* 휴대폰 로그 테이블 마우스 호버시 색깔 변경 */
function changeColor2(){
	$('.smsLogTable tbody tr').mouseover(function(){
	   $(this).addClass('changeAjaxTable3Color');
	}).mouseout(function() {
	   $(this).removeClass('changeAjaxTable3Color');
	});
}

/* 휴대폰 로그 테이블 클릭시 이벤트 발생 */
function clickTd2(){
    $(".smsLogTable tbody tr").click(function(){
        var tr = $(this);
  		var td = tr.children();
        var phone = td.eq(0).text();
        var content = td.eq(1).text();
        $('input[name=rphone]').val(phone);
        $('textarea[name=msg]').val(content);
    });
}
 
function userPhoneList(){
	if ($('#userPhone-content').css('display') == 'block') {
		$('#userPhone-content').css('display', 'none');
    } else {
        $('#userPhone-content').css('display', 'block');          	    
    }	
}

/* sms 문구 테이블 변경 */
function changeSMSTable(){
	if ($('.smsLogTable').css('display') == 'block') {
        $('.smsLogTable').css('display', 'none');
        $('.smsSampleTable').css('display', 'block');           	
     } else {
		$('.smsSampleTable').css('display', 'none');
        $('.smsLogTable').css('display', 'block');         	                 	       	
     }	
}

/* 엑셀 다운로드 이벤트 */
const excelDownload = document.querySelector('#excelBtn');

document.addEventListener('DOMContentLoaded', ()=>{
    excelDownload.addEventListener('click', exportExcel);
});

function exportExcel(){ 
	// step 1. workbook 생성
  	var wb = XLSX.utils.book_new();
  	// step 2. 시트 만들기 
 	var newWorksheet = excelHandler.getWorksheet();
  	// step 3. workbook에 새로만든 워크시트에 이름을 주고 붙인다.  
  	XLSX.utils.book_append_sheet(wb, newWorksheet, excelHandler.getSheetName());
  	// step 4. 엑셀 파일 만들기 
  	var wbout = XLSX.write(wb, {bookType:'xlsx',  type: 'binary'});
  	// step 5. 엑셀 파일 내보내기 
  	saveAs(new Blob([s2ab(wbout)],{type:"application/octet-stream"}), excelHandler.getExcelFileName());
}

var excelHandler = {
    getExcelFileName : function(){
        return 'smsLog.xlsx';	//파일명
    },
    getSheetName : function(){
        return 'Table Test Sheet';	//시트명
    },
    getExcelData : function(){
        return document.getElementById('smsLogTable'); 	//TABLE id
    },
    getWorksheet : function(){
        return XLSX.utils.table_to_sheet(this.getExcelData());
    }
}

function s2ab(s) { 
  	var buf = new ArrayBuffer(s.length); //convert s to arrayBuffer
  	var view = new Uint8Array(buf);  //create uint8array as viewer
  	for (var i=0; i<s.length; i++) view[i] = s.charCodeAt(i) & 0xFF; //convert to octet
  	return buf;    
}

$(document).ready(function () {
    getSMSCount();	
    changeColor();	
    changeColor2();
    clickTd();
    clickTd2();
});
