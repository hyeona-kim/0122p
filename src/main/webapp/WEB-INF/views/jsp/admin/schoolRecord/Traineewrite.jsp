<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/header.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/center.css" />
<style>

	
	#staffWrap{
		width: 95%;
		margin: auto;
		margin-top: 20px;
	}
	#staffList_top {
		background: black;
		color: white;
		height: 40px;
		line-height: 40px;
	}
	
	#searchTime, #makeTime{
		margin-top:10px;
		border-collapse: collapse;
		width: 100%;
        
	}
	#searchTime td, #searchTime th, #makeTime td, #makeTime th{
        height: 40px;
		padding-left: 10px;
		border: 1px solid #ddd;
        
	}
	#searchTime th, #makeTime th{background-color: #F5F7F9;}
	
	#searchTime caption, #makeTime caption{
		text-indent: -9999px;
		height: 0;
	}
</style>

</head>
<c:if test="${tvo eq null }">
<body>
	<article id="wrap">
		<jsp:include page="../../head.jsp"></jsp:include>
		<div id="center">
			<jsp:include page="./leftList.jsp"></jsp:include>
			<div class="right">
				<div id="staffWrap">
					<div id="staffList_top">신상기록부</div>
				    <table id="makeTime">
				        <caption>신상기록부</caption>
					<tbody>
                       <c:forEach var="vo" items="${vo8 }">
						<tr>
							<th rowspan="5">이미지</th>
                        </tr>
                        <tr>
							<th>성명</th>
							<td> ${vo.tr_name}</td>
							<th>교육과정</th>
							<td></td>
                        </tr>
                        <tr>
                            <th>교육타입</th>
							<td></td>
                            <th>교육기간</th>
							<td></td>
						</tr>
                        <tr>
                            <th>주민등록번호</th>
							<td>${vo.tr_rrn}</td>
                            <th>주소</th>
							<td>${vo.tr_addr}</td>
					    </tr>
                        <tr>
                            <th>본인휴대폰</th>
							<td>${vo.tr_hp}</td>
                            <th>집전화</th>
							<td></td>
                        </tr>
                    </c:forEach>
				</tbody>
			</table>
            <table id="makeTime">
                    <tbody>
                        <tr>
                            <th rowspan="4">사업장</th>
                        </tr>
                        <tr>
                            <th>업체명</th>
							<td><input type="text"></td>
                            <th>직종</th>
							<td><input type="text"></td>
                            <th>대표자</th>
							<td><input type="text"></td>
                        </tr>
                        <tr>
                            <th>근무부서</th>
							<td><input type="text"></td>
                            <th>직위</th>
							<td><input type="text"></td>
                            <th>전화번호</th>
							<td><input type="text"></td>
                        </tr>
                        <tr>
                            <th>소재지</th>
							<td colspan="5"><input type="text"></td>
                        </tr>
                    </tbody>
            </table>
            <table id="makeTime">
                <tbody>
                    <tr>
                        <th colspan="2">훈련신청사유</th>
                        <td colspan="4"><input type="text"></td>
                    </tr>
                </tbody>
            </table>
            <table id="makeTime">
                <thead>
                    <tr>
                        <th rowspan="2">최종학력</th>
                        <th colspan="2">학교명</th>
                        <th colspan="2">졸업년도</th>
                        <th colspan="2">전공</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        
                        <td><input type="text"></td>
                        <td><input type="text"></td>
                        <td><input type="text"></td>
                    </tr>
                </tbody>
            </table>
            <table id="makeTime">
                <thead>
                   <tr>
                        <th colspan="3">면허 및 자격사항</th>
                        <th colspan="4">근 무 경 력</th>
                   </tr>
                </thead>
                <tbody>
                    <tr>
                        <th>자격명</th>
                        <th>취득일</th>
                        <th>발행처</th>
                        <th>회사명</th>
                        <th>근무기간</th>
                        <th>담당업무</th>
                        <th>직급</th>
                    </tr>
                    <tr>
                        <td><input type="text"></td>
                        <td><input type="text"></td>
                        <td><input type="text"></td>
                        <td><input type="text"></td>
                        <td><input type="text"></td>
                        <td><input type="text"></td>
                        <td><input type="text"></td>
                    </tr>
                </tbody>
             </table>
             </div>
            </div>
		</div>
	</div>
</article>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
	<script>
		$(function() {
			//$().removeClass("selected");
			$(".selected").removeClass("selected");
			$(".l_select").removeClass("l_selected");
			$("#thirdmenu").addClass("selected");
			$("#l_second").addClass("l_select");
		});
		
		function paging(str) {
			location.href="traincurrent?cPage="+str
		}
	</script>
</body>
</c:if>
<c:if test="${tvo ne null}">
	<c:redirect url="index">
	</c:redirect>
</c:if>
</html>