<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<form action="Controller?type=addBoard" method="post">
	<table>
		<caption>게시판 등록 테이블</caption>
		<thead>
			
		</thead>
		<tbody>
			<tr>
				<th>제목</th>
				<td class="left"><input class="input" type="text" placeholder="제목" name="bd_subject"/></td>
			</tr>
			<tr>
				<th>전체공지</th>
				<td class="left"><input type="checkbox" name="bd_notice" value="1"/>공지</td>
			</tr>
			<tr>
				<th>내용</th>
				<td class="left"><textarea rows="10" cols="70" name="bd_content"></textarea></td>
			</tr>
			<tr>
				<th>파일첨부</th>
				<td class="left"><input type="file" name="bd_file"/></td>
			</tr>
		</tbody>
		<tfoot>
			<tr>
				<td colspan="2">
					<a href="javascript:addBoard()" class="bo_edit_btn bo_btn">등록</a>
					<a href="" class="bo_del_btn bo_btn">취소</a>
				</td>
			</tr>
		</tfoot>
	</table>
</form>