<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <h2>사후관리카드</h2>
    <!-- colgroup으로 비율 맞춰놔서 width만 100%맞추면 돼요-->
    <table class="after">
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
            <td></td>
            <th>전화번호</th>
            <td></td>
            <th>집전화번호</th>
            <td></td>
        </tr>
        <tr>
            <th>성명</th>
            <td></td>
            <th>생년월일</th>
            <td></td>
            <th>주소(상세)</th>
            <td></td>
        </tr>
        <tr>
            <th>훈련과정명</th>
            <td></td>
            <th>교육기간</th>
            <td></td>
            <th>수료일</th>
            <td></td>
        </tr>
        <tr>
            <th>최종학력<br/>(학교명)</th>
            <td></td>
            <th>전공</th>
            <td></td>
            <th>제적일</th>
            <td></td>
        </tr>
    </table>
    <table class="after">
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
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
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
            <td>1.</td>
            <td colspan="2">2.</td>
            <td colspan="2">3.</td>
        </tr>
        <tr>
            <th>외국어능력</th>
            <td>
                영어 
                <input type="radio" name="r1"/>상
                <input type="radio" name="r1"/>중
                <input type="radio" name="r1"/>하
            </td>
            <td colspan="4">
                기타외국어(<input type="text" style="width: 100px;"/>)
                <input type="radio" name="r2"/>&nbsp;상&nbsp;
                <input type="radio" name="r2"/>&nbsp;중&nbsp;
                <input type="radio" name="r2"/>&nbsp;하&nbsp;
            </td>
        </tr>
        <tr>
            <th>컴퓨터능력</th>
            <td>
                엑셀
                <input type="radio" name="r3"/>상
                <input type="radio" name="r3"/>중
                <input type="radio" name="r3"/>하
            </td>
            <td colspan="2">
                파워포인트
                <input type="radio" name="r4"/>&nbsp;상&nbsp;
                <input type="radio" name="r4"/>&nbsp;중&nbsp;
                <input type="radio" name="r4"/>&nbsp;하&nbsp;
            </td>
            <td colspan="2">
                워드
                <input type="radio" name="r5"/>&nbsp;상&nbsp;
                <input type="radio" name="r5"/>&nbsp;중&nbsp;
                <input type="radio" name="r5"/>&nbsp;하&nbsp;
            </td>
        </tr>
        <tr>
            <th colspan="2">기타추가내용</th>
            <th>(취업예정자격증)</th>
            <td colspan="4">
                <input type="text" style="width: 350px;"/>
            </td>
        </tr>
    </table>
    <table class="after">
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
                <input type="radio" name="r6"/>Y
                <input type="radio" name="r6"/>N
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
                <input type="checkbox" name="r7"/>Y
                <input type="checkbox" name="r7"/>N
                (워크넷에서 구직인증기간 만료확인 꼭 해주세요.)
            </td>
        </tr>
    </table>
    <table class="after">
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
    <table class="after">
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
            <th>가능 근무형태</th>
            <td colspan="5">
                <input type="checkbox"/>정규직
                <input type="checkbox"/>계약직
                <input type="checkbox"/>인턴직
                <input type="checkbox"/>아르바이트
            </td>
        </tr>
        <tr>
            <th>가능 근무형태</th>
            <td colspan="3">
                <input type="checkbox"/>주 5일
                <input type="checkbox"/>주 6일
                <input type="checkbox"/>격주휴무
            </td>
            <th>가능 근무시간</th>
            <td>
                <input type="checkbox"/>주간
                <input type="checkbox"/>야간
                <input type="checkbox"/>심야
            </td>
        </tr>
        <tr>
            <th>훈련생 요청사항</th>
            <td colspan="5">
                <input type="text" style="width: 600px;"/>
            </td>
        </tr>
    </table>
    <table class="after">
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