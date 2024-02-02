<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/header.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/center.css" />
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
<body>
	<article id="wrap">
		<jsp:include page="../../head.jsp"></jsp:include>
		<div id="center">
			<jsp:include page="./leftList.jsp"></jsp:include>
			<div class="right">
				<div id="staffWrap">
					<div id="staffList_top">훈련생 현황</div>
					<table id="searchTime">
						<caption>과정검색</caption>
							<thead>
								<tr>
									<th>검색</th>
									<td>
										<select id="searchnum">
											<%-- 이값에따라 page.numPerPage값을 수정 해 주어야한다 --%>
											<option>표시개수</option>
											<option>5</option>
											<option>10</option>
											<option>15</option>
										</select>
										<select id="searchyear">
								
										</select>
									</td>
									<td>
										<select id="searchType">
												<option value="1">담당교수</option>
												<option value="2">과정타입</option>
												<option value="3">과정명</option>
												<option value="4">훈련생명</option>
										</select>
										<input type="text" id="searchValue"/>
										<button type="button" id="search">검 색</button>
									</td>
								</tr>
							</thead>
						</table>
						<div id="result">
				<table id="makeTime">
				<caption>훈련현황 리스트</caption>
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
		
						<c:forEach var="vo2" items="${requestScope.ar }" varStatus="vs">
				<c:set var="num" value="${page.totalRecord - ((page.nowPage-1) * page.numPerPage) }"/>
					<tr>
						<td>${num-(vs.index)}</td>
						<td>${vo2.c_name}</td>
						<%-- 강사 코드에따른 강사를 가져오는 Bean을 만든다 --%>
						<td>${vo2.svo.sf_name}</td>
						<td>${vo2.start_date }</td>
						<td>${vo2.end_date }</td>
						<td>${vo2.c_day}</td>
						<td>${vo2.c_round_num }</td>
						<td>${vo2.c_peo_num}</td>
						<td>
						<input type="button" onclick="bt1('${vo2.c_idx}')" value="과정별 훈련생 현황">
						<input type="button" value="면접평가 결과표">
						</td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
			</div>
			</div>
		</div>
	</div>

	<form action="traineecurrentbt1" method="post" name="fff">
		<input type="hidden" name="type" value=""/>
		<input type="hidden" name="c_idx" value=""/>
		<input type="hidden" name="cPage" value="${param.cPage}"/>
	</form>
	

</article>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
	<script>
		let searchType="1";
		let searchValue="";
		let searchnum="";
		let searchyear="";
		$(function() {
			//$().removeClass("selected");
			$(".selected").removeClass("selected");
			$(".l_select").removeClass("l_selected");
			$("#thirdmenu").addClass("selected");
			$("#l_second").addClass("l_select");
			let now = new Date();	// 현재 날짜 및 시간
			let year = now.getFullYear();
			let str = "<option>년도선택</option>";
			
			for(let i=year+1; i>year-5; i--){
				str+= "<option value="+i+">"+i+"</option>";
			}
			$("#searchyear").html(str);
			
			$("#searchnum").change(function(){
				searchnum = $("#searchnum").val();
				console.log(searchnum);


				$.ajax({
					url: "tcsearch",
					type:"post",
					data: "num="+searchnum+"&select="+searchType+"&value="+searchValue+"&year="+searchyear+"&cPage=1",

				}).done(function(result){
					$("#result").html(result);

					
				});


								
			});

			$("#searchyear").change(function(){
				searchyear = $("#searchyear").val();

				$.ajax({
					url: "tcsearch",
					type:"post",
					data: "num="+searchnum+"&select="+searchType+"&value="+searchValue+"&year="+searchyear+"&cPage=1",


				}).done(function(result){
					$("#result").html(result);


				});
								
			});
			$("#search").click(function(){
				searchType = $("#searchType").val();
				searchValue = $("#searchValue").val();
				if(searchType == "4"){
					location.href="trainee_name?value="+searchValue
				
				}else{
					$.ajax({
						url: "tcsearch",
						type:"post",
						data: "num="+searchnum+"&select="+searchType+"&value="+searchValue+"&year="+searchyear+"&cPage=1",
					}).done(function(result){
						$("#result").html(result);

					});
				}
			});

		});
		
		function paging(str) {

			$.ajax({
				url: "tcsearch",
				type:"post",
				data: "num="+searchnum+"&select="+searchType+"&value="+searchValue+"&year="+searchyear+"&cPage="+str,
			}).done(function(result){
				$("#result").html(result);
			});
			
		}

		function bt1(c_idx){
			//console.log(c_idx);
			document.fff.type.value="traineecurrentbt1";
			document.fff.c_idx.value=c_idx;
			//console.log(document.fff.type.value);
			document.fff.submit();

		}
		
	</script>
</body>

</html>