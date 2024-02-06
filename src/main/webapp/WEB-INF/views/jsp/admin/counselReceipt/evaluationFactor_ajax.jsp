<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/functions" %>
		<h2 id="hd" class="title">평가내용 등록/수정</h2>
		<form action="evaluationFactor_ajax" method="post" name="rm">
		<table id="t1" class="table">
			<colgroup>
				<col width="15%"/>
				<col width="25%"/>
				<col width="25%"/>
				<col width="15%"/>
			</colgroup>
			<thead>
				<tr>
					<th>순번</th>
					<th>평가요소</th>
					<th>평가내용</th>
					<th>점수</th>
				</tr>
			</thead>
			<tbody id="addRoom_tbody">
				<c:forEach var="rvo" items="${ar2 }">
						<tr>
							<td>
								<strong>${rvo.ef_idx }</strong>
							</td>

							<td>
								<input type="text" name="efName" value="${rvo.ef_name }(${rvo.ef_score})" class="text"/> 
							</td>
							<td>
								<textarea name="efSubject" cols="50" rows="2" class="textarea">${rvo.ef_subject}</textarea>
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
						<input type="submit"  id="sav"  value="저장" class="btn"/>
						<input type="button"  id="cl" value="닫기" class="btn"/>
					</td>
				</tr>
			</tfoot>
			
		</table>	
		</form>
			
