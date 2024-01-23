<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0, viewport-fit=cover">
	<!-- 클래식 에디터 -->
	<script src="https://cdn.ckeditor.com/ckeditor5/29.1.0/classic/ckeditor.js"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/jsp/css/header.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/jsp/css/center.css" />
<style>
table tfoot ol.page {
	    list-style:none;
	    width: 300px;
	    margin: auto;
	}
	
	table tfoot ol.page li {
	    float:left;
	    margin-right:8px;
	}
	
	table tfoot ol.page li a {
	    display:block;
	    padding:3px 7px;
	    color:gray;
	    font-weight:bold;
	    text-decoration: none;
	}
	
	table tfoot ol.page li a:hover {
		color:black;
	    font-weight:bold;
	}
	.disable {
	    padding:3px 7px;
	    color:white;
	}
	
	.now {
	   padding:3px 7px;
	    color:#46ade1;
	    font-weight:bold;
	}
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
		border: 1px solid #ddd;
		height: 40px;
		padding-left: 10px;
	}
	#searchTime th, #makeTime th{background-color: #EBF7FF;}
	
	#searchTime caption, #makeTime caption{
		text-indent: -9999px;
		height: 0;
	}
	.ck.ck-editor {
    	max-width: 100%;
    	padding: 8px;
    	
	}
	.ck-editor__editable {
	    min-height: 300px;
	}
	
	#t2{
		margin-top:10px;
		border-collapse: collapse;
		width: 99%;
		margin-bottom: 10px;
	}
	
	#t2 th{
	width: 100px;
	background-color: #EBF7FF;
	
	}

</style>

</head>
<body>
	<article id="wrap">
		<jsp:include page="../../head.jsp"></jsp:include>
		<div id="center">
			<jsp:include page="./leftList.jsp"></jsp:include>
			<div class="right">
				<div id="staffWrap">
					<div id="staffList_top">확인서류등록</div>
				<form action="Controller?type=trainuploadview" method="post" encType="multipart/form-data">
				<table id="makeTime" >
				<caption>서류보기 리스트</caption>
					<tbody>
						<tr>
							<th>확인서류명</th>
							<td>${vo6.subject}</td>
						</tr>
						<tr>
							<th>과정별 자동입력</th>
							<td>
								<table id="t2">
									<tbody>
										<tr>
											<th>훈련생명</th>
											<td colspan="3"></td>
										<tr>	
											<th>과정명</th>
											<td></td>
											<th>훈련기간</th>
											<td></td>
										</tr>
									</tbody>
								</table>
							</td>
						</tr>
						<tr>
							<th>내용</th>
							<td><textarea id="content" name="content" cols="100" rows="8">${vo6.content }</textarea></td>
						</tr>
						<tr>
							<th>첨부파일:</th>
							<td>
								<c:if test="${vo6.file_name ne null }">
									<a href ="javascript:down('${vo6.file_name }')">
										${vo6.file_name }
									</a>
								</c:if>
							</td>
						</tr>
						<tr>
							<td colspan="2">
								<input type="button" value="닫기" onclick="javascript:location.href='Controller?type=trainupload'">
							</td>
						</tr>
					</tbody>
			</table>
			</form>
			</div>
		</div>
	</div>
	<form action="Controller" method="post" name="frm">
		<input type="hidden" name="type" value=""/>
		<input type="hidden" name="tn_idx" value=""/>
		<input type="hidden" name="fname"/>
		<input type="hidden" name="cPage" value="${param.cPage }"/>
	</form>
	<div id="edit" hidden="hidden"></div>
	
	
	
	
</article>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>

	<script>
		$(function() {
			//$().removeClass("selected");
			$(".selected").removeClass("selected")
			$("#secondmenu").addClass("selected");
		});
		
	 	ClassicEditor
            .create( document.querySelector( '#content' ))
            .catch( error => {
                console.error( error );
            });
	 	function sendData(){
        		let ar = document.forms[0].elements;
        	
        			let str = ar[0].dataset.str;
        			if(document.forms[0].elements[0].value==""){
        				alert(str+"를 입력하세요");
        				document.forms[0].elements[i].focus();
        				return;
        			}
        		
        		
        		for(var i=21; i<ar.length-1; i++){
        			console.log(ar.length)
        			let str = ar[i].dataset.str;
        			if(document.forms[0].elements[i].value==""){
        				alert(str+"를 입력하세요");
        				document.forms[0].elements[i].focus();
        				return;
        			}
        		}
        		document.forms[0].submit();
        		
        	}
	 	
	 	function down(fname){
	 		document.frm.fname.value = fname;
	 		document.frm.type.value = "traindownload";
	 		document.frm.submit();
	 		
	 	}
	 	
	 	
	 	
	 	
	</script>
</body>
</html>