<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<table class="table">
	<h2 class="title">제목:${vo.sg_subject}</h2>
	<div class="main_item align_right main_color">
		작성자:***&nbsp;|&nbsp;등록일:${vo.sg_write_date}&nbsp;|&nbsp;조회수:${vo.sg_hit}
	</div>
	<caption>고충 및 건의사항 보기 테이블</caption>
	<colgroup>
		<col width="20%"/>
		<col width="60%"/>
		<col width="15%"/>
	</colgroup>
	<thead>
		<tr>
			<th>과정명</th>
			<td colspan="2">${vo.c_name}</td>
		</tr>
	</thead>
</table>
<div class="main_item">
	<textarea rows="15" cols="106" readonly class="textarea">
		${vo.sg_content}
	</textarea>
</div>
<table id="t1">
	<tbody>
		<tr>
			<td>이전글△</td>
			<td class="left">이전글 제목</td>
			<td>대표강사</td>
		</tr>
		<tr>
			<td>다음글▽</td>
			<td class="left">다음글 제목</td>
			<td>대표강사</td>
		</tr>
	</tbody>
	<tfoot>
		<tr>
			<td colspan="3">
				<button onclick="javascript:location.href='suggestionList'" class="btn">목록</button>
				<button onclick="reply('${vo.sg_idx}')" class="btn">답변</button>
				<button class="btn">수정</button>
				<button class="btn red">삭제</button>
				<button onclick="javascript:location.href=''" class="btn">인쇄</a>
			</td>
		</tr>
	</tfoot>
</table>