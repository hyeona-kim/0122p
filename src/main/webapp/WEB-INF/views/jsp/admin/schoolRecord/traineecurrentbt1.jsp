<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/jsp/css/header.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/jsp/css/center.css" />
 <link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
<style>
table tfoot ol.page {
	    list-style:none;
	}
	
	table tfoot ol.page li {
	    float:left;
	    margin-right:8px;
	}
	
	table tfoot ol.page li a {
	    display:block;
	    padding:3px 7px;
	    border:1px solid #00B3DC;
	    color:#2f313e;
	    font-weight:bold;
	    text-decoration: none;
	}
	
	table tfoot ol.page li a:hover {
	    background:#00B3DC;
	    color:white;
	    font-weight:bold;
	}
	.disable {
	    padding:3px 7px;
	    border:1px solid silver;
	    color:silver;
	}
	
	.now {
	   padding:3px 7px;
	    border:1px solid #ff4aa5;
	    background:#ff4aa5;
	    color:white;
	    font-weight:bold;
	}
	#staffWrap{
		width: 95%;
		margin: auto;
		margin-top: 20px;
	}
	#staffList_top {
		background: black;
		color: white;
		height: 40px;
		line-height: 40px;
	}
	
	#searchTime, #makeTime{
		margin-top:10px;
		border-collapse: collapse;
		width: 100%;
	}
	#searchTime td, #searchTime th, #makeTime td, #makeTime th{
		border: 1px solid #ddd;
		height: 40px;
		padding-left: 10px;
	}
	#searchTime th, #makeTime th{background-color: #ddd;}
	
	#searchTime caption, #makeTime caption{
		text-indent: -9999px;
		height: 0;
	}
</style>

</head>
<c:if test="${tvo eq null }">
<body>
	<article id="wrap">
		<jsp:include page="../../head.jsp"></jsp:include>
		<div id="center">
			<jsp:include page="./leftList.jsp"></jsp:include>
			<div class="right">
				<div id="staffWrap">
					<div id="staffList_top">훈련생현황</div>
					<table id="searchTime">
						<caption>훈련생확인서류검색</caption>
							<thead>
								<tr>
									<th>｜"훈련과정테스트" 과정 (교육기간 : 2024년 12월 30일 ~ 2024년 12월 30일)</th>
								</tr>
							</thead>
						</table>
						<div id="b1">
							<input type="button" value="면접평가표등록">
							<input type="button" value="교육생일괄삭제">
							<input type="button" value="교육생상태 일괄수정">
						</div>
				<table id="makeTime">
				<caption>훈련생확인서류 리스트</caption>
					<thead>
						<tr>
							<th><input type="checkbox">선택</th>
							<th>번호</th>
							<th>이미지</th>
							<th>학생코드</th>
							<th>이름</th>
							<th>연락처</th>
							<th>주민번호</th>
							<th>상태</th>
							<th>사유 및 날짜</th>
							<th>관리</th>
						</tr>
					</thead>
					<tfoot>
						<tr>
							<td colspan="10">
								<ol class="page">
			<c:if test="${requestScope.page.startPage < requestScope.page.pagePerBlock }">
            <li class="disable">&lt;</li>
         </c:if>   
   
         <c:if test="${requestScope.page.startPage >= requestScope.page.pagePerBlock }">
            <li><a href="javascript:paging('${page.startPage-page.pagePerBlock }')">&lt;</a></li>
         </c:if>

         <c:forEach begin="${page.startPage }" end="${page.endPage }" varStatus="vs">
            <c:if test="${vs.index eq page.nowPage }">
               <li class="now">${vs.index }</li>
            </c:if>
            <c:if test="${vs.index ne page.nowPage }">
               <li><a onclick="paging('${vs.index}')">${vs.index}</a></li>
            </c:if>
         </c:forEach>
   
         <c:if test="${page.endPage < page.totalPage }">
            <li><a href="javascript:paging('${page.startPage + page.pagePerBlock }')">&gt;</a></li>
         </c:if>
         <c:if test="${page.endPage >= page.totalPage }">
            <li class="disable">&gt;</li>   
         </c:if>
                              </ol>
                          </td>
						</tr>
					</tfoot>
					<tbody>
		
						<c:forEach var="vo7" items="${requestScope.ar }" varStatus="vs">
				<c:set var="num" value="${page.totalRecord - ((page.nowPage-1) * page.numPerPage) }"/>
					<tr>
						<td><input type="checkbox"></td>
						<!-- 학생에 대한 정보 입력  -->
						<td>${num+(vs.index) }</td>
						<td><!-- 이미지 --></td>
						<td><!-- 학생코드 --></td>
						<td>${vo7.tr_name }</td>
						<td>${vo7.tr_hp }</td>
						<td>${vo7.tr_rrn }</td>
						<td><!-- 상태 -->
							<select name="status">
								<option value="수강" >수강</option>
								<option value="비수강" >비수강</option>
							</select>
						</td>
						<td><!-- 사유및날짜 --></td>
						<td>
						<input type="button" id="fset"  onclick="" value="정보수정">
						<input type="button" id="fset"  onclick="" value="신상기록부">
						<input type="button" id="fset"  onclick="" value="서류관리">
						<input type="button" id="fset"  onclick="" value="상담일지">
						<input type="button" id="fset"  onclick="" value="사후관리">
						<input type="button" id="fset"  onclick="" value="면접평가표">
						</td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
			</div>
		</div>
	</div>
	<div id="m1" hidden="hidden"></div>
	
</article>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
	 <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
	<script>
		$(function() {
			//$().removeClass("selected");
			$(".selected").removeClass("selected");
			$(".l_select").removeClass("l_selected");
			$("#thirdmenu").addClass("selected");
			$("#l_four").addClass("l_select");

		
			
		});
		
	/* function set(str){
		$.ajax({
            url: "Controller",
            type: "post",
            data:"type="+encodeURIComponent("confirm")+"&select="+str
         }).done(function(result){
            $("#m1").html(result);
         });
         
		$( "#m1" ).dialog({
				width:700,
            	height:600
		});

	} */
		
    function paging(str) {
        location.href="Controller?type=traincurrent&cPage="+str
     }
		
		
		
	</script>
</body>
</c:if>

</html>