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
    #search_top{
        height: 80px;
    }
    #search_top article{
        height: 30px;
        line-height: 30px;
        margin-top: 30px;
        position: relative;
    }
    #search_top article a{
        position: absolute;
        right: 5px;
    }
    .search_area{
        height: 20px;
        border: 1px solid #ababab;
    }
    .btn{
		background-color: #00acac;
		border: 1px solid #00acac;
		color: white;
		padding: 5px;
		border-radius: 5px 5px;
		font-weight: bold;
	}
    #select_top{
        margin-top: 20px;
        height: 150px;
    }
    #select_top #select_table{
        width: 100%;
        border-collapse: collapse;
    }
    #select_top #select_table td,#select_top #select_table th{
        border: 1px solid #ababab;
        height: 120px;
    }
    #select_top #select_table th{
        background-color: #dedede;
    }
    .chk{
        display: inline-block;
        height: 50px;
        width: 130px;
        line-height: 50px;
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
						<div id="search_top">
                            <!--검색을 위한 영역-->
                            <article>
                                표시개수:
                                <select class="search_area" style="width: 60px;">
                                    <option>5</option>
                                    <option>10</option>
                                    <option>15</option>
                                </select>
                                검색:
                                <select class="search_area" style="width: 80px;">
                                    <option>년도선택</option>
                                    <option>2025</option>
                                    <option>2024</option>
                                </select>
                                <select class="search_area" style="width: 120px;">
                                    <option>타입검색</option>
                                    <option>2025</option>
                                    <option>2024</option>
                                </select>
                                <select class="search_area" style="width: 500px;">
                                    <option>과정검색</option>
                                    <option>2025</option>
                                    <option>2024</option>
                                </select>
                                <select class="search_area" style="width: 80px;">
                                    <option>이름</option>
                                    <option>2025</option>
                                    <option>2024</option>
                                </select>
                                <input type="text" style="width: 120px;"/>
                                <input type="button" class="btn" value="검색" id="search_btn"/>
                                <a href="" ><img src="" alt="문서이미지"/></a>
                            </article>
                        </div>
						<div id="select_top">
                            <table id="select_table">
                            <colgroup>
                                <col width="20%"/>
                                <col width="*"/>
                                <col width="10%"/>
                            </colgroup>
                                <tr>
                                    <th>검색</th>
                                    <td>
                                        <span class="chk"><input type="checkbox" name="chk1"/>이름</span>
                                        <span class="chk"><input type="checkbox" name="chk1"/>주민번호</span>
                                        <span class="chk"><input type="checkbox" name="chk1"/>핸드폰</span>
                                        <span class="chk"><input type="checkbox" name="chk1"/>전화</span>
                                        <span class="chk"><input type="checkbox" name="chk1"/>과정</span>
                                        <span class="chk"><input type="checkbox" name="chk1"/>결재일</span>
                                        <span class="chk"><input type="checkbox" name="chk1"/>지원경로</span>
                                        <span class="chk"><input type="checkbox" name="chk1"/>개강일</span>
                                        <br/>
                                        <span class="chk"><input type="checkbox" name="chk1"/>HRD등록일</span>
                                        <span class="chk"><input type="checkbox" name="chk1"/>현재상태</span>
                                        <span class="chk"><input type="checkbox" name="chk1"/>제적일</span>
                                        <span class="chk"><input type="checkbox" name="chk1"/>제적사유</span>
                                        <span class="chk"><input type="checkbox" name="chk1"/>수료일</span>
                                        <span class="chk"><input type="checkbox" name="chk1"/>전체교육비</span>
                                        <span class="chk"><input type="checkbox" name="chk1"/>카드유형</span>
                                        <span class="chk"><input type="checkbox" name="chk1"/>우편번호</span>
                                        <br/>
                                        <span class="chk"><input type="checkbox" name="chk1"/>주소</span>
                                        <span class="chk"><input type="checkbox" name="chk1"/>메모</span>
                                        <span class="chk"><input type="checkbox" name="chk1"/>이전직장명</span>
                                        <span class="chk"><input type="checkbox" name="chk1"/>학생코드</span>
                                        <span class="chk"><input type="checkbox" name="chk1"/>과정타입</span>
                                    </td>
                                    <td>
                                        <input type="button" class="btn" id="check_btn" value="검색"/>
                                        <br/>
                                        <br/>
                                    </td>
                                </tr>
                            </table>
						</div>
						<div id="traineeReceipt_Table">
                            <!--훈련생에대한 정보 가져오기 -->
						</div>
					</div>
				</div>
			</div>
		</article>
		

		
	<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
	 <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>

	<script>
		$(function(){
			//$().removeClass("selected");
			$(".selected").removeClass("selected");
			$(".l_select").removeClass("l_selected");
			$("#firstmenu").addClass("selected");
			$("#l_third").addClass("l_select");
            
            $("#check_btn").click(function(){
                console.log("체크박스 검색");
            });
            $("#search_btn").click(function(){
                console.log("검색어 검색");
            });
            
		});


	</script>
</body>
</html>