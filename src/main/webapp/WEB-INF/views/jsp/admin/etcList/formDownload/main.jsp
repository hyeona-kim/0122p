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
	#formDownWrap{
		width: 95%;
		padding: 10px;
		margin: 0px auto;
	}
	table caption{
		text-indent: -9999px;
		height: 0px;
	}
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
	table#formDownList{
		border-collapse: collapse;
		width: 98%;
		margin: 0px auto;
		padding: 0px;
	}
	table#formDownList tbody{
		text-align: center;
	}
	table#formDownList tbody th, table#formDownList tbody td{
		border: 1px solid #e9e9e6;
		padding: 5px;
	}
	table#formDownList tbody th {
		background-color: #f0f0ef;
	}
	table#formDownList tbody td {
		font-size: 13px;
	}
	table#formDownList caption{
		text-indent: -9999px;
		height: 0px;
	}
	table#formDownList thead td{
		text-align: right;
		border: none;
		padding: 8px 0px;
	}
	div#formDownList_top{
		background-color: black;
		padding: 5px;
		padding-left: 10px;
		color: white;
		font-weight: bold;
	}
	#search_btn, #form_add_btn{
		background-color: #4cdbcf;
		border-radius: 3px;
		border: none;
		padding: 5px 7px;
		font-weight: bold;
		font-size: 14px;
		color: white; 
		text-decoration: none;
	}
	#mainAjax{
		text-align: center;
		margin: 0px auto;
		padding: 10px;
		width: 98%;
	}
	#mainAjax table caption{ text-indent: -9999px; }
	
	#mainAjax table{
		width: 100%;
		border-collapse: collapse;
	}
	#mainAjax table th{
		background: #eee;
	}
	#mainAjax table th, #mainAjax table td{
		border: 1px solid #e9e9e6;
		padding: 5px;
	}
	#mainAjax th{
		width: 20px;
	}
	#mainAjax tfoot td{
		border: none;
	}
	#addFormAjax table, #editFormAjax table {
		border-collapse: collapse;
		position: absolute;
		width: 95%;
		padding: 5px auto;
	}
	#addFormAjax table th, #addFormAjax table td, #editFormAjax table th, #editFormAjax table td{
		border: 1px solid #e9e9e6;
		padding: 5px;
	}
	#addFormAjax, #editFormAjax {
		text-align: center;
		margin: 0px auto;
		padding: 10px;
	}
	#addFormAjax th, #editFormAjax th{
		width: 20%;
	}
	#addFormAjax table tbody tr, #editFormAjax table tbody tr{
		width: 90%;
	}
	#addFormAjax tfoot td, #editFormAjax tfoot td{
		border: none;
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
	.left {	text-align: left; }
	.input { width: 450px; }
	.form_btn{
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
	.form_edit_btn{ background-color: #1876c7; }
	.form_del_btn{ background-color: #cc1919; }
</style>
</head>
<c:if test="${tvo eq null }">
<body>
	<article>
		<jsp:include page="${pageContext.request.contextPath }/WEB-INF/views/jsp/head.jsp"></jsp:include>
		<div id="center">
			<jsp:include page="../leftList.jsp"></jsp:include>
			<div class="right">
				<!--  여기서 표시될 테이블들 가지고오기 -->
				<div id="formDownWrap">
					<div id="formDownList_top">서식 자료실</div>
					<table id="formDownList">
						<colgroup>
							<col width="40%">
							<col width="60%">
						</colgroup>
						<caption>서식 자료실 검색 테이블</caption>
						<%-- ===== 검색하는 부분 ===== --%>
						<thead>
							<tr>
								<td align="left">
                                    <label for="viewNum">표시개수</label>
									<select id="viewNum" onchange="changeViewNum()">
										<option>10</option>
										<option>20</option>
										<option>30</option>
									</select>
                                    <select>
                                        <option>제목</option>
                                    </select>
									<input type="text" id="search_value"/>
									<button type="button" id="search_btn" onclick="searchFormDown()">검색</button>
								</td>
                                <td align="right"><button type="button" id="form_add_btn">서식파일 등록</button></td>
							</tr>
						</thead>
					</table>
					<%-- ===== 비동기식 통신으로 출력할 테이블 시작 ===== --%>
					<div id="mainAjax">
						
					</div>
					<%-- ===== 비동기식 통신으로 출력할 테이블 끝 ===== --%>
					<%-- ===== 서식파일 등록 테이블 시작 ===== --%>
                    <div id="addFormAjax">
                    
                    </div>
					<%-- ===== 서식파일 등록 테이블 끝 ===== --%>
					<%-- ===== 수정 테이블 시작 ===== --%>
                    <div id="editFormAjax">
                    
                    </div>
					<%-- ===== 수정 테이블 끝 ===== --%>
				</div>
			</div>
		</div>
	</article>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
	<script>
		$(function() {
			$(".selected").removeClass("selected");
			$(".l_select").removeClass("l_selected");
			$("#etclist").addClass("selected");
			$("#l_third").addClass("l_select");
			
			$("#addFormAjax").dialog({
				title: '서식파일 등록',
				autoOpen: false,
				modal: true,
				width: 800,
				height: 210
			});

			$("#editFormAjax").dialog({
				title: '서식파일 수정',
				autoOpen: false,
				modal: true,
				width: 800,
				height: 210
			});

			// 처음 메인 페이지로 왔을때
			// 비동기식 통신을 이용해 전체목록을 출력한다
			$.ajax({
				url: "formMainAjax",
				type: "post",
			}).done(function(result) {
				$("#mainAjax").html(result);
			});

			// [서식파일 등록]을 클릭했을 때 수행하는 곳
			$("#form_add_btn").on("click", function(){
				$.ajax({
					url: "addFormDownAjax",
					type: "post",
				}).done(function(result){
					$("#addFormAjax").html(result);
					$("#addFormAjax").dialog("open");
				});	
			});
		});
		
		// [검색]을 클릭했을 때 수행하는 곳
		function searchFormDown(cPage) {
			let value = document.getElementById("search_value").value;
			$.ajax({
				url: "searchFormDown",
				type: "post",
				data: "fd_subject="+encodeURIComponent(value)+
						"&cPage="+cPage
			}).done(function(result){
				$("#mainAjax").html(result);
			})
		};

		function editFormDown(idx) {
			$.ajax({
				url: "editFormDownAjax",
				type: "post",
				data: "fd_idx="+idx,
			}).done(function(result){
				$("#editFormAjax").html(result);
				$("#editFormAjax").dialog("open");
			});
		};
		
		// 서식파일 등록에서 [저장]을 클릭했을 때
		// 또는 서식파일 수정에서 [수정]을 클릭했을 때 수행하는 곳
		function addFormDown(frm) {
			if(frm.fd_subject.value.trim() == 0){
				alert(frm.fd_subject.dataset.str+"을 입력하세요");
				frm.fd_subject.focus();
				return; // 수행 중단
			};
			frm.submit();
		};

		// [취소]을 클릭했을 때 켜져있는 dialog를 끄는 기능
		function closeDialog() {
			if($("#addFormAjax").dialog("isOpen")) {
				$("#addFormAjax").dialog("close");
			}
			if($("#editFormAjax").dialog("isOpen")) {
				$("#editFormAjax").dialog("close");
			}
		};

		// [삭제]를 클릭했을 때 수행하는 곳
		function deleteFormDown(idx) {
			if(confirm("삭제하시겠습니까?")){
				location.href="deleteFormDown?fd_idx="+idx;
			}else{
				return false;
			}
		};

		/* 목록 아래 [page번호]를 클릭할 때 수행
			 cPage를 변수로 가지고 새롭게 비동기통신을 해서
			 테이블을 표현한다 */
		function paging(cPage) {
			$.ajax({
				url: "formMainAjax",
				type: "post",
				data: "cPage="+cPage
			}).done(function(result){
				$("#mainAjax").html(result);
			});
		};

		// 목록에서 [첨부파일]을 클릭할 때 수행
		// 첨부된 파일을 다운받는 기능
		function formFileDown(fd_fname) {
			location.href="formFileDown?fd_fname="+fd_fname;
		};

		// [표시개수]를 바꿨을 때 수행
		// 선택한 표시개수만큼 1page에 출력하는 기능
		function changeViewNum(cPage) {
			let num = document.getElementById("viewNum").value;
			$.ajax({
				url: "formMainAjax",
				type: "post",
				data: "numPerPage="+num+
						"&cPage="+cPage
			}).done(function(result){
				$("#mainAjax").html(result);
			});
		};
	</script>
</body>
</c:if>
<c:if test="${tvo ne null}">
	<c:redirect url="index">
	</c:redirect>
</c:if>
</html>