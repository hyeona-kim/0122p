<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<table id="makeTime" class="table">
					<caption>과정별 교수계획서 및 학습 안내서 리스트</caption>
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
								<th>모집인원</th>
								<th>관리</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="vo2" items="${requestScope.ar }" varStatus="vs">
							<c:set var="num" value="${page.totalRecord - (page.numPerPage*(page.nowPage-1))}"/>
							<tr>
								<td>${num-vs.index}</td>
								<td>${vo2.c_name}</td>
								<td>W1805300001	</td>
								<td>${vo2.svo.sf_name}</td>
								<td>${vo2.start_date }</td>
								<td>${vo2.end_date }</td>
								<td>${vo2.c_day}</td>
								<td>${vo2.c_round_num }</td>
								<td>${vo2.c_peo_num}</td>
								<td><button type="button" onclick="set('${vo2.c_idx}')" class="btn">과정별 학습 안내서</button></td>
							</tr>
						</c:forEach>
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