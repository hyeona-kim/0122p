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
                    <th >상담일</th>
                    <td><input type="date" id="so_day" name="so_day" value="${vo.so_day}"/></td>
					<th >상담자</th>
                    <td><input type="text" id="so_tname" name="so_tname" value="${vo.so_tname}"/></td>
                </tr>
                <tr>
					<th >상담종류</th>
                    <td>
						<input type="hidden" id="so_menu_value" value="${vo.so_menu}"/>
						<select id="so_menu" name="so_menu">
							<option class="opmenu">일반상담</option> 
							<option class="opmenu">입학상담</option> 
							<option class="opmenu">정기상담</option> 
							<option class="opmenu">고충상담</option> 
							<option class="opmenu">집중상담</option> 
							<option class="opmenu">심화상담</option> 
							<option class="opmenu">수료상담</option> 
							<option class="opmenu">수료후상담</option> 
							<option class="opmenu">취업상담</option> 
						</select>
					</td>
 					<th >총상담횟수</th>
        			<td>${ss_num}</td>
                </tr>
				<tr>
                    <th >상담내용</th>
                    <td colspan="3"><textarea type="text" id="so_subject" name="so_subject" cols="90" rows="10">${vo.so_subject}</textarea></td>
                </tr>
                <tr>
                    <th >지도관리 및 피드백</th>
                    <td colspan="3"><textarea type="text" id="so_pd" name="so_pd" cols="90" rows="10">${vo.so_pd}</textarea></td>
				</tr>
			</thead>
			<tfoot>
				<tr>
					<td colspan="8" align="center">
						<input type="button"  onclick="update_counsel(this.form)"  value="수정" class="btn"/>
						<input type="button"  onclick="del_counsel('${vo.so_idx}','${vo.c_idx}')" value="삭제" class="btn red"/>
						<input type="hidden"  name="total" value=""/>
						<input type="button" id="close" value="목록" class="btn"/>
					</td>
				</tr>
			</tfoot>
		</table>
	</form>
	</div>
	
