<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

	<h2 id="add_h2">교육생 상담일지</h2>
	<div id="add_top">
		<table id="tt_add1" class="t1">
			<colgroup>
				<col width="25%"/>
				<col width="35%"/>
				<col width="20%"/>
				<col width="*"/>
			</colgroup>
			<thead>
				<tr>
					<th>성명</th>
					<td>${tvo.tr_name}</td>
                </tr>
                <tr>
					<th>주민번호</th>
					<td>${tvo.tr_rrn}</td>
				</tr>
                <tr>
					<th>주소</th>
					<td>${tvo.tr_addr}</td>
				</tr>
                <tr>
					<th>전화번호</th>
					<td>${tvo.tr_hp}</td>
				</tr>
			</thead>
            <tr>
                <th >교육과정명</th>
                <td>${cvo.c_name}</td>
                <th>교육기간</th>
                <td>${cvo.start_date} ~ ${cvo.end_date}</td>
                <td>총상담횟수</td>
                <td>${tvo.ss_num}</td>
            </tr>
		</table>
	</div>
	
	<div>
	<form action="counselsave" method="post" enctype="multipart/form-data">
		<input type="hidden" name ="c_idx" value="${cvo.c_idx}">
		<table id="tt_add2" class="t1">
			<colgroup>
				<col width="25%"/>
				<col width="25%"/>
				<col width="25%"/>
				<col width="25%"/>
			</colgroup>

			<thead id="t2head">
				<tr>
                    <th>상담일</th>
					<th>구분</th>
					<th>상담자</th>
 					<th>상담내용</th>
        			<th>조치사항</th>    
                </tr>
				<c:if test="${ar ne null}" >
				<c:forEach var="vo" items="${ar}">
				<tr>
                    <th><a href="javascript:editCounsel('${vo.so_idx}', '${vo.tr_idx}')">${vo.so_day}</a></th>
					<th>${vo.so_pp}</th>
					<th>${vo.svo.sf_name}</th>
 					<th>${vo.so_subject}</th>
        			<th>${vo.so_pd}</th>    
                </tr>
				</c:forEach>
				</c:if>
						<td colspan="4">
							<button type="button" onclick="counselListAdd('${tvo.c_idx}', '${tvo.tr_idx}')">상담등록</button>
							<button type="button">인쇄</button>
							<button type="button" id="cc_cancle">취소</button>
						</td>
					</tr>
			</tbody>
		</table>
	</form>
	</div>
	
