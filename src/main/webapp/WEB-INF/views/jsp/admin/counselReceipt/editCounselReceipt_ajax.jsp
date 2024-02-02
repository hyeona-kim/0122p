<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
			<h2 id="hd">면접평가표 수정</h2>

			<form action="editCounselReceipt" method="post">
			<table id="table">
				<tbody>
					<tr>
						<th><label>면접평가명</label></th>
						<td>
							<input type="text" name="cr_name" value="${edit_crvo.cr_name }" />
						</td>
					</tr>
					<tr>
						<th><label>합격점수</label></th>
						<td><input type="text" name="cr_score" value="${edit_crvo.cr_score }"></td>
					</tr>
					<tr>
						<th><label>사용여부</label></th>
						<td>
							<input type="checkbox" name="cr_status" value="사용" checked>사용
					</tr>
				</tbody>
				<tfoot>
					<tr>
						<td colspan="2" align="right" id="course_add_btn">
							<input type="button" value="수정" onclick="addCounselReceipt(this.form)">
						</td>
						<td colspan="2" align="left">
							<input type="button" value="목록" id="cancel4">
						</td>
					</tr>
				</tfoot>	
			</table>

			<input type="hidden" name="cr_idx" value="${edit_crvo.cr_idx }">

		</form>
