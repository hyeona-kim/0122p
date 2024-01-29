<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/functions" %>

		<h2 id="hd">능력단위 등록/수정</h2>
		<form action="skillAdd" method="post" name="skill_frm">
		<input type="hidden" value="${c_idx}" name="c_idx">
		<input type="hidden" value="${s_idx}" name="s_idx">
		<input type="hidden" value="upskill_add" name="upskill">
		<table id="t1">
			<thead>
				<tr bgcolor="lightgray">
					<td>순번</td>
					<td>능력단위요소명</td>
				</tr>
			</thead>
			<tbody id="addUpskill_tbody">
				<c:if test="${ar ne null}">
					<c:forEach var="rvo" items="${requestScope.ar }" varStatus="vs">
						<tr>
							<td><strong>${vs.index+1}</strong><br/>
								<button type="button" onclick="skill_delete('${rvo.sk_idx}','${s_idx}','${c_idx}')">삭제</button>
							</td>
							<td><input type="text" name="sk_name" value="${rvo.sk_name }"> </td>
						</tr> 
						<input type="hidden" name="sk_idx" value="${rvo.sk_idx}"/>
					</c:forEach>
				</c:if>
				<c:if test="${ar eq null}">
					<tr>
						<td colspan="2">
							검색결과 없음.
						</td>
					</tr>
				</c:if>
			</tbody>

			<tfoot>
				<tr>
					<td colspan="2" align="left">
						<input type="button" id="add_upskill" value="저장"/>
						<input type="button" onclick="addHtml('${sk_length}')" value="추가"/>
						<input type="button" id="skill_cl" value="닫기"/>
					</td>
				</tr>
			</tfoot>
		</table>	
		</form>
			
