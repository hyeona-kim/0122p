<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
		<table id="makeCounsel">
			<caption>일자별 상담관리</caption>
							<thead>
								<tr>
									<th>번호</th>
									<th>이름</th>
									<th>과정명</th>
									<th>개강일</th>
									<th>종료일</th>
									<th>연락처</th>
									<th>주민번호</th>
									<th>상태</th>
									<th>최종상담일</th>
									<th>관리</th>
								</tr>
							</thead>
							<tbody>
							<c:if test="${ar ne null }">
							<c:forEach var="vo" items="${ar }" varStatus="vs">
							<c:set var="num" value="${page.totalRecord - (page.numPerPage*(page.nowPage-1))}"/>
								<tr>
									<td>${num-vs.index}</td>
									<td>${vo.tvo.tr_name} </td>
									<td>${vo.cvo.c_name }</td>
									<td>${vo.cvo.start_date }</td>
									<td>${vo.cvo.end_date }</td>
									<td>${vo.tvo.tr_hp }</td>
									<td>${vo.tvo.tr_rrn }</td>
									<c:if test="${vo.tvo.tr_status eq 0}">
										<td>수강</td>
									</c:if>
									<c:if test="${vo.tvo.tr_status eq 1}">
										<td>수료</td>
									</c:if>
									<c:if test="${vo.tvo.tr_status eq 2}">
										<td>제적</td>
									</c:if>
									<td>${vo.tvo.ss_end}</td>
									<td>
										<button type="button" id="so_del_btn" onclick="counselList('${vo.so_idx}')">상담내역 및 등록</button>
										<input type="hidden" name="so_idx" value="${vo.so_idx }"/>
									</td>
								</tr>
							</c:forEach>
							</c:if>
							<c:if test="${ar eq null }">
								<tr>
									<td colspan="12">데이터가 없습니다</td>
								</tr>
							</c:if>
							</tbody>
							<tfoot>
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