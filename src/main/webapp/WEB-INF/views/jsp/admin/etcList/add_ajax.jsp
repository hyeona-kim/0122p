<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/signature_pad/1.5.3/signature_pad.min.js"></script>
<h2 class="title">교직원 등록</h2>
<form action="addStaff" method="post">
	<table class="table">
		<colgroup>
			<col width="15%">
			<col width="35%">
			<col width="15%">
			<col width="35%">
		</colgroup>
		<caption>교직원 등록 테이블</caption>
		<tbody>
			<tr>
				<th>이름</th>
				<td><input class="text" type="text" placeholder="이름" data-str="이름" name="sf_name"/></td>
				<th>직급</th>
				<td><input class="text" type="text" placeholder="직급" data-str="직급" name="sf_job"/></td>
			</tr>
			<tr>
				<th>아이디</th>
				<td><input class="text" type="text" placeholder="아이디" data-str="아이디" name="sf_id"/></td>
				<th>암호</th>
				<td><input class="text" type="text" placeholder="암호" data-str="암호" name="sf_pwd"/></td>
			</tr>
			<tr>
				<th>입사일</th>
				<td><input class="text" type="date" placeholder="2023-01-01" data-str="입사일" name="sf_hire_date"/></td>
				<th>퇴사일</th>
				<!-- <td class="left"><input class="input" type="date" disabled="disabled" name="sf_fire_date"/></td> -->
				<td>년-월-일</td>
			</tr>
			<tr>
				<th>연락처</th>
				<td>
					<input class="text" type="text" placeholder="010" name="sf_phone" data-str="연락처" style="width: 20%;"/>
					<input class="text" type="text" placeholder="1234" name="sf_phone" data-str="연락처" style="width: 20%;"/>
					<input class="text" type="text" placeholder="5678" name="sf_phone" data-str="연락처" style="width: 20%;"/>
				</td>
				<th>사용권한</th>
				<td>
					<select name="rt_idx" class="select">
						<option value="0">기본(일반행정 및 보조직원)</option>
						<option value="1">교직원</option>
						<option value="9">총책임자</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>인증선택</th>
				<td colspan="3">
					<select id="certification" onchange="changeCertifi()" class="select">
						<option value="none">사용안함</option>
						<option value="image">도장이미지</option>
						<option value="sign">전자서명</option>
					</select>
				</td>
			</tr>
		</tbody>
	</table>
	<%-- 도장이미지 표현 부분 --%>
	<div id="certi_image" hidden="hidden">
		<table class="certi_table table" >
			<caption>도장이미지 입력 테이블</caption>
			<tbody>
				<tr>
					<td style="border: none; ">*서명에 사용할 도장을 등록해주세요!</td>
				</tr>
				<tr>
					<td style="border: none; "><input type="file" name="img_file" class="text"></td>
				</tr>
			</tbody>
		</table>
	</div>
	<%-- 전자서명 표현 부분 --%>
	<div id="certi_sign" hidden="hidden">
		<table class="certi_table table">
			<caption>전자서명 입력 테이블</caption>
			<tbody>
				<tr>
					<td style="border: none; ">*전자서명을 사용하실 경우 서명을 등록해주세요!</td>
				</tr>
				<tr>
					<td style="border: none; ">
						<button type="button" id="clear_btn" onclick="padClear()" class="btn">다시</button>
						<button id="save" class="btn">저장</button>
					</td>
				</tr>
				<tr>
					<td>
						<canvas id="canvas" width="600" height="200"></canvas>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	<div class="main_item align_center">
		<button onclick="javascript:addStaff()" class="btn">등록</button>
		<button id="cc_btn" class="btn">취소</button>
	</div>
</form>