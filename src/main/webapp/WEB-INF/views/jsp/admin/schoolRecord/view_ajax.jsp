<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<table class="table">
	<h2 class="title"></h2>
	<caption>고충 및 건의사항 보기 테이블</caption>
	<colgroup>
		<col width="20%"/>
		<col width="50%"/>
		<col width="15%"/>
		<col width="10%"/>
	</colgroup>
	<thead>
		<!-- 문의 글 qna_title/qna_writer/qna_write_date-->
		<tr>
			<th>제목:</th>
		</tr>
	</thead>
</table>
<table id="t1">
	<tfoot>
		<tr>
			<td colspan="3">
				<button onclick="javascript:location.href='suggestionList'" class="btn">목록</button>
				<button onclick="reply('${vo.qna_idx}')" class="btn">답변</button>
			</td>
		</tr>
	</tfoot>
</table>