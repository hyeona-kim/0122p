<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<table id="makeCounsel" class="table">
    <caption>일자별 상담관리</caption>
                    <thead>
                        <tr>
                            <th>번호</th>
                            <th>이미지</th>
                            <th>학생코드</th>
                            <th>이름</th>
                            <th>연락처</th>
                            <th>주민번호</th>
                            <th>상태</th>
                            <th>최종상담일</th>
                            <th>관리</th>
                        </tr>
                    </thead>
                    <tbody>
                    <c:if test="${ar ne null }">
                    <c:forEach var="vo" items="${ar }" varStatus="vs">
                    <c:set var="num" value="${page.totalRecord - (page.numPerPage*(page.nowPage-1))}"/>
                        <tr>
                            <td>${num-vs.index}</td>
                            <c:if test="${vo.file_name ne null}">
                                <td><img src="${pageContext.request.contextPath }/upload_file/${vo.file_name}" alt="학생이미지" width="80" height="80"/></td>
                            </c:if>
                            <c:if test="${vo.file_name eq null}">
                                <td>No Image</td>
                            </c:if>
                            <td>W1805300001</td>
                            <td>${vo.tr_name} </td>
                            <td>${vo.tr_hp }</td>
                            <td>${vo.tr_rrn }</td>
                            <c:if test="${vo.status eq 0}">
                                <td>수강</td>
                            </c:if>
                            <c:if test="${vo.status eq 1}">
                                <td>수료</td>
                            </c:if>
                            <c:if test="${vo.status eq 2}">
                                <td>제적</td>
                            </c:if>
                            <c:if test="${vo.ss_end ne null}">
                                <td>${vo.ss_end}</td>
                            </c:if>
                            <c:if test="${vo.ss_end eq null}">
                                <td>최근 상담기록 없음</td>
                            </c:if>
                            <td>
                                <button type="button" onclick="counselList('${vo.tr_idx}')" class="btn">상담내역 및 등록</button>
                                <input type="hidden" name="tr_idx" value="${vo.tr_idx }"/>
                            </td>
                        </tr>
                    </c:forEach>
                    </c:if>
                    <c:if test="${ar eq null }">
                        <tr>
                            <td colspan="12">데이터가 없습니다</td>
                        </tr>
                    </c:if>
                    </tbody>
                    <tfoot>
                        <c:if test="${ar ne null }">

                            <tr>
                                <td colspan="12">
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
                                                <li><a onclick="paging('${vs.index}', '${c_idx}')">${vs.index}</a></li>
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
                        </c:if>
                        </tfoot>
                    </table>