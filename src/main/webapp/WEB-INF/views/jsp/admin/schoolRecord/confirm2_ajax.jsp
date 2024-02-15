<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <form action="confirm" method="post" name="cf">
            <table id="makeTime">
                <caption>훈련생확인서류현황</caption>
                <thead>
                    <tr>
                        <th rowspan="2">번호</th>
                        <th rowspan="2">이미지</th>
                        <th rowspan="2">이름</th>
                        <th rowspan="2">연락처</th>
                        <th rowspan="2">주민번호</th>
                        <th rowspan="2">상태</th>
                        <th colspan="2">서명</th>
                        <th rowspan="2">확인서류</th>
                    </tr>
                    <tr>
                        <!-- 확인서류 반복문 -->
                        <td></td>
                        <td></td>
                    </tr>    
                </thead>
                <tbody>
                    <!-- 교육별 훈련생 목록 반복문 -->
                    <tr>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td colspan="2"></td>
                        <td></td>
                    </tr>
                </tbody>
                <input type="hidden" name="cPage" value="${param.cPage}" />
                <input type="hidden" name="c_idx" value="${param.c_idx}" />
                <input type="hidden" name="tn_idx" value="${tn_idx}" />
                </tbody>
            </table>
        </form>