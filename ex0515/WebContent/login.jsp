<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script> 
<style>
	#login{margin:auto;}
	#login td{text-align:center;}
	#menu{width:800px;margin:auto;margin-bottom:20px;}
	p,h3{text-align:center;}
	
</style>
</head>
<body>
<div><%@include file="../menu.jsp" %></div>
	<form action=login method=post name=frm>
	<table id=login border=1 width=250>
		<tr>
			<td colspan=2><h2>로그인</h2></td>
		</tr>
		<tr>
			<td>아이디</td>
			<td><input type=text name=id></td>
		</tr>
		<tr>
			<td>비밀번호</td>
			<td><input type=password name=pass></td>
		</tr>
		<tr>
			<td colspan=2><input type=submit value=로그인></td>
			
		</tr>
		
		<tr>
			<td colspan=2><input type=button value=회원가입 onClick="location.href='/user/insert'"></td>
		</tr>
		
		
	</table>
	</form>
	<p>
	<img src="/image/mint.jpg" align=center/></p>
		<h3>민트초코맛쿠키</h3>
	
	
<script>
	$(frm).submit(function(e){
		e.preventDefault();
		var id=$(frm.id).val();
		var pass=$(frm.pass).val();
		
		$.ajax({
			type:"post",
			url:"/login",
			data:{"id":id, "pass":pass},
			dataType:"json",
			success:function(data){
				if(data.id==null){
					alert("아이디 및 비밀번호가 일치하지 않습니다!");
					$(frm.id).focus();
				}else{
					alert(data.name + "님이 입장하셨습니다.");
					location.href="/stu/list";
				}
			}
		});
	});
	
</script>
</body>
</html>