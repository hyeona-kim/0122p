<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<h2 id="subject_h2">${cvo.c_name}</h2>
	<div id="btns">
		<button id="add_subject_btn">교과목 파일등록</button>
		<button onclick="downSubject()">교과목등록액셀파일</button>
	</div>
	<div id="subject_wrap">
		<c:if test="${sb_ar eq null}">
		<c:forEach begin="1" end="3">
		<table class="subject_out">
		<colgroup>
			<col width="10%"/>
			<col width="90%"/>
		</colgroup>
			<tr>
				<th>
					<p>과목1</p>
					
					<select style="width: 80px; height: 25px;">
						<option>미삭제</option>
						<option>삭제</option>
					</select>
					
				</th> 
				<td>
					<table id="innerTable">
					<colgroup>
						<col width="10%"/>
						<col width="30%"/>
						<col width="10%"/>
						<col width="20%"/>
						<col width="10%"/>
						<col width="20%"/>
					</colgroup>
						<tr>
							<th>과목명</th>
							<td><input type="text" style="width: 320px; height: 25px;"/></td>
							<th>분류/시수</th>
							<td>
								<select style="width: 80px; height: 25px;">
									<option>NCS</option>
									<option>비NCS</option>
								</select>
								<input type="text" style="width: 70px; height: 25px;"/>
							</td>
							<th>교수</th>
							<td></td>
						</tr>
						<tr>
							<th>능력단위명</th>
							<td><input type="text" style="width: 320px; height: 25px;"/></td>
							<th>분류번호</th>
							<td></td>
							<th>강의실</th>
							<td></td>
						</tr>
					</table>
				</td> 
			</tr>
		</table>
		</c:forEach>
		</c:if>
		<c:if test="${sb_ar ne null}">
		<c:forEach items="${sb_ar}" var="sbvo">
		<table class="subject_out">
		<colgroup>
			<col width="10%"/>
			<col width="90%"/>
		</colgroup>
			<tr>
				<th>
					<p>과목1</p>
					<c:if test="${sbvo.s_status eq '0'}">
						<select  style="width: 80px; height: 25px;">
							<option selected>미삭제</option>
							<option >삭제</option>
						</select>
					</c:if>
					<c:if test="${sbvo.s_status eq '1'}">
						<select  style="width: 80px; height: 25px;">
							<option >미삭제</option>
							<option selected>삭제</option>
						</select>
					</c:if>
				</th> 
				<td>
					<table id="innerTable">
					<colgroup>
						<col width="10%"/>
						<col width="30%"/>
						<col width="10%"/>
						<col width="20%"/>
						<col width="10%"/>
						<col width="20%"/>
					</colgroup>
						<tr>
							<th>과목명</th>
							<td><input type="text" style="width: 320px; height: 25px;" value="${sbvo.s_title}"/></td>
							<th>분류/시수</th>
							<td>
								<c:if test="${sbvo.s_type eq 'NCS'}">
									<select style="width: 80px; height: 25px;">
										<option selected>NCS</option>
										<option>비NCS</option>
									</select>
								</c:if>
								<c:if test="${sbvo.s_type ne 'NCS'}">
									<select style="width: 80px; height: 25px;">
										<option>NCS</option>
										<option selected>비NCS</option>
									</select>
								</c:if>
								<input type="text" style="width: 70px; height: 25px;" value="${sbvo.hour}"/>
							</td>
							<th>교수</th>
							<td>${sbvo.sf_name}</td>
						</tr>
						<tr>
							<th>능력단위명</th>
							<td><input type="text" style="width: 320px; height: 25px;" value="${sbvo.us_name}"/></td>
							<th>분류번호</th>
							<td>${sbvo.s_category_num}</td>
							<th>강의실</th>
							<td>${sbvo.r_name}</td>
						</tr>
					</table>
				</td> 
			</tr>
		</table>
		</c:forEach>
		</c:if>
		<div align="center">
			<button type="button" id="">저장</button>
			<button type="button">과정추가</button>
			<button type="button" id="cc_cancle">목록</button>
		</div>
	</div>