<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
    <h2>사후관리카드</h2>
    <!-- colgroup으로 비율 맞춰놔서 width만 100%맞추면 돼요-->
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
            <td></td>
            <th>생년월일</th>
            <td>${fn:substring(vo15.tr_rrn,0,6)}</td>
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
            <td>${vo15.tr_cancel_date}</td>
        </tr>
    </table>
    <table class="after" id="makeTime">
        <colgroup>
            <col width="16%"/>
            <col width="20%"/>
            <col width="16%"/>
            <col width="16%"/>
            <col width="16%"/>
            <col width="16%"/>
        </colgroup>
        <tr>
            <th rowspan="3">경력사항</th>
            <th>근무지</th>
            <th>근무기간</th>
            <th>직위</th>
            <th>담당업무</th>
            <th>급여수준</th>
        </tr>
        <tr>
            <td>${qvo.qc_cname}</td>
            <td>${qvo.qc_day}</td>
            <td>${qvo.qc_position}</td>
            <td>${qvo.qc_job}</td>
            <td>${qvo.qc_sal}</td>
        </tr>
        <tr>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
        </tr>
        <tr>
            <th>보유자격증</th>
            <td>1.${qvo.qc_name}</td>
            <td colspan="2">2.</td>
            <td colspan="2">3.</td>
        </tr>
        <tr>
            <th>외국어능력</th>
            <td>
                영어
                <input> 
                <input type="radio"  value="상"/>상
                <input type="radio"  value="중"/>중
                <input type="radio"  value="하"/>하
            </td>
            <td colspan="4">
                기타외국어(<input type="text" style="width: 100px;" name="r1"/>)
                <input type="radio" name="r1"/>&nbsp;상&nbsp;
                <input type="radio" name="r1"/>&nbsp;중&nbsp;
                <input type="radio" name="r1"/>&nbsp;하&nbsp;
            </td>
        </tr>
        <tr>
            <th>컴퓨터능력</th>
            <td>
                엑셀
                <input type="radio" name="r2" value="상"/>상
                <input type="radio" name="r2" value="중"/>중
                <input type="radio" name="r2" value="하"/>하
            </td>
            <td colspan="2">
                파워포인트
                <input type="radio" name="r3" value="상"/>&nbsp;상&nbsp;
                <input type="radio" name="r3" value="중"/>&nbsp;중&nbsp;
                <input type="radio" name="r3" value="하"/>&nbsp;하&nbsp;
            </td>
            <td colspan="2">
                워드
                <input type="radio" name="r4" value="상"/>&nbsp;상&nbsp;
                <input type="radio" name="r4" value="중"/>&nbsp;중&nbsp;
                <input type="radio" name="r4" value="하"/>&nbsp;하&nbsp;
            </td>
        </tr>
        <tr>
            <th colspan="2">기타추가내용</th>
            <th>(취업예정자격증)</th>
            <td colspan="4">
                <input type="text" style="width: 350px;" neme="qc_memo"/>
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
                <input type="radio" name="re_check" />Y
                <input type="radio" name="re_check" />N
            </c:if>
            <c:if test="${wvo.wp_re eq 'Y'}">
                <input type="radio" value="Y" checked />Y
                <input type="radio" value="N"/>N
            </c:if>
            <c:if test="${wvo.wp_re eq 'N'}">
                <input type="radio" value="Y" />Y
                <input type="radio" value="N" checked />N
            </c:if>
            </td>
            <th>
                소속기관명(취업성공패키지 등)
            </th>
            <td>
                <input type="text" style="width: 180px;"/>
            </td>
        </tr>
        <tr>
            <th>
                워크넷취업활동 여부(구인구직기간만료확인)
            </th>
            <td colspan="3">
            <c:if test="${wvo.wp_work eq null}">
                <input type="checkbox" name="r7"/>Y
                <input type="checkbox" name="r7"/>N
                (워크넷에서 구직인증기간 만료확인 꼭 해주세요.)
            </c:if>
            <c:if test="${wvo.wp_work eq 'Y'}">
                <input type="checkbox" name="r7" checked/>Y
                <input type="checkbox" name="r7"/>N
                (워크넷에서 구직인증기간 만료확인 꼭 해주세요.)
            </c:if>
            <c:if test="${wvo.wp_work eq 'N'}">
                <input type="checkbox" name="r7" />Y
                <input type="checkbox" name="r7" checked/>N
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
            <td>1.<input type="text" style="width: 180px;"/></td>
            <td>2.<input type="text" style="width: 180px;"/></td>
            <td>3.<input type="text" style="width: 180px;"/></td>
        </tr>
        <tr>
            <th>기타특이사항</th>
            <td colspan="3"><input type="text" style="width: 600px;"/></td>
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
                <input type="text" style="width: 80px;"/>
            </td>            
            <td>
                2.<br/>
                <input type="text" style="width: 80px;"/>
            </td>            
            <td>
                3.<br/>
                <input type="text" style="width: 80px;"/>
            </td>            
            <th>취업희망분야</th>
            <td><input type="text" style="width: 150px;"/></td>            
        </tr>
        <tr>
            <th>희망급여수준</th>
            <td colspan="4"><input type="text" style="width: 400px;"/></td>
            <td><input type="checkbox"/>회사내규</td>
        </tr>
        <tr>
            <th>가능 고용형태</th>
            <td colspan="5">
            <c:if test="${wvo.wp_form eq null}">
                <input type="checkbox"/>정규직
                <input type="checkbox"/>계약직
                <input type="checkbox"/>인턴직
                <input type="checkbox"/>아르바이트
            </c:if>
            <c:if test="${wvo.wp_form eq '정규직'}">
                <input type="checkbox" checked/>정규직
                <input type="checkbox"/>계약직
                <input type="checkbox"/>인턴직
                <input type="checkbox"/>아르바이트
            </c:if>
            <c:if test="${wvo.wp_form eq '계약직'}">
                <input type="checkbox"/>정규직
                <input type="checkbox" checked/>계약직
                <input type="checkbox"/>인턴직
                <input type="checkbox"/>아르바이트
            </c:if>
            <c:if test="${wvo.wp_form eq '인턴직'}">
                <input type="checkbox"/>정규직
                <input type="checkbox"/>계약직
                <input type="checkbox" checked/>인턴직
                <input type="checkbox"/>아르바이트
            </c:if>
            <c:if test="${wvo.wp_form eq '아르바이트'}">
                <input type="checkbox"/>정규직
                <input type="checkbox"/>계약직
                <input type="checkbox"/>인턴직
                <input type="checkbox" checked/>아르바이트
            </c:if>
            </td>
        </tr>
        <tr>
            <th>가능 근무형태</th>
            <td colspan="3">
            <c:if test="${wvo.wp_week eq 'null'}">
                <input type="checkbox"/>주 5일
                <input type="checkbox"/>주 6일
                <input type="checkbox"/>격주휴무
            </c:if>
            <c:if test="${wvo.wp_week eq '주 5일'}">
                <input type="checkbox" checked/>주 5일
                <input type="checkbox"/>주 6일
                <input type="checkbox"/>격주휴무
            </c:if>
            <c:if test="${wvo.wp_week eq '주 6일'}">
                <input type="checkbox"/>주 5일
                <input type="checkbox" checked/>주 6일
                <input type="checkbox"/>격주휴무
            </c:if>
            <c:if test="${wvo.wp_week eq '격주휴무'}">
                <input type="checkbox"/>주 5일
                <input type="checkbox"/>주 6일
                <input type="checkbox" checked/>격주휴무
            </c:if>
            </td>
            <th>가능 근무시간</th>
            <td>
            <c:if test="${wvo.wp_time eq 'null'}">
                <input type="checkbox"/>주간
                <input type="checkbox"/>야간
                <input type="checkbox"/>심야
            </c:if>
            <c:if test="${wvo.wp_time eq '주간'}">
                <input type="checkbox" checked/>주간
                <input type="checkbox"/>야간
                <input type="checkbox"/>심야
            </c:if>
            <c:if test="${wvo.wp_time eq '야간'}">
                <input type="checkbox"/>주간
                <input type="checkbox" checked/>야간
                <input type="checkbox"/>심야
            </c:if>
            <c:if test="${wvo.wp_time eq '심야'}">
                <input type="checkbox"/>주간
                <input type="checkbox"/>야간
                <input type="checkbox" checked/>심야
            </c:if>
            </td>
        </tr>
        <tr>
            <th>훈련생 요청사항</th>
            <td colspan="5">
                <input type="text" style="width: 600px;"/>
            </td>
        </tr>
    </table>
    <table class="after" id="makeTime">
        <tr>
            <th colspan="6">※취업 관리 사항</th>
        </tr>
        <tr>
            <th>업체명</th>
            <td><input type="text" style="width: 100px;"/></td>
            <th>사업자등록번호</th>
            <td><input type="text" style="width: 100px;"/></td>
            <th>취업확인서</th>
            <td>
                <input type="radio" name="r8"/>Y
                <input type="radio" name="r8"/>N
            </td>
        </tr>
        <tr>
            <th>주소</th>
            <td colspan="3"><input type="text" style="width: 400px;"/></td>
            <th>연락처</th>
            <td>
                <input type="text" style="width: 150px;"/>
            </td>
        </tr>
        <tr>
            <th>근무직종</th>
            <td><input type="text" style="width: 150px;"/></td>
            <th>고용보험유무</th>
            <td>
                <input type="radio" name="r9"/>Y
                <input type="radio" name="r9"/>N
            </td>
            <th>취업일</th>
            <td><input type="text" style="width: 150px;"/></td>
        </tr>
        <tr>
            <th>사업자 등록증첨부</th>
            <td colspan="5"><input type="file"/></td>
        </tr>
    </table>
    <div>
        <input type="button" value="수정"/>
        <input type="button" value="인쇄"/>
        <input type="button" value="취소"/>
    </div>