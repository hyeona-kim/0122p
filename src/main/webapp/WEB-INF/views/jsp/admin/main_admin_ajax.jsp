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
                        <c:if test="${vo2.sf_mgr eq '1' or vo2.sf_tmgr eq '1'}">
                            <td>관리자그룹</td>
                        </c:if>
                        <c:if test="${vo2.sf_tmgr eq '0'}">
                            <c:if test="${vo2.sf_mgr eq '0' and vo2.sf_tcr eq '1'}">
                                <td>교강사그룹</td>
                            </c:if>
                            <c:if test="${vo2.sf_mgr eq '0' and vo2.sf_tcr eq '0'}">
                                <td></td>
                            </c:if>

                        </c:if>
                        <%-- sf_link가 1인 사람만 ON 마크 표시 --%>
                        <c:if test="${sfvo.sf_link eq '1'}">
                            <td><button type="button" id="block_btn" onclick="unblockStaff('${sfvo.sf_idx}')" class="btn red2">ON</button></td>
                        </c:if>
                        <c:if test="${sfvo.sf_link eq '0'}">
                            <td></td>
                        </c:if>

                        <c:if test="${vo2.sf_tmgr eq '1'}"> <%-- 권한을 여러개 갖을 수 있으므로, 가장 높은 권한부터 순차적으로 확인하여 출력 --%>
                            <td><span id="director">최고 관리자</span></td>
                        </c:if>
                        <c:if test="${vo2.sf_tmgr eq '0'}">
                            <c:if test="${vo2.sf_mgr eq '1'}">
                                <td><span id="manager">관리자</span></td>
                            </c:if>
                            <c:if test="${vo2.sf_mgr eq '0'}">
                                <c:if test="${vo2.sf_tcr eq '1'}">
                                    <td><span id="faculty">교직원</span></td>
                                </c:if>
                                <c:if test="${vo2.sf_tcr eq '0'}">
                                    <td></td>
                                </c:if>
                            </c:if>
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
<c:if test="${admin_menu eq 'allMenu'}">
    <div id="navi2_wrap">      
        <ul id="navi2">
            <li>
                <a href="counselReceipt?listSelect=1&cPage=1" class="menu2" id="first">상담 및 접수</a>
                <ul class="sub_manu2" id="first">
                    <li>상담및접수</li>
                    <li><a href="counselReceipt?listSelect=1&cPage=1">&nbsp;&nbsp;&nbsp;면접평가표관리</a></li>
                    <li><a href="counselReceipt?listSelect=2&cPage=1">&nbsp;&nbsp;&nbsp;입학상담내역</a></li>
                    <li><a href="counselReceipt?listSelect=3&cPage=1">&nbsp;&nbsp;&nbsp;일일모집현황</a></li>
                    <li><a href="counselReceipt?listSelect=4&cPage=1">&nbsp;&nbsp;&nbsp;교육생등록현황</a></li>
                    <li><a href="counselReceipt?listSelect=5&cPage=1">&nbsp;&nbsp;&nbsp;수강생파일등록</a></li>
                </ul>
            </li>
            <li>
                <a href="course?listSelect=1&cPage=1" class="menu2">과정등록</a>
                <ul class="sub_manu2">
                    <li>과정등록</li>
                    <li><a href="course?listSelect=1&cPage=1">&nbsp;&nbsp;&nbsp;교육과정현황</a></li>
                    <li><a href="course?listSelect=2&cPage=1">&nbsp;&nbsp;&nbsp;교수계획서 / 학습안내서</a></li>
                    <li><a href="course?listSelect=3&cPage=1">&nbsp;&nbsp;&nbsp;시간표만들기(HRD)</a></li>
                </ul>
            </li>
            <li>
                <a href="suggestionList?cPage=1" class="menu2">학적부</a>
                <ul class="sub_manu2">
                    <li>학적부</li>
                    <li><a href="suggestionList?cPage=1">&nbsp;&nbsp;&nbsp;고충 및 건의사항</a></li>
                    <li><a href="traincurrent">&nbsp;&nbsp;&nbsp;과정별 훈련생 현황</a></li>
                    <li><a href="trainupload">&nbsp;&nbsp;&nbsp;훈련생확인서류등록</a></li>
                    <li><a href="trainconfirm">&nbsp;&nbsp;&nbsp;훈련생확인서류관리</a></li>
                    <li><a href="boardMainList">&nbsp;&nbsp;&nbsp;게시판</a></li>
                </ul>
            </li>
            <li>
                <a href="counsel?listSelect=1&cPage=1" class="menu2">상담관리</a>
                <ul class="sub_manu2">
                    <li>상담관리</li>
                    <li><a href="counsel?listSelect=1&cPage=1">&nbsp;&nbsp;&nbsp;과정별 상담관리</a></li>
                    <li><a href="counsel?listSelect=2&cPage=1">&nbsp;&nbsp;&nbsp;일자별 상담관리</a></li>
                    <li><a href="counsel?listSelect=3&cPage=1">&nbsp;&nbsp;&nbsp;교육생별 상담관리</a></li>
                </ul>
            </li>
            <li>
                <a href="t_log?listSelect=1&cPage=1" class="menu2">훈련일지</a>
                <ul class="sub_manu2">
                    <li>훈련일지</li>
                    <li><a href="t_log?listSelect=1&cPage=1">&nbsp;&nbsp;&nbsp;훈련일지</a></li>
                    <li><a href="t_log?listSelect=2&cPage=1">&nbsp;&nbsp;&nbsp;보강훈련일지</a></li>                    
                </ul>
            </li>
            <li>
                <a href="" class="menu2">사전평가</a>
                <ul class="sub_manu2"> 
                    <li>사전평가</li>
                </ul>
            </li>
            <li>
                <a href="" class="menu2">자기/수행평가</a>
                <ul class="sub_manu2">
                    <li>자기/수행평가</li>
                </ul>
            </li>
            <li>
                <a href="" class="menu2">평가관리</a>
                <ul class="sub_manu2">
                    <li>평가관리</li>
                </ul>
            </li>
            <li>
                <a href="" class="menu2">설문관리</a>
                <ul class="sub_manu2">
                    <li>설문관리</li>
                </ul>
            </li>
            <li>
                <a href="" class="menu2">증서관리</a>
                <ul class="sub_manu2">
                    <li>증서관리</li>
                </ul>
            </li>
            <li>
                <a href="" class="menu2">사후관리</a>
                <ul class="sub_manu2">
                    <li>사후관리</li>
                </ul>
            </li>
            <li>
                <a href="total?listSelect=1&cPage=1" class="menu2">통합관리</a>
                <ul class="sub_manu2">
                    <li>통합관리</li>
                    <li><a href="total?listSelect=1&cPage=1">&nbsp;&nbsp;&nbsp;과정별 통합관리</a></li>
                    <li><a href="total?listSelect=2&cPage=1">&nbsp;&nbsp;&nbsp;과정별 학생관리</a></li>
                    <li><a href="total?listSelect=3&cPage=1">&nbsp;&nbsp;&nbsp;일정관리</a></li>
                </ul>
            </li>
            <li>
                <a href="" class="menu2">자료실</a>
                <ul class="sub_manu2">
                    <li>자료실</li>
                </ul>
            </li>
            <li>
                <a href="" class="menu2">커뮤니티</a>
                <ul class="sub_manu2">
                    <li>커뮤니티</li>
                </ul>
            </li>
            <li>
                <a href="" class="menu2">로그현황</a>
                <ul class="sub_manu2">
                    <li>로그현황</li>
                </ul>
            </li>
            <li>
                <a href="staffList" class="menu2">기타관리</a>
                <ul class="sub_manu2">
                    <li>기타관리</li>
                    <li><a href="staffList">&nbsp;&nbsp;&nbsp;&nbsp;교직원현황</a></li>
                    <li><a href="weeklyMeeting">&nbsp;&nbsp;&nbsp;&nbsp;주간회의록</a></li>	
                    <li><a href="formDownload">&nbsp;&nbsp;&nbsp;&nbsp;서식자료실</a></li>	
                    <li><a href="">&nbsp;&nbsp;&nbsp;&nbsp;훈련교재현황</a></li>	
                    <li><a href="">&nbsp;&nbsp;&nbsp;&nbsp;훈련시설현황</a></li>	
                    <li><a href="">&nbsp;&nbsp;&nbsp;&nbsp;훈련장비현황</a></li>	
                    <li><a href="">&nbsp;&nbsp;&nbsp;&nbsp;휴일일정관리</a></li>	
                </ul>
            </li>
            <li>
                <a href="" class="menu2">시스템문의</a>
            </li>
        </ul>
    </div>
  
</c:if>