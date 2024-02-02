<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<h2 id="table_h2">주간회의록등록</h2>
	<form action="editWeeklyMeeting" method="post" name="frm">
			<table class="t1">
				<colgroup>
					<col width="25%"/>
					<col width="25%"/>
					<col width="25%"/>
					<col width="25%"/>
				 </colgroup>
			<thead>
				<tr>
					<td colspan="4">
			
					</td>
				</tr>
			</thead>

				<tbody>
					<tr>
						<th><label>부서명</label></th>
						<td>
							<input type="text" name="wk_deptname" value="${edit_war.wk_deptname}"  style="width: 150px;"/>
						</td>
						<th><label>작성자</label></th>
						<td>
							<input type="text" name="wk_name" value="${edit_war.wk_name}"/>
						</td>
					</tr>
					<tr>
						<th><label>회의일자</label></th>
						<td><input type="date" name="wk_date" value="${edit_war.wk_date}">
						</td>
						<th><label>제목</label></th>
						
						<td><input type="text" name="wk_title" value="${edit_war.wk_title}">
						</td>
					</tr>
					<tr>
						<th><label>참석자</label></th>
						<td colspan="3"><input type="text" name="wk_attendance" value="${edit_war.wk_attendance}"></td>
					</tr>
					<tr>
						<th><label>불참자(사유)</label></th>
						<td colspan="3"><input type="text" name="wk_absentee" value="${edit_war.wk_absentee}"></td>
					</tr>
					<tr>
						<th><label>논의내용</label></th>
						<td colspan="3">
							<textarea name="wk_discussion"cols="60" rows="6" >${edit_war.wk_discussion}</textarea>
						</td>
					</tr>

					<tr>
						<th><label>공지&건의사항</label></th>
						<td colspan="3">
							<textarea name="wk_announcement"cols="60" rows="6" >${edit_war.wk_announcement}</textarea>
						</td>
					</tr>
					<tr>
						<th><label>다음주 안건</label></th>
						<td colspan="3">
							<textarea name="wk_item"cols="60" rows="6" >${edit_war.wk_item}</textarea>
						</td>
					</tr>
					<tr>
						<th><label>사진</label></th>
						<td colspan="3">
							<img style="width: 250px;" src="/upload_wk/${edit_war.wk_file_name}">
						</td>
					</tr>
				</tbody>
				<tfoot>
					<tr>
						<td colspan="4" align="right" id="add_btn">
							<input type="button" onclick="editWk(this.form)" value="등록">
							<input type="button" value="목록" id="cc_cancle">
						</td>
					</tr>
				</tfoot>	
			</table>
			<input type="hidden" name="edit" value="1">
			<input type="hidden" name="wk_idx" value="${edit_war.wk_idx}">

		</form>
		