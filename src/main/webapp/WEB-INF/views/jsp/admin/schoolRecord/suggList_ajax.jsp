<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <table class="sugList table">
    	<colgroup>
    		<col width="10%"/>
    		<col width="35%"/>
    		<col width="15%"/>
    		<col width="10%"/>
    	</colgroup>
		<tbody>
		<%-- ===== 출력할 건의사항 항목 ===== --%>
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>작성일</th>
				<th>작성자</th>
				<th>답변여부</th>
			</tr>
			<c:if test="${page eq null && ar eq null}">
				<tr>
					<td colspan="5">
						답변할 질문이 없습니다.
					</td>
				</tr>
			</c:if>
			<c:forEach items="${ar}" varStatus="vs" var="svo">
				<tr>
					<c:if test="${page eq null}">
						<td>${vs.index+1}</td>
					</c:if>
					<c:if test="${page ne null}">
						<c:set var="num" value="${page.totalRecord - (page.numPerPage*(page.nowPage-1))}"/>
						<td>${num-vs.index}</td>
					</c:if>
					<td align="left"><a onclick="openSugg('${svo.qna_idx}')">${svo.qna_title}</a></td>
					<td>${svo.qna_write_date}</td>
					<td>${svo.qna_writer}</td>
					<td>
						<c:if test="${svo.c_check == true}">
							<a class="btn " onclick="openSugg('${svo.qna_idx}')">답변</a>
						</c:if>
						<c:if test="${svo.c_check == false}">
							<a class="btn red2 red3" onclick="openSugg('${svo.qna_idx}')">미답변</a>
						</c:if>
					</td>
				</tr>
			</c:forEach>
			
		</tbody>
		<%-- 화면 하단 page 번호 출력하는 부분 --%>
		<c:if test="${page ne null}">
			<tfoot>
				<tr>
					<td colspan="5">
						<ol class="page">
						<%-- ========== 이전버튼 만드는 부분 시작 ========== --%>
						<%-- startPage가 5보다 작을 경우
							이전page로 돌아가는 버튼 비활성화 후 생성 --%>
						<c:if test="${requestScope.page.startPage < requestScope.page.pagePerBlock }">
							<li class="disable">&lt;</li>
						</c:if>   
						<%-- startPage가 5보다 같거나 클 경우
							이전page로 돌아가는 버튼 활성화 후 생성 --%>
						<c:if test="${requestScope.page.startPage >= requestScope.page.pagePerBlock }">
							<li><a href="javascript:paging('${page.startPage - page.pagePerBlock }')">&lt;</a></li>
						</c:if>
						<%-- ========== 이전버튼 만드는 부분 끝 ========== --%>
						
						<%-- ========== page 번호 만드는 부분 시작 ==========--%>
						<c:forEach begin="${page.startPage }" end="${page.endPage }" varStatus="vs">
							<c:if test="${vs.index eq page.nowPage }">
							<li class="now">${vs.index }</li>
							</c:if>
							<c:if test="${vs.index ne page.nowPage}">
							<li><a href="javascript:paging('${vs.index}')">${vs.index}</a></li>
							</c:if>
						</c:forEach>
						<%-- ========== page 번호 만드는 부분 끝 ==========--%>
						
						<%-- ========== 다음버튼 만드는 부분 시작 ========== --%>
						<%-- endPage가 마지막 끝나는 page보다 작을 경우
							다음page로 가는 버튼 활성화 후 생성 --%>
						<c:if test="${page.endPage < page.totalPage }">
							<li><a href="javascript:paging('${page.startPage + page.pagePerBlock }')">&gt;</a></li>
						</c:if>
						<%-- endPage가 마지막 끝나는 page보다 크거나 같을 경우
							다음page로 가는 버튼 비활성화 후 생성 --%>
						<c:if test="${page.endPage >= page.totalPage }">
							<li class="disable">&gt;</li>   
						</c:if>
						<%-- ========== 다음버튼 만드는 부분 끝 ========== --%>
						</ol>
					</td>
				</tr>
			</tfoot>
		</c:if>
    </table>