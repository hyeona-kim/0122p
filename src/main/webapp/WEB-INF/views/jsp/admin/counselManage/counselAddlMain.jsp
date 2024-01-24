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
	<header>상담관리보고</header>
	<div id="top">
		<table id="t1">
			<thead>
				<tr>
					<td >교육과정명:</td>
					<td>테스트</td>
					<td>교육기간:</td>
					<td>2000-01-01~2000-02-02</td>
					<td>총회의수</td>
					<td>1</td>
				</tr>
			</thead>
		</table>
	</div>
	
	<div>
	<form action="counselAdd" method="post">
		<table id="t2">
			<thead id="t2head">
				<tr>
                    <td>회의일:</td>
					<td>회차</td>
					<td>상담기간</td>
					<td>상담목적</td>
					<td>담당</td>

                </tr>
                <tr>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
			</thead>
			<tbody>
							<button type="submit" onclick="">보고서등록</button>
							<button type="button" onclick="">인쇄</button>
							<button type="button" onclick="">취소</button>
						</td>
					</tr>
			</tbody>
		</table>
	</form>
	</div>
	
	<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
	<script>


	</script>
</body>
</html>