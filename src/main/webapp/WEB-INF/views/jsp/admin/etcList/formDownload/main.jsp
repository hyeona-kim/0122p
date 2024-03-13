<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/main2.css"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/right.css"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/paging.css"/>
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
</head>
<body>
    <article>
		<jsp:include page="${pageContext.request.contextPath }/WEB-INF/views/jsp/top_head.jsp"></jsp:include>
	</article>
    <article class="bottom">
        <article>
            <jsp:include page="${pageContext.request.contextPath }/WEB-INF/views/jsp/head.jsp"></jsp:include>
        </article>
        <article class="center">
            <div>
                <header>&nbsp;&nbsp;기타관리</header>
                <div> 
                    <ul>
                        <jsp:include page="../leftList.jsp"></jsp:include>
                    </ul>
                </div>
                <!-- 메인 컨텐츠가 들어오는 영역-->
                <div class="right">
					<div id="staffWrap">
                    <div id="formDownWrap">
                        <div id="formDownList_top" class="title">서식 자료실</div>
                        <table id="formDownList" class="table">
                            <colgroup>
                                <col width="13%">
                                <col width="67%">
                                <col width="20%">
                            </colgroup>
                            <caption>서식 자료실 검색 테이블</caption>
                            <%-- ===== 검색하는 부분 ===== --%>
                            <thead>
                                <tr>
									<th>검색</th>
                                    <td>
                                        <select id="viewNum" onchange="changeViewNum()" class="select">
                                            <option value="0">표시개수</option>
                                            <option>10</option>
                                            <option>20</option>
                                            <option>30</option>
                                        </select>
										<!--
                                        <select class="select">
                                            <option>제목</option>
                                        </select>
                                        <input type="text" id="search_value" class="text"/>
                                        <button type="button" id="search_btn" onclick="changeViewNum()" class="btn">검색</button>
										-->
                                    </td>
                                    <td align="right"><button type="button" id="form_add_btn" class="btn">서식파일 등록</button></td>
                                </tr>
                            </thead>
                        </table>
                        <%-- ===== 비동기식 통신으로 출력할 테이블 시작 ===== --%>
                        <div id="mainAjax" style="margin-top: 20px;">
                            
                        </div>
                        <%-- ===== 비동기식 통신으로 출력할 테이블 끝 ===== --%>
                        <%-- ===== 서식파일 등록 테이블 시작 ===== --%>
                        <div id="addFormAjax">
                        
                        </div>
                        <%-- ===== 서식파일 등록 테이블 끝 ===== --%>
                        <%-- ===== 수정 테이블 시작 ===== --%>
                        <div id="editFormAjax">
                        
                        </div>
                        <%-- ===== 수정 테이블 끝 ===== --%>
				    </div>
                </div>
			</div>
            </div> 
        </article>
    </article>

    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
    <script>
        $(".sub_manu").mouseover(function(){
            $(this).css("display","block");
        });
        $(".menu1").mouseover(function(){
            $(this).next().css("display","block");
        });
        $(".menu1").mouseout(function(){
            $(this).next().css("display","none");
        });
        $(".sub_manu").mouseout(function(){
            $(this).css("display","none");
        });
        $(function() {
			$(".subSelect").removeClass("subSelect");
			$("#l_three").addClass("subSelect");
			$("#addFormAjax").dialog({
				title: '서식파일 등록',
				autoOpen: false,
				modal: true,
				width: 800,
				maxHeight: 500
			});

			$("#editFormAjax").dialog({
				title: '서식파일 수정',
				autoOpen: false,
				modal: true,
				width: 800,
				maxHeight: 500
			});

			// 처음 메인 페이지로 왔을때
			// 비동기식 통신을 이용해 전체목록을 출력한다
			$.ajax({
				url: "formMainAjax",
				type: "post",
			}).done(function(result) {
				$("#mainAjax").html(result);
			});

			// [서식파일 등록]을 클릭했을 때 수행하는 곳
			$("#form_add_btn").on("click", function(){
				$.ajax({
					url: "addFormDownAjax",
					type: "post",
				}).done(function(result){
					$("#addFormAjax").html(result);
					$("#addFormAjax").dialog("open");
				});	
			});
		});

		function editFormDown(idx) {
			$.ajax({
				url: "editFormDownAjax",
				type: "post",
				data: "fd_idx="+idx,
			}).done(function(result){
				$("#editFormAjax").html(result);
				$("#editFormAjax").dialog("open");
			});
		};
		
		// 서식파일 등록에서 [저장]을 클릭했을 때
		// 또는 서식파일 수정에서 [수정]을 클릭했을 때 수행하는 곳
		function addFormDown(frm) {
			if(frm.fd_subject.value.trim() == 0){
				alert(frm.fd_subject.dataset.str+"을 입력하세요");
				frm.fd_subject.focus();
				return; // 수행 중단
			};
			frm.submit();
		};

		// [취소]을 클릭했을 때 켜져있는 dialog를 끄는 기능
		function closeDialog() {
			if($("#addFormAjax").dialog("isOpen")) {
				$("#addFormAjax").dialog("close");
			}
			if($("#editFormAjax").dialog("isOpen")) {
				$("#editFormAjax").dialog("close");
			}
		};

		// [삭제]를 클릭했을 때 수행하는 곳
		function deleteFormDown(idx) {
			if(confirm("삭제하시겠습니까?")){
				location.href="deleteFormDown?fd_idx="+idx;
			}else{
				return false;
			}
		};

		/* 목록 아래 [page번호]를 클릭할 때 수행
			 cPage를 변수로 가지고 새롭게 비동기통신을 해서
			 테이블을 표현한다 */
		function paging(cPage) {
			$.ajax({
				url: "formMainAjax",
				type: "post",
				data: "cPage="+cPage
			}).done(function(result){
				$("#mainAjax").html(result);
			});
		};

		// 목록에서 [첨부파일]을 클릭할 때 수행
		// 첨부된 파일을 다운받는 기능
		function formFileDown(fd_fname) {
			location.href="formFileDown?fd_fname="+fd_fname;
		};

		// [표시개수]를 바꿨을 때 수행
		// 선택한 표시개수만큼 1page에 출력하는 기능
		function changeViewNum(cPage) {
			let num = document.getElementById("viewNum").value;
			let value = document.getElementById("search_value").value;
			$.ajax({
				url: "formMainAjax",
				type: "post",
				data: "numPerPage="+num+
						"&cPage="+cPage+
						"&value="+value
			}).done(function(result){
				$("#mainAjax").html(result);
			});
		};
    </script>
</body>
</html>