<%@page import="java.util.List"%>
<%@page import="org.apache.ibatis.session.SqlSession"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
	#courseList_top, #staffList_top {
		background: black;
		color: white;
		height: 40px;
		line-height: 40px;
	}
	
	#searchCourse, #makeCourse{
		margin-top:10px;
		border-collapse: collapse;
		width: 100%;
	}
	
	#searchCourse td, #searchCourse th, #makeCourse td, #makeCourse th, #makeTime td, #makeTime th {
		border: 1px solid #ddd;
		height: 20px;
		padding-left: 10px;
	}
	#makeCourse th{
		height: 40px;
	}
	#searchCourse th, #makeCourse th, #makeTime th{background-color: #ddd;}
	
	#searchCourse caption, #makeCourse caption{
		text-indent: -9999px;
		height: 0;
	}
	#ttop{
		margin-top:10px;
		text-align: right;
	}
	
	#table{
		width:100%;
		border: 1px solid #EAEAEA;
		border-collapse: collapse;
		margin-top: 50px;

	}
	
	#table th,td{
		border-bottom : 1px solid #EAEAEA;
		padding:10px;
	}

	#table th{
		background-color: #D6F0FF;
	}
	
	div#box{
		display: inline-block;
		color: red;
		width: 300px;
		height: 20px;
		padding:0;
		margin:0;
		margin-left:6px;
		font-weight: bold; 
	
	}
	
	#table tfoot>tr:first-child td{
		
		color:blue;
		font-weight: bold;
		border-bottom: none;
		font-size: 15px;
		padding-top:10px;
	}
	
	#table thead tr{
		font-weight: bold;
		border-bottom: 1px solid black;
	}
	

	 #hd{
      background-color: #2e2e2e;
      color: #fff;
      width: 100%;
      margin: 0px auto;
      margin-bottom: 10px;
   }
   #t1{
      border-collapse: collapse;
      width: 600px;
      margin: auto;
   }
   
   #t1 td{
      border: 1px solid black;
      padding: 4px;
      height: 20px;
      text-align: center;
   }
   .num, .color{
      background-color: #D6F0FF;
   }
   #btn{
      display: inline-block;
      width: 100%;
      text-align: center;
      margin: 20px auto;
   }
   #btn>form>input{
      height: 40px;   
      border: none;
      width: 60px;
      font-size: 16px;
      color: #fff;
      border-radius: 3px;
   }
   #btn>form>input:first-child{
      background-color: #99ccff;
   }
   #btn>form>input:first-child:hover{
      background-color: #88bbee;
   }
   #btn>form>input:last-child{
      background-color: #c0c0c0;
   }
   #btn>form>input:last-child:hover{
      background-color: #d1d1d1;
   }

   #t1 {
      border-collapse: collapse;
      width: 100%;
      border-spacing: 0;
   }

   #t1 tbody{
       margin: 0;
        padding: 0;
        border: 1px solid black;
       text-align: center;
    }
     #t1 tfoot{
     	border: none;
    }
	#table_h2{
		background-color: black;
		color: white;
	}
	<!-- 교과목 수정,등록하는 CSS-->
	#subject_wrap{
		width: 100%;
		border: 1px solid red;
	}
	.subject_out{
		border-collapse: collapse;
		width: 100%;
	}
	.subject_out td, .subject_out th{
		height: 120px;
		border: 1px solid #ababab;
		text-align: center;
	}
	.subject_out th{
		background-color: #ededed;
	}
	.subject_out p{
		font-size: 20px;
	}
	.subject_out select{
		width: 60px;
		height: 25px;
	}
	.subject_out #innerTable{
		border-collapse: collapse;
		height: 100px;
		margin: auto;
	}
	.subject_out #innerTable td, .subject_out #innerTable th{
		height: 20px;
		border: 1px solid #ababab;
	}
	#subject_h2{
		background: black;
		color: white;
		width: 100%;
		height: 40px;
		line-height: 40px;
	}
	#btns button{
		height: 30px;
		
		border: 1px solid black;
		background:  #00acac;
		color: white;
		border: 1px solid #00acac;
		border-radius: 5px 5px;
	}
	#btns {
		width: 100%;
		margin-bottom: 20px;
		text-align: right;
	}

	#cf_h2{
		background: black;
		color: white;
		width: 100%;
		height: 40px;
		line-height: 40px;
		margin-bottom: 30px;
	}
	#cf_wrap{
		width: 100%;

	}
	#cf_table, #crf_table{
		border-collapse: collapse;
		width: 100%;
	}
	#cf_table td,#cf_table th, #crf_table td, #crf_table th{
		border: 1px solid #aaaaaa;
		height: 30px;
		line-height: 30px;
		text-align: center;
	}
	#cf_table thead, #crf_table thead{
		background-color: #dedede;
	}
	#cf_table tfoot td, #crf_table tfoot td{
		border: none;
		text-align: center;
		padding-top: 10px;
	}
	#crf_table tfoot td{
		border: 1px solid #2e2e2e;
		height: 30px;
	}
	
</style>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/header.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/center.css" />
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">

</head>
<body>
	<article id="wrap">
		<jsp:include page="${pageContext.request.contextPath }/WEB-INF/views/jsp/head.jsp"></jsp:include>

		<div id="center">
			<jsp:include page="./leftList.jsp"></jsp:include>
			<div class="right">

				<!--  여기서 표시될 테이블들 가지고오기 -->

					<div id="staffWrap">
						<div id="courseList_top">면접평가표리스트</div>
						<div id="ttop">
							<button type="button" onclick="setcr1()">평가표등록</button>	
						</div>
						<div id="counselReceipt_Table">
						
						</div>
					</div>
				</div>
			</div>
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
		$(function(){
			$.ajax({
				url: "counselReceiptMain",
				type: "post",
				data:"type="+encodeURIComponent("counselReceiptMain")+"&listSelect="+encodeURIComponent("1")+"&cPage="+encodeURIComponent('${param.cPage}')
			}).done(function(result){
				$("#counselReceipt_Table").html(result);
			});
			
			
			//$().removeClass("selected");
			$(".selected").removeClass("selected");
			$(".l_select").removeClass("l_selected");
			$("#firstmenu").addClass("selected");
			$("#l_first").addClass("l_select");
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

            $("#dialog").dialog("open",{
            	width:500,
            	height:600
            });
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

            $("#dialog2").dialog("open",{
            	width:500,
            	height:600
            });
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

            $("#dialog3").dialog("open",{
            	width:500,
            	height:600
            });
        }

		function setcr4() {
			$.ajax({
				url:"cr_dialog",
				type:"post",
				data:"&select="+encodeURIComponent("evaluationFactor")
			}).done(function(result){
				$("#dialog4").html(result);
				
				$("#cc_cancle").click(function(){
					 $("#dialog4").dialog("close");
				});
			});

            $("#dialog4").dialog("open",{
            	width:500,
            	height:600
            });
        }


		
		
		$( "#dialog" ).dialog({
            autoOpen: false,
            width:1000,
            modal: true,
            buttons: {
                "닫기": function() {
                    $( this ).dialog( "close" );
                }
            }
        });

		$( "#dialog2" ).dialog({
            autoOpen: false,
            width:1000,
            modal: true,
            buttons: {
                "닫기": function() {
                    $( this ).dialog( "close" );
                }
            }
        });
		$( "#dialog3" ).dialog({
            autoOpen: false,
            width:1000,
            modal: true,
            buttons: {
                "닫기": function() {
                    $( this ).dialog( "close" );
                }
            }
        });

		$( "#dialog4" ).dialog({
            autoOpen: false,
            width:1000,
            modal: true,
            buttons: {
                "닫기": function() {
                    $( this ).dialog( "close" );
                }
            }
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