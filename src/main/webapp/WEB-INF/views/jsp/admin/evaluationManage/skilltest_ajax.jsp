<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<table id="makeCourse" class="table">		
			<caption>과정별시간표만들기</caption>
			<thead>
				<tr>
					<th>번호</th>
					<th>과정명</th>
					<th>과정코드</th>
					<th>담당교수</th>
					<th>개강일</th>
					<th>종료일</th>
					<th>요일</th>
					<th>회차</th>
					<th>모집</th>
					<th>관리</th>
				</tr>
			</thead>
			<tfoot>
				<tr>
					<td colspan="10">
						<ol class="page">
				<c:if test="${requestScope.page.startPage < requestScope.page.pagePerBlock }">
					<li class="disable">&lt;</li>
				</c:if>	
		
				<c:if test="${requestScope.page.startPage >= requestScope.page.pagePerBlock }">
					<c:if test="${param.select != null}">
						<li><a href="javascript:paging('${page.startPage-page.pagePerBlock }')">&lt;</a></li>
					</c:if>
				</c:if>
	
				<c:forEach begin="${page.startPage }" end="${page.endPage }" varStatus="vs">
					<c:if test="${vs.index eq page.nowPage }">
						<li class="now">${vs.index }</li>
					</c:if>
					<c:if test="${vs.index ne page.nowPage }">
						<li><a href="javascript:paging('${vs.index}')">${vs.index}</a></li>
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
					<tbody>	
							<c:forEach var="cvo" items="${c_ar }" varStatus="vs">
							<c:set var="num" value="${page.totalRecord - (page.numPerPage*(page.nowPage-1))}"/>
							<tr>
                                <td>${num-vs.index}</td>
								<td>${cvo.c_name}</td>
								<td>과정코드</td>
								<td>${cvo.svo.sf_name}</td>
								<td>${cvo.start_date }</td>
								<td>${cvo.end_date }</td>
								<td>${cvo.c_day}</td>
								<td>${cvo.c_round_num }</td>
								<td>${cvo.c_peo_num}</td>
								<td>
									<button type="button" class="btn">능력단위별 종합평가서</button>
								</td>
							</tr>
						</c:forEach>
			</tbody>
		</table>