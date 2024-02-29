<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<table id="reg_table" class="table">
    <thead>
        <tr>
            <th>과정명</th>
            <th>NCS세분류</th>
            <th>훈련시작일</th>  
            <th>훈련종료일</th>   
            <th>실시인원</th> 
            <th>수료인원</th>
            <th>중도탈락</th>
            <th>미수료</th>
            <th>조기취업</th>
            <th>수료후 취업</th>
            <th>취업률</th>
            <th>탈락율</th>

        </tr>
    </thead>
    <tbody>
    <c:if test="${ar ne null}">
        <c:forEach var="cvo" items="${ar}" varStatus="vs">
            <tr>
                <td>${cvo.c_name}</td>
                <td>ncs</td>
                <td>${cvo.start_date}</td>
                <td>${cvo.end_date}</td>
                <td>${fn:length(cvo.tr_ar)}</td>
                <td>0</td>
                <td>0</td>
                <td>0</td>
                <td>0</td>
                <td>0</td>
                <td>0</td>
                <td>0</td>
            </tr>                
        </c:forEach>
    </c:if>
 
    
    </tbody>
</table>