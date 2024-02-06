<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/functions" %>
		<h2 id="hd" class="title">다음예정일 등록/수정</h2>
		<form action="addNextscheduled" method="post" name="rm">
			<input type="hidden" name="ns_idx" value="" />
		<table id="makeTime" class="table">
			<thead>
				<tr>
					<th>순번</th>
					<th>예정일항목</th>
				</tr>
					<c:forEach var="rvo" items="${ar }" varStatus="vs">
						<tr>
							<td><strong>${vs.index+1 }</strong><br/>
								<button type="button" onclick="delNs('${rvo.ns_idx}')" class="btn red">삭제</button>
							</td>

							<td><input type="text" name="nextscheduledName" value="${rvo.ns_name }" class="text"/></td>
						</tr>
					</c:forEach>
			</thead>
					<tbody id="addNextscheduled_tbody">

					</tbody>
			<tfoot>
				<tr>
					<td colspan="2">
						<input type="button" onclick="addNextscheduled()" value="항목추가" class="btn"/>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<input type="submit"  id="sav" value="저장" class="btn"/>
						<input type="button"  id="cl" value="닫기" class="btn"/>
					</td>
				</tr>
			</tfoot>
			<input type="hidden" name="cPage" value="${param.cPage}"/>
			<input type="hidden" name="listSelect" value="${param.listSelect}"/>
		</table>	
		</form>
			
