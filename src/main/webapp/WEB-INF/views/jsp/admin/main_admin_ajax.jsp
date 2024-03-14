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
    <table id="staffList" class="table" style="font-weight: bold;">
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
                    <c:set var="num" value="${page.totalRecord - (page.numPerPage*(page.nowPage-1))}"/>
                    <tr>
                        <td>${num-vs.index}</td>
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
                        <c:if test="${vo2.sf_link eq '1'}">
                            <td><button type="button" id="block_btn" onclick="unblockStaff('${vo2.sf_idx}')" class="btn red2">ON</button></td>
                        </c:if>
                        <c:if test="${vo2.sf_link eq '0'}">
                            <td></td>
                        </c:if>
                        <c:if test="${vo2.sf_tmgr eq '1'}"> <%-- 권한을 여러개 갖을 수 있으므로, 가장 높은 권한부터 순차적으로 확인하여 출력 --%>
                            <td><span id="director">최고
                                <br/>관리자</span></td>
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
                            <c:if test="${sessionScope.vo.sf_mgr eq '1' or sessionScope.vo.sf_tmgr eq '1'}">
                                <a href="javascript:editStaffForm('${vo2.sf_idx}')" class="btn" style="text-decoration: none;">수정</a>
                                    <a href="javascript:delStaff('${vo2.sf_idx}', '${vo2.sf_tcr}', '${vo2.sf_mgr}', '${vo2.sf_tmgr}')" class="btn red" style="text-decoration: none;">삭제</a>
                            </c:if>
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
                    <li><a href="counselReceipt?listSelect=1&cPage=1">면접평가표관리</a></li>
                    <li><a href="counselReceipt?listSelect=2&cPage=1">입학상담내역</a></li>
                    <li><a href="counselReceipt?listSelect=3&cPage=1">일일모집현황</a></li>
                    <li><a href="counselReceipt?listSelect=4&cPage=1">교육생등록현황</a></li>
                    <li><a href="counselReceipt?listSelect=5&cPage=1">수강생파일등록</a></li>
                </ul>
            </li>
            <li>
                <a href="course?listSelect=1&cPage=1" class="menu2">과정등록</a>
                <ul class="sub_manu2">
                    <li><a href="course?listSelect=1&cPage=1">교육과정현황</a></li>
                    <li><a href="course?listSelect=2&cPage=1">교수계획서 / 학습안내서</a></li>
                    <li><a href="course?listSelect=3&cPage=1">시간표만들기(HRD)</a></li>
                </ul>
            </li>
            <li>
                <a href="suggestionList?cPage=1" class="menu2">학적부</a>
                <ul class="sub_manu2">
                    <li><a href="traincurrent">과정별 훈련생 현황</a></li>
                    <li><a href="trainupload">훈련생확인서류등록</a></li>
                    <li><a href="trainconfirm">훈련생확인서류관리</a></li>
                    <li><a href="suggestionList?cPage=1">Q&A</a></li>
                    <li><a href="boardMainList">게시판</a></li>
                </ul>
            </li>
            <li>
                <a href="t_log?listSelect=1&cPage=1" class="menu2">훈련일지</a>
                <ul class="sub_manu2">
                    <li><a href="t_log?listSelect=1&cPage=1">훈련일지</a></li>            
                </ul>
            </li>
            <li>
                <a href="counsel?listSelect=1&cPage=1" class="menu2">상담관리</a>
                <ul class="sub_manu2">
                    <li><a href="counsel?listSelect=1&cPage=1">과정별 상담관리</a></li>
                    <li><a href="counsel?listSelect=2&cPage=1">일자별 상담관리</a></li>
                    <li><a href="counsel?listSelect=3&cPage=1">교육생별 상담관리</a></li>
                </ul>
            </li>

            <li>
                <a href="em_log?listSelect=1&cPage=1" class="menu2">평가관리</a>
                <ul class="sub_manu2">
                    <li><a href="em_log?listSelect=1&cPage=1">과목별 평가설정</a></li>
                    <li><a href="em_log?listSelect=2&cPage=1">과목별 채점결과보기</a></li>
                    <li><a href="em_log?listSelect=3&cPage=1">훈련생 종합 성적표</a></li>
                    <!-- <li><a href="em_log?listSelect=4&cPage=1">훈련생 개별 성적표</a></li>
                    <li><a href="em_log?listSelect=5&cPage=1">시험지파일등록</a></li> -->
                </ul>
            </li>
            <li>
                <a href="f_log?listSelect=1&cPage=1" class="menu2">사후관리</a>
                <ul class="sub_manu2">
                    <li><a href="f_log?listSelect=1&cPage=1" >일일취업보고</a></li>
                    <li><a href="f_log?listSelect=2&cPage=1" >취업현황보고</a></li>
                    <li><a href="f_log?listSelect=3&cPage=1" >사후관리현황</a></li>
                    <!-- <li><a href="f_log?listSelect=4&cPage=1" >사후관리현황표</a></li> -->
                    <li><a href="f_log?listSelect=5&cPage=1" >취업확인서</a></li>
                    <!-- <li><a href="f_log?listSelect=6&cPage=1" >전체취업생현황</a></li> -->
   
                </ul>
            </li>
            
            <li>
                <a href="staffList" class="menu2">기타관리</a>
                <ul class="sub_manu2">
                    <li><a href="staffList">교직원현황</a></li>
                    <li><a href="weeklyMeeting">주간회의록</a></li>	
                    <li><a href="formDownload">서식자료실</a></li>	
                    <li><a href="calendar">일정관리</a></li>	
                    <li><a href="bookList" >교재결재내역</a></li>	
                </ul>
            </li>
           
        </ul>
    </div>
  
</c:if>
<c:if test="${admin_menu eq 'counseling'}">
    <div id="counseling_div">
        <div>
            <h2 class="title">문의내역</h2>
            <div class="main_item align_right">
                <button type="button" class="btn" id="allinquiry">전체 문의내역 보기</button>
            </div>
            <c:if test="${fn:length(ar1) < 5}">
                <c:forEach begin="0" end="${fn:length(ar1)-1}" varStatus="vs">
                    <article onclick="inquiry('${ar1[vs.index].ac_idx}')">${ar1[vs.index].ac_title}(${fn:substring(ar1[vs.index].ac_write_date, 0, 10)})
                        <span>
                            <c:if test="${ar1[vs.index].ac_answer_date ne null}">
                                답변<input type="checkbox" checked readonly disabled/>
                            </c:if>
                            <c:if test="${ar1[vs.index].ac_answer_date eq null}">
                                답변:<input type="checkbox" readonly disabled/>
                            </c:if>
                        </span>
                    </article>
                </c:forEach>
            </c:if>
            <c:if test="${fn:length(ar1) >= 5}">
                <c:forEach begin="0" end="4" varStatus="vs">
                    <article onclick="inquiry('${ar1[vs.index].ac_idx}')" >${ar1[vs.index].ac_title}(${fn:substring(ar1[vs.index].ac_write_date, 0, 10)})
                        <span>
                            <c:if test="${ar1[vs.index].ac_answer_date ne null}">
                                답변<input type="checkbox" checked readonly disabled/>
                            </c:if>
                            <c:if test="${ar1[vs.index].ac_answer_date eq null}">
                                답변:<input type="checkbox" readonly disabled/>
                            </c:if>
                        </span>
                    </article>
                </c:forEach>
            </c:if>
        </div>

        <div>
            <h2 class="title">상담내역</h2>
            <div class="main_item align_right">
                <button type="button" class="btn" id="allconsult">전체 상담내역 보기</button>
            </div>

            <c:if test="${fn:length(ar2) < 5}">
                <c:forEach begin="0" end="${fn:length(ar2)-1}" varStatus="vs">
                    <article onclick="consult('${ar2[vs.index].ac_idx}')">${ar2[vs.index].ac_name} / ${ar2[vs.index].ac_phone} / ${ar2[vs.index].ac_email}
                        <span>
                            <c:if test="${ar2[vs.index].ac_answer_date ne null}">
                                연락:<input type="checkbox" checked disabled/>
                            </c:if>
                            <c:if test="${ar2[vs.index].ac_answer_date eq null}">
                                연락:<input type="checkbox" readonly disabled/>
                            </c:if>
                        </span>
                    </article>
                </c:forEach>
            </c:if>
            <c:if test="${fn:length(ar2) >= 5}">
                <c:forEach begin="0" end="4" varStatus="vs">
                    <article onclick="consult('${ar2[vs.index].ac_idx}')">${ar2[vs.index].ac_name} / ${ar2[vs.index].ac_phone} / ${ar2[vs.index].ac_email}
                        <span>
                            <c:if test="${ar2[vs.index].ac_answer_date ne null}">
                                연락:<input type="checkbox" checked disabled/>
                            </c:if>
                            <c:if test="${ar2[vs.index].ac_answer_date eq null}">
                                연락:<input type="checkbox" readonly disabled/>
                            </c:if>
                        </span>
                    </article>
                </c:forEach>
            </c:if>
        </div>
    </div>
    <div id="inquiry_ajax" hidden>
        <h2 class="title">문의 리스트</h2>
        <div style="text-align: center; font-size: 12px;">문의가 답변되지 않은 경우 꼭 문의 답변을 남겨주세요.</div>
        <c:forEach var="inquiryVO" items="${ar1}" varStatus="vs">
            <article onclick="inquiry('${inquiryVO.ac_idx}')" >${inquiryVO.ac_title}(${fn:substring(inquiryVO.ac_write_date, 0, 10)})
                <span>
                    <c:if test="${ar1[vs.index].ac_answer_date ne null}">
                        답변<input type="checkbox" checked readonly disabled/>
                    </c:if>
                    <c:if test="${ar1[vs.index].ac_answer_date eq null}">
                        답변:<input type="checkbox" readonly disabled/>
                    </c:if>
                </span>
            </article>
            
        </c:forEach>
    </div>
    <div id="consult_ajax" hidden>
        <h2 class="title">상담 리스트</h2>
        <div style="text-align: center; font-size: 12px;">예비 훈련생과 연락후 상담일정을 잡으신경우 등록해주세요.</div>
        <c:forEach var="consultVO" items="${ar2}" varStatus="vs">
            <article onclick="consult('${ar2[vs.index].ac_idx}')">${consultVO.ac_name} / ${consultVO.ac_phone} / ${consultVO.ac_email}
                <span>
                    <c:if test="${ar2[vs.index].ac_answer_date ne null}">
                        연락:<input type="checkbox" checked disabled/>
                    </c:if>
                    <c:if test="${ar2[vs.index].ac_answer_date eq null}">
                        연락:<input type="checkbox" readonly disabled/>
                    </c:if>
                </span>
            </article>
            
        </c:forEach>
    </div>
</c:if>