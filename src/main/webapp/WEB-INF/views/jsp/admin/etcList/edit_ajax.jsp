<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="https://cdnjs.cloudflare.com/ajax/libs/signature_pad/1.5.3/signature_pad.min.js"></script>
<h2 class="title">교직원 수정</h2>
<form action="editStaff" method="post" encType="multipart/form-data">
	<input type="hidden" name="sf_idx" value="${vo.sf_idx}">
	<table class="table">
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
				<td><input class="text" type="text" id="sf_name" name="sf_name" data-str="이름" value="${vo.sf_name}"/></td>
				<th>직급</th>
				<td><input class="text" type="text" name="sf_job" data-str="직급" value="${vo.sf_job}"/></td>
			</tr>
			<tr>
				<th>아이디</th>
				<td class="left"><input class="text" type="text" name="sf_id" data-str="아이디" value="${vo.sf_id}"/></td>
				<th>암호</th>
				<td><input class="text" type="text" name="sf_pwd" data-str="암호" value="${vo.sf_pwd}"/></td>
			</tr>
			<tr>
				<th>입사일</th>
				<td><input class="text" type="date" name="sf_hire_date" data-str="입사일" value="${vo.sf_hire_date}"/></td>
				<th>퇴사일</th>
				<td><input class="text" type="date" name="sf_fire_date" data-str="퇴사일" value="${vo.sf_fire_date}"/></td>
			</tr>
			<tr>
				<th>연락처</th>
				<td>
					<input class="text" type="text" placeholder="010" name="sf_phone" data-str="연락처" value="${phone1}" style="width: 20%;"/>
					<input class="text" type="text" placeholder="1234" name="sf_phone" data-str="연락처" value="${phone2}" style="width: 20%;"/>
					<input class="text" type="text" placeholder="5678" name="sf_phone" data-str="연락처" value="${phone3}" style="width: 20%;"/>
				</td>
				<th>사용권한</th>
				<td>
					<select name="rt_idx" class="select">
						<c:choose>
							<c:when test="${vo.rt_idx eq '9'}" >
								<option value="0">기본(일반행정 및 보조직원)</option>
								<option value="1">교직원</option>
								<option value="9" selected>총책임자</option>
							</c:when>
							<c:when test="${vo.rt_idx eq '1'}" >
								<option value="0">기본(일반행정 및 보조직원)</option>
								<option value="1" selected>교직원</option>
								<option value="9">총책임자</option>
							</c:when>
							<c:when test="${vo.rt_idx eq '0'}" >
								<option value="0" selected>기본(일반행정 및 보조직원)</option>
								<option value="1">교직원</option>
								<option value="9">총책임자</option>
							</c:when>
						</c:choose>
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
		<tfoot>
			<tr>
				<td colspan="4">
					<button onclick="javascript:editStaff()" class="btn">수정</button>
					<button onclick="" class="btn">취소</button>
				</td>
			</tr>
		</tfoot>
	</table>
	<%-- 전자서명 표현 부분 --%>
	<div id="certi_sign" hidden="hidden">
		<table class="table">
			<caption>전자서명 입력 테이블</caption>
			<tbody>
				<tr>
					<td style="border: none;">*전자서명을 사용하실 경우 서명을 등록해주세요!</td>
				</tr>
				<tr>
					<td style="border: none;"><button type="button" id="clear_btn" onclick="padClear()" class="btn red2">다시</button></td>
				</tr>
				<tr>
					<td>
						<canvas id="signature" width="600" height="200"></canvas>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	<%-- 도장이미지 표현 부분 --%>
	<div id="certi_image" hidden="hidden">
		<table class="table">
			<caption>도장이미지 입력 테이블</caption>
			<tbody>
				<tr>
					<td style="border: none;">*서명에 사용할 도장을 등록해주세요!</td>
				</tr>
				<tr>
					<td style="border: none;"><input type="file" name="img_file" class="text"></td>
				</tr>
			</tbody>
		</table>
	</div>
</form>