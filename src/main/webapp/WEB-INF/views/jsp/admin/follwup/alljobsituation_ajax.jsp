<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


        <table id="makeTime" class="table">
        <caption>훈련현황 리스트</caption>
            <thead>
                <tr>
                    <th>순번</th>
                    <th>이름</th>
                    <th>취업처</th>
                    <th>과정명</th>
                    <th>연락처</th>
                    <th>주민번호</th>
                    <th>취업일</th>
                </tr>
            </thead>
            <tfoot>
                <tr>
                    <td colspan="7">
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
                <c:forEach var="vo7" items="${tvo }" varStatus="vs">
                    <c:set var="num" value="${page.totalRecord - ((page.nowPage-1) * page.numPerPage) }"/>
                        <input type="hidden" name="c_idx" value="${param.c_idx}">
                        <tr>
                            <td>${num-(vs.index)}</td>
                            <td>${vo7.tr_name }</td>
                            <td>?</td>
                            <td>${vo7.cvo.c_name}</td>
                            <td>${vo7.tr_hp}</td>
                            <td>${vo7.tr_rrn}</td>
                            <td>?</td>
                                <input type="hidden" id="nowstatus${vs.index}" value="${vo7.tr_nowstatus}" class="sts"/>                       
                                <input type="hidden" name="tr_idx" value="${vo7.tr_idx}">
                        </tr>
                </c:forEach>
            </tbody>
    </table>