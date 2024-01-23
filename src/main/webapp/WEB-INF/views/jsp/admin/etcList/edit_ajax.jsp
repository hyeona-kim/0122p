<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/signature_pad/1.5.3/signature_pad.min.js"></script>
<form action="Controller?type=editStaff" method="post" encType="multipart/form-data">
	<table>
		<colgroup>
			<col width="15%">
			<col width="35%">
			<col width="15%">
			<col width="35%">
		</colgroup>
		<caption>교직원 수정 테이블</caption>
		<tbody>
			<tr>
				<th>이름</th>
				<td class="left"><input class="input" type="text" id="sf_name" name="sf_name"/></td>
				<th>직급</th>
				<td class="left"><input class="input" type="text" name="sf_job"/></td>
			</tr>
			<tr>
				<th>아이디</th>
				<td class="left"><input class="input" type="text" name="sf_id"/></td>
				<th>암호</th>
				<td class="left"><input class="input" type="text" name="sf_pwd"/></td>
			</tr>
			<tr>
				<th>입사일</th>
				<td class="left"><input class="input" type="date" name="sf_hire_date"/></td>
				<th>퇴사일</th>
				<td class="left"><input class="input" type="date" name="sf_fire_date"/></td>
			</tr>
			<tr>
				<th>연락처</th>
				<td class="left">
					<input class="phone" type="text" placeholder="010" name="sf_phone"/>
					<input class="phone" type="text" placeholder="1234" name="sf_phone"/>
					<input class="phone" type="text" placeholder="5678" name="sf_phone"/>
				</td>
				<th>사용권한</th>
				<td class="left">
					<select name="rt_idx">
						<option value="0">기본(교직원)</option>
						<option value="1">임직원</option>
						<option value="9">총책임자</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>인증선택</th>
				<td colspan="3" class="left">
					<select id="certification" onchange="changeCertifi()">
						<option value="none">사용안함</option>
						<option value="image">도장이미지</option>
						<option value="sign">전자서명</option>
					</select>
				</td>
			</tr>
		</tbody>
		<tfoot>
			<tr>
				<td colspan="4">
					<!-- <button type="button" onclick="addStaff()" class="staff_edit_btn staff_btn">저장</button>
					<button type="button" onclose="" class="staff_del_btn staff_btn">취소</button> -->
					<a href="javascript:addStaff()" class="staff_edit_btn staff_btn">수정</a>
					<a href="" class="staff_del_btn staff_btn">취소</a>
				</td>
			</tr>
			<%-- 도장이미지 표현 부분 --%>
			<tr>
				<td>
					<div id="certi_image" hidden="hidden">
						<table class="certi_table">
							<caption>도장이미지 입력 테이블</caption>
							<tbody>
								<tr>
									<td>*서명에 사용할 도장을 등록해주세요!</td>
								</tr>
								<tr>
									<td><input type="file" name="img_file"></td>
								</tr>
							</tbody>
						</table>
					</div>
				</td>
			</tr>
			<%-- 전자서명 표현 부분 --%>
			<tr>
				<td>
					<div id="certi_sign" hidden="hidden">
						<table class="certi_table">
							<caption>전자서명 입력 테이블</caption>
							<tbody>
								<tr>
									<td>*전자서명을 사용하실 경우 서명을 등록해주세요!</td>
								</tr>
								<tr>
									<td><button type="button" id="clear_btn" onclick="padClear()">다시</button></td>
								</tr>
								<tr>
									<td>
										<canvas id="signature" width="600" height="200"></canvas>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</td>
			</tr>
		</tfoot>
	</table>
</form>