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
    <article class="logo"><img alt="로고" src="${pageContext.request.contextPath }/image/ict_logo.png" /></article>
    <article class="bottom">
        <article>
            <jsp:include page="${pageContext.request.contextPath }/WEB-INF/views/jsp/head.jsp"></jsp:include>
        </article>
        <article class="center">
            <div>
                <header>&nbsp;&nbsp;상담 및 접수</header>
                <div> 
                    <ul>
                        <jsp:include page="./leftList.jsp"></jsp:include>
                    </ul>
                </div>
                <!-- 메인 컨텐츠가 들어오는 영역-->
                <div class="right">
                    <div id="staffWrap">
						<div id="courseList_top" class="main_item title">면접평가표리스트</div>
						<div id="ttop" class="main_item align_right">
							<button type="button" onclick="setcr1()" class="btn">평가표등록</button>	
						</div>
						<div id="counselReceipt_Table">
						
						</div>
					</div>
				</div>
                </div>
            </div> 
        </article>
    </article>
    <form name="frm" action="counselReceipt" method="post">
        <input type="hidden" name="cr_idx" value="" />
    </form>
    
    <div id="dialog" hidden="" title="면접평가표등록">	
    </div>

    <div id="dialog2" hidden="" title="면접평가표수정">	
    </div>
    
    <div id="dialog3" hidden="" title="면접평가표">	
    </div>

    <div id="dialog4" hidden="" title="평가내용 등록/수정">	
    </div>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
    <script>
        let select ="";
		let select_year = "";
		let numPerPage = "";
		let value ="";
		let room_length =7;
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
        $(function(){
			$(".subSelect").removeClass("subSelect");
			$("#l_one").addClass("subSelect");
			$.ajax({
				url: "counselReceiptMain",
				type: "post",
				data:"type="+encodeURIComponent("counselReceiptMain")+"&listSelect="+encodeURIComponent("1")+"&cPage="+encodeURIComponent('${param.cPage}')
			}).done(function(result){
				$("#counselReceipt_Table").html(result);
			});
			
	
		});


			
		function setcr1() {
			$.ajax({
				url:"cr_dialog",
				type:"post",
				data:"&select="+encodeURIComponent("addCounselReceipt")
			}).done(function(result){
				$("#dialog").html(result);
				
				$("#cc_cancle").click(function(){
					 $("#dialog").dialog("close");
				});
			});

            $("#dialog").dialog("open");
        }

		function setcr2(cr_idx) {
			$.ajax({
				url:"editCounselReceipt",
				type:"post",
				data:"&cr_idx="+cr_idx,
			}).done(function(result){
				$("#dialog2").html(result);
				
				$("#cc_cancle").click(function(){
					 $("#dialog2").dialog("close");
				});
			});

            $("#dialog2").dialog("open");
        }

		function setcr3() {
			$.ajax({
				url:"cr_dialog",
				type:"post",
				data:"&select="+encodeURIComponent("counselReceipt_file")
			}).done(function(result){
				$("#dialog3").html(result);
				
				$("#cc_cancle").click(function(){
					 $("#dialog3").dialog("close");
				});
			});

            $("#dialog3").dialog("open");
        }

		function setcr4() {
			$.ajax({
				url:"cr_dialog",
				type:"post",
				data:"&select="+encodeURIComponent("evaluationFactor")
			}).done(function(result){
				$("#dialog4").html(result);
				
				$("#cl").click(function(){
					 $("#dialog4").dialog("close");
				});
			});

            $("#dialog4").dialog("open");
        }

		$( "#dialog" ).dialog({
            autoOpen: false,
            width:600,
            modal: true,
        
        });

		$( "#dialog2" ).dialog({
            autoOpen: false,
            width:600,
            modal: true,
        
        });
		$( "#dialog3" ).dialog({
            autoOpen: false,
            width:1000,
            modal: true,
        
        });

		$( "#dialog4" ).dialog({
            autoOpen: false,
            width:1200,
            modal: true,
         
        });

		function addCounselReceipt(frm) {
		    frm.action= "editCounselReceipt?edit=ok";
		    frm.submit();
		}

		
		function del(cr_idx){
			if( confirm("삭제하시겠습니까?")){
			frm.action = "delCounselReceipt";
			document.frm.cr_idx.value = cr_idx; 
			
			document.frm.submit();
			}
		}
    </script>
</body>
</html>