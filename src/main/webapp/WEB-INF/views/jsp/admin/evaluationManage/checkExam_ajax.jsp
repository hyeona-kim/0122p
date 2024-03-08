<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<h2 id="table_h2" class="title">응시확인 파일확인 </h2>
	<form action="checkExam_file" method="post" encType="multipart/form-data" name="frm02">
		 <input type="hidden" name="fname"/>
			<table id="table" class="table">
				<tbody>
					<tr>
						<th><label>구분</label></th>
						<th><label>다운로드</label></th>
						<th><label>파일올리기</label></th>
					</tr>
					<tr>
						<td>응시확인서류</td>
							<td>
							<c:if test="${fvo2 ne null}">
								<button type="button" onclick="download2('${fvo2.cef_name}')" value="${fvo2.cef_name}">${fvo2.cef_name}</button>
								<input type="hidden" name="cef_name" value="${fvo2.cef_name}"/>
							</c:if>
							</td>
						<td>
							<input type="file" name="file1" class="text" />
						</td>
					</tr>
				
				</tbody>
				<tfoot>
					<tr>
						<td colspan="2" id="">
							<input type="submit" value="저장" class="btn">
							<input type="button" value="목록" id="cc_cancle" class="btn">
							<input name="es_idx" type="hidden" value="${esvo.es_idx}"/>
							
						</td>
					</tr>
				</tfoot>	
			</table>
		</form>
		