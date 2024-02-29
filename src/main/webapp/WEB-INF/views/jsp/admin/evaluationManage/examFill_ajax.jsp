<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
			<form action="" method="post">
			<table id="table" class="table">
				<colgroup>
					<col width="20%"/>
					<col width="30%"/>
					<col width="25%"/>
					<col width="25%"/>
				</colgroup>
			<thead>
			</thead>
				<tbody id="examFill_tbody">
					<!--문제 반복문 처리-->
					<tr>
						<th><label><input type="text" name="" /></label></th>
						<td colspan="3">
							[문항] <input type="text" name=""/><br/>
							<textarea cols="80" rows="4" >{문제 내용}</textarea><br/>
							<!--객관식일경우 반복식 수행-->
								1) {보기1}<input type="text" name=""/><hr/>
								2) {보기1}<input type="text" name=""/><hr/>
								3) {보기1}<input type="text" name=""/><hr/>
								4) {보기1}<input type="text" name=""/><hr/>
							
							정답 : <input type="text"/>

						</td>
					</tr>
				</tbody>


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
				<input type="hidden" name="cPage" value="${param.cPage}"/>
				<input type="hidden" name="es_idx" value="${esvo.es_idx}"/>
			</table>
		</form>
