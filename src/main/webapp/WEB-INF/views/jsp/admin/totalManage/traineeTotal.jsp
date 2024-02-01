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
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
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
	#staffList_top {
		background: black;
		color: white;
		height: 40px;
		line-height: 40px;
        font-weight: bold;
        font-size: 20px;
	}
    #search_t{
        width: 100%;
        height: 35px;
        margin-top: 20px;
    }
    #search_t caption{
        height: 0;
        text-indent: -9999px;
    }
	#e_table{
		width:100%;
		border-collapse: collapse;
	}
	#e_table td, #e_table th{
		border: 1px solid #ababab;
		padding: 5px;
	}
	#e_h2{
		height: 35px;
		background-color: black;
		color: white;
		font-size: 20px;
		line-height: 35px;
	}
	#e_div{
		height: 20px;
		line-height: 20px;
		font-size: 11px;
		color: red;
	}
	#before, #after{
		display: inline-block;
		width: 25px;
		height: 25px;
		line-height: 20px;
		border-radius: 12px 12px;
		color: white;
		font-weight: bold;
	}
	#before{
		margin-right: 20px;
		background-color:darkgray;
	}
	#after{
		background-color:aquamarine;
	}
    .man{color: #032c94;}
    .woman{color: #ed091c;}
    .giveup{color:  #fcb60b;}
    .employ{color: #4e8ede;}
    .finish{color: #df6c69;}
    .none{color: #c3db94;}
    .weeding{color: #76c2c3;}
    
    .btn{
        padding:5px 11px;
        border-radius: 3px 3px;
        border: none;
        color: white;
        background-color: #00acac;
        margin-left: 2px;
    }
    #btn_area .btn:first-child{
        background-color: #348fe2;
    }
    
    #btn_area .btn:nth-child(7),#btn_area .btn:nth-child(8){
        background-color: #e5e5e5;
        
        
    }
    #btn_area .btn:nth-child(6){
        background-color: #f59c1a;
    }

    #btn_area{
        width: 100%;
        margin-top: 20px;
        text-align: center;
    }
    .search_tag{
        height: 25px;
    }
    .tr_ul{
        display: flex;
    }
    .tr_li{
        list-style-type: none;
        display: inline-flex;
        width: 220px;
        height: 65px;
    }

    .tr_li .l_div{
        display: inline-block;
        width: 64px;
        height: 65px;
        margin: 0;
    }
    .tr_li .info{
        display: inline-block;
        border: 1px solid #ababab;
        height: 63px;
        width: 140px;
        margin: 0;
        border-bottom: none;
    }
    .tr_li .info div{
        display: inline-block;
        width: 100%;
        height: 49%;
        border-bottom: 1px solid #ababab;
    }
    .tr_select{
        background-color: #999999;
        color: white;
        border: none;
    }
    .t1{
        border-collapse: collapse;
        width: 100%;
        margin-bottom: 20px;
    }
    .t1 td,.t1 th{
        border: 1px solid #ababab;
        text-align:center;
    }
    .t1 th{
        background-color: #dedede;
    }
    .t1 tfoot td,.t1 tfoot th{
        border: none;
    }

    #staffWrap{
		width: 95%;
		margin: auto;
		margin-top: 20px;
	}
	#staffList_top {
		background: black;
		color: white;
		height: 40px;
		line-height: 40px;
	}
	
	#searchTime, #makeTime{
		margin-top:10px;
		border-collapse: collapse;
		width: 100%;
	}
	#searchTime td, #searchTime th, #makeTime td, #makeTime th{
		border: 1px solid #ddd;
		height: 40px;
		padding-left: 10px;
	}
	#searchTime th, #makeTime th{background-color: #EBF7FF;}
	
	#searchTime caption, #makeTime caption{
		text-indent: -9999px;
		height: 0;
	}
	.ck.ck-editor {
    	max-width: 100%;
    	padding: 8px;
    	
	}
	.ck-editor__editable {
	    min-height: 300px;
	}
	
	#t2{
		margin-top:10px;
		border-collapse: collapse;
		width: 99%;
		margin-bottom: 10px;
	}
	
	#t2 th{
	width: 100px;
	background-color: #EBF7FF;
	
	}
</style>

</head>
<c:if test="${tvo eq null }">
<body>
	<article id="wrap">
		<jsp:include page="${pageContext.request.contextPath }/WEB-INF/views/jsp/head.jsp"></jsp:include>
		<div id="center">
			<jsp:include page="./leftList.jsp"></jsp:include>
			<div class="right">
				<div id="staffWrap">
					<article>
						<div id="staffList_top">&nbsp;&nbsp;과정별 학생관리 현황</div>
						<table id="search_t">
						<caption>과정 선택및 검색</caption>
                        <colgroup>
                            <col width=""/>
                        </colgroup>
							<thead>
								<tr>
									<td>훈련과정:
										<select id="searchCourse" style="width: 600px;" class="search_tag">
                                            <option value="0">-과정을 선택해주세요-</option>
                                            <c:forEach var="cvo" items="${c_ar}">
                                                <option value="${cvo.c_idx}">${cvo.c_name}(${cvo.start_date}~${cvo.end_date})</option>
                                            </c:forEach>
										</select>
										<select id="searchType" class="search_tag">
											<option value="0">훈련생명</option>
										</select>
										<input type="text" id="searchValue" class="search_tag"/>
										<button type="button" id="search_bt" class="btn">검색</button>
									</td>
								</tr>
							</thead>
						</table>
                        <hr/>
						<div id="courseLog_Table">
							<span class="man">●</span>남자 
                            <span class="woman">●</span>여자 
                            <span class="giveup">■</span>수강포기
                            <span class="employ">■</span>조기취업
                            <span class="finish">■</span>조기수료
                            <span class="none">■</span>미수료
                            <span class="weeding">■</span>제적
                            <div align="right">
                                <button type="button" class="btn">훈련생종합성적표</button> 
                                <button type="button" class="btn">능력단위분석표</button> 
                                <button type="button" class="btn">편지비교표</button> 
                            </div>
						</div>
                        <div id="btn_area">
                            <button type="button" class="btn" id="traineeEdit" >정보변경</button> 
                            <button type="button" class="btn">신상기록부</button> 
                            <button type="button" class="btn">사후관리카드</button> 
                            <button type="button" class="btn">사후관리취업지원</button> 
                            <button type="button" class="btn" id ="ss_dialog">상담관리</button> 
                            <button type="button" class="btn">설문관리</button> 
                            <button type="button" class="btn">사전평가</button> 
                            <button type="button" class="btn">성적표</button> 
                        </div>
					</article>
				</div>
			</div>	
		</div>
		<div id="dialog" hidden title="훈련생별상담관리"></div>
		<div id="dialog2" hidden title="훈련생별상담등록"></div>
		<div id="dialog3" hidden title="상담일지"></div>
		<div id="dialog4" hidden title="정보수정"></div>
        <form name="frm" action="counsel" method="post">
			<input type="hidden" name="type"  value=""/> 
			<input type="hidden" name="so_idx" value="" />
            <input type="hidden" name="total" value="total"/>
            <input type="hidden" name="c_idx" value=""/>
		</form>
		
	</article>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
	<script>
        
	let selectTr=""; //훈련생
    let selectCourse="";
    let searchType ="";
    let searchValue ="";
	$(function() {
        $("#searchCourse").change(function(){
            selectCourse =this.value;
            $.ajax({
                url: "traineeTotal",
                type: "post",
                data:"listSelect="+encodeURIComponent("2")+"&c_idx="+selectCourse+"&select="+searchType+"&value="+searchValue
            }).done(function(result){
                let html = "<span class='man'>●</span>남자 "+
                            "<span class='woman'>●</span>여자 "+
                            "<span class='giveup'>■</span>수강포기"+
                            "<span class='employ'>■</span>조기취업"+ 
                            "<span class='finish'>■</span>조기수료"+
                            "<span class='none'>■</span>미수료"+ 
                            "<span class='weeding'>■</span>제적"+
                            "<div align='right'><button type='button' class='btn'>훈련생종합성적표</button>"+ 
                            "<button type='button' class='btn'>능력단위분석표</button> "+
                            "<button type='button' class='btn'>편지비교표</button></div>" ;
                $("#courseLog_Table").html(html+result);
            });
        });
		
        $("#search_bt").click(function(){
            searchType =$("#searchType").val();
            searchValue =$("#searchValue").val();
            $.ajax({
                url: "traineeTotal",
                type: "post",
                data:"listSelect="+encodeURIComponent("2")+"&c_idx="+selectCourse+"&select="+searchType+"&value="+searchValue
            }).done(function(result){
                let html = "<span class='man'>●</span>남자 "+
                            "<span class='woman'>●</span>여자 "+
                            "<span class='giveup'>■</span>수강포기"+
                            "<span class='employ'>■</span>조기취업"+ 
                            "<span class='finish'>■</span>조기수료"+
                            "<span class='none'>■</span>미수료"+ 
                            "<span class='weeding'>■</span>제적"+
                            "<div align='right'><button type='button' class='btn'>훈련생종합성적표</button>"+ 
                            "<button type='button' class='btn'>능력단위분석표</button> "+
                            "<button type='button' class='btn'>편지비교표</button></div>" ;
                $("#courseLog_Table").html(html+result);
            });
   
        });


        	
        $("#ss_dialog").click(function(){
            $("#dialog").dialog("open");
            
            $.ajax({
                url: "ss_dialog",
                type: "post",
                data:"listSelect="+encodeURIComponent("2")+"&c_idx="+selectCourse+"&tr_idx="+selectTr+"&select=counselList"
            }).done(function(result){
              $("#dialog").html(result);
              $("#cc_cancle").click(function(){
                    $("#dialog").dialog("close");
                });
            
            });
   
        });

        $("#traineeEdit").click(function(){
            $("#dialog4").dialog("open");
            
            $.ajax({
                url: "totaledit",
                type: "post",
                data:"listSelect="+encodeURIComponent("2")+"&c_idx="+selectCourse+"&tr_idx="+selectTr
            }).done(function(result){
              $("#dialog4").html(result);
              $("#cc_cancle").click(function(){
                    $("#dialog4").dialog("close");
                });
            
            });
   
        });
       
        
		//$().removeClass("selected");
		$(".selected").removeClass("selected");
		$(".l_select").removeClass("l_selected");
		$("#thirteenmenu").addClass("selected");
		$("#l_second").addClass("l_select");
		
		
	});

	$("#dialog").dialog({
        autoOpen: false,
		width:1000,
		modal: true,
    });
    

    $("#dialog2").dialog({
        autoOpen: false,
		width:1000,
		modal: true,
    });

    $("#dialog3").dialog({
        autoOpen: false,
		width:1000,
		modal: true,
    });
    $("#dialog4").dialog({
        autoOpen: false,
		width:1000,
		modal: true,
    });
    function traineeSelect(tr_idx,tt){
        selectTr =tr_idx;
        $(".tr_select").removeClass("tr_select");
        tt.setAttribute('class','info tr_select');
    }

    function counselListAdd() {
         $.ajax({
            url:"ss_dialog",
            type:"post",
            data:"&select="+encodeURIComponent("counselListAdd")+"&c_idx="+selectCourse+"&tr_idx="+encodeURIComponent(selectTr)+"&total=total",
         }).done(function(result){
         $("#dialog2").dialog("open");
            $("#dialog2").html(result);
            
            $("#close").click(function(){
                $("#dialog2").dialog("close");
            });
         });
        }
        function total_add(frm){
            frm.total.value="total";
            frm.submit();
        }

        function update(frm){
            frm.total.value ="total";
            frm.submit();
        }


        function editCounsel(so_idx) {
            $.ajax({
                url:"ss_dialog",
                type:"post",
                data:"&select="+encodeURIComponent("editCounsel")+"&tr_idx="+selectTr+"&so_idx="+encodeURIComponent(so_idx),
            }).done(function(result){
            $("#dialog3").dialog("open");
                $("#dialog3").html(result);

                $("#cancle").click(function(){
                    $("#dialog3").dialog("close");
                });
            });

        }
        function del(so_idx){
			if( confirm("삭제하시겠습니까?")){
                frm.action = "delCounsel";
                document.frm.so_idx.value =so_idx;
                document.frm.c_idx.value= selectCourse;
                
                document.frm.submit();
			}
		}

        function sendData(ddd){
    		
    		ddd.submit();
		}

	</script>
</body>
</c:if>

</html>