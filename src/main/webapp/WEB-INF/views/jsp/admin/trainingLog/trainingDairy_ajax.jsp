<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<table class="table">
    <colgroup>
        <col width="5%"/>
        <col width="5%"/>
        <col width="8%"/>
        <col width="5%"/>
        <col width="5%"/>
        <col width="5%"/>
        <col width="5%"/>
        <col width="5%"/>
        <col width="22%"/>
        <col width="5%"/>
        <col width="5%"/>
        <col width="24%"/>
    </colgroup>
    <thead>
        <tr>
            <th rowspan="2">
                선택
                <input type="checkbox"/>
            </th>
            <th rowspan="2">번호</th>
            <th rowspan="2">작성일</th>
            <th rowspan="2">재적</th>
            <th rowspan="2">출석</th>
            <th rowspan="2">결석</th>
            <th rowspan="2">지각</th>
            <th rowspan="2">조퇴</th>
            <th rowspan="2">특이사항</th>
            <th colspan="2">결제현황</th>
            <th rowspan="2">관리</th>
        </tr>
        <tr>
            <th>관리자</th>
            <th>책임자</th>
        </tr>
    </thead>
    <tfoot>
        <tr>
            <td colspan="12">
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
        <c:if test="${td_ar eq null}">
            <td colspan="12">
                등록된 훈련일지가 존재하지 않습니다.
            </td>
        </c:if>
        <c:if test="${td_ar ne null}">
            <c:forEach var="tdvo" items="${td_ar}" varStatus="vs">
                <c:set var="num" value="${page.totalRecord - (page.numPerPage*(page.nowPage-1))}"/>
                <!--td_idx, write_date, td_attend, td_tardy, td_earlyLeave, td_significant, c_idx, admin_check, ceo_check-->
                <tr>
                    <td>
                        선택
                        <input type="checkbox"/>
                    </td>
                    <td>${num-vs.index}</td>
                    <td>${tdvo.write_date}</td>
                    <td>${fn:length(cvo.tr_ar3)}</td>
                    <td>${fn:length(cvo.tr_ar3)}</td>
                    <td>${tdvo.td_attend}</td>
                    <td>${tdvo.td_tardy}</td>
                    <td>${tdvo.td_earlyLeave}</td>
                    <td>${tdvo.td_significant}</td>
                    <c:if test="${tdvo.admin_check eq 0}">
                        <td style="color: blue;">결</td>
                    </c:if>
                    <c:if test="${tdvo.admin_check eq 1}">
                        <td style="color: red;">미</td>
                    </c:if>
                    <c:if test="${tdvo.ceo_check eq 0}">
                        <td style="color: blue;">결</td>
                    </c:if>
                    <c:if test="${tdvo.ceo_check eq 1}">
                        <td style="color: red;">미</td>
                    </c:if>
                    <td>
                        <button type="button" class="btn green">훈련일지</button>
                        <button type="button" class="btn blue">수정</button>
                        <button type="button" class="btn red">삭제</button>
                    </td>
                </tr>
            </c:forEach>
        </c:if>
	</tbody>
</table>