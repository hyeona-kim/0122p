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
                        <th>작성자</th>
                        <th>등록일</th>
                        <th>조회수</th>
                     </tr>
                  <c:if test="${vo ne null}"> <%-- vo는 로그인 정보 --%>
                  <%-- ===== 로그인 정보가 있다면 반복문을 통해
                           게시판 목록 출력 ===== --%>
                     <c:if test="${ar ne null}">   
                        <c:forEach items="${ar }" varStatus="vs" var="bvo">
                           <c:set var="num" value="${page.totalRecord - (page.numPerPage*(page.nowPage-1))}"/>
                           <tr>
                              <td>${num-vs.index}</td>
                              <td align="left">
                                 <%-- 전체공지로 클릭되었다면(notice가 1일때)
                                 공지 마크가 추가되어야함 --%>
                                 <c:if test="${bvo.bd_notice eq '1'}">
                                    <span id="notice">공지</span>
                                 </c:if>
                                 <a href="javascript:viewContent('${bvo.bd_idx}')">
                                    ${bvo.bd_subject}
                                 </a>
                              </td>                              
                              <td>${bvo.bd_file}</td>
                              <td>***</td>
                              <td>${bvo.bd_write_date}</td>
                              <td>${bvo.bd_hit}</td>
                           </tr>
                        </c:forEach>
                     </c:if>
                     <c:if test="${ar eq null}">
                        <tr><td colspan="6">검색 결과가 없습니다</td></tr>
                     </c:if>
                  </c:if>
                  </tbody>
                  <%-- 화면 하단 page 번호 출력하는 부분 --%>
                  <tfoot>
                     <tr>
                        <td colspan="6">
                           <ol class="page">
                              <%-- ========== 이전버튼 만드는 부분 시작 ========== --%>
                              <%-- startPage가 5보다 작을 경우
                                  이전page로 돌아가는 버튼 비활성화 후 생성 --%>
                              <c:if test="${requestScope.page.startPage < requestScope.page.pagePerBlock }">
                                 <li class="disable">&lt;</li>
                              </c:if>   
                              <%-- startPage가 5보다 같거나 클 경우
                                  이전page로 돌아가는 버튼 활성화 후 생성 --%>
                              <c:if test="${requestScope.page.startPage >= requestScope.page.pagePerBlock }">
                                 <li><a href="boardList?cPage=${page.startPage-page.pagePerBlock }">&lt;</a></li>
                              </c:if>
                              <%-- ========== 이전버튼 만드는 부분 끝 ========== --%>
                              
                              <%-- ========== page 번호 만드는 부분 시작 ==========--%>
                              <c:forEach begin="${page.startPage }" end="${page.endPage }" varStatus="vs">
                                 <c:if test="${vs.index eq page.nowPage }">
                                    <li class="now">${vs.index }</li>
                                 </c:if>
                                 <c:if test="${vs.index ne page.nowPage && search_flag eq null && notice_flag eq null && viewList_flag eq null}">
                                    <li><a href="javascript:paging('${vs.index}')">${vs.index}</a></li>
                                 </c:if>
                                 <c:if test="${vs.index ne page.nowPage && search_flag ne null && notice_flag eq null && viewList_flag eq null}">
                                    <li><a href="javascript:searchBoard('${vs.index}')">${vs.index}</a></li>
                                 </c:if>
                                 <c:if test="${vs.index ne page.nowPage && search_flag eq null && notice_flag ne null && viewList_flag eq null}">
                                    <li><a href="javascript:checkNotice('${vs.index}')">${vs.index}</a></li>
                                 </c:if>
                                 <c:if test="${vs.index ne page.nowPage && viewList_flag ne null}">
                                    <li><a href="javascript:viewBoardList('${vs.index}', '${page.nowPage}')">${vs.index}</a></li>
                                 </c:if>
                              </c:forEach>
                              <%-- ========== page 번호 만드는 부분 끝 ==========--%>
                              
                              <%-- ========== 다음버튼 만드는 부분 시작 ========== --%>
                              <%-- endPage가 마지막 끝나는 page보다 작을 경우
                                  다음page로 가는 버튼 활성화 후 생성 --%>
                              <c:if test="${page.endPage < page.totalPage }">
                                 <li><a href="boardList?cPage= ${page.startPage + page.pagePerBlock }">&gt;</a></li>
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