<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

	<h2 id="add_h2">"${cvo.c_name}" 상담관리보고서</h2>
	<div id="add_top">
		<table id="tt_add1" class="t1 table">
			<colgroup>
				<col width="25%"/>
				<col width="35%"/>
				<col width="20%"/>
				<col width="*"/>
			</colgroup>
			<thead>

			</thead>
		</table>
	</div>
	
	<div>
		<table id="tt_add2" class="t1 table">
			<colgroup>
				<col width="25%"/>
				<col width="25%"/>
				<col width="25%"/>
				<col width="25%"/>
			</colgroup>
			<thead id="t2head">
				<tr>
                    <th>과정명</th>
                    <td>${cvo.c_name}</td>
                    <th>훈련기간</th>
                    <td>${cvo.start_date} ~ ${cvo.end_date}</td>
                </tr>
                <tr>
                    <th>훈련시간</th>
                    <td>${vo.ss_time}</td>
					<th>훈련교사</th>
                    <td>${cvo.svo.sf_name}</td>
                </tr>
                <tr>
                    <th>상담기간</th>
                    <td>${vo.ss_day}</td>
                    <th>상담사</th>
                    <td>${vo.ss_tname}</td>
                </tr>
                <tr>
                    <th>상담목적</th>
                    <td colspan ='3'>
                        ${vo.ss_p}
                    </td>
                </tr>
                <tr>
                    <th>상담내용전달사항</th>
                    <td colspan="3">${vo.ss_msg}</td>
                </tr>
                <tr>
                    <th>회의내용</th>
                    <td colspan ='3'>${vo.ss_msubject}</td>
                </tr>
                <tr>
                    <th>회의사진</th>
                    <td colspan ='3'>
                        <c:if test="${vo.ss_img ne null}">
                            <img src="${pageContext.request.contextPath}/counselimg/${vo.ss_img}" width="100%">
                        </c:if>
                        <c:if test="${vo.ss_img eq null}">
                            No Image
                        </c:if>
                    </td>
                </tr>
				<tr>
                	<th>회의참석자</th>
					<td colspan ='3'>${vo.ss_member}</td>
					
				</tr>
					<th>회의일시</th>
					<td>${vo.ss_mday}</td>
					<th>회의장소</th>
					<td>${vo.ss_pa}</td>
				</tr>
					
			</thead>
			<tbody>
					<tr>
						<td colspan="4">
							<button type="button" onclick="editCounselAdd('${vo.ss_idx}')">수정</button>
                            <button type="button" onclick="del('${vo.ss_idx}')">삭제</button>
                            <input type="hidden" name="ss_idx" value="${vo.ss_idx }"/>
							<button type="button" id="close">목록</button>
						</td>
					</tr>
			</tbody>
		</table>
	</div>
	
