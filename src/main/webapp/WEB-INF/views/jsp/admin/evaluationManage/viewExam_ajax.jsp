<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
			<h2 id="hd" class="title">(교과목명)${svo.s_title}</h2>

			<form action="" method="post">
			<table id="table" class="table">
				<colgroup>
					<col width="20%"/>
					<col width="30%"/>
					<col width="25%"/>
					<col width="25%"/>
				</colgroup>
			<thead>
			</thead>
				<tbody>
					<tr>
						<th><label>평가일시</label></th>
						<td>
							${esvo.es_date}
						</td>
						<th><label>훈련생</label></th>
						<td>
						
						</td>
					</tr>
					<tr>
						<th><label>교과목</label></th>
						<td>

						</td>
						<th><label>훈련교사</label></th>
						<td>
							${esvo.sf_idx}
						</td>
					</tr>
					<tr>
						<th><label>능력단위명/수준</label></th>
						<td>${esvo.sk_idx} / ${esvo.es_level}</td>
						<th><label>평가시간</label></th>
						<td>${esvo.es_time}</td>
					</tr>
					<tr>
						<th><label>평가유형</label></th>
						<td>${esvo.es_type}</td>
						<th><label>총배점</label></th>
						<td>${esvo.es_totalScore}</td>
					</tr>
					<tr>
						<th><label>평가점수</label></th>
						<td></td>
						<th><label>성취수준</label></th>
						<td></td>
					</tr>
					
					<tr>
						<th><label>성취기준</label></th>
						<td colspan="3">


						</td>
					</tr>
					<tr>
						<th><label>능력단위요소</label></th>
						<td colspan="3">${esvo.sk_idx}</td>
					</tr>
					<!--문제 반복문 처리-->
					<c:forEach var="qvo" items="${qt_ar}" varStatus="vs">

						<tr>
							<th colspan="4">문항</th>
						</tr>
						<tr>
							<th>
								<label>{문제의 능력단위요소}</label><br/>
								<input type="text" value="${esvo.sk_idx}" readonly />
							</th>
							<td colspan="3">
								문항${vs.index+1}. ${qvo.qt_name} <br/>
								<textarea cols="80" rows="4" >${qt_content}</textarea><br/>
								<c:if test="${qvo.qt_type eq 0}">
									<c:set var="select" value="select${vs.index}" />
										
									<c:forEach var="s" items="${requestScope[select]}" varStatus="ss">
										${ss.index+1}. ${s}<br/>
									</c:forEach>
								</c:if>
									정답 : ${qvo.qt_correct}
									<br/>
									배점 : ${qvo.qt_score}
							</td>
						</tr>
					</c:forEach>
						
					</tbody>
					
					
					<tfoot>
						<tr>
							<td colspan="4" style="color: #154790;">
								
							</td>
					</tr>
					<tr>
						<td colspan="4" >
							<input type="button" value="시험지인쇄(정답포함)" onclick="" class="btn">
							<input type="button" value="시험지인쇄(정답 미포함)" id="" class="btn">
							<input type="button" value="엑셀 저장" id="" class="btn">
							<input type="button" value="목록" id="" class="btn">
						</td>
					</tr>
				</tfoot>	
				<input type="hidden" name="cPage" value="${param.cPage}"/>
			</table>
		</form>
