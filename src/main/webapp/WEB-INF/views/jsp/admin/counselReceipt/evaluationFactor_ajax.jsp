<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/functions" %>
		<h2 id="hd">평가내용 등록/수정</h2>
		<form action="evaluationFactor_ajax" method="post" name="rm">
		<table id="t1">
			<thead>
				<tr bgcolor="lightgray">
					<td>순번</td>
					<td>평가요소</td>
					<td>평가내용</td>
					<td>점수</td>
				</tr>
			</thead>
			<tbody id="addRoom_tbody">
				<c:forEach var="rvo" items="${ar }">
						<tr>
							<td>
								<strong>${rvo.ef_idx }</strong>
							</td>

							<td>
								<input type="text" name="efName" value="${rvo.ef_name }(${rvo.ef_score})"> 
							</td>
							<td>
								<textarea name="efSubject">${rvo.ef_subject}</textarea>
							</td>
							<td>
								<strong>${rvo.ef_score }</strong>
							</td>
						</tr>
					</c:forEach>
			</tbody>
			<tfoot>
				<tr>
					<td colspan="4" align="left">
						<input type="submit"  id="sav"  value="저장"/>
						<input type="button"  id="cl" value="닫기"/>
					</td>
				</tr>
			</tfoot>
			
		</table>	
		</form>
			
