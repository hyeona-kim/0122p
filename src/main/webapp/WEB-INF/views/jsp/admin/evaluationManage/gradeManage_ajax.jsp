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
        <c:if test="${esvo eq null}">
            <td colspan="13">
                등록된 성적이 존재하지 않습니다.
            </td>
        </c:if>
        <c:if test="${esvo ne null}">
            
                <tr>
                    <td>${esvo.es_name}</td>
                    <td>${esvo.es_date}</td>  
                    <td>${esvo.es_time}</td>  
                    <td>${esvo.es_totalScore}</td>  
                    <td>${esvo.es_type}</td>  
                    <td>${esvo.es_level}</td>  
                    <td>${esvo.es_num_question}</td>  
                    <td>${esvo.sk_idx}</td>
                    <td>
                        <button type="button" class="btn green" onclick="scoreList('${esvo.es_idx}')">평가별 학생 리스트</button>
                    </td>
                </tr>
            
        </c:if>
	</tbody>
</table>