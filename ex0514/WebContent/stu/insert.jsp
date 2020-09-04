<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>[학생등록]</title>
<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<STYLE>
	#tbl td{border:1px solid #515A5A;}
	.title{background:#76D7C4;}
	.row:hover{background:#1ABC9C;color:white;cursor:pointer;}
	#tbl{border-collapse:collapse;margin-bottom:10px;}
</STYLE>
</head>
<body>
<div><%@include file="../menu.jsp" %></div>
	<h1>[학생등록]</h1>
	<form action=insert method=post name=frm>
	<table id=tbl border=1 width=500>
		<tr>
			<td>학생번호</td>
			<td><input type=text name=scode maxlength=8></td>
		</tr>
		<tr>	
			<td>학생명</td>
			<td><input type=text name=sname></td>
		</tr>
		<tr>
			<td>학생학과</td>
			<td>
				<select name=dept>
					<option>전산</option>
					<option selected>전자</option>
					<option>건축</option>
				</select>	
			</td>
		</tr>
		<tr>
			<td>학년</td>
			<td>
			<input type=radio value=1 name=year checked>1학년
			<input type=radio value=2 name=year>2학년
			<input type=radio value=3 name=year>3학년
			<input type=radio value=4 name=year>4학년
			</td>
		</tr>
		<tr>
			<td>생년월일</td>
			<td><input type=date name=birthday></td>
		</tr>	
		<tr>
			<td>지도교수</td>
			<td>
				<select name=advisor>
				<c:forEach items="${plist}" var="vo">
					<option value="${vo.pcode}">${vo.pcode}:${vo.pname}:${vo.dept}</option>
				</c:forEach>
				</select>
			</td>
		</tr>
	</table>
	<input type=submit value=저장>
	<input type=reset value=취소>
	<input type=button value=목록 onClick="location.href='list'">
	</form>
</body>
<script>

	//유효성 검사하기
	$(frm).submit(function(e){
		e.preventDefault();
		if(!confirm("저장하시겠습니까?")) return;
		var scode=$(frm.scode).val();
		var sname=$(frm.sname).val();
		if(scode.length !=8){
			alert("학번을 8자리로 입력하세요!");
			$(frm.scode).focus();
		}else if(sname==""){
			alert("학생명을 입력하세요!");
			$(frm.sname).focus();
		}else{
			frm.submit();
		}
	});

</script>
</html>