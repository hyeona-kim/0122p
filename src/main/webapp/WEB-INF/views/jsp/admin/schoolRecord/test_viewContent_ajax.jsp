<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="${pageContext.request.contextPath }/js/jquery-ui.min.js"></script>
<table>
	<caption>게시판 보기 테이블</caption>
	<colgroup>
		<col width="20%"/>
		<col width="60%"/>
		<col width="15%"/>
	</colgroup>
	<thead>
		<tr>
			<th>과정명</th>
			<td colspan="2">${bvo.c_name}</td>
		</tr>
	</thead>
	<tbody>
		<tr>
			<th colspan="3">${bvo.bd_subject}</th>
		</tr>
		<tr>
			<td class="left" colspan="3">작성자:***&nbsp;|&nbsp;등록일:${bvo.bd_write_date}&nbsp;|&nbsp;조회수:${bvo.bd_hit}</td>
		</tr>
		<tr>
			<td class="left" colspan="3" id="bd_content">${bvo.bd_content}</td>
		</tr>
	</tbody>
	<tfoot>
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
		<tr>
			<td colspan="3">
				<a href="javascript:location.href='boardMainList?c_idx=${bvo.c_idx}'" id="close_btn" class="bo_list_btn bo_btn">목록</a>
				<a href="javascript:reply('${bvo.bd_idx}', '${cPage}', '${bvo.c_idx}')" class="bo_reply_btn bo_btn">답변</a>
				<a href="" class="bo_print_btn bo_btn">인쇄</a>
			</td>
		</tr>
	</tfoot>
</table>