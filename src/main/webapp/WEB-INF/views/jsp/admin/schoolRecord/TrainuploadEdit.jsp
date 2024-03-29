<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

				<form action="trainuploadedit" method="post" encType="multipart/form-data" name="fff">
				<table id="makeTime" class="table">
					<colgroup>
						<col width="20%"/>
						<col width="80%"/>
					</colgroup>
					<h2 class="title">확인서류등록</h2>
					<caption>확인서류등록 리스트</caption>
					<tbody>
						<tr>
							<th>확인서류명</th>
							<td><input type="text" name="subject" value="${vo3.subject}" data-str="서류명" class="text"/></td>
						</tr>
						<tr>
							<th>과정별 자동입력</th>
							<td>
								<table id="t2" class="table" style="margin-bottom: 5px; width: 95%;">
									<colgroup>
										<col width="25%"/>
										<col width="25%"/>
										<col width="25%"/>
										<col width="25%"/>
									</colgroup>
									<tbody>
										<tr>
											<th>훈련생명</th>
											<td colspan="3"></td>
										<tr>	
											<th>과정명</th>
											<td></td>
											<th>훈련기간</th>
											<td></td>
										</tr>
									</tbody>
								</table>
							</td>
						</tr>
						<tr>
							<th>내용</th>
							<td><textarea id="content" name="content"  cols="100" rows="8">${vo3.content }</textarea></td>
						</tr>
						<tr>
							<th>첨부파일:</th>
							<td ><input type="file" name="file" data-str="파일" class="text"/>
								<c:if test="${vo3.file_name ne null }">
								<span style="color: red;">(${vo3.file_name })</span>
								</c:if>
							</td>
						</tr>
					</tbody>
					<tfoot>
						<tr>
							<td colspan="2">
								<input type="button" value="저장" onclick="sendData(this.form)" class="btn"/>
								<input type="button" value="닫기" onclick="javascript:location.href='trainupload'" class="btn">
							</td>
						</tr>
					</tfoot>
			</table>
			<input type="hidden" name="tn_idx" value="${vo3.tn_idx }">
		</form>
