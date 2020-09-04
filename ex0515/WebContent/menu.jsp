<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
	#menu{background:#A3E4D7;color:white;padding:10px;overflow:hidden;}
	#menu a{text-decoration:none; color:white;}
	#menu a:hover{background:#17A589;padding:10px;}
	.item{float:left;width:100px;}
	.login{float:right;}
	a{text-decoration:none;color:black;}
	#page{width:800px;background:#E8F6F3;box-shadow:10px 10px 10px #F2F4F4;}
	#tbl{margin-top:10px;}
	#login{border-collapse:collapse;}
	.info{float:right;}
</style>

<div id=menu>
<c:if test="${id==null}">
	<div class=item><a href="/login">교수관리</a></div>
	<div class=item><a href="/login">학생관리</a></div>
	<div class=item><a href="/login">강좌관리</a></div>
	<div class=login><a href="/login">로그인</a></div>
</c:if>

<c:if test="${id!=null}">
	<div class=item><a href="/pro/list">교수관리</a></div>
	<div class=item><a href="/stu/list">학생관리</a></div>
	<div class=item><a href="/cou/list">강좌관리</a></div>
	<div class=login><a href="/logout">로그아웃</a></div>
	<div class=info>${id} ${name}</div>
</c:if>
</div>