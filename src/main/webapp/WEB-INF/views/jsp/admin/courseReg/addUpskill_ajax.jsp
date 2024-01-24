<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/functions" %>

	
    
		<h2 id="hd">능력단위 등록/수정</h2>
		<form action="Controller" method="post" name="rm">
         <input type="hidden" name="type"  value="addUpskill"/>
		<table id="t1">
			<thead>
				<tr bgcolor="lightgray">
					<td>순번</td>
					<td>능력단위요소명</td>
				</tr>

			</thead>
			<tbody id="addUpskill_tbody">
			 <c:forEach var="rvo" items="${ar2 }">
					<tr>
						<td><strong>${rvo.sk_idx }</strong><br/>
							<button type="button">삭제</button>
						</td>
						<td><input type="text" name="upskill_name" value="${rvo.sk_name }"> </td>
	
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
			
