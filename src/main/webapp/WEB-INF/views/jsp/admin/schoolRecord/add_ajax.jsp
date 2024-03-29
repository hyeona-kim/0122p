<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<form action="addSuggestion" method="post" enctype="multipart/form-data" name="addForm">
	<input type="hidden" name="c_idx" value="52"/>
	<h2 class="title">고충 및 건의사항 등록</h2>
	<table class="table">
		<caption>고충 및 건의사항 등록 테이블</caption>
		<thead>
			<tr>
				<th>과정명</th>
				<%-- [수정필요] 
				 	 훈련과정명을 가져와야함 --%>
				<td>훈련과정명</td>
			</tr>
		</thead>
		<tbody>
			<tr>
				<th>제목</th>
				<td class="left"><input class="text" type="text" placeholder="제목" name="sg_subject" id="sg_subject"/></td>
			</tr>
			<tr>
				<th>전체공지</th>
				<td class="left"><input type="checkbox" name="notice" value="1"/>공지</td>
			</tr>
			<tr>
				<th>내용</th>
				<td class="left"><textarea rows="10" cols="70" name="sg_content" id="sg_content" class="textarea"></textarea></td>
			</tr>
			<tr>
				<th>파일첨부</th>
				<td class="left"><input type="file" name="file" class="text"/></td>
			</tr>
		</tbody>
		<tfoot>
			<tr>
				<td colspan="2">
					<button onclick="javascript:addSuggestion()" class="btn">등록</button>
					<button onclick="javascript:location.href=''" class="btn">취소</button>
				</td>
			</tr>
		</tfoot>
	</table>
</form>