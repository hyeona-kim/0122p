<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
		<table id="makeCourse" class="table">
			<caption>교육과정리스트</caption>
							<thead>
								<tr>
									<th>순번</th>
									<th>면접평가표명</th>
									<th>합격점수</th>
									<th>사용여부</th>
									<th>관리</th>
								</tr>
							</thead>
							<tbody>
							<c:if test="${ar2 ne null }">
							<c:forEach var="cvo" items="${ar2 }" varStatus="vs">
								<tr>
									<td>${vs.index+1 }</td>
									<td>${cvo.cr_name }</td>
									<td>${cvo.cr_score }</td>
									<td>${cvo.cr_status} </td>
									<td>
										<button type="button" onclick="setcr2('${cvo.cr_idx}')" class="btn">수정</button>
										<button type="button" onclick="del('${cvo.cr_idx}')" class="btn red">삭제</button>
										<button type="button" onclick="setcr4()" class="btn">평가내용등록/수정</button>
										<button type="button" onclick="setcr3()" class="btn">면접평가표 보기</button>
									</td>
								</tr>
							</c:forEach>
							</c:if>
							</tbody>
						</table>