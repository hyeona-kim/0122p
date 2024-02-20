<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:if test="${admin_menu eq 'staff'}">
    <div class="title">교직원 관리</div>
    <article>
        
    <div>
        <c:if test="${page.totalRecord > 0}">
            <c:if test="${requestScope.page.nowPage == 1 }">
                <a class="disable">◀</a>
            </c:if>	
            <c:if test="${requestScope.page.nowPage != 1 }">
                <a href="javascript:paging('${page.nowPage-1 }')">◀</a>
            </c:if>
        </c:if>
    </div>
    <table id="staffList" class="table">
        <caption>교직원현황 테이블</caption>
        <tbody>
            <%-- ===== 출력할 교직원 항목 ===== --%>
            <tr>
                <th>번호</th>
                <th>성명</th>
                <th>교수코드</th>
                <th>직급</th>
                <th>아이디</th>
                <th>암호</th>
                <th>연락처</th>
                <th>입사일</th>
                <th>퇴사일</th>
                <th>사용권한</th>
                <th>차단여부</th>
                <th>책임자</th>
                <th colspan="2">관리</th>
            </tr>
            <%-- ===== 교직원 목록 출력 ===== --%>
                <c:forEach items="${requestScope.ar}" varStatus="vs" var="vo2">
                    <tr>
                        <td>${vs.index+1}</td>
                        <td>${vo2.sf_name}</td>
                        <%-- 사용권한이 1(교수)인 사람만
                             교수코드(sf_code)를 출력 --%>
                        <c:if test="${vo2.sf_code ne 'tcnull'}">
                            <td>${vo2.sf_code}</td>
                        </c:if>
                        <c:if test="${vo2.sf_code eq 'tcnull'}">
                            <td></td>
                        </c:if>
                        <td>${vo2.sf_job}</td>
                        <td>${vo2.sf_id}</td>
                        <td>${vo2.sf_pwd}</td>
                        <td>${vo2.sf_phone}</td>
                        <td>${vo2.sf_hire_date}</td>
                        <td>${vo2.sf_fire_date}</td>
                        <c:if test="${vo2.rt_name ne null}">
                            <td>${vo2.rt_name}</td>
                        </c:if>
                        <c:if test="${vo2.rt_name eq null}">
                            <td></td>
                        </c:if>
                        <%-- sf_link가 1인 사람만 ON 마크 표시 --%>
                        <c:if test="${vo2.sf_link eq '1'}">
                            <td><button type="button" id="block_btn" onclick="unblockStaff('${vo2.sf_idx}')" class="btn red2">ON</button></td>
                        </c:if>
                        <c:if test="${vo2.sf_link eq '0'}">
                            <td></td>
                        </c:if>
                        <%-- 사용권한이 9인 사람은 총책임자, 1인 사람은 교직원 마크 표시 --%>
                        <c:if test="${vo2.rt_idx eq '1'}">
                            <td><span id="faculty">교직원</span></td>
                        </c:if>
                        <c:if test="${vo2.rt_idx eq '9'}">
                            <td><span id="director">총책임자</span></td>
                        </c:if>
                        <c:if test="${vo2.rt_idx ne '9' and vo2.rt_idx ne '1'}">
                            <td></td>
                        </c:if>
                        <td colspan="2">
                            <a href="javascript:editStaffForm('${vo2.sf_idx}')" class="btn" style="text-decoration: none;">수정</a>
                            <a href="javascript:delStaff('${vo2.sf_idx}')" class="btn red" style="text-decoration: none;">삭제</a>
                        </td>
                    </tr>
                </c:forEach>
        </tbody>
    </table>
    <div>
        <c:if test="${page.totalRecord > 0}">
            <c:if test="${page.nowPage != page.totalPage }">
                <a href="javascript:paging('${page.nowPage+1 }')">▶</a>
            </c:if>
            <c:if test="${page.nowPage == page.totalPage }">
                <a class="disable">▶</a>	
            </c:if>
        </c:if>
    </div>
    </article>
</c:if>