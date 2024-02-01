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
	}
	
	#searchCourse, #makeCourse{
		margin-top:10px;
		border-collapse: collapse;
		width: 100%;

	}
	#searchCourse td, #searchTime th, #makeCourse td, #makeCourse th{
		border: 1px solid #ddd;
		height: 40px;
		padding-left: 10px;
        text-align: center;
	}
	#searchCourse th, #makeCourse th{background-color: #ddd;}
	
	#searchCourse caption, #makeCourse caption{
		text-indent: -9999px;
		height: 0;
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
    .btn{
        padding:5px 11px;
        border-radius: 3px 3px;
        border: none;
        color: white;
        background-color: #00acac;
        margin-left: 2px;
        font-weight: bold;
    }
    .red{background-color:  #d43f3a}
	.blue{ background-color: #2e6da4;}
	.yellow{background-color: #eea236;}
	.green{background-color: #5cb85c;}
    .gray{background-color: #e5e5e5;}
    #search_area{
        display: flex;
        width: 100%;
    }
    #search_area div{
        margin-top: 10px;
        display: inline-block;
        width: 50%;
    }
    #search_area div:last-child{
        text-align: right;
    }
    .t1{
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
    }
    .t1 td,.t1 th{
        border: 1px solid #ababab;
        padding:10px;
        text-align: center;
    }
    .t1 tfoot td{
        border: none;
    }
    .t1 th{
        background-color: #dedede;
        padding:3px;
    }
    .search{
        height: 25px;
        margin-right: 8px;
    }
    .tr_li{
        display: inline-block;
        margin-right: 3px;
    }
    .tr_ul{
        list-style-type: none;
        display: flex;
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
                        <div id="staffList_top" style="font-weight: bold;">&nbsp;&nbsp;"${cvo.c_name}"훈련일지</div>
                        <div id="search_area">
                            <div>
                                <select id="numPerPage" class="search">						
                                    <option>표시개수</option>
                                    <option>5</option>
                                    <option>10</option>
                                    <option>15</option>
                                </select>
                                <select id="searchType" class="search">
                                    <option value="0">작성일</option>
                                </select>
                                <input type="date" id="searchValue" class="search"/>
                                <button type="button" id="search_bt" class="btn">검색</button>
                            </div>
                            <div>
                                <button type="button" class="btn" onclick="javascript:location.href='t_log?listSelect=1'">목록</button>
                                <button type="button" class="btn blue">훈련일지 일괄출력</button>
                                <button type="button" class="btn" id="write_btn">훈련일지 등록</button>
                            </div>
                        </div>
                        <div id="courseLog_Table">
                            <!--비동기 통신으로 가져올 내용 -->
                        </div>
                    </article>
                </div>
			</div>	
		</div>
	</article>
    <div id="dialog" hidden></div>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
	<script>

	let searchType ="";
	let numPerPage = "";
	let searchValue ="";
    let cPage = "1";
	let c_idx = "${cvo.c_idx}"
	$(function() {

        $.ajax({
			url: "diary_ajax",
			type:"post",
			data:"listSelect=1&cPage=1&num="+numPerPage+"&select="+searchType+"&value="+searchValue+"&c_idx="+c_idx,
		}).done(function(result){
			$("#courseLog_Table").html(result);
		});

		//$().removeClass("selected");
		$(".selected").removeClass("selected");
		$(".l_select").removeClass("l_selected");
		$("#sixmenu").addClass("selected");
		$("#l_first").addClass("l_select");
		
		$("#numPerPage").on("change",function(){
			numPerPage = this.value;
            $.ajax({
                url: "diary_ajax",
                type:"post",
                data:"listSelect=1&cPage=1&num="+numPerPage+"&select="+searchType+"&value="+searchValue+"&c_idx="+c_idx,
            }).done(function(result){
                $("#courseLog_Table").html(result);
            });

		});
		$("#search_bt").click(function(){
            searchType = $("#searchType").val();
			searchValue = $("#searchValue").val();
            $.ajax({
                url: "diary_ajax",
                type:"post",
                data:"listSelect=1&cPage=1&num="+numPerPage+"&select="+searchType+"&value="+searchValue+"&c_idx="+c_idx,
            }).done(function(result){
                $("#courseLog_Table").html(result);
            });
			
		});	
        $("#write_btn").click(function(){
            $("#dialog").dialog("open");
            // /tl_dialog
            $.ajax({
                url: "tl_dialog",
                type:"post",
                data:"c_idx="+c_idx,
            }).done(function(result){
                $("#dialog").html(result);
                $("#cc_cancle").click(function(){
                    $("#dialog").dialog("close");
                });
            });
        });
		
	});
	
	function paging(str) {
        cPage =str;
        $.ajax({
			url: "diary_ajax",
			type:"post",
			data:"listSelect=1&cPage="+cPage+"&num="+numPerPage+"&select="+searchType+"&value="+searchValue+"&c_idx="+c_idx,
		}).done(function(result){
			$("#courseLog_Table").html(result);
		});
		
	}
    $("#dialog").dialog({
        autoOpen: false,
		width:1200,
		modal: true,
    });
	</script>
</body>
</c:if>

</html>