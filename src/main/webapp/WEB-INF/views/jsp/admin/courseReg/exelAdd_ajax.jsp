<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<h2 id="e_h2">강사/시설/교과목 엑셀등록</h2>
<div id="e_div"><b>*HRD에서 받은 엑셀 파일을 조작없이 업로드해주세요</b></div>
<table id="e_table">
    <colgroup>
        <col width="20%"/>
        <col width="80%"/>
    </colgroup>
    <tr>
        <th bgcolor="#eeeeee">첨부파일</th>
        <td><input type="file" name="file"/></td>
    </tr>
</table>
<div id="btns" style="text-align: center; margin-top: 20px;" >
    <button type="button">저장</button>
    <button type="button" id="cc_cancle">취소</button>
</div>
 <c:if test="${sfvo ne null || svo ne null || rvo ne null}">
    
    <table id="e_table">
        <colgroup>
            <col width="25%"/>
            <col width="25%"/>
            <col width="25%"/>
            <col width="25%"/>
        </colgroup>
        <thead>
            <tr>
                <th bgcolor="#eeeeee">구분</th>
                <th colspan="2" bgcolor="#eeeeee">명칭</th>
                <th bgcolor="#eeeeee">코드</th>
            </tr>
        </thead>
        <tbody>
        <c:if test="${sfvo ne null}">
            <c:forEach var="sfvo" items="${sfvo}">
            <tr>
                <td>강사</td>
                <td>[${cvo.start_date}]${sfvo.sf_name}_${sfvo.sf_code}</td>
                <td></td>
                <td>${sfvo.sf_name}_${sfvo.sf_code}</td>
            </tr>
            </c:forEach>
        </c:if>
        <c:if test="${rvo ne null}">
            <c:forEach var="rvo" items="${rvo}">
            <tr>
                <td>시설</td>
                <td>${rvo.r_name}(${rvo.r_sep})</td>
                <td></td>
                <td>${rvo.r_name}(${rvo.r_sep})</td>
            </tr>
            </c:forEach>
        </c:if>
        <c:if test="${svo ne null}">
            <c:forEach var="svo" items="${svo}">
            <tr>
                <td>과목</td>
                <td>(${svo.s_type})${svo.s_title}</td>
                <td></td>
                <td></td>
            </tr>
            </c:forEach>
        </c:if>
        </tbody>
    </table>
</c:if>

