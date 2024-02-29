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
				<tbody id="examFill_tbody">
					<tr>
						<th rowspan="6"><label><input type="text" name="" class="text"/></label></th>
					</tr>
					<tr>
						<td>
							<input type="text" name="" placeholder="문항" class="text"/>
						</td>
					</tr>
					<tr>				
						<td>
							<textarea cols="80" rows="4" placeholder="문제 내용" class="textarea"></textarea>
						</td>
					</tr>
					<tr>
						<td id="selectExam">
							<input type="text" value="1" id="idx" readonly class="text" style="width: 10%;"/>
							<input type="text" name="" value="" class="text" style="width: 70%"/>
						</td>
					</tr>
					<tr>
						<td>
							<input type="button" value="추가" onclick="addSelect()" class="btn">
						</td>
					</tr>
					<tr>
						<td>
							정답 : <input type="text" class="text"/>
						</td>
					</tr>

				</tbody>
			</table>

				<div>
					<table>
						<tfoot>
							<tr>
								<td colspan="4" style="color: #154790;">
									<input type="button" value="추가" onclick="addExamFill()" class="btn">
								</td>
							</tr>
							<tr>
								<td colspan="4" >
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
