<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<h2 id="table_h2">훈련생현황</h2>
	<form action="Controller" method="post" name="frm02">
		<input type="hidden" name="type"  value="addCourse"/>
			<table id="table">
			<thead>
				<tr>
					<td colspan="4">
						｜훈련생정보수정
					</td>
				</tr>
			</thead>
				<tbody>
					<tr>
						<th><label>학생코드</label></th>
						<td colspan="2"></td>
					</tr>
					<tr>
						<th><label>이름</label></th>
						<td><input type="text"></td>
						<th><label>주민번호</label></th>
						<td>
							<input type="text">-<input type="text">
						</td>
					</tr>
					<tr>
						<th><label>휴대폰번호</label></th>
						<td>
							<input type="text" name="ph">-
							<input type="text" name="ph">-
							<input type="text" name="ph">
						</td>
						<th><label>과정명</label></th>
						<td></td>
					</tr>
					<tr>
						<th><label>집전화</label></th>
						<td>
							<input type="text" name="hph">-
							<input type="text" name="hph">-
							<input type="text" name="hph">						
						</td>
						<th><label>HRD등록일</label></th>
						<td><input type="text"></td>
					</tr>
					<tr>
						<th><label>현재상태</label></th>
						<td><select>
								<option value="수강">수강</option>
								<option value="비수강">비수강</option>
							</select>
						</td>
					<tr>
						<th><label>수강포기(제적,취소)일</label></th>
						<td><input type="text" name="ch"></td>
					</tr>
					<tr>
						<th><label>수료일</label></th>
						<td><input type="text"></td>
					</tr>
					<tr>
						<th><label>수강포기(제적,취소)사유</label></th>
						<td><input type="text" name="ch"></td>
					</tr>
					<tr>
						<th><label>사진(210*210)</label></th>
						<td>
							<input type="file"/>
						</td>
					<tr>
						<th><label>이직전직장명</label></th>
						<td><input type="text"></td>
					</tr>
					<tr>
						<th><label>환불금액</label></th>
						<td><input type="text"><div id="box">(* ,없이 숫자로만 입력해주세요)</div></td>
					</tr>
					<tr>
						<th><label>담당직무</label></th>
						<td><input type="text"></td>
					</tr>
					
					
					
					
					
						<tr>
						<th><label>전체교육비</label></th>
						<td>
							<input type="text"/><div id="box">(*,없이 숫자로만 입력해주세요)</div>
						</td>
					<tr>
						<th><label>지원경로</label></th>
						<td colspan="2">
						<select>
							<option value="인터넷">인터넷</option>
							<option value="전단지">전단지</option>
							<option value="현수막">현수막</option>
							<option value="생활정보지">생활정보지</option>
							<option value="고용지원센터">고용지원센터</option>
							<option value="직접내방">직접내방</option>
							<option value="지인소개">지인소개</option>
							<option value="HRD">HRD</option>
							<option value="기타">기타</option>
						</select></td>
					</tr>
					<tr>
						<th><label>카드유형</label></th>
						<td>
							<select>
								<option value="취성패1">취성패1</option>
								<option value="취성패2">취성패1</option>
								<option value="내일배움">내일배움</option>
							</select>
						</td>
					</tr>
					<tr>
						<th><label>주소</label></th>
						<td colspan="3">
							<input type="search"><input type="button">우편번호검색
							<input type="text">
						</td>
					</tr>
					<tr>
						<th><label>상담내용</label></th>
						<td>
							<table>
								<tbody>
									<tr>
										<th>상담일</th>
										<th>상담자</th>
										<th>상담내용</th>
									</tr>
									<tr>
										<td>상담내용이 없습니다.</td>
									</tr>
								</tbody>
							</table>
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
							<input type="submit" value="등록">
						</td>
						<td colspan="2" align="left">
							<input type="button" value="목록" id="cc_cancle">
						</td>
					</tr>
				</tfoot>	
			</table>
		</form>
		