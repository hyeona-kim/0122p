<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
		<h2 class="title">훈련생확인서류등록</h2>
			<form action="confirm" method="post" name="cf" >
				<table id="makeTime" class="table">
				<caption>훈련생확인서류등록 리스트</caption>
					<thead>
						<tr>
							<th colspan="2">서류선택</th>
						</tr>
						<tr>
							<th ><input type="checkbox" id="allCheckBox" onclick="allChecked()"/>선택</th>
							<th>파일이름</th>
						</tr>
					</thead>
					<tbody>
					<c:forEach items="${requestScope.ar }" var="va">
					<tr>
						<td><label class="checkbox-inline"><input type="checkbox" name="chk" class="chk" onclick="chkClicked('${va.tn_idx}')"  value="${va.tn_idx}"></td>
						<td>${va.subject}</td>
					</tr>
					</c:forEach>
					<input type="hidden" name="cPage" value="${param.cPage}"/>
					<input type="hidden" name="c_idx" value="${param.c_idx}"/>
					<input type="hidden" name="tn_idx" value="${tn_idx}"/>
				</tbody>	
			</table>
		</form>
				<div class="bb1 main_item align_center">
					<button type="button" onclick="subRow()" value="저장" class="btn">저장</button>
    				<button type="button" onclick="javascript:location.href='trainconfirm'" class="btn">닫기</button>
				</div>
				

				