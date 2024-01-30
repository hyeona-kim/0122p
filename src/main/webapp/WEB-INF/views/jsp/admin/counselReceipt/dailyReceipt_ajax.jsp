<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<table id="reg_table">
    <thead>
        <tr>
            <td rowspan="2">훈련구분</td>
            <td rowspan="2">교육과정명</td>
            <td rowspan="2">교사</td>
            <td colspan="6">교육일정</td>
            <td colspan="2">승인현황</td>
            <td colspan="2">금일접수인원</td>
            <td colspan="2">등록인원</td>
            <td rowspan="2">현수강생</td>
            <td rowspan="2">제적인원</td>
        </tr>
        <tr>
            <td>요일</td>
            <td>교육시간</td>
            <td>교시</td>
            <td>수업시간</td>
            <td>교육중</td>
            <td>모집중</td>
            <td>강의실</td>
            <td>인원</td>
            <td>신청접수</td>
            <td>문의</td>
            <td>HRD등록</td>
            <td>총등록</td>
        </tr>
    </thead>
    
    <tbody>
        <c:forEach var="cvo" items="${c_ar}">
            <tr>
                <td>${cvo.ctvo.ct_name}</td>
                <td>${cvo.c_name}</td>
                <td>${cvo.svo.sf_name}</td>
                <td>${cvo.c_day}</td>
                <td>${cvo.total_hour}</td>
                <td>${cvo.c_time}</td>
                <td>수업시간</td>
                <c:if test="${cvo.c_reg eq false}">
                    <td>${cvo.start_date}~
                        <br/>${cvo.end_date}</td>
                    <td></td>
                </c:if>
                <c:if test="${cvo.c_reg eq true}">
                    <td></td>
                    <td>${cvo.start_date}~
                        <br/>${cvo.end_date}</td>
                </c:if>
                <td>${cvo.rvo.r_name}</td>
                <td>승인된 인원</td>
                <td>0</td>
                <td>0</td>
                <td>HRD등록</td>
                <td>${cvo.c_peo_num}</td>
                <td>${cvo.c_peo_num}-재적인원</td>
                <td>제적인원</td>
            </tr>
        </c:forEach>
    </tbody>
</table>