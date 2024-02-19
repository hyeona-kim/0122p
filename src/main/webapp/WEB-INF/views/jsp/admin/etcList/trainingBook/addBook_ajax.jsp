<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<h2 class="title">훈련교재 등록</h2>
<form action="addTrainingBook" method="post">
	<table class="table">
		<colgroup>
			<col width="15%">
			<col width="35%">
			<col width="15%">
			<col width="35%">
		</colgroup>
		<caption>훈련교재 등록 테이블</caption>
		<tbody>
			<tr>
				<th>구분</th>
				<td>
                    <label for="tb_type">시중교재</label><input type="radio" id="tb_type" name="tb_type" value="0"/>
                    <label for="tb_type">자체교재</label><input type="radio" id="tb_type" name="tb_type" value="1"/>
                </td>
				<th>교재명</th>
				<td><input class="text" type="text" data-str="직급" name="tb_title"/></td>
			</tr>
			<tr>
				<th>저자</th>
				<td><input class="text" type="text" name="tb_writer"/></td>
				<th>출판사</th>
				<td><input class="text" type="text" name="tb_publisher"/></td>
			</tr>
			<tr>
				<th>발행년도</th>
				<td>
                    <input class="text" type="text" name="tb_pub_date"/><br/>
                    (입력 예.2023-12-01)
                </td>
				<th>교재가격</th>
				<td>
                    <input class="text" type="text" name="tb_price"/><br/>
                    <span class="font_red">(*숫자로만 입력해주세요)</span>
                </td>
			</tr>
			<tr>
				<th>지급방법</th>
				<td colspan="3" id="provide_type">
					<select class="select" name="tb_provide_type">
                        <option value="0">무상</option>
                        <option value="1">유상</option>
                    </select>
				</td>
			</tr>
			<tr>
				<th rowspan="3">
                    교재이미지<br/>
                    (앞,뒤,목차)
                </th>
				<td colspan="3" id="img1">
					<input type="file" name="fr_img_fname"/>
				</td>
			</tr>
            <tr><td colspan="3" id="img2"><input type="file" name="bk_img_fname"/></td></tr>
            <tr><td colspan="3" id="img3"><input type="file" name="li_img_fname"/></td></tr>
            <tr>
                <th>비고</th>
                <td colspan="3"><textarea class="textarea" id="comments" name="tb_comments"></textarea></td>
            </tr>
		</tbody>
	</table>
	<div class="main_item align_center">
		<button onclick="javascript:addTrainingBook()" class="btn blue">등록</button>
		<button id="cc_btn" class="btn red">취소</button>
	</div>
</form>