<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<table class="table">
    <colgroup>
        <col width="10%"/>
        <col width="15%"/>
        <col width="10%"/>
        <col width="10%"/>
        <col width="10%"/>
        <col width="40%"/>
    </colgroup>
    <thead>
        <tr>
            <th rowspan="2">번호</th>
            <th rowspan="2">과목명</th>
            <th rowspan="2">능력단위명</th>
            <th rowspan="2">NCS</th>
            <th rowspan="2">교강사</th>
            <th rowspan="2">관리현황</th>
        </tr>
    </thead>

	<tbody>	
        <c:if test="${s_ar eq null}">
            <td colspan="12">
                등록된 과목이 존재하지 않습니다.
            </td>
        </c:if>
        <c:if test="${s_ar ne null}">
            <c:forEach var="svo" items="${s_ar}" varStatus="vs">
                <tr>
                    <td>${vs.index+1}</td>
                    <td>${svo.s_title}</td>
                    <td>${svo.us_name}</td>
                    <td>${svo.s_type}</td>
                    <td>관리자</td>  
                    <td>
                        <button type="button" class="btn green" onclick="evaluationInfo('${svo.s_idx}')">평가기본정보</button>
                        <button type="button" class="btn blue" onclick="editTraining('${tdvo.td_idx}')">시험출제</button>
                        <button type="button" class="btn blue" onclick="gradeManage('${svo.s_idx}')">성적관리</button>
                        <button type="button" class="btn blue" onclick="editTraining('${tdvo.td_idx}')">평가현황</button>
                        <button type="button" class="btn blue" onclick="editTraining('${tdvo.td_idx}')">시험결과오픈</button>
                        <button type="button" class="btn blue" onclick="editTraining('${tdvo.td_idx}')">평가별 시험예시</button>
                    </td>

                </tr>
            </c:forEach>
        </c:if>
	</tbody>
</table>