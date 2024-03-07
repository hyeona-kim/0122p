<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<table id="" class="table">		
			<caption>과정별시간표만들기</caption>
			<thead>
				<tr>
					<th>번호</th>
					<th>과정명</th>
					<th>과정코드</th>
					<th>담당교수</th>
					<th>개강일</th>
					<th>종료일</th>
				</tr>
			</thead>
						<tfoot>
							<tr>
				
							</tr>
						</tfoot>
					<tbody>	
							<c:forEach var="cvo" items="${c_ar }" varStatus="vs">
							<c:set var="num" value="${page.totalRecord - (page.numPerPage*(page.nowPage-1))}"/>
							<tr>
                                <td></td>
								<td></td>
								<td></td>
								<td>
									<button type="button" class="btn">훈련생별 개별 성적표</button>
								</td>
							</tr>
						</c:forEach>
			</tbody>
		</table>