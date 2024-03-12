<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
		<form action="editExam" method="post" id="frm">
			<table id="table" class="table">
				<colgroup>
					<col width="20%"/>
					<col width="80%"/>
				</colgroup>
			<thead>
				<h2>총점: ${esvo.es_totalScore}</h2>
			</thead >
            <c:if test="${esvo.es_type ne 2}">
				<c:set var="num" value="${esvo.es_num_question}"/>
            </c:if>
            <c:if test="${esvo.es_type eq 2}">
				<c:set var="num" value="${n1+n2}"/>
            </c:if>
            <c:forEach var="qvo" items="${esvo.qt_ar}" varStatus="vs">
            <input type="hidden" value="${qvo.qt_idx}" name="qt_idx"/>
            <tbody>
                <tr>
                    <th rowspan="7"><label><input type="text" name="sk_idx" class="text" value="" /></label></th>
                </tr>
                <tr>
                    <td>
                        문항${vs.index+1} <input type="text" name="qt_name" placeholder="${vs.index+1}번 문항" class="text" value="${qvo.qt_name}"/>
                    </td>
                </tr>
                <tr>				
                    <td>
                        <textarea cols="80" rows="4" placeholder="문제 내용" class="textarea" name="qt_content">${qvo.qt_content}</textarea>
                    </td>
                </tr>
                <c:if test="${qvo.qt_type eq 0}">
                <c:set var="select" value="select${vs.index}" />  
                <tr>
                    <td id="selectExam${vs.index+1}">
                        <c:forEach var="s" items="${requestScope[select]}" varStatus="ss">
                        <input type="text" value="${ss.index+1}" class="text" style="width: 10%" name="idx${vs.index+1}" readonly/>
                        <input type="text" name="qt_select${vs.index+1}" value="${s}" class="text" style="width: 70%" placeholder="객관식 문항${ss.index+1}"/><br/>
                        </c:forEach>
                    </td>
                </tr>
                <tr>
                    <td>
                        <input type="button" value="객관식문항추가" onclick="addSelect('${vs.index+1}')" class="btn">
                    </td>
                </tr>
                </c:if>
                <tr>
                    <td>
                        정답 : <input type="text" class="text" name="qt_correct" value="${qvo.qt_correct}"/>
                    </td>
                </tr>
                <tr>
                    <td>
                        배점 : <input type="number" class="text" name="qt_score" value="${qvo.qt_score}"/>
                    </td>
                </tr>
                <input type="hidden" value="${qvo.qt_type}" name="qt_type"/>
            </tbody>
            </c:forEach>
			</table>
			
			<div>
				<table>
					<tfoot>
						<tr>
							<td colspan="4">
								<input type="button" value="수정" onclick="edit('${n1}', '${esvo.es_type}', '${esvo.es_totalScore}', '${num}')" class="btn">
								<input type="button" value="목록" id="" class="btn">
								
							</td>
						</tr>
					</tfoot>
				</table>
			</div>
			<div id="box">
				<input type="hidden" name="cPage" value="${param.cPage}"/>
				<input type="hidden" name="es_idx" value="${esvo.es_idx}"/>
			</div>
			<input type="hidden" name="s_idx" value="${svo.s_idx}"/>
		</form>
		