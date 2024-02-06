<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

	<div>
	<form action="editCounsel" method="post">
		<table id="tt_add2" class="table">
			<colgroup>
				<col width="25%"/>
				<col width="25%"/>
				<col width="25%"/>
				<col width="25%"/>
			</colgroup>

			<thead id="t2head">
				
				<tr>
					<input type="hidden" name="listSelect" value="${param.listSelect}"/>
					<input type="hidden" name="so_idx" value="${vo.so_idx}"/>
					<input type="hidden" name="c_idx" value="${vo.c_idx}"/>
                    <th bgcolor="lightgray">상담일</th>
                    <td><input type="text" id="so_day" name="so_day" value="${vo.so_day}"/></td>
					<th bgcolor="lightgray">상담자</th>
                    <td><input type="text" id="so_tname" name="so_tname" value="${vo.so_tname}"/></td>
                </tr>
                <tr>
					<th bgcolor="lightgray">상담종류</th>
                    <td><select id="so_menu" name="so_menu">
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
        			<td>${ss_num}</td>
                </tr>
				<tr>
                    <th bgcolor="lightgray">상담내용</th>
                    <td colspan="3"><textarea type="text" id="so_subject" name="so_subject" cols="90" rows="10">${vo.so_subject}</textarea></td>
                </tr>
                <tr>
                    <th bgcolor="lightgray">지도관리 및 피드백</th>
                    <td colspan="3"><textarea type="text" id="so_pd" name="so_pd" cols="90" rows="10">${vo.so_pd}</textarea></td>
				</tr>
			</thead>
			<tfoot>
				<tr>
					<td colspan="8" align="center">
						<input type="button"  onclick="update(this.form)"  value="수정"/>
						<input type="button"  onclick="del('${vo.so_idx}','${vo.c_idx}')" value="삭제"/>
						<input type="hidden"  name="total" value=""/>
						<input type="button" id="close" value="목록"/>
					</td>
				</tr>
			</tfoot>
		</table>
	</form>
	</div>
	
