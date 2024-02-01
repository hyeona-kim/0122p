<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<table id="board_table">
    <tbody>
        <%-- ===== 출력할 게시판 항목 ===== --%>
        <tr>
            <th>번호</th>
            <th>제목</th>
            <th>첨부파일</th>
            <th>관리</th>
        </tr>
        <c:if test="${vo ne null}"> <%-- vo는 로그인 정보 --%>
        <%-- ===== 로그인 정보가 있다면 반복문을 통해 자료실 목록 출력 ===== --%>
        <c:if test="${ar ne null}">   
        <c:forEach items="${ar }" varStatus="vs" var="vo">
            <form action="formFileDown" method="post" id="frm">
                <c:set var="num" value="${page.totalRecord - (page.numPerPage*(page.nowPage-1))}"/>
                <tr>
                    <td>${num-vs.index}</td>
                    <td>${vo.fd_subject}</td>                              
                    <td><a href="javascript:formFileDown('${vo.fd_fname}')">
                        ${vo.fd_fname}
                    </a></td>
                    <td>
                        <button type="button" id="form_edit_btn" onclick="editFormDown('${vo.fd_idx}')" class="form_edit_btn form_btn">수정</button>
                        <button type="button" onclick="deleteFormDown('${vo.fd_idx}')" class="form_del_btn form_btn">삭제</button>
                    </td>
                </tr>
            </form>
        </c:forEach>
        </c:if>
        <c:if test="${ar eq null}">
        <tr><td colspan="4">검색 결과가 없습니다</td></tr>
        </c:if>
    </c:if>
    </tbody>
    <%-- 화면 하단 page 번호 출력하는 부분 --%>
    <tfoot>
        <tr>
        <td colspan="4">
            <ol class="page">
                <%-- ========== 이전버튼 만드는 부분 시작 ========== --%>
                <%-- startPage가 5보다 작을 경우
                    이전page로 돌아가는 버튼 비활성화 후 생성 --%>
                <c:if test="${page.startPage < page.pagePerBlock}">
                    <li class="disable">&lt;</li>
                </c:if>   
                <%-- startPage가 5보다 같거나 클 경우
                    이전page로 돌아가는 버튼 활성화 후 생성 --%>
                <c:if test="${page.startPage >= page.pagePerBlock && change_flag eq null}">
                    <li><a href="javascript:paging('${page.startPage-page.pagePerBlock}')">&lt;</a></li>
                </c:if>
                <c:if test="${page.startPage >= page.pagePerBlock && change_flag ne null}">
                    <li><a href="javascript:changeViewNum('${page.startPage-page.pagePerBlock}')">&lt;</a></li>
                </c:if>
                <%-- ========== 이전버튼 만드는 부분 끝 ========== --%>
                
                <%-- ========== page 번호 만드는 부분 시작 ==========--%>
                <c:forEach begin="${page.startPage }" end="${page.endPage }" varStatus="vs">
                    <c:if test="${vs.index eq page.nowPage }">
                    <li class="now">${vs.index }</li>
                    </c:if>
                    <c:if test="${vs.index ne page.nowPage && change_flag eq null}">
                    <li><a href="javascript:paging('${vs.index}')">${vs.index}</a></li>
                    </c:if>
                    <c:if test="${vs.index ne page.nowPage && change_flag ne null}">
                    <li><a href="javascript:changeViewNum('${vs.index}')">${vs.index}</a></li>
                    </c:if>
                </c:forEach>
                <%-- ========== page 번호 만드는 부분 끝 ==========--%>
                
                <%-- ========== 다음버튼 만드는 부분 시작 ========== --%>
                <%-- endPage가 마지막 끝나는 page보다 작을 경우
                    다음page로 가는 버튼 활성화 후 생성 --%>
                <c:if test="${page.endPage < page.totalPage && change_flag eq null}">
                    <li><a href="javascript:paging('${page.startPage + page.pagePerBlock}')">&gt;</a></li>
                </c:if>
                <c:if test="${page.endPage < page.totalPage && change_flag ne null}">
                    <li><a href="javascript:changeViewNum('${page.startPage + page.pagePerBlock}')">&gt;</a></li>
                </c:if>
                <%-- endPage가 마지막 끝나는 page보다 크거나 같을 경우
                    다음page로 가는 버튼 비활성화 후 생성 --%>
                <c:if test="${page.endPage >= page.totalPage }">
                    <li class="disable">&gt;</li>   
                </c:if>
                <%-- ========== 다음버튼 만드는 부분 끝 ========== --%>
            </ol>
        </td>
        </tr>
    </tfoot>
</table>