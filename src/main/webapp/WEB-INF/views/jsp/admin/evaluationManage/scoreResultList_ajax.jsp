<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
			<table id="table" class="table">
				<colgroup>
					<col width="10%"/>
					<col width="40%"/>
					<col width="20%"/>
					<col width="30%"/>
				</colgroup>
			<thead>
				<tr>
					<button style="border: none; background: none; padding: 0;">
						<img src="/image/lefticon.png" alt="왼쪽 화살표" width="50" height="50">
					</button>
					<button style="border: none; background: none; padding: 0;">
						<img src="/image/righticon.png" alt="오른쪽 화살표" width="50" height="50">
					</button>
				</tr>
				<tr>
					<th>평가일시</th>
					<td>${esvo.es_date}</td>
					<th>훈련생</th>
					<td>${tvo.tr_name}</td>
				</tr>
				<tr>
					<th>교과목</th>
					<td>${svo.s_title}</td>
					<th>훈련교사</th>
					<td>${svo.sf_name}</td>
				</tr>
				<tr>
					<th>능력단위명</th>
					<td>${svo.us_name}</td>
					<th>평가시간/총배점</th>
					<td>${esvo.es_time} / ${esvo.es_totalScore}</td>
				</tr>
				<tr>
					<th>평가유형</th>
					<td>${esvo.es_type} </td>
					<th>평가수준</th>
					<td>${esvo.es_level} </td>
				</tr>
				<tr>
					<th>평가점수</th>
					<td></td>
					<th>성취수준</th>
					<td></td>
				</tr>
				<tr>
					<th>성취기준</th>
					<td colspan="3">
						<table>
							<colgroup>
								<col width="40%"/>
								<col width="20%"/>
								<col width="30%"/>
							</colgroup>
							<tr>
								<th >
									수준 5수준 4수준 3수준 2수준 1수준
								</th>
							</tr>
							<tr>
								<td>
									점수구간	90점 이상	80~89점	70~79점	60~69점	60점 미만
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<th>능력단위요소</th>
					<th colspan="3">문항</th>
				</tr>
			</thead >

				<!-- 반복처리  -->
					<tbody>
						<tr>
							<th rowspan="7"><label><input type="text" name="sk_idx" class="text" /></label></th>
						</tr>
						<tr>
							<td colspan="3">
								 <input type="text" name="qt_name" placeholder="번 문항" class="text"/>
							</td>
						</tr>
						<tr>				
							<td colspan="3">
								<textarea cols="80" rows="4" placeholder="문제 내용" class="textarea" name="qt_content"></textarea>
							</td>
						</tr>
						<tr>
							<td id="selectExam" colspan="3">
								<!--문제항목 반복-->
								<input type="text" value="1" class="text" style="width: 10%" name="id" readonly/>
								<input type="text" name="qt_select${i}" value="" class="text" style="width: 70%" placeholder="객관식 문항1"/>
								<!--문제항목 반복-->
							</td>
						</tr>
						<tr>
							<td colspan="3">
								작성답안 : <input type="text" class="text" name="qt_correct"/>
							</td>
						</tr>
						<tr>
							<td colspan="3">
								점수 : <input type="number" class="text" name="qt_score"/>
							</td>
						</tr>
						<input type="hidden" value="0" name="qt_type"/>
					</tbody>
					<!-- 반복처리  -->
					
			</table>
			
			<div>
				<table>
					<tfoot>
						<tr>
							<td colspan="4">
								<input type="button" value="목록" id="" class="btn">
							</td>
						</tr>
					</tfoot>
				</table>
			</div>
		 