<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<table class="table">
	<h2 class="title"></h2>
	<caption>고충 및 건의사항 보기 테이블</caption>
	<colgroup>
		<col width="25%"/>
		<col width="25%"/>
		<col width="25%"/>
		<col width="25%"/>
	</colgroup>
	<tbody>
		<!-- 문의 글 qna_title/qna_writer/qna_write_date-->
		<input type="hidden" id="qna_idx" value="${svo.qna_idx}"/>
		<tr>
			<th>제목</th>
			<td>${svo.qna_title}</td>
			<th>작성자</th>
			<td>${svo.qna_writer}</td>
		</tr>
		<tr>
			<td colspan="4">
				${svo.qna_write_date}
			</td>
		</tr>
		<tr>
			<td colspan="4">
				<textarea class="textarea" rows="12" disabled style="background-color: #dedede;">
					${svo.qna_content}
				</textarea>
			</td>
		</tr>
		<tr>
			<th colspan="4">
				답변
			</th>
		</tr>
		<c:if test="${fn:length(svo.c_list) eq 0}">
			<tr>
				<td colspan="4">
					<textarea class="textarea" rows="12" id="cm_content">
						
					</textarea>
				</td>
			</tr>
		</c:if>
		<c:if test="${fn:length(svo.c_list) ne 0}">
			<c:forEach var="cvo" items="${svo.c_list}">
				<tr>
					<td colspan="4">
						작성자:${cvo.cm_writer}(${cvo.cm_write_date})
					</td>
				</tr>
				<tr>
					<td colspan="4">
						<textarea class="textarea" rows="12" disabled>
							${cvo.cm_content}
						</textarea>
					</td>
				</tr>
			</c:forEach>
		</c:if>
	</tbody>
	<tfoot>
		<tr>
			<td colspan="4">
				<button type="button" id="cc_cancle" class="btn">목록</button>
				<button type="button" id="add_comm" class="btn">답변달기</button>
			</td>
			<input type="hidden" id="cm_write_date" />
			<input type="hidden" id="cm_writer" value="${vo.sf_name}"/>
		</tr>
	</tfoot>
</table>

