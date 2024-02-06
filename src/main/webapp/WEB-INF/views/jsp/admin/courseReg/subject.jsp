<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<h2 id="subject_h2" class="title">${cvo.c_name}</h2>
	<div id="btns" class="align_right main_item">
		<button id="add_subject_btn" class="btn">교과목 파일등록</button>
		<button onclick="downSubject()" class="btn">교과목등록액셀파일</button>
	</div>
	<div id="subject_wrap">
		<form name="sb_add_frm" action="add_subject_form" method="post">
		<input type="hidden" name="c_idx" value="${cvo.c_idx}"/>
		<c:if test="${sb_ar eq null}">
		<c:forEach begin="1" end="18" varStatus="vs">
		<table class="table subject_out" style="margin: 0 auto;">
		<colgroup>
			<col width="10%"/>
			<col width="90%"/>
		</colgroup>
		<input type="hidden" name="s_idx"/>
			<tr>
				<th>
					<p>과목${vs.index}</p>
					<select style="width: 80px; height: 25px;" class="select">
						<option value="0">미삭제</option>
						<option value="1">삭제</option>
					</select>
				</th> 
				<td>
					<table id="innerTable" class="table" style="width: 95%; margin-top: 15px;">
					<colgroup>
						<col width="15%"/>
						<col width="15%"/>
						<col width="20%"/>
						<col width="20%"/>
						<col width="10%"/>
						<col width="20%"/>
					</colgroup>
						<tr>
							<th>과목명</th>
							<td><input type="text" name="s_title" class="text"/></td>
							<th>분류/시수</th>
							<td>
								<select name="s_type" class="select">
									<option value="NCS">NCS</option>
									<option value="NONCS">비NCS</option>
								</select>
								<input type="text" name="hour" class="text" style="width: 30%;"/>
							</td>
							<th>교수</th>
							<td><input type="text" name="sf_name" class="text"/></td>
						</tr>
						<tr>
							<th>능력단위명</th>
							<td><input type="text"  name="us_name" class="text"/></td>
							<th>분류번호</th>
							<td><input type="text"  name="s_category_num" class="text"/></td>
							<th>강의실</th>
							<td><input type="text"  name="r_name" class="text"/></td>
						</tr>
					</table>
				</td> 
			</tr>
		</table>
		</c:forEach>
		</c:if>
		<c:if test="${sb_ar ne null}">
		<c:forEach items="${sb_ar}" var="sbvo" varStatus="vs">
		<table class="table subject_out" style="margin: 0 auto;">
		<colgroup>
			<col width="10%"/>
			<col width="90%"/>
		</colgroup>
		<input type="hidden" name="s_idx" value="${sbvo.s_idx}"/>
			<tr>
				<th>
					<p>과목${vs.index+1}</p>
					<c:if test="${sbvo.s_status eq '0'}">
						<select name="s_status" class="select">
							<option selected value="0">미삭제</option>
							<option value="1">삭제</option>
						</select>
					</c:if>
					<c:if test="${sbvo.s_status eq '1'}">
						<select name="s_status" class="select">
							<option value="0" >미삭제</option>
							<option selected value="1">삭제</option>
						</select>
					</c:if>
				</th> 
				<td>
					<table id=" innerTable" class="table" style="width: 95%; margin-top: 15px;">
					<colgroup>
						<col width="15%"/>
						<col width="15%"/>
						<col width="20%"/>
						<col width="20%"/>
						<col width="10%"/>
						<col width="20%"/>
					</colgroup>
						<tr>
							<th>과목명</th>
							<td><input type="text" value="${sbvo.s_title}" name="s_title" class="text"/></td>
							<th>분류/시수</th>
							<td>
								<c:if test="${sbvo.s_type eq 'NCS'}">
								<select name="s_type" class="select">
									<option selected value="NCS">NCS</option>
									<option value="NONCS">비NCS</option>
								</select>
								</c:if>
								<c:if test="${sbvo.s_type ne 'NCS'}">
								<select name="s_type" class="select">
									<option value="NCS">NCS</option>
									<option selected value="NONCS">비NCS</option>
								</select>
								</c:if>
								<input type="text" value="${sbvo.hour}" name="hour" class="text" style="width: 30%;"/>
							</td>
							<th>교수</th>
							<td><input type="text" value="${sbvo.sf_name}" name="sf_name"/></td>
						</tr>
						<tr>
							<th>능력단위명</th>
							<td><input type="text" value="${sbvo.us_name}" name="us_name" class="text"/></td>
							<th>분류번호</th>
							<td><input type="text" value="${sbvo.s_category_num}" name="s_category_num" class="text"/></td>
							<th>강의실</th>
							<td><input type="text" value="${sbvo.r_name}" name="r_name" class="text"/></td>
						</tr>
					</table>
				</td> 
			</tr>
		</table>
		</c:forEach>
		<c:forEach begin="1" end="${18-sb_length}" varStatus="vs">
		<table class="table subject_out" style="margin: 0 auto;">
			<colgroup>
				<col width="10%"/>
				<col width="90%"/>
			</colgroup>
			<input type="hidden" name="s_idx" />
				<tr>
					<th>
						<p>과목${vs.index + sb_length}</p>
						<select style="width: 80px; height: 25px;" name="s_status">
							<option value="0" >미삭제</option>
							<option value="1">삭제</option>
						</select>
						
					</th> 
					<td>
						<table id="innerTable" class="table" style="width: 95%; margin-top: 15px;">
						<colgroup>
							<col width="15%"/>
							<col width="15%"/>
							<col width="20%"/>
							<col width="20%"/>
							<col width="10%"/>
							<col width="20%"/>
						</colgroup>
							<tr>
								<th>과목명</th>
								<td><input type="text" name="s_title" class="text"/></td>
								<th>분류/시수</th>
								<td>
									<select  name="s_type" class="select">
										<option value="NCS">NCS</option>
										<option value="NONCS">비NCS</option>
									</select>
									<input type="text" name="hour" class="text" style="width: 30%;"/>
								</td>
								<th>교수</th>
								<td><input type="text" name="sf_name" class="text"/></td>
							</tr>
							<tr>
								<th>능력단위명</th>
								<td><input type="text" name="us_name" class="text"/></td>
								<th>분류번호</th>
								<td><input type="text" name="s_category_num" class="text"/></td>
								<th>강의실</th>
								<td><input type="text" name="r_name" class="text"/></td>
							</tr>
						</table>
					</td> 
				</tr>
			</table>
		</c:forEach>
		</c:if>
		<div id="add_space" hidden>
		</div>
		<div align="center">
			<button type="button" id="sb_db_btn" class="btn">저장</button>
			<button type="button" id="sb_add_btn" class="btn">과정추가</button>
			<button type="button" id="cc_cancle" class="btn">목록</button>
		</div>
		</form>
	</div>