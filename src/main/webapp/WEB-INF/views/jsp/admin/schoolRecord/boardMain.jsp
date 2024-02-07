<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
    <article class="logo"><img alt="로고" src="${pageContext.request.contextPath }/image/ict_logo.png" /></article>
    <article class="bottom">
        <article>
            <jsp:include page="${pageContext.request.contextPath }/WEB-INF/views/jsp/head.jsp"></jsp:include>
        </article>
        <article class="center">
            <div>
                <header>&nbsp;&nbsp;상담관리</header>
                <div> 
                    <ul>
                        <jsp:include page="./leftList.jsp"></jsp:include>
                    </ul>
                </div>
                <!-- 메인 컨텐츠가 들어오는 영역-->
                <div class="right">
                    	<!--  여기서 표시될 테이블들 가지고오기 -->
				<div id="staffWrap">
					<div id="boList_top" class="title">게시판</div>
	
						<%-- ===== 검색하는 부분 ===== --%>
						<table id="boList" class="table">
							<caption>게시판 검색 테이블</caption>
							<thead>	
								<tr>
									<th>검색</th>
									<td>
										<select id="search_year" onchange="searchBothBoard()" class="select">
											<option value="">년도선택</option>
											<option>2024</option>
											<option>2023</option>
											<option>2022</option>
											<option>2021</option>
											<option>2020</option>
											<option>2019</option>
											<option>2018</option>
										</select>
									</td>
									<td>
										<select id="search_tag" class="select">
											<option value="1">훈련강사</option>
                                            <option value="2">과정타입</option>
                                            <option value="3">과정명</option>
                                        </select>
                                        <input type="text" id="search_value" class="text"/>
                                        <button type="button" id="search_btn" onclick="searchBothBoard()" class="btn">검색</button>
									</td>
								</tr>
							</thead>
						</table>
						<%-- ===== 검색하는 부분 ===== --%>
						
						<%-- ===== 비동기식으로 표현할 과정 목록 시작 ===== --%>
						<div id="board_main_list">
							
						</div>
						<%-- ===== 비동기식으로 표현할 과정 목록 끝 ===== --%>

						<%-- ===== 게시글 내용 시작 ===== --%>
						<div id="boContent">
						
						</div>
						<%-- ===== 게시글 내용 끝 ===== --%>
						
						<%-- ===== 게시글 답변 작성 폼 시작 ===== --%>
						<div id="replyForm">
						
						</div>
						<%-- ===== 게시글 답변 작성 폼 끝 ===== --%>

						<%-- ===== 게시글 작성 폼 시작 ===== --%>
						<div id="addForm">
							<input type="hidden" id="hidden_btn" value="'${param.c_idx}'"/>
						</div>
						<%-- ===== 게시글 작성 폼 끝 ===== --%>
				</div>    
				</div>
            </div> 
        </article>
    </article>

    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
    <script>
        let search_year = "";
		let search_value = "";
		let search_tag = "";
		let add_flag = '${param.c_idx}';
		
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
			$("#l_five").addClass("subSelect");
			
			// 게시판에 들어왔을 때 [글쓰기]를 하고 온 경우
			// 과정별 게시판을 ajax를 이용해 목록을 출력한다
			if(add_flag != "") {
				test_viewBoardList(add_flag);
			}else { // 처음 게시판에 들어왔을 때의 경우
				// 비동기식 통신을 이용해 과정의 목록들을 출력한다
				$.ajax({
					url: "boardCourseAjax",
					type: "post",
				}).done(function(result) {
					$("#board_main_list").html(result);
				});
			};
    	});

        /* 목록 아래 [page번호]를 클릭할 때 수행
		 str를 변수로 가지고 새롭게 비동기통신을 해서
		 테이블을 표현한다 */
		function paging(str) {
			$.ajax({
				url: "boardCourseAjax",
				type: "post",
				data: "cPage="+str
			}).done(function(result){
				$("#board_main_list").html(result);
			});
		};
		// ============================ 이 밑으로는 test중 ============================
		function test_viewBoardList(c_idx, cPage) {
			$.ajax({
				url: "test_viewBoardList",
				type: "get",
				data: "c_idx="+c_idx+
						"&cPage="+cPage,
			}).done(function(result){
				$("#board_main_list").html(result);
			});
		};
		
		function searchBothBoard(cPage) {
			search_year = document.getElementById("search_year").value;
			search_tag = document.getElementById("search_tag").value;
			search_value = document.getElementById("search_value").value;
			
			$.ajax({
				url: "searchBothBoard",
				type: "post",
				data: "cPage="+cPage+
				"&tag="+search_tag+
				"&value="+encodeURIComponent(search_value)+
				"&year="+search_year,
			}).done(function(result){
				$("#board_main_list").html(result);
			});
		};
    </script>
</body>
</html>