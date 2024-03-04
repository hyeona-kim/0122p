<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
			<form action="" method="post">
			<table id="table" class="table">
				<colgroup>
					<col width="20%"/>
					<col width="80%"/>
				</colgroup>
			<thead>
			</thead >
			<c:forEach var="i" begin="1" end="${esvo.es_num_question}">
				<tbody id="examFill_tbody">
					<tr>
						<th rowspan="6"><label><input type="text" name="sk_idx" class="text" /></label></th>
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
						<td id="selectExam${i}">
							<input type="text" value="1" class="text" style="width: 10%" name="idx${i}"/>
							<input type="text" name="qt_select" value="" class="text" style="width: 70%" placeholder="객관식 문항1"/>
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
					
				</tbody>
			</c:forEach>
			</table>
			
			<div>
				<table>
					<tfoot>
						<tr>
							<td colspan="4">
								<input type="submit" value="등록" onclick="" class="btn">
								<input type="button" value="목록" id="" class="btn">
								
							</td>
						</tr>
					</tfoot>
				</table>
			</div>
			
			<input type="hidden" name="cPage" value="${param.cPage}"/>
			<input type="hidden" name="es_idx" value="${esvo.es_idx}"/>
		</form>
		