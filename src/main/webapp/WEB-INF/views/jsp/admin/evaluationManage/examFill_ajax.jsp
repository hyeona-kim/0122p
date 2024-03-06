<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
		<form action="addExam" method="post" id="frm">
			<table id="table" class="table">
				<colgroup>
					<col width="20%"/>
					<col width="80%"/>
				</colgroup>
			<thead>
				<h2>총점: ${esvo.es_totalScore}</h2>
			</thead >
			<c:if test="${esvo.es_type eq 2}">
				<c:set var="num" value="${n1+n2}"/>
				<c:forEach var="i" begin="1" end="${n1}">
					<tbody>
						<tr>
							<th rowspan="7"><label><input type="text" name="sk_idx" class="text" /></label></th>
						</tr>
						<tr>
							<td>
								문항${i} <input type="text" name="qt_name" placeholder="${i}번 문항" class="text"/>
							</td>
						</tr>
						<tr>				
							<td>
								<textarea cols="80" rows="4" placeholder="문제 내용" class="textarea" name="qt_content"></textarea>
							</td>
						</tr>
						<tr>
							<td id="selectExam${i}">
								<input type="text" value="1" class="text" style="width: 10%" name="idx${i}" readonly/>
								<input type="text" name="qt_select${i}" value="" class="text" style="width: 70%" placeholder="객관식 문항1"/>
							</td>
						</tr>
						<tr>
							<td>
								<input type="button" value="객관식문항추가" onclick="addSelect('${i}')" class="btn">
							</td>
						</tr>
						<tr>
							<td>
								정답 : <input type="text" class="text" name="qt_correct"/>
							</td>
						</tr>
						<tr>
							<td>
								배점 : <input type="number" class="text" name="qt_score"/>
							</td>
						</tr>
						<input type="hidden" value="0" name="qt_type"/>
					</tbody>
				</c:forEach>
				<c:forEach var="i" begin="${n1+1}" end="${n2 + n1}">
					<tbody>
						<tr>
							<th rowspan="7"><label><input type="text" name="sk_idx" class="text" /></label></th>
						</tr>
						<tr>
							<td>
								<input type="text" name="qt_name" placeholder="${i}번 문항" class="text"/>
							</td>
						</tr>
						<tr>				
							<td>
								<textarea cols="80" rows="4" placeholder="문제 내용" class="textarea" name="qt_content"></textarea>
							</td>
						</tr>
						<tr>
							<td>
								정답 : <input type="text" class="text" name="qt_correct"/>
							</td>
						</tr>
						<tr>
							<td>
								배점 : <input type="number" class="text" name="qt_score"/>
							</td>
						</tr>
						<input type="hidden" value="1" name="qt_type"/>
					</tbody>
				</c:forEach>
			</c:if>
			<c:if test="${esvo.es_type ne 2}">
				<c:set var="num" value="${esvo.es_num_question}"/>
				<c:forEach var="i" begin="1" end="${esvo.es_num_question}">
					<tbody>
						<tr>
							<th rowspan="7"><label><input type="text" name="sk_idx" class="text" /></label></th>
						</tr>
						<tr>
							<td>
								<input type="text" name="qt_name" placeholder="${i}번 문항" class="text"/>
							</td>
						</tr>
						<tr>				
							<td>
								<textarea cols="80" rows="4" placeholder="문제 내용" class="textarea" name="qt_content"></textarea>
							</td>
						</tr>
						<tr>
							<td>
								정답 : <input type="text" class="text" name="qt_correct"/>
							</td>
						</tr>
						<tr>
							<td>
								배점 : <input type="number" class="text" name="qt_score"/>
							</td>
						</tr>
						<c:if test="${esvo.es_type eq 1}">
							<input type="hidden" value="1" name="qt_type"/>
						</c:if>
						<c:if test="${esvo.es_type eq 3}">
							<input type="hidden" value="2" name="qt_type"/>
						</c:if>
					</tbody>
				</c:forEach>
			</c:if>
			</table>
			
			<div>
				<table>
					<tfoot>
						<tr>
							<td colspan="4">
								<input type="button" value="등록" onclick="addExam('${n1}', '${esvo.es_type}', '${esvo.es_totalScore}', '${num}')" class="btn">
								<input type="button" value="목록" id="" class="btn">
								
							</td>
						</tr>
					</tfoot>
				</table>
			</div>
			<div id="box">
				<input type="hidden" name="cPage" value="${param.cPage}"/>
				<input type="hidden" name="es_idx" value="${esvo.es_idx}"/>
			</div>
			<input type="hidden" name="s_idx" value="${svo.s_idx}"/>
		</form>
		