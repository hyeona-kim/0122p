<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<h2 id="subject_h2">${cvo.c_name}</h2>
	<div id="btns">
		<button id="add_subject_btn">교과목 파일등록</button>
		<button onclick="downSubject()">교과목등록액셀파일</button>
	</div>
	<div id="subject_wrap">
		<table class="subject_out">
		<colgroup>
			<col width="10%"/>
			<col width="90%"/>
		</colgroup>
			<tr>
				<th>
					<p>과목1</p>
					<select>
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
		<table class="subject_out">
			<colgroup>
				<col width="10%"/>
				<col width="90%"/>
			</colgroup>
				<tr>
					<th>
						<p>과목1</p>
						<select>
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
			<table class="subject_out">
				<colgroup>
					<col width="10%"/>
					<col width="90%"/>
				</colgroup>
					<tr>
						<th>
							<p>과목1</p>
							<select>
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
	</div>
