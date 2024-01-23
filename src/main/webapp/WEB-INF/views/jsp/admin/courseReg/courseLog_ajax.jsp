<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
		<table id="makeCourse">
			<caption>교육과정리스트</caption>
							<thead>
								<tr>
									<th>번호</th>
									<th>과정명</th>
									<th>과정코드</th>
									<th>과정타입</th>
									<th>담당교수</th>
									<th>개강일</th>
									<th>종료일</th>
									<th>요일</th>
									<th>회차</th>
									<th>모집인원</th>
									<th>강의실</th>
									<th>관리</th>
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
									<td>${requestScope.ct_names[vs.index]} </td>
									<td>${requestScope.sf_names[vs.index]} </td>
									<td>${cvo.start_date }</td>
									<td>${cvo.end_date }</td>
									<td>월화수목금</td>
									<td>${cvo.c_round_num }</td>
									<td>${cvo.c_peo_num }</td>
									<td>${requestScope.r_names[vs.index]} </td>
									<td>
										<button type="button">교과목 등록/수정</button>
										<button type="button">학습안내서 등록/수정</button>
										<input type="hidden" name="c_idx" value="${cvo.c_idx }"/>
										<button type="button" onclick="editC('${cvo.c_idx}')">수정</button>
										<button type="button" id="c_del_btn" onclick="del('${cvo.c_idx}')">삭제</button>
									</td>
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