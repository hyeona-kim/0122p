<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<h2 id="table_h2">면접평가표 등록</h2>
	<form action="addCounselReceipt" method="post" name="frm02">
			<table id="table">
				<tbody>
					<tr>
						<th><label>면접평가명</label></th>
						<td>
							<input type="text" name="cr_name" />
						</td>
					</tr>
					<tr>
						<th><label>합격점수</label></th>
						<td><input type="text" name="cr_score">점 이상~</td>
					</tr>
					<tr>
						<th><label>요일</label></th>
						<td>
						<input type="checkbox" name="cr_status" value="사용">사용
						</td>
					</tr>

				</tbody>
				<tfoot>
					<tr>
						<td colspan="2" align="right" id="counselReceipt_add_btn">
							<input type="submit" value="저장">
						</td>
						<td colspan="2" align="left">
							<input type="button" value="목록" id="cc_cancle">
						</td>
					</tr>
				</tfoot>	
			</table>
		</form>
		