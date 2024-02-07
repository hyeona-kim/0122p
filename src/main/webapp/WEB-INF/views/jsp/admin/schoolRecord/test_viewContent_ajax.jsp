<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="${pageContext.request.contextPath }/js/jquery-ui.min.js"></script>
<h2 class="title">제목:${bvo.bd_subject}</h2>
<div class="main_item main_color">작성자:***&nbsp;|&nbsp;등록일:${bvo.bd_write_date}&nbsp;|&nbsp;조회수:${bvo.bd_hit}</div>
<table class="table">
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
			<td class="left" colspan="3" id="bd_content">
				<textarea class="textarea" rows="20" cols="120" readonly>${bvo.bd_content}</textarea>	
			</td>
		</tr>
	</tbody>
		
</table>
<table id="t1">
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
</table>
<div class="main_item align_center">
	<button onclick="javascript:location.href='boardMainList?c_idx=${bvo.c_idx}'" id="close_btn" class="btn">목록</button>
	<button onclick="javascript:reply('${bvo.bd_idx}', '${cPage}', '${bvo.c_idx}')" class="btn">답변</button>
	<button onclick="javascript:location.href=''" class="btn">인쇄</button>
</div>