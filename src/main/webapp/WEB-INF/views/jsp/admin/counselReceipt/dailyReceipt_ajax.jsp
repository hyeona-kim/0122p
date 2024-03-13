<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<table id="reg_table" class="table">
    <thead>
        <tr>
            <th rowspan="2">훈련구분</th>
            <th rowspan="2">교육과정명</th>
            <th rowspan="2">교사</th>
            <th colspan="6">교육일정</th>
            <th colspan="2">승인현황</th>
            <th colspan="2">금일접수인원</th>
            <th colspan="2">등록인원</th>
            <th rowspan="2">현수강생</th>
            <th rowspan="2">제적인원</th>
        </tr>
        <tr>
            <th>요일</th>
            <th>교육시간</th>
            <th>교시</th>
            <th>수업시간</th>
            <th>교육중</th>
            <th>모집중</th>
            <th>강의실</th>
            <th>인원</th>
            <th>신청접수</th>
            <th>문의</th>
            <th>HRD등록</th>
            <th>총등록</th>
        </tr>
    </thead>
    
    <tbody>
        <c:forEach var="cvo" items="${c_ar}" varStatus="vs">
            <tr>
                <td bgcolor="${cvo.ctvo.ct_color}">${cvo.ctvo.ct_name}</td>
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
                <td class="receipt${cvo.c_idx}">0</td> <!--신청-->
                <td class="inquiry${cvo.c_idx}">0</td> <!--문의-->
                <td>HRD등록</td>
                
                <td>${fn:length(cvo.tr_ar)}</td><!--모집인원말고 과정별 trainee의 수를 가져오기.-->
                <td>${fn:length(cvo.tr_ar3)}</td>
                <td>${fn:length(cvo.tr_ar2)}</td>
            </tr>
        </c:forEach>
    </tbody>
</table>