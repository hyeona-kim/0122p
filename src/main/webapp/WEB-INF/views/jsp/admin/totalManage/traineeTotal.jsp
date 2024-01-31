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
	
	#searchCourse, #makeCourse{
		margin-top:10px;
		border-collapse: collapse;
		width: 100%;
	}
	#searchCourse td, #searchTime th, #makeCourse td, #makeCourse th{
		border: 1px solid #ddd;
		height: 40px;
		padding-left: 10px;
	}
	#searchCourse th, #makeCourse th{background-color: #ddd;}
	
	#searchCourse caption, #makeCourse caption{
		text-indent: -9999px;
		height: 0;
	}
	#e_table{
		width:100%;
		border-collapse: collapse;
	}
	#e_table td, #e_table th{
		border: 1px solid #ababab;
		padding: 5px;
	}
	#e_h2{
		height: 35px;
		background-color: black;
		color: white;
		font-size: 20px;
		line-height: 35px;
	}
	#e_div{
		height: 20px;
		line-height: 20px;
		font-size: 11px;
		color: red;
	}
	#before, #after{
		display: inline-block;
		width: 25px;
		height: 25px;
		line-height: 20px;
		border-radius: 12px 12px;
		color: white;
		font-weight: bold;
	}
	#before{
		margin-right: 20px;
		background-color:darkgray;
	}
	#after{
		background-color:aquamarine;
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
					<article>
						<div id="staffList_top">과정별시간표만들기</div>
						<table id="searchCourse">
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
											<option value="3">과정명</option>
										</select>
										<input type="text" id="searchValue"/>
										<button type="button" id="search_bt">검 색</button>
									</td>
								</tr>
							</thead>
						</table>
						<div id="courseLog_Table">
							
						</div>
					</article>
				</div>
			</div>	
		</div>
		<div id="dialog" hidden title="액셀등록">
		<div id="dialog2" hidden title="주별 시간표 보기">
			
		</div>
	</article>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
	<script>
	
	$(function() {
        /*
		$.ajax({
			url: "courseMain",
			type: "post",
			data:"listSelect="+encodeURIComponent("3")+"&cPage="+encodeURIComponent('${param.cPage}')
		}).done(function(result){
			$("#courseLog_Table").html(result);
		});*/
		
		
		//$().removeClass("selected");
		$(".selected").removeClass("selected");
		$(".l_select").removeClass("l_selected");
		$("#thirteenmenu").addClass("selected");
		$("#l_first").addClass("l_select");
		
		
	});
	

	</script>
</body>
</c:if>

</html>