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
                        <div id="sugList_top" class="title">Q&A</div>
						<div class="main_item">
							<select id="c_check" class="select">
								<option value="1">미답변</option>
								<option value="2">전체</option>
							</select>
						</div>
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
			

			$.ajax({
				url: "suggMain",
				type: "post",
				data: "qname=q&cPage=1&c_check=1"
			}).done(function(result){
				$("#ajaxContent").html(result);
			});
			
			$("#c_check").change(function(){
				$.ajax({
					url: "suggMain",
					type: "post",
					data: "qname=q&cPage=1&c_check="+this.value
				}).done(function(result){
					$("#ajaxContent").html(result);
				});
			});	
			
			
		});

	
		/* 목록 아래 [page번호]를 클릭할 때 수행
			 cPage를 변수로 가지고 새롭게 비동기통신을 해서
			 테이블을 표현한다 */
		function paging(cPage) {
			$.ajax({
				url: "suggMain",
				type: "post",
				data: "qname=q&cPage="+cPage+"&c_check=2"
			}).done(function(result){
				$("#ajaxContent").html(result);
			});
		}
		
		
		function openSugg(qna_idx){
            $("#dialog").dialog("open");
            $.ajax({
                url: "viewSugg_s",
                type:"post",
                data:"qna_idx="+qna_idx,
            }).done(function(result){
                $("#dialog").html(result);
				$("#cc_cancle").click(function(){
					$("#dialog").dialog("close")
				});
				$("#add_comm").click(function(){
					//cm_idx, cm_writer, cm_content, cm_write_date, qna_idx, status
					let cm_writer=$("#cm_writer").val();
					let cm_content=$("#cm_content").val();
					let qna_idx=$("#qna_idx").val();
					
					let today = new Date();   
					let year = today.getFullYear(); // 년도
					let month = today.getMonth() + 1;  // 월
					month = Number(month)<10 ? "0"+month:month;
					let date = today.getDate();  // 날짜
					let cm_write_date= year + '-' + month + '-' + date;//현재날짜
					$.ajax({
						url:"addComm",
						type:"post",
						data:"cm_writer="+cm_writer+"&cm_content="+cm_content+"&qna_idx="+qna_idx+"&cm_write_date="+cm_write_date,
						dataType:"json"
					}).done(function(res){
						if(res.cnt == 1){
							alert("저장되었습니다")
							location.reload(true);
						}else{
							alert("저장실패")
							location.reload(true);
						}
					});
				})
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