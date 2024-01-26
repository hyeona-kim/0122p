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
					<div id="staffList_top">과정별 교수계획서 및 학습 안내서</div>
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
											<option value="1">훈련강사</option>
											<option value="2">과정타입</option>
											<option value="3">강의실</option>
										</select>
										<input type="text" id="searchValue"/>
										<button type="button" id="search_bt">검 색</button>
									</td>
								</tr>
							</thead>
						</table>
					</form>	
				<div id="courseLog_Table">	
					
				</div>
			</div>
		</div>
	</div>
	<div id="dialog" hidden="" title="교육과정등록">	
		<!--학습 안내서를 등록하는 테이블 -->
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
	$(function() {
	
		$.ajax({
			url: "courseMain",
			type: "post",
			data:"listSelect="+encodeURIComponent('${param.listSelect}')+"&cPage="+encodeURIComponent('${param.cPage}'),
		}).done(function(result){
			$("#courseLog_Table").html(result);
		});
		
		
		//$().removeClass("selected");
		$(".selected").removeClass("selected");
		$(".l_select").removeClass("l_selected");
		$("#secondmenu").addClass("selected");
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
				$("#courseLog_Table").html(result);
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
				$("#courseLog_Table").html(result);
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
				$("#courseLog_Table").html(result);
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
			$("#courseLog_Table").html(result);
		});
	}

	function set(c_idx){
		//console.log(c_idx);
		//이 비동기 통신을 하면서fileVo객체를 받아온다 과정에대한 c_idx를 가지고가서 출력하고 그 과정명을h2태그에 띄어준다 
		
		$("#dialog").dialog("open");
		$.ajax({
			url:"course_file",
			type:"post",
			data:"cPage="+encodeURIComponent(cPage)+"&listSelect=2&c_idx="+c_idx
		}).done(function(result){
			$("#dialog").html(result);
			$("#cc_cancle").click(function(){
				$("#dialog").dialog("close");
			});
		});
		
	}

	$("#dialog").dialog({
		autoOpen: false,
		width:900,
		modal: true,
	});
	</script>
</body>
</c:if>
</html>