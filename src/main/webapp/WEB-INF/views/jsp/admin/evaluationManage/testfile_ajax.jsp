<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<table id="" class="table">		
			<caption>과정별시간표만들기</caption>
			<thead>
				<tr>
					<th>연번</th>
					<th>직종</th>
					<th>평가유형</th>
					<th>평가</th>
					<th>능력단위요소</th>
					<th>비고</th>
				</tr>
			</thead>
						<tfoot>
							<tr>
				
							</tr>
						</tfoot>
					<tbody>	
							<tr>
								<!-- c:if 문으로 구별-->
                                <td colspan="6">
									평가기본정보가 없습니다.
								</td>
							</tr>
			</tbody>
		</table>