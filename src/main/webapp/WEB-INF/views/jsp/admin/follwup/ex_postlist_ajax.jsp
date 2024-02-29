<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


        <table id="makeTime" class="table">
        <caption>훈련현황 리스트</caption>
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
            <tfoot>
                <tr>
                    <td colspan="10">
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
            <tbody>

                <c:forEach var="vo2" items="${ar }" varStatus="vs">
        <c:set var="num" value="${page.totalRecord - ((page.nowPage-1) * page.numPerPage) }"/>
            <tr>
                <td>${num-(vs.index)}</td>
                <td>${vo2.c_name}</td>
                <%-- 강사 코드에따른 강사를 가져오는 Bean을 만든다 --%>
                <td>${vo2.svo.sf_name}</td>
                <td>${vo2.start_date }</td>
                <td>${vo2.end_date }</td>
                <td>${vo2.c_day}</td>
                <td>${vo2.c_round_num }</td>
                <td>${vo2.c_peo_num}</td>
                <td>
              <input type="button" value="사후관리현황표" class="btn" onclick="bt1">
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>