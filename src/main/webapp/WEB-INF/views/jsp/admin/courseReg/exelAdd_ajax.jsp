<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<h2 id="e_h2" class="title">강사/시설/교과목 엑셀등록</h2>
<div id="e_div" class="main_item" style="color: #154790;"><b>*HRD에서 받은 엑셀 파일을 조작없이 업로드해주세요</b></div>
<form action="add_subject" method="post" enctype="multipart/form-data">
    <input type="hidden" name="listSelect" value="3"/>
    <input type="hidden" name="c_idx" value="${param.c_idx}"/>
    <table id="e_table" class="table">
        <colgroup>
            <col width="20%"/>
            <col width="80%"/>
        </colgroup>
        <tr>
            <th>첨부파일</th>
            <td><input type="file" name="s_file" class="text"/></td>
        </tr>
    </table>
    <div id="btns" class="main_item align_center">
        <button type="submit" class="btn">저장</button>
        <button type="button" id="cc_cancle" class="btn">취소</button>
    </div>
</form>
 <c:if test="${s_ar ne null}">
    <table id="e_table" class="table">
        <colgroup>
            <col width="25%"/>
            <col width="25%"/>
            <col width="25%"/>
            <col width="25%"/>
        </colgroup>
        <thead>
            <tr>
                <th >구분</th>
                <th colspan="2">명칭</th>
                <th>코드</th>
            </tr>
        </thead>
        <tbody>
    
        <c:if test="${s_ar ne null}">
            <c:forEach var="svo" items="${s_ar}">
            <tr>
                <td>과목</td>
                <td>(${svo.s_type})${svo.s_title}</td>
                <td></td>
                <td></td>
            </tr>
            </c:forEach>
        </c:if>
        <c:if test="${sf_ar ne null}">
            <c:forEach var="sfvo" items="${sf_ar}">
            <tr>
                <td>강사</td>
                <td>(${sfvo.sf_name})${sfvo.sf_code}</td>
                <td></td>
                <td>${sfvo.sf_code}</td>
            </tr>
            </c:forEach>
        </c:if>
        <c:if test="${r_ar ne null}">
            <c:forEach var="rvo" items="${r_ar}">
            <tr>
                <td>시설</td>
                <td>(${rvo.r_name})${rvo.r_sep}</td>
                <td></td>
                <td>(${rvo.r_name})</td>
            </tr>
            </c:forEach>
        </c:if>
        </tbody>
    </table>
</c:if>

