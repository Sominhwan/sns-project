<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="sns.*"%>
<%@page import="sns.UserMgr"%>
<%@page import="sns.UniversityBean"%>

<!DOCTYPE html>
<html style="background-color:	#ECECEC;">
<head>
<meta charset="UTF-8">
<title>Search University</title>

<script>
function setTextBoxValue(value) {
  document.getElementById("selectedUni").value = value;
}

function setInputValue() {
  var form = document.getElementById("inputForm");
  form.submit();
}
</script>
<link
      rel="shortcut icon"
      type="image/x-icon"
      href="./images/loginLogo.png"
    />
</head>
<body>
    <div id= "side-bar" class="side-bar" style="
	bottom:0px;
	left: 0px;
    padding-left: 10px;
    height: 380px;
    background-color: white;
    overflow-y: auto;
    margin: 70px 10px 10px 10px;
    box-shadow: 0 2px 5px rgba(0,0,0,0.2);
">
<span class="a" style="position: absolute; top:130px; left:100px; font-weight: bold" >Tip</span>
<span class="b" style="position: absolute; top:160px; left:100px;" >대학교를 검색 한 후 클릭을 하면 </span>
<span class="c" style="position: absolute; top:190px; left:100px;" >학교명으로 자동으로 넘어갑니다. </span>
<span class="d" style="position: absolute; top:400px; left:170px; color: gray">powered by PhoTalk</span>
<%
    String searchUniName = request.getParameter("uniName");
    if (searchUniName != null) {
        UserMgr userMgr = new UserMgr();
        ArrayList<String> uniList = userMgr.getUniversityList();

        out.println("<ul style= \"list-style-type:none; padding-left: 0; margin-top:-10;\">");
        boolean hasResult = false;
        for (String uniName : uniList) {
            if (uniName.contains(searchUniName)) {
                out.println("<li style=\"padding-bottom:10px; padding-top:10px; cursor:pointer; border-bottom:1px solid #ccc;\" onclick=\"setInputValue('" + uniName + "')\">" + uniName + "</li>");
                hasResult = true;
            }
        }
        out.println("</ul>");
		
        %>
        <script>
            document.querySelector('.a').style.display = 'none';
            document.querySelector('.b').style.display = 'none';
            document.querySelector('.c').style.display = 'none';
            document.querySelector('.d').style.display = 'none';
        </script>
        <% 
    }
%>
</div>
    
    <form name="searchForm" id="searchForm" method="get" action="search.jsp" onsubmit="return checkForm()">
    <label> <input type="text" name="uniName" id="uniName" 
    style="z-index:1000;
    height: 45px; width: 100%;
    position: absolute;
    top: 0px;
    left: 0px;
    border: none;
    outline: none;
    font-size: 20px;
    padding-left: 10px;
    box-shadow: 0 2px 5px rgba(0,0,0,0.2);"
    placeholder="대학 이름을 입력하세요"
      />
    </label>
    
    <img id="search"  onclick="searchSchool()" src="./images/adminSearch.svg" style="position: fixed;
    top: 10px; right: 10px; cursor: pointer;
    z-index: 1000;" />
    
    <input type="submit" value="검색" style="display:none;"/>
</form>
    
 
    

<input type="hidden" name="selectedUni" id="selectedUni"/>



<form id="inputForm" method="post" action="update1.jsp">
    <input type="hidden" name="selectedUni" id="selectedUniInput" />
</form>

<script>
    document.addEventListener("DOMContentLoaded", function() {
        document.querySelectorAll("#selectedUni").forEach(function(element) {
            element.addEventListener("input", function() {
                document.getElementById("selectedUniInput").value = element.value;
            });
        });
    });

    function setInputValue(value) {

        document.getElementById("selectedUni").value = value;
        opener.document.getElementById("school").value = document.getElementById("selectedUni").value;
        window.close();
        
       
    }
    function searchSchool(){
    	document.searchForm.submit();
    } 
    function checkForm() {
        var uniName = document.getElementById("uniName").value.trim();
        if (uniName == "") {
            alert("대학 이름을 입력해주세요.");
            return false;
        }
        return true;
    }
</script>

</body>
</html>