<%@page contentType="text/html; charset=UTF-8"%>
<%
		
%>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="./css/help.css" />
    <link rel="stylesheet" href="./css/profile.css"/>
    <link rel="stylesheet" href="./css/modal.css"/>
    <link rel="stylesheet" href="./css/navbar.css"/>
    <title>사용법</title>
    <link
      rel="shortcut icon"
      type="image/x-icon"
      href="./images/loginLogo.png"
    />
  </head>
  <body>
    <nav>
    <div class = "navbar">
        <img src="images/mainLogo.png" alt="Image Button"/>
	    <a id = "PhoTalk" class = "navbar-brand" href="Main.jsp">PhoTalk</a>
	    <img src="images/mainSearch.svg" alt="mainSearch" style="position:relative; left:180px;"/>
	    <form method="post" action="searched.jsp">
        	<span><input type="text" class = "InputBase"  placeholder="검색" name="searchWord" onkeyup="searchUser()" autocomplete="off"></span>
        </form>
        <!-- 모달창 -->
        <div class="absol">
        <img id = "mainMessageFalse" src="./images/mainMessageFalse.png" alt="Image Button" style="cursor: pointer"/>
        <div id="alarm" class="alarm">
        <span class="alarmBalloon"></span>
        </div>
        </div>             
        <img id = "mainAlarmFalse" src="./images/mainAlarmFalse.png" alt="Image Button" style="cursor: pointer"/>
    	<img id = "mainProfile2" src="./images/mainProfile2.png" alt="Image Button" onclick="profileModal()" style="cursor: pointer"/>
    </div>	   
</nav>
    
    <div class="side-bar"></div>
    <span class="Help1">PhoTalk 사용법</span>
    <span class="time1">PhoTalk 사용법:</span>
    <span class="time2">PhoTalk 사용법:</span>
    <span class="time3">PhoTalk 사용법:</span>
    <span class="time4">PhoTalk 사용법:</span>
    <span class="time5">PhoTalk 사용법:</span>
    <span class="time6">PhoTalk 사용법:</span>

    <!-- 비디오 삽입 -->
    <video id="player" style="position: absolute; top:101px; left:380px;" width="1500" height="800"  controls>
      <source src="./images/test.mp4" type="video/mp4" />
    </video>

    <!-- seekToTime() 함수 정의 -->
    <script>
      var player = document.getElementById("player");

      function seekToTime(time) {
        player.currentTime = time;
      }
    </script>


    <!-- 1분으로 이동하는 링크 -->
    <a class="time1-1" href="#" style="text-decoration: none;" onclick="seekToTime(60)">1:00</a>
    <a class="time1-2" href="#" style="text-decoration: none;" onclick="seekToTime(120)">2:00</a>
    <a class="time1-3" href="#" style="text-decoration: none;" onclick="seekToTime(180)">3:00</a>
    <a class="time1-4" href="#" style="text-decoration: none;" onclick="seekToTime(240)">4:00</a>
    <a class="time1-5" href="#" style="text-decoration: none;" onclick="seekToTime(300)">5:00</a>
    <a class="time1-6" href="#" style="text-decoration: none;" onclick="seekToTime(360)">6:00</a>
  	
  </body>
</html>