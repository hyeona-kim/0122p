<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<h2 id="table_h2" class="title">주간회의록등록</h2>
	<form action="addWeeklyMeeting" enctype="multipart/form-data" method="post" name="frm">
			<table class="t1 table">
				<colgroup>
					<col width="30%"/>
					<col width="10%"/>
					<col width="20%"/>
					<col width="40%"/>
				 </colgroup>
				<tbody>
					<tr>
						<th><label>부서명</label></th>
						<td>
							<input type="text" name="wk_deptname" class="text"/>
						</td>
						<th><label>작성자</label></th>
						<td>
							<input type="text" name="wk_name" class="text"/>
						</td>
					</tr>
					<tr>
						<th><label>회의일자</label></th>
						<td><input type="date" name="wk_date" class="text"/>
						</td>
						<th><label>제목</label></th>
						
						<td><input type="text" name="wk_title"class="text"/>
						</td>
					</tr>
					<tr>
						<th><label>참석자</label></th>
						<td colspan="3"><input type="text" name="wk_attendance" class="text"/></td>
					</tr>
					<tr>
						<th><label>불참자(사유)</label></th>
						<td colspan="3"><input type="text" name="wk_absentee" class="text"/></td>
					</tr>
					<tr>
						<th><label>논의내용</label></th>
						<td colspan="3">
							<textarea name="wk_discussion"cols="60" rows="6" class="textarea"></textarea>
						</td>
					</tr>

					<tr>
						<th><label>공지&건의사항</label></th>
						<td colspan="3">
							<textarea name="wk_announcement"cols="60" rows="6" class="textarea"></textarea>
						</td>
					</tr>
					<tr>
						<th><label>다음주 안건</label></th>
						<td colspan="3">
							<textarea name="wk_item"cols="60" rows="6" class="textarea"></textarea>
						</td>
					</tr>
					<tr>
						<th><label>사진업로드</label></th>
						<td colspan="3">

							<input type="file" name="file" class="text">

						</td>
					</tr>
				</tbody>
				<tfoot>
					<tr>
						<td colspan="4" id="add_btn">
							<input type="submit" value="등록" class="btn">
							<input type="button" value="목록" id="cc_cancle" class="btn">
						</td>
					</tr>
				</tfoot>	
			</table>
			
			<input type="hidden" name="cPage" value="${param.cPage}"/>
			<input type="hidden" name="select" value="${param.select}"/>
			<input type="hidden" name="year" value="${param.year}"/>
			<input type="hidden" name="value" value="${param.value}"/>
			<input type="hidden" name="num" value="${param.num}"/>
		</form>
		