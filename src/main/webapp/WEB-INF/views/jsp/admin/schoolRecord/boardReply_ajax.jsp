<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="rp" uri="http://java.sun.com/jsp/jstl/core" %>
<form action="boardAddReply" method="post">
	<%-- 작성자 정보를 전달하기 위해 input태그 추가 --%>
	<input type="hidden" name="writer" value="${bvo.bd_writer}">
	<input type="hidden" name="c_idx" value="${bvo.c_idx}">
	<table>
		<caption>게시판 답변 작성 테이블</caption>
		<thead>
			
		</thead>
		<tbody>
			<tr>
				<th>제목</th>
				<td class="left"><input class="input" type="text" name="bd_subject" value="re:${bvo.bd_subject}"/></td>
			</tr>
			<tr>
				<th>전체공지</th>
				<td class="left"><input type="checkbox" name="bd_notice" value="1"/>공지</td>
			</tr>
			<tr>
				<th>내용</th>
				<td class="left">
					<textarea rows="10" cols="70" name="bd_content">
						========================================
*** 님이 작성한 글
						========================================
${bvo.bd_content}
					</textarea>
				</td>
			</tr>
			<tr>
				<th>파일첨부</th>
				<td class="left"><input type="file" name="bd_file"/></td>
			</tr>
		</tbody>
		<tfoot>
			<tr>
				<td colspan="2">
					<button type="button" onclick="addReply(this.form)" class="bo_edit_btn bo_btn">등록</button>
					<!-- <a href="javascript:addReply(this.form)" class="bo_edit_btn bo_btn">등록</a> -->
					<!-- <a href="" class="bo_del_btn bo_btn">취소</a> -->
					<button type="button" class="bo_del_btn bo_btn" id="cancel_btn">취소</a>
				</td>
			</tr>
		</tfoot>
	</table>
</form>