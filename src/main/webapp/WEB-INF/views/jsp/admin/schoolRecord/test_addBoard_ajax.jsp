<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" href="${pageContext.request.contextPath }/css/jquery-ui.min.css">
<script src="${pageContext.request.contextPath }/js/jquery-ui.min.js"></script>
<script src="js/summernote-lite.js"></script>
<script src="js/lang/summernote-ko-KR.js"></script>
<form action="test_addBoard" method="post" id="addForm_t" enctype="multipart/form-data">
	<!-- 추가 인자로 보내기 위해 hidden으로 던진다 -->
	<input type="hidden" name="c_idx" value="${param.c_idx}"/>
	<h2 class="title">게시판 등록</h2>
	<table class="table">
		<colgroup>
		<col width="20%"/>
		<col width="80%"/>
		</colgroup>
		<caption>게시판 등록 테이블</caption>
		<tbody>
			<tr>
				<th>제목</th>
				<td class="left"><input class="text" type="text" placeholder="제목" name="bd_subject" id="bd_subject" /></td>
			</tr>
			<tr>
				<th>전체공지</th>
				<td class="left"><input type="checkbox" name="bd_notice" id="bd_notice" value="1"/>공지</td>
			</tr>
			<tr>
				<th>내용</th>
				<td class="left"><textarea rows="10" cols="70" name="bd_content" id="bd_content" class="textarea"></textarea></td>
			</tr>
			<tr>
				<th>파일첨부</th>
				<td class="left"><input type="file" name="file" id="bd_file" class="text"/></td>
			</tr>
		</tbody>
		<tfoot>
			<tr>
				<td colspan="2">
					<!-- <a href="" class="bo_edit_btn bo_btn">등록</a> -->
					<button type="button" onclick="addBoard(this.form)" class="btn">등록</button>
					<!-- <button type="button" onclick="addBoard()" class="bo_edit_btn bo_btn">등록</button> -->
					<button type="button" onclick="location.href=''" class="btn">취소</button>
				</td>
			</tr>
		</tfoot>
	</table>
</form>