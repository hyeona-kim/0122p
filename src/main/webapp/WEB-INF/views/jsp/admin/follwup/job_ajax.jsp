<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<table id="reg_table" class="table">
    <thead>
        <tr>
            <th>분류</th>
            <th>과정명</th>
            <th>담당교수</th>
            <th>교육기간</th>  
            <th>실시인원</th>   
            <th>수료</th> 
            <th>미수료중도탈락</th>
            <th>조기취업</th>
            <th>수료후 취업</th>
            <th>취업률</th>
            <th>수료율</th>
        </tr>
    </thead>
    <tbody>
    <c:if test="${ar ne null}">
        <c:forEach var="cvo" items="${ar}" varStatus="vs">
            <tr>
                <td bgcolor="${cvo.ctvo.ct_color}">${cvo.ctvo.ct_name}</td>
                <td>${cvo.c_name}</td>
                <td>${cvo.svo.sf_name}</td>
                <c:if test="${cvo.c_reg eq false}">
                    <td>${cvo.start_date}~${cvo.end_date}</td>
                </c:if>
                <td>${fn:length(cvo.tr_ar)}</td> <!--실시인원-->
                <td>${fn:length(cvo.tr_ar6)}</td><!--수료-->
                <td>${fn:length(cvo.tr_ar2)}</td><!--제적-->
                <td>X</td><!--조기취업-->
                <td>X</td><!--수료후 취업 -->
                <c:set var="all" value="${fn:length(cvo.tr_ar)}"/>
                <c:set var="a" value="${fn:length(cvo.tr_ar6)}"/>
                <c:set var="c" value="${fn:length(cvo.tr_ar4)}"/>
                <c:set var="d" value="${fn:length(cvo.tr_ar6)}"/>
                <c:if test="${all eq 0}">
                    <td>0</td>
                    <td>0</td>
                </c:if>
                <c:if test="${all ne 0}">
                    <td>X</td>
                    <td>${(c+d)/all*100}%</td>
                </c:if>
            </tr>                
        </c:forEach>
    </c:if>
    </tbody>
</table>