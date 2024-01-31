<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
		<table id="makeCounsel">
			<caption>일자별 상담관리</caption>
							<thead>
								<tr>
									<th>번호</th>
									<th>상담일</th>
									<th>훈련생</th>
									<th>과정명</th>
									<th>구분</th>
									<th>상담자</th>
									<th>상담내용</th>
									<th>조치사항</th>
									<th>관리</th>
								</tr>
							</thead>
							<tbody>
							<c:if test="${ar ne null }">
							<c:forEach var="vo" items="${ar }" varStatus="vs">
							<c:set var="num" value="${page.totalRecord - (page.numPerPage*(page.nowPage-1))}"/>
								<tr>
									<td>${num-vs.index}</td>
									<td>${vo.so_day }</td>
									<td><a href="javascript:counselList('${vo.cvo.c_idx}', '${vo.tvo.tr_idx}')">${vo.tvo.tr_name}</a></td>
									<td>${vo.cvo.c_name }</td>
									<td>${vo.so_menu }</td>
									<td>${vo.so_tname }</td>
									<td>${vo.so_subject }</td>
									<td>${vo.so_pd }</td>
									<td>
										<button type="button" id="so_del_btn" onclick="del('${vo.so_idx}')">삭제</button>
										<input type="hidden" name="so_idx" value="${vo.so_idx }"/>
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