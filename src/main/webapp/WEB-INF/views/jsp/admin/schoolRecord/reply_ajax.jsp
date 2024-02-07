<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="rp" uri="http://java.sun.com/jsp/jstl/core" %>
<form action="addReply" method="post" enctype="multipart/form-data">
	<%-- 작성자 정보를 전달하기 위해 input태그 추가 --%>
	<input type="hidden" name="sg_writer" value="${vo.sg_writer}"/>
	<input type="hidden" name="c_idx" value="52"/>
	<table class="table">
		<caption>고충 및 건의사항 답변 작성 테이블</caption>
		<thead>
			<tr>
				<th>과정명</th>
				<td>${vo.c_name}</td>
			</tr>
		</thead>
		<tbody>
			<tr>
				<th>제목</th>
				<td><input class="text" type="text" name="sg_subject" id="reply_subject" value="re:${vo.sg_subject}"/></td>
			</tr>
			<tr>
				<th>전체공지</th>
				<td><input type="checkbox" name="notice" value="1" />공지</td>
			</tr>
			<tr>
				<th>내용</th>
				<td>
					<textarea rows="10" cols="70" name="sg_content" id="reply_content">
						========================================
*** 님이 작성한 글
						========================================
${vo.sg_content}
					</textarea>
				</td>
			</tr>
			<tr>
				<th>파일첨부</th>
				<td><input type="file" name="file"/></td>
			</tr>
		</tbody>
		<tfoot>
			<tr>
				<td colspan="2">
					<button type="button" onclick="addReply(this.form)" class="btn">등록</button>
					<!-- <a href="javascript:addReply(this.form)" class="sug_edit_btn sug_btn">등록</a> -->
					<button onclick="javascript:location.href=''" class="btn red2">취소</button>
				</td>
			</tr>
		</tfoot>
	</table>
</form>