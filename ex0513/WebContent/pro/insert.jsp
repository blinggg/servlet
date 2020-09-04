<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>교수등록</title>
<STYLE>
	#tbl td{border:1px solid #515A5A;}
	.title{background:#76D7C4;}
	.row:hover{background:#1ABC9C;color:white;cursor:pointer;}
	#tbl{border-collapse:collapse;}
</STYLE>
<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
</head>
<body>
	<h1>교수등록</h1>
	<form name=frm action=insert method=post>
		<table id=tbl border=1 width=700>
			<tr>
				<td>교수번호</td>
				<td><input type=text name=pcode maxlength=3></td>
			</tr>
				<tr>
				<td>교수이름</td>
				<td><input type=text name=pname></td>
			</tr>
				<tr>
				<td>교수학과</td>
				<td>
					<select name=dept>
						<option>전자</option>
						<option>전산</option>
						<option selected>건축</option>
					</select>
				</td>
			</tr>
			<tr>
				<td>교수직급</td>
				<td>
					<input type=radio name=title value=정교수>정교수
					<input type=radio name=title value=부교수>부교수
					<input type=radio name=title value=조교수 checked>조교수
				</td>
			</tr>
			<tr>
				<td>임용일</td>
				<td><input type=date name=hiredate>	
			</tr>
			<tr>
				<td>급여</td>
				<td><input type=number name=salary>	
			</tr>
		</table>
		<input type=submit value=저장>
		<input type=reset value=취소>
		<input type=button value=목록 onClick="location.href='list'">
	</form>
</body>
<script>
	$(frm).submit(function(e){
		e.preventDefault(); //기본이벤트 방지 
		if(!confirm("저장하시겠습니까?")) return;
		var pcode=$(frm.pcode).val();
		var salary=$(frm.salary).val();
		var pname=$(frm.pname).val();
		//alert(pcode);
		
		if(pcode.length!=3){
			alert("교수코드를 다시 입력하세여!");
			$(frm.pcode).focus();
			
		}else if(pname==""){
			alert("이름을 입력하세요!");
			$(frm.pname).focus();
			
		}else if(salary==""){
			alert("급여를 입력하세요!");
			$(frm.salary).focus();
			
		}else{
			frm.submit();
		}
	});
</script>
</html>