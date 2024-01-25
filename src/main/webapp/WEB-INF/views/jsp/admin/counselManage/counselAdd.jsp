<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<body>
	<h2 id="add_h2">상담관리보고서등록</h2>
	<div id="add_top">
		<table id="tt_add1" class="t1">
			<colgroup>
				<col width="25%"/>
				<col width="35%"/>
				<col width="20%"/>
				<col width="*"/>
			</colgroup>
			<thead>
				<tr>
					<th >교육과정명</th>
					<td>${cvo.c_name}</td>
					<th>교육기간</th>
					<td>${cvo.start_date}+"~"+${cvo.end_date}</td>
				</tr>
			</thead>
		</table>
	</div>
	
	<div>
	<form action="counselAdd" method="post">
		<table id="tt_add2" class="t1">
			<colgroup>
				<col width="25%"/>
				<col width="25%"/>
				<col width="25%"/>
				<col width="25%"/>
			</colgroup>
			<thead id="t2head">
				<tr>
                    <th>회의일자</th>
                    <td><input type="text" id="ss_mday" name="ss_mday"/></td>
					<th>상담사</th>
                    <td><input type="text" id="sf_idx" name="sf_idx"/></td>
                </tr>
                <tr>
                    <th>훈련시간</th>
                    <td><input type="text" id="ss_time" name="ss_time"/></td>
					<th>훈련교사</th>
                    <td><input type="text" id="sf_idx" name="sf_idx"/></td>
                </tr>
				<tr>
                    <th>회의장소</th>
                    <td><input type="text" id="ss_pa" name="ss_pa"/></td>
                    <th>총회의회수</th>
                    <td><input type="text" id="ss_cnt" name="ss_cnt"/></td>
                </tr>
                <tr>
                    <th>상담회차</th>
					<td><input type="text" id="ss_num" name="ss_num"/></td>
                    <th>상담기간</th>
					<td><input type="text" id="ss_day" name="ss_day"/></td>
                </tr>
				<tr>
                	<th>회의참석자</th>
					<td colspan ='3'><textarea type="text" id="ss_member" name="ss_member" cols="90" rows="10"></textarea></td>
					
				</tr>
				<tr>
					<th>상담목적</th>
					<td colspan ='3'>
						<textarea type="text" id="so_pp" name="so_pp" cols="90" rows="10"></textarea>
					</td>
				</tr>
					<th>상담대상자</th>
					<td colspan ='3'><textarea type="text" id="tr_idx" name="tr_idx" cols="90" rows="10"></textarea></td>
				</tr>
				<tr>
					<th>상담내용전달사항</th>
					<td colspan="3"><textarea type="text" id="ss_msg" name="ss_msg" cols="90" rows="10"></textarea></td>
				</tr>
				<tr>
					<th>회의내용</th>
					<td colspan ='3'><textarea type="text" id="ss_msubject" name="ss_msubject" cols="90" rows="10"></textarea></td>
				</tr>
				<tr>
					<th>회의사진</th>
					<td colspan ='3'><input type="file"/></td>
				</tr>
					
			</thead>
			<tbody>
					<tr>
						<td colspan="4">
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