<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<table class="table">
    <colgroup>
        <col width="5%"/>
        <col width="5%"/>
        <col width="8%"/>
        <col width="5%"/>
        <col width="5%"/>
        <col width="5%"/>
        <col width="5%"/>
        <col width="5%"/>
        <col width="22%"/>
        <col width="5%"/>
        <col width="5%"/>
        <col width="24%"/>
    </colgroup>
    <thead>
        <tr>
            <th rowspan="2">
                선택
                <input type="checkbox"  id="chk_all"/>
            </th>
            <th rowspan="2">번호</th>
            <th rowspan="2">작성일</th>
            <th rowspan="2">재적</th>
            <th rowspan="2">출석</th>
            <th rowspan="2">결석</th>
            <th rowspan="2">지각</th>
            <th rowspan="2">조퇴</th>
            <th rowspan="2">특이사항</th>
            <th colspan="2">결제현황</th>
            <th rowspan="2">관리</th>
        </tr>
        <tr>
            <th>관리자</th>
            <th>책임자</th>
        </tr>
    </thead>
    <tfoot>
        <tr>
            <td colspan="12">
                <ol class="page">
        <c:if test="${requestScope.page.startPage < requestScope.page.pagePerBlock }">
            <li class="disable">&lt;</li>
        </c:if>	

        <c:if test="${requestScope.page.startPage >= requestScope.page.pagePerBlock }">
            <c:if test="${param.select != null}">
                <li><a href="javascript:paging('${page.startPage-page.pagePerBlock }')">&lt;</a></li>
            </c:if>
        </c:if>

        <c:forEach begin="${page.startPage }" end="${page.endPage }" varStatus="vs">
            <c:if test="${vs.index eq page.nowPage }">
                <li class="now">${vs.index }</li>
            </c:if>
            <c:if test="${vs.index ne page.nowPage }">
                <li><a href="javascript:paging('${vs.index}')">${vs.index}</a></li>
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
	<tbody>	
        <c:if test="${td_ar eq null}">
            <td colspan="12">
                등록된 훈련일지가 존재하지 않습니다.
            </td>
        </c:if>
        <c:if test="${td_ar ne null}">
            <c:forEach var="tdvo" items="${td_ar}" varStatus="vs">
                <c:set var="num" value="${page.totalRecord - (page.numPerPage*(page.nowPage-1))}"/>
                <!--td_idx, write_date, td_attend, td_tardy, td_earlyLeave, td_significant, c_idx, admin_check, ceo_check-->
                <tr>
                    <td>
                        선택
                        <input type="checkbox"  name="chk"  class="chk"/>
                    </td>
                    <td>${num-vs.index}</td>
                    <td>${tdvo.write_date}</td>
                    <td>${fn:length(cvo.tr_ar3)}</td>
                    <td>${fn:length(cvo.tr_ar3)}</td>
                    <td>${tdvo.attend_check}</td>
                    <td>${tdvo.tardy_check}</td>
                    <td>${tdvo.earlyLeave_check}</td>
                    <td>${tdvo.td_significant}</td>
                    <c:if test="${vo.sf_tmgr eq 1}">
                        <!--총책임자인 경우-->
                        <c:if test="${tdvo.ceo_check eq 1 || tdvo.admin_check eq 1}">
                            <!-- ceo_check 나 admin_check가 하나라도 있다면 ...-->
                            <!-- 결재가 있는곳에 결재 사인 이미지 파일 넣어주기 -->
                            <c:if test="${tdvo.admin_check eq 0}">
                                <td style="color: blue;">결</td> 
                            </c:if>
                            <c:if test="${tdvo.admin_check eq 1}">
                                <td style="color: red;">미</td>
                            </c:if>
                            <c:if test="${tdvo.ceo_check eq 0}">
                                <td style="color: blue;">결</td>
                            </c:if>
                            <c:if test="${tdvo.ceo_check eq 1}">
                                <td style="color: red;">미</td>
                            </c:if>
                        </c:if>
                        <c:if test="${tdvo.ceo_check eq 0 && tdvo.admin_check eq 0}">
                            <td style="color: red;">미</td>
                            <td><a style="color: red; text-decoration: underline;" onclick="sign('${tdvo.td_idx}')">미</a></td>
                        </c:if>
                    </c:if>
                    <c:if test="${vo.sf_tmgr eq 0}">
                        <!--총책임자가 아닌 경우-->
                        <c:if test="${tdvo.ceo_check eq 0 || tdvo.admin_check eq 0}">
                            <!-- ceo_check 나 admin_check가 하나라도 있다면 ...-->
                            <!-- 결재가 있는곳에 결재 사인 이미지 파일 넣어주기 -->
                            <c:if test="${tdvo.admin_check eq 0}">
                                <td style="color: blue;">
                                    <a onclick="showSign('${tdvo.td_idx}')">결</a>
                                    <div hidden id="img_div${tdvo.td_idx}">
                                        <img style="display: inline-block; width: 100%; height: 98%;" src="${pageContext.request.contextPath }/trainingLog_sign/${tdvo.td_sign}"/>
                                    </div>
                                </td> 
                            </c:if>
                            <c:if test="${tdvo.admin_check eq 1}">
                                <td style="color: red;">미</td>
                            </c:if>
                            <c:if test="${tdvo.ceo_check eq 0}">
                                <td style="color: blue;">
                                    <a onclick="showSign('${tdvo.td_idx}')">결</a>
                                    <div hidden id="img_div${tdvo.td_idx}">
                                        <img style="display: inline-block; width: 100%; height: 98%;" src="${pageContext.request.contextPath }/trainingLog_sign/${tdvo.td_sign}"/>
                                    </div>
                                </td> 
                            </c:if>
                            <c:if test="${tdvo.ceo_check eq 1}">
                                <td style="color: red;">미</td>
                            </c:if>
                        </c:if>
                        <c:if test="${tdvo.ceo_check eq 1 && tdvo.admin_check eq 1}">
                            <td><a style="color: red; text-decoration: underline;" onclick="sign('${tdvo.td_idx}','${vo.sf_tmgr}')">미</a></td>
                            <td style="color: red;">미</td>
                        </c:if>
                    </c:if>
                    <td>
                        <button type="button" class="btn green" onclick="viewTraining('${tdvo.td_idx}')">훈련일지</button>
                        <button type="button" class="btn blue" onclick="editTraining('${tdvo.td_idx}')">수정</button>
                        <button type="button" class="btn red" onclick="delTraining('${tdvo.td_idx}')">삭제</button>
                    </td>
                </tr>
            </c:forEach>
        </c:if>
	</tbody>
</table>