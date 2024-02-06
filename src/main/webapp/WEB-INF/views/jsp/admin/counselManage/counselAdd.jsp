<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

	<h2 id="add_h2">상담관리보고서등록</h2>
	<div id="add_top">
		<table id="tt_add1" class="table">
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
					<td>${cvo.start_date} ~ ${cvo.end_date}</td>
				</tr>
			</thead>
		</table>
	</div>
	
	<div>
	<form action="counselsave" method="post" enctype="multipart/form-data">
		<input type="hidden" name ="c_idx" value="${cvo.c_idx}">
		<input type="hidden" name = "ss_cnt" value="${ss_cnt+1}">
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
                    <td><input type="date" id="ss_mday" name="ss_mday"/></td>
					<th>상담사</th>
                    <td><input type="text" id="ss_tname" name="ss_tname" /></td>
                </tr>
                <tr>
                    <th>훈련시간</th>
                    <td><input type="time" id="ss_time" name="ss_time"/></td>
					<th>훈련교사</th>
                    <td>${cvo.svo.sf_name}<input type="hidden" id="sf_idx" name="sf_idx" value="${cvo.svo.sf_idx}"/></td>
                </tr>
				<tr>
                    <th>회의장소</th>
                    <td><input type="text" id="ss_pa" name="ss_pa"/></td>
                    <th>총회의회수</th>
					<td>${ss_cnt+1}</td>
					
                </tr>
                <tr>
                    <th>상담회차</th>
					<td><input type="text" id="ss_num" name="ss_num"/></td>
                    <th>상담기간</th>
					<td><input type="date" id="ss_day1" name="ss_day1"/>~<input type="date" id="ss_day2" name="ss_day2"/></td>
                </tr>
				<tr>
                	<th>회의참석자</th>
					<td colspan ='3'><textarea type="text" id="ss_member" name="ss_member" cols="90" rows="10"></textarea></td>
					
				</tr>
				<tr>
					<th>상담목적</th>
					<td colspan ='3'>
						<textarea type="text" id="ss_p" name="ss_p" cols="90" rows="10"></textarea>
					</td>
				</tr>
					<th>상담대상자</th>
					<td colspan ='3'><textarea type="text" id="ss_name" name="ss_name" cols="90" rows="10"></textarea></td>
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
					<td colspan ='3'><input type="file" id="ss_img1" name="ss_img1"/></td>
				</tr>
					
			</thead>
			<tbody>
					<tr>
						<td colspan="4">
							<button type="submit">등록</button>
							<button type="button" id="cc_close">취소</button>
						</td>
					</tr>
			</tbody>
		</table>
	</form>
	</div>
	
