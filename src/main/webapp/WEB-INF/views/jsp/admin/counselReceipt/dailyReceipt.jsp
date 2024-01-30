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

    #ttop{
        margin: auto;
        width: 95%;
        height: 220px;
        position: relative;
    }
    #ttop #t1{
        position: absolute;
        left: 0px;
        top:10px;
        width: 50%;
        height: 110px;
        text-align: left;
    }
    #ttop #t2{
        position: absolute;
        left: 3px;
        bottom:9px;
        width: 50%;
        height: 110px;
        text-align: left;
    }
    #ttop #t2 #top_table{
        border-collapse: collapse;
    }
    #ttop #t2 #top_table th,#ttop #t2 #top_table td{
        border: 1px solid #ababab;
    }
    #ttop #t2 #top_table th{
        background-color: #dedede;
        padding: 3px;
    }
    #ttop #t3{
        position: absolute;
        right: 10px;
        top:10px;
        width: 50%;
        height: 110px;
        text-align: right;
    }
    #ttop #t4{
        position: absolute;
        right: 0px;
        bottom:0;
        width: 50%;
        height: 110px;
        text-align: right;
        
    }
    #ttop #t4 #right_table{
        border: 1px solid blue;
        position: absolute;
        right: 0px;
        bottom:0;
        height: 90px;
        border-collapse: collapse;
    }
    #ttop #t4 #right_table td{
        border: 1px solid #ababab;
    }
    #ttop #t4 #right_table tr:first-child{
        height: 30%;
    }
    #ttop #t4 #right_table tr:last-child{
        height: 70%;
    }
    #reg_table{
        width: 100%;
        border-collapse: collapse;
        margin-top: 30px;
    }
    #reg_table td{
        border: 1px solid #ababab;
    }
    #reg_table thead tr{
        background-color: #dedede;
    }
    #reg_table tbody td:nth-child(12){
        background-color: orange;
    }
    #reg_table tbody td:nth-child(16){
        background-color: lightcoral;
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
						<div id="courseList_top">
                            <!--자바스크립트 -->
                        </div>
						<div id="ttop">
                            <div id="t1">
                                검색
                                <select name="">
                                    <option value="0">전체</option>
                                    <option value="1">모집중</option>
                                    <option value="2">교육중</option>
                                </select>
                            </div>

                            <article id="t2">
                                <span>접수기준일: 당일0시~ 당일 24시까지</span>
                                <table id="top_table">
                                    <tr>
                                        <th rowspan="4">접수현황</th>
                                        <th colspan="5">일일 접수 현황</th>
                                        <th colspan="5">일일 문의 현황</th>
                                    </tr>
                                    <tr>
                                        <th>총계</th>
                                        <th>국가기간</th>
                                        <th>국민내일배움카드</th>
                                        <th>일반과정</th>
                                        <th>KDT</th>
                                        <th>총계</th>
                                        <th>국가기간</th>
                                        <th>국민내일배움카드</th>
                                        <th>일반과정</th>
                                        <th>KDT</th>
                                    </tr>
                                    <tr>
                                        <td>0</td>
                                        <td>0</td>
                                        <td>0</td>
                                        <td>0</td>
                                        <td>0</td>
                                        <td>0</td>
                                        <td>0</td>
                                        <td>0</td>
                                        <td>0</td>
                                        <td>0</td>
                                    </tr>
                                </table>
                            </article>
                    
                            <div id="t3">
                                <a href=""><img alt="인쇄" src=""/></a>
                                <a href=""><img alt="액셀다운" src=""/></a>
                            </div>
                            <article id="t4">
                                <span id="nowDate"></span>
                                <table id="right_table">
                                    <tr>
                                        <td rowspan="2">결재</td>
                                        <td>담당</td>
                                        <td>부장</td>
                                        <td>원장</td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                    </tr>
                                </table>
                            </article>
						</div>
						<div id="counselReceipt_Table">
                            <!--과정에 대한 정보 가져오기 -->
						</div>
					</div>
				</div>
			</div>
		</article>
		

		
	<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
	 <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>

	<script>
		$(function(){
            let now = new Date();	
            let year = now.getFullYear();   
            $("#courseList_top").html("<strong>&nbsp;&nbsp;"+year+"년 일일모집현황</strong>");
            $("#nowDate").html("Date:"+now.getFullYear()+"/"+now.getMonth()+"/"+now.getDate());
            
			$.ajax({
				url: "dailyReceipt",
				type: "post",
				data:"year="+year+"&selectList=3"
			}).done(function(result){
				$("#counselReceipt_Table").html(result);
			});
			
			
			//$().removeClass("selected");
			$(".selected").removeClass("selected");
			$(".l_select").removeClass("l_selected");
			$("#firstmenu").addClass("selected");
			$("#l_third").addClass("l_select");
		});


	</script>
</body>
</html>