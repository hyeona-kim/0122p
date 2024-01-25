<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

	<header id="h1">상담관리보고서등록</header>
	<div id="add_top">
		<table id="tt_add1" class="t1">
			<thead>
				<tr>
					<td >교육과정명</td>
					<td>${cvo.c_name}</td>
					<td>교육기간</td>
					<td>${cvo.start_date}+"~"+${cvo.end_date}</td>
				</tr>
			</thead>
		</table>
	</div>
	
	<div>
	<form action="counselAdd" method="post">
		<table id="tt_add2" class="t1">
			<thead id="t2head">
				<tr>
                    <td>회의일자</td>
                    <td><input type="text" id="ss_mday" name="ss_mday"/></td>
					<td>상담사</td>
                    <td><input type="text" id="sf_idx1" name="sf_idx1"/></td>
                </tr>
                <tr>
                    <td>훈련시간</td>
                    <td><input type="text" id="ss_time" name="ss_time"/></td>
					<td>훈련교사</td>
                    <td><input type="text" id="sf_idx2" name="sf_idx2"/></td>
                </tr>
				<tr>
                    <td>회의장소</td>
                    <td><input type="text" id="ss_pa" name="ss_pa"/></td>
                    <td>총회의회수</td>
                    <td><input type="text" id="ss_cnt" name="ss_cnt"/></td>
                </tr>
                <tr>
                    <td>상담회차</td>
					<td><input type="text" id="ss_num" name="ss_num"/></td>
                    <td>상담기간</td>
					<td><input type="text" id="ss_day" name="ss_day"/></td>
                </tr>
				<tr>
                	<td>회의참석자</td>
					<td colspan ='3'><input type="text" id="ss_member" name="ss_member"/></td>
					
				</tr>
				<tr>
					<td>상담목적</td>
					<td colspan ='3'><input type="text" id="so_pp" name="so_pp"/></td>
				</tr>
					<tr><td>상담대상자</td>
						<td colspan ='3'><input type="text" id="tr_idx" name="tr_idx"/></td>
				</tr>
				<tr>
				<td>상담내용전달사항</td>
				<td ><input type="text" id="ss_msg" name="ss_msg"/></td>
				</tr>
				<tr>
					<td>회의내용</td>
					<td colspan ='3'><input type="text" id="ss_msubject" name="ss_msubject"/></td>
				</tr>
				<tr>
					<td>회의사진</td>
					<td colspan ='3'><input type="text" id="ss_bd" name="ss_bd"/></td>
				</tr>
					
			</thead>
			<tbody>
					<tr>
						<td>
							<button type="submit">등록</button>
							<button type="button" id="cc_cancle">취소</button>
						</td>
					</tr>
			</tbody>
		</table>
	</form>
	</div>
