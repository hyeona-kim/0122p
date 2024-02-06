<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<h2 id="table_h2">상담파일등록</h2>
	<form action="addCounselFile" method="post" enctype="multipart/form-data">
			<table id="table" class="table">
			<thead>
				<tr>
					<td colspan="1" class="color">
						첨부파일(엑셀파일)
					</td>
                    <td colspan="3">
                        <input type="file" name="addFile" value="파일 선택"/>
                    </td>
				</tr>
			</thead>
				
			<tfoot>
					
				<tr>
					<td colspan="2" align="right" id="add">
						<input type="submit" value="저장">
					</td>
					<td colspan="2" align="left">
						<input type="button" value="취소" id="cc_cancle">
					</td>
				</tr>
			</tfoot>	
		</table>
	</form>
		