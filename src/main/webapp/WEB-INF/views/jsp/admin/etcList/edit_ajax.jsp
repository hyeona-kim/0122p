<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="https://cdnjs.cloudflare.com/ajax/libs/signature_pad/1.5.3/signature_pad.min.js"></script>
<h2 class="title">교직원 수정</h2>
<form action="editStaff?place=${place}" method="post" encType="multipart/form-data" id="frm2">
	<input type="hidden" name="sf_idx" value="${vo.sf_idx}">
	<input type="hidden" name="log_idx" value="${sessionScope.vo.sf_idx}">
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
					<select name="authority" class="select" id="authority">
						<c:if test="${vo.sf_tmgr eq '0'}">
							<c:choose>
								<c:when test="${vo.sf_mgr eq '1' and vo.sf_tcr eq '1'}" >
									<option value="0">교직원</option>
									<option value="1">관리자</option>
									<option value="2" selected>관리자(강사겸임)</option>
								</c:when>
								<c:when test="${vo.sf_mgr eq '1' and vo.sf_tcr eq '0'}" >
									<option value="0">교직원</option>
									<option value="1" selected>관리자</option>
									<option value="2">관리자(강사겸임)</option>
								</c:when>
								<c:when test="${vo.sf_mgr eq '0' and vo.sf_tcr eq '1'}" >
									<option value="0" selected>교직원</option>
									<option value="1">관리자</option>
									<option value="2">관리자(강사겸임)</option>
								</c:when>
							</c:choose>
							<c:if test="${sessionScope.vo.sf_tmgr eq '1'}"> <%-- 이 옵션이 선택된 상태로 저장버튼 누르면 확인창 띄워서 권한이전을 하시겠습니까? 물어보기 --%>
							<option value="3">최고 관리자</option>
							</c:if>
						</c:if>
						<c:if test="${vo.sf_tmgr eq '1'}">
							<option value="3" selected>최고 관리자</option>
						</c:if>
					</select>
				</td>
			</tr>
		<tr>
			<c:if test="${sessionScope.vo.sf_idx eq vo.sf_idx}">
			<th>인증선택</th>
				<td colspan="3">
					<select id="certification" onchange="changeCertifi()" class="select">
						<option value="none" selected>사용안함</option>
						<option value="image">도장이미지</option>
						<option value="sign">전자서명</option>
					</select>
				</td>
			</c:if>
		</tr>
	</tbody>
	<tfoot>
		<tr>
			<td colspan="4">
				<button type="button" onclick="javascript:editStaff('${vo.sf_idx}')" class="btn">수정</button>
				<button type="button" id="cc_btn" class="btn">취소</button>
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
					<c:if test="${vo.sf_fname eq null}">	
						<td style="border: none;">*전자서명을 사용하실 경우 서명을 등록해주세요!</td>
					</c:if>
				</tr>
				<c:if test="${vo.sf_fname ne null}">
					<tr>
						<td>
							<img src="${pageContext.request.contextPath}/upload_sign/${vo.sf_fname}" onerror="this.style.display='none'" width="100%" />
						</td>
					</tr>
					
					<tr><td style="border: none;">기존 사인을 수정하시려면 아래에 새로 입력해주세요(반드시 수정 후 저장해야 적용됩니다)</td></tr>
				</c:if>
				<tr>
					<td style="border: none;">
						<button type="button" id="clear_btn" class="btn red2">다시</button>
						<button type="button" onclick="addSign()" class="btn red2">저장</button>
					</td>
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
					<td style="border: none;"><input type="file" name="ifile" class="text"></td>
				</tr>
			</tbody>
		</table>
	</div>
	<input type="hidden" id="sf_fname" name="sf_fname" value=""/>
</form>