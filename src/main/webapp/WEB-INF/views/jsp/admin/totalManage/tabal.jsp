<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
		<table id="makeCourse">
			<caption>교육과정리스트</caption>
							<thead>
								<tr>
									<th>연번</th>
									<th>과정명</th>
									<th>회차</th>
									<th>개강일</th>
									<th>종료일</th>
									<th>과정타입</th>
									<th>담당교수</th>
									<th>모집인원<br/>/실시(수료)인원</th>
									<th>사전평가</th>
									<th>평가관리</th>
									<th>상담관리</th>
									<th>훈련일자</th>
									<th>보강훈련</th>
									<th>사후취업지원</th>
									<th>훈련생별</th>
								</tr>
							</thead>
							<tbody>
							<c:if test="${ar ne null }">
							<c:forEach var="cvo" items="${ar }" varStatus="vs">
							<c:set var="num" value="${page.totalRecord - (page.numPerPage*(page.nowPage-1))}"/>
								<tr>
									<td>${num-vs.index}</td>
									<td>${cvo.c_name }</td>
									<td>W1805300001</td>
									<td>${cvo.ctvo.ct_name} </td>
									<td>${cvo.svo.sf_name} </td>
									<td>${cvo.start_date }</td>
									<td>${cvo.end_date }</td>
									<td>${cvo.c_day }</td>
									<td><button type="button">사전평가 평가현황</button></td>
									<td><button type="button">교과목별 평가현황</button></td>
									<td><button type="button">미작성</button></td>
									<td><button type="button">미작성</button></td>
									<td><button type="button">미작성</button></td>
									<td><button type="button">미작성</button></td>
									<td><button type="button">훈련생별보기</button></td>
								</tr>
							</c:forEach>
							</c:if>
							<c:if test="${ar eq null }">
								<tr>
									<td colspan="12">검색 결과가 없습니다</td>
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