<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
    <h2 id="e_h2" class="title">&nbsp;&nbsp;&nbsp;"${cvo.c_name}" 시간표 보기</h2>
    <div class="main_item align_left main_color">
        ■ 훈련과정명 : ${cvo.c_name}<br/>
        ■ 훈련기간 : <span id="startDate"></span> ~ <span id="endDate"></span> <br/>
        ■ 훈련시간 : 0930 ~ 1820 (120일/960시간)<br/>
        ■ 훈련장소 :  ${cvo.rvo.r_name}<br/>
        ■ 훈련비용 : ${cvo.course_fee}원<br/>
        ■ 훈련교사 :  ${cvo.sf_idx}
    </div>
<c:if test="${cvo.c_timeExel ne null}">
    <div style="text-align: center;" class="main_item" id="page">
   
    </div>
    <div class="main_item" id="weekCount">
        훈련시간표 (2월 5주차)
        <select class="select" onchange="select()">
            <option>2월5주차</option>
        </select>
    </div>
    <table class="time_table">
        <colgroup>
            <col width="*"/>
            <col width="13.5%"/>
            <col width="13.5%"/>
            <col width="13.5%"/>
            <col width="13.5%"/>
            <col width="13.5%"/>
            <col width="13.5%"/>
            <col width="13.5%"/>

        </colgroup>
        <tr>
            <th rowspan="2">교시</th>
            <th>Sun</th>
            <th>Mon</th>
            <th>Tue</th>
            <th>Wed</th>
            <th>Thu</th>
            <th>Fri</th>
            <th>Sat</th>
           
        </tr>
        <tr>
            <c:forEach var="i" begin="0" end="6">
                <th class="day${i}"></th>
            </c:forEach>
        </tr>
        <c:forEach  var="k" begin="1" end="8">
            <tr>
                <td class="class"><a>${k}교시</a></td>
                <c:forEach var="i" begin="0" end="6">
                    <td class="class${k}${i}"></td>
                </c:forEach>
            </tr>
        </c:forEach>
    </table>
</c:if>
<c:if test="${cvo.c_timeExel eq null}">
    <div class="main_item" style="color: red; ">※시간표 정보가 존재하지 않습니다 등록해주세요※</div>
    <form action="addExelfile" method="post" enctype="multipart/form-data">
        <input type="hidden" name="listSelect" value="3"/>
        <input type="hidden" name="c_idx" value="${cvo.c_idx}"/>
        <table id="e_table" class="table">
            <colgroup>
                <col width="20%"/>
                <col width="80%"/>
            </colgroup>
            <tr>
                <th>첨부파일</th>
                <td><input type="file" name="c_file" class="text"/></td>
            </tr>
        </table>
        <div id="btns" class="main_item align_center">
            <button type="submit" class="btn">저장</button>
            <button type="button" id="cc_cancle" class="btn">취소</button>
        </div>
    </form>
</c:if>