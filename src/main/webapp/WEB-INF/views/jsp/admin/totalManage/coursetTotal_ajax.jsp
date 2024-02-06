<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

		<table id="makeCourse" class="table">
			<caption>교육과정리스트</caption>
			<colgroup>
				<col width="5%"/>
				<col width="6%"/>
				<col width="5%"/>
				<col width="7%"/>
				<col width="7%"/>
				<col width="7%"/>
				<col width="7%"/>
				<col width="6%"/>
				<col width="8%"/>
				<col width="8%"/>
				<col width="7%"/>
				<col width="7%"/>
				<col width="6%"/>
				<col width="7%"/>
				<col width="10%"/>
			</colgroup>
							<thead>
								<tr>
									<th>연번</th>
									<th>과정명</th>
									<th>회차</th>
									<th>개강일</th>
									<th>종료일</th>
									<th>과정타입</th>
									<th>담당교수</th>
									<th>모집인원<br/>/실시(수료)인원</th>
									<th>사전평가</th>
									<th>평가관리</th>
									<th>상담관리</th>
									<th>훈련일자</th>
									<th>보강훈련</th>
									<th>사후취업지원</th>
									<th>훈련생별</th>
								</tr>
							</thead>
							<tbody>
							<c:if test="${c_ar ne null }">
							<c:forEach var="cvo" items="${c_ar }" varStatus="vs">
							<c:set var="num" value="${page.totalRecord - (page.numPerPage*(page.nowPage-1))}"/>
								<tr>
									<td>${num-vs.index}</td>
									<td>${cvo.c_name }</td>
									<td>${cvo.c_round_num}</td>
									<td>${cvo.start_date} </td>
									<td>${cvo.end_date} </td>
									<td>${cvo.ctvo.ct_name }</td>
									<td>${cvo.svo.sf_name }</td>
									<td>${cvo.c_peo_num }&nbsp;/&nbsp;${fn:length(cvo.tr_ar)}</td>
									<td><button type="button" class="btn blue">사전평가<br/>평가현황</button></td>
									<td><button type="button" class="btn blue">교과목별<br/> 평가현황</button></td>
									<td>
										<c:if test="${fn:length(cvo.cs_ar) eq 0}">
										<button type="button" onclick="javascript:location.href='counsel?listSelect=4&cPage=1&c_idx=${cvo.c_idx}'" class="btn red2">미작성</button>
										</c:if>
										<c:if test="${fn:length(cvo.cs_ar) ne 0}">
										<button type="button" onclick="javascript:location.href='counsel?listSelect=4&cPage=1&c_idx=${cvo.c_idx}'" class="btn yellow">
											LAST<br/>(${fn:substring(cvo.cs_ar[0].so_day, 5, 10)})
										</button>
										</c:if>
									</td>
									<td><button type="button" class="btn red2">미작성</button></td>
									<td><button type="button" class="btn red2">보강<br/>없음</button></td>
									<td><button type="button" class="btn red2">미작성</button></td>
									<td><button type="button" class="btn yellow" onclick="javascript:location.href='total?listSelect=2&c_idx=${cvo.c_idx}'">훈련생<br/>보기</button></td>
								</tr>
							</c:forEach>
							</c:if>
							<c:if test="${c_ar eq null }">
								<tr>
									<td colspan="15">검색 결과가 없습니다</td>
								</tr>
							</c:if>
							</tbody>
							<tfoot>
						<tr>
							<td colspan="15">
								<ol class="page">
			<c:if test="${requestScope.page.startPage < requestScope.page.pagePerBlock }">
				<li class="disable">&lt;</li>
			</c:if>	
	
			<c:if test="${requestScope.page.startPage >= requestScope.page.pagePerBlock }">
				<li><a href="javascript:paging('${page.startPage-page.pagePerBlock }')">&lt;</a></li>
			</c:if>

			<c:forEach begin="${page.startPage }" end="${page.endPage }" varStatus="vs">
				<c:if test="${vs.index eq page.nowPage }">
					<li class="now">${vs.index }</li>
				</c:if>
				<c:if test="${vs.index ne page.nowPage }">
					<li><a onclick="paging('${vs.index}')">${vs.index}</a></li>
				</c:if>
			</c:forEach>
	
			<c:if test="${page.endPage < page.totalPage }">
				<li><a href="javascript:paging('${page.startPage + page.pagePerBlock }')">&gt;</a></li>
			</c:if>
			<c:if test="${page.endPage >= page.totalPage }">
				<li class="disable">&gt;</li>	
			</c:if>
                              </ol>
                          </td>
						</tr>
					</tfoot>
						</table>