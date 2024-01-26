<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<h2 id="cf_h2">"${cvo.c_name}"교수계획서 및 학습안내서 </h2>
<form action="course_file" enctype="multipart/form-data" method="post" name="file_frm">
<div id="cf_wrap">
<table id="cf_table">
    <colgroup>
        <col width="30%"/>
        <col width="30%"/>
        <col width="40%"/>
    </colgroup>
    <thead>
        <tr>
            <th>구분</th>
            <th>다운로드</th>
            <th>파일 올리기</th>
        </tr>
    </thead>
    <tbody>
        <c:if test="${fvo ne null}">
            <c:forEach var="fvo" items="${fvo}" varStatus="vs">
            <tr>
                <td name="f_info">${fvo.f_info} <input type="hidden" name="f_info" value="${fvo.f_info}"/></td>
                <c:if test="${fvo.f_name ne null}">
                    <td><a href="coursefileDown?f_name=${fvo.f_name}">${fvo.f_name}</a><input type="hidden" name="f_name" value="${fvo.f_name}"/></td>
                </c:if>
                <c:if test="${fvo.f_name eq null}">
                    <td></td>
                </c:if>
                <td>
                    <input type="file" name="file${vs.index+1}" value="파일 선택"/>
                </td>
                <input name="f_idx" type="hidden" value="${fvo.f_idx}"/>
            </tr>
            </c:forEach>
        </c:if>

        <c:if test="${fvo eq null}">
            <tr>
                <td name="f_info">운영계획서<input type="hidden" name="f_info" value="운영계획서"/></td>
                <td name="f_name"></td>
                <td>
                    <input type="file" name="file1" value="파일 선택"/>       
                </td>
            </tr>
            <tr>
                <td name="f_info">학습안내서<input type="hidden" name="f_info" value="학습안내서"/></td>
                <td name="f_name"></td>
                <td>
                    <input type="file" name="file2" value="파일 선택"/>
                </td>
            </tr>
            <tr>
                <td name="f_info">OT설명자료<input type="hidden" name="f_info" value="OT설명자료"/></td>
                <td name="f_name"></td>
                <td>
                    <input type="file" name="file3" value="파일 선택"/>
                </td>
            </tr>
            <tr>
                <td name="f_info">평가계획서<input type="hidden" name="f_info" value="평가계획서"/></td>
                <td name="f_name"></td>
                <td>
                    <input type="file" name="file4" value="파일 선택"/>
                </td>
            <tr>
                <td name="f_info">평가도구적절성<input type="hidden" name="f_info" value="평가도구적절성"/></td>
                <td name="f_name"></td>
                <td>
                    <input type="file" name="file5" value="파일 선택"/>
                </td>
            </tr>
            <tr>
                <td name="f_info">훈련일일시간표<input type="hidden" name="f_info" value="훈련일일시간표"/></td>
                <td name="f_name"></td>
                <td>
                    <input type="file" name="file6" value="파일 선택"/>    
                </td>
            </tr>
        </c:if>
    </tbody>
    <tfoot>
        <tr>
            <td colspan="3">
                <button type="submit" >저장</button>
                <button type="button" id="cc_cancle">목록</button>
            </td>
        </tr>
    </tfoot>
</table>
</div>
<input name="c_idx" type="hidden" value="${cvo.c_idx}"/>
<input name="listSelect" type="hidden" value="${param.listSelect}"/>
<input name="cPage" type="hidden" value="${param.cPage}"/>
</form>