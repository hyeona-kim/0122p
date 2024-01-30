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
	#counselReceipt_Table{
		width: 100%;
		height: 600px;
		background-color: #ededed;
	}
	#counselReceipt_Table article:first-child{
		margin: auto;
		width: 98%;
		height: 10%;
		text-align: right;
		line-height: 60px;
	}
	.btn{
		background-color: #00acac;
		border: 1px solid #00acac;
		color: white;
		padding: 7px;
		border-radius: 5px 5px;
		font-weight: bold;
	}
	#counselReceipt_Table article:last-child{
		margin: auto;
		height: 80%;
		width: 98%;
		background-color: white;
	}
	#counselReceipt_Table #exel_d{
		width: 100%;
		height: 400px;
	}
	#counselReceipt_Table #exel_t{
		width: 100%;
		height: 90px;
		border-collapse: collapse;
		margin: auto;
	}
	#counselReceipt_Table #exel_t th,#counselReceipt_Table #exel_t td{
		border: 1px solid #dedede;
	}
	#counselReceipt_Table #exel_t th{
		background-color: #dedede;
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
                            <strong>&nbsp;&nbsp;&nbsp;수강생 등록</strong>
                        </div>
						<div id="counselReceipt_Table">
                            <!--과정에 대한 정보 가져오기 -->
							<article>
								<button class="btn" id="exelDown_btn">수강생데이터입력샘플EXCEL</button>
							</article>
							<article>
								<div id="exel_d">
									<table id="exel_t">
										<colgroup>
											<col width="30%"/>
											<col width="70%"/>
										</colgroup>
										<tr>
											<th>
												수강생일괄등록
											</th>
											<td >
												<input type="file" name="t_file" style="border: 1px solid #ababab;"/><br/><br/>
												<input type="button" class="btn" id="submit_btn" value="등록"/>
											</td>
										</tr>
									</table>
									<div>[파일 등록 시 아래사항들을 다시한번 확인해주세요!]</div>
									<br/><br/>
									<div>
										*필수입력사항:성함,연락처,훈련과정명(코드값),수강상태<br/>
										*훈련과정명(코드값)은 과정등록에 있는 과정코드값을 입력해야합니다, 과정명을 입력하면 저장되지 않습니다.<br/>
										*수강상태는 수강,수료,조기수료,미수료,제적 중에 하나를 택하여 정확히 입력해주세요.<br/>
										*카드유형을 취성패1,취성패2,국가취업지원제도1,국가취업지원제도2,내일배움카드(실업자),근로자카드,일반(근로복지공단),일반,일반(기타)중에 하나를 입력해주세요<br/>
										*전체교육비가 없을경우 0을 입력합니다.<br/>
										*주민번호,전화,우편번호,주소,상담메모,카드유형은 필수 입력값이 아니며 내용이 없으면 공란으로 작성해주세요.<br/>
										*이외에 입력할 내용은 등록 후 수정바라며, 파일 업로드시 참고사항내용은 삭제 후 업로드 바랍니다.<br/>
										*파일형식은 97-2003파일형식으로 저장하셔야 합니다.<br/>
									</div>
								</div>
							</article>
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
			$("#l_five").addClass("l_select");
			$("#submit_btn").click(function(){
				console.log("저장버튼클릭");
			});
            $("#exelDown_btn").click(function(){
				console.log("엑셀파일 다운로드");
			});
		});


	</script>
</body>
</html>