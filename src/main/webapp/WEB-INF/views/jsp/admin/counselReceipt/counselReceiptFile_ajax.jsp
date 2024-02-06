<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<h2 id="cf_h2" class="title">면접평가표</h2>
<form action="counselReceipt_file" method="post" name="file_frm">
<div id="cf_wrap">
    <table id="cf_table" class="table">
        <thead>
            <tr>
                <th>훈련과정명</th>
                <td><input type="text" class="text"></td>
                <th>훈련기간</th>
                <td><input type="text" class="text"></td>
            </tr>
            <tr>
                <th>지원자 성명</th>
                <td><input type="text" class="text"></td>
                <th>생년월일</th>
                <td><input type="text" class="text"></td>
            </tr>
        </thead>
    </table>
</div>

<div id="cf_wrap">
    <table id="crf_table" class="table">
        <colgroup>
            <col width="10%"/>
            <col width="15%"/>
            <col width="30%"/>
            <col width="25%"/>
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
                <td></td>
                <td>${rvo.ef_name }(${rvo.ef_score})</td>
                <td>${rvo.ef_subject }</td>
                <td>
                    <input type="checkbox" class="checkbox">A
                    <input type="checkbox" class="checkbox">B
                    <input type="checkbox" class="checkbox">C
                    <input type="checkbox" class="checkbox">D
                    <input type="checkbox" class="checkbox">E
                </td>
                <td></td>
                <td></td>
             </tr>
            </c:forEach>
            <tr>
                <td></td>
                <td>종합평가</td>
                <td id="align_left">
                    <input type="checkbox" class="checkbox">꼭 합격 시켜야한다</br>
                    <input type="checkbox" class="checkbox">합격 시켜야한다</br>
                    <input type="checkbox" class="checkbox">보통이다</br>
                    <input type="checkbox" class="checkbox">합격 시 고려해야한다</br>
                    <input type="checkbox" class="checkbox">불합격 시켜야한다
                </td>
                <td>
                    [불합격사유] <br>
                    <input type="checkbox" class="checkbox">대기자<br>
                    <input type="checkbox" class="checkbox">점수 순위 불합격<br>
                    <input type="checkbox" class="checkbox">기타<br>
                    <input type="text" class="text">
                </td>
                <td colspan="2">[평가 점수]</td>
            </tr>
        </tbody>
        <tfoot>
            <tr>
                <td colspan="6" style="color: red;">
                    *입학 면접평가표는 지원자에게 배포하지 않습니다 </br>
                    *E 등급이 2개 이상일 경우 탈락처리합니다.
                </td>
            </tr>
        </tfoot>
    </table>
</div>

<div id="cf_wrap">
    <table id="cf_table" class="table">
        <colgroup>
            <col width="15%"/>
            <col width="35%"/>
            <col width="15%"/>
            <col width="35%"/>
        </colgroup>
        <tbody>
            <tr>
                <th>평가자</th>
                <td> 
                    <select name="" id="">
                        <option value="">평가자선택</option>
                        <option value="">평가자1</option>
                        <option value="">평가자2</option>
                    </select>
                </td>
                <th>평가일</th>
                <td> <input type="text" class="text"> </td>
            </tr>
            <tr>
                <th>평가자 의견</th>
                <td colspan="3"> <input type="text" class="text"></td>
            </tr>
        </tbody>
    </table>
</div>