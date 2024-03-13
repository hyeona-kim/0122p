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
<style>
    .table td{
        font-size: 12px;
        font-weight: bold;
    }
    #t2{
        display: flex;
        position: relative;
        padding-top: 25px;
        height: 150px;
    }
    #t2>span{
        position: absolute;
        display: inline-block;
        top: 0; 
        color: #154790;
    }
    #t2>span:first-child{
        left: 0;
        top:29px;
        font-size: 13px;
        font-weight: bold;
    }
    #t2>span#t3{
        right: 0;
    }
    #t2>span#nowDate{
        right: 0;
        top:52px;
    }
    #t2 table#top_table{
        width: 40%;
        position: absolute;
        left: 0;
        bottom: 0;
        margin: 0;
    }
    #t2 table#top_table td,#t2 table#top_table th{
        font-size: 13px;
        padding: 2px;
    }
    #t2 table#right_table{
        width: 20%;
        position: absolute;
        right: 0;
        bottom: 0;
        margin: 0;
    }
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
                <header>&nbsp;&nbsp;상담 및 접수</header>
                <div> 
                    <ul>
                        <jsp:include page="./leftList.jsp"></jsp:include>
                    </ul>
                </div>
                <!-- 메인 컨텐츠가 들어오는 영역-->
                <div class="right">

                    <!--  여기서 표시될 테이블들 가지고오기 -->
                        <div id="staffWrap">
                            <div id="courseList_top" class="title">
                                <!--자바스크립트 -->
                            </div>
                            <div id="ttop">
                                <div id="t1" class="main_item main_color">
                                    검색
                                    <select name="" id="select" class="select">
                                        <option value="0">전체</option>
                                        <option value="1">교육중</option>
                                        <option value="2">모집중</option>
                                    </select>
                                </div>
                                
                                <article id="t2" class="main_item">
                                    <span>접수기준일: 당일0시~ 당일 24시까지</span>
                                    <table id="top_table" class="table">
                                        <tr>
                                            <th rowspan="2">접수현황</th>
                                            <th>일일 접수 현황</th>
                                            <th>일일 문의 현황</th>
                                        </tr>
                                        <tr>
                                            <td id="reciept">0</td>
                                            <td id="inquiry">0</td>
                                        </tr>
                                    </table>
                                    <span id="t3">
                                       
                                    </span>
                                    <span id="nowDate"></span>
                                    <table id="right_table" class="table">
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
    </article>

    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
    <script>
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
        $(function(){
            $(".subSelect").removeClass("subSelect");
			$("#l_three").addClass("subSelect");
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
                //과정별 일일 접수,문의내역구하기
                $.ajax({
                    url:"getCountast",
                    type:"post",
                    data:"select=0&list=list&today=today",
                    dataType:"json"
                }).done(function(res){
                    let inquiry_ar = res.inquiry; //일일문의
                    let consult_ar = res.consult; //일일상담
                    let receipt_ar = res.receipt; //일일 접수
                    
                    if(inquiry_ar != null){
                        for(let i =0; i<inquiry_ar.length;i++){
                            let num = Number($(".inquiry"+inquiry_ar[i].c_idx).html())+1;
                            $(".inquiry"+inquiry_ar[i].c_idx).html(num);
                        }                        
                    }
                });
			});
			//일일 문의,접수 내역구하기
            $.ajax({
                url:"getCountast",
                type:"post",
                data:"select=0",
                dataType:"json"
            }).done(function(res){
                $("#inquiry").html(res.inquiry);
            });
			

            $("#select").change(function(){
                let select = $("#select").val();
                $.ajax({
                    url: "dailyReceipt",
                    type: "post",
                    data:"year="+year+"&selectList=3&select="+select,
                }).done(function(result){
                    $("#counselReceipt_Table").html(result);
                    //과정별 일일 접수 내역 구하기
                    $.ajax({
                        url:"getCountast",
                        type:"post",
                        data:"select=0&list=list&today=today",
                        dataType:"json"
                    }).done(function(res){
                        let inquiry_ar = res.inquiry; //일일문의
                        let consult_ar = res.consult; //일일상담
                        let receipt_ar = res.receipt; //일일 접수

                        if(inquiry_ar != null){
                            for(let i =0; i<inquiry_ar.length;i++){
                                let num = Number($(".inquiry"+inquiry_ar[i].c_idx).html())+1;
                                $(".inquiry"+inquiry_ar[i].c_idx).html(num);
                            }                        
                        }
                    });
                });
            });
		});

    </script>
</body>
</html>