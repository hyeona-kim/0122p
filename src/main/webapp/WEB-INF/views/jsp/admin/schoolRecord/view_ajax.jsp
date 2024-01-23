<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<table>
	<caption>고충 및 건의사항 보기 테이블</caption>
	<colgroup>
		<col width="20%"/>
		<col width="60%"/>
		<col width="15%"/>
	</colgroup>
	<thead>
		<tr>
			<th>과정명</th>
			<%-- [수정필요] 
			 	 훈련과정명을 가져와야함 --%>
			<td colspan="2">훈련과정테스트</td>
		</tr>
	</thead>
	<tbody>
		<tr>
			<th colspan="3">${param.subject}</th>
		</tr>
		<tr>
			<td class="left" colspan="3">작성자:***&nbsp;|&nbsp;등록일:${param.date}&nbsp;|&nbsp;조회수:${param.hit}</td>
		</tr>
		<tr>
			<td class="left" colspan="3"><textarea rows="10" cols="100">${param.content}</textarea></td>
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
				<a href="Controller?type=suggestionList" class="sug_list_btn sug_btn">목록</a>
				<a href="javascript:reply('${param.subject}','${param.content}')" class="sug_reply_btn sug_btn">답변</a>
				<a href="" class="sug_print_btn sug_btn">인쇄</a>
			</td>
		</tr>
	</tfoot>
</table>