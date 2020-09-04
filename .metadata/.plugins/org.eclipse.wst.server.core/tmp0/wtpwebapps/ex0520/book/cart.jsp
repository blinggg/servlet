<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
   <meta charset="UTF-8">
   <title>장바구니</title>
   <link rel="stylesheet" href="../home.css"/>
</head>
<body>
   <div id="page">
      <div id="header"><jsp:include page="../header.jsp"></jsp:include></div>
      <div id="center">
         <div id="menu"><jsp:include page="../menu.jsp"></jsp:include></div>
         <div id="content">
           <!-- 여기부터 출력할 내용 작성시작 -->
            <h2>[장바구니]</h2>
            	<table width=700 id=cart>
            		<tr class=title>
            			<td width=100>코드</td>
            			<td width=300>제목</td>
            			<td width=100>가격</td>
            			<td width=50>수량</td>
            			<td width=50>수정</td>
            			<td width=100>금액</td>
            		</tr>
            		<c:forEach items="${listCart}" var="vo">
            			<tr class=row>
            				<td class=code>${vo.code}</td>
            				<td>${vo.title}</td>
            				<td class=price><fmt:formatNumber value="${vo.price}" pattern="#,###"/></td>
            				<td>
            				<input type=text class=number value="${vo.number}" size=2 style="height:17px;margin-right:5px;"></td>
            				<td><button>수정</button></td>
    						<td>${vo.price * vo.number}</td>
            			</tr>
            		</c:forEach>
            	</table>
            	<!-- 여기부터 출력할 내용 작성종료 -->
            <div>
            </div>
         </div>
      </div>
      <div id="footer"><jsp:include page="../footer.jsp"></jsp:include></div>
   </div>
</body>
<script>

	//수정버튼을 눌렀을 때
	$("#cart").on("click", " .row button", function(){
		var row=$(this).parent().parent();
		var code=row.find(".code").html();
		var number=row.find(".number").val();
		//alert(code+number);
		if(!confirm(code+"의 목록을"+number+" 개로 수정하시겠습니까?")) return;
		  $.ajax({
		         type:"post",
		         url:"/book/cartUpdate",
		         data:{"code":code, "number":number},
		         success:function(){
		            alert("수정되었습니다.");
		         }
		});
	});

</script>
</html>