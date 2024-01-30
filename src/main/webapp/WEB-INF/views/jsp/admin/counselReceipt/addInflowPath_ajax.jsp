<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/functions" %>
		<h2 id="hd">유입경로항목 등록/수정</h2>
		<form action="addInflowPath" method="post" name="rm">
			<input type="hidden" name="id_idx" value="" />
		<table id="makeTime">
			<thead>
				<tr bgcolor="lightgray">
					<td>순번</td>
					<td>유입경로항목</td>
				</tr>
					<c:forEach var="rvo" items="${ar3 }" varStatus="vs">
						<tr>
							<td><strong>${vs.index+1 }</strong><br/>
								<button type="button" onclick="delId('${rvo.id_idx}')">삭제</button>
							</td>

							<td><input type="text" name="InflowPathName" value="${rvo.id_name }"> </td>
						</tr>
					</c:forEach>
			</thead>
					<tbody id="addInflowPath_tbody">

					</tbody>

			<tfoot>
				<tr>
					<td colspan="4" align="left">
						<input type="button" onclick="addInflowPath()" value="유입경로추가"/>
					</td>
				</tr>
				<tr>
					<td colspan="4" align="left">
						<input type="submit"  id="sav"  value="저장"/>
						<input type="button"  id="cl" value="닫기"/>
					</td>
				</tr>
			</tfoot>
			<input type="hidden" name="cPage" value="${param.cPage}"/>
			<input type="hidden" name="listSelect" value="${param.listSelect}"/>
		</table>	
		</form>
			
