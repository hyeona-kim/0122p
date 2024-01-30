<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<table>
    <!--  이름0,주민번호0,전화번호0,전화,과정0,결재일0,지원경로,개강일0,HRD등록일0,현재상태0,제적일,제적사유0,수료일0,전체교육비,카드유형0,우편번호,주소,메모,이전직장명,학생코드,과정타입(1~18) -->
    <thead>
        <tr>
            <c:if test="${b_ar[0] eq true}">
                <td>이름</td>
            </c:if>
            <c:if test="${b_ar[1] eq true}">
                <td>주민번호</td>
            </c:if>
            <c:if test="${b_ar[2] eq true}">
                <td>핸드폰번호</td>
            </c:if>
            <c:if test="${b_ar[3] eq true}">
                <td>전화번호</td>
            </c:if>
            <c:if test="${b_ar[4] eq true}">
                <td>과정</td>
            </c:if>
            <c:if test="${b_ar[5] eq true}">
                <td>결재일</td>
            </c:if>
            <c:if test="${b_ar[6] eq true}">
                <td>지원경로</td>
            </c:if>
            <c:if test="${b_ar[7] eq true}">
                <td>개강일</td>
            </c:if>
            <c:if test="${b_ar[8] eq true}">
                <td>HRD등록일</td>
            </c:if>
            <c:if test="${b_ar[9] eq true}">
                <td>현재상태</td>
            </c:if>
            <c:if test="${b_ar[10] eq true}">
                <td>제적일</td>
            </c:if>
            <c:if test="${b_ar[11] eq true}">
                <td>제적사유</td>
            </c:if>
            <c:if test="${b_ar[12] eq true}">
                <td>수료일</td>
            </c:if>
            <c:if test="${b_ar[13] eq true}">
                <td>전체교육비</td>
            </c:if>
            <c:if test="${b_ar[14] eq true}">
                <td>카드유형</td>
            </c:if>
            <c:if test="${b_ar[15] eq true}">
                <td>우편번호</td>
            </c:if>
            <c:if test="${b_ar[16] eq true}">
                <td>주소</td>
            </c:if>
            <c:if test="${b_ar[17] eq true}">
                <td>메모</td>
            </c:if>
            <c:if test="${b_ar[18] eq true}">
                <td>이전직장명</td>
            </c:if>
            <c:if test="${b_ar[19] eq true}">
                <td>학생코드</td>
            </c:if>
        <c:if test="${b_ar[20] eq true}">
            <td>과정타입</td>
        </c:if>
    </tr>
</thead>
<tfoot>
            <tr>
                <td colspan="${cols}">
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
<tbody>
    <c:forEach var="tvo" items="${t_ar}">
    <tr>
        <c:if test="${b_ar[0] eq true}">
            <td>${tvo.tr_name}</td>
        </c:if>
        <c:if test="${b_ar[1] eq true}">
            <td>${tvo.tr_rrn}</td>
        </c:if>
        <c:if test="${b_ar[2] eq true}">
            <td>${tvo.tr_phone}</td>
        </c:if>
        <c:if test="${b_ar[3] eq true}">
            <td>${tvo.tr_hp}</td>
        </c:if>
        <c:if test="${b_ar[4] eq true}">
            <td>${tvo.cvo.c_name}</td>
        </c:if>
        <c:if test="${b_ar[5] eq true}">
            <td>결재일칼럼 추가</td>
        </c:if>
        <c:if test="${b_ar[6] eq true}">
            <td>${tvo.t_path}</td>
        </c:if>
        <c:if test="${b_ar[7] eq true}">
            <td>${tvo.cvo.start_date}</td>
        </c:if>
        <c:if test="${b_ar[8] eq true}">
            <td>${tvo.tr_hrd}</td>
        </c:if>
        <c:if test="${b_ar[9] eq true}">
            <td>${tvo.tr_nowstatus}</td>
        </c:if>
        <c:if test="${b_ar[10] eq true}">
            <td>${tvo.tr_cancel_date}</td>
        </c:if>
        <c:if test="${  b_ar[11] eq true}">
            <td>${tvo.tr_cancel_text}</td>
        </c:if>
        <c:if test="${b_ar[12] eq true}">
            <td>${tvo.cvo.end_date}</td>
        </c:if>
        <c:if test="${b_ar[13] eq true}">
            <td>${tvo.cvo.course_fee}</td>
        </c:if>
        <c:if test="${b_ar[14] eq true}">
            <td>${tvo.tr_card}</td>
        </c:if>
        <c:if test="${b_ar[15] eq true}">
            <td>${tvo.tr_pos_code}</td>
        </c:if>
        <c:if test="${b_ar[16] eq true}">
            <td>${tvo.tr_addr}</td>
        </c:if>
        <c:if test="${b_ar[17] eq true}">
            <td>학생별 메모</td>
        </c:if>
        <c:if test="${b_ar[18] eq true}">
            <td>${tvo.tr_bc}</td>
        </c:if>
        <c:if test="${b_ar[19] eq true}">
            <td>${tvo.s_code}</td>
        </c:if>
        <c:if test="${b_ar[20] eq true}">
            <td>${tvo.cvo.ctvo.ct_name}</td>
        </c:if>
    </tr>
    </c:forEach>
</tbody>
</table>