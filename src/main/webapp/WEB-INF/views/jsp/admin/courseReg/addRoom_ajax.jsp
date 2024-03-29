<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/functions" %>
		<h2 id="hd" class="title">강의실관리</h2>
		<form action="addRoom" method="post" name="rm">
		<table id="t1" class="table">
			<thead>
				<tr>
					<th>순번</th>
					<th>강의실명</th>
					<th>강의구분</th>
					<th>사용여부</th>
				</tr>
				<c:if test="${r_ar ne null}">
					<c:forEach var="rvo" items="${r_ar }">
						<tr>
							<td><strong>${rvo.r_idx }</strong><br/>
								<button type="button" class="btn red">삭제</button>
							</td>
							<td><input type="text" name="className" value="${rvo.r_name }" class="text"> </td>
							<td>
								<select name="roomSep" class="select">
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
								<select name="use" class="select">
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
						<input type="button" onclick="addRoom('${f:length(r_ar)}')" value="강의실추가" class="btn"/>
					</td>
				</tr>
				<tr>
					<td colspan="4" align="left">
						<input type="submit"  id="sav"  value="저장" class="btn"/>
						<input type="button"  id="cl" value="닫기" class="btn"/>
					</td>
				</tr>
			</tfoot>
			<input type="hidden" name="cPage" value="${param.cPage}"/>
			<input type="hidden" name="listSelect" value="${param.listSelect}"/>
		</table>	
		</form>
			
