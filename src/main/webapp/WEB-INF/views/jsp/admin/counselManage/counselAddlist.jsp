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
    <thead>
        <tr>
            <td>담당</td>
            <td>부장</td>
            <td>관장</td>
        </tr>
        <tr>
            <td>결제</td>
        </tr>

    </thead>
<body>
	<header>훈련과정테스트</header>

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
		
				<tr>
                    <td>과정명</td>
                    <td></td>
                    <td>훈련기관</td>
                    <td></td>
                </tr>
                <tr>
                    <td>훈련시간</td>
                    <td></td>
					<td>훈련교사</td>
                    <td></td>
                </tr>
				<tr>
                    <td>상담기간</td>
                    <td></td>
                    <td>상담사</td>
                    <td></td>
                </tr>
                <tr>
                    <td >상담목적</td>
                    <td colspan ='3'></td>
                </tr>
				<tr>
                    <td>상담대상자</td>
                    <td colspan ='3'></td>
                </tr>
				<tr>
                    <td>상담내용<br/>전달사항</td>
                    <td colspan ='3'></td>
                </tr>
				<tr>
                    <td>회의내용</td>
                        <td  colspan ='3'></td>
                </tr>
				<tr>
                    <td>결괴회의<br/>근거자료</td>
                        <td  colspan ='3'></td>
                </tr>
				<tr>
                    <td>회의참석자</td>
                        <td colspan ='3'></td>
                </tr>
                <tr>
                    <td>회의일시</td>
                       <td></td>
                    <td>회의장소</td>
                       <td></td>
                </tr>
					
		
			<tbody>
							<button type="button">인쇄</button>
							<button type="button">수정</button>
							<button type="button">삭제</button>
							<button type="button">목록</button>
						</td>
					</tr>
			</tbody>
		</table>
	</div>
	
<script>

</script>
</body>
</html>