<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="rp" uri="http://java.sun.com/jsp/jstl/core" %>
<form action="Controller?type=addReply" method="post">
	<%-- 작성자 정보를 전달하기 위해 input태그 추가 --%>
	<input type="hidden" name="writer" value="${param.writer}">
	<table>
		<caption>고충 및 건의사항 답변 작성 테이블</caption>
		<thead>
			<tr>
				<th>과정명</th>
				<%-- [수정필요] 
				 	 훈련과정명을 가져와야함 --%>
				<td>훈련과정테스트</td>
			</tr>
		</thead>
		<tbody>
			<tr>
				<th>제목</th>
				<td class="left"><input class="input" type="text" name="sg_subject" value="re:${param.subject}"/></td>
			</tr>
			<tr>
				<th>전체공지</th>
				<td class="left"><input type="checkbox" name="sg_notice" value="1"/>공지</td>
			</tr>
			<tr>
				<th>내용</th>
				<td class="left">
					<textarea rows="10" cols="70" name="sg_content">
						========================================
*** 님이 작성한 글
						========================================
${param.content}
					</textarea>
				</td>
			</tr>
			<tr>
				<th>파일첨부</th>
				<td class="left"><input type="file" name="sg_file"/></td>
			</tr>
		</tbody>
		<tfoot>
			<tr>
				<td colspan="2">
					<button type="button" onclick="addReply(this.form)" class="sug_edit_btn sug_btn">등록</button>
					<!-- <a href="javascript:addReply(this.form)" class="sug_edit_btn sug_btn">등록</a> -->
					<a href="" class="sug_del_btn sug_btn">취소</a>
				</td>
			</tr>
		</tfoot>
	</table>
</form>