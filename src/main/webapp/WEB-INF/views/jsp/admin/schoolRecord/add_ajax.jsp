<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<form action="Controller?type=addSuggestion" method="post">
	<table>
		<caption>고충 및 건의사항 등록 테이블</caption>
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
				<td class="left"><input class="input" type="text" placeholder="제목" name="sg_subject"/></td>
			</tr>
			<tr>
				<th>전체공지</th>
				<td class="left"><input type="checkbox" name="sg_notice" value="1"/>공지</td>
			</tr>
			<tr>
				<th>내용</th>
				<td class="left"><textarea rows="10" cols="70" name="sg_content"></textarea></td>
			</tr>
			<tr>
				<th>파일첨부</th>
				<td class="left"><input type="file" name="sg_file"/></td>
			</tr>
		</tbody>
		<tfoot>
			<tr>
				<td colspan="2">
					<a href="javascript:addSuggestion()" class="sug_edit_btn sug_btn">등록</a>
					<a href="" class="sug_del_btn sug_btn">취소</a>
				</td>
			</tr>
		</tfoot>
	</table>
</form>