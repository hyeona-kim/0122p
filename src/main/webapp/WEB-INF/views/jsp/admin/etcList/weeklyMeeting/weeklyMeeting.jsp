<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sf" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/header.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/center.css" />
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
<title>Insert title here</title>
<style>
	#staffWrap{
		width: 95%;
		padding: 10px;
		margin: 0px auto;
	}
	#staffList{
		border-collapse: collapse;
		width: 98%;
		margin: 0px auto;
		padding: 0px;
	}
	#staffList tbody{
		text-align: center;
	}
	#staffList tbody th, #staffList tbody td{
		border: 1px solid black;
		padding: 5px;
	}
	#staffList tbody th {
		background-color: #f0f0ef;
	}
	#staffList tbody td {
		border: 1px solid black;
		font-size: 13px;
	}
	#staffList caption{
		text-indent: -9999px;
		height: 0px;
	}
	#staffList thead td{
		text-align: right;
		border: none;
		padding: 8px 0px;
	}
	#staffList tbody th, #staffList tfoot td {
		text-align: center;
		border: none;
		padding: 8px 0px;
	}
	div#staffList_top{
		background-color: black;
		padding: 5px;
		padding-left: 10px;
		color: white;
		font-weight: bold;
	}
	#weeklyMeeting_add_btn{
		background-color: #4cdbcf;
		border-radius: 3px;
		border: none;
		padding: 5px 7px;
		font-weight: bold;
		font-size: 14px;
		color: white; 
		text-decoration: none;
	}
	.staff_btn{
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
	.staff_edit_btn{ background-color: #1876c7;	}
	.staff_del_btn{ background-color: #cc1919; }
	#addForm table caption{ text-indent: -9999px; }
	#addForm table {
		width: 950px;
		height: 450px;
		border-collapse: collapse;
		position: absolute;
		
	}
	#addForm table th, #addForm table td{
		border: 1px solid #e9e9e6;
		padding: 5px;
	}
	#addForm {
		text-align: center;
		margin: 0px auto;
		padding: 10px;
	}
	#addForm .left {
		text-align: left;
	}
	#addForm th{
		width: 20%;
	}
	#addForm .phone{
		width: 50px;
	}
	#addForm .input{
		width: 150px;
	}
	#addForm tfoot td{
		border: none;
	}
	#signature{
		border: 1px solid black;
	}
	#director{
		background-color: #e14b4b;
		border-radius: 3px;
		padding: 5px 7px;
		font-weight: bold;
		font-size: 14px;
		color: white; 
	}
	#faculty{
		background-color: #322eee;
		border-radius: 3px;
		padding: 5px 7px;
		font-weight: bold;
		font-size: 14px;
		color: white; 
	}
	#block_btn{
		background-color: #4c5bcf;
		border-radius: 3px;
		padding: 5px 7px;
		font-weight: bold;
		font-size: 14px;
		color: white; 
	}
</style>
</head>
<body>
	<article id="wrap">
		<jsp:include page="${pageContext.request.contextPath }/WEB-INF/views/jsp/head.jsp"></jsp:include>
		<div id="center">
		<jsp:include page="../leftList.jsp"></jsp:include>
		
		<div class="right">
			<!--  여기서 표시될 테이블들 가지고오기 -->
			<div id="staffWrap">
				<div id="staffList_top">주간회의록</div>
				<table id="staffList">
					<thead>
					<tr>
						<td colspan="3">
							<select id="numPerPage">
								<option>표시개수</option>
								<option>5</option>
								<option>10</option>
								<option>15</option>
							</select>
							<select id="searchType">
								<option value="1">제목</option>
								<option value="2">논의내용</option>
								<option value="3">회의일</option>
							</select>
							<input type="text" id="searchValue"/>
							<button type="button" id="search_bt">검 색</button>
						</td>
			
						<td colspan="2">
							<button type="button" id="weeklyMeeting_add_btn" onclick="setWk()">회의록 등록</button>
						</td>
					</tr>
				</thead>
			</table>
					<div id="weeklyMeeting_Table">	
						<!--비동기로 받아올 부분-->
					</div>

				</div>
			</div>
		</div>

		<div id="dialog" hidden="" title="주간회의록작성">	
		</div>

		<div id="dialog2" hidden="" title="주간회의록수정">	
		</div>

	
	</article>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js" 
	integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
	<script>
		let select ="";
		let numPerPage = "";
		let value ="";
		let cPage = 1;

		$(function(){

			$(".selected").removeClass("selected")
			$("#etclist").addClass("selected");

			$.ajax({
			url: "weeklyMeetingMain",
			type: "post",
			data:"listSelect="+encodeURIComponent("1"),
			}).done(function(result){
				$("#weeklyMeeting_Table").html(result);
			});



			$("#numPerPage").on("change",function(){
			numPerPage = this.value;
			$.ajax({
				url: "searchweeklyMeeting",
				type: "post",
				data:"select="+encodeURIComponent(select)+"&value="+encodeURIComponent(value)
					+"&num="+encodeURIComponent(numPerPage)+"&listSelect="+encodeURIComponent("1")+"&cPage="+encodeURIComponent("1")
			}).done(function(result){
				$("#weeklyMeeting_Table").html(result);
			});



			$("#searchType").on("change",function(){
				select = this.value;
			});


			$("#search_bt").click(function(){
				value = $("#searchValue").val();
			
				$.ajax({
					url: "searchweeklyMeeting",
					type: "post",
					data:"select="+encodeURIComponent(select)+"&value="+encodeURIComponent(value)
						+"&num="+encodeURIComponent(numPerPage)+"&listSelect="+encodeURIComponent("1")+"&cPage="+encodeURIComponent("1")
				}).done(function(result){
					$("#weeklyMeeting_Table").html(result);
				});

			});	

		});
			
		});

		function paging(str) {
		cPage = str;
		$.ajax({
			url:"searchweeklyMeeting",
			type:"post",
			data:"select="+encodeURIComponent(select)+"&value="+encodeURIComponent(value)
				+"&num="+encodeURIComponent(numPerPage)+"&listSelect="+encodeURIComponent("1")+"&cPage="+encodeURIComponent(str),
		}).done(function(result){
			$("#weeklyMeeting_Table").html(result);
		});
	}
		
		function setWk() {
            $("#dialog").dialog("open");
            $.ajax({
				url:"wk_dialog",
				type:"post",
				data:"&select="+encodeURIComponent("addWeeklyMeeting")+"&listSelect=1&cPage=1",
			}).done(function(result){
				$("#dialog").html(result);
				
				$("#cl").click(function(){
					 room_length = 7;
					 $("#dialog").dialog( "close" );
				});
				
				$(".ui-dialog-titlebar-close").click(function(){
					 room_length = 7;
					 $("#dialog").dialog( "close" );
				});

			});
        }

		

		 function editWeeklyMeeting(wk_idx) {
			$.ajax({
				url: "weeklyMeetingEditForm",
				type: "post",
				data: "wk_idx="+wk_idx
			}).done(function(result){
				$("#dialog2").html(result);

				$("#dialog2").dialog({
					title : '주간회의록',
					modal : true,
					width : 1000,
					height : 600
				});
			});
			
		};


		function editWk(frm) {
			
			frm.submit();
		};



		$("#dialog").dialog({
		autoOpen: false,
		width:900,
		modal: true,
		buttons: {
			"닫기": function() {
				$( this ).dialog( "close" );
			}
		}
	});


		

	
		function delWk(idx) {
			if(confirm("삭제하시겠습니까?")){
				location.href="delWeeklyMeeting?wk_idx="+idx;
			}else{
				return false;
			}
		};


		

	
	</script>
</body>
</html>