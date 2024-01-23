<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/summernote-lite.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/header.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/center.css" />
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
				<form action="uploadwrite" method="post" encType="multipart/form-data">
				<table id="makeTime" >
				<caption>확인서류등록 리스트</caption>
					<tbody>
						<tr>
							<th>확인서류명</th>
							<td><input type="text" name="subject" size="45" data-str="서류명"/></td>
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
							<td><textarea id="content" name="content" cols="100" rows="8"></textarea></td>
						</tr>
						<tr>
							<th>첨부파일:</th>
							<td><input type="file" name="file" data-str="파일"/></td>
						</tr>
						<tr>
							<td colspan="2">
								<input type="button" value="저장"
								onclick="sendData()"/>
								<input type="button" value="닫기" onclick="javascript:location.href='trainupload'">
							</td>
						</tr>
						
					</tbody>
			</table>
			</form>
			</div>
		</div>
	</div>
</article>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
	<script src="js/summernote-lite.js"></script>
	<script src="js/lang/summernote-ko-KR.js"></script>
	<script>
		$(function() {
			//$().removeClass("selected");
			$(".selected").removeClass("selected")
			$("#secondmenu").addClass("selected");

			//textarea에 에디터 가져다 놓기
			$("#content").summernote({
					height:200,
					focus : true, /* 커서를 미리 가져다 놓는다 */
					lang : "ko-KR",
					callbacks:{
						onImageUpload:function(files, editor){
							// 이미지가 에디터에 추가 될 때마다 수행하는곳
							// 추가되어 들어온 이미지는 여러개일수 있기 때문에 files 으로 받아야함.(배열)
							// 배열로 받아야하기때문에 반복문을 돌림
							for(let i=0; i<files.length; i++)
								sendImage(files[i],editor);
							
						}
						
					}
				});
				$("#content").summernote("lineHeight", .7);
			});

			


	 	function sendData(){
        		let ar = document.forms[0].elements;
        	
        			let str = ar[0].dataset.str;
        			if(document.forms[0].elements[0].value==""){
        				alert(str+"를 입력하세요");
        				document.forms[0].elements[i].focus();
        				return;
        			}
        	
        		document.forms[0].submit();
        		
        	}
	</script>
</body>
</html>