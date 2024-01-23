<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	header{
		 background-color: #2e2e2e;
      color: #fff;
      width: 1000px;
      height: 30px;
      margin: 0px auto;
      margin-bottom: 10px;
      font-size: 20px;
	}
	
	#wrap{
		width: 600px;
		height: 270px;
		padding: 0;
		margin: 0 auto;
		text-align: center;
	}

	 th, td {
	 	margin: 0;
        padding: 0;
        border: 1px solid black;
        text-align: center;
    }
    table {
		border-collapse: collapse;
		width: 100%;
		border-spacing: 0;
	}
	#top{
		margin: 10px;
	}
	#t2head, #t1td{
		background-color: skyblue;
	}
	#ttop{
		 float: right;
		 margin-bottom: 10px;
	}
	
</style>
</head>
<body>
	<header>과정별 상담관리</header>
	<div id="top">
		<table id="t1">
			<thead>
				<tr>
					<td id="t1td">검색</td>
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
							<option>상담사</option>
							<option>과정타입</option>
							<option>과정명</option>
						</select>
						<input type="text"/>
						<button type="button">검 색</button>
					</td>
				</tr>
			</thead>
		</table>
	</div>
	
	<div id="bottom">
		<table id="t2">
			<thead id="t2head">
				<tr>
                    <td>번호</td>
					<td>과정명</td>
					<td>과정타입</td>
					<td>담당교수</td>
					<td>개강일</td>
					<td>종료일</td>
					<td>요일</td>
					<td>회차</td>
					<td>승인/수강인원</td>
					<td>관리</td>
				</tr>
			</thead>
			<tbody>
					<tr>
						<td>1</td>
						<td>W1805300001</td>
						<td>내일배움카드</td>
						<td>김상당</td>
						<td>2018-05-28</td>
						<td>2018-07-12</td>
						<td>월화수목금</td>
						<td>2</td>
						<td>5/0</td>
						<td>
							<button type="button">교육생별 상담내역</button>
							<button type="button">상담결과보고</button>
						</td>
					</tr>
			</tbody>
		</table>
	</div>
	
<script>

</script>
</body>
</html>