<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<form action="addFormDown" method="post" enctype="multipart/form-data">
	<table>
		<caption>서식파일 등록 테이블</caption>
		<tbody>
			<tr>
				<th>제목</th>
				<td class="left"><input type="text" name="fd_subject" data-str="제목" class="input" id="fd_subject"/></td>
			</tr>
			<tr>
				<th>첨부파일</th>
				<td class="left"><input type="file" name="file"/></td>
			</tr>
		</tbody>
		<tfoot>
			<tr>
				<td colspan="2">
					<button type="button" onclick="addFormDown(this.form)" class="form_edit_btn form_btn">저장</button>
					<button type="button" onclick="closeDialog()" class="form_can_btn form_btn">취소</button>
				</td>
			</tr>
		</tfoot>
	</table>
</form>