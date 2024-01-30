<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/header.css" />
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
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
	#cf_h2{
		background: black;
		color: white;
		width: 100%;
		height: 40px;
		line-height: 40px;
		margin-bottom: 30px;
	}
	#cf_wrap{
		width: 100%;

	}
	#cf_table{
		border-collapse: collapse;
		width: 100%;
	}
	#cf_table td,#cf_table th{
		border: 1px solid #aaaaaa;
		height: 30px;
		line-height: 30px;
		text-align: center;
	}
	#cf_table thead{
		background-color: #dedede;
	}
	#cf_table tfoot td{
		border: none;
		text-align: center;
		padding-top: 10px;
	}

	#cd_div h3 {
        text-align: center;
    }
	#cd_div2{
		text-align: center;
		border: 1px solid black;
	}

	#hd_btn{
		text-align: right;
		margin: 0;
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
	#courseList_top, #staffList_top {
		background: black;
		color: white;
		height: 40px;
		line-height: 40px;
	}
	
	#searchCourse, #makeCourse{
		margin-top:10px;
		border-collapse: collapse;
		width: 100%;
	}
	
	#searchCourse td, #searchCourse th, #makeCourse td, #makeCourse th, #makeTime td, #makeTime th {
		border: 1px solid #ddd;
		height: 20px;
		padding-left: 10px;
	}
	#makeCourse th{
		height: 40px;
	}
	#searchCourse th, #makeCourse th, #makeTime th{background-color: #ddd;}
	
	#searchCourse caption, #makeCourse caption{
		text-indent: -9999px;
		height: 0;
	}
	#ttop{
		margin-top:10px;
		text-align: right;
	}
	
	#table{
		width:100%;
		border: 1px solid #EAEAEA;
		border-collapse: collapse;
		margin-top: 50px;

	}
	
	#table th,td{
		border-bottom : 1px solid #EAEAEA;
		padding:10px;
	}

	#table th{
		background-color: #D6F0FF;
	}
	
	div#box{
		display: inline-block;
		color: red;
		width: 300px;
		height: 20px;
		padding:0;
		margin:0;
		margin-left:6px;
		font-weight: bold; 
	
	}
	
	#table tfoot>tr:first-child td{
		
		color:blue;
		font-weight: bold;
		border-bottom: none;
		font-size: 15px;
		padding-top:10px;
	}
	
	#table thead tr{
		font-weight: bold;
		border-bottom: 1px solid black;
	}
	

	 #hd{
      background-color: #2e2e2e;
      color: #fff;
      width: 100%;
      margin: 0px auto;
      margin-bottom: 10px;
   }
   #t1{
      border-collapse: collapse;
      width: 600px;
      margin: auto;

   }
   
   #t1 td{
      border: 1px solid black;
      padding: 4px;
      height: 20px;
      text-align: center;
	  height: 35px;
	  line-height: 35px;
   }
   #t1 {
      border-collapse: collapse;
      width: 100%;
      border-spacing: 0;
   }
     #t1 tfoot{
     	border: none;
    }
	#ct_t1{
		width: 100%;
		border-collapse: collapse;
	}
	#ct_t1 td{
		border: 1px solid #aaaaaa;
		height: 50px;
		line-height: 50px;
		text-align: center;
	}
	#ct_t1 tfoot td{
		border: none;
	}
	#ct_h2{
		height: 35px;
		line-height: 35px;
		background-color: black;
		color: white;
		width: 100%;
	}
   .num, .color{
      background-color: #D6F0FF;
   }
   #btn{
      display: inline-block;
      width: 100%;
      text-align: center;
      margin: 20px auto;
   }
   #btn>form>input{
      height: 40px;   
      border: none;
      width: 60px;
      font-size: 16px;
      color: #fff;
      border-radius: 3px;
   }
   #btn>form>input:first-child{
      background-color: #99ccff;
   }
   #btn>form>input:first-child:hover{
      background-color: #88bbee;
   }
   #btn>form>input:last-child{
      background-color: #c0c0c0;
   }
   #btn>form>input:last-child:hover{
      background-color: #d1d1d1;
   }

  
	#table_h2{
		background-color: black;
		color: white;
	}
	<!-- 교과목 수정,등록하는 CSS-->
	#subject_wrap{
		width: 100%;
		border: 1px solid red;
	}
	.subject_out{
		border-collapse: collapse;
		width: 100%;
	}
	.subject_out td, .subject_out th{
		height: 120px;
		border: 1px solid #ababab;
		text-align: center;
	}
	.subject_out th{
		background-color: #ededed;
	}
	.subject_out p{
		font-size: 20px;
	}
	.subject_out select{
		width: 60px;
		height: 25px;
	}
	.subject_out #innerTable{
		border-collapse: collapse;
		height: 100px;
		margin: auto;
	}
	.subject_out #innerTable td, .subject_out #innerTable th{
		height: 20px;
		border: 1px solid #ababab;
	}
	#subject_h2{
		background: black;
		color: white;
		width: 100%;
		height: 40px;
		line-height: 40px;
	}
	#btns button{
		height: 30px;
		
		border: 1px solid black;
		background:  #00acac;
		color: white;
		border: 1px solid #00acac;
		border-radius: 5px 5px;
	}
	#btns {
		width: 100%;
		margin-bottom: 20px;
		text-align: right;
	}

	#cf_h2{
		background: black;
		color: white;
		width: 100%;
		height: 40px;
		line-height: 40px;
		margin-bottom: 30px;
	}
	#cf_wrap{
		width: 100%;

	}
	#cf_table{
		border-collapse: collapse;
		width: 100%;
	}
	#cf_table td,#cf_table th{
		border: 1px solid #aaaaaa;
		height: 30px;
		line-height: 30px;
		text-align: center;
	}
	#cf_table thead{
		background-color: #dedede;
	}
	#cf_table tfoot td{
		border: none;
		text-align: center;
		padding-top: 10px;
	}
	#us_table{
		width: 100%;
		border-collapse: collapse;
		margin-top: 20px;
	}
	#us_table th{
		background-color: #dedede;
	}
	#us_table th,#us_table td{
		border: 1px solid #dedede;
		height: 35px;
		text-align: center;
	}

</style>

</head>
<c:if test="${tvo eq null }">
<body>
	<article id="wrap">
		<jsp:include page="${pageContext.request.contextPath }/WEB-INF/views/jsp/head.jsp"></jsp:include>
		<div id="center">
			<jsp:include page="./leftList.jsp"></jsp:include>
			<div class="right">
				<div id="staffWrap">
					<div id="staffList_top">입학상담내역</div>

					<div id="cd_div">
						<h3>${now} 금일 상담 예정자</h3>
						<div id="cd_div2">
							<h4>금일 처리할 데이터가 없습니다</h4>
						</div>
					</div>

					<p id="hd_btn">
						<button type="button" onclick="togglek()">숨기기</button>
					</p>

					<form>
						<table id="searchTime">
						<caption>과정검색</caption>
							<thead>
								<tr>
									<th>검색</th>
									<td>
										<select id="numPerPage">
											
											<option>표시개수</option>
											<option>5</option>
											<option>10</option>
											<option>15</option>
										</select>
										<select id="selectYear">

										</select>
									</td>
									<td>
										<select id="searchType">
											<option value="1">국가기간</option>
											<option value="2">국민내일배움카드</option>
											<option value="3">일반과정</option>
											<option value="4">KDT</option>
										</select>
									</td>
									<td>
										<select id="searchType2">
											<option value="1">여긴 나중에 과정명 반복문 처리</option>
										</select>
									</td>
									<td>
										<select id="searchType3">
											<option value="1">이름</option>
											<option value="2">전화번호</option>
											<option value="3">메모</option>
										</select>
										<input type="text" id="searchValue"/>
										<button type="button" id="search_bt">검 색</button>
									</td>
								</tr>
							</thead>
						</table>
						<table>
							<tbody>
								<tr>	
									<th>
										<button type="button">선택삭제</button>
										<button type="button">선택 접수처리</button>
										<button type="button" id="btn_right" onclick="setid()">유입경로항목관리</button>
										<button type="button" id="btn_right" onclick="setNs()">다음예정일항목관리</button>
										<button type="button" id="btn_right" onclick="setDB()">입학상담등록</button>
									</th>
								</tr>
							</tbody>
						</table>
					</form>	
				<div id="counselReceipt_Table">	
					
				</div>
			</div>
		</div>
	</div>

	<div id="dialog" hidden="" title="유입경로항목 등록/수정">	
	</div>

	<div id="dialog2" hidden="" title="다음예정일항목 등록/수정">	
	</div>

	<div id="dialog3" hidden="" title="등록">	
	</div>

</article>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
	<script>
	let select ="";
	let select_year = "";
	let numPerPage = "";
	let value ="";
	let cPage = 1;
	let room_length =Number('${id_length}');

	$(function() {
	
		$.ajax({
			url: "counselReceiptMain",
			type: "post",
			data:"listSelect="+encodeURIComponent('${param.listSelect}')+"&cPage="+encodeURIComponent('${param.cPage}'),
		}).done(function(result){
			$("#counselReceipt_Table").html(result);
		});
		
		
		//$().removeClass("selected");
		$(".selected").removeClass("selected");
		$(".l_select").removeClass("l_selected");
		$("#firstmenu").addClass("selected");
		$("#l_second").addClass("l_select");
		
		let now = new Date();	// 현재 날짜 및 시간
		let year = now.getFullYear();
		let str = "<option>년도선택</option>";
		
		for(let i=year+1; i>year-5; i--){
			str+= "<option value="+i+">"+i+"</option>";
		}
		$("#selectYear").html(str);
		
		$("#searchType").on("change",function(){
			select = this.value;
		});
		$("#selectYear").on("change",function(){
			select_year = this.value;
			console.log("dd");
			$.ajax({
				url: "searchCourse",
				type: "post",
				data:"select="+encodeURIComponent(select)+"&value="+encodeURIComponent(value)+"&year="+encodeURIComponent(select_year)
					+"&num="+encodeURIComponent(numPerPage)+"&listSelect="+encodeURIComponent('${param.listSelect}')+"&cPage="+encodeURIComponent('${param.cPage}')
			}).done(function(result){
				$("#counselReceipt_Table").html(result);
			});
		});
		$("#numPerPage").on("change",function(){
			numPerPage = this.value;
			$.ajax({
				url: "searchCourse",
				type: "post",
				data:"select="+encodeURIComponent(select)+"&value="+encodeURIComponent(value)+"&year="+encodeURIComponent(select_year)
					+"&num="+encodeURIComponent(numPerPage)+"&listSelect="+encodeURIComponent('${param.listSelect}')+"&cPage="+encodeURIComponent('${param.cPage}')
			}).done(function(result){
				$("#counselReceipt_Table").html(result);
			});
		});
		$("#search_bt").click(function(){
			let value = $("#searchValue").val();
			
			$.ajax({
				url: "searchCourse",
				type: "post",
				data:"select="+encodeURIComponent(select)+"&value="+encodeURIComponent(value)+"&year="+encodeURIComponent(select_year)
					+"&num="+encodeURIComponent(numPerPage)+"&listSelect="+encodeURIComponent('${param.listSelect}')+"&cPage="+encodeURIComponent('${param.cPage}')
			}).done(function(result){
				$("#counselReceipt_Table").html(result);
			});
		});	
	});


	



	
	function paging(str) {
		cPage = str;
		$.ajax({
			url:"searchCourse",
			type:"post",
			data:"select="+encodeURIComponent(select)+"&value="+encodeURIComponent(value)+"&year="+encodeURIComponent(select_year)
				+"&num="+encodeURIComponent(numPerPage)+"&listSelect="+encodeURIComponent('${param.listSelect}')+"&cPage="+encodeURIComponent(str),
		}).done(function(result){
			$("#counselReceipt_Table").html(result);
		});
	}

	function setid() {
            $("#dialog").dialog("open");
            $.ajax({
				url:"cr_dialog",
				type:"post",
				data:"&select="+encodeURIComponent("addInflowPath")+"&listSelect=1&cPage=1",
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

		function setNs() {
            $("#dialog2").dialog("open");
            $.ajax({
				url:"cr_dialog",
				type:"post",
				data:"&select="+encodeURIComponent("addNextscheduled")+"&listSelect=1&cPage=1",
			}).done(function(result){
				$("#dialog2").html(result);
				
				$("#cl").click(function(){
					 room_length = 7;
					 $("#dialog2").dialog( "close" );
				});
				
				$(".ui-dialog-titlebar-close").click(function(){
					 room_length = 7;
					 $("#dialog2").dialog( "close" );
				});

			});
        }
		function setDB() {
            $("#dialog3").dialog("open");
            $.ajax({
				url:"cr_dialog",
				type:"post",
				data:"&select="+encodeURIComponent("addCounselingDetail")+"&listSelect=1&cPage=1",
			}).done(function(result){
				$("#dialog3").html(result);
				
				$("#cl").click(function(){
					 room_length = 7;
					 $("#dialog3").dialog( "close" );
				});
				
				$(".ui-dialog-titlebar-close").click(function(){
					 room_length = 7;
					 $("#dialog3").dialog( "close" );
				});

			});
        }

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

	$("#dialog2").dialog({
		autoOpen: false,
		width:900,
		modal: true,
		buttons: {
			"닫기": function() {
				$( this ).dialog( "close" );
			}
		}
	});

	$("#dialog3").dialog({
		autoOpen: false,
		width:900,
		modal: true,
		buttons: {
			"닫기": function() {
				$( this ).dialog( "close" );
			}
		}
	});

	function togglek() {
        var cdDiv = document.getElementById("cd_div");

        if (cdDiv.style.display === "none") {
            cdDiv.style.display = "block";
        } else {
            cdDiv.style.display = "none";
        }
    }

	function addInflowPath() {
			room_length +=1;
			let str = $("#addInflowPath_tbody").html();
			let str2="<tr><td><strong>"+room_length+"</strong><br/><button type='button'>삭제</button> </td> <td><input type='text' name='InflowPathName'> </td>";
			
			$("#addInflowPath_tbody").html(str+str2);
		}
	function addNextscheduled() {
			room_length +=1;
			let str = $("#addNextscheduled_tbody").html();
			let str2="<tr><td><strong>"+room_length+"</strong><br/><button type='button'>삭제</button> </td> <td><input type='text' name='nextscheduledName'> </td>";
			
			$("#addNextscheduled_tbody").html(str+str2);
		}
	function delId(id_idx){
			if( confirm("삭제하시겠습니까?")){

			rm.action = "delInflowPath";
			document.rm.id_idx.value = id_idx; 
			
			document.rm.submit();
			}
		}
	function delNs(ns_idx){
			if( confirm("삭제하시겠습니까?")){

			rm.action = "delNextscheduled";
			document.rm.ns_idx.value = ns_idx; 
			
			document.rm.submit();
			}
		}

	</script>
</body>
</c:if>
</html>