<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<div>
    <img src="${pageContext.request.contextPath }/image/title.png"/>
</div>
<c:if test="${fn:length(td_ar) < 5}">
    <c:forEach begin="1" end="${fn:length(td_ar)}" varStatus="vs">    
        <div>
            ${td_ar[vs.index-1].write_date}
            <td>
                <button type="button" class="btn green">훈련일지</button>
                <button type="button" class="btn blue">수정</button>
                <button type="button" class="btn red">삭제</button>
            </td>
        </div>
    </c:forEach>
    <c:forEach begin="${fn:length(td_ar)+1}" end="5" varStatus="vs">
        <div class="none_div"></div>
    </c:forEach>
</c:if>
<c:if test="${fn:length(td_ar) eq 5}">
    <c:forEach var="tdvo" items="${td_ar}">    
        <div>
            ${tdvo.write_date}
            <td>
                <button type="button" class="btn green">훈련일지</button>
                <button type="button" class="btn blue">수정</button>
                <button type="button" class="btn red">삭제</button>
            </td>
        </div>
    </c:forEach>
</c:if>
<div>
    <button type="button" onclick="write_btn('${c_idx}')">등록</button>
</div>
