<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	.subject{
		border-collapse: collapse;
		width: 1200px;
	}
	.subject td, .subject th{
		height: 120px;
		border: 1px solid #ababab;
		text-align: center;
		
	}
	.subject th{
		background-color: #ededed;
	}
	.subject p{
		font-size: 20px;
	}
	.subject select{
		width: 60px;
		height: 25px;
	}
	.subject #innerTable{
		width: 97%;
		border-collapse: collapse;
		height: 100px;
		margin: auto;
	}
	.subject #innerTable td, .subject #innerTable th{
		height: 20px;
		border: 1px solid #ababab;
	}
	h2{
		background: black;
		color: white;
		width: 1200px;
		height: 40px;
		line-height: 40px;
	}
	#btns button{
		height: 30px;
		background:  #00acac;
		color: white;
		border: 1px solid #00acac;
		border-radius: 5px 5px;
	}
	#btns {
		margin-bottom: 20px;
		width: 1200px;
		text-align: right;
	}
</style>
</head>
<body>
	<h2>"(빅데이터 전문가)  파이썬&웹기반 빅데이터 활용 전문 개발자 양성과정-A과정"과목등록</h2>
	<div id="btns">
		<button>교과목 파일등록</button>
		<button>교과목등록액셀파일</button>
	</div>
	<table class="subject">
	<colgroup>
		<col width="10%"/>
		<col width="90%"/>
	</colgroup>
		<tr>
			<th>
				<p>과목1</p>
				<select>
					 <option>미삭제</option>
					 <option>삭제</option>
				</select>
			</th> 
			<td>
				<table id="innerTable">
				<colgroup>
					<col width="10%"/>
					<col width="30%"/>
					<col width="10%"/>
					<col width="20%"/>
					<col width="10%"/>
					<col width="20%"/>
				</colgroup>
					<tr>
						<th>과목명</th>
						<td><input type="text" style="width: 320px; height: 25px;"/></td>
						<th>분류/시수</th>
						<td>
							<select style="width: 80px; height: 25px;">
								<option>NCS</option>
								<option>비NCS</option>
							</select>
							<input type="text" style="width: 70px; height: 25px;"/>
						</td>
						<th>교수</th>
						<td></td>
					</tr>
					<tr>
						<th>능력단위명</th>
						<td><input type="text" style="width: 320px; height: 25px;"/></td>
						<th>분류번호</th>
						<td></td>
						<th>강의실</th>
						<td></td>
					</tr>
				</table>
			</td> 
		</tr>
	</table>
</body>
</html>