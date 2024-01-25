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

	#counselWrap{
		width: 95%;
		margin: auto;
		margin-top: 20px;
	}
	#counselList_top {
		background: black;
		color: white;
		height: 40px;
		line-height: 40px;
	}
	
	#searchCounsel, #makeCounsel{
		margin-top:10px;
		border-collapse: collapse;
		width: 100%;
	}
	
	#searchCounsel td, #searchCounsel th, #makeCounsel td, #makeCounsel th{
		border: 1px solid #ddd;
		height: 20px;
		padding-left: 10px;
	}
    #makeCounsel {text-align: center;}
	#makeCounsel th{
		height: 40px;
	}
    #peo_num{
        font-weight: bold;
        color: #0000ff;
    }
	#searchCounsel th, #makeCounsel th{background-color: #ddd;}
	
	#searchCounsel caption, #makeCounsel caption{
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
    .t1 th, .t1 td {
	 	margin: 0;
        padding: 0;
        border: 1px solid black;
        text-align: center;
		height: 40px;


    }
	.t1 td input{
		width: 85%;
		border: 1px solid #dedede;
		height: 30px;
	}
	.t1 th{
		background-color: lightblue;
	}
    .t1 {
		border-collapse: collapse;
		width: 100%;
		border-spacing: 0;
	}
	#add_top{
		width: 100%;
		margin-bottom: 20px;
	}
	.t1 tbody td{
		border: none;
	}
	.t1 tbody td{
		padding-top: 20px;
	}
	#add_h2{
		background-color: black;
		color: white;
		height: 35px;
		line-height: 35px;
		padding-left: 20px;
	}
	
</style>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/header.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/center.css" />
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">

</head>
<body>
	<article id="wrap">

		<jsp:include page="../../head.jsp"></jsp:include>
		<div id="center">
			<jsp:include page="./leftList.jsp"></jsp:include>
			<div class="right">
				<!--  여기서 표시될 테이블들 가지고오기 -->
					
					<div id="counselWrap">
						<div id="counselList_top">상담 관리</div>
						<div id="ttop">
							<button type="button" onclick="set()">상담파일등록</button>	
							<button type="button" onclick="downloadFile()">상담파일등록 샘플</button>
						</div>
						<form>
							<table id="searchCounsel">
							<caption>상담검색</caption>
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
												<option value="1">상담사</option>
												<option value="2">상담일</option>
												<option value="3">과정명</option>
												<option value="4">훈련생</option>
											</select>
											<input type="text" id="searchValue"/>
											<button type="button" id="search_bt">검 색</button>
										</td>
									</tr>
								</thead>
							</table>
						</form>
						<div id="counsel_Table">
						
						</div>
					</div>
				</div>
			</div>
		</article>
		
		<form name="frm" action="counsel" method="post">
			<input type="hidden" name="type"  value=""/> 
			<input type="hidden" name="so_idx" value="" />
		</form>
		
		
		<div id="dialog" hidden="" title="상담파일등록">	
		</div>
		
		<div id="dialog2" hidden="" title="상담결과보고">
		</div>
        
        <div id="dialog3" hidden="" title="상담결과보고">
		</div>
		
	<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
	 <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
	<script>
		let select ="";
		let select_year = "";
		let numPerPage = "";
		let value ="";
		$(function(){
			$.ajax({
				url: "counselMain",
				type: "post",
				data:"type="+encodeURIComponent("counselMain")+"&listSelect="+encodeURIComponent("1")+"&cPage="+encodeURIComponent('${param.cPage}')
			}).done(function(result){
				$("#counsel_Table").html(result);
			});
			
			
			//$().removeClass("selected");
			$(".selected").removeClass("selected");
			$(".l_select").removeClass("l_selected");
			$("#fourthmenu").addClass("selected");
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
					url: "searchCounsel",
					type: "post",
					data:"type="+encodeURIComponent("searchCounsel")+"&select="+encodeURIComponent(select)+"&value="+encodeURIComponent(value)+"&year="+encodeURIComponent(select_year)
						+"&num="+encodeURIComponent(numPerPage)+"&listSelect="+encodeURIComponent('${param.listSelect}')+"&cPage="+encodeURIComponent('${param.cPage}')
				}).done(function(result){
					$("counsel_Table").html(result);
				});
			});
			$("#numPerPage").on("change",function(){
				numPerPage = this.value;
				$.ajax({
					url: "searchCounsel",
					type: "post",
					data:"type="+encodeURIComponent("searchCounsel")+"&select="+encodeURIComponent(select)+"&value="+encodeURIComponent(value)+"&year="+encodeURIComponent(select_year)
						+"&num="+encodeURIComponent(numPerPage)+"&listSelect="+encodeURIComponent('${param.listSelect}')+"&cPage="+encodeURIComponent('${param.cPage}')
				}).done(function(result){
					$("#counsel_Table").html(result);
				});
			});
			
			$("#search_bt").click(function(){
				let value = $("#searchValue").val();
				
				$.ajax({
					url: "searchCounsel",
					type: "post",
					data:"type="+encodeURIComponent("searchCounsel")+"&select="+encodeURIComponent(select)+"&value="+encodeURIComponent(value)+"&year="+encodeURIComponent(select_year)
						+"&num="+encodeURIComponent(numPerPage)+"&listSelect="+encodeURIComponent('${param.listSelect}')+"&cPage="+encodeURIComponent('${param.cPage}')
				}).done(function(result){
					$("#counsel_Table").html(result);
				});
			});	
			
			
			
			
		});
		
		function set() {
			$.ajax({
				url:"addCounselFile",
				type:"post",
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
		function set2(c_idx) {
			$.ajax({
				url:"counselAddMain",
				type:"post",
				data:"type="+encodeURIComponent("ss_dialog")+"&select="+encodeURIComponent("counselAddMain")+"&c_idx="+c_idx,
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

        function counselA(c_idx){
            $("#dialog2").dialog("close");
            $.ajax({
                url:"counselA",
                type:"post",
                data:"type="+encodeURIComponent("ss_dialog")+"&select="+encodeURIComponent("counselA")+"&c_idx="+c_idx,
            }).done(function(result){
				$("#dialog3").html(result);
				
				$("#cc_close").click(function(){
					 $("#dialog3").dialog("close");
				});
			});
            $("#dialog3").dialog("open");
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
            width:1200,
            modal: true,
            buttons: {
                "닫기": function() {
                    $( this ).dialog( "close" );
                }
            }
        });

		function paging(str) {
			$.ajax({
				url: "searchCounsel",
				type: "post",
				data:"type="+encodeURIComponent("searchCounsel")+"&select="+encodeURIComponent(select)+"&value="+encodeURIComponent(value)+"&year="+encodeURIComponent(select_year)
					+"&num="+encodeURIComponent(numPerPage)+"&listSelect="+encodeURIComponent('${param.listSelect}')+"&cPage="+encodeURIComponent(str),
			}).done(function(result){
				$("#counsel_Table").html(result);
			});
			
		}
		function close(){
		location.href="councel?listSelect=1&cPage=1";

	}
	</script>
</body>
</html>