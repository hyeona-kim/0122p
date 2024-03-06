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
    .time_divWrap{
        background-color: white;
        width: 98%;
        height: 98%;
        margin: auto;
        border: 1px solid #154790;
    }

    .time_divWrap>.time_div{
        height: 25%;
        border-bottom: 1px solid #ababab;
        text-align: center;
    }
    .time_divWrap>.time_div:nth-child(2n+1){
        background-color: #dddddd;
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
        let select_idx ="";
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
        select_idx= c_idx;
        $.ajax({
            url:"weekTime",
            type:"post",
            data:"listSelect=3&c_idx="+c_idx,
        }).done(function(result){
            $("#dialog2").html(result);
            $("#cc_cancle").click(function(){
                $( "#dialog2" ).dialog("close");
            });
            $.ajax({
                url:"getTime",
                type:"post",
                data:"listSelect=3&c_idx="+c_idx+"&cPage=1",
                dataType:"json",
            }).done(function(data){
               /*시간표의 정보를 가져올 */
                dataSetting(data.w_list,data.page,data.week_ar);
                
            });
            
        });
    }
    function paging2(c_page){
        $.ajax({
            url:"getTime",
            type:"post",
            data:"listSelect=3&c_idx="+select_idx+"&cPage="+c_page,
            dataType:"json",
        }).done(function(data){
           /*시간표의 정보를 가져올 */
            dataSetting(data.w_list,data.page,data.week_ar);
            $(".op"+(Number(c_page)-1)).attr("selected",true);
        });
    }
    function dataSetting(list,page,week_ar){
        // 시간표에 데이터를 세팅해준다 (class활용 예정)
        start = format(list[0].training_date)
        end = format(list[list.length-1].training_date)
        $("#startDate").html(start)
        $("#endDate").html(end)
        let str = "";
        //페이징을 하기위한 버튼 만들기
        if(page.totalRecord >0){
            if(page.nowPage == 1){
                str +="<a class='disable before'>&#129152;</a>";
            }else{
                str +="<a href='javascript:paging2("+Number(page.nowPage-1)+")' class='before'>&#129152;</a>";
            }   
            if(page.nowPage != page.totalPage ){
                str +="<a href='javascript:paging2("+Number(page.nowPage+1)+")' class='before'>&#129154;</a>";
            }else{
                str+="<a class='disable before'>&#129154;</a>";
            }
        }
        $("#page").html(str);
        
        //주차 정보 띄어주기
        week_vo = week_ar[Number(page.nowPage-1)];
        
        str = "";
        str+="훈련시간표 ("+week_ar[Number(page.nowPage-1)].weekcount.substring(0,2)+"월"+week_ar[Number(page.nowPage-1)].weekcount.substring(2,4)+
                "주차)<select class='select' onchange='select2(this)'>";
        for(let i=0; i<week_ar.length;i++){
            let weekcount = week_ar[i].weekcount;
            weekcount = weekcount.substring(0,2)+"월"+weekcount.substring(2,4)+"주";
            str +="<option value='"+i+"' class='op"+i+"'>"+weekcount+"</option>";
        }
        str += "</select>";
        $("#weekCount").html(str);
        
        //날짜 띄어주기
        for(let i=0; i<7;i++){
            $(".day"+i).html(week_vo.day_ar[i].day);
        }

        
        //액셀파일에서 가져온 정보와 동일한 날짜의 시간표를 가져와서 출력해준다.
        $(".class1").val("0930");
        $(".class2").val("1030");
        $(".class3").val("1130");
        $(".class4").val("1230");
        $(".class5").val("1420");
        $(".class6").val("1520");
        $(".class7").val("1620");
        $(".class8").val("1720");
        for(let i=1; i<= 8; i++ ){
            //$(".class"+i).val()
            for(let k=0; k<7;k++){
                let time_ar = week_vo.day_ar[k].time_ar;
                console.log(time_ar);
                if(time_ar != null){
                    for(let t=0; t<time_ar.length; t++){
                        if(time_ar[t].start_time == $(".class"+i).val()){
                            let t_str = "";
                            t_str 
                            +="<div class='time_divWrap'><div class='time_div'>"+time_ar[t].start_time.substring(0,2)+":"+time_ar[t].start_time.substring(2)+"~"
                            +(Number(time_ar[t].start_time.substring(0,2))+1)+":"+time_ar[t].start_time.substring(2)
                            +"</div>"
                            +"<div class='time_div'>"+time_ar[t].sf_name+"</div>"
                            +"<div class='time_div'>"+time_ar[t].s_name+"</div>"
                            +"<div class='time_div'>"+time_ar[t].r_name+"</div></div>"
                            $("#id"+i+k).html(t_str);
                        }
                        //$("#id"+i+k).html(time_ar[t].s_name+"<br/>"+time_ar[t].start_time);
                    }
                }else{
                    $("#id"+i+k).html("");
                }
                // 만약 시간표가 비어있다면 그 전 시간표의 정보를 가져와서 띄어준다
                if( $("#id"+i+k).html().length<1){
                    $("#id"+i+k).html($("#id"+(i-1)+k).html());
                }
            }
        }
    }
    function select2(tt){
        let idx =Number(tt.value)+1;
        $.ajax({
            url:"getTime",
            type:"post",
            data:"listSelect=3&c_idx="+select_idx+"&cPage="+(idx),
            dataType:"json",
        }).done(function(data){
           /*시간표의 정보를 가져올 */
            dataSetting(data.w_list,data.page,data.week_ar);
            $(".op"+(idx-1)).attr("selected",true);
        });
    }
    function format(str){
        // 날짜형식을 yyyy-mm-dd형식으로 변환한다.
        return str.substring(0,4)+"-"+str.substring(4,6)+"-"+str.substring(6);
    }

    $( "#dialog2" ).dialog({
        autoOpen: false,
        width:2000,
        modal: true,
        maxHeight:950,
        position: { my: "center top", at: "center top"}
    });
    </script>
</body>
</html>