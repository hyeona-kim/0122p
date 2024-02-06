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
                <header>&nbsp;&nbsp;과정등록</header>
                <div> 
                    <ul>
                        <jsp:include page="./leftList.jsp"></jsp:include>
                    </ul>
                </div>
                <!-- 메인 컨텐츠가 들어오는 영역-->
                <div class="right">
                    <div id="staffWrap">
                        <article>
                            <div id="staffList_top" class="title">과정별시간표만들기</div>
                            <table id="searchCourse" class="table">
                            <caption>과정검색</caption>
                                <thead>
                                    <tr>
                                        <th>검색</th>
                                        <td>
                                            <select id="numPerPage" class="select">
                                                
                                                <option>표시개수</option>
                                                <option>5</option>
                                                <option>10</option>
                                                <option>15</option>
                                            </select>
                                            <select id="selectYear" class="select">
                                            </select>
                                        </td>
                                        <td>
                                            <select id="searchType" class="select">
                                                <option value="1">훈련강사</option>
                                                <option value="2">과정타입</option>
                                                <option value="3">과정명</option>
                                            </select>
                                            <input type="text" id="searchValue" class="text"/>
                                            <button type="button" id="search_bt" class="btn">검색</button>
                                        </td>
                                    </tr>
                                </thead>
                            </table>
                            <div id="courseLog_Table">
                                
                            </div>
                        </article>
                    </div>
				</div>

            </div> 
        </article>
    </article>
    <div id="dialog" hidden title="액셀등록"></div>
    <div id="dialog2" hidden title="주별 시간표 보기"></div>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
    <script>
        let select ="1";
        let select_year = "";
        let numPerPage = "";
        let value ="";
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
        
	$(function() {
		$(".subSelect").removeClass("subSelect");
		$("#l_three").addClass("subSelect");
        $.ajax({
            url: "courseMain",
            type: "post",
            data:"listSelect="+encodeURIComponent("3")+"&cPage="+encodeURIComponent('${param.cPage}')
        }).done(function(result){
            $("#courseLog_Table").html(result);
        });
        
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
                url: "searchCourse",
                type: "post",
                data:"select="+encodeURIComponent(select)+"&value="+encodeURIComponent(value)+"&year="+encodeURIComponent(select_year)
                    +"&num="+encodeURIComponent(numPerPage)+"&listSelect="+encodeURIComponent('${param.listSelect}')+"&cPage="+encodeURIComponent('${param.cPage}')
            }).done(function(result){
                $("#courseLog_Table").html(result);
            });
        });
        $("#numPerPage").on("change",function(){
            numPerPage = this.value;
            $.ajax({
                url: "searchCourse",
                type: "post",
                data:"select="+encodeURIComponent(select)+"&value="+encodeURIComponent(value)+"&year="+encodeURIComponent(select_year)
                    +"&num="+encodeURIComponent(numPerPage)+"&listSelect="+encodeURIComponent('${param.listSelect}')+"&cPage="+encodeURIComponent('${param.cPage}')
            }).done(function(result){
                $("#courseLog_Table").html(result);
            });
        });
        $("#search_bt").click(function(){
            value = $("#searchValue").val();
            
            $.ajax({
                url: "searchCourse",
                type: "post",
                data:"select="+encodeURIComponent(select)+"&value="+encodeURIComponent(value)+"&year="+encodeURIComponent(select_year)
                    +"&num="+encodeURIComponent(numPerPage)+"&listSelect="+encodeURIComponent('${param.listSelect}')+"&cPage="+encodeURIComponent('${param.cPage}')
            }).done(function(result){
                $("#courseLog_Table").html(result);
            });
        });	
        
    });

    function paging(str) {
        $.ajax({
            url: "searchCourse",
            type: "post",
            data:"select="+encodeURIComponent(select)+"&value="+encodeURIComponent(value)+"&year="+encodeURIComponent(select_year)
                +"&num="+encodeURIComponent(numPerPage)+"&listSelect="+encodeURIComponent('${param.listSelect}')+"&cPage="+encodeURIComponent(str),
        }).done(function(result){
            $("#courseLog_Table").html(result);
        });
    }
    function set(str,c_idx){
        
     

        $.ajax({
            url:"exelAdd",
            type:"post",
            data:"listSelect=3&select="+str+"&c_idx="+c_idx,
        }).done(function(result){
            $("#dialog").html(result);
            if(str =="time"){
            	$("#e_h2").html("HRD시간표 액셀등록"); 
				$( "#dialog" ).dialog("open");
            }
            if(str =="SRS"){
                $("#e_h2").html("강사/시설/교과목 엑셀등록"); 
				$( "#dialog" ).dialog("open");
            }
            $("#cc_cancle").click(function(){
                $( "#dialog" ).dialog("close");
            });
        });

    }

    $( "#dialog" ).dialog({
        autoOpen: false,
        width:1000,
		maxHeight:800,
        modal: true,
    });
    function set2(c_idx){
        $( "#dialog2" ).dialog("open");

        $.ajax({
            url:"weekTime",
            type:"post",
            data:"listSelect=3&c_idx="+c_idx,
        }).done(function(result){
            $("#dialog2").html(result);
            $("#cc_cancle").click(function(){
                $( "#dialog2" ).dialog("close");
            });
            
        });

    }

    $( "#dialog2" ).dialog({
        autoOpen: false,
        width:1600,
        modal: true,
    });
    </script>
</body>
</html>