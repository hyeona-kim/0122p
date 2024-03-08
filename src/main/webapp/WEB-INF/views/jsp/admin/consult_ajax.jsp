<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!-- 상담-->
<!--ac_idx, ac_name, ac_phone, ac_email, ac_title, ac_content, ac_write_date, ac_type, ac_gender, m_id, ac_answer, ac_answer_date-->
<h2 class="title">상담내역</h2>
<table class="table">
    
    <tr>
        <th>
            이름
        </th>
        <td>${asvo.ac_name}</td>
        <th>
            전화번호
        </th>
        <td>${asvo.ac_phone}</td>
    </tr>
    <tr>
        <th>
            이메일
        </th>
        <td>${asvo.ac_email}</td>
        <th>
            성별
        </th>
        <td>${asvo.ac_gender}</td>
    </tr>
    <tr>
        <th>상담일</th>
        <td colspan="3">
            <input type="date" id="ac_answer_date" class="text" value="${asvo.ac_answer_date}"/>
            <input type="hidden" id="ac_idx" value="${asvo.ac_idx}"/>
             &nbsp;&nbsp;<button type="button" id="c_add_btn" class="btn">등록</button>
        </td>
    </tr>
</table>