<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<table class="table">
    <colgroup>
        <col width="5%"/>
        <col width="5%"/>
        <col width="10%"/>
        <col width="7%"/>
        <col width="8%"/>
        <col width="30%"/>
    </colgroup>
    <thead>
        <tr>
            <th rowspan="2">평가명</th>
            <th rowspan="2">평가일</th>
            <th rowspan="2">평가유형</th>
            <th rowspan="2">출제여부</th>
            <th rowspan="2">채점여부(채점인원/총인원)</th>
            <th rowspan="2">채점결과</th>
        </tr>
    </thead>

	<tbody>	
        <c:if test="${es_ar eq null}">
            <td colspan="13">
                등록된 평가가 존재하지 않습니다.
            </td>
        </c:if>
        <c:if test="${es_ar ne null}">
            <c:forEach var="esvo" items="${es_ar}" varStatus="vs">
                <tr>
                    <td>${esvo.es_name}</td>
                    <td>${esvo.es_date}</td>  
                    <td>${esvo.es_type}</td>  
                    <td>${esvo.es_examStatus}</td>  
                    <td>${esvo.es_gradingStatus}</td>  
                    <td>
                        <button type="button" class="btn green" onclick="chcekTraineeScoreList('${esvo.es_idx}')">훈련생별 결과보기</button>
                    </td>

                </tr>
            </c:forEach>
        </c:if>
	</tbody>
</table>