<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    


<table id="us_table">
				<thead>
					<tr>
						<th>순번</th>
						<th>과목명</th>
						<th>능력단위명</th>
						<th>NCS</th>
						<th>교강사</th>
						<th>분류번호</th>
						<th>능력단위요소</th>
						<th>관리현황</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="vo2" items="${requestScope.ar }" varStatus="vs">
					<c:set var="num" value="${page.totalRecord - (page.numPerPage*(page.nowPage-1))}"/>
					<tr>
						<td>${vs.index+1}</td>
						<td>${vo2.us_name}</td>
						<td>${vo2.s_idx}</td>
						<td>${vo2.us_ncs }</td>
						<td>${vo2.sk_idx }</td>
						<td>${vo2.t_idx}</td>
						<td>${vo2.us_cnum }</td>
						<td><button type="button"  onclick="set5('skill','${vo2.us_idx}')">등록/수정</button></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>

	