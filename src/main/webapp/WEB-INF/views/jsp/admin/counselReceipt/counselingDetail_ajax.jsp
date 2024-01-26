<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<table id="makeTime">
					<caption>과정별 교수계획서 및 학습 안내서 리스트</caption>
						<thead>
							<tr>
								<th>선택<br> <input type="checkbox"> </th>
								<th>번호</th>
								<th>최초상담자</th>
								<th>상담날짜</th>
								<th>성명</th>
								<th>연락처</th>
								<th>과정구분</th>
								<th>과정명</th>
								<th>현재상태</th>
								<th>관리여부</th>
								<th>취소사유</th>
								<th>다음예정일</th>
								<th>상담내용</th>
								<th>문자</th>
							</tr>
						</thead>
						
						<tbody>
							<c:forEach var="vo2" items="${ar }" varStatus="vs">
							<c:set var="num" value="${page.totalRecord - (page.numPerPage*(page.nowPage-1))}"/>
							<tr>
								<td><input type="checkbox"></td>
								<td>${vs.index+1}</td>
								<td>${vo2.sf_idx}</td>
								<td>${vo2.cd_date}</td>
								<td>${vo2.cd_name}</td>
								<td>${vo2.cd_phone }</td>
								<td>${vo2.cd_sep }</td>
								<td>${vo2.c_idx}</td>
								<td>${vo2.cd_status }</td>
								<td>${vo2.cd_manageStatus}</td>
								<td>${vo2.cd_cancel}</td>
								<td>${vo2.cd_nextDate}</td>
								<td>${vo2.cd_subject}</td>
								<td><input type="checkbox"></td>
							</tr>
						</c:forEach>
					</tbody>

					<tfoot>
						<tr>
							<td colspan="14">
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