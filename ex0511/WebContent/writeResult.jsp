<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>저장완료!(TEXT)</title>
</head>
<body>
	<H1>저장되었습니다!</H1>
	<h1>Artist:<%=request.getAttribute("n") %></h1>
	<h1>title:<%=request.getAttribute("t") %></h1>
	<h1>content:<%=request.getAttribute("c") %></h1>
</body>
</html>