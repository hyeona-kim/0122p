<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<div id="staffList_top" class="title">"${cvo.c_name}"과정 훈련일지</div> 
<div>
    <div style="color: red; font-size: 12px;" class="main_item">
        *출석현황은 직접 기입하지 않고,결석자,조퇴자를 체크하면 자동기입됩니다.
    </div>
    <div class="main_item align_right">
        <button class="btn red2">훈련날짜</button>
        <input type="date" class="text" style="width: 20%;"/>
        <button class="btn">시간표내용가져오기</button>
    </div>
</div>
<table class="table">
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
        <td><input type="text"  value="${fn:length(cvo.tr_ar3)}" class="text"/></td>
        <th>출석</th>
        <td><input type="text" value="${fn:length(cvo.tr_ar3)}" class="text"/></td>
        <th>결석</th>
        <td><input type="text" class="text"/></td>
        <th>지각</th>
        <td><input type="text" class="text"/></td>
        <th>조퇴</th>
        <td><input type="text" class="text"/></td>
    </tr>
</table>
<table class="table">
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
        <td><input type="text" value="1" class="text"/></td>
        <td><input type="text" class="text"/></td>
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
    <tfoot>
        <tr>
            <td colspan="4">
                <button class="btn">+ 훈련사항추가</button>
            </td>
        </tr>
    </tfoot>
</table>
<table class="table">
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
        <td><input type="text" class="text"/></td>
        <th>실습</th>
        <td><input type="text" class="text"/></td>
    </tr>
    <tr>
        <th>지시사항</th>
        <td colspan="4">
            <textarea cols="100" rows="10" class="textarea">

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
            <textarea  cols="80" rows="10" class="textarea">

            </textarea>
        </td>
    </tr>
</table>
<div class="main_item align_center">
    <button class="btn">저장</button>
    <button class="btn" id="cc_cancle">목록</button>
</div>