<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<div id ="d1">
		<table id="t1">
			<thead id="t2head">
				<tr>
					<td >교육과정명</td>
					<td>${cvo.c_name}</td>
					<td>교육기간</td>
					<td>${cvo.start_date} ~ ${cvo.end_date}</td>
					<td>총회의수</td>
				<c:if test="${ss_cnt ne null}">
					<td>${ss_cnt}</td>
				</c:if>
					<c:if test="${ss_cnt eq null}">
					<td>0</td>
				</c:if>
				</tr>
			</thead>
		</table>
	</div>
	
	<div id="d2">
	<form action="counselAdd" method="post">
		<table id="t2">
			<colgroup>
				<col width="10%"/>
				<col width="5%"/>
				<col width="25%"/>
				<col width="90"/>
				<col width="10"/>
				
			</colgroup>
			<thead id="t2head">
				
				<tr>
                    <td>회의일</td>
					<td>회차</td>
					<td>상담기간</td>
					<td>상담목적</td>
					<td>담당</td>
				</tr>
                </tr>
			</thead>	
			<tbody>
				<c:forEach items="${ar}" var="vo" varStatus="vs">
					<tr>
						<td>${vo.ss_mday}</td>
						<td>${ss_cnt-vs.index}</td>
						<td>${vo.ss_day}</td>
						<td>${vo.ss_p}</td>
						<td>${cvo.svo.sf_name}</td>
					</tr>
				</c:forEach>
			</tbody>
			<tfoot>
				<tr>
					<td colspan="5">
						<button type="button" onclick="counselA('${cvo.c_idx}')">보고서등록</button>
						<button type="button" onclick="">인쇄</button>
						<button type="button" id="cc_cancle">취소</button>
					</td>
				</tr>
			</tfoot>
		</table>
	</form>
</div>
