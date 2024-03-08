<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<article class="logo" id="logo">
    <a href="clickLogo"><img alt="로고" src="${pageContext.request.contextPath }/image/ict_logo.png" /></a>
    <span>
        <c:if test="${main_select eq 1 && vo.sf_tcr eq 1}">
            <!-- 관리자 모드로 로그인한 경우, 교강사 권한이 있는경우-->
            <button type="button" class="btn yellow" onclick="location.href ='clickLogo?mode=change'">교강사모드</button> 
        </c:if>
        <c:if test="${main_select eq 2 && vo.sf_mgr eq 1}">
            <!-- 교강사 모드로 로그인한 경우, 관리자 권한이 있는경우-->
            <button type="button" class="btn yellow"  onclick="location.href ='clickLogo?mode=change'">관리자모드</button> 
        </c:if>
        &nbsp;&nbsp;접속자:${vo.sf_name} / 
        <a class="a" href="/logoutlll">로그아웃</a>
    </span>
</article>