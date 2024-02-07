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
	#searchTime th, #makeTime th{background-color: #e2eef0;}
	
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
					<div id="staffList_top">훈련생확인서류</div>
					<table id="searchTime">
						<caption>훈련생확인서류검색</caption>
						<thead>
							<tr>
								<th>검색</th>
								<td>
									<select id="searchyear">
	
									</select>
								</td>
								<td>
									<select id="searchType">
										<option value="1">담당교수</option>
										<option value="2">과정타입</option>
										<option value="3">과정명</option>
									</select>
									<input type="text" id="searchValue"/>
									<button type="button" id="search">검 색</button>
								</td>
							</tr>
						</thead>
					</table>
					<div id="result">
						<table id="makeTime">
						<caption>훈련생확인서류 리스트</caption>
							<thead>
								<tr>
									<th>번호</th>
									<th>과정명</th>
									<th>담당교수</th>
									<th>개강일</th>
									<th>종료일</th>
									<th>요일</th>
									<th>회차</th>
									<th>모집인원</th>
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
				
								<c:forEach var="vo4" items="${requestScope.ar }" varStatus="vs">
						<c:set var="num" value="${page.totalRecord - ((page.nowPage-1) * page.numPerPage) }"/>
							<tr>
								<td>${num-(vs.index)}</td>
								<td>${vo4.c_name}</td>
								<%-- 강사 코드에따른 강사를 가져오는 Bean을 만든다 --%>
								<td>${vo4.svo.sf_name}</td>
								<td>${vo4.start_date }</td>
								<td>${vo4.end_date }</td>
								<td>${vo4.c_day}</td>
								<td>${vo4.c_round_num }</td>
								<td>${vo4.c_peo_num}</td>
								<td>
								<input type="button" id="fset"  onclick="set('${vo4.tn_idx}')" value="확인서류설정">
								<input type="button" onclick="set2('${vo4.tn_idx}')" value="확인서류보기">
								</td>
							</tr>
						</c:forEach>
						</tbody>
					</table>
				</div>

			</div>
		</div>
	</div>
	<div id="m1" hidden="hidden"></div>
	
</article>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
	 <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
	<script>
		let searchType="1";
		let searchValue="";
		let searchyear="";

		$(function() {
			//$().removeClass("selected");
			$(".selected").removeClass("selected");
			$(".l_select").removeClass("l_selected");
			$("#thirdmenu").addClass("selected");
			$("#l_four").addClass("l_select");

			let now = new Date();	// 현재 날짜 및 시간
			let year = now.getFullYear();
			let str = "<option>년도선택</option>";
			
			for(let i=year+1; i>year-5; i--){
				str+= "<option value="+i+">"+i+"</option>";
			}
			$("#searchyear").html(str);

			$("#searchyear").change(function(){
				searchyear = $("#searchyear").val();
				$.ajax({
					url: "confilmsearch",
					type:"post",
					data: "select="+searchType+"&value="+searchValue+"&year="+searchyear+"&cPage=1",
				}).done(function(result){
					$("#result").html(result);
				});
								
			});
			$("#search").click(function(){
				searchType = $("#searchType").val();
				searchValue = $("#searchValue").val();
			
				$.ajax({
					url: "confilmsearch",
					type:"post",
					data: "select="+searchType+"&value="+searchValue+"&year="+searchyear+"&cPage=1",
				}).done(function(result){
					$("#result").html(result);
				});
				
			});
			
		});

		function sendData(){
    		let ar = document.fff.elements;
    	
    		let str = ar[0].dataset.str;

    		document.fff.submit();
		}



		
	function set(str,str1){
		console.log(str+"/"+str1);
		$.ajax({
            url: "confirm",
            type: "post",
            data:"tn_idx="+str+"&c_idx="+str1
         }).done(function(result){
            $("#m1").html(result);
         });
         
		$( "#m1" ).dialog({
				width:700,
            	height:600
		});

		let idxobj = $("input[name=chk]:checked")
		let objvalue = idxobj.val();

		$.each(idxobj, function(idx){
			if($chk.eq(idx).prop("checked") == true){
				
			}
		});


	}

	function set2(str,str1){
		$.ajax({
            url: "confirm2",
            type: "post",
            data:"tn_idx="+str+"&c_idx="+str1
         }).done(function(result){
            $("#m1").html(result);
         });
         
		$( "#m1" ).dialog({
				width:1000,
            	height:600
		});
	}


	function subRow(){
		let query = 'input[name="chk"]:checked'
		let selectedElements = document.querySelectorAll(query)

		let selectedElementsCnt = selectedElements.length;

		if(selectedElementsCnt == 0){
			alert("등록할 항목을 선택해주세요.")
			return false;
		}else if(confirm("등록하시겠습니까?")){
			cf.action="confirmAdd";
			cf.submit();
		}
	}

	function allChecked(target){

		let checkbox = document.getElementById('allCheckBox');
		let is_checked = checkbox.checked;

		if(is_checked){
			chkAllChecked()
		}else{
			chkAllUnChecked()
		}


	}


	function chkClicked(tr_idx){
			//console.log(tr_idx);
			//체크박스 전체개수
			let allCount = document.querySelectorAll(".chk").length;

			//체크된 체크박스 전체개수
			let query = 'input[name="chk"]:checked'
			let selectedElements = document.querySelectorAll(query)
			let selectedElementsCnt = selectedElements.length;

			//체크박스 전체개수와 체크된 체크박스 전체개수가 같으면 전체 체크박스 체크
			if(allCount == selectedElementsCnt){
				document.getElementById('allCheckBox').checked = true;
			}

			//같지않으면 전체 체크박스 해제
			else{
				document.getElementById('allCheckBox').checked = false;
			}
		}

		/* 전체 체크  */
		function chkAllChecked(){
			document.querySelectorAll(".chk").forEach(function(v, i) {
            v.checked = true;
        });
    }

		/* 전체 체크 해제 */
		function chkAllUnChecked(){
			document.querySelectorAll(".chk").forEach(function(v, i) {
            v.checked = false;
        });
    }
	

	function paging(str) {	
		$.ajax({
			url: "confilmsearch",
			type:"post",
			data:"select="+searchType+"&value="+searchValue+"&year="+searchyear+"&cPage="+str,
		}).done(function(result){
			$("#result").html(result);
		});

	
	}
		
		
		
		
	</script>
</body>
</c:if>

</html>