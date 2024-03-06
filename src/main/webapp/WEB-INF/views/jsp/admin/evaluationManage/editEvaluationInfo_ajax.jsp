<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<h2 id="table_h2" class="title">${svo.s_title}평가기본정보수정</h2>
	<form action="editEvaluationStatus" method="post" name="frm02">
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
                        <c:if test="${esvo.es_name eq '평가1'}">
                            <td>
                                <select name="es_name" class="select">
                                    <option selected>평가1</option>
                                    <option>평가2</option>
                                    <option>평가3</option>
                                </select>
                            </td>
                        </c:if>
                        <c:if test="${esvo.es_name eq '평가2'}">
                            <td>
                                <select name="es_name" class="select">
                                    <option>평가1</option>
                                    <option selected>평가2</option>
                                    <option>평가3</option>
                                </select>
                            </td>
                        </c:if>
                        <c:if test="${esvo.es_name eq '평가3'}">
                            <td>
                                <select name="es_name" class="select">
                                    <option>평가1</option>
                                    <option>평가2</option>
                                    <option selected>평가3</option>
                                </select>
                            </td>
                        </c:if>
						<th><label>평가일시</label></th>
						<td>
							<input type="date" name="es_date" class="text" value="${esvo.es_date}"/>
						</td>
					</tr>
					<tr>
						<th><label>평가유형</label></th>
						<td>
                            <select id="selectType" name="es_type" class="select">
                            <c:if test="${esvo.es_type eq '1'}">
                                <option value="1" selected>필답</option>
								<option value="2">서답</option>
                            </c:if>
                            <c:if test="${esvo.es_type eq '2'}">
                                <option value="1">필답</option>
								<option value="2" selected>서답</option>
                            </c:if>
							</select>
						</td>
						<th><label>평가시간</label></th>

						<td><input type="text" name="es_time" class="text" value="${esvo.es_time}"/></td>

					</tr>
					<tr>
						<th><label>난이도</label></th>
						<td>
						<input type="text" name="es_level" class="text" style="width: 40%;" value="${esvo.es_level}"/> 
						</td>
						<th><label>문항수</label></th>
						<td>
                        <c:if test="${esvo.es_type eq '1'}">
                            <div id="selectType1">
                                <input type="text" id="q1" class="text" style="width: 40%;" value="${esvo.es_num_question}"/> 
                            </div>	
							<div hidden="hidden" id="selectType2">
                                필답형: <input type="text" id="q2" class="text" style="width: 40%;" value="0"/> <br/>
								단답형: <input type="text" id="q3" class="text" style="width: 40%;" value="0"/> 
							</div>	
                        </c:if>
                        <c:if test="${esvo.es_type eq '2'}">
                            <div hidden="hidden" id="selectType1">
                                <input type="text" id="q1" class="text" style="width: 40%;" value="0"/> 
                            </div>	
							<div id="selectType2">
                                필답형: <input type="text" id="q2" class="text" style="width: 40%;" value="${q1}"/> <br/>
								단답형: <input type="text" id="q3" class="text" style="width: 40%;" value="${q2}"/> 
							</div>	
                        </c:if>
						</td>
					</td>
					</tr>
					<tr>
						<th><label>훈련교사</label></th>
						<td>
						<select name="sf_idx" class="select">
							<option value="${esvo.sf_idx}">${sfvo.sf_name}</option>
						</select>
					</td>
						<th><label>총배점</label></th>
						<td><input type="text" name="es_totalScore" class="text" value="${esvo.es_totalScore}"></td>
					</tr>
					
				</tbody>
				<tfoot>
					<tr>
						<td colspan="4" id="counselDetail_add_btn">
							<input type="submit" value="수정" class="btn" id="edit_btn">
							<input type="button" value="목록" id="cc_cancle" class="btn">
						</td>
					</tr>
				</tfoot>	
			</table>
			
			<input type="hidden" name="cPage" value="${param.cPage}"/>
			<input type="hidden" name="es_idx" value="${esvo.es_idx}"/>
			<input type="hidden" name="s_idx" value="${esvo.s_idx}"/>
            <input type="hidden" name="es_num_question" id="totalQuestions" class="text" style="width: 40%;" readonly/>
		</form>
		