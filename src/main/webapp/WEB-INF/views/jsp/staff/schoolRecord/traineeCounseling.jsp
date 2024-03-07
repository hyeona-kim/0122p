<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
  <div id="print">
				    <table id="makeTime" class="table">
                        <colgroup>
                            <col width="20%"/>
                            <col width="20%"/>
                            <col width="*"/>
                        </colgroup>
				        <caption>신상기록부</caption>
                        <tbody>
                            <c:if test="${vo11.file_name eq null}">
                                <tr>
                                    <td rowspan="5" width="125">NO IMAGE</td>
                                </tr>
                            </c:if>
                   
                            <tr>
                                <td rowspan="5">
                                    <div style="border:1px solid #ababab; width: 180px; height: 200px; margin: auto;">
                                        <c:if test="${vo11.file_name ne null}">
                                            <img src="${pageContext.request.contextPath }/upload_file/${vo11.file_name}" alt="" style="display: inline-block; width: 180px; height: 200px;" />
                                        </c:if>
                                    </div>
                                </td>
                                <!-- <td rowspan="5"><img src="${pageContext.request.contextPath }/upload_file/${vo11.file_name}" width="200" height="200"></td> -->
                            </tr>
                          
                            <tr>
                                <th>성명</th>
                                <td>${vo11.tr_name}</td>
                            </tr>
                            <tr>
                                <th>주민등록번호</th>
                                <td>${vo11.tr_rrn}</td>
                            </tr>
                            <tr>
                                <th>주소</th>
                                <td>${vo11.tr_addr}</td>
                            </tr>
                            <tr>
                                <th>전화번호</th>
                                <td>${vo11.tr_hp}</td>
                            </tr>
                    </tbody>
                </table>
            
            <table id="makeTime" class="table">
                <tbody>
                    <tr>
                        <th>교육과정명</th>
                        <td>${cv.c_name}</td>
                        <th>교육기간</th>
                        <td>${cv.start_date}~${cv.end_date}</td>
                        <th>총상담횟수</th>
                        <c:if test="${vo11.ss_num eq null}">
                           <td>${ss_num}회</td>
                           <input type="hidden" id="ss_num" value="${ss_num}"/>
                        </c:if>
                        <c:if test="${vo11.ss_num ne null}">
                            <td>${vo11.ss_num}</td>
                            <input type="hidden" id="ss_num" value="${vo11.ss_num}"/>
                        </c:if>
                    </tr>
                </tbody>
            </table>
            <table id="makeTime" class="table">
                <thead>
                    <tr>
                        <th>상담일</th>
                        <th>구분</th>
                        <th>상담자</th>
                        <th>상담내용</th>
                        <th>조치사항</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="ccv1" items="${ccvo}">
                    <tr>
                        <td><a onclick="c_detail('${ccv1.so_idx}')">${ccv1.so_day}</a></td>
                        <td>${ccv1.so_menu}</td>
                        <td>${ccv1.so_tname}</td>
                        <td>${ccv1.so_menu}</td>
                        <td>${ccv1.so_pd}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
            <div class="main_item align_center">
                <button type="button" onclick="add_counsel()" class="btn">상담등록</button>           
                <button type="button" onclick="" class="btn">엑셀</button>           
                <button type="button" onclick="printPage()" class="btn">인쇄</button>           
                <button type="button" id="c_canclebtn" class="btn">취소</button>           
            </div>
      