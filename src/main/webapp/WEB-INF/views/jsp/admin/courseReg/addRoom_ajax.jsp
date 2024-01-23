<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/functions" %>

	
    
		<h2 id="hd">강의실관리</h2>
		<form action="Controller" method="post" name="rm">
         <input type="hidden" name="type"  value="addRoom"/>
		<table id="t1">
			<thead>
				<tr bgcolor="lightgray">
					<td>순번</td>
					<td>강의실명</td>
					<td>강의구분</td>
					<td>사용여부</td>
				</tr>
			
			
				<c:if test="${r_ar ne null}">
					<c:forEach var="rvo" items="${r_ar }">
						<tr>
							<td><strong>${rvo.r_idx }</strong><br/>
								<button type="button">삭제</button>
							</td>
							<td><input type="text" name="className" value="${rvo.r_name }"> </td>
							<td>
								<select name="roomSep">
								<c:if test="${rvo.r_sep  eq 1}">
										<option value="1" selected>실습</option>
										<option value="2">이론</option>
										<option value="3">겸용</option>
								</c:if>
								<c:if test="${rvo.r_sep  eq 2}">
										<option value="1">실습</option>
										<option value="2" selected>이론</option>
										<option value="3">겸용</option>
								</c:if>
								<c:if test="${rvo.r_sep  eq 3}">
										<option value="1">실습</option>
										<option value="2">이론</option>
										<option value="3" selected>겸용</option>
								</c:if>
								</select>
							</td>
							<td>
								<select name="use">
								<c:if test="${rvo.r_status eq 1 }">
									<option value="1" selected>사용</option>
									<option value="0">미사용</option>
								</c:if>
								<c:if test="${rvo.r_status eq 0 }">
									<option value="1" >사용</option>
									<option value="0" selected>미사용</option>
								</c:if>
								</select>
							</td>
						</tr>
					</c:forEach>
				</c:if>
			</thead>
			<tbody id="addRoom_tbody">
			</tbody>
			<tfoot>
				<tr>
					<td colspan="4" align="left">
						<input type="button" onclick="addRoom('${f:length(r_ar)}')" value="강의실추가"/>
					</td>
				</tr>
				<tr>
					<td colspan="4" align="left">
						<input type="submit"  id="sav"  value="저장"/>
						<input type="button"  id="cl" value="닫기"/>
					</td>
				</tr>
			</tfoot>
			
		</table>	
		</form>
			
