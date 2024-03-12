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
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/summernote-lite.css"/>
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
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
		<jsp:include page="${pageContext.request.contextPath }/WEB-INF/views/jsp/top_head.jsp"></jsp:include>
	</article>
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
                        <div id="sugList_top" class="title">고충 및 건의사항</div>
                        <table class="sugList table">
                            <caption>고충 및 건의사항 검색 테이블</caption>
                            <%-- ===== 검색하는 부분 ===== --%>
                            <thead>
                             
                            </thead>
                        </table>
						<div class="main_item align_right"><button type="button" id="sug_add_btn" class="btn">글쓰기</button></div>
                        <%-- ===== 비동기식 통신으로 출력할 테이블 시작 ===== --%>
                        <form action="SuggDownload" name="downForm" method="get">
                            <input type="hidden" name="fname"/>
                            <div id="ajaxContent">
								
                            </div>
                        </form>
                        <%-- ===== 비동기식 통신으로 출력할 테이블 끝 ===== --%>
                    </div>
                    <%-- 끝--%>    
				</div>
            </div> 
        </article>
    </article>
	<%-- ===== 고충 및 건의사항 작성 폼 시작 ===== --%>
	<div id="addForm" hidden>
	
	</div>
	<%-- ===== 고충 및 건의사항 작성 폼 끝 ===== --%>
	
	<%-- ===== 건의사항 내용 시작 ===== --%>
	<div id="sugContent" hidden>
	
	</div>
	<%-- ===== 건의사항 내용 끝 ===== --%>
	
	<%-- ===== 건의사항 답변 작성 폼 시작 ===== --%>
	<div id="replyForm" hidden>
	
	</div>
	<div id="dialog" hidden></div>


    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
    <script src="js/summernote-lite.js"></script>
	<script src="js/lang/summernote-ko-KR.js"></script>
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
			$(".subSelect").removeClass("subSelect");
			$("#l_one").addClass("subSelect");
			
			/* 처음 고충 및 건의사항을 클릭했을 때
				 비동기식통신을 수행해 전체 목록을 가져온다 */
			$.ajax({
				url: "suggMain",
				type: "post",
				data: "qname=q"
			}).done(function(result){
				$("#ajaxContent").html(result);
			});
			
			/* 목록에서 [글쓰기]버튼을 클릭했을 때 수행 */
			$("#sug_add_btn").bind("click", function(){
				$.ajax({
					url: "sugAddForm",
					type: "post",
				}).done(function(result){
					$("#addForm").html(result);
					// 글쓰기에 [에디터] 추가
					$("#sg_content").summernote({
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
					$("#sg_content").summernote("lineHeight", 0.7);
				});

				$("#addForm").dialog({
					title : '고충 및 건의사항 작성',
					modal : true,
					width : 1000,
					maxHeight : 800
				});
			});
			
		});

		// [글쓰기] 또는 [답변]을 할 때
		// 에디터에 이미지가 업로드되면 내용에 추가하는 기능
		function sendImage(file, editor, reply){
			let frm = new FormData();

			frm.append("file", file);

			$.ajax({
				url: "saveSuggImg",
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
					$("#sg_content").summernote("editor.insertImage", data.url+"/"+data.fname);
				}
			});
		};
		
		/* 목록 아래 [page번호]를 클릭할 때 수행
			 cPage를 변수로 가지고 새롭게 비동기통신을 해서
			 테이블을 표현한다 */
		function paging(cPage) {
			$.ajax({
				url: "suggMain",
				type: "post",
				data: "cPage="+cPage
			}).done(function(result){
				$("#ajaxContent").html(result);
			});
		}
		
		/* 건의사항 작성 폼에서 [등록] 버튼을 눌렀을때 수행 */
		function addSuggestion() {
			// 제목만 유효성 검사
			let subject = document.getElementById("sg_subject").value;

			if(!subject.trim().length > 0) {
				alert("제목을 입력하세요");
				return;
			}
			
			document.addForm.submit();
		};
		
		/* 글의 제목을 클릭했을 때 내용 보기 */
		function viewContent(sg_idx) {
			$.ajax({
				url: "viewSugg",
				type: "post",
				data: "sg_idx="+sg_idx
			}).done(function(result){
				$("#sugContent").html(result);
			});
			$("#sugContent").dialog({
				title : '고충 및 건의사항',
				modal : true,
				width : 1000,
				maxHeight : 800
			});
		};
		
		/* 건의사항 보기화면에서 [답변]을 눌렀을때 수행 */
		function reply(sg_idx) {
			let reply = "reply";
			$.ajax({
				url: "reply",
				type: "post",
				data: "sg_idx="+sg_idx
			}).done(function(result){
				$("#replyForm").html(result);
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
			});
			
			$("#replyForm").dialog({
				title : '고충 및 건의사항 답변 작성',
				modal : true,
				width : 1000,
				maxHeight:  800,
			});
		};
		
		/* 답변 작성에서 [등록]을 눌렀을때 수행 */
		function addReply(frm) {
			// 제목만 유효성 검사
			let subject = document.getElementById("reply_subject").value;

			if(!subject.trim().length > 0) {
				alert("제목을 입력하세요");
				return;
			}
			frm.submit();
		};

		
		function download(fname) {
			document.downForm.fname.value = fname;
			document.downForm.submit();
		};

		function openSugg(qna_idx){
            $("#dialog").dialog("open");
            $.ajax({
                url: "viewSugg_s",
                type:"post",
                data:"qna_idx="+qna_idx,
            }).done(function(result){
                $("#dialog").html(result);
             
            });
        }

        $("#dialog").dialog({
			autoOpen: false,
			maxHeight: 900,
			width: 1200,
			modal: true,
        });
    </script>
</body>
</html>