<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<div class="title">
    문의 - ${asvo.ac_title}
</div>
<div class="main_item" >
    <textarea class="textarea" style="width: 100%;" rows="12" disabled>${asvo.ac_content}</textarea>
</div>
<div class="main_item" style="font-weight: bold; color: #154790;">
    답변
</div>
<c:if test="${asvo.ac_answer ne null}">
    <div class="main_item">
        <textarea class="textarea" style="width: 100%;" rows="12" id="ac_answer">${asvo.ac_answer}</textarea>
    </div> 
</c:if>
<c:if test="${asvo.ac_answer eq null}">
    <div class="main_item">
        <textarea class="textarea" style="width: 100%;" placeholder="답변을 입력해주세요" rows="12" id="ac_answer"></textarea>
    </div> 
</c:if>
<div class="main_item align_center">
    <input type="button" value="등록/수정" class="btn" id="i_add_btn"/>
    <input type="hidden" id="ac_idx" value="${asvo.ac_idx}"/>
</div>