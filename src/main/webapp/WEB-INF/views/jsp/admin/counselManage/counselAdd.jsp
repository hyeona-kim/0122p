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
	<header>상담관리보고서등록</header>
	<div id="top">
		<table id="t1">
			<thead>
				<tr>
					<td >교육과정명:</td>
					<td>테스트</td>
					<td>교육기간:</td>
					<td>2000-01-01~2000-02-02</td>
				</tr>
			</thead>
		</table>
	</div>
	
	<div">
		<table id="t2">
			<thead id="t2head">
				<tr>
                    <td>회의일자</td><br/>
                    <input type="text" id="ss_mday" name="ss_mday"/>
					<td>상담사</td><br/>
                    <input type="text" id="sf_idx" name="sf_idx"/>
                </tr>
                <tr>
                    <td>훈련시간</td><br/>
                     <input type="text" id="" name=""/>
					<td>훈련교사</td><br/>
                    <input type="text" id="" name=""/>
                </tr>
				<tr>
                    <td>회의장소</td><br/>
                    <input type="text" id="" name=""/>
                    <td>총회의회수</td><br/>
                    <input type="text" id="" name=""/>
                </tr>
                <tr>
                    <td>상담회차</td><br/>
                    <input type="text" id="" name=""/>
                    <td>상담기간</td><br/>
                    <input type="text" id="" name=""/>
                </tr>
				<tr>
                	<td colspan ='3'>회의참석자</td><br/>
                    <input type="text" id="" name=""/>
					
				</tr>
				<tr>
					<td colspan ='3'>상담목적</td><br/>
                    <input type="text" id="" name=""/>
				</tr>
					<tr><td colspan ='3'>상담대상자</td><br/>
                    <input type="text" id="" name=""/>
				</tr>
				<tr>
				<td colspan ='3'>상담내용<br/>전달사항</td><br/>
                    <input type="text" id="" name=""/>
				</tr>
				<tr>
					<td colspan ='3'>회의내용</td><br/>
						<input type="text" id="" name=""/>
				</tr>
				<tr>
					<td colspan ='3'>회의사진</td><br/>
						<input type="text" id="" name=""/>
				</tr>
					
			</thead>
			<tbody>
							<button type="button" onclick="add()">등록</button>
							<button type="button">취소</button>
						</td>
					</tr>
			</tbody>
		</table>
	</div>
	
	<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
	<script>


	</script>
</body>
</html>