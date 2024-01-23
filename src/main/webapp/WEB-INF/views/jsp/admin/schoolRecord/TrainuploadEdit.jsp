<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

				<form action="Controller?type=trainuploadedit" method="post" encType="multipart/form-data" name="fff">
				<table id="makeTime" >
				<caption>확인서류등록 리스트</caption>
					<tbody>
						<tr>
							<th>확인서류명</th>
							<td><input type="text" name="title" value="${vo3.subject }" data-str="서류명"/></td>
						</tr>
						<tr>
							<th>과정별 자동입력</th>
							<td>
								<table id="t2">
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
							<td><textarea id="content" name="content" ${vo3.content } cols="100" rows="8"></textarea></td>
						</tr>
						<tr>
							<th>첨부파일:</th>
							<td><input type="file" name="file" data-str="파일"/>
								<c:if test="${vo3.file_name ne null }">
								(${vo3.file_name })
								</c:if>
							</td>
						</tr>
						<tr>
							<td colspan="2">
								<input type="button" value="저장"
								onclick="sendData()"/>
								<input type="button" value="닫기" onclick="javascript:location.href='Controller?type=trainupload'">
							</td>
						</tr>
					</tbody>
			</table>
						<input type="hidden" name="tn_idx" value="${vo3.tn_idx }">

			</form>
