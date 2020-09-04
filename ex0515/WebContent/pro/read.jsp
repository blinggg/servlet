<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>[교수정보]</title>
<STYLE>
	#ctbl td,#stbl td{border:1px solid #515A5A;text-align:center;}
	.title{background:#76D7C4;}
	.row:hover{background:#1ABC9C;color:white;cursor:pointer;}
	#stbl,#ctbl,#tbl{border-collapse:collapse;}
	#tbl{margin-botton:10px;} 
	#menu{width:500px;}
</STYLE>
<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script> 
</head>
<body>
<div><%@include file="../menu.jsp" %></div>
	<h1>교수정보</h1>
	<form name=frm action=update method=post>
		<table id=tbl border=1 width=500>
			<tr>
				<td>교수번호</td>
				<td><input type=text name=pcode maxlength=3 value="${vo.pcode}" readonly></td>
			</tr>
				<tr>
				<td>교수이름</td>
				<td><input type=text name=pname value="${vo.pname}"></td>
			</tr>
				<tr>
				<td>교수학과</td>
				<td>
					<select name=dept>
						<option <c:out value="${vo.dept.equals('전자')?'selected':''}"/>>전자</option>
						<option <c:out value="${vo.dept.equals('전산')?'selected':''}"/>>전산</option>
						<option <c:out value="${vo.dept.equals('건축')?'selected':''}"/>>건축</option>
					</select>
				</td>
			</tr>
			<tr>
				<td>교수직급</td>
				<td>
					<input type=radio name=title value=정교수 <c:out value="${vo.title.equals('정교수')?'checked':''}"/>>정교수
					<input type=radio name=title value=부교수 <c:out value="${vo.title.equals('부교수')?'checked':''}"/>>부교수
					<input type=radio name=title value=조교수 <c:out value="${vo.title.equals('조교수')?'checked':''}"/>>조교수
				</td>
			</tr>
			<tr>
				<td>임용일</td>
				<td><input type=text name=hiredate value="${vo.hiredate}">	
			</tr>
			<tr>
				<td>급여</td>
				<td><input type=number name=salary value="${vo.salary}">	
			</tr>
		</table>
		
		<input type=submit value=수정>
		<input type=button value=삭제 onClick="delete?pcode=${pcode}" id=btnDelete>
		<input type=reset value=취소>
		<input type=button value=목록 onClick="location.href='list'">
	</form>

	<div id=courses>
		<span id=pname></span>
		<h1>[담당과목]</h1>
		<table id=ctbl border=1 width=500></table>
		<script id="ctemp" type="text/x-handlebars-template">
			<tr class=title>
				<td>강좌코드</td>
				<td>강좌명</td>
				<td>강의시간수</td>
				<td>강의실</td>
				<td>이동</td>
			</tr>

			{{#each cArray}}
			<tr class=crow>
				<td class=lcode>{{lcode}}</td>
				<td>{{lname}}</td>
				<td>{{hours}}</td>
				<td>{{room}}</td>
				<td><button>강좌목록</button></td>
			</tr>
			{{/each}}
	</script>
	</div>
	<div id=students>
		<span id=lname></span>
		<h1>[수강하는 학생목록]</h1>
		<table id=stbl border=1 width=500></table>
		<script id="stemp" type="text/x-handlebars-template">
			<tr class=title>
				<td>학생코드</td>
				<td>학생명</td>
				<td>학생학과</td>
				<td>학년</td>
				<td>이동</td>
			</tr>

			{{#each sArray}}
			<tr class=srow>
				<td class=scode>{{scode}}</td>
				<td>{{sname}}</td>
				<td>{{dept}}</td>
				<td>{{year}}</td>
				<td><button>학생목록</button></td>
			</tr>
			{{/each}}
	</script>
	</div>		
</body>
<script>
var pcode="${vo.pcode}";

	//담당과목을 눌렀을 때
	$("#ctbl").on("click", ".crow button", function(){
		//alert(".");
		var crow=$(this).parent().parent();
		var lcode=crow.find(".lcode").html();
		//alert(lcode);
		location.href="/cou/read?lcode="+lcode;
	});
	
	//학생과목을 눌렀을 때
	$("#stbl").on("click", ".srow button", function(){
		//alert(".");
		var srow=$(this).parent().parent();
		var scode=srow.find(".scode").html();
		//alert(lcode);
		location.href="/stu/read?scode="+scode;
	});
	
	//특정교수의 강좌목록 및 학생목록 보이기
		$.ajax({
				type:"get",
				url:"/pro/cslist",
				data:{"pcode":pcode},
				dataType:"json",
				success:function(data){
					//alert(".");
					var temp=Handlebars.compile($("#ctemp").html());
			     	$("#ctbl").html(temp(data));
			     	
			     	var temp=Handlebars.compile($("#stemp").html());
			     	$("#stbl").html(temp(data));
			}
		});

	//삭제버튼을 눌렀을 때
	$("#btnDelete").on("click", function(){
		var pcode=${vo.pcode};
		if(!confirm(pcode+"을 삭제하시겠습니까?")) return;
		location.href="delete?pcode="+pcode;
	});
	
	$(frm).submit(function(e){
		e.preventDefault(); //기본이벤트 방지 
		if(!confirm("수정하시겠습니까?")) return;
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