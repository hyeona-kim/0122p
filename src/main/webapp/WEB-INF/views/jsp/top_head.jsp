<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<article class="logo">
    <a href="clickLogo"><img alt="로고" src="${pageContext.request.contextPath }/image/ict_logo.png" /></a>
    <span>서비스종료일:${vo.sf_fire_date} / 접속자:${vo.sf_name} / <a class="a" href="logout">로그아웃</a></span>
</article>