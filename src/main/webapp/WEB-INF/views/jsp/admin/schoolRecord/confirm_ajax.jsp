<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

			<form action="confirm" method="post" name="cf" >
				<table id="makeTime">
				<caption>훈련생확인서류등록 리스트</caption>
					<thead>
						<tr>
							<th colspan="3">서류선택</th>
						</tr>
					</thead>
					<tbody>
					<c:forEach items="${requestScope.ar }" var="va">
					<tr>
						<td><label class="checkbox-inline"><input type="checkbox" name="chk" class="chk"  value="${va.tn_idx}"></td>
						<td>${va.subject}</td>
						<td><input type="date"></td>
					</tr>
					</c:forEach>
					
					
						

				</tbody>	
			</table>
		</form>
				<div class="bb1">
					<button type="button" id="ck" onclick="subRow()" value="저장">저장</button>
    				<button type="button" onclick="javascript:location.href='trainconfirm'">닫기</button>
				</div>
				

				