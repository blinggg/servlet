<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>   
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>학사관리시스템</title>
	<link rel="stylesheet" href="../home.css">
	<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
</head>
<body>
	<div id="divPage">
		<div id="divTop"><jsp:include page="../header.jsp"/></div>
		<div id="divCenter">
			<div id="divMenu"><jsp:include page="../menu.jsp"/></div>
			<div id="divContent">
			<!--여기에 내용출력 시작---------------------------- -->
			<div id="divHeader"><h2>학 생 정 보</h2></div>
			<form name="frm">
				<table>
					<tr>
						<td class="title" width=100>학생번호</td>
						<td width=280><input type="text" name="scode" maxlength=8 value="${vo.scode}" size=5 readonly></td>
						<td class="title" width=100>학생이름</td>
						<td width=300><input type="text" name="sname" value="${vo.sname}" size=5></td>
					</tr>
					<tr>
						<td class="title" width=100>학생학과</td>
						<td width=280>
							<select name="dept">
								<option value="전산" <c:out value="${vo.dept=='전산'?'selected':''}"/>>전산학과</option>
								<option value="전자" <c:out value="${vo.dept=='전자'?'selected':''}"/>>전자학과</option>
								<option value="건축" <c:out value="${vo.dept=='건축'?'selected':''}"/>>건축학과</option>
							</select>
						</td>
						<td class="title" width=100>생년월일</td>
						<td width=300>
							<input type="text" name="yy" size=2 placeholder="yyyy" maxlength=4 value="${fn:substring(vo.birthday,0,4)}">년 
							<input type="text" name="mm" size=1 placeholder="mm" maxlength=2 value="${fn:substring(vo.birthday,5,7)}">월 
							<input type="text" name="dd" size=1 placeholder="dd" maxlength=2 value="${fn:substring(vo.birthday,8,10)}">일 
							<input type="hidden" name="birthday">
						</td>
					</tr>	
					<tr>
						<td class="title" width=100>학생학년</td>
						<td width=280>
							<input type="radio" name="year" value="1" <c:out value="${vo.year=='1'?'checked':''}"/>>1학년
							<input type="radio" name="year" value="2" <c:out value="${vo.year=='2'?'checked':''}"/>>2학년
							<input type="radio" name="year" value="3" <c:out value="${vo.year=='3'?'checked':''}"/>>3학년
							<input type="radio" name="year" value="4" <c:out value="${vo.year=='4'?'checked':''}"/>>4학년
						</td>
						<td class="title" width=100>지도교수</td>
						<td width=300>
							<input type="text" name="pcode" value="${vo.advisor}" size=2 readonly>
							<input type="text" name="pname" value="${vo.pname}"size=5 readonly>
						</td>
					</tr>						
				</table>
				<div id="pagination">
					<input type="button" value="저장" id="btnInsert">
					<input type="reset" value="취소">
					<input type="button" value="삭제" id="btnDelete">
				</div>
			</form>
			<div id="divHeader"><h2>수 강 신 청</h2></div>
			<table>
				<tr>
					<td class="title" width=100>
						수강신청과목
					</td>
					<td width=700>
						<select id="lcode">
							<c:forEach items="${clist}" var="vo">
								<option value="${vo.lcode}" lname="${vo.lname}">${vo.lcode}:${vo.lname}:${vo.pname}</option>
							</c:forEach>
						</select>
						<button id="btnEnroll">수강신청</button>
					</td>	
				</tr>
			</table>
			<table id="tbl"></table>
			<script id="temp" type="text/x-handlebars-template">
 				<tr class="title">
 					<td width=70>강좌번호</td>
 					<td width=160>강좌이름</td>
 					<td width=120>수강신청일</td>
 					<td width=130>담당교수</td>
 					<td width=100>강의실</td>
 					<td width=100>강의시수</td>
					<td width=70>수강취소</td>
 				</tr>
 				{{#each array}}
 				<tr class="row">
 					<td class="lcode">{{lcode}}</td>
 					<td class="lname">{{lname}}</td>
 					<td class="edate">{{edate}}</td>
 					<td class="pname">{{pname}}</td>
 					<td class="room">{{room}}</td>
 					<td class="hours">{{hours}}</td>
					<td><button>수강취소</button></td>
 				</tr>
 				{{/each}}
 			</script>
			<!--여기에 내용출력 종료---------------------------- -->
			</div>
		</div>
		<div id="divBottom"><jsp:include page="../footer.jsp"/></div>
	</div>
</body>
<script>
	var scode="${vo.scode}";
	getList();
	
	$("#tbl").on("click", ".row button", function(){
		var lcode=$(this).parent().parent().find(".lcode").html();
		var lname=$(this).parent().parent().find(".lname").html();
		if(!confirm(lname + " 강좌를 수강취소하시겠습니까?")) return;
		$.ajax({
			type:"post",
			url:"/haksa/ec/delete",
			data:{"scode":scode,"lcode":lcode},
			success:function(){
				alert(lname + " 강좌가 수강취소되었습니다.");
				getList();
			}
		});
	});
	
	$("#btnEnroll").on("click", function(){
		var lcode=$("#lcode").val();
		var lname=$("#lcode option:selected").attr("lname");
		if(!confirm(lname + " 강좌를 신청하시겠습니까?")) return;
		$.ajax({
			type:"post",
			url:"/haksa/ec/insert",
			data:{"scode":scode, "lcode":lcode},
			dataType:"json",
			success:function(data){
				if(data.count==1){
					alert("이미 신청한 강좌입니다.");
				}else{
					alert("수강신청되었습니다.");
					getList();
				}
			}
		});	
	});
	
	function getList(){
		$.ajax({
			type:"get",
			url:"/haksa/ec",
			data:{"scode":scode},
			dataType:"json",
			success:function(data){
				var template = Handlebars.compile($("#temp").html());
		 		$("#tbl").html(template(data));
			}
		});	
	}
	
	$("#btnDelete").on("click", function(){
		if(!confirm(scode + " 학생을 삭제하시겠습니까?")) return;	
		$.ajax({
			type:"post",
			url:"delete",
			data:{"scode":scode},
			dataType:"json",
			success:function(data){
				if(data.count==0){
					alert("삭제되었습니다.");
					location.href="list.jsp";
				}else{
					alert("수강신청 데이타가 있어 삭제할수 없습니다.");
				}
			}
		});
	});
	
	$("#btnInsert").on("click", function(){
		if(!confirm("수정하시겠습니까?")) return;
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
			url:"update",
			data:{"scode":scode,"sname":sname,"dept":dept,"year":year,"advisor":advisor,"birthday":birthday},
			success:function(){
				alert("수정되었습니다.");
				location.href="list.jsp";
			}
		});
	});
	
	$(frm.pcode).on("click", function(){
		window.open("/haksa/professors/listAll.jsp","adivor","width=320,height=300,top=200,left=900");
	});
</script>
</html>






