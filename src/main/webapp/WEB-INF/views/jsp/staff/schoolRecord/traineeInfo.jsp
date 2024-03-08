
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<form action="s_traineeEdit" method="post" encType="multipart/form-data" name="fff">
    <div class="main_color main_item bold">｜훈련생정보수정</div>	
    <table id="makeTime" class="table">
    <caption>확인서류등록 리스트</caption>
        <colgroup>
            <col width="10%"/>
            <col width="40%"/>
            <col width="10%"/>
            <col width="40%"/>
        </colgroup>
                <tbody>
                    <tr>
                        <th><label>학생코드</label></th>
                        <td colspan="3"></td>
                    </tr>
                    <tr>
                        <th>이름</th>
                        <td><input type="text" class="text" value="${vo9.tr_name}" name="tr_name"></td>
                        <th>주민번호</th>
                        <td>
                            <input type="text" class="text" value="${fn:substring(vo9.tr_rrn,0,6)}" name="tr_rrn" style="width: 40%;">-
                            <input type="text" class="text" value="${fn:substring(vo9.tr_rrn,7,14)}" name="tr_rrn" style="width: 40%;">
                        </td>
                    </tr>
                    <tr>
                        <th><label>휴대폰번호</label></th>
                        <td>
                            <input type="text" class="text"  value="${fn:substring(vo9.tr_hp,0,3)}" name="tr_hp" style="width: 20%;">-
                            <input type="text" class="text"  value="${fn:substring(vo9.tr_hp,4,8)}" name="tr_hp" style="width: 20%;">-
                            <input type="text" class="text" value="${fn:substring(vo9.tr_hp,9,13)}" name="tr_hp" style="width: 20%;">
                        </td>
                        <th><label>과정명</label></th>
                        <td>${vo2.c_name}</td>
                    </tr>
                    <tr>
                        <th><label>집전화</label></th>
                        <td>
                            <input type="text" class="text" value="${fn:substring(vo9.tr_phone,0,2)}" name="tr_phone" style="width: 20%;">-
                            <input type="text" class="text" value="${fn:substring(vo9.tr_phone,3,6)}" name="tr_phone" style="width: 20%;">-
                            <input type="text" class="text" value="${fn:substring(vo9.tr_phone,7,11)}" name="tr_phone" style="width: 20%;">						
                        </td>
                        <th><label>HRD등록일</label></th>
                        <td><input type="text" class="text"></td>
                    </tr>
                    <tr>
                        <th><label>현재상태</label></th>
                        <td>
                            <input type="hidden" id="nowstatus" value="${vo9.tr_nowstatus}"/>
                            <select name="tr_nowstatus" class="select" >
                                <option id="op1" value="0" >접수</option>
                                <option id="op2" value="1" >예정</option>
                                <option id="op3" value="2" >수강</option>
                                <option id="op4" value="3" >조기수료</option>
                                <option id="op5" value="4" >조기취업</option>
                                <option id="op6" value="5" >수료</option>
                                <option id="op7" value="6" >수강포기</option>
                                <option id="op8" value="7" >미수료</option>
                                <option id="op9" value="8" >제적</option>
                                <option id="op10" value="9" >취소</option>
                            </select>
                        </td>
                        <th><label>수료일</label></th>
                        <td><input type="text" class="text" value="${vo2.end_date}"></td>
                    <tr>
                        <th><label>수강포기<br/>(제적,취소)일</label></th>
                        <td><input type="date" class="text" name="tr_cancel_date" value="${vo9.tr_cancel_date}" id="cancel_date"></td>
                        <th><label>수강포기<br/>(제적,취소)사유</label></th>
                        <td><input type="text" class="text" name="tr_cancel_text" value="${vo9.tr_cancel_text}"></td>
                    </tr>
                    
                    <tr>
                        <th><label>사진(210*210)</label></th>
                        <td>
                            <div style="border:1px solid #ababab; width: 180px; height: 200px; margin:3px auto;">
                                <c:if test="${vo9.file_name ne null}">
                                    <img src="${pageContext.request.contextPath }/upload_file/${vo9.file_name}" alt="" style="display: inline-block; width: 180px; height: 200px;" />
                                </c:if>
                            </div>
                            <input type="file" onchange="readURL(this);" name="file" class="text"> 
                        </td>
                        <th><label>환불금액</label></th>
                        <td><input type="text" class="text"><div id="box">(* ,없이 숫자로만 입력해주세요)</div></td>
                    <tr>
                        <th><label>이직전직장명</label></th>
                        <td><input type="text" class="text"></td>
                        <th><label>담당직무</label></th>
                        <td><input type="text" class="text"></td>
                    </tr>
                    
                        <tr>
                        <th><label>전체교육비</label></th>
                        <td>
                            <input type="text" class="text" value="${vo2.course_fee}"/><div id="box">(*,없이 숫자로만 입력해주세요)</div>
                        </td>
                        <th><label>카드유형</label></th>
                        <td>
                            <select id="tr_card" name="tr_card" class="select">
                                <c:if test="${vo9.tr_card eq null}" >
                                    <option value="취성패1" >취성패1</option>
                                    <option value="취성패2">취성패2</option>
                                    <option value="내일배움">내일배움</option>
                                </c:if>
                                <c:if test="${vo9.tr_card eq '취성패1'}" >
                                    <option value="취성패1" selected>취성패1</option>
                                    <option value="취성패2">취성패2</option>
                                    <option value="내일배움">내일배움</option>
                                </c:if>
                                <c:if test="${vo9.tr_card eq '취성패2'}" >
                                    <option value="취성패1" >취성패1</option>
                                    <option value="취성패2" selected>취성패2</option>
                                    <option value="내일배움">내일배움</option>
                                </c:if>
                                <c:if test="${vo9.tr_card eq '내일배움'}" >
                                    <option value="취성패1" >취성패1</option>
                                    <option value="취성패2">취성패2</option>
                                    <option value="내일배움" selected>내일배움</option>
                                </c:if>
                            </select>
                        </td>
                    <tr>
                        <th><label>지원경로${chk3}</label></th>
                        <td colspan="3">
                            
                            <c:if test="${t_path1 eq 1}">
                                <input type="checkbox" name="t_path" value="인터넷" checked>인터넷
                            </c:if>
                            
                            <c:if test="${t_path1 ne 1}">
                                <input type="checkbox" name="t_path" value="인터넷" >인터넷
                            </c:if>

                            <c:if test="${t_path2 eq 2}">
                                <input type="checkbox" name="t_path" value="전단지" checked>전단지
                            </c:if>
                            <c:if test="${t_path2 ne 2}">
                                <input type="checkbox" name="t_path" value="전단지" >전단지
                            </c:if>

                            <c:if test="${t_path3 eq 3}">
                                <input type="checkbox" name="t_path" value="현수막" checked>현수막
                            </c:if>
                            <c:if test="${t_path3 ne 3}">
                                <input type="checkbox" name="t_path" value="현수막" >현수막
                            </c:if>

                            <c:if test="${t_path4 eq 4}">
                                <input type="checkbox" name="t_path" value="생활정보지" checked>생활정보지
                            </c:if>
                            <c:if test="${t_path4 ne 4}">
                                <input type="checkbox" name="t_path" value="생활정보지" >생활정보지
                            </c:if>

                            <c:if test="${t_path5 eq 5}">
                                <input type="checkbox" name="t_path" value="고용지원센터" checked>고용지원센터
                            </c:if>
                            <c:if test="${t_path5 ne 5}">
                                <input type="checkbox" name="t_path" value="고용지원센터" >고용지원센터
                            </c:if>

                            <c:if test="${t_path6 eq 6}">
                                <input type="checkbox" name="t_path" value="직접내방" checked>직접내방
                            </c:if>
                            <c:if test="${t_path6 ne 6}">
                                <input type="checkbox" name="t_path" value="직접내방" >직접내방
                            </c:if>

                            <c:if test="${t_path7 eq 7}">
                                <input type="checkbox" name="t_path" value="지인소개" checked>지인소개
                            </c:if>
                            <c:if test="${t_path7 ne 7}">
                                <input type="checkbox" name="t_path" value="지인소개">지인소개
                            </c:if>

                            <c:if test="${t_path8 eq 8}">
                                <input type="checkbox" name="t_path" value="HRD" checked>HRD
                            </c:if>
                            <c:if test="${t_path8 ne 8}">
                                <input type="checkbox" name="t_path" value="HRD">HRD
                            </c:if>

                            <c:if test="${t_path9 eq 9}">
                                <input type="checkbox" name="t_path" value="기타"checked>기타
                            </c:if>
                            <c:if test="${t_path9 ne 9}">
                                <input type="checkbox" name="t_path" value="기타">기타
                            </c:if>
                        </td>
                    </tr>
                    
                    <tr>
                        <th><label>주소</label></th>
                        <td colspan="3" style="text-align: left;">
                            <input type="text" value="원래주소 : ${vo9.tr_addr}" style="width: 98%; margin: auto;" disabled/>
                            <input type="text" class="text" name="tr_pos_code" id="sample6_postcode" placeholder="우편번호" style="width: 10%; margin-bottom: 5px; margin-left: 10px;">
                            <input type="button" onclick="checkPost()" value="우편번호 찾기" class="btn"><br>
                            <input type="text" class="text" name="tr_addr" id="sample6_address" placeholder="주소" style="width: 20%; margin-bottom: 5px;margin-left: 10px;"><br>
                            <input type="text" class="text" name="tr_addr" id="sample6_detailAddress" placeholder="상세주소" style="width: 10%; margin-bottom: 5px;margin-left: 10px;">
                            <input type="text" class="text" name="tr_addr" id="sample6_extraAddress" placeholder="참고항목" style="width: 10%; margin-bottom: 5px;">
                        </td>
                    <tr>
                        <th><label>상담내용</label></th>
                        <td colspan="3">
                            <table class="table ">
                                <tbody>
                                    <tr>
                                        <td>상담일</td>
                                        <td>상담자</td>
                                        <td>상담내용</td>
                                    </tr>
                                    <tr>
                                        <td colspan="3">상담내용이 없습니다.</td>
                                    </tr>
                                </tbody>
                            </table>
                        </td>
                    </tr>
                </tbody>
                <tfoot>
                    <tr>
                        <td colspan="4" class="main_color">
                            <label>* 교육시간, 교시, 요일은 시간표 만들때 사용됩니다. 시간표를 만들려면 꼭 입력해주세요</label><br/>
                            <label>* 총 교육일수는 훈련일지에서 사용됩니다.</label>
                        </td>
                    </tr>
                </tfoot>
                    
</table>
<div class="main_item align_center">
    <button type="button" onclick="sendData(this.form)" class="btn">등록</button>
    <button type="button" id="list_btn" class="btn">취소</button>
    <input type="hidden" name="tr_idx" value="${vo9.tr_idx}">
    <input type="hidden" name="c_idx" value="${c_idx}">
    <input type="hidden" id="start_date" value="${vo2.start_date}">
</div>
</form>