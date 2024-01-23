<%@page import="ictedu.util.LmsBean"%>
<%@page import="mybatis.vo.CourseVO"%>
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
	#courseList_top {
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
	
	#searchCourse td, #searchCourse th, #makeCourse td, #makeCourse th{
		border: 1px solid #ddd;
		height: 20px;
		padding-left: 10px;
	}
	#makeCourse th{
		height: 40px;
	}
	#searchCourse th, #makeCourse th{background-color: #ddd;}
	
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
</style>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/header.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/center.css" />
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">

</head>
<body>
	<article id="wrap">

		<jsp:include page="../../head.jsp"></jsp:include>

		<jsp:include page="${pageContext.request.contextPath }/WEB-INF/views/jsp/head.jsp"></jsp:include>

		<div id="center">
			<jsp:include page="./leftList.jsp"></jsp:include>
			<div class="right">
				<!--  여기서 표시될 테이블들 가지고오기 -->
					
					<div id="staffWrap">
						<div id="courseList_top">교육과정리스트</div>
						<div id="ttop">
							<button type="button" onclick="set()">과정등록</button>	
							<button type="button" onclick="set2()">과정타입수정</button>	
							<button type="button" onclick="set3()">강의실관리</button>	
						</div>
						<form>
							<table id="searchCourse">
							<caption>과정검색</caption>
								<thead>
									<tr>
										<th>검색</th>
										<td>
											<select id="numPerPage">
			
												<option value="5">표시개수</option>
												<option>5</option>
												<option>10</option>
												<option>15</option>
											</select>
											<select id="selectYear">
	
											</select>
										</td>
										<td>
											<select id="searchType">
												<option value="1">훈련강사</option>
												<option value="2">과정타입</option>
												<option value="3">강의실</option>
											</select>
											<input type="text" id="searchValue"/>
											<button type="button" id="search_bt">검 색</button>
										</td>
									</tr>
								</thead>
							</table>
						</form>
						<div id="courseLog_Table">
						
						</div>
					</div>
				</div>
			</div>
		</article>
		
		<form name="frm" action="course" method="post">
			<input type="hidden" name="type"  value=""/> 
			<input type="hidden" name="c_idx" value="" />
		</form>
		
		
		<div id="dialog" hidden="" title="교육과정등록">	
		</div>
		
		<div id="dialog2" hidden="" title="과정타입수정">
		</div>
		
		<div id="dialog3" hidden="" title="강의실관리">
		</div>
		
		<div id="dialog4" hidden="" title="과정수정">
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
				url: "Controller",
				type: "post",
				data:"type="+encodeURIComponent("courseMain")+"&listSelect="+encodeURIComponent("1")+"&cPage="+encodeURIComponent(${param.cPage})
			}).done(function(result){
				$("#courseLog_Table").html(result);
			});
			
			
			//$().removeClass("selected");
			$(".selected").removeClass("selected");
			$(".l_select").removeClass("l_selected");
			$("#secondmenu").addClass("selected");
			$("#l_first").addClass("l_select");
			
			let now = new Date();	// 현재 날짜 및 시간
			let year = now.getFullYear();
			let str = "<option>년도선택</option>";
			
			for(let i=year+1; i>year-5; i--){
				str+= "<option value="+i+">"+i+"</option>";
			}
			$("#selectYear").html(str);
			
			$("#searchType").on("change",function(){
				select = this.value;
			});
			$("#selectYear").on("change",function(){
				select_year = this.value;
				$.ajax({
					url: "Controller",
					type: "post",
					data:"type="+encodeURIComponent("searchCourse")+"&select="+encodeURIComponent(select)+"&value="+encodeURIComponent(value)+"&year="+encodeURIComponent(select_year)
						+"&num="+encodeURIComponent(numPerPage)+"&listSelect="+encodeURIComponent(${param.listSelect})+"&cPage="+encodeURIComponent(${param.cPage})
				}).done(function(result){
					$("#courseLog_Table").html(result);
				});
			});
			$("#numPerPage").on("change",function(){
				numPerPage = this.value;
				$.ajax({
					url: "Controller",
					type: "post",
					data:"type="+encodeURIComponent("searchCourse")+"&select="+encodeURIComponent(select)+"&value="+encodeURIComponent(value)+"&year="+encodeURIComponent(select_year)
						+"&num="+encodeURIComponent(numPerPage)+"&listSelect="+encodeURIComponent(${param.listSelect})+"&cPage="+encodeURIComponent(${param.cPage})
				}).done(function(result){
					$("#courseLog_Table").html(result);
				});
			});
			
			$("#search_bt").click(function(){
				let value = $("#searchValue").val();
				
				$.ajax({
					url: "Controller",
					type: "post",
					data:"type="+encodeURIComponent("searchCourse")+"&select="+encodeURIComponent(select)+"&value="+encodeURIComponent(value)+"&year="+encodeURIComponent(select_year)
						+"&num="+encodeURIComponent(numPerPage)+"&listSelect="+encodeURIComponent(${param.listSelect})+"&cPage="+encodeURIComponent(${param.cPage})
				}).done(function(result){
					$("#courseLog_Table").html(result);
				});
			});	
			
			
			
			
		});
		
		function set() {
			$.ajax({
				url:"Controller",
				type:"post",
				data:"type="+encodeURIComponent("c_dialog")+"&select="+encodeURIComponent("addCourse")
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
		function set2() {
			$.ajax({
				url:"Controller",
				type:"post",
				data:"type="+encodeURIComponent("c_dialog")+"&select="+encodeURIComponent("addCourseType")
			}).done(function(result){
				$("#dialog2").html(result);
				$(".ccol").on("change input", function() {
		             $(this).prev().val("");
		             $(this).prev().val($(this).val());
		   		});
				
				$("#cancel").click(function(){
					 $("#dialog2").dialog( "close" );
				});
			});
			
            $("#dialog2").dialog("open");
        }
		function set3() {
            $("#dialog3").dialog("open");
            
            $.ajax({
				url:"Controller",
				type:"post",
				data:"type="+encodeURIComponent("c_dialog")+"&select="+encodeURIComponent("addRoom")
			}).done(function(result){
				$("#dialog3").html(result);
				
				$("#cl").click(function(){
					 room_length = 7;
					 $("#dialog3").dialog( "close" );
				});
				
				$(".ui-dialog-titlebar-close").click(function(){
					 room_length = 7;
					 $("#dialog3").dialog( "close" );
				});

			});
        }
		function editC(c_idx){
			 $.ajax({
					url:"Controller",
					type:"post",
					data:"type="+encodeURIComponent("editCourse")+"&c_idx="+c_idx
				}).done(function(result){
					$("#dialog4").html(result);
					
					$("#cancel4").click(function(){
						 $("#dialog4").dialog( "close" );
				});
			});
			$("#dialog4").dialog("open");	
        }

		$( "#dialog" ).dialog({
            autoOpen: false,
            width:1200,
            modal: true,
            buttons: {
                "닫기": function() {
                    $( this ).dialog( "close" );
                }
            }
        });
		
		$( "#dialog2" ).dialog({
            autoOpen: false,
            width: 1200,
            modal: true,
            buttons: {
                "닫기": function() {
                    $( this ).dialog( "close" );
                }
            }
        });
		$( "#dialog3" ).dialog({
            autoOpen: false,
            width: 700,
            modal: true,
            buttons: {
                "닫기": function() {
                    $( this ).dialog( "close" );
					room_length = 7;
                }
            }
        });
		
		$( "#dialog4" ).dialog({
            autoOpen: false,
            width: 1200,
            modal: true,
            buttons: {
                "닫기": function() {
                    $( this ).dialog( "close" );
                }
            }
        });

		function del(c_idx){
			if( confirm("삭제하시겠습니까?")){
			frm.action = "Controller?type=delCourse";
			document.frm.c_idx.value =c_idx; 
			
			document.frm.submit();
			}
		}
		
		function paging(str) {
			$.ajax({
				url: "Controller",
				type: "post",
				data:"type="+encodeURIComponent("searchCourse")+"&select="+encodeURIComponent(select)+"&value="+encodeURIComponent(value)+"&year="+encodeURIComponent(select_year)
					+"&num="+encodeURIComponent(numPerPage)+"&listSelect="+encodeURIComponent(${param.listSelect})+"&cPage="+encodeURIComponent(str),
			}).done(function(result){
				$("#courseLog_Table").html(result);
			});
		}
		function addRoom() {
			room_length +=1;
			let str = $("#addRoom_tbody").html();
			let str2="<tr><td><strong>"+room_length+"</strong><br/><button type='button'>삭제</button> </td> <td><input type='text' name='className'> </td> <td> <select name='roomSep'>"+
			"<option value='1' selected>실습</option> <option value='2'>이론</option><option value='3'>겸용</option></select>"+
			"</td><td>  <select name='use'><option value='1' selected>사용</option><option value='0' >미사용</option></select></td> </tr>" ;
			
			$("#addRoom_tbody").html(str+str2);
		}
		
		function addCourse(frm) {
		    frm.action= "Controller?type=editCourse&edit=ok";
		    frm.submit();
		}
	</script>
</body>
</html>