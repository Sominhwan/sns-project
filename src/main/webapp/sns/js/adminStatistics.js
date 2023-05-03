var userSignCount = []; // 총 회워가입 수
var userPostCount = []; // 총 게시물 수
var postList = []; // top 5 게시물 정보
var postInfo = []; // userPostCount, userEmail
var postAllCount;
var postPercent = [];
var otherPercent = 0;
function searchUserCount(){
    $.ajax({
		url : "UserInfoCount",
        type : "get",
        dataType : "json",
        global: false,
        success : function(obj){
			var result = obj.count; 
			userSignCount = result;
			searchPostCount();
        },
        error : function(xhr, status, error){
    		alert("통신 실패");
        }
    });		
}

function searchPostCount(){
	var post = "true";
    $.ajax({
		url : "UserInfoCount?post="+post,
        type : "get",
        dataType : "json",
        global: false,
        success : function(obj){
			var result = obj.count; 
			userPostCount = result;
			chart();
        },
        error : function(xhr, status, error){
    		alert("통신 실패");
        }
    });		
}

function chart(){
	Highcharts.chart('container', {
		credits: {enabled: false},
	    title: {
	        text: '2023년도 회원 가입 및 게시물 수',
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
	        data: [userPostCount[0].result, userPostCount[1].result, userPostCount[2].result, userPostCount[3].result, userPostCount[4].result, userPostCount[5].result, userPostCount[6].result, 
	        		userPostCount[7].result, userPostCount[8].result, userPostCount[9].result, userPostCount[10].result, userPostCount[11].result]
	    }]
	});
}

function searchPostInfo(){
    $.ajax({
		url : "PostInfoCount",
        type : "get",
        dataType : "json",
        global: false,
        success : function(obj){
			var result = obj.result; 
			postList = result;
			horiStackedBar();
        },
        error : function(xhr, status, error){
    		alert("통신 실패");
        }
    });		
}

function horiStackedBar() {
	Highcharts.chart('container2_1', {
	  credits: {enabled: false},
	  chart: {
	    type: 'column'
	  },
	  title: {
	    align: 'center',
	    text: '2023년 좋아요 수 TOP5 게시물'
	  },
	  subtitle: {
	    align: 'center',
	    text: '좋아요 수가 많은 게시물을 클릭시 상세한 정보를 얻어올 수 있습니다.'
	  },
	  accessibility: {
	    announceNewData: {
	      enabled: true
	    }
	  },
	  xAxis: {
	    type: 'category'
	  },
	  yAxis: {
	    title: {
	      text: '좋아요 수'
	    }
	
	  },
	  legend: {
	    enabled: false
	  },
	  plotOptions: {
	    series: {
	      borderWidth: 0,
	      dataLabels: {
	        enabled: true,
	        format: '{point.y:.0f}'
	      }
	    }
	  },
	
	  tooltip: {
	    headerFormat: '<span style="font-size:11px">{series.name}</span><br>',
	    pointFormat: '<span style="color:{point.color}">{point.name}</span>: <b>{point.y:.0f}회</b> of total<br/>'
	  },
	
	  series: [
	    {
	      name: '좋아요 수',
	      colorByPoint: true,
	      data: [
	        {
	          name: postList[0].postId+"번 게시물",
	          y: postList[0].likeNum,
	          drilldown: postList[0].postId
	        },
	        {
	          name: postList[1].postId+"번 게시물",
	          y: postList[1].likeNum,
	          drilldown: postList[1].postId
	        },
	        {
	          name: postList[2].postId+"번 게시물",
	          y: postList[2].likeNum,
	          drilldown: postList[2].postId
	        },
	        {
	          name: postList[3].postId+"번 게시물",
	          y: postList[3].likeNum,
	          drilldown: postList[3].postId
	        },
	        {
	          name: postList[4].postId+"번 게시물",
	          y: postList[4].likeNum,
	          drilldown: postList[4].postId
	        }
	      ]
	    }
	  ],
	  drilldown: {
	    breadcrumbs: {
	      position: {
	        align: 'right'
	      }
	    },
	    series: [
	      {
	        name: postList[0].postId,
	        id: postList[0].postId,
	        data: [
	          [
	            '게시물 댓글 수',
	            postList[0].commentNum
	          ],
	          [
	            '게시물 공유하기 수',
	            postList[0].shareNum
	          ],
	          [
	            '게시물 신고 횟수',
	            postList[0].postReport
	          ],
	          [
	            '게시물 좋아요 수',
	            postList[0].likeNum
	          ]
	        ]
	      },
	      {
	        name: postList[1].postId,
	        id: postList[1].postId,
	        data: [
	          [
	            '게시물 댓글 수',
	            postList[1].commentNum
	          ],
	          [
	            '게시물 공유하기 수',
	            postList[1].shareNum
	          ],
	          [
	            '게시물 신고 횟수',
	            postList[1].postReport
	          ],
	          [
	            '게시물 좋아요 수',
	            postList[1].likeNum
	          ]
	        ]
	      },
	      {
	        name: postList[2].postId,
	        id: postList[2].postId,
	        data: [
	          [
	            '게시물 댓글 수',
	            postList[2].commentNum
	          ],
	          [
	            '게시물 공유하기 수',
	            postList[2].shareNum
	          ],
	          [
	            '게시물 신고 횟수',
	            postList[2].postReport
	          ],
	          [
	            '게시물 좋아요 수',
	            postList[2].likeNum
	          ]
	        ]
	      },
	      {
	        name: postList[3].postId,
	        id: postList[3].postId,
	        data: [
	          [
	            '게시물 댓글 수',
	            postList[3].commentNum
	          ],
	          [
	            '게시물 공유하기 수',
	            postList[3].shareNum
	          ],
	          [
	            '게시물 신고 횟수',
	            postList[3].postReport
	          ],
	          [
	            '게시물 좋아요 수',
	            postList[3].likeNum
	          ]
	        ]
	      },
	      {
	        name: postList[4].postId,
	        id: postList[4].postId,
	        data: [
	          [
	            '게시물 댓글 수',
	            postList[4].commentNum
	          ],
	          [
	            '게시물 공유하기 수',
	            postList[4].shareNum
	          ],
	          [
	            '게시물 신고 횟수',
	            postList[4].postReport
	          ],
	          [
	            '게시물 좋아요 수',
	            postList[4].likeNum
	          ]
	        ]
	      }
	    ]
	  }
	});
}

function userPostInfo(){
    $.ajax({
		url : "PostUpCount",
        type : "get",
        dataType : "json",
        global: false,
        success : function(obj){
			var result = obj.result; 
			postInfo = result; // 유저 이메일, 포스트 올린 횟수
			postAllCount = obj.count;
			var other = 0;
			for(let i=0; i<result.length; i++){
				postPercent[i] = (result[i].userPostCount / postAllCount * 100).toFixed(1);
			}
			other = (Number(postPercent[0])+Number(postPercent[1])+Number(postPercent[2])+Number(postPercent[3])+Number(postPercent[4])+Number(postPercent[5])+
					Number(postPercent[6])+Number(postPercent[7])+Number(postPercent[8])+Number(postPercent[9])).toFixed(1);
			otherPercent = (100-other).toFixed(1);
			userChart();
        },
        error : function(xhr, status, error){
    		alert("통신 실패");
        }
    });		
}

function userChart(){
	Highcharts.chart('container3_1', {
	  credits: {enabled: false},		
	  chart: {
	    styledMode: true
	  },
	  title: {
	    text: '게시물을 제일 많이 올린 TOP10 사용자'
	  },
	  xAxis: {
	    categories: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
	  },
	  series: [{
	    type: 'pie',
	    allowPointSelect: true,
	    keys: ['name', 'y', 'selected', 'sliced'],
	    data: [
	      [postInfo[0].userEmail+ ' - '+ Number(postPercent[0]) + '%', Number(postPercent[0]), true, true],
	      [postInfo[1].userEmail+ ' - '+ Number(postPercent[1]) + '%', Number(postPercent[1]), false],
	      [postInfo[2].userEmail+ ' - '+ Number(postPercent[2]) + '%', Number(postPercent[2]), false],
	      [postInfo[3].userEmail+ ' - '+ Number(postPercent[3]) + '%', Number(postPercent[3]), false],
	      [postInfo[4].userEmail+ ' - '+ Number(postPercent[4]) + '%', Number(postPercent[4]), false],
	      [postInfo[5].userEmail+ ' - '+ Number(postPercent[5]) + '%', Number(postPercent[5]), false],
	      [postInfo[6].userEmail+ ' - '+ Number(postPercent[6]) + '%', Number(postPercent[6]), false],
	      [postInfo[7].userEmail+ ' - '+ Number(postPercent[7]) + '%', Number(postPercent[7]), false],
	      [postInfo[8].userEmail+ ' - '+ Number(postPercent[8]) + '%', Number(postPercent[8]), false],
	      [postInfo[9].userEmail+ ' - '+ Number(postPercent[9]) + '%', Number(postPercent[9]) , false],
	      ['Other'+ ' - '+ Number(otherPercent) + '%', Number(otherPercent), false]
	    ],
	    showInLegend: true
	  }]
	});
}

window.onload = function(){
	searchUserCount();
	searchPostInfo();
	
	 userPostInfo();
	 //userChart();

}