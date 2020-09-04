<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>학사관리시스템</title>
	<link rel="stylesheet" href="home.css">
</head>
<body>
	<div id="divPage">
		<div id="divTop"><jsp:include page="header.jsp"/></div>
		<div id="divCenter">
			<div id="divMenu"><jsp:include page="menu.jsp"/></div>
			<div id="divContent">
			<!--여기에 내용출력 시작---------------------------- -->
			<!--여기에 내용출력 종료---------------------------- -->
			</div>
		</div>
		<div id="divBottom"><jsp:include page="footer.jsp"/></div>
	</div>
</body>
</html>