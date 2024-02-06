<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<div class="title">상담결과 보고</div>
	<div id ="d1">
		<table id="t1" class="table">
			<thead id="t2head">
				<tr>
					<th >교육과정명</th>
					<td>${cvo.c_name}</td>
					<th>교육기간</th>
					<td>${cvo.start_date} ~ ${cvo.end_date}</td>
					<th>총회의수</th>
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
		<table id="t2" class="table">
			<colgroup>
				<col width="10%"/>
				<col width="5%"/>
				<col width="25%"/>
				<col width="90"/>
				<col width="10"/>
			</colgroup>
			<thead id="t2head">
				
				<tr>
                    <th>회의일</th>
					<th>회차</th>
					<th>상담기간</th>
					<th>상담목적</th>
					<th>담당</th>
				</tr>
                </tr>
			</thead>	
			<tbody>
				<c:if test="${ar ne null}">
				<c:forEach items="${ar}" var="vo" varStatus="vs">
					<tr>
						<td><a href="javascript:viewCounselAdd('${vo.ss_idx}')">${vo.ss_mday}</a></td>
						<td>${ss_cnt-vs.index}</td>
						<td>${vo.ss_day}</td>
						<td>${vo.ss_p}</td>
						<td>${cvo.svo.sf_name}</td>
					</tr>
				</c:forEach>
				</c:if>
				<c:if test="${ar eq null}">
					<tr>
						<td colspan="5">데이터가 없습니다.</td>
					</tr>
				</c:if>
			</tbody>
			<tfoot>
				<tr>
					<td colspan="5">
						<button type="button" onclick="counselA('${cvo.c_idx}')" class="btn">보고서등록</button>
						<button type="button" onclick="" class="btn">인쇄</button>
						<button type="button" id="cc_cancle" class="btn">취소</button>
					</td>
				</tr>
			</tfoot>
		</table>
	</form>
</div>
