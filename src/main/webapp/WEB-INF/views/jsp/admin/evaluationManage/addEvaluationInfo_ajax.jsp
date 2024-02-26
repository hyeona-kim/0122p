<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<h2 id="table_h2" class="title">${svo.s_title}평가기본정보입력</h2>
	<form action="addEvaluationStatus" method="post" name="frm02">
			<table id="table" class="table">
				<colgroup>
					<col width="10%"/>
					<col width="40%"/>
					<col width="10%"/>
					<col width="40%"/>
				 </colgroup>
			
				<tbody>
					<tr>
						<th><label>평가선택</label></th>
						<td>
								<select name="es_name" class="select">
									<option value="평가1">평가1</option>
									<option value="평가2">평가2</option>
									<option value="평가3">평가3</option>
								</select>
						</td>
						<th><label>평가일시</label></th>
						<td>
							<input type="date" name="es_date" class="text"/>
						</td>
					</tr>
					<tr>
						<th><label>평가유형</label></th>
						<td>
							<select id="selectType" name="es_type" class="select">
								<option value="0" selected>선택하세요</option>
								<option value="1">필답</option>
								<option value="2">서답</option>
							</select>
						</td>
						<th><label>평가시간</label></th>

						<td><input type="text" name="es_time" class="text"/></td>

					</tr>
					<tr>
						<th><label>난이도</label></th>
						<td>
						<input type="text" name="es_level" class="text" style="width: 40%;"/> 
						</td>
						<th><label>문항수</label></th>
						<td>

							<div hidden="hidden" id="selectType1">
								<input type="text"  id="q1" class="text" style="width: 40%;" value="0"/> 
							</div>	


							<div hidden="hidden" id="selectType2">
								필답형: <input type="text"   id="q2" class="text" style="width: 40%;" value="0"/> <br/>
								단답형: <input type="text"  id="q3" class="text" style="width: 40%;" value="0"/>  <br/>
								<input type="hidden" name="es_num_question" id="totalQuestions" class="text" style="width: 40%;" value="0" readonly/>
							</div>	

						</td>
					</td>
					</tr>
					<tr>
						<th><label>훈련교 사</label></th>
						<td>
						<select name="sf_idx" class="select">
							<option value="${sessionScope.vo.sf_idx}">${sessionScope.vo.sf_name}</option>
						</select>
					</td>
						<th><label>총배점</label></th>
						<td><input type="text" name="es_totalScore" class="text"></td>
					</tr>
					
				</tbody>
				<tfoot>
					<tr>
						<td colspan="4" id="evaluationStatus_add_btn">
							<input type="submit" value="등록" class="btn">
							<input type="button" value="목록" id="cc_cancle" class="btn">
						</td>
					</tr>
				</tfoot>	
			</table>
			
			<input type="hidden" name="s_idx" value="${svo.s_idx}"/>
			<input type="hidden" name="cPage" value="${param.cPage}"/>
		</form>
		