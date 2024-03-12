
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<table class="table">
    <colgroup>
        <col width="5%"/>
        <col width="5%"/>
        <c:if test="${sb_ar ne null}">
            <h1>${fn:length(sb_ar)}!</h1>
            <c:forEach begin="1" end="${fn:length(sb_ar)}">
                <col width="*"/>
            </c:forEach>
        </c:if>
        <c:if test="${sb_ar eq null}">
            <h1>null</h1><col width="*"/>
        </c:if>
        <col width="5%"/>
        <col width="5%"/>
        <col width="10%"/>
    </colgroup>
    <thead>
        <tr>
            <th rowspan="3">번호</th>
            <th rowspan="3">성명</th>
            <c:if test="${sb_ar ne null}">
                <th colspan="${fn:length(sb_ar)}">과목명</th>
            </c:if>
            <c:if test="${sb_ar eq null}">
                <th rowspan="3">과목명</th>
            </c:if>
            <th rowspan="3">평균</th>
            <th rowspan="3">순위</th>
            <th rowspan="3">관리</th>
        </tr>
        <c:if test="${sb_ar ne null}">
            <tr>
                <c:forEach var="svo" items="${sb_ar}">
                    <th rowspan="2">${svo.s_title}</th>
                </c:forEach>
            </tr>
        </c:if>
    </thead>

	<tbody>	
        <c:if test="${cvo.tr_ar eq null}">
            <c:set var="k" value="${6+fn:length(sb_ar)}"/>
            <td colspan="${k}">
                학생이 존재하지 않습니다.
            </td>
        </c:if>
        <c:if test="${cvo.tr_ar ne null}">
            <c:forEach var="tvo" items="${cvo.tr_ar}" varStatus="vs">
                <c:set var="total" value="totalScore${vs.index}" />
                <tr>
                    <td>${vs.index+1}</td>
                    <td>${tvo.tr_name}</td>
                    <c:forEach var="s" items="${requestScope[total]}" varStatus="ss">
                        <td>${s}</td>
                    </c:forEach>
                    <td>${average[vs.index]}</td>
                    <td>${rank[vs.index]}</td>  
                    <td>
                        <c:choose>
                            <c:when test="${tvo.tr_nowstatus eq 1}" >
                                수강예정
                            </c:when>
                            <c:when test="${tvo.tr_nowstatus eq 3}" >
                                조기수료
                            </c:when>
                            <c:when test="${tvo.tr_nowstatus eq 4}" >
                                조기취업
                            </c:when>
                            <c:when test="${tvo.tr_nowstatus eq 5}" >
                                수료
                            </c:when>
                            <c:when test="${tvo.tr_nowstatus eq 6}" >
                                수강포기
                            </c:when>
                            <c:when test="${tvo.tr_nowstatus eq 7}" >
                                미수료
                            </c:when>
                            <c:when test="${tvo.tr_nowstatus eq 8}" >
                                수강예정
                            </c:when>
                            <c:otherwise>
                            </c:otherwise>
                        </c:choose>
                    </td>
                </tr>
            </c:forEach>
        </c:if>
	</tbody>
</table>