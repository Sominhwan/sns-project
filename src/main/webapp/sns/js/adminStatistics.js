var userSignCount = []; // 총 회워가입 수
var userPostCount = []; // 총 게시물 수

function searchUserCount(){
    $.ajax({
		url : "UserInfoCount",
        type : "get",
        dataType : "json",
        global: false,
        success : function(obj){
			var result = obj.count; 
			userSignCount = result;
			chart();
        },
        error : function(xhr, status, error){
    		alert("통신 실패");
        }
    });		
}

function chart(){
	Highcharts.chart('container', {
	    title: {
	        text: '2023년도 회원 가입 수',
	        style: {
	         	fontSize: '18px'
	          }   
	    },
	    subtitle: {
	        text: '월별 차트'
	    },
	    yAxis: {
	        title: {
	            text: ''
	        }
	    },
	    legend: {
	        layout: 'vertical',
	        align: 'right',
	        verticalAlign: 'middle'       
	    },
	    plotOptions: {
	        series: {
	            pointStart: 1
	        }
	    },
	    series: [{
	        name: '회원 수',
	        data: [userSignCount[0].result, userSignCount[1].result, userSignCount[2].result, userSignCount[3].result, userSignCount[4].result,
	         		userSignCount[5].result, userSignCount[6].result, userSignCount[7].result, userSignCount[8].result, userSignCount[9].result, userSignCount[10].result, userSignCount[11].result]
	    }, {
	        name: '게시물 수',
	        data: [10, 50, 60, 70, 80, 81, 85, 90, 95, 100, 110, 120]
	    }]
	});
}

window.onload = function(){
	searchUserCount();
}