<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
    <!-- colgroup으로 비율 맞춰놔서 width만 100%맞추면 돼요-->
    <form action="afterManage_axaj" method="post" name="qwe" encType="multipart/form-data">
    <table class="after" id="makeTime">
        <colgroup>
            <col width="16%"/>
            <col width="18%"/>
            <col width="16%"/>
            <col width="17%"/>
            <col width="16%"/>
            <col width="17%"/>
        </colgroup>
        <tr>
            <th>성명</th>
            <td>${vo15.tr_name}</td>
            <th>전화번호</th>
            <td>${vo15.tr_hp}</td>
            <th>집전화번호</th>
            <td>${vo15.tr_phone}</td>
        </tr>
        <tr>
            <th>성별</th>
            <td>
            <c:if test="${vo15.gender eq true}">
                남자
            </c:if>
            <c:if test="${vo15.gender eq false}">
                여자
            </c:if>
            </td>
            <th>생년월일</th>
            <td>${vo15.tr_rrn}</td>
            <th>주소(상세)</th>
            <td>${vo15.tr_addr}</td>
        </tr>
        <tr>
            <th>훈련과정명</th>
            <td>${cvo2.c_name}</td>
            <th>교육기간</th>
            <td>${cvo2.start_date}~${cvo2.end_date}</td>
            <th>수료일</th>
            <td>${cvo2.end_date}</td>
        </tr>
        <tr>
            <th>최종학력<br/>(학교명)</th>
            <td>${tfvo.tf_name}</td>
            <th>전공</th>
            <td>${tfvo.tf_major}</td>
            <th>제적일</th>
            <td>
            <c:if test="${vo15.tr_cancel_date ne null}">
                ${vo15.tr_cancel_date}
            </c:if>
            </td>
        </tr>
    </table>
    <table class="after" id="makeTime">
        <colgroup>
            <col width="13%"/>
            <col width="17%"/>
            <col width="13%"/>
            <col width="13%"/>
            <col width="13%"/>
            <col width="13%"/>
            <col width="18%"/>
        </colgroup>
        <tr>
            <th rowspan="${fn:length(qvo)+1}">경력사항</th>
            <th colspan="2">근무지</th>
            <th>근무기간</th>
            <th>직위</th>
            <th>담당업무</th>
            <th>급여수준</th>
        </tr>
        <c:forEach var="qvo" items="${qvo}">
        <tr>
            <td colspan="2">${qvo.qc_cname}</td>
            <td>${qvo.qc_day}</td>
            <td>${qvo.qc_position}</td>
            <td>${qvo.qc_job}</td>
            <td>${qvo.qc_sal}</td>
        </tr>
        </c:forEach>
        <tr>
            <th>보유자격증</th>
            <c:forEach var="qvo" items="${qvo}" varStatus="vs">
                <td colspan="2">${vs.index+1}.${qvo.qc_name}</td>
            </c:forEach>

        </tr>
        <tr>
            <th>외국어능력</th>
            <td colspan="2">
                영어
            <c:if test="${qvo[0].qc_elevel eq null }">
                <input type="radio" name="qc_elevel" value="상"/>상
                <input type="radio" name="qc_elevel" value="중"/>중
                <input type="radio" name="qc_elevel" value="하"/>하
            </c:if>
            <c:if test="${qvo[0].qc_elevel eq '상' }">
                <input type="radio" name="qc_elevel"  value="상" checked/>상
                <input type="radio" name="qc_elevel"  value="중"/>중
                <input type="radio" name="qc_elevel"  value="하"/>하
            </c:if>
            <c:if test="${qvo[0].qc_elevel eq '중' }">
                <input type="radio" name="qc_elevel"  value="상"/>상
                <input type="radio" name="qc_elevel"  value="중" checked/>중
                <input type="radio" name="qc_elevel"  value="하"/>하
            </c:if>
            <c:if test="${qvo[0].qc_elevel eq '하' }">
                <input type="radio" name="qc_elevel" value="상"/>상
                <input type="radio" name="qc_elevel"  value="중"/>중
                <input type="radio" name="qc_elevel"  value="하" checked/>하
            </c:if>
            </td>
            <td colspan="4">

                기타외국어(<input type="text" style="width: 100px;" name="qc_flname" value="${qvo[0].qc_flname}"/>)
            <c:if test="${qvo[0].qc_flevel eq null}">
                <input type="radio" name="qc_flevel" value="상"/>&nbsp;상&nbsp;
                <input type="radio" name="qc_flevel" value="중"/>&nbsp;중&nbsp;
                <input type="radio" name="qc_flevel" value="하"/>&nbsp;하&nbsp;
            </c:if>
            <c:if test="${qvo[0].qc_flevel eq '상'}">
                <input type="radio" name="qc_flevel" value="상" checked/>&nbsp;상&nbsp;
                <input type="radio" name="qc_flevel" value="중"/>&nbsp;중&nbsp;
                <input type="radio" name="qc_flevel" value="하"/>&nbsp;하&nbsp;
            </c:if>
            <c:if test="${qvo[0].qc_flevel eq '중'}">
                <input type="radio" name="qc_flevel" value="상"/>&nbsp;상&nbsp;
                <input type="radio" name="qc_flevel" value="중" checked/>&nbsp;중&nbsp;
                <input type="radio" name="qc_flevel" value="하"/>&nbsp;하&nbsp;
            </c:if>
            <c:if test="${qvo[0].qc_flevel eq '하'}">
                <input type="radio" name="qc_flevel" value="상"/>&nbsp;상&nbsp;
                <input type="radio" name="qc_flevel" value="중"/>&nbsp;중&nbsp;
                <input type="radio" name="qc_flevel" value="하" checked/>&nbsp;하&nbsp;
            </c:if>
            </td>
        </tr>
        <tr>
            <th>컴퓨터능력</th>
            <td colspan="2">
                엑셀
            <c:if test="${qvo[0].qc_xlevel eq null }">
                <input type="radio" name="qc_xlevel" value="상"/>상
                <input type="radio" name="qc_xlevel" value="중"/>중
                <input type="radio" name="qc_xlevel" value="하"/>하
            </c:if>
            <c:if test="${qvo[0].qc_xlevel eq '상' }">
                <input type="radio" name="qc_xlevel"  value="상" checked/>상
                <input type="radio" name="qc_xlevel"  value="중"/>중
                <input type="radio" name="qc_xlevel"  value="하"/>하
            </c:if>
            <c:if test="${qvo[0].qc_xlevel eq '중' }">
                <input type="radio" name="qc_xlevel"  value="상"/>상
                <input type="radio" name="qc_xlevel"  value="중" checked/>중
                <input type="radio" name="qc_xlevel"  value="하"/>하
            </c:if>
            <c:if test="${qvo[0].qc_xlevel eq '하' }">
                <input type="radio" name="qc_xlevel"  value="상"/>상
                <input type="radio" name="qc_xlevel"  value="중"/>중
                <input type="radio" name="qc_xlevel"  value="하" checked/>하
            </c:if>
            </td>
            <td colspan="2">
                파워포인트
            <c:if test="${qvo[0].qc_plevel eq null }">
                <input type="radio" name="qc_plevel" value="상"/>&nbsp;상&nbsp;
                <input type="radio" name="qc_plevel" value="중"/>&nbsp;중&nbsp;
                <input type="radio" name="qc_plevel" value="하"/>&nbsp;하&nbsp;
            </c:if>
            <c:if test="${qvo[0].qc_plevel eq '상' }">
                <input type="radio" name="qc_plevel" value="상" checked/>&nbsp;상&nbsp;
                <input type="radio" name="qc_plevel" value="중"/>&nbsp;중&nbsp;
                <input type="radio" name="qc_plevel" value="하"/>&nbsp;하&nbsp;
            </c:if>
            <c:if test="${qvo[0].qc_plevel eq '중' }">
                <input type="radio" name="qc_plevel" value="상"/>&nbsp;상&nbsp;
                <input type="radio" name="qc_plevel" value="중" checked/>&nbsp;중&nbsp;
                <input type="radio" name="qc_plevel" value="하"/>&nbsp;하&nbsp;
            </c:if>
            <c:if test="${qvo[0].qc_plevel eq '하' }">
                <input type="radio" name="qc_plevel" value="상"/>&nbsp;상&nbsp;
                <input type="radio" name="qc_plevel" value="중"/>&nbsp;중&nbsp;
                <input type="radio" name="qc_plevel" value="하" checked/>&nbsp;하&nbsp;
            </c:if>
            </td>
            <td colspan="2">
                워드
            <c:if test="${qvo[0].qc_wlevel eq null }">
                <input type="radio" name="qc_wlevel" value="상"/>&nbsp;상&nbsp;
                <input type="radio" name="qc_wlevel" value="중"/>&nbsp;중&nbsp;
                <input type="radio" name="qc_wlevel" value="하"/>&nbsp;하&nbsp;
            </c:if>
            <c:if test="${qvo[0].qc_wlevel eq '상' }">
                <input type="radio" name="qc_wlevel" value="상" checked/>&nbsp;상&nbsp;
                <input type="radio" name="qc_wlevel" value="중"/>&nbsp;중&nbsp;
                <input type="radio" name="qc_wlevel" value="하"/>&nbsp;하&nbsp;
            </c:if>
            <c:if test="${qvo[0].qc_wlevel eq '중' }">
                <input type="radio" name="qc_wlevel" value="상"/>&nbsp;상&nbsp;
                <input type="radio" name="qc_wlevel" value="중" checked/>&nbsp;중&nbsp;
                <input type="radio" name="qc_wlevel" value="하"/>&nbsp;하&nbsp;
            </c:if>
            <c:if test="${qvo[0].qc_wlevel eq '하' }">
                <input type="radio" name="qc_wlevel" value="상"/>&nbsp;상&nbsp;
                <input type="radio" name="qc_wlevel" value="중"/>&nbsp;중&nbsp;
                <input type="radio" name="qc_wlevel" value="하" checked/>&nbsp;하&nbsp;
            </c:if>
            </td>
        </tr>
        <tr>
            <th colspan="2">기타추가내용</th>
            <th>(취업예정자격증)</th>
            <td colspan="4">

                <input type="text" style="width: 350px;" name="qc_memo" value="${qvo[0].qc_memo}"/>

            </td>
        </tr>
    </table>
    <table class="after" id="makeTime">
        <colgroup>
            <col width="15%"/>
            <col width="35%"/>
            <col width="15%"/>
            <col width="35%"/>
        </colgroup>
        <tr>
            <th>
                고용지원금 대상자 여부(지원프로그램명 기재)
            </th>
            <td>
            <c:if test="${wvo.wp_re eq null}">
                <input type="radio" name="wp_re" value="Y"/>Y
                <input type="radio" name="wp_re" value="N"/>N
            </c:if>
            <c:if test="${wvo.wp_re eq 'Y'}">
                <input type="radio" name="wp_re"  value="Y" checked />Y
                <input type="radio" name="wp_re" value="N"/>N
            </c:if>
            <c:if test="${wvo.wp_re eq 'N'}">
                <input type="radio" name="wp_re" value="Y" />Y
                <input type="radio" name="wp_re" value="N" checked />N
            </c:if>
            </td>
            <th>
                소속기관명(취업성공패키지 등)
            </th>
            <td>
                <input type="text" style="width: 180px;" name="wp_name" value="${wvo.wp_name}"/>
            </td>
        </tr>
        <tr>
            <th>
                워크넷취업활동 여부(구인구직기간만료확인)
            </th>
            <td colspan="3">
            <c:if test="${wvo.wp_work eq null}">
                <input type="radio" name="wp_work" value="Y"/>Y
                <input type="radio" name="wp_work" value="N"/>N
                (워크넷에서 구직인증기간 만료확인 꼭 해주세요.)
            </c:if>
            <c:if test="${wvo.wp_work eq 'Y'}">
                <input type="radio" name="wp_work" value="Y" checked/>Y
                <input type="radio" name="wp_work" value="N"/>N
                (워크넷에서 구직인증기간 만료확인 꼭 해주세요.)
            </c:if>
            <c:if test="${wvo.wp_work eq 'N'}">
                <input type="radio" name="wp_work" value="Y"/>Y
                <input type="radio" name="wp_work" value="N" checked/>N
                (워크넷에서 구직인증기간 만료확인 꼭 해주세요.)
            </c:if>
            </td>
        </tr>
    </table>
    <table class="after" id="makeTime">
        <colgroup>
            <col width="10%"/>
            <col width="30%"/>
            <col width="30%"/>
            <col width="30%"/>
        </colgroup>
        <tr>
            <th colspan="4">
                교육기간 수료 후 취득 직무능력 조사
            </th>
        </tr>
        <tr>
            <th>보유기술</th>
            <td>1.<input type="text" style="width: 180px;" name="wp_skill" value="${skill[0]}"/></td>
            <td>2.<input type="text" style="width: 180px;" name="wp_skill" value="${skill[1]}"/></td>
            <td>3.<input type="text" style="width: 180px;" name="wp_skill" value="${skill[2]}"/></td>
        </tr>
        <tr>
            <th>기타특이사항</th>
            <td colspan="3"><input type="text" style="width: 600px;" name="wp_etc" value="${wvo.wp_etc}"/></td>
        </tr>
    </table>
    <table class="after" id="makeTime">
        <colgroup>
            <col width="15%"/>
            <col width="12%"/>
            <col width="12%"/>
            <col width="11%"/>
            <col width="15%"/>
            <col width="35%"/>
        </colgroup>
        <tr>
            <th colspan="6">수료 후 희망 근무 조건</th>
        </tr>
        <tr>
            <th>희망지역</th>
            <td>
                1.<br/>
                <input type="text" style="width: 80px;" name="wp_area" value="${area[0]}"/>
            </td>            
            <td>
                2.<br/>
                <input type="text" style="width: 80px;" name="wp_area" value="${area[1]}"/>
            </td>            
            <td>
                3.<br/>
                <input type="text" style="width: 80px;" name="wp_area" value="${area[2]}"/>
            </td>            
            <th>취업희망분야</th>
            <td><input type="text" style="width: 150px;" value="${wvo.wp_hope}" name="wp_hope"/></td>            
        </tr>
        <tr>
            <th>희망급여수준</th>
            <td colspan="4"><input type="text" style="width: 400px;" value="${wvo.wp_pay}" name="wp_pay"/></td>
            <td>
                <input type="checkbox"/>회사내규
            </td>
        </tr>
        <tr>
            <th>가능 고용형태</th>
            <td colspan="5">
            <c:if test="${wvo.wp_form eq null || wvo.wp_form eq ''}">
                <input type="radio" name="wp_form" value="정규직"/>정규직
                <input type="radio" name="wp_form" value="계약직"/>계약직
                <input type="radio" name="wp_form" value="인턴직"/>인턴직
                <input type="radio" name="wp_form" value="아르바이트"/>아르바이트
            </c:if>
            <c:if test="${wvo.wp_form eq '정규직'}">
                <input type="radio" name="wp_form" value="정규직" checked/>정규직
                <input type="radio" name="wp_form" value="계약직"/>계약직
                <input type="radio" name="wp_form" value="인턴직"/>인턴직
                <input type="radio" name="wp_form" value="아르바이트"/>아르바이트
            </c:if>
            <c:if test="${wvo.wp_form eq '계약직'}">
                <input type="radio" name="wp_form" value="정규직"/>정규직
                <input type="radio" name="wp_form" value="계약직" checked/>계약직
                <input type="radio" name="wp_form" value="인턴직"/>인턴직
                <input type="radio" name="wp_form" value="아르바이트"/>아르바이트
            </c:if>
            <c:if test="${wvo.wp_form eq '인턴직'}">
                <input type="radio" name="wp_form" value="정규직"/>정규직
                <input type="radio" name="wp_form" value="계약직"/>계약직
                <input type="radio" name="wp_form" value="인턴직" checked/>인턴직
                <input type="radio" name="wp_form" value="아르바이트"/>아르바이트
            </c:if>
            <c:if test="${wvo.wp_form eq '아르바이트'}">
                <input type="radio" name="wp_form" value="정규직"/>정규직
                <input type="radio" name="wp_form" value="계약직"/>계약직
                <input type="radio" name="wp_form" value="인턴직"/>인턴직
                <input type="radio" name="wp_form" value="아르바이트" checked/>아르바이트
            </c:if>
            </td>
        </tr>
        <tr>
            <th>가능 근무형태</th>
            <td colspan="3">
            <c:if test="${wvo.wp_week eq null || wvo.wp_week eq ''}">
                <input type="radio" name="wp_week" value="주 5일"/>주 5일
                <input type="radio" name="wp_week" value="주 6일"/>주 6일
                <input type="radio" name="wp_week" value="격주휴무"/>격주휴무
            </c:if>
            <c:if test="${wvo.wp_week eq '주 5일'}">
                <input type="radio" name="wp_week" value="주 5일" checked/>주 5일
                <input type="radio" name="wp_week" value="주 6일"/>주 6일
                <input type="radio" name="wp_week" value="격주휴무"/>격주휴무
            </c:if>
            <c:if test="${wvo.wp_week eq '주 6일'}">
                <input type="radio" name="wp_week" value="주 5일"/>주 5일
                <input type="radio" name="wp_week" value="주 6일" checked/>주 6일
                <input type="radio" name="wp_week" value="격주휴무"/>격주휴무
            </c:if>
            <c:if test="${wvo.wp_week eq '격주휴무'}">
                <input type="radio" name="wp_week" value="주 5일"/>주 5일
                <input type="radio" name="wp_week" value="주 6일"/>주 6일
                <input type="radio" name="wp_week" value="격주휴무" checked/>격주휴무
            </c:if>
            </td>
            <th>가능 근무시간</th>
            <td>
            <c:if test="${wvo.wp_time eq null || wvo.wp_time eq ''}">
                <input type="radio" name="wp_time" value="주간"/>주간
                <input type="radio" name="wp_time" value="야간"/>야간
                <input type="radio" name="wp_time" value="심야"/>심야
            </c:if>
            <c:if test="${wvo.wp_time eq '주간'}">
                <input type="radio" name="wp_time" checked/>주간
                <input type="radio" name="wp_time"/>야간
                <input type="radio" name="wp_time"/>심야
            </c:if>
            <c:if test="${wvo.wp_time eq '야간'}">
                <input type="radio" name="wp_time"/>주간
                <input type="radio" name="wp_time" checked/>야간
                <input type="radio" name="wp_time"/>심야
            </c:if>
            <c:if test="${wvo.wp_time eq '심야'}">
                <input type="radio" name="wp_time"/>주간
                <input type="radio" name="wp_time"/>야간
                <input type="radio" name="wp_time" checked/>심야
            </c:if>
            </td>
        </tr>
        <tr>
            <th>훈련생 요청사항</th>
            <td colspan="5">
                <input type="text" style="width: 600px;" value="${wvo.wp_memo}" name="wp_memo"/>
            </td>
        </tr>
    </table>
    <table class="after" id="makeTime">
        <tr>
            <th colspan="6">※취업 관리 사항</th>
        </tr>
        <tr>
            <th>업체명</th>
            <td><input type="text" style="width: 100px;" value="${wvo.wp_wname}" name="wp_wname"/></td>
            <th>사업자등록번호</th>
            <td><input type="text" style="width: 100px;" value="${wvo.wp_number}" name="wp_number"/></td>
            <th>취업확인서</th>
            <td>
            <c:if test="${wvo.wp_check eq null || wvo.wp_check eq ''}">
                <input type="radio" name="wp_check" value="Y"/>Y
                <input type="radio" name="wp_check" value="N"/>N
            </c:if>
            <c:if test="${wvo.wp_check eq 'Y'}">
                <input type="radio" name="wp_check"  value="Y"checked/>Y
                <input type="radio" name="wp_check" value="N"/>N
            </c:if>
            <c:if test="${wvo.wp_check eq 'N'}">
                <input type="radio" name="wp_check" value="Y"/>Y
                <input type="radio" name="wp_check" value="N" checked/>N
            </c:if>
            </td>
        </tr>
        <tr>
            <th>주소</th>
            <td colspan="3"><input type="text" style="width: 400px;" value="${wvo.wp_addr}" name="wp_addr"/></td>
            <th>연락처</th>
            <td>
                <input type="text" style="width: 150px;" value="${wvo.wp_phone}" name="wp_phone"/>
            </td>
        </tr>
        <tr>
            <th>근무직종</th>
            <td><input type="text" style="width: 150px;" value="${wvo.wp_job}" name="wp_job"/></td>
            <th>고용보험유무</th>
            <td>
            <c:if test="${wvo.wp_is eq null || wvo.wp_is eq ''}">
                <input type="radio" name="wp_is" value="Y"/>Y
                <input type="radio" name="wp_is" value="N"/>N
            </c:if>
            <c:if test="${wvo.wp_is eq 'Y'}">
                <input type="radio" name="wp_is" value="Y" checked/>Y
                <input type="radio" name="wp_is" value="N"/>N
            </c:if>
            <c:if test="${wvo.wp_is eq 'N'}">
                <input type="radio" name="wp_is" value="Y"/>Y
                <input type="radio" name="wp_is" value="N" checked/>N
            </c:if>
            </td>
            <th>취업일</th>
            <td><input type="text" style="width: 150px;" value="${wvo.wp_wday}" name="wp_wday"/></td>
        </tr>
        <tr>
            <th>사업자 등록증첨부</th>
            <td colspan="5"><input type="file" name="file"/>
            <c:if test="${wvo.file_name ne null}">
                <span style="font-size: 13px; color: red;">기존파일:${wvo.file_name}</span>
            </c:if>
            </td>
        </tr>
    </table>
    <div align="center">
        <input type="button" value="수정" onclick="editform(this.form)"/>
        <input type="button" value="인쇄"/>
        <input type="button" value="취소"/>
        <input type="hidden" name="c_idx" value="${c_idx}">
        <input type="hidden" name="tr_idx" value="${tr_idx}">
        <input type="hidden" name="wp_idx" value="${wvo.wp_idx}">
        <input type="hidden" name="qc_idx" value="${qvo[0].qc_idx}">
    </div>
</form>