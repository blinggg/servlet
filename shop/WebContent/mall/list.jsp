<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>쇼핑몰</title>
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
<link rel="stylesheet" href="../home.css" />
</head>
<body>
   <div id="divPage">
      <div id="divMenu"><jsp:include page="../menu.jsp" /></div>
      <div id="divHeader">
         <h2>업 체 목 록</h2>
      </div>
      <div id="divCondition">
         <div id="divSearch">
            <select id="selKey">
               <option value="mall_id">업체코드</option>
               <option value="mall_name">업체명</option>
               <option value="address">주소</option>
            </select> <input type="text" id="txtWord"> <select id="selPerPage">
               <option value="3">3행</option>
               <option value="5">5행</option>
               <option value="10">10행</option>
            </select> <input type="button" id="btnSearch" value="검색"> <span
               style="font-size: 12px;">검색수: <b id="count"></b>건
            </span>
         </div>
         <div id="divSort">
            <select id="selOrder">
               <option value="mall_id">업체코드</option>
               <option value="mall_name">업체명</option>
               <option value="address">주소</option>
            </select> <select id="selDesc">
               <option value="">오름차순</option>
               <option value="desc">내림차순</option>
            </select>
         </div>
      </div>
      <table id="tbl"></table>
      <script id="temp" type="text/x-handlebars-template">
          <tr class="title">
             <td width=100>업체코드</td>
             <td width=100>업체명</td>
             <td width=300>주소</td>
             <td width=150>전화번호</td>
             <td width=150>이메일</td>
          </tr>
          {{#each array}}
          <tr class="row">
             <td>{{mall_id}}</td>
             <td>{{mall_name}}</td>
             <td>{{address}}</td>
             <td>{{tel}}</td>
             <td>{{email}}</td>
          </tr>
          {{/each}}
 </script>
      <div id="pagination">
         <button id="btnPre">◀</button>
         <button id="btnNext">▶</button>
         [<span id="curPage"></span>/<span id="totPage"></span>]
      </div>
   </div>
</body>
<script>
   var url = "/shop/mall/list";
</script>
<script src="../home.js"></script>
</html>