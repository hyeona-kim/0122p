<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<h2 id="table_h2" class="title">평가관리 시험증빙자료</h2>
	<form action="" method="post" name="frm02">
			<table id="table" class="table">
				<tbody>
					<tr>
						<th><label>시험증빙 이미지</label></th>
						<td>
							<input type="file" name="" class="text" />
						</td>
					</tr>
					<tr>
						<th><label>비고</label></th>
						<td><textarea rows="10" cols="50"></textarea></td>
					</tr>
				
				</tbody>
				<tfoot>
					<tr>
						<td colspan="2" id="evidence_add_btn">
							<input type="submit" value="저장" class="btn">
							<input type="button" value="목록" id="cc_cancle" class="btn">
						</td>
					</tr>
				</tfoot>	
			</table>
		</form>
		