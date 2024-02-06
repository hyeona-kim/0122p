<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/functions" %>
		<h2 id="hd" class="title">"${cvo.c_name}"과정 상담 일괄등록</h2>
	<form action="uploadAllCounsel?c_idx=${cvo.c_idx}" method="post" name="ua">
		<table id="t1" class="table">
			<thead>
				<tr >
					<th>번호</th>
					<th>성명</th>
					<th>상담일(필수항목)</th>
					<th>상담자</th>
					<th>상담종류</th>
                    <th>상담목적</th>
					<th>상담내용</th>
					<th>지도관리 및 피드백</th>
				</tr>
				<c:if test="${ar ne null}">
                    <c:forEach var="vo" items="${ar }" varStatus="vs">
                        <tr>
                            <td>${vs.index+1}</td>
							<td>
                                ${vo.tr_name}
                                <input type="hidden" name="tr_idx" value="${vo.tr_idx}"/>
                            </td>
							<td><input type="date" name="date" class="text"/></td>
                            <td>
                                <input type="text" name="sf_name" value="${cvo.svo.sf_name}" class="text"/>
                                <input type="hidden" name="sf_idx" value="${cvo.svo.sf_idx}"/>
                            </td>
                            <td>
                                <select name="select" class="select">
                                    <option value="일반상담" selected>일반상담</option>
                                    <option value="입학상담">입학상담</option>
                                    <option value="정기상담">정기상담</option>
                                    <option value="고충상담">고충상담</option>
                                    <option value="집중상담">집중상담</option>
                                    <option value="심화상담">심화상담</option>
                                    <option value="수료상담">수료상담</option>
                                    <option value="수료후상담">수료후상담</option>
                                    <option value="취업상담">취업상담</option>
                                </select>
                            </td>
                            <td><textarea name="so_pp"></textarea></td>
                            <td><textarea name="so_subject"></textarea></td>
                            <td><textarea name="so_pd"></textarea></td>
						</tr>
					</c:forEach>
				</c:if>
			</thead>
			<tfoot>
				<tr>
					<td colspan="8" align="left">
						<input type="submit"  id="sav"  value="저장" class="btn"/>
						<input type="button"  id="cl" value="닫기" class="btn"/>
					</td>
				</tr>
			</tfoot>
			<input type="hidden" name="cPage" value="${param.cPage}"/>
			<input type="hidden" name="listSelect" value="${param.listSelect}"/>
		</table>	
	</form>
			
