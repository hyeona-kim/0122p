<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/functions" %>
		<h2 id="hd" class="title">유입경로항목 등록/수정</h2>
		<form action="addInflowPath" method="post" name="rm">
			<input type="hidden" name="id_idx" value="" />
		<table id="makeTime" class="table">
			<thead>
				<tr>
					<th>순번</th>
					<th>유입경로항목</th>
				</tr>		
			</thead>
			<tbody id="addInflowPath_tbody">
				<c:forEach var="rvo" items="${ar3 }" varStatus="vs">
					<tr>
						<td><strong>${vs.index+1 }</strong><br/>
							<button type="button" onclick="delId('${rvo.id_idx}')" class="btn red">삭제</button>
						</td>
						<td><input type="text" name="InflowPathName" value="${rvo.id_name }" class="text"/></td>
					</tr>
				</c:forEach>
			</tbody>
			<tfoot>
				<tr>
					<td colspan="2" class="align_right">
						<input type="button" onclick="addInflowPath()" value="유입경로추가" class="btn"/>
					</td>
				</tr>
				<tr>
					<td colspan="2"	class="align_right">
						<input type="submit"  id="sav"  value="저장" class="btn"/>
						<input type="button"  id="cl" value="닫기" class="btn"/>
					</td>
				</tr>
			</tfoot>
			<input type="hidden" name="cPage" value="${param.cPage}"/>
			<input type="hidden" name="listSelect" value="${param.listSelect}"/>
		</table>	
		</form>
			
