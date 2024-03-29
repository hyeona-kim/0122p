<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<table class="table">
    <colgroup>
        <col width="10%"/>
        <col width="15%"/>
        <col width="15%"/>
        <col width="15%"/>
        <col width="15%"/>
        <col width="*"/>
    </colgroup>
    <thead>
        <tr>
            <th>순번</th>
            <th>학생이름</th>
            <th>연락처</th>
            <th>응시 및 채점여부</th>
            <th>관리</th>
        </tr>
    </thead>

	<tbody>
        <c:if test="${tr_ar ne null}">
            <c:forEach var="tvo" items="${tr_ar}" varStatus="vs">
                <tr>
                    <td>${vs.index+1}</td>
                    <td>${tvo.tr_name}</td>  
                    <td>${tvo.tr_phone}</td>  
                    <td>
                    <c:set var="v" value="0"/>
                    <c:set var="s" value="0"/>
                    <c:if test="${tvo.gc_ar ne null}">
                        <c:forEach var="gcvo" items="${tvo.gc_ar}" varStatus="vs2">
                            <c:if test="${gcvo.gc_answer eq NONE and v eq 0}">  <%-- 값이 하나라도 들어있지 않을 경우에는 더이상 set할 이유가 없음 --%>
                                <c:set var="v" value="1"/>
                                <c:if test="${gcvo.gc_status ne 0 and s eq 0}"> <%-- 하나라도 채점이 안되어 있을 경우에는 더이상 set할 이유가 없음 --%>
                                    <c:set var="s" value="1"/>
                                </c:if>
                            </c:if>
                        </c:forEach>

                        <c:if test="${v eq 1}">
                            미응시
                        </c:if>
                        <c:if test="${v eq 0 and s eq 0}">
                            채점완료
                        </c:if>
                        <c:if test="${v eq 0 and s eq 1}">
                            미채점
                        </c:if>
                    </c:if>
                    <c:if test="${tvo.gc_ar eq null}">
                        미응시
                    </c:if>
                    </td>  
                    <td>
                        <button type="button" class="btn green" onclick="scoreResultList('${tvo.tr_idx}')">채점결과보기</button>
                    </td>
                    <input type="hidden" value="${tvo.tr_idx}" name="tr_idx">
                </tr>
            </c:forEach>
        </c:if>
	</tbody>
</table>