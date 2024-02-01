<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
   <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
   <ul id="tr_ul">
    <c:if test="${t_ar ne null}">
        <c:forEach var="tvo" items="${t_ar}">
            <li class="tr_li">
                <div class="l_div">
                    <c:if test="${tvo.file_name eq null}">
                        <img src="${pageContext.request.contextPath }/image/total_trainee.png" alt="이미지"/></div>
                    </c:if>
                    <c:if test="${tvo.file_name ne null}">
                        <img src="${pageContext.request.contextPath }/upload_file/${tvo.file_name}" alt="" width="64" height="64"/></div>
                    </c:if>
                <div class="info" onclick="traineeSelect('${tvo.tr_idx}',this)">
                    <div>
                        <c:if test="${tvo.gender eq true}">
                            <span class="man">●</span>
                        </c:if>
                        <c:if test="${tvo.gender eq false}">
                            <span class="woman">●</span>
                        </c:if>
                        <span>${tvo.tr_name}</span>
                    </div>
                    <div>
                        <span>${tvo.tr_rrn}</span>
                        <c:if test="${tvo.tr_nowstatus eq 6}">
                            <span class="giveup">■</span>
                        </c:if>
                        <c:if test="${tvo.tr_nowstatus eq 4}">
                            <span class="employ">■</span>
                        </c:if>
                        <c:if test="${tvo.tr_nowstatus eq 3}">
                            <span class="finish">■</span>
                        </c:if>
                        <c:if test="${tvo.tr_nowstatus eq 7}">
                            <span class="none">■</span>
                        </c:if>
                        <c:if test="${tvo.tr_nowstatus eq 8}">
                            <span class="weeding">■</span>
                        </c:if>
                    </div>
                </div>
            </li>
        </c:forEach>
    </c:if>
    <c:if test="${t_ar eq null}">
        <div align="center" style="border-top: 1px solid #dedede; border-bottom: 1px solid #dedede; padding: 3px; color: #dedede;">데이터 없음.</div>
    </c:if>
   </ul>