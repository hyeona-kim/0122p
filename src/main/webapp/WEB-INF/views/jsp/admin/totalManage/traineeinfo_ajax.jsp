<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
   <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


<form action="traineeEdit2" method="post" encType="multipart/form-data" name="fff">
    <h2 class="title">훈련생정보수정</h2>
        <table class="table">
            <caption>확인서류등록 리스트</caption>
                <tbody>
                    <tr>
                        <th><label>학생코드</label></th>
                        <td colspan="3"></td>
                    </tr>
                    <tr>
                        <th>이름</th>
                        <td><input type="text" value="${vo9.tr_name}" name="tr_name" class="text"></td>
                        <th>주민번호</th>
                        <td>
                            <input type="text" value="${fn:substring(vo9.tr_rrn,0,6)}" name="tr_rrn" class="text" style="width: 40%;">-
                            <input type="text" value="${fn:substring(vo9.tr_rrn,7,14)}" name="tr_rrn" class="text" style="width: 40%;">
                        </td>
                    </tr>
                    <tr>
                        <th><label>휴대폰번호</label></th>
                        <td>
                            <input type="text"  value="${fn:substring(vo9.tr_hp,0,3)}" name="tr_hp" class="text" style="width: 20%;">-
                            <input type="text"  value="${fn:substring(vo9.tr_hp,4,8)}" name="tr_hp" class="text" style="width: 20%;">-
                            <input type="text" 	value="${fn:substring(vo9.tr_hp,9,13)}" name="tr_hp" class="text" style="width: 20%;">
                        </td>
                        <th><label>과정명</label></th>
                        <td>${vo2.c_name}</td>
                    </tr>
                    <tr>
                        <th><label>집전화</label></th>
                        <td>
                            <input type="text" 	value="${fn:substring(vo9.tr_phone,0,2)}" name="tr_phone" class="text" style="width: 20%;">-
                            <input type="text" value="${fn:substring(vo9.tr_phone,3,6)}" name="tr_phone" class="text" style="width: 20%;">-
                            <input type="text" 	value="${fn:substring(vo9.tr_phone,7,11)}" name="tr_phone" class="text" style="width: 20%;">						
                        </td>
                        <th><label>HRD등록일</label></th>
                        <td><input type="text" class="text"></td>
                    </tr>
                    <tr>
                        <th><label>현재상태</label></th>
                        <td>
                            <select name="tr_nowstatus" class="select">
                                <c:if test="${vo9.tr_nowstatus eq 0}">
                                    <option id="op1" value="0" selected >접수</option>
                                    <option id="op2" value="1" >예정</option>
                                    <option id="op3" value="2" >수강</option>
                                    <option id="op4" value="3" >조기수료</option>
                                    <option id="op5" value="4" >조기취업</option>
                                    <option id="op6" value="5" >수료</option>
                                    <option id="op7" value="6" >수강포기</option>
                                    <option id="op8" value="7" >미수료</option>
                                    <option id="op9" value="8" >제적</option>
                                    <option id="op10" value="9" >취소</option>
                                </c:if>
                                <c:if test="${vo9.tr_nowstatus eq 1}">
                                    <option id="op1" value="0" >접수</option>
                                    <option id="op2" value="1" selected>예정</option>
                                    <option id="op3" value="2" >수강</option>
                                    <option id="op4" value="3" >조기수료</option>
                                    <option id="op5" value="4" >조기취업</option>
                                    <option id="op6" value="5" >수료</option>
                                    <option id="op7" value="6" >수강포기</option>
                                    <option id="op8" value="7" >미수료</option>
                                    <option id="op9" value="8" >제적</option>
                                    <option id="op10" value="9" >취소</option>
                                </c:if>
                                <c:if test="${vo9.tr_nowstatus eq 2}">
                                    <option id="op1" value="0" >접수</option>
                                    <option id="op2" value="1" >예정</option>
                                    <option id="op3" value="2" selected>수강</option>
                                    <option id="op4" value="3" >조기수료</option>
                                    <option id="op5" value="4" >조기취업</option>
                                    <option id="op6" value="5" >수료</option>
                                    <option id="op7" value="6" >수강포기</option>
                                    <option id="op8" value="7" >미수료</option>
                                    <option id="op9" value="8" >제적</option>
                                    <option id="op10" value="9" >취소</option>
                                </c:if>
                                <c:if test="${vo9.tr_nowstatus eq 3}">
                                    <option id="op1" value="0" >접수</option>
                                    <option id="op2" value="1" >예정</option>
                                    <option id="op3" value="2" >수강</option>
                                    <option id="op4" value="3" selected>조기수료</option>
                                    <option id="op5" value="4" >조기취업</option>
                                    <option id="op6" value="5" >수료</option>
                                    <option id="op7" value="6" >수강포기</option>
                                    <option id="op8" value="7" >미수료</option>
                                    <option id="op9" value="8" >제적</option>
                                    <option id="op10" value="9" >취소</option>
                                </c:if>
                                <c:if test="${vo9.tr_nowstatus eq 4}">
                                    <option id="op1" value="0" >접수</option>
                                    <option id="op2" value="1" >예정</option>
                                    <option id="op3" value="2" >수강</option>
                                    <option id="op4" value="3" >조기수료</option>
                                    <option id="op5" value="4" selected >조기취업</option>
                                    <option id="op6" value="5" >수료</option>
                                    <option id="op7" value="6" >수강포기</option>
                                    <option id="op8" value="7" >미수료</option>
                                    <option id="op9" value="8" >제적</option>
                                    <option id="op10" value="9" >취소</option>
                                </c:if>
                                <c:if test="${vo9.tr_nowstatus eq 5}">
                                    <option id="op1" value="0" >접수</option>
                                    <option id="op2" value="1" >예정</option>
                                    <option id="op3" value="2" >수강</option>
                                    <option id="op4" value="3" >조기수료</option>
                                    <option id="op5" value="4" >조기취업</option>
                                    <option id="op6" value="5" selected >수료</option>
                                    <option id="op7" value="6" >수강포기</option>
                                    <option id="op8" value="7" >미수료</option>
                                    <option id="op9" value="8" >제적</option>
                                    <option id="op10" value="9" >취소</option>
                                </c:if>
                                <c:if test="${vo9.tr_nowstatus eq 6}">
                                    <option id="op1" value="0" >접수</option>
                                    <option id="op2" value="1" >예정</option>
                                    <option id="op3" value="2" >수강</option>
                                    <option id="op4" value="3" >조기수료</option>
                                    <option id="op5" value="4" >조기취업</option>
                                    <option id="op6" value="5" >수료</option>
                                    <option id="op7" value="6" selected>수강포기</option>
                                    <option id="op8" value="7" >미수료</option>
                                    <option id="op9" value="8" >제적</option>
                                    <option id="op10" value="9" >취소</option>
                                </c:if>
                                <c:if test="${vo9.tr_nowstatus eq 7}">
                                    <option id="op1" value="0" >접수</option>
                                    <option id="op2" value="1" >예정</option>
                                    <option id="op3" value="2" >수강</option>
                                    <option id="op4" value="3" >조기수료</option>
                                    <option id="op5" value="4" >조기취업</option>
                                    <option id="op6" value="5" >수료</option>
                                    <option id="op7" value="6" >수강포기</option>
                                    <option id="op8" value="7" selected>미수료</option>
                                    <option id="op9" value="8" >제적</option>
                                    <option id="op10" value="9" >취소</option>
                                </c:if>
                                <c:if test="${vo9.tr_nowstatus eq 8}">
                                    <option id="op1" value="0" >접수</option>
                                    <option id="op2" value="1" >예정</option>
                                    <option id="op3" value="2" >수강</option>
                                    <option id="op4" value="3" >조기수료</option>
                                    <option id="op5" value="4" >조기취업</option>
                                    <option id="op6" value="5" >수료</option>
                                    <option id="op7" value="6" >수강포기</option>
                                    <option id="op8" value="7" >미수료</option>
                                    <option id="op9" value="8" selected>제적</option>
                                    <option id="op10" value="9" >취소</option>
                                </c:if>
                                <c:if test="${vo9.tr_nowstatus eq 9}">
                                    <option id="op1" value="0" >접수</option>
                                    <option id="op2" value="1" >예정</option>
                                    <option id="op3" value="2" >수강</option>
                                    <option id="op4" value="3" >조기수료</option>
                                    <option id="op5" value="4" >조기취업</option>
                                    <option id="op6" value="5" >수료</option>
                                    <option id="op7" value="6" >수강포기</option>
                                    <option id="op8" value="7" >미수료</option>
                                    <option id="op9" value="8" >제적</option>
                                    <option id="op10" value="9" selected >취소</option>
                                </c:if>
                            </select>
                        </td>
                        <th><label>수료일</label></th>
                        <td><input type="text" value="${vo2.end_date}" class="text"></td>
                    <tr>
                        <th><label>수강포기(제적,취소)일</label></th>
                        <td><input type="text" name="tr_cancel_date" vaule="${vo9.tr_cancel_date}" class="text"></td>
                        <th><label>수강포기(제적,취소)사유</label></th>
                        <td><input type="text" name="tr_cancel_text" value="${vo9.tr_cancel_text}" class="text"></td>
                    </tr>
                    
                    <tr>
                        <th><label>사진(210*210)</label></th>
                        <td>
                            <input type="file" onchange="readURL(this)" name="file" class="text"> 
                            <img id="preview" width="210" height="210" />
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
                            <input type="text" class="text" /><div id="box">(*,없이 숫자로만 입력해주세요)</div>
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
                        <th><label>지원경로</label></th>
                        <td colspan="3">
                            <input type="checkbox" name="t_path" value="인터넷">인터넷
                            <input type="checkbox" name="t_path" value="전단지">전단지
                            <input type="checkbox" name="t_path" value="현수막">현수막
                            <input type="checkbox" name="t_path" value="생활정보지">생활정보지
                            <input type="checkbox" name="t_path" value="고용지원센터">고용지원센터
                            <input type="checkbox" name="t_path" value="직접내방">직접내방
                            <input type="checkbox" name="t_path" value="지인소개">지인소개
                            <input type="checkbox" name="t_path" value="HRD">HRD
                            <input type="checkbox" name="t_path" value="기타">기타
                        </td>
                    </tr>
                    
                    <tr>
                        <th><label>주소</label></th>
                        <td colspan="3" style="text-align: left;"><input type="text" id="postcode" name="zipcode" size="5" readonly class="text" style="width: 10%; margin-bottom: 5px;"/>
                            <input type="button" value="우편번호검색" onclick="checkPost()" class="btn"><br>
                            <input type="text" id="address" name="addr1" size="50" placeholder="주소" readonly class="text" style="width: 20%; margin-bottom: 5px;"><br>
                            <input type="text" id="detailAddress" name="addr2" size="50" placeholder="상세주소" class="text" style="width: 20%; margin-bottom: 5px;"></td>
                        </td>
                    </tr>
                    <tr>
                        <th><label>상담내용</label></th>
                        <td colspan="3">
                            <table class="table">
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
                        <td colspan="4" align="left">
                            <label>* 교육시간, 교시, 요일은 시간표 만들때 사용됩니다. 시간표를 만들려면 꼭 입력해주세요</label><br/>
                            <label>* 총 교육일수는 훈련일지에서 사용됩니다.</label>
                        </td>
                    </tr>
                </tfoot>
                    
</table>
<div class="main_item align_center">
    <button type="button" onclick="sendData(this.form)" class="btn">등록</button>
    <button type="button" id="cc_cancle" class="btn">목록</button>
    <input type="hidden" name="tr_idx" value="${vo9.tr_idx}">
    <input type="hidden" name="c_idx" value="${c_idx}">
</div>
</form>