<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>1부터 100까지의 합계</title>
</head>
<body>

	<%
		//1부터 100까지의 합계
		int sum=0;
		for(int i=1; i<=100; i++){
			sum=sum+i;
		}
		
		int etot=0;
		for(int i=2; i<=100; i+=2){
			etot=etot+i;
		}
		
		int htot=0;
		for(int i=1; i<100; i+=2){
			htot=htot+i;
		}
	%>
	
	<H1>1부터 100까지의 합계:<%=sum%></H1>	
	<H1>1부터 100까지 짝수의 합계:<%=etot%></H1>
	<h1>1부터 100까지의 홀수의 합계:<%=htot%></h1>
</body>
</html>