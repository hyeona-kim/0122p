<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="${pageContext.request.contextPath }/js/jquery-ui.min.js"></script>
<script src="${pageContext.request.contextPath }/js/summernote-lite.js"></script>
<script src="${pageContext.request.contextPath }/js/lang/summernote-ko-KR.js"></script>
<form action="test_replyBoard" method="post" id="replyForm_t" enctype="multipart/form-data">
	<%-- 작성자 정보를 전달하기 위해 input태그 추가 --%>
	<input type="hidden" name="bd_writer" value="${bvo.bd_writer}">
	<input type="hidden" name="c_idx" value="${bvo.c_idx}">
	<table>
		<caption>게시판 답변 작성 테이블</caption>
		<tbody>
			<tr>
				<th>제목</th>
				<td class="left"><input class="input" type="text" id="bd_replySubject" name="bd_subject" value="re:${bvo.bd_subject}"/></td>
			</tr>
			<tr>
				<th>전체공지</th>
				<td class="left"><input type="checkbox" id="bd_notice" name="bd_notice" value="1"/>공지</td>
			</tr>
			<tr>
				<th>내용</th>
				<td class="left">
					<textarea rows="10" cols="70" id="reply_content" name="bd_content">========================================*** 님이 작성한 글========================================${bvo.bd_content}</textarea>
				</td>
			</tr>
			<tr>
				<th>파일첨부</th>
				<td class="left"><input type="file" id="bd_file" name="file"/></td>
			</tr>
		</tbody>
		<tfoot>
			<tr>
				<td colspan="2">
					<button type="button" class="bo_edit_btn bo_btn" onclick="addReply(this.form)">등록</button>
					<button type="button" class="bo_del_btn bo_btn" id="cancel_btn">취소</a>
				</td>
			</tr>
		</tfoot>
	</table>
</form>