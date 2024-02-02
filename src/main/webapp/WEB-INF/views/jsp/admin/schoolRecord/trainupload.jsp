<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/header.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/center.css" />
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
<link rel="stylesheet" href="css/summernote-lite.css">
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
	#searchTime th, #makeTime th{background-color: #ddd;}
	
	#searchTime caption, #makeTime caption{
		text-indent: -9999px;
		height: 0;
	}
	#b1{
		 float: right;
		 padding-top: 10px;
		 margin-bottom: 10px;
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
<c:if test="${tvo eq null }">
<body>
	<article id="wrap">
		<jsp:include page="../../head.jsp"></jsp:include>
		<div id="center">
			<jsp:include page="./leftList.jsp"></jsp:include>
			<div class="right">
				<div id="staffWrap">
					<div id="staffList_top">훈련생확인서류등록</div>
					<div id="b1">
						<input type="button" value="확인서류등록" onclick="javascript:location.href='uploadwrite'"/>
					</div>
				<table id="makeTime">
				<caption>훈련생확인서류등록 리스트</caption>
					<thead>
						<tr>
							<th>순번</th>
							<th>서류명</th>
							<th>첨부파일</th>
							<th>관리</th>
						</tr>
					</thead>
					<tfoot>
						<tr>
							<td colspan="10">
								<ol class="page">
				<c:if test="${requestScope.page.startPage < requestScope.page.pagePerBlock }">
				<li class="disable">&lt;</li>
			</c:if>	
	
			<c:if test="${requestScope.page.startPage >= requestScope.page.pagePerBlock }">
				<li><a href="javascript:paging('${page.startPage-page.pagePerBlock }')">&lt;</a></li>
			</c:if>

			<c:forEach begin="${page.startPage }" end="${page.endPage }" varStatus="vs">
				<c:if test="${vs.index eq page.nowPage }">
					<li class="now">${vs.index }</li>
				</c:if>
				<c:if test="${vs.index ne page.nowPage }">
					<li><a onclick="paging('${vs.index}')">${vs.index}</a></li>
				</c:if>
			</c:forEach>
	
			<c:if test="${page.endPage < page.totalPage }">
				<li><a href="javascript:paging('${page.startPage + page.pagePerBlock }')">&gt;</a></li>
			</c:if>
			<c:if test="${page.endPage >= page.totalPage }">
				<li class="disable">&gt;</li>	
			</c:if>
                              </ol>
                          </td>
						</tr>
					</tfoot>
					<tbody>
		
						<c:forEach var="vo3" items="${requestScope.ar }" varStatus="vs">
				<c:set var="num" value="${page.totalRecord - ((page.nowPage-1) * page.numPerPage) }"/>
					<tr>
						<td>${num-(vs.index) }</td>
						<td>${vo3.subject }</td>
						<td>${vo3.file_name }</td>
						<td>
						<input type="button" value="수정"
							onclick="edit('${vo3.tn_idx}')"/>
						<input type="button" onclick="traindel('${vo3.tn_idx}')" value="삭제">
						<input type="button" onclick="javascript:location.href='trainuploadview?tn_idx=${vo3.tn_idx}'" value="확인서류보기">
						</td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
			</div>
		</div>
	</div>
	<form action="trainuploaddel" method="post" name="frm">
		<input type="hidden" name="type" value=""/>
		<input type="hidden" name="tn_idx" value=""/>
		<input type="hidden" name="cPage" value="${param.cPage }"/>
	</form>
	<div id="edit" hidden="hidden"></div>
	
	
</article>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
	<script src="js/summernote-lite.js"></script>
	<script src="js/lang/summernote-ko-KR.js"></script>

	<script>
		$(function() {
			//$().removeClass("selected");
			$(".selected").removeClass("selected");
			$(".l_select").removeClass("l_selected");
			$("#thirdmenu").addClass("selected");
			$("#l_third").addClass("l_select");
		});

		/* function edit(tn_idx){
			console.log(tn_idx);
			
			document.frm.type.value="trainuploadedit";
			document.frm.tn_idx.value=tn_idx;
			console.log(document.frm.type.value);
			document.frm.submit();}
	 */
		
		function traindel(tn_idx){
			document.frm.type.value="trainuploaddel";
			document.frm.tn_idx.value=tn_idx;
			document.frm.submit();
			
		}
		function edit(ed){
			//console.log(ed);
			$.ajax({
				url:"trainuploadedit",
				type:"post",
				data:"type="+encodeURIComponent("trainuploadedit")+"&tn_idx="+ed
			}).done(function(reg){
				$("#edit").html(reg);
				
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
			
			$("#edit").dialog({
				width:1000,
				height:600
			});
			
		}
		
	
		function sendData(frm){
    		let ar = frm.elements;
    	
    			let str = ar[0].dataset.str;
    			if(frm.elements[0].value==""){
    				alert(str+"를 입력하세요");
    				frm.elements[i].focus();
    				return;
    			}

    		frm.submit();
		}
		
		function paging(str) {
			location.href="trainupload?cPage="+str;
		}
	</script>
</body>
</c:if>
<c:if test="${tvo ne null}">
	<c:redirect url="trainupload">
	</c:redirect>
</c:if>
</html>