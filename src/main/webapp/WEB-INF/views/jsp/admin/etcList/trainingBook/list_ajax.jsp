<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <table class="sugList table">
    	<colgroup>
    		<col width="5%"/> <%-- 번호 --%>
    		<col width="6%"/> <%-- 구분 --%>
    		<col width="25%"/> <%-- 교재명 --%>
    		<col width="10%"/> <%-- 저자 --%>
    		<col width="11%"/> <%-- 출판사 --%>
    		<col width="6%"/> <%-- 발행년도 --%>
    		<col width="6%"/> <%-- 교재가격 --%>
    		<col width="6%"/> <%-- 지급방법 --%>
    		<col width="6%"/> <%-- 결제여부 --%>
    		<col width="9%"/> <%-- 이미지 --%>
    		<col width="10%"/> <%-- 관리 --%>
    	</colgroup>
		<tbody>
		<%-- ===== 출력할 교재현황 목록 항목 ===== --%>
			<tr>
				<th>번호</th>
				<th>구분</th>
				<th>교재명</th>
				<th>저자</th>
				<th>출판사</th>
				<th>발행년도</th>
				<th>교재가격</th>
				<th>지급방법</th>
				<th>결제여부</th>
				<th>이미지</th>
				<th>관리</th>
			</tr>
			<c:if test="${vo ne null}"> <%-- vo는 로그인 정보 --%>
			<%-- ===== 로그인 정보가 있다면 반복문을 통해
						교재현황 목록 출력 ===== --%>
				<c:if test="${ar ne null}">
					<c:forEach items="${ar}" varStatus="vs" var="bvo">
						<c:set var="num" value="${page.totalRecord - (page.numPerPage*(page.nowPage-1))}"/>
						<tr>
							<td>${num-vs.index}</td>
							<td>
								<%-- 구분이 0이면 시중교재, 1이면 자체교재 로 출력 --%>
								<c:if test="${bvo.tb_type eq '0'}">시중교재</c:if>
								<c:if test="${bvo.tb_type eq '1'}">자체교재</c:if>
							</td>
							<td>${bvo.tb_title}</td>
							<td>${bvo.tb_writer}</td>
							<td>${bvo.tb_publisher}</td>
							<td>${bvo.tb_pub_date}</td>
							<td>${bvo.tb_price}</td>
							<td>
                                <%-- 지급방법이 0이면 무상, 1이면 유상 으로 출력 --%>
                                <c:if test="${bvo.tb_provide_type eq '0'}">무상</c:if>
                                <c:if test="${bvo.tb_provide_type eq '1'}">유상</c:if>
                            </td>
							<td>
								<%-- 지급방법이 0(무상)이면 공백, 1(유상)이면 결제버튼 활성화 --%>
								<c:if test="${bvo.tb_provide_type eq '1'}">
									<button class="btn green">결제</button>
								</c:if>
							</td>
                            <td>
                                <button class="btn green" id="img_btn">교재 이미지</button>
                            </td>
                            <td>
                                <button class="btn blue" id="edit_btn">수정</button>
                                <button class="btn red" onclick="delBook('${bvo.tb_idx}')">삭제</button>
                            </td>
						</tr>
					</c:forEach>
				</c:if>
				<c:if test="${ar eq null}">
					<tr><td colspan="11">검색 결과가 없습니다</td></tr>
				</c:if>
			</c:if>
		</tbody>
		<%-- 화면 하단 page 번호 출력하는 부분 --%>
		<tfoot>
			<tr>
				<td colspan="11">
					<ol class="page">
						<%-- ========== 이전버튼 만드는 부분 시작 ========== --%>
						<%-- startPage가 5보다 작을 경우 이전page로 돌아가는 버튼 비활성화 후 생성 --%>
						<c:if test="${page.startPage < page.pagePerBlock}">
							<li class="disable">&lt;</li>
						</c:if>	
						<%-- startPage가 5보다 같거나 클 경우 이전page로 돌아가는 버튼 활성화 후 생성 --%>
						<c:if test="${page.startPage >= page.pagePerBlock && search_flag eq null && notice_flag eq null }">
							<li><a href="javascript:paging('${page.startPage-page.pagePerBlock}')">&lt;</a></li>
						</c:if>
						<c:if test="${page.startPage >= page.pagePerBlock && search_flag ne null && notice_flag eq null}">
							<li><a href="javascript:searchSugg('${page.startPage-page.pagePerBlock}')">&lt;</a></li>
						</c:if>
						<%-- ========== 이전버튼 만드는 부분 끝 ========== --%>
						
						<%-- ========== page 번호 만드는 부분 시작 ==========--%>
						<c:forEach begin="${page.startPage }" end="${page.endPage }" varStatus="vs">
							<c:if test="${vs.index eq page.nowPage }">
								<li class="now">${vs.index }</li>
							</c:if>
							<c:if test="${vs.index ne page.nowPage && search_flag eq null && notice_flag eq null}">
								<li><a href="javascript:paging('${vs.index}')">${vs.index}</a></li>
							</c:if>
							<c:if test="${vs.index ne page.nowPage && search_flag ne null && notice_flag eq null}">
								<li><a href="javascript:searchSugg('${vs.index}')">${vs.index}</a></li>
							</c:if>
						</c:forEach>
						<%-- ========== page 번호 만드는 부분 끝 ==========--%>
						
						<%-- ========== 다음버튼 만드는 부분 시작 ========== --%>
						<%-- endPage가 마지막 끝나는 page보다 작을 경우 다음page로 가는 버튼 활성화 후 생성 --%>
						<c:if test="${page.endPage < page.totalPage && search_flag eq null && notice_flag eq null}">
							<li><a href="javascript:paging('${page.startPage + page.pagePerBlock}')">&gt;</a></li>
						</c:if>
						<c:if test="${page.endPage < page.totalPage && search_flag ne null && notice_flag eq null}">
							<li><a href="javascript:searchSugg('${page.startPage + page.pagePerBlock}')">&gt;</a></li>
						</c:if>
						<%-- endPage가 마지막 끝나는 page보다 크거나 같을 경우 다음page로 가는 버튼 비활성화 후 생성 --%>
						<c:if test="${page.endPage >= page.totalPage }">
							<li class="disable">&gt;</li>	
						</c:if>
						<%-- ========== 다음버튼 만드는 부분 끝 ========== --%>
					</ol>
				</td>
			</tr>
		</tfoot>
    </table>