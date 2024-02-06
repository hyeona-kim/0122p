<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

	<h2 id="add_h2">&nbsp;&nbsp;교육생 상담일지</h2>
	<div id="add_d1">
		<table class="add table">
			<colgroup>
				<col width ="20%" />
				<col width ="40%" />
				<col width ="40%" />
			</colgroup>
			<tr>
				<c:if test="${tvo.file_name ne null}">
					<td rowspan="4"><img src="${pageContext.request.contextPath }/upload_file/${tvo.file_name}" alt="학생이미지" width="150" height="150"/></td>
				</c:if>
				<c:if test="${tvo.file_name eq null}">
					<td rowspan="4">No Image</td>
				</c:if>
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
		</table>
		<table class="table t1">	
			<colgroup>
				<col width="17%"/>
				<col width="17%"/>
				<col width="17%"/>
				<col width="17%"/>
				<col width="16%"/>
				<col width="16%"/>
			</colgroup>		
			<tr>
				<th >교육과정명</th>
				<td>${cvo.c_name}</td>
				<th>교육기간</th>
				<td>${cvo.start_date} ~ ${cvo.end_date}</td>
				<th>총상담횟수</th>
				<td>${tvo.ss_num}</td>
			</tr>	
		</table>
	</div>
	<div id="add_d2">
	<form action="counselsave" method="post" enctype="multipart/form-data">
		<input type="hidden" name ="c_idx" value="${cvo.c_idx}">
		<table class="add t1 table" id="add_t1">
			<colgroup>
				<col width="10%"/>
				<col width="10%"/>
				<col width="10%"/>
				<col width="35%"/>
				<col width="35%"/>
				
			</colgroup>

			<thead>
				<tr>
                    <th>상담일</th>
					<th>구분</th>
					<th>상담자</th>
 					<th>상담내용</th>
        			<th>조치사항</th>    
                </tr>
			</thead>
			<tbody>
				<c:if test="${ar ne null}" >
				<c:forEach var="vo" items="${ar}">
				<tr>
                    <td><a href="javascript:editCounsel('${vo.so_idx}', '${vo.tr_idx}')">${vo.so_day}</a></td>
					<td>${vo.so_pp}</td>
					<td>${vo.svo.sf_name}</td>
 					<td>${vo.so_subject}</td>
        			<td>${vo.so_pd}</td>    
        		</tr>
				</c:forEach>
				</c:if>
        
			</tbody>
			<tfoot>
				<tr>
					<td colspan="5">
						<button type="button" onclick="counselListAdd('${tvo.tr_idx}', '${tvo.c_idx}')" class="btn">상담등록</button>
						<button type="button" class="btn">인쇄</button>
						<button type="button" id="cc_cancle" class="btn">취소</button>
					</td>
				</tr>
			</tfoot>
		</table>
	</form>
	</div>
	
