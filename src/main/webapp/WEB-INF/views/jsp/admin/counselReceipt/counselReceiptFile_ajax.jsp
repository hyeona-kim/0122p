<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<h2 id="cf_h2">면접평가표</h2>
<form action="counselReceipt_file" method="post" name="file_frm">
<div id="cf_wrap">
    <table id="cf_table">
        <thead>
            <tr>
                <th>훈련과정명</th>
                <th><input type="text"></th>
                <th>훈련기간</th>
                <th><input type="text"></th>
            </tr>
            <tr>
                <th>지원자 성명</th>
                <th><input type="text"></th>
                <th>생년월일</th>
                <th><input type="text"></th>
            </tr>
        </thead>
    </table>
</div>

<div id="cf_wrap">
    <table id="crf_table">
        <colgroup>
            <col width="10%"/>
            <col width="20%"/>
            <col width="30%"/>
            <col width="20%"/>
            <col width="10%"/>
            <col width="10%"/>
        </colgroup>
     <thead>
        <tr>
            <th rowspan="11">평가내역</th>
            <th>평가요소</th>
            <th>평가항목</th>
            <th>평가등급</th>
            <th>득점</th>
            <th>비고</th>
        </tr>
        </thead>
         <tbody>
            <c:forEach var="rvo" items="${ar2 }">

            <tr>
                <td ></td>
                <td>${rvo.ef_name }(${rvo.ef_score})</td>
                <td>${rvo.ef_subject }</td>
                <td>
                    <input type="checkbox">A
                    <input type="checkbox">B
                    <input type="checkbox">C
                    <input type="checkbox">D
                    <input type="checkbox">E
                </td>
                <td></td>
                <td></td>
             </tr>
            </c:forEach>
        </tbody>
        <tfoot>
                <tr>
                    <td></td>
                    <td>종합평가</td>
                    <td>
                        <input type="checkbox">꼭 합격 시켜야한다</br>
                        <input type="checkbox">합격 시켜야한다</br>
                        <input type="checkbox">보통이다</br>
                        <input type="checkbox">합격 시 고려해야한다</br>
                        <input type="checkbox">불합격 시켜야한다
                    </td>
                    <td>
                        [불합격사유] <br>
                        <input type="checkbox">대기자<br>
                        <input type="checkbox">점수 순위 불합격<br>
                        <input type="checkbox">기타<br>
                        <input type="text">
                    </td>
                    <td colspan="2">[평가 점수]</td>
                </tr>
            <tr>
                <td colspan="6">
                    *입학 면접평가표는 지원자에게 배포하지 않습니다 </br>
                    *E 등급이 2개 이상일 경우 탈락처리합니다.
                </td>
            </tr>
            <tfoot>
</table>
</div>

<div id="cf_wrap">
    <table id="cf_table">
        <colgroup>
            <col width="15%"/>
            <col width="35%"/>
            <col width="15%"/>
            <col width="35%"/>
        </colgroup>
        <tbody>
            <tr>
                <td>평가자</td>
                <td> 
                    <select name="" id="">
                        <option value="">평가자선택</option>
                        <option value="">평가자1</option>
                        <option value="">평가자2</option>
                    </select>
                </td>
                <td>평가일</td>
                <td> <input type="text"> </td>
            </tr>
            <tr>
                <td>평가자 의견</td>
                <td colspan="3"> <input type="text"> </td>
            </tr>
        </tbody>
    </table>
</div>