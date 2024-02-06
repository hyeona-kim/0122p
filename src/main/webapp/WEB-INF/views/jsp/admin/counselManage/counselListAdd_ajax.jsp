<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

	<h2 id="add_h2">상담등록</h2>

	
	<div>
	<form action="counselListAdd" method="post">
		<table id="tt_add2" class="add_l table">
			<colgroup>
				<col width="50%"/>
				<col width="50%"/>
				
			</colgroup>

			<thead id="t2head">
                <input type="hidden" name="c_idx" value="${cvo.c_idx}"/>
                <input type="hidden" name="sf_idx" value="${cvo.svo.sf_idx}"/>
                <input type="hidden" name="tr_idx" value="${tvo.tr_idx}"/>
                <input type="hidden" name="ss_num" value="${tvo.ss_num+1}"/>
                <tr>
                    <th bgcolor="lightgray">상담일</th>
                    <td><input type="date" id="so_day" name="so_day" /></td>
					<th bgcolor="lightgray">상담자</th>
                    <td><input type="text" id="so_tname" name="so_tname" /></td>
                </tr>
                <tr>
					<th bgcolor="lightgray">상담종류</th>
                    <td>
                    <select id="so_menu" name="so_menu">
                        <option>일반상담</option> 
                        <option>입학상담</option> 
                        <option>정기상담</option> 
                        <option>고충상담</option> 
                        <option>집중상담</option> 
                        <option>심화상담</option> 
                        <option>수료상담</option> 
                        <option>수료후상담</option> 
                        <option>취업상담</option> 
                    </select>
                    </td>
 					<th bgcolor="lightgray">총상담횟수</th>
        			<td>${tvo.ss_num+1}</td>       
                </tr>
                <tr>
                    <th bgcolor="lightgray">상담목적</th>
                    <td colspan="3"><textarea type="text" id="so_pp" name="so_pp" cols="90" rows="10"></textarea></td>

                </tr>
				<tr>
                    <th bgcolor="lightgray">상담내용</th>
                    <td colspan="3"><textarea type="text" id="so_subject" name="so_subject" cols="90" rows="10"></textarea></td>
                </tr>
                <tr>
                    <th bgcolor="lightgray">지도관리 및 피드백</th>
                    <td colspan="3"><textarea type="text" id="so_pd" name="so_pd" cols="90" rows="10"></textarea></td>
                </tr>
                <input type="hidden" name="total"/>
                    <tr>
						<td colspan="4" align="center">
							<button type="button" onclick="total_add(this.form)">등록</button>
							<button type="button" id="close">취소</button>
						</td>
					</tr>
			</tbody>
		</table>
	</form>
	</div>
	
