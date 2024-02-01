<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
  <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
 

<form action="counseling_ajax" method="post" name="ddd">
<table id="makeTime">
    <caption>상담등록</caption>
            <tr>
                <th>상담일</th>
                <td><input type="date" name="so_day"></td>
                <th>상담자</th>
                <td><input type="text" name="so_tname"></td>
            </tr>
            <tr>
                <th>상담종류</th>
                <td>
                    <select id="so_menu" name="so_menu">
                        <option id="oo1" value="일반상담">일반상담</option>
                        <option id="oo2" value="입학상담">입학상담</option>
                        <option id="oo3" value="정기상담">정기상담</option>
                        <option id="oo4" value="고충상담">고충상담</option>
                        <option id="oo5" value="집중상담">집중상담</option>
                        <option id="oo6" value="심화상담">심화상담</option>
                        <option id="oo7" value="수료상담">수료상담</option>
                        <option id="oo8" value="수료후상담">수료후상담</option>
                        <option id="oo9" value="취업상담">취업상담</option>
                    </select>
                </td>
                <th>총상담횟수</th>
                <td>${ss_num}회</td>
            </tr>
            <tr>
                <th>상담목적</th>
                <td colspan="3">
                    <textarea rows="8" cols="100" name="so_pp"></textarea>
                </td>
            </tr>
            <tr>
                <th>상담내용</th>
                <td colspan="3">
                    <textarea rows="8" cols="100" name="so_subject"></textarea>
                </td>
            </tr>
            <tr>
                <th>지도관리 및 피드백</th>
                <td colspan="3">
                    <textarea rows="8" cols="100" name="so_pd"></textarea>
                </td>
            </tr>
</table> 
<div> 
    <input type="button" value="등록" onclick="sendDate(this.form)">
    <input type="button" value="취소" onclick="">
    <input type="hidden" name="c_idx" value="${c_idx}">
    <input type="hidden" name="tr_idx" value="${tr_idx}">
    <input type="hidden" name="sf_idx" value="${vvo.sf_idx}">
    <input type="hidden" name="ss_num" value="${ss_num+1}">
    
</div>  
</form>       
