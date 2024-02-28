<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<table class="table">
    <colgroup>
        <col width="10%"/>
        <col width="10%"/>
        <col width="10%"/>
        <col width="10%"/>
        <col width="10%"/>
        <col width="10%"/>
        <col width="10%"/>
        <col width="10%"/>
        <col width="*"/>
    </colgroup>
    <thead>
        <tr>
            <th rowspan="2">평가</th>
            <th rowspan="2">평가일시</th>
            <th rowspan="2">평가시간</th>
            <th rowspan="2">총배점</th>
            <th rowspan="2">평가유형</th>
            <th rowspan="2">수준</th>
            <th rowspan="2">문항수</th>
            <th rowspan="2">능력단위요소</th>
            <th rowspan="2">관리</th>
        </tr>
    </thead>

	<tbody>	
        <c:if test="${qt_ar eq null}">
            <td colspan="13">
                등록된 시험이 존재하지 않습니다.
            </td>
        </c:if>
        <c:if test="${qt_ar ne null}">
            <c:forEach var="qtvo" items="${qt_ar}" varStatus="vs">
                <tr>
                    <td>${qtvo.es_name}</td>
                    <td>${qtvo.es_date}</td>  
                    <td>${qtvo.es_time}</td>  
                    <td>${qtvo.es_totalScore}</td>  
                    <td>${qtvo.es_type}</td>  
                    <td>${qtvo.es_level}</td>  
                    <td>${qtvo.es_num_question}</td>  
                    <td>${qtvo.sk_idx}</td>
                    <td>
                        <button type="button" class="btn green" onclick="grading('${qtvo.qt_idx}')">시험 채점</button>
                    </td>
                </tr>
            </c:forEach>
        </c:if>
	</tbody>
</table>