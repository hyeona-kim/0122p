<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

		<div id="staffWrap">
		<div id="staffList_top">디지털컨비젼스 평가정보관리 과정 과목현황</div>
		<div id="courseLog_Table">	
			
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
				<c:if test="${ar ne null}">
				<c:forEach var="vo2" items="${requestScope.ar }" varStatus="vs">
					<tr>
						<td>${vs.index+1}</td>
						<td>${vo2.s_title}</td>
						<td>${vo2.us_name}</td>
						<td>${vo2.s_type }</td>
						<td>${vo2.sf_name }</td>
						<td>${vo2.s_category_num}</td>
						<td>
							<c:forEach var="skvo" items="${vo2.sk_ar}">
								${skvo.sk_name},
							</c:forEach>
						</td>
						<td><button type="button"  onclick="set5('skill','${vo2.s_idx}','${vo2.c_idx}')">등록/수정</button></td>
					</tr>
				</c:forEach>
				</c:if>
				<c:if test="${ar eq null}">
					<tr>
						<td colspan="8">해당 과정의 능력요소가 존재하지 않습니다.</td>
					</tr>
				</c:if>
			</tbody>
			</table>
		</div>

