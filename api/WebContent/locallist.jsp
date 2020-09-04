<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
<meta name="viewport" content="user-scalable=no, width=device-width" charset="euc-kr"/>
<link href="home_mobile.css" rel="stylesheet" type="text/css" media="screen and (max-width:799px)">
<link href="home.css" rel="stylesheet" type="text/css" media="screen and (min-width:800px)">
<title>장 소 검 색</title>
</head>
<body>
<div id=divPage>
	<div id=divMenu><jsp:include page="menu.jsp"/></div>
	<div id="divHeader">
			<h2>장 소 검 색</h2>
	</div>
	<div id=divCondition>

		<input type=text id="query" value=떡볶이>
		<input type=button value=검색 id=btnSearch>
		<select id="size">
			<option value="5">5행</option>
			<option value="10">10행</option>
		</select>
		검색건수:<span id="total"></span>
	</div>
		<table id="tbl"></table>
		<script id="temp" type="text/x-handlebars-template">
			<tr class=title>
				<td width=200>장소이름</td>
				<td>주소</td>
				<td>전화번호</td>
				<td>카테고리 이름</td>
				<td>위치보기</td>
			</tr>

		{{#each documents}}
			<tr class=row>
				<td><a href="{{place_url}}">{{{place_name}}}</td>
				<td><div class=address>{{address_name}}</div></td>
				<td><div class=phone>{{{phone}}}</div></td>
				<td>{{category_name}}</td>
				<td class=location><button x1={{x}} y1={{y}} place={{place_name}} phone={{phone}}>위치보기</button></td>
			</tr>
		{{/each}}

		</script>	
		<div id="pagination">
				<button id="btnPre">◀</button>
				<button id="btnNext">▶</button>
				[<span id="curPage"></span>/<span id="totPage"></span>]
		</div>
	</div>
	<!-- 지도출력 -->
   <div id="map"></div>

   <!-- 마우스커서 -->
   <div id="map" style="width:100%;height:350px;"></div>
	
	
</body>
<script>

	var query, page=1, size, total, is_end, totPage;
	getList();
	 
	$("#tbl").on("click",".row button",function(){
	    var x=$(this).attr("x1");
	    var y=$(this).attr("y1");
	    var place=$(this).attr("place");
	    var phone=$(this).attr("phone");
	    
	    $("#map").show();
	    var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
	    var options = { //지도를 생성할 때 필요한 기본 옵션
	       center: new kakao.maps.LatLng(y,x), //지도의 중심좌표.
	       level: 3 //지도의 레벨(확대, 축소 정도)   QAWSEDRFGTYHzXCVB   QWE2WE34R567890-=67890-=
	    }
	    ;
	    var marker = new kakao.maps.Marker({position:new kakao.maps.LatLng(y,x)});
	    var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴
	    marker.setMap(map);
	    
	    // 마커에 커서가 오버됐을 때 마커 위에 표시할 인포윈도우를 생성합니다
	    var iwContent = "<div style=padding:5px;>"+place+"<br>"+phone+"</div>"; 
	    // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
	
	    // 인포윈도우를 생성합니다
	    var infowindow = new kakao.maps.InfoWindow({
	        content : iwContent
	    });
	
	    // 마커에 마우스오버 이벤트를 등록합니다
	    kakao.maps.event.addListener(marker, 'mouseover', function() {
	      // 마커에 마우스오버 이벤트가 발생하면 인포윈도우를 마커위에 표시합니다
	        infowindow.open(map, marker);
	    });
	
	    // 마커에 마우스아웃 이벤트를 등록합니다
	    kakao.maps.event.addListener(marker, 'mouseout', function() {
	        // 마커에 마우스아웃 이벤트가 발생하면 인포윈도우를 제거합니다
	        infowindow.close();
	    });
	 });


	   $("#btnSearch").on("click",function(){
	      page=1;
	      getList();
	   });
	   
	   $("#display, #query").change(function(){
	      page=1;
	      getList();
	   });
	   
	   $("#btnNext").on("click",function(){
		      if(is_end==false){
		         page=page+1;
		         getList();
		      }else{
		         alert("마지막 페이지입니다!");
		      }
		   });
		   
		   $("#btnPre").on("click",function(){
		      if(page>1){
		         page=page-1;
		         getList();
		      }else{
		         alert("첫번째 페이지입니다!");
		      }
		   });

	   
	function getList(){
		query=$("#query").val();
		size=$("#size").val();
		$("#curPage").html(page);
		$.ajax({
			type:"get",
			url:"https://dapi.kakao.com/v2/local/search/keyword.json",
			headers:{"Authorization":"KakaoAK 8435c4ce5155ad1a2bb35e6227a1f65f"},
			dataType:"json",
			data:{"query":query,"page":page,"size":size},
			success:function(data){
				var template = Handlebars.compile($("#temp").html());
	            $("#tbl").html(template(data));
	            is_end=data.meta.is_end;
				
	             total=data.meta.total_count;
	             $("#total").html(total);
	             
	             if(total%size==0){
	                totPage=total/size;
	             }else{
	                totPage=parseInt(total/zise)+1;
	             }

	             $("#totPage").html(totPage);
	             

				}
			});		
		}
</script>
</html>