<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<div>
    <img src="${pageContext.request.contextPath }/image/title.png"/>
</div>
<c:if test="${fn:length(c_ar) < 5}">
    <c:forEach begin="1" end="${fn:length(c_ar)}" varStatus="vs">    
        <div onclick="course_log('${c_ar[vs.index-1].c_idx}')">${c_ar[vs.index-1].c_name}</div>
    </c:forEach>
    <c:forEach begin="${fn:length(c_ar)+1}" end="5" varStatus="vs">
        <div class="none_div"></div>
    </c:forEach>
</c:if>
<c:if test="${fn:length(c_ar) eq 5}">
    <c:forEach var="cvo" items="${c_ar}">    
        <div onclick="course_log('${cvo.c_idx}')">${cvo.c_name}</div>
    </c:forEach>
</c:if>
<div>
    <c:if test="${page.totalRecord > 0}">
        <c:if test="${requestScope.page.nowPage == 1 }">
            <a class="disable">◀</a>
        </c:if>	
        <c:if test="${requestScope.page.nowPage != 1 }">
            <a href="javascript:paging('${page.nowPage-1 }')">◀</a>
        </c:if>
        
        <c:if test="${page.nowPage != page.totalPage }">
            <a href="javascript:paging('${page.nowPage+1 }')">▶</a>
        </c:if>
        <c:if test="${page.nowPage == page.totalPage }">
            <a class="disable">▶</a>	
        </c:if>
    </c:if>
</div>