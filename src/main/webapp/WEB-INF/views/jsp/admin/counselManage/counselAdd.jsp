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
					<td >교육과정명</td>
					<td>${vo.c_name}</td>
					<td>교육기간</td>
					<td>${vo.start_date}+"~"+${vo.end_date}</td>
				</tr>
			</thead>
		</table>
	</div>
	
	<div>
	<form action="counselAdd" method="post">
		<table id="t2">
			<thead id="t2head">
				<tr>
                    <td>회의일자</td>
                    <input type="text" id="ss_mday" name="ss_mday"/>
					<td>상담사</td>
                    <input type="text" id="sf_idx" name="sf_idx"/>
                </tr>
                <tr>
                    <td>훈련시간</td>
                     <input type="text" id="ss_time" name="ss_time"/>
					<td>훈련교사</td>
                    <input type="text" id="sf_idx" name="sf_idx"/>
                </tr>
				<tr>
                    <td>회의장소</td>
                    <input type="text" id="ss_pa" name="ss_pa"/>
                    <td>총회의회수</td>
                    <input type="text" id="ss_cnt" name="ss_cnt"/>
                </tr>
                <tr>
                    <td>상담회차</td>
                    <input type="text" id="ss_num" name="ss_num"/>
                    <td>상담기간</td>
                    <input type="text" id="ss_day" name="ss_day"/>
                </tr>
				<tr>
                	<td colspan ='3'>회의참석자</td>
                    <input type="text" id="ss_member" name="ss_member"/>
					
				</tr>
				<tr>
					<td colspan ='3'>상담목적</td>
                    <input type="text" id="so_pp" name="so_pp"/>
				</tr>
					<tr><td colspan ='3'>상담대상자</td>
                    <input type="text" id="tr_idx" name="tr_idx"/>
				</tr>
				<tr>
				<td colspan ='3'>상담내용전달사항</td>
                    <input type="text" id="ss_msg" name="ss_msg"/>
				</tr>
				<tr>
					<td colspan ='3'>회의내용</td>
						<input type="text" id="ss_msubject" name="ss_msubject"/>
				</tr>
				<tr>
					<td colspan ='3'>회의사진</td>
						<input type="text" id="ss_bd" name="ss_bd"/>
				</tr>
					
			</thead>
			<tbody>
							<button type="submit">등록</button>
							<button type="button" onclick="cancel()">취소</button>
						</td>
					</tr>
			</tbody>
		</table>
	</form>
	</div>
	
	<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
	<script>
	function cancel(){
		location.href="councel?listSelect=1"

	}


	</script>
</body>
</html>