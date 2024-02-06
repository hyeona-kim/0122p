<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<form action="addFormDown" method="post" enctype="multipart/form-data">
	<h2 class="title">서식파일 등록</h2>
	<table class="table">
		<caption>서식파일 등록 테이블</caption>
		<tbody>
			<tr>
				<th>제목</th>
				<td><input type="text" name="fd_subject" data-str="제목" class="text" id="fd_subject"/></td>
			</tr>
			<tr>
				<th>첨부파일</th>
				<td><input type="file" name="file" class="text"/></td>
			</tr>
		</tbody>
		<tfoot>
			<tr>
				<td colspan="2">
					<button type="button" onclick="addFormDown(this.form)" class="btn">저장</button>
					<button type="button" onclick="closeDialog()" class="btn">취소</button>
				</td>
			</tr>
		</tfoot>
	</table>
</form>