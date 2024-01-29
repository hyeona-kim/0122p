<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
			<h2 id="hd">교육과정수정</h2>

			<form action="editCourse" method="post">
			<table id="table">
			<thead>
				<tr bgcolor="lightgray">
					<td colspan="4">
						과정수정
					</td>
				</tr>
			</thead>
				<tbody>
					<tr>
						<th><label>과정명</label></th>
						<td>
							<input type="text" name="c_name" value="${edit_cvo.c_name }" />
						</td>
						<th><label>과정구분</label></th>
						<td>
						<select name="ct_idx">
							<c:forEach items="${requestScope.c_ar}" var="c_ar"  varStatus="loop">
								<c:if test="${ct_idx eq c_ar.ct_idx}">
									<option value="${c_ar.ct_idx }" selected>
										${c_ar.ct_name }
									</option>
								</c:if>
								<c:if test="${ct_idx ne c_ar.ct_idx}">
									<option value="${c_ar.ct_idx }">
											${c_ar.ct_name }
									</option>
								</c:if>
							</c:forEach>
						</select>
						</td>
					</tr>
					<tr>
						<th><label>모집예정일</label></th>
						<td><input type="text">-
							<input type="text">
						</td>
						<th><label>담당교사</label></th>
						<td>
						<select name="sf_idx">
							<c:forEach items="${requestScope.s_ar}" var="s_ar" varStatus="loop">
								<c:if test="${sf_idx eq s_ar.sf_idx}">
									<option value="${s_ar.sf_idx }" selected>
										${s_ar.sf_name }
									</option>
								</c:if>
								<c:if test="${sf_idx ne s_ar.sf_idx}">
									<option value="${s_ar.sf_idx }" >
										${s_ar.sf_name }
									</option>
								</c:if>
							</c:forEach>
						</select>
						</td>
					</tr>
					<tr>
						<th><label>개강일</label></th>
						<td><input type="text" name="start_date" value="${edit_cvo.start_date }"></td>
						<th><label>종료일</label></th>
						<td><input type="text" name="end_date" value="${edit_cvo.end_date }"></td>
					</tr>
					<tr>
						<th><label>교육시간</label></th>
						<td><input type="text"><div id="box">(* 숫자로만 입력해주세요)</div></td>
						<th><label>교시/수업시간</label></th>
						<td><input type="text">-<input type="text"></td>
					</tr>
					<tr>
						<th><label>교육비</label></th>
						<td><input type="text" name="course_fee" value="${edit_cvo.course_fee }"><div id="box">(* 콤마(,)없이 숫자로만 입력해주세요)</div></td>
						<th><label>총교육일수</label></th>
						<td><input type="text"><div id="box">(숫자만입력가능)</div></td>
					</tr>
					<tr>
						<th><label>모집인원</label></th>
						<td><input type="text" name="c_peo_num" value="${edit_cvo.c_peo_num }"></td>
						<th><label>요일</label></th>
						<td>
						<c:if test="${monday eq true}">
							<input type="checkbox" name="c_day" value="월" checked>월
						</c:if>	
						<c:if test="${monday eq null || monday ne true}">
							<input type="checkbox" name="c_day" value="월" >월
						</c:if>	
						<c:if test="${tuesday eq true}">
							<input type="checkbox" name="c_day" value="화" checked>화
						</c:if>
						<c:if test="${tuesday eq null || tuesday ne true}">
							<input type="checkbox" name="c_day" value="화">화
						</c:if>
						<c:if test="${wednesday eq true}">
							<input type="checkbox" name="c_day" value="수" checked>수
						</c:if>	
						<c:if test="${wednesday eq null || wednesday ne true}">
							<input type="checkbox" name="c_day" value="수" >수
						</c:if>	
						<c:if test="${thursday eq true}">
							<input type="checkbox" name="c_day" value="목" checked>목
						</c:if>
						<c:if test="${thursday eq null || thursday ne true}">
							<input type="checkbox" name="c_day" value="목">목
						</c:if>
						<c:if test="${friday eq true}">
							<input type="checkbox" name="c_day" value="금" checked>금
						</c:if>
						<c:if test="${friday eq null || friday ne true}">
							<input type="checkbox" name="c_day" value="금" >금
						</c:if>
						<c:if test="${saturday eq true}">
							<input type="checkbox" name="c_day" value="토" checked>토
						</c:if>
						<c:if test="${saturday eq null || saturday ne true}">
							<input type="checkbox" name="c_day" value="토" >토
						</c:if>
						<c:if test="${sunday eq true}">
							<input type="checkbox" name="c_day" value="일" checked>일
						</c:if>
						<c:if test="${sunday eq null || sunday ne true}">
							<input type="checkbox" name="c_day" value="일" >일
						</c:if>
						</td>
					</tr>
					<tr>
						<th><label>NCS세분류</label></th>
						<td><input type="text"></td>
						<th><label>회차</label></th>
						<td>
						<input type="text" name="c_round_num" value="${edit_cvo.c_round_num }">
						<input type="hidden" name="c_idx" value="${edit_cvo.c_idx }"/>
						</td>
					</tr>
				</tbody>
				<tfoot>
					<tr>
						<td colspan="3" align="left">
							<label>* 교육시간, 교시, 요일은 시간표 만들때 사용됩니다. 시간표를 만들려면 꼭 입력해주세요</label><br/>
							<label>* 총 교육일수는 훈련일지에서 사용됩니다.</label>
						</td>
					</tr>
					<tr>
						<td colspan="2" align="right" id="course_add_btn">
							<input type="button" value="수정" onclick="addCourse(this.form)">
						</td>
						<td colspan="2" align="left">
							<input type="button" value="목록" id="cancel4">
						</td>
					</tr>
				</tfoot>	
				<input type="hidden" name="cPage" value="${param.cPage}"/>
			</table>
		</form>
