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
                <header>&nbsp;&nbsp;학적부</header>
                <div> 
                    <ul>
                        <jsp:include page="./leftList.jsp"></jsp:include>
                    </ul>
                </div>
                <!-- 메인 컨텐츠가 들어오는 영역-->
                <div class="right">
                    <div id="staffWrap">
                        <!-- <div id="boList_top">과정별 게시판</div> -->
        
                            <%-- ===== 검색하는 부분 ===== --%>
                            <table id="boList">
                                <caption>게시판 테이블</caption>
                                <thead>	
                                    <tr>
                                        <th>검색</th>
                                        <td>
                                            <select  id="search_tag">
                                                <option value="subject">제목</option>
                                                <option>작성자</option>
                                            </select>
                                            <input type="text"  id="search_value"/>
                                            <button type="button" id="search_btn" onclick="searchBoard()">검색</button>
                                        </td>
                                        <th colspan="2">전체공지</th>
                                        <td colspan="2">
                                            <input type="checkbox" id="chk_btn" onchange="checkNotice('${cPage}', '${c_idx}')"/>숨김
                                        </td>
                                    </tr>
                                    <tr><td colspan="6" align="right"><button type="button" id="bo_add_btn" onclick="add_btn_click('${param.c_idx}')">글쓰기</button></td></tr>
                                </thead>
                            </table>
                            <%-- ===== 검색하는 부분 ===== --%>
                            
                            <%-- ===== 비동기식으로 표현할 게시글 목록 시작 ===== --%>
                            <div id="board_list">
                                
                            </div>
                            <%-- ===== 비동기식으로 표현할 게시글 목록 끝 ===== --%>
    
                            <%-- ===== 게시글 작성 폼 시작 ===== --%>
                            <div id="addForm">
                            
                            </div>
                            <%-- ===== 게시글 작성 폼 끝 ===== --%>
    
                            <%-- ===== 게시글 내용 시작 ===== --%>
                            <div id="boContent">
                            
                            </div>
                            <%-- ===== 게시글 내용 끝 ===== --%>
                            
                            <%-- ===== 게시글 답변 작성 폼 시작 ===== --%>
                            <div id="replyForm">
                            
                            </div>
                            <%-- ===== 게시글 답변 작성 폼 끝 ===== --%>
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
			//$().removeClass("selected");
			/* 처음 게시판을 클릭했을 때
				 비동기식통신을 수행해 전체 목록을 가져온다 */
			
			$.ajax({
					url: "boardListAjax",
					type: "post",
					data: "cPage="+'${cPage}'+
							"&c_idx="+'${c_idx}'
				}).done(function(result){
					$("#board_list").html(result);
				});
			$(".selected").removeClass("selected");
			$(".l_select").removeClass("l_selected");
			$("#thirdmenu").addClass("selected");
			$("#l_five").addClass("l_select");
			
			/* 목록에서 [글쓰기]버튼을 클릭했을 때 수행 */
			/* $("#bo_add_btn").bind("click", function(){
				$.ajax({
					url: "addBoardAjax",
					type: "post",
				}).done(function(result){
					$("#addForm").html(result);
				});
				
				$("#addForm").dialog({
					title : '게시글 작성',
					modal : true,
					width : 1000,
					height : 600
				});
			}); */
			
		});
		
		/* 목록에서 [글쓰기]버튼을 클릭했을 때 수행 */
		function add_btn_click(c_idx){
			console.log("add="+c_idx);
			$.ajax({
				url: "addBoardAjax",
				type: "post",
				data: "c_idx="+c_idx,
			}).done(function(result){
				$("#addForm").html(result);
			});
			
			$("#addForm").dialog({
				title : '게시글 작성',
				modal : true,
				width : 1000,
				height : 600
			});
		};
		
		/* 목록 아래 [page번호]를 클릭할 때 수행
		 str를 변수로 가지고 새롭게 비동기통신을 해서
		 테이블을 표현한다 */
		function paging(str) {
			$.ajax({
				url: "boardListAjax",
				type: "post",
				data: "cPage="+str
			}).done(function(result){
				$("#board_list").html(result);
			});
		}
		
		/* 게시글 작성 폼에서 [등록] 버튼을 눌렀을때 수행 */
		function addBoard() {
			// 유효성 검사 해야함
			$("#addForm").dialog("close");
			
		};
		
		/* 글의 제목을 클릭했을 때 내용 보기 */
		function viewContent(bd_idx, cPage, c_idx) {
			$.ajax({
				url: "boardViewAjax",
				type: "post",
				data: "bd_idx="+bd_idx+
						"&cPage="+cPage+
						"&c_idx="+c_idx,
			}).done(function(result){
				$("#boContent").html(result);

				$("#boContent").dialog({
					title : '게시글 보기',
					modal : true,
					width : 1000,
					height : 600
				});
			});
			
		};

		/* 게시글 보기화면에서 [답변]을 눌렀을때 수행 */
		function reply(idx) {
			$.ajax({
				url: "boardReplyAjax",
				type: "post",
				data: "bd_idx="+idx
			}).done(function(result){
				$("#replyForm").html(result);
			});
			
			$("#replyForm").dialog({
				title : '게시판 답변 작성',
				modal : true,
				width : 1000,
				height : 600
			});
		};
		
		
		/* 답변 작성에서 [등록]을 눌렀을때 수행 */
		function addReply(frm) {
			frm.submit();

		};
		
		/* 게시글 목록에서 [검색]을 눌렀을때 수행 */
		function searchBoard(cPage) {
			let value = document.getElementById("search_value").value;
			$.ajax({
				url: "searchBoard",
				type: "post",
				data: "cPage="+encodeURIComponent(cPage)+
					  "&value="+encodeURIComponent(value)
			}).done(function(result){
				$("#board_list").html(result);
			});
		};

		function checkNotice(cPage, c_idx) {
			let checked = $("#chk_btn").is(':checked');
			if(checked) {
				$.ajax({
					url: "checkNotice_board",
					type: "post",
					data: "cPage="+encodeURIComponent(cPage),
				}).done(function(result) {
					$("#board_list").html(result);
				});
			}else if(!checked) {
				$.ajax({
					url: "boardList",
					type: "post",
					data: "cPage="+encodeURIComponent('1')+
							"&c_idx="+encodeURIComponent(c_idx),
				}).done(function(result) {
					$("#board_list").html(result);
				});
			}
		};
    </script>
</body>
</html>