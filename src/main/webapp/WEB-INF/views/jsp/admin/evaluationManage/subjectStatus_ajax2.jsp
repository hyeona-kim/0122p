<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

    <c:if test="${es_ar ne null }">
        <c:forEach var="esvo" items="${es_ar}" varStatus="vs">
            <tr>    
                <td>${esvo.es_name}</td>
                <td>${esvo.es_date}</td>
                <td>${esvo.es_type}</td>
                <td>${esvo.es_examStatus}</td>
                <td>${esvo.es_gradingStatus}</td>
                <td><button type="button" class="btn">응시확인</button></td>
            </tr>
        </c:forEach>
    </c:if> 
    <c:if test="${es_ar eq null }">
            <tr>    
                <td></td>
                <td></td>
                <td></td>
                <td>미출제</td>
                <td>미제출</td>
                <td><button type="button" class="btn">응시확인</button></td>
            </tr>
    </c:if>       