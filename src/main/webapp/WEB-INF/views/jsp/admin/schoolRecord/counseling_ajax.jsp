<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<table id="makeTime">
    <caption>상담등록</caption>
            <tr>
                <th>상담일</th>
                <td></td>
                <th>상담자</th>
                <td></td>
            </tr>
            <tr>
                <th>상담종류</th>
                <td>
                    <select>
                        <option>1</option>
                    </select>
                </td>
                <th>총상담횟수</th>
                <td></td>
            </tr>
            <tr>
                <th>상담내용</th>
                <td colspan="3">
                    <textarea rows="8" cols="50"></textarea>
                </td>
            </tr>
            <tr>
                <th>지도관리 및 피드백</th>
                <td><textarea rows="8" cols="50"></textarea></td>
            </tr>
</table>           
        <input type="button" value="등록" onclick="">
        <input type="button" value="취소" onclick="">