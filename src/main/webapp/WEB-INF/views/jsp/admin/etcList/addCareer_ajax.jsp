<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" href="${pageContext.request.contextPath }/css/jquery-ui.min.css">
<script src="${pageContext.request.contextPath }/js/jquery-ui.min.js"></script>
<script src="js/summernote-lite.js"></script>
<script src="js/lang/summernote-ko-KR.js"></script>
<form action="addCareer" method="post" id="addCareerForm_t" enctype="multipart/form-data">
	<!-- 추가 인자로 보내기 위해 hidden으로 던진다 -->
	<input type="hidden" name="sf_idx" value="${param.sf_idx}"/>
	<h2 class="title">강사 소개란 등록</h2>
	<table class="table">
		<colgroup>
		<col width="20%"/>
		<col width="80%"/>
		</colgroup>
		<caption>강사 소개란 등록 테이블</caption>
		<tbody>
			<tr>
				<th>경력</th>
				<td class="left"><textarea rows="10" cols="70" name="sf_career" id="sf_career" class="textarea"></textarea></td>
			</tr>
			<tr>
				<th>사진</th>
				<td class="left"><input type="file" name="file" id="sf_file" class="text"/></td>
			</tr>
		</tbody>
		<tfoot>
			<tr>
				<td colspan="2">
					<button type="button" onclick="addCareer(this.form)" class="btn">등록</button>
					<button type="button" onclick="location.href=''" class="btn">취소</button>
				</td>
			</tr>
		</tfoot>
	</table>
</form>