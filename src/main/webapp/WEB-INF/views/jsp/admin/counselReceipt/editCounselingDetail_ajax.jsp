<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<h2 id="table_h2">상담DB 상세보기/수정</h2>
	<form action="editCounselingDetail?edit=1" method="post" name="frm02">
			<table id="table">
				<colgroup>
					<col width="10%"/>
					<col width="40%"/>
					<col width="10%"/>
					<col width="40%"/>
				 </colgroup>
			<thead>
				<tr>
					<td colspan="4">
						상담내역 등록
					</td>
				</tr>
			</thead>
				<tbody>
					<tr>
						<th><label>최초상담자</label></th>
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
						<th><label>상담날짜</label></th>
						<td>
							<input type="text" name="cd_date" value="${edit_cdvo.cd_date}"/>
						</td>
					</tr>
					<tr>
						<th><label>지원자성명</label></th>
						<td><input type="text" name="cd_name" value="${edit_cdvo.cd_name}">
						</td>
						<th><label>연락처</label></th>
						
						<td><input type="text" name="cd_phone" value="${edit_cdvo.cd_phone}">
						</td>
					</tr>
					<tr>
						<th><label>과정명</label></th>
						<td>
						<select name="c_idx">
							<c:forEach items="${c_ar}" var="c_ar"  varStatus="loop">
								<c:if test="${c_idx eq c_ar.c_idx}">
											<option value="${c_ar.c_idx }" selected>
												${c_ar.c_name }
											</option>
										</c:if>
										<c:if test="${c_idx ne c_ar.c_idx}">
											<option value="${c_ar.c_idx }" >
												${c_ar.c_name }
											</option>
								</c:if>
							</c:forEach>
						</select>
						</td>
						<th><label>상담결과</label></th>
						<td>
							<select name="cd_result">
								<option value="과정만문의(단순문의)">과정만문의(단순문의)</option>
								<option value="수강문의">수강문의</option>
								<option value="수강">수강</option>
							</select>
						</td>
					</td>

					<tr>
						<th><label>HRD등록일</label></th>
						<td><input type="text" name=""></td>
						<th><label>취소사유</label></th>
						<td>
							<select name="cd_cancel" >
								<option value="0">취소시 선택하세요</option>
								<option value="그냥">그냥</option>
								<option value="그냥2">그냥2</option>
								<option value="그냥3">그냥3</option>
							</select>
						</td>
					</tr>

					</tr>
					<tr>
						<th><label>주민번호</label></th>
						<td><input type="text" name="cd_personalNum" value="${edit_cdvo.cd_personalNum}"></td>
						<th><label>카드유형</label></th>
						<td>
							<select name="cd_cardType">
								<option value="취성패1">취성패1</option>
								<option value="국민취업카드">국민취업카드</option>
								<option value="내일배움카드">내일배움카드</option>
							</select>
						</td>
					</tr>
					<tr>
						<th><label>카드발급유무</label></th>
						<td>
							<input type="checkbox" value="유" name="cd_card">유
							<input type="checkbox" value="무" name="cd_card">무
						</td>
						<th><label>다음예정일</label></th>
						<td>
							<select name="ns_idx">
								<c:forEach items="${ns_ar}" var="ns_ar"  varStatus="loop">
									<c:if test="${ns_idx eq ns_ar.ns_idx}">
												<option value="${ns_ar.ns_idx }" selected>
													${ns_ar.ns_name }
												</option>
											</c:if>
											<c:if test="${ns_idx ne ns_ar.ns_idx}">
												<option value="${ns_ar.ns_idx }" >
													${ns_ar.ns_name }
												</option>
									</c:if>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<th><label>주소</label></th>
						<td colspan="3"><input type="text" name="cd_address" value="${edit_cdvo.cd_address}" ></td>
					</tr>
					<tr>
						<th><label>유입경로</label></th>
					<td colspan="3">
						<c:forEach items="${id_ar}" var="ar3"  varStatus="loop">
						<input type="checkbox" value="${ar3.id_idx}" name="id_idx">${ar3.id_name}
						</c:forEach>
					</td>
					</tr>
					<tr>
						<th><label>상담내용</label></th>
					<td colspan="3">
						<input type="text" name="cd_subject" value="${edit_cdvo.cd_subject}">
					</td>
					</tr>
				</tbody>
				<tfoot>
					<tr>
						<td colspan="2" align="right" id="counselDetail_add_btn">
							<input type="submit" value="등록">
						</td>
						<td colspan="2" align="left">
							<input type="button" value="목록" id="cc_cancle">
						</td>
					</tr>
				</tfoot>	
			</table>
			
			<input type="hidden" name="cd_idx" value="${param.cd_idx}"/>
			<input type="hidden" name="cPage" value="${param.cPage}"/>
			<input type="hidden" name="select" value="${param.select}"/>
			<input type="hidden" name="year" value="${param.year}"/>
			<input type="hidden" name="value" value="${param.value}"/>
			<input type="hidden" name="num" value="${param.num}"/>

		</form>
		