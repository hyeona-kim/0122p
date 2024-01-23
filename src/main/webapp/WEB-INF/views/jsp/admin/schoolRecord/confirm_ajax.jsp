<%@page import="mybatis.dao.TrainuploadDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

				<table id="makeTime">
				<caption>훈련생확인서류등록 리스트</caption>
					<thead>
						<tr>
							<th colspan="3">서류선택</th>
						</tr>
					</thead>
					<tbody>
					<c:forEach items="${ar }" var="va">
					<tr>
						<td><input type="checkbox"></td>
						<td>${va.subject}</td>
						<td><input type="date"></td>
					</tr>
					</c:forEach>
					
					
						<%-- <c:forEach var="vo3" items="${requestScope.ar }" varStatus="vs">
				<c:set var="num" value="${page.totalRecord - ((page.nowPage-1) * page.numPerPage) }"/>
					<tr>
						<td>${num+(vs.index)-2 }</td>
						<td><a href="Contoller?type=view&tn_idx=${vo3.tn_idx }&cPage=${page.nowPage }">
							${vo3.subject } ${vo3.subject }</a></td>
						<td>${vo3.file_name }</td>
						<td>
						<input type="button" value="수정"
							onclick="edit('${vo3.tn_idx}')"/>
						<input type="button" onclick="traindel('${vo3.tn_idx}')" value="삭제">
						<input type="button" value="확인서류보기">
						</td>
					</tr>
				</c:forEach> --%>

				</tbody>	
			</table>
				<div class="bb1">
					<button type="button"   onclick="">저장</button>
    				<button type="button"   onclick="javascript:location.href='Controller?type=trainconfirm'">닫기</button>
				</div>
				