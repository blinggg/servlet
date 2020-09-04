<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쇼핑몰</title>
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
  <link rel="stylesheet" href="../home.css">
</head>
<body>
	<div id="divPage">
		<div id="divMenu"><jsp:include page="../menu.jsp" /></div>
		<!--내용 입력 시작 ---------------------- -->
		<div id="divHeader">
			<h2>상 품 정 보</h2>
		</div>
		<form name="frm" action="update" method="post" enctype="multipart/form-data"> <!-- 이밎 서브밋 -->
			<table id="tbl">
				<tr>
					<td class="title" width=100>상품코드</td>
					<td width=100><input type="text" name="prod_id" value="${vo.prod_id}" size=10></td>
					<td class="title" width=100>제조원/수입원</td>
					<td width=200><input type="text" name="company" value="${vo.company}" size=27></td>
					<td class="title" width=100>판매가격</td>
					<td width=100><input type="text" name="price1" value="${vo.price1}" size=10></td>
				</tr>
				<tr>
					<td class="title">업체코드</td>
					<td colspan=3><input type="text" name="mall_id" value="${vo.mall_id}"size=10>
					<input type="text" name="mall_name" size=47 value="${vo.mall_name}"></td>
					<td class="title">일반가격</td>
					<td><input type="text" name="price2" value="${vo.price2}" size=10></td>
				</tr>
				<tr>
				
					<td class="title">상품이름</td>
					<td colspan=3><input type="text" name="prod_name" value="${vo.prod_name}" size=70></td>
					<td class=title>판매상태</td>
					<td><input type="checkbox" name="prod_del" value=1 <c:out value="${vo.prod_del=='1'?'checked':''}"/>> 판매중지</td>
				</tr>
					
				<tr>
					<td class="title">상품이미지</td>
					<td colspan=5>
					<c:if test="${vo.image==null}"><img src="http://placehold.it/150x120" id="image" width=150 /></c:if>
					<c:if test="${vo.image!=null}"><img src="/img/product/${vo.image}" id="image" width=150/></c:if>
					<input type="file" name="image"accept="image/*" style="visibility:hidden;" value="${vo.image}"></td>
				</tr>
				<tr>
					<td class="title">상품설명</td>
					<td colspan=5><textarea rows="10" cols="100" name="detail">${vo.detail}</textarea></td>
				</tr>
			</table>
			<div id="pagination">
				<input type="submit" value="저장"> 
				<input type="reset" value="취소">
				<input type=button value=삭제 id=btnDelete>
			</div>
		</form>
		 <!--내용 입력 종료 ---------------------- -->
	</div>
</body>
<script>

	var prod_id="${vo.prod_id}";
	
	//삭제버튼을 눌렀을 때
	$("#btnDelete").on("click", function(){
		if(!confirm("상품을 삭제하시겠습니까?")) return;
		$.ajax({
			type:"get",
			url:"delete",
			data:{"prod_id":prod_id},
			dataType:"json",
			success:function(data){
				if(data.count==0){
					alert("삭제되었습니다.");
					location.href="list.jsp";
				}else{
					alert("구매자가 구매한 목록이 있으므로 삭제할 수 없습니다.");
				}
			}
		});
	});
	
	//상품정보를 수정할 때
	$(frm).submit(function(e){
		e.preventDefault();
		if(!confirm("상품정보를 수정하시겠습니까?")) return;
		frm.submit();
	});
	
	//판매상태를 수정할 때
	$(frm.prod_del).on("click", function(){
		if($(frm.prod_del).is(":checked")){
			alert("판매를 중지합니다.");
		}else{
			alert("판매중지를 해제합니다.");
		}
	});
		
	//업로드할 이미지 불러오기
	$("#image").on("click", function(){
		$(frm.image).click();	
	
	});
	
	//이미지 미리보기
	$(frm.image).on("change",function(e){
		var reader=new FileReader();
		reader.onload=function(e){
			$("#image").attr("src", e.target.result);
		}
		reader.readAsDataURL(this.files[0]);
	});
	
	
	//업체목록 불러오기
	$(frm.mall_id).on("click", function(){
		window.open('/shop/mall/listAll.jsp','mall','width=400,height=300,top=200,left=900');
	});
	
</script>
</html>