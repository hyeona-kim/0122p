<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<form action="s_addDiary" method="post" >

    <div id="staffList_top" class="title">"${cvo.c_name}"과정 훈련일지</div> 
    <input type="hidden" name="c_idx" value="${cvo.c_idx}"/>
    <div>
        <div class="main_item align_right">
            <button type="button" class="btn">훈련날짜</button>
            <input type="date" class="text" style="width: 20%;" name="write_date" value="${tdvo.write_date}" id="v_write_date" disabled/>
        </div>
    </div>
    <table class="table viewTable" >
        <colgroup>
            <col width="5%"/>
            <col width="15%"/>
            <col width="5%"/>
            <col width="15%"/>
            <col width="5%"/>
            <col width="15%"/>
            <col width="5%"/>
            <col width="15%"/>
            <col width="5%"/>
            <col width="15%"/>
        </colgroup>
        <tr>
            <th>재적</th>
            <td><input type="text" value="${fn:length(cvo.tr_ar3)}" class="text"  disabled/></td>
            <th>출석</th>
            <td><input type="text" id="attend" value="${fn:length(cvo.tr_ar3)}" class="text" disabled/></td>
            <th>결석</th>
            <td><input type="text" id="absence" class="text" value="${tdvo.attend_check}" name="attend_check" disabled/></td>
            <th>지각</th>
            <td><input type="text" id="tardy" class="text" value="${tdvo.tardy_check}" name="tardy_check" disabled/></td>
            <th>조퇴</th>
            <td><input type="text" id="earlyLeave" class="text" value="${tdvo.earlyLeave_check}" name="earlyLeave_check" disabled/></td>
        </tr>
    </table>
    <table class="table viewTable" id="diaryTable">
        <colgroup>
            <col width="15%"/>
            <col width="35%"/>
            <col width="15%"/>
            <col width="35%"/>
        </colgroup>
        <thead>
            <tr>
                <th colspan="4">훈련사항</th>
            </tr>
            <tr>
                <th>교시</th>
                <th>훈련과목</th>
                <th>담당교사</th>
                <th>훈련내용</th>
            </tr>
        </thead>
        
        <tbody id="innerText">
            <tr>
                <td><input type="text" value="1" class="text"/></td>
                <td><input type="text" class="text" /></td>
                <td><input type="text" class="text"/></td>
                <td><input type="text" class="text"/></td>
            </tr>
            <tr>
                <td><input type="text" value="2" class="text"/></td>
                <td><input type="text" class="text"/></td>
                <td><input type="text" class="text"/></td>
                <td><input type="text" class="text"/></td>
            </tr>
            <tr>
                <td><input type="text" value="3" class="text"/></td>
                <td><input type="text" class="text"/></td>
                <td><input type="text" class="text"/></td>
                <td><input type="text" class="text"/></td>
            </tr>
            <tr>
                <td><input type="text" value="4" class="text"/></td>
                <td><input type="text" class="text"/></td>
                <td><input type="text" class="text"/></td>
                <td><input type="text" class="text"/></td>
            </tr>
        </tbody>
    </table>
    <table class="table viewTable">
        <colgroup>
            <col width="20%"/>
            <col width="20%"/>
            <col width="20%"/>
            <col width="20%"/>
            <col width="20%"/>
        </colgroup>
        <tr>
            <th>훈련기간</th>
            <th>이론</th>
            <td><input type="text" class="text" value="0"/></td>
            <th>실습</th>
            <td><input type="text" class="text" value="0"/></td>
        </tr>
        <tr>
            <th>지시사항</th>
            <td colspan="4">
                <textarea cols="100" rows="10" class="textarea" name="td_instruction" >${tdvo.td_instruction}</textarea>
            </td>
        </tr>
        <tr>
            <th rowspan="4">특이사항</th>
            <th>결석자</th>
            <input type="hidden" id="chk1" value="${tdvo.td_attend}" />
            <input type="hidden" id="chk2" value="${tdvo.td_tardy}"/>
            <input type="hidden" id="chk3" value="${tdvo.td_earlyLeave}"/>
            <input type="hidden" id="tr_length" value="${fn:length(cvo.tr_ar3)}"/>
            <td colspan="3">
                <ul class="tr_ul">
                    <c:forEach var="trvo" items="${cvo.tr_ar3}" varStatus="vs">
                        <li class="tr_li">
                            <input type ="checkbox" name="chk1" value="${trvo.tr_idx}" onclick="setCount(1, '${vs.index}')" class="chk1${vs.index}" />${vs.index+1}.  ${trvo.tr_name}
                        </li>
                    </c:forEach>
                </ul>
            </td>
        </tr>
        <tr>
            <th>지각자</th>
            <td colspan="3">
                <ul class="tr_ul">
                    <c:forEach var="trvo" items="${cvo.tr_ar3}" varStatus="vs">
                        <li class="tr_li">
                            <input type ="checkbox" name="chk2" value="${trvo.tr_idx}" onclick="setCount(2, '${vs.index}')" class="chk2${vs.index}"/>${vs.index+1}.  ${trvo.tr_name}
                        </li>
                    </c:forEach>
                </ul>
            </td>
        </tr>
        <tr>
            <th>조퇴자</th>
            <td colspan="3">
                <ul class="tr_ul">
                    <c:forEach var="trvo" items="${cvo.tr_ar3}" varStatus="vs">
                        <li class="tr_li">
                            <input type ="checkbox" name="chk3" value="${trvo.tr_idx}" onclick="setCount(3, '${vs.index}')" class="chk3${vs.index}"/>${vs.index+1}.  ${trvo.tr_name}
                        </li>
                    </c:forEach>
                </ul>
            </td>
        </tr>
        <tr>
            <th>기타사항</th>
            <td colspan="3">
                <textarea  cols="80" rows="10" class="textarea" name="td_significant" >${tdvo.td_significant}</textarea>
            </td>
        </tr>
    </table>
</form>