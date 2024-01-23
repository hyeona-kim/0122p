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
	    width: 300px;
	    margin: auto;
	}
	
	table tfoot ol.page li {
	    float:left;
	    margin-right:8px;
	}
	
	table tfoot ol.page li a {
	    display:block;
	    padding:3px 7px;
	    color:gray;
	    font-weight:bold;
	    text-decoration: none;
	}
	
	table tfoot ol.page li a:hover {
		color:black;
	    font-weight:bold;
	}
	.disable {
	    padding:3px 7px;
	    color:white;
	}
	
	.now {
	   padding:3px 7px;
	    color:#46ade1;
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
					<div id="staffList_top">훈련생확인서류</div>
					<table id="searchTime">
						<caption>훈련생확인서류검색</caption>
							<thead>
								<tr>
									<th>검색</th>
									<td>
										<select>
											<option>년도선택</option>
											<c:forEach begin="2000" end="2024" var="year">
				     							  <option value="${year}">${year}</option>
				    						</c:forEach>
										</select>
									</td>
									<td>
										<select>
												<option>번호</option>
												<option>과정명</option>
												<option>담당교수</option>
												<option>개강일</option>
												<option>종료일</option>
												<option>요일</option>
												<option>회차</option>
												<option>모집인원</option>
										</select>
										<input type="text"/>
										<button type="button">검 색</button>
									</td>
								</tr>
							</thead>
						</table>
				<table id="makeTime">
				<caption>훈련생확인서류 리스트</caption>
					<thead>
						<tr>
							<th>번호</th>
							<th>과정명</th>
							<th>담당교수</th>
							<th>개강일</th>
							<th>종료일</th>
							<th>요일</th>
							<th>회차</th>
							<th>모집인원</th>
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
		
						<c:forEach var="vo4" items="${requestScope.ar }" varStatus="vs">
				<c:set var="num" value="${page.totalRecord - ((page.nowPage-1) * page.numPerPage) }"/>
					<tr>
						<td>${num+(vs.index-2)}</td>
						<td>${vo4.c_name}</td>
						<%-- 강사 코드에따른 강사를 가져오는 Bean을 만든다 --%>
						<td>${vo4.t_idx}</td>
						<td>${vo4.start_date }</td>
						<td>${vo4.end_date }</td>
						<td>${vo4.ti_idx}</td>
						<td>${vo4.c_round_num }</td>
						<td>${vo4.c_peo_num}</td>
						<td>
						<input type="button" id="fset"  onclick="set('${vo4.tn_idx}')" value="확인서류설정">
						<input type="button" value="확인서류보기">
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
		
	function set(str){
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

	}
		
	function paging(str) {
		location.href="Controller?type=trainconfirm&cPage="+str
	
	}
		
		
		
		
	</script>
</body>
</c:if>

</html>