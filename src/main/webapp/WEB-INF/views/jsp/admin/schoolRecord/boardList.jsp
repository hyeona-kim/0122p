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
	}
	table#boList thead tr:last-child td {
		border: none;
	}
	#bo_add_btn{
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
	#addForm, #board_list{
		text-align: center;
		margin: 0px auto;
		padding: 10px;
		width: 98%;
	}
	#addForm table caption, #board_list table caption{ text-indent: -9999px; }
	
	#addForm table, #board_list table{
		width: 100%;
		border-collapse: collapse;
	}
	#addForm table th, #board_list table th{
		background: #eee;
	}
	
	#addForm table th,#addForm table td, #board_list table th, #board_list table td{
		border: 1px solid #e9e9e6;
		padding: 5px;
	}
	
	#addForm .left, #board_list .left{
		text-align: left;
	}
	#addForm th, #board_list th{
		width: 20px;
	}
	#addForm .input, #board_list .input{
		width: 350px;
	}
	#addForm tfoot td, #board_list tfoot td{
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
					<div id="boList_top">과정별 게시판</div>
	
						<%-- ===== 검색하는 부분 ===== --%>
						<table id="boList">
							<caption>게시판 테이블</caption>
							<thead>	
								<tr>
									<th>검색</th>
									<td>
										<select  id="search_tag">
											<option value="subject">제목</option>
											<option>작성자</option>
										</select>
										<input type="text"  id="search_value"/>
										<button type="button" id="search_btn" onclick="searchBoard()">검색</button>
									</td>
									<th colspan="2">전체공지</th>
									<td colspan="2">
										<input type="checkbox" id="chk_btn" onchange="checkNotice()"/>숨김
									</td>
								</tr>
								<tr><td colspan="6" align="right"><button type="button" id="bo_add_btn" onclick="add_btn_click('${param.c_idx}')">글쓰기</button></td></tr>
							</thead>
						</table>
						<%-- ===== 검색하는 부분 ===== --%>
						
						<%-- ===== 비동기식으로 표현할 게시글 목록 시작 ===== --%>
						<div id="board_list">
							
						</div>
						<%-- ===== 비동기식으로 표현할 게시글 목록 끝 ===== --%>

						<%-- ===== 게시글 작성 폼 시작 ===== --%>
						<div id="addForm">
						
						</div>
						<%-- ===== 게시글 작성 폼 끝 ===== --%>

						<%-- ===== 게시글 내용 시작 ===== --%>
						<div id="boContent">
						
						</div>
						<%-- ===== 게시글 내용 끝 ===== --%>
						
						<%-- ===== 게시글 답변 작성 폼 시작 ===== --%>
						<div id="replyForm">
						
						</div>
						<%-- ===== 게시글 답변 작성 폼 끝 ===== --%>
				</div>
			</div>
		</div>
	</article>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
	<script>
	
		$(function() {
			//$().removeClass("selected");
			/* 처음 게시판을 클릭했을 때
				 비동기식통신을 수행해 전체 목록을 가져온다 */
			$.ajax({
					url: "boardListAjax",
					type: "post",
				}).done(function(result){
					$("#board_list").html(result);
				});
			$(".selected").removeClass("selected");
			$(".l_select").removeClass("l_selected");
			$("#thirdmenu").addClass("selected");
			$("#l_five").addClass("l_select");
			
			/* 목록에서 [글쓰기]버튼을 클릭했을 때 수행 */
			/* $("#bo_add_btn").bind("click", function(){
				$.ajax({
					url: "addBoardAjax",
					type: "post",
				}).done(function(result){
					$("#addForm").html(result);
				});
				
				$("#addForm").dialog({
					title : '게시글 작성',
					modal : true,
					width : 1000,
					height : 600
				});
			}); */
			
		});
		
		/* 목록에서 [글쓰기]버튼을 클릭했을 때 수행 */
		function add_btn_click(c_idx){
			console.log("add="+c_idx);
			$.ajax({
				url: "addBoardAjax",
				type: "post",
				data: "c_idx="+c_idx,
			}).done(function(result){
				$("#addForm").html(result);
			});
			
			$("#addForm").dialog({
				title : '게시글 작성',
				modal : true,
				width : 1000,
				height : 600
			});
		};
		
		/* 목록 아래 [page번호]를 클릭할 때 수행
		 str를 변수로 가지고 새롭게 비동기통신을 해서
		 테이블을 표현한다 */
		function paging(str) {
			$.ajax({
				url: "boardListAjax",
				type: "post",
				data: "cPage="+str
			}).done(function(result){
				$("#board_list").html(result);
			});
		}
		
		/* 게시글 작성 폼에서 [등록] 버튼을 눌렀을때 수행 */
		function addBoard() {
			// 유효성 검사 해야함
			
			document.forms[0].submit();
		};
		
		
		/* 글의 제목을 클릭했을 때 내용 보기 */
		function viewContent(bd_idx) {
			$.ajax({
				url: "boardViewAjax",
				type: "post",
				data: "bd_idx="+bd_idx
			}).done(function(result){
				$("#boContent").html(result);
			});
			
			$("#boContent").dialog({
				title : '게시글 보기',
				modal : true,
				width : 1000,
				height : 600
			});
		};
		/* 게시글 보기화면에서 [답변]을 눌렀을때 수행 */
		function reply(idx) {
			$.ajax({
				url: "boardReplyAjax",
				type: "post",
				data: "bd_idx="+idx
			}).done(function(result){
				$("#replyForm").html(result);
			});
			
			$("#replyForm").dialog({
				title : '게시판 답변 작성',
				modal : true,
				width : 1000,
				height : 600
			});
		};
		
		
		/* 답변 작성에서 [등록]을 눌렀을때 수행 */
		function addReply(frm) {
			frm.submit();
		};
		
		/* 게시글 목록에서 [검색]을 눌렀을때 수행 */
		function searchBoard(cPage) {
			let value = document.getElementById("search_value").value;
			$.ajax({
				url: "searchBoard",
				type: "post",
				data: "cPage="+encodeURIComponent(cPage)+
					  "&value="+encodeURIComponent(value)
			}).done(function(result){
				$("#board_list").html(result);
			});
		};

		function checkNotice(cPage) {
			let checked = $("#chk_btn").is(':checked');
			if(checked) {
				$.ajax({
					url: "checkNotice_board",
					type: "post",
					data: "cPage="+encodeURIComponent(cPage),
				}).done(function(result) {
					$("#board_list").html(result);
				});
			}else if(!checked) {
				$.ajax({
					url: "boardListAjax",
					type: "post",
					data: "cPage="+encodeURIComponent('1'),
				}).done(function(result) {
					$("#board_list").html(result);
				});
			}
		};
	</script>
</body>
</c:if>
</html>