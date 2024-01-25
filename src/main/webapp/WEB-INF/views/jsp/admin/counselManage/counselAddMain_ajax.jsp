<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

		<table id="t1">
			<thead>
				<tr>
					<td >교육과정명</td>
					<td>${cvo.c_name}</td>
					<td>교육기간</td>
					<td>${cvo.start_date} ~ ${cvo.end_date}</td>
					<td>총회의수</td>
					<td>1</td>
				</tr>
			</thead>
		</table>
	</div>
	
	<div>
	<form action="counselAdd" method="post">
		<table id="t2">
			<thead id="t2head">
				
				<tr>
                    <td>회의일:</td>
					<td>회차</td>
					<td>상담기간</td>
					<td>상담목적</td>
					<td>담당</td>
				</tr>
                </tr>
			</thead>	
			<tbody>
				<c:forEach items="${ar}" var="vo">
					<tr>
						<td>${vo.ss_mday}</td>
						<td>${vo.ss_cnt}</td>
						<td>${vo.ss_day}</td>
						<td>${vo.co_vo.so_pp}</td>
						<td>5</td>
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
