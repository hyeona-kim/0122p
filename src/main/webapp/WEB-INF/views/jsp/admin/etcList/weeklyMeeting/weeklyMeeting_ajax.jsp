<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<table id="staffList">
	
	<tbody>
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>작성자</th>
			<th>회의일</th>
			<th>관리</th>
		</tr>
	</tbody>
	
	<tfoot>
			<c:forEach items="${wk_ar}" varStatus="vs" var="vo">
			<c:set var="num" value="${page.totalRecord - (page.numPerPage*(page.nowPage-1))}"/>
				<tr>
					<td>${vs.index+1}</td>
					<td>${vo.wk_title}</td>
					<td>${vo.wk_name}</td>
					<td>${vo.wk_date}</td>
					<td>
						<input type="button" value="상세보기/수정" onclick="editWeeklyMeeting('${vo.wk_idx}')">
						<input type="button" value="삭제" onclick="delWk('${vo.wk_idx}')">
					</td>
				</tr>
			</c:forEach>
			<tr>
				<td colspan="12">
					<ol class="page">
					<c:if test="${requestScope.page.startPage < requestScope.page.pagePerBlock }">
						<li class="disable">&lt;</li>
					</c:if>	

					<c:if test="${requestScope.page.startPage >= requestScope.page.pagePerBlock }">
						<li><a href="javascript:paging('${page.startPage-page.pagePerBlock }')">&lt;</a></li>
					</c:if>

					<c:forEach begin="${page.startPage }" end="${page.endPage }" varStatus="vs">
						<c:if test="${vs.index eq page.nowPage }">
							<li class="now">${vs.index }</li>
						</c:if>
						<c:if test="${vs.index ne page.nowPage }">
							<li><a onclick="paging('${vs.index}')">${vs.index}</a></li>
						</c:if>
					</c:forEach>

					<c:if test="${page.endPage < page.totalPage }">
						<li><a href="javascript:paging('${page.startPage + page.pagePerBlock }')">&gt;</a></li>
					</c:if>
					<c:if test="${page.endPage >= page.totalPage }">
						<li class="disable">&gt;</li>	
					</c:if>
				  </ol>
			  </td>
			</tr>
			
	</tfoot>
</table>