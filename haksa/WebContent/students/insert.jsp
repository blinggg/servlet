<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>학사관리시스템</title>
	<link rel="stylesheet" href="../home.css">
	<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
</head>
<body>
	<div id="divPage">
		<div id="divTop"><jsp:include page="../header.jsp"/></div>
		<div id="divCenter">
			<div id="divMenu"><jsp:include page="../menu.jsp"/></div>
			<div id="divContent">
			<!--여기에 내용출력 시작---------------------------- -->
			<div id="divHeader"><h2>학 생 등 록</h2></div>
			<form name="frm">
				<table>
					<tr>
						<td class="title" width=100>학생번호</td>
						<td width=300><input type="text" name="scode" maxlength=8 value="91414033" size=5></td>
						<td class="title" width=100>학생이름</td>
						<td width=300><input type="text" name="sname" value="홍길동" size=5></td>
					</tr>
					<tr>
						<td class="title" width=100>학생학과</td>
						<td width=300>
							<select name="dept">
								<option value="전산">전산학과</option>
								<option value="전자">전자학과</option>
								<option value="건축" selected>건축학과</option>
							</select>
						</td>
						<td class="title" width=100>생년월일</td>
						<td width=300>
							<input type="text" name="yy" size=2 placeholder="yyyy" maxlength=4>년 
							<input type="text" name="mm" size=1 placeholder="mm" maxlength=2>월 
							<input type="text" name="dd" size=1 placeholder="dd" maxlength=2>일 
						</td>
					</tr>	
					<tr>
						<td class="title" width=100>학생학년</td>
						<td width=300>
							<input type="radio" name="year" value="1" checked>1학년
							<input type="radio" name="year" value="2">2학년
							<input type="radio" name="year" value="3">3학년
							<input type="radio" name="year" value="4">4학년
						</td>
						<td class="title" width=100>지도교수</td>
						<td width=300>
							<input type="text" name="pcode" size=2 readonly>
							<input type="text" name="pname" size=5 readonly>
						</td>
					</tr>						
				</table>
				<div id="pagination">
					<input type="button" value="저장" id="btnInsert">
					<input type="reset" value="취소">
				</div>
			</form>
			<!--여기에 내용출력 종료---------------------------- -->
			</div>
		</div>
		<div id="divBottom"><jsp:include page="../footer.jsp"/></div>
	</div>
</body>
<script>
	$("#btnInsert").on("click", function(){
		if(!confirm("저장하시겠습니까?")) return;
		var scode=$(frm.scode).val();
		var sname=$(frm.sname).val();
		var dept=$(frm.dept).val();
		var year=$('input[name="year"]:checked').val();
		var birthday=$(frm.yy).val()+"-"+$(frm.mm).val()+"-"+$(frm.dd).val();
		var advisor=$(frm.pcode).val();
		
		var fmtDate = /^(19|20)\d{2}-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[0-1])$/;
		if(scode==""||sname==""||birthday==""||advisor==""){
			alert("학번, 학생이름을 입력하세요!");
			return;
		}else if(!fmtDate.test(birthday)){
			alert("날짤를 yyyy-mm-dd 형식으로 입력해 주세요!");
			return;
		}
		
		$.ajax({
			type:"post",
			url:"insert",
			data:{"scode":scode,"sname":sname,"dept":dept,"year":year,"advisor":advisor,"birthday":birthday},
			dataType:"json",
			success:function(data){
				if(data.count==0){
					alert("등록되었습니다.");
					location.href="list.jsp";
				}else{
					alert("이미 사용된 학번입니다.");
					$(frm.scode).focus();
				}
			}
		});
		
	});
	
	$(frm.pcode).on("click", function(){
		window.open("/haksa/professors/listAll.jsp","","width=320,height=300,top=200,left=900");
	});
</script>
</html>






