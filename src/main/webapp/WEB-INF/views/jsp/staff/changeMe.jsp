<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<form name="me_form">
    <div class="title">개인정보 수정</div>
    <br/>
    <table class="table">
        <tbody>
            <tr>
                <th>이름</th>
                <td><input type="text" name="sf_name" disabled value="${sf_vo.sf_name}"/></td>
                <th>아이디</th>
                <td><input type="text" name="sf_id" value="${sf_vo.sf_id}"/></td>
            </tr>
            <tr>
                <th>전화번호</th>
                <td><input type="text" name="sf_phone" value="${sf_vo.sf_phone}"/></td>
                <th>이메일</th>
                <td><input type="text" name="sf_email" value="${sf_vo.sf_email}"/></td>
            </tr>
        </tbody>
        <tfoot>
            <tr>
                <td colspan="4">
                    <input type="button" class="btn" value="수정" id="meedit_btn"/>
                    <input type="button" class="btn red2" value="취소" id="mec_btn"/>
                </td>
            </tr>
        </tfoot>
    </table>
</form>