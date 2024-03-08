<%@page import="com.ict.project.util.Paging"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/main2.css"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/right.css"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/paging.css"/>
<link rel="stylesheet" href="${pageContext.request.contextPath }/css/jquery-ui.min.css">
<link rel="stylesheet" href="css/summernote-lite.css">
<style>
	#t1{
		margin: auto;
		width: 70%;
		border-collapse: collapse;
	}
	#t1 td{
		text-align: center;
		border: 1px solid #ababab;
		border-left: none;
		border-right: none;
	}
	#t1 tfoot td{
		border: none;
		padding-top: 10px;
	}
</style>
</head>
<body>
	<article>

				<!--  여기서 표시될 테이블들 가지고오기 -->
				<div id="staffWrap">
					<!-- <div id="boList_top">과정별 게시판</div> -->
	
						<%-- ===== 검색하는 부분 ===== --%>
						<table id="boList" class="table">
							<caption>게시판 테이블</caption>
							<thead>	
								<tr>
									<th>검색</th>
									<td>
										<select  id="search_tag" class="select">
											<option value="subject">제목</option>
											<option>작성자</option>
										</select>
										<input type="text" id="search_value" class="text"/>
										<button type="button" id="search_btn" onclick="searchBoard('${cPage}', '${c_idx}')" class="btn">검색</button>
									</td>
									<th colspan="2">전체공지</th>
									<td colspan="2">
										<input type="checkbox" id="chk_btn" onchange="checkNotice('${cPage}', '${c_idx}')"/>숨김
									</td>
								</tr>
							</thead>
						</table>
						<div class="main_item align_right"><button type="button" id="bo_add_btn" onclick="add_btn_click('${param.c_idx}')" class="btn">글쓰기</button></div>
						<%-- ===== 검색하는 부분 ===== --%>
						
						<%-- ===== 비동기식으로 표현할 게시글 목록 시작 ===== --%>
						<form action="boardDownload" name="downForm" method="get">
							<input type="hidden" name="fname"/>
							<div id="board_list">
								
							</div>
						</form>
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
	<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
	<script>
		
		$(function() {
			/* 처음 게시판을 클릭했을 때
				 비동기식통신을 수행해 전체 목록을 가져온다 */
			$.ajax({
					url: "test_boardListAjax",
					type: "post",
					data: "cPage="+'${cPage}'+
							"&c_idx="+'${c_idx}'
				}).done(function(result){
                    $("#boList_top").html("과정별 게시판");
                    $("#boList").html("");
					$("#board_list").html(result);
				});
			$(".selected").removeClass("selected");
			$(".l_select").removeClass("l_selected");
			$("#thirdmenu").addClass("selected");
			$("#l_five").addClass("l_select");
		});

        /* 게시판에서 페이지 왔다갔다할때 수행하는 부분
            Paging을 유지해서 하기위함 */
        function viewBoardList(c_idx, cPage) {
            $.ajax({
                url: "test_boardListAjax",
                type: "post",
                data: "cPage="+cPage+
                        "&c_idx="+c_idx,
            }).done(function(result) {
                $("#board_list").html(result);
            });
        };

        /* 게시글의 제목을 클릭해서 내용 보기하는 부분 */
        function viewContent(bd_idx, cPage, c_idx) {
            $.ajax({
                url: "test_viewContentAjax",
                type: "post",
                data: "bd_idx="+bd_idx+
                        "&cPage="+cPage+
                        "&c_idx="+c_idx,
            }).done(function(result){
                $("#boContent").html(result);
				$("#boContent").dialog({
					title: '게시글 보기',
					modal: true,
					width: 1000,
					maxHeight: 900
				});
            });
        };

        /* [글쓰기] 버튼을 클릭했을때 등록폼을 가져오는 부분 */
        function add_btn_click(c_idx) {
            $.ajax({
                url: "test_addBoardAjax",
                type: "post",
                data: "c_idx="+c_idx,
            }).done(function(result){
                $("#addForm").html(result);
				$("#bd_content").summernote({
					height: 200,
					focus: true,
					lang: "ko-KR",
					dialogsInBody: true,
					callbacks: {
						onImageUpload: function(files, editor) {
							for (let i=0; i<files.length; i++) {
								sendImage(files[i], editor);
							}
						}
					}
				});
				$("#bd_content").summernote("lineHeight", 0.7);
                $("#addForm").dialog({
                    title: '게시글 등록',
                    modal: true,
                    width: 1000,
                    maxHeight: 900
                });
            });
        };

		// [글쓰기] 또는 [답변]을 할 때
		// 에디터에 이미지가 업로드되면 내용에 추가하는 기능
		function sendImage(file, editor, reply){
			let frm = new FormData();

			frm.append("file", file);

			$.ajax({
				url: "saveBoardImg",
				type: "post",
				data: frm,
				contentType: false,
				processData: false,
				cache: false,
				dataType: "json",
			}).done(function(data) {
				if(reply != null){
					$("#reply_content").summernote("editor.insertImage", data.url+"/"+data.fname);
				}else {
					$("#bd_content").summernote("editor.insertImage", data.url+"/"+data.fname);
				}
			});
		};

        /* 등록폼에서 [등록] 버튼을 클릭했을 때 수행하는 부분 */
        function addBoard(frm) {
			// 제목만 유효성 검사
			let subject = document.getElementById("bd_subject").value;

			if(!subject.trim().length > 0) {
				alert("제목을 입력하세요");
				return;
			}
			
			frm.submit();
			// 이 아래는 비동기식 통신으로 추가만 하는거
			// dialog가 안꺼지는 문제점이 있어서 다시 수정함
			// 이때는 인자로 form이 아니라 c_idx를 받았음
            /* let checked = $("#bd_notice").is(":checked");
            let notice = 0;
            if(checked)
                notice = 1;
            let subject = document.getElementById("bd_subject").value;
            let content = document.getElementById("bd_content").value;
            let file = document.getElementById("bd_file").value;

            $.ajax({
                url: "test_addBoard",
                type: "post",
                data: "c_idx="+c_idx+
                        "&cPage=1"+
                        "&bd_subject="+subject+
                        "&bd_notice="+notice+
                        "&bd_content="+content+
                        "&bd_file="+file,
            }).done(function(result){
                $("#board_list").html(result);
            }); */
        };
        
        /* 목록에서 [숨김] 체크박스를 클릭했을 때 수행하는 부분 */
        function checkNotice(cPage, c_idx) {
            let checked = $("#chk_btn").is(":checked");
            if(checked) { // 체크박스 체크했을 경우
                $.ajax({
                    url: "test_checkNotice_board",
                    type: "post",
                    data: "cPage="+cPage+
                            "&c_idx="+c_idx,
                }).done(function(result){
                    $("#board_list").html(result);
                });
            }else if(!checked) { // 체크박스 해제했을 경우
                $.ajax({
                    url: "test_viewBoardList",
                    type: "post",
                    data: "cPage="+cPage+
                            "&c_idx="+c_idx,
                }).done(function(result){
                    $("#board_list").html(result);
                });
            };
        };

        /* 과정별 게시판 목록에서 [검색] 버튼을 클릭했을 때 수행하는 부분 */
        function searchBoard(cPage, c_idx) {
            let bd_subject = document.getElementById("search_value").value;
            $.ajax({
                url: "test_searchBoard",
                type: "post",
                data: "cPage="+encodeURIComponent(cPage)+
                        "&c_idx="+encodeURIComponent(c_idx)+
                        "&bd_subject="+encodeURIComponent(bd_subject),
            }).done(function(result){
                $("#board_list").html(result);
            });
        };

		/* 게시글 보기 상태에서 [답변] 버튼을 클릭해서 답변Form을 가져오는 기능 */
		function reply(bd_idx, cPage, c_idx) {
			let reply = "reply";
			$.ajax({
				url: "test_replyBoardAjax",
				type: "post",
				data: "bd_idx="+bd_idx+
						"&cPage="+cPage+
						"&c_idx="+c_idx,
			}).done(function(result){
				$("#boContent").html(result);
				$("#reply_content").summernote({
					height: 200,
					focus: true,
					lang: "ko-KR",
					dialogsInBody: true,
					callbacks: {
						onImageUpload: function(files, editor) {
							for (let i=0; i<files.length; i++) {
								sendImage(files[i], editor, reply);
							}
						}
					}
				});
				$("#reply_content").summernote("lineHeight", 0.7);
				$("#boContent").dialog({
					title: '게시글 답변 작성',
					modal: true,
					width: 1000,
					maxHeight: 900
				});
			});
		};

        /* 답변 작성에서 [등록]을 눌렀을때 수행 */
		function addReply(frm) {
			// 제목만 유효성 검사
			let subject = document.getElementById("bd_replySubject").value;

			if(!subject.trim().length > 0) {
				alert("제목을 입력하세요");
				return;
			}
			frm.submit();
			// 이 아래는 비동기식 통신으로 추가만 하는거
			// dialog가 안꺼지는 문제점이 있어서 다시 수정함
			// 이때는 인자로 form이 아니라 c_idx를 받았음
            /* let checked = $("#bd_notice").is(":checked");
            let notice = 0;
            if(checked)
                notice = 1;
            let subject = document.getElementById("bd_subject").value;
            let content = document.getElementById("bd_content").value;
            let file = document.getElementById("bd_file").value;

			$.ajax({
                url: "test_replyBoard",
                type: "post",
                data: "c_idx="+c_idx+
                        "&cPage=1"+
                        "&bd_subject="+subject+
                        "&bd_notice="+notice+
                        "&bd_content="+content+
                        "&bd_file="+file,
            }).done(function(result){
                $("#board_list").html(result);
				$("#replyForm").dialog("close");
            }); */
		};

		function download(fname) {
			document.downForm.fname.value = fname;
			document.downForm.submit();
		};
		
	</script>
</body>
</html>