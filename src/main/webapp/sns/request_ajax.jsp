<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
<%
	/* request객체에서 받아온 파라미터값 저장 */
	String city = request.getParameter("city");
	String zipcode = request.getParameter("zipcode");
	
	/* out객체를 통해 응답 */
	out.println("도시: " + city);
	out.println("우편주소: " + zipcode);
%>
</body>
</html>