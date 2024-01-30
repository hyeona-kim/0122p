<%@page import="com.ict.project.util.Paging"%>
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

	div#boList_top{
		background-color: black;
		padding: 5px;
		padding-left: 10px;
		color: white;
		font-weight: bold;
	}
	
	#boWrap{
		width: 95%;
		padding: 10px;
		margin: 0px auto;
	}
	table#boList{
		border-collapse: collapse;
		width: 98%;
		margin: 10px auto 0px auto;
		padding: 0px;
	}
	table#boList thead{
		text-align: center;
	}
	table#boList thead th, table#boList thead td{
		border: 1px solid #e9e9e6;
		padding: 5px;
	}
	table#boList thead th {
		background-color: #f0f0ef;
	}
	table#boList thead td {
		font-size: 13px;
	}
	table#boList caption{
		text-indent: -9999px;
		height: 0px;
	}/* 
	table#boList thead tr:last-child td {
		border: none;
	} */
	#search_btn, #board_btn, #bo_add_btn{
		background-color: #4cdbcf;
		border-radius: 3px;
		border: none;
		padding: 5px 7px;
		font-weight: bold;
		font-size: 14px;
		color: white; 
		text-decoration: none;
	}
	table#boList tbody{
		text-align: center;
	}
	table#boList tbody th, table#boList tbody td{
		border: 1px solid #e9e9e6;
		padding: 5px;
	}
	table#boList tbody th {
		background-color: #f0f0ef;
	}
	table#boList tbody td {
		font-size: 13px;
	}
	#addForm, #board_main_list{
		text-align: center;
		margin: 0px auto;
		padding: 10px;
		width: 98%;
	}
	#addForm table caption, #board_main_list table caption{ text-indent: -9999px; }
	
	#addForm table, #board_main_list table{
		width: 100%;
		border-collapse: collapse;
	}
	#addForm table th, #board_main_list table th{
		background: #eee;
	}
	
	#addForm table th,#addForm table td, #board_main_list table th, #board_main_list table td{
		border: 1px solid #e9e9e6;
		padding: 5px;
	}
	
	#addForm .left, #board_main_list .left{
		text-align: left;
	}
	#addForm th, #board_main_list th{
		width: 20px;
	}
	#addForm .input, #board_main_list .input{
		width: 350px;
	}
	#addForm tfoot td, #board_main_list tfoot td{
		border: none;
	}
	#boContent table caption{ text-indent: -9999px; }
	
	#boContent table {
		width: 950px;
		height: 450px;
		border-collapse: collapse;
		position: absolute;
		
	}
	#boContent table th, #boContent table td{
		border: 1px solid #e9e9e6;
		padding: 5px;
	}
	#boContent {
		text-align: center;
		margin: 0px auto;
		padding: 10px;
	}
	#boContent .left {
		text-align: left;
	}
	#boContent th{
		width: 20%;
	}
	#boContent tfoot td{
		border: none;
	}
	#replyForm table caption{ text-indent: -9999px; }
	#replyForm table {
		width: 950px;
		height: 450px;
		border-collapse: collapse;
		position: absolute;
		
	}
	#replyForm table th, #replyForm table td{
		border: 1px solid #e9e9e6;
		padding: 5px;
	}
	#replyForm {
		text-align: center;
		margin: 0px auto;
		padding: 10px;
	}
	#replyForm .left {
		text-align: left;
	}
	#replyForm th{
		width: 20%;
	}
	#replyForm tfoot td{
		border: none;
	}
	#notice{
		background-color: #e14b4b;
		border-radius: 3px;
		padding: 5px 7px;
		font-weight: bold;
		font-size: 14px;
		color: white; 
	}
	.bo_btn{
		display: inline-block;
		background-color: #cc1919;
		border-radius: 3px;
		border: none;
		padding: 5px 7px;
		font-weight: bold;
		font-size: 14px;
		color: white; 
		text-decoration: none;
	}
	.bo_list_btn{ background-color: #f0f0ef; }
	.bo_reply_btn{ background-color: #cc1919; }
	.bo_print_btn{ background-color: #1876c7; }
	.bo_edit_btn{ background-color: #1876c7; }
	.bo_del_btn{ background-color: #cc1919; }
	
	#trFirst{
		border-collapse: collapse;
		width: 100%;
		height: 20px;
		background-color: #dcdcdc;
	}
	</style>
</head>
<c:if test="${tvo eq null }">
<body>
	<article>
		<jsp:include page="${pageContext.request.contextPath }/WEB-INF/views/jsp/head.jsp"></jsp:include>
		<div id="center">
			<jsp:include page="./leftList.jsp"></jsp:include>
			<div class="right">
				<!--  여기서 표시될 테이블들 가지고오기 -->
				<div id="boWrap">
					<div id="boList_top">게시판</div>
	
						<%-- ===== 검색하는 부분 ===== --%>
						<table id="boList">
							<caption>게시판 검색 테이블</caption>
							<thead>	
								<tr>
									<th>검색</th>
									<td>
										<select id="search_year" onchange="searchBoth()">
											<option value="">년도선택</option>
											<option>2024</option>
											<option>2023</option>
											<option>2022</option>
											<option>2021</option>
											<option>2020</option>
											<option>2019</option>
											<option>2018</option>
										</select>
									</td>
									<td>
										<select id="search_tag">
											<option value="1">훈련강사</option>
                                            <option value="2">과정타입</option>
                                            <option value="3">과정명</option>
                                        </select>
                                        <input type="text" id="search_value"/>
                                        <button type="button" id="search_btn" onclick="searchBoth()">검색</button>
									</td>
								</tr>
							</thead>
						</table>
						<%-- ===== 검색하는 부분 ===== --%>
						
						<%-- ===== 비동기식으로 표현할 과정 목록 시작 ===== --%>
						<div id="board_main_list">
							
						</div>
						<%-- ===== 비동기식으로 표현할 과정 목록 끝 ===== --%>

						<%-- ===== 게시글 내용 시작 ===== --%>
						<div id="boContent">
						
						</div>
						<%-- ===== 게시글 내용 끝 ===== --%>
						
						<%-- ===== 게시글 답변 작성 폼 시작 ===== --%>
						<div id="replyForm">
						
						</div>
						<%-- ===== 게시글 답변 작성 폼 끝 ===== --%>

						<%-- ===== 게시글 작성 폼 시작 ===== --%>
						<div id="addForm">
							<input type="hidden" id="hidden_btn" value="'${param.c_idx}'"/>
						</div>
						<%-- ===== 게시글 작성 폼 끝 ===== --%>
				</div>
			</div>
		</div>
	</article>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
	<script>
		let search_year = "";
		let search_value = "";
		let search_tag = "";
		$(function() {
            // 처음 게시판에 들어왔을 때
            // 비동기식 통신을 이용해 과정의 내용들을 출력한다
				$.ajax({
					url: "boardCourseAjax",
					type: "post",
				}).done(function(result) {
					$("#board_main_list").html(result);
					console.log(result);
				});

			
        });

        /* 목록 아래 [page번호]를 클릭할 때 수행
		 str를 변수로 가지고 새롭게 비동기통신을 해서
		 테이블을 표현한다 */
		function paging(str) {
			$.ajax({
				url: "boardCourseAjax",
				type: "post",
				data: "cPage="+str
			}).done(function(result){
				$("#board_main_list").html(result);
			});
		};
		// ============================ 이 밑으로는 test중 ============================
		function test_viewBoardList(c_idx, cPage) {
			$.ajax({
				url: "test_viewBoardList",
				type: "get",
				data: "c_idx="+c_idx+
						"&cPage="+cPage,
			}).done(function(result){
				$("#board_main_list").html(result);
			});
		};

		function searchYear(cPage){
			search_year = document.getElementById("search_year").value;

			$.ajax({
				url: "searchYear",
				type: "post",
				data: "year="+encodeURIComponent(search_year)+
						"&cPage="+cPage+
						"&value="+encodeURIComponent(search_value),
			}).done(function(result){
				$("#board_main_list").html(result);
			});
		};
		
		function searchValue(cPage) {
			search_tag = document.getElementById("search_tag").value;
			search_value = document.getElementById("search_value").value;
			
			$.ajax({
				url: "searchValue",
				type: "post",
				data: "cPage="+cPage+
						"&value="+encodeURIComponent(search_value)+
						"&tag="+encodeURIComponent(search_tag),
			}).done(function(result){
				$("#board_main_list").html(result);
			});
		};
		
		function searchBoth(cPage) {
			search_year = document.getElementById("search_year").value;
			search_tag = document.getElementById("search_tag").value;
			search_value = document.getElementById("search_value").value;
			
			$.ajax({
				url: "searchBoth",
				type: "post",
				data: "cPage="+cPage+
				"&tag="+search_tag+
				"&value="+encodeURIComponent(search_value)+
				"&year="+search_year,
			}).done(function(result){
				$("#board_main_list").html(result);
			});
		};

	</script>
</body>
</c:if>
</html>