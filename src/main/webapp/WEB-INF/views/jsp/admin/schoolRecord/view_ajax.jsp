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
		<tr>
			<th>
				제목
			</th>
			<td colspan="1">
				${vo.qna_title}
			</td>
		</tr>
		<tr>
			<th>
				작성자
			</th>
			<td>
				${vo.qna_writer}
			</td>
		</tr>
		<tr>
		<th>
			작성일
		</th>
		<td>
			${vo.qna_write_date}
		</td>
	</tr>
	</thead>
</table>
<div class="main_item">
	<textarea rows="20" cols="150" readonly class="textarea">
		${vo.qna_content}
	</textarea>
</div>
<table id="t1">
	<tbody>
		<!--답변 반복문처리-->
		<c:forEach items="${cvo}" varStatus="vs" var="cvo">
			<tr>
				<td>${vs.index+1}</td>
				<th>작성자</th>
				<td>${cvo.cm_writer}</td>
				<th>내용</th>
				<td>${cvo.cm_content}</td>
			</tr>
		</c:forEach>                                                                                                                                                                                                                                                                                                                                                                                                                              
	</tbody>
	<tfoot>
		<tr>
			<td colspan="3">
				<button onclick="javascript:location.href='suggestionList'" class="btn">목록</button>
				<button onclick="reply('${vo.qna_idx}')" class="btn">답변</button>
				<button class="btn red">삭제</button>
			</td>
		</tr>
	</tfoot>
</table>