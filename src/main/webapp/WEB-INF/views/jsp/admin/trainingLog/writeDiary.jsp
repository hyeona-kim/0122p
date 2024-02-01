<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<div id="staffList_top" style="font-weight: bold;">&nbsp;&nbsp;"${cvo.c_name}"과정 훈련일지</div> 
<div>
    <div style="color: red;">
        *출석현황은 직접 기입하지 않고,결석자,조퇴자를 체크하면 자동기입됩니다.
    </div>
    <div align="right">
        <button class="btn red">훈련날짜</button>
        <input type="date"/>
        <button class="btn blue">시간표내용가져오기</button>
    </div>
</div>
<table class="t1">
    <tr>
        <th>재적</th>
        <td><input type="text" style="width: 50px;" value="${fn:length(cvo.tr_ar3)}"/></td>
        <th>출석</th>
        <td><input type="text" style="width: 50px;" value="${fn:length(cvo.tr_ar3)}"/></td>
        <th>결석</th>
        <td><input type="text" style="width: 50px;"/></td>
        <th>지각</th>
        <td><input type="text" style="width: 50px;"/></td>
        <th>조퇴</th>
        <td><input type="text" style="width: 50px;"/></td>
    </tr>
</table>
<table class="t1">
    <tr>
        <th colspan="4">훈련사항</th>
    </tr>
    <tr>
        <th>교시</th>
        <th>출석</th>
        <th>담당교사</th>
        <th>훈련내용</th>
    </tr>
    <tr>
        <td><input type="text" style="width: 100px;" value="1"/></td>
        <td><input type="text" style="width: 250px;"/></td>
        <td><input type="text" style="width: 100px;"/></td>
        <td><input type="text" style="width: 250px;"/></td>
    </tr>
    <tr>
        <td><input type="text" style="width: 100px;" value="2"/></td>
        <td><input type="text" style="width: 250px;"/></td>
        <td><input type="text" style="width: 100px;"/></td>
        <td><input type="text" style="width: 250px;"/></td>
    </tr>
    <tr>
        <td><input type="text" style="width: 100px;" value="3"/></td>
        <td><input type="text" style="width: 250px;"/></td>
        <td><input type="text" style="width: 100px;"/></td>
        <td><input type="text" style="width: 250px;"/></td>
    </tr>
    <tr>
        <td><input type="text" style="width: 100px;" value="4"/></td>
        <td><input type="text" style="width: 250px;"/></td>
        <td><input type="text" style="width: 100px;"/></td>
        <td><input type="text" style="width: 250px;"/></td>
    </tr>
    <tfoot>
        <tr>
            <td colspan="4">
                <button class="btn blue">+ 훈련사항추가</button>
            </td>
        </tr>
    </tfoot>
</table>
<table class="t1">
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
        <td><input type="text" style="width: 120px;"/></td>
        <th>실습</th>
        <td><input type="text" style="width: 120px;"/></td>
    </tr>
    <tr>
        <th>지시사항</th>
        <td colspan="4">
            <textarea cols="100" rows="10">

            </textarea>
        </td>
    </tr>
    <tr>
        <th rowspan="4">특이사항</th>
        <th>결석자</th>
        <td colspan="3">
            <ul class="tr_ul">
                <c:forEach var="trvo" items="${cvo.tr_ar3}" varStatus="vs">
                <li class="tr_li">
                    <input type ="radio" name="chk${trvo.tr_idx}"/>${trvo.tr_name}
                </li>
                </c:forEach>
            </ul>
        </td>
    </tr>
    <tr>
        <th>지각자</th>
        <td colspan="3">
            <ul class="tr_ul">
                <c:forEach var="trvo" items="${cvo.tr_ar3}">
                <li class="tr_li">
                    <input type ="radio" name="chk${trvo.tr_idx}"/>${trvo.tr_name}
                </li>
                </c:forEach>
            </ul>
        </td>
    </tr>
    <tr>
        <th>조퇴자</th>
        <td colspan="3">
            <ul class="tr_ul">
                <c:forEach var="trvo" items="${cvo.tr_ar3}">
                <li class="tr_li">
                    <input type ="radio" name="chk${trvo.tr_idx}"/>${trvo.tr_name}
                </li>
                </c:forEach>
            </ul>
        </td>
    </tr>
    <tr>
        <th>기타사항</th>
        <td colspan="3">
            <textarea  cols="80" rows="10">

            </textarea>
        </td>
    </tr>
</table>
<div align="center" style="margin-top: 20px;">
    <button class="btn blue">저장</button>
    <button class="btn gray" id="cc_cancle">목록</button>
</div>