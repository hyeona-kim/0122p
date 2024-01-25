<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
		<table id="makeCounsel">
			<caption>상담관리</caption>
							<thead>
								<tr>
									<th>번호</th>
									<th>과정명</th>
									<th>담당교수</th>
									<th>개강일</th>
									<th>종료일</th>
									<th>요일</th>
									<th>회차</th>
									<th>모집인원</th>
									<th>관리</th>
								</tr>
							</thead>
							<tbody>
							<c:if test="${c_ar ne null }">
							<c:forEach var="vo" items="${c_ar }" varStatus="vs">
							<c:set var="num" value="${c_page.totalRecord - (c_page.numPerPage*(c_page.nowPage-1))}"/>
								<tr>
									<td>${num-vs.index}</td>
									<td>${vo.c_name }</td>
									<td>${vo.svo.sf_name} </td>
									<td>${vo.start_date }</td>
									<td>${vo.end_date }</td>
									<td>${vo.c_day }</td>
									<td>${vo.c_round_num }</td>
									<td id="peo_num">${vo.c_peo_num }</td>
									<td>
										<button type="button" onclick="set3('${vo.c_idx }')">교육생별 상담내역</button>
										<button type="button" onclick="set2('${vo.c_idx}')">상담결과보고</button>
										<input type="hidden" name="c_idx" value="${vo.c_idx }"/>
									</td>
								</tr>
							</c:forEach>
							</c:if>
							<c:if test="${c_ar eq null }">
								<tr>
									<td colspan="12">검색 결과가 없습니다</td>
								</tr>
							</c:if>
							</tbody>
							<tfoot>
						<tr>
							<td colspan="12">
								<ol class="page">
			<c:if test="${requestScope.c_page.startPage < requestScope.c_page.pagePerBlock }">
				<li class="disable">&lt;</li>
			</c:if>	
	
			<c:if test="${requestScope.c_page.startPage >= requestScope.c_page.pagePerBlock }">
				<li><a href="javascript:paging('${c_page.startPage-c_page.pagePerBlock }')">&lt;</a></li>
			</c:if>

			<c:forEach begin="${c_page.startPage }" end="${c_page.endPage }" varStatus="vs">
				<c:if test="${vs.index eq c_page.nowPage }">
					<li class="now">${vs.index }</li>
				</c:if>
				<c:if test="${vs.index ne c_page.nowPage }">
					<li><a onclick="paging('${vs.index}')">${vs.index}</a></li>
				</c:if>
			</c:forEach>
	
			<c:if test="${c_page.endPage < c_page.totalPage }">
				<li><a href="javascript:paging('${c_page.startPage + c_page.pagePerBlock }')">&gt;</a></li>
			</c:if>
			<c:if test="${c_page.endPage >= c_page.totalPage }">
				<li class="disable">&gt;</li>	
			</c:if>
                              </ol>
                          </td>
						</tr>
					</tfoot>
						</table>