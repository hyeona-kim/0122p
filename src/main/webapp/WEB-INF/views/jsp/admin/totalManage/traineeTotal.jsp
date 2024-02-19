<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/main2.css"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/right.css"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/paging.css"/>
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
<style>
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
        background-color: rgb(21, 71, 144,0.6);
        color: white;
        border: none;
    }
    /*man,woman,giveup,employ,finish,none,*/
    .woman{color: #F51901;}
    .man{color:#493BF5 ;}
    .giveup{color:#C33BF5 ;}
    .employ{color: #F5A82F;}
    .finish{color: #7BF587;}
    .none{color: #66F4E6;}
    .weeding{color: #67BAF5;}
</style>
</head>
<body>
    <article>
		<jsp:include page="${pageContext.request.contextPath }/WEB-INF/views/jsp/top_head.jsp"></jsp:include>
	</article>
    <article class="bottom">
        <article>
            <jsp:include page="${pageContext.request.contextPath }/WEB-INF/views/jsp/head.jsp"></jsp:include>
        </article>
        <article class="center">
            <div>
                <header>&nbsp;&nbsp;통합관리</header>
                <div> 
                    <ul>
                        <jsp:include page="./leftList.jsp"></jsp:include>
                    </ul>
                </div>
                <!-- 메인 컨텐츠가 들어오는 영역-->
                <div class="right">
                    <div id="staffWrap">
                        <article>
                            <div id="staffList_top" class="title">&nbsp;&nbsp;과정별 학생관리 현황</div>
                            <table id="search_t" class="table">
                            <caption>과정 선택및 검색</caption>
                            <colgroup>
                                <col width=""/>
                            </colgroup>
                                <thead>
                                    <tr>
                                        <th>검색</th>
                                        <td>훈련과정:
                                            <select id="searchCourse" class="select">
                                                <option value="0">-과정을 선택해주세요-</option>
                                                <c:forEach var="cvo" items="${c_ar}">
                                                    <c:if test="${param.c_idx eq null || param.c_idx ne cvo.c_idx}">
                                                        <option value="${cvo.c_idx}">${cvo.c_name}(${cvo.start_date}~${cvo.end_date})</option>
                                                    </c:if>
                                                    <c:if test="${param.c_idx eq cvo.c_idx }">
                                                        <option value="${cvo.c_idx}" selected>${cvo.c_name}(${cvo.start_date}~${cvo.end_date})</option>
                                                    </c:if>
                                                </c:forEach>
                                            </select>
                                            <select id="searchType" class="select">
                                                <option value="0">훈련생명</option>
                                            </select>
                                            <input type="text" id="searchValue" class="text" style="width: 40%;"/>
                                            <button type="button" id="search_bt" class="btn">검색</button>
                                        </td>
                                    </tr>
                                </thead>
                            </table>
                            <hr/>
                    
                            <div id="courseLog_Table" class="main_item" style="color: #154790; font-weight: bold;">
                                <span class="man">●</span>남자 
                                <span class="woman">●</span>여자 
                                <span class="giveup">■</span>수강포기
                                <span class="employ">■</span>조기취업
                                <span class="finish">■</span>조기수료
                                <span class="none">■</span>미수료
                                <span class="weeding">■</span>제적
                                <div align="right">
                                    <button type="button" class="btn" style="margin-right: 3px;">훈련생종합성적표</button> 
                                    <button type="button" class="btn">능력단위분석표</button> 
                                    <button type="button" class="btn">편지비교표</button> 
                                </div>
                            </div>
                            <div id="btn_area" class="main_item align_center">
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
        </article>
    </article>
    <div id="dialog" hidden title="훈련생별상담관리"></div>
    <div id="dialog2" hidden title="훈련생별상담등록"></div>
    <div id="dialog3" hidden title="상담일지"></div>
    <div id="dialog4" hidden title="정보수정"></div>
    <form name="frm" action="counsel" method="post">
        <input type="hidden" name="so_idx" value="" />
        <input type="hidden" name="total" value="total"/>
        <input type="hidden" name="c_idx" value=""/>
    </form>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
    <script>
             
        let selectTr=""; //훈련생
        let selectCourse="${param.c_idx}";
        let searchType ="";
        let searchValue ="";
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
            $("#l_two").addClass("subSelect");
        if(selectCourse.length >0){
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
                            "<div align='right'><button type='button' class='btn' style='margin-right: 3px;'>훈련생종합성적표</button>"+ 
                            "<button type='button' class='btn'>능력단위분석표</button> "+
                            "<button type='button' class='btn'>편지비교표</button></div>" ;
                $("#courseLog_Table").html(html+result);
            });
        }
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
                            "<div align='right'><button type='button' class='btn' style='margin-right: 3px;'>훈련생종합성적표</button>"+ 
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
		
	});

	$("#dialog").dialog({
        autoOpen: false,
		width:1000,
        maxHeight:900,
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
        maxHeight:900,
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
        function total_add(frm2){
            frm2.total.value="total";
            frm2.submit();
        }

        function update(frm2){
            frm2.total.value ="total";
            frm2.submit();
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
                document.frm.action = "delCounsel";
                document.frm.total.value="total";
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
</html>