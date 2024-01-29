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
		<div id="center">
			<jsp:include page="./leftList.jsp"></jsp:include>
			<div class="right">
				<!--  여기서 표시될 테이블들 가지고오기 -->
					
					<div id="counselWrap">
						<div id="counselList_top">일자별 상담관리</div>

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
		
		
		<div id="dialog" hidden="" title="교육생 상담일지">	
		</div>
		

		
	<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
	 <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
	<script>
		let select ="1";
		let select_year = "";
		let numPerPage = "";
		let value ="";
		$(function(){
			if('${value}' != null){
				$.ajax({
					url: "searchCounsel",
					type: "post",
					data:"type="+encodeURIComponent("searchCounsel")+"&select="+encodeURIComponent('2')+"&value="+encodeURIComponent('${value}')+"&year="+encodeURIComponent(select_year)
					+"&num="+encodeURIComponent(numPerPage)+"&listSelect="+encodeURIComponent('2')+"&cPage="+encodeURIComponent('${param.cPage}')
				}).done(function(result){
					$("#counsel_Table").html(result);
				});
			} else {

				$.ajax({
					url: "counselMain",
					type: "post",
					data:"type="+encodeURIComponent("searchCounsel")+"&listSelect="+encodeURIComponent("2")+"&cPage="+encodeURIComponent('${param.cPage}')
				}).done(function(result){
					$("#counsel_Table").html(result);
				});
			}
			
			
			//$().removeClass("selected");
			$(".selected").removeClass("selected");
			$(".l_select").removeClass("l_selected");
			$("#fourthmenu").addClass("selected");
			$("#l_second").addClass("l_select");
			
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
            value = $("#searchValue").val();
            if(value != null && value.trim().length > 0){

               $.ajax({
                  url: "searchCounsel",
                  type: "post",
                  data:"type="+encodeURIComponent("searchCounsel")+"&select="+encodeURIComponent(select)+"&value="+encodeURIComponent(value)+"&year="+encodeURIComponent(select_year)
                  +"&num="+encodeURIComponent(numPerPage)+"&listSelect="+encodeURIComponent("2")+"&cPage="+encodeURIComponent('${param.cPage}')
               }).done(function(result){
                  $("#counsel_Table").html(result);
               });
            } else {
               alert("검색어를 입력하세요");
               $('#searchValue').focus();
            }

         });   
			
			
			
			
		});
			

        function del(so_idx){
			if( confirm("삭제하시겠습니까?")){
                frm.action = "delCounsel";
                document.frm.so_idx.value =so_idx; 
                
                document.frm.submit();
			}
		}

		function paging(str) {
			select = $("#searchType").val();
         $.ajax({
            url: "searchCounsel",
            type: "post",
            data:"select="+encodeURIComponent(select)+"&value="+encodeURIComponent(value)+"&year="+encodeURIComponent(select_year)
               +"&num="+encodeURIComponent(numPerPage)+"&listSelect="+encodeURIComponent("2")+"&cPage="+encodeURIComponent(str),
         }).done(function(result){
            $("#counsel_Table").html(result);
         });
         
      }

	</script>
</body>
</html>