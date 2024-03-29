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
	.data{
		color: #ababab;
	}
	.data h3{
		font-size: 15px;
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
                    <div id="staffWrap">
                        <div id="staffList_top" class="main_item title">입학상담내역</div>
                        <div id="cd_div" class="main_item data" style="display: none;">
                            <h3>${now} 금일 상담 예정자</h3>
                            <div id="cd_div2">
                                
                            </div>
                        </div>
                        <p id="hd_btn" class="main_item align_right">
                            <input type="button" onclick="togglek()" class="btn" id="togglek" value="금일 상담 예정자 보기"/>
                        </p>
                        <form>
                            <table id="searchTime" class="table">
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
                                            <select name="ct_idx" id="ct_select" class="select">
                                                <option value="0" name="ct_idx">타입검색</option>
                                                <c:forEach items="${ct_ar1}" var="ct_ar"  varStatus="loop">
                                                    <option value="${ct_ar.ct_idx }" name="ct_idx">
                                                             ${ct_ar.ct_name } 
                                                     </option>
                                                </c:forEach>
                                            </select>
                                        </td>
                                        <td>
                                            <select name="searchType2" id="c_select" class="select">
                                                <option value="0" name="c_idx">과정검색</option>
                                                <c:forEach items="${c_ar1}" var="c_ar"  varStatus="loop">
                                                    <option value="${c_ar.c_idx }" name="c_idx">
                                                             ${c_ar.c_name } 
                                                     </option>
                                                </c:forEach>
                                            </select>
                                        </td>
                                        <td>
                                            <select id="searchType3" class="select">
                                                <option value="1">이름</option>
                                                <option value="2">전화번호</option>
                                                <option value="3">메모</option>
                                            </select>
                                            <input type="text" id="searchValue" class="text"/>
                                            <button type="button" id="search_bt" class="btn">검색</button>
                                        </td>
                                    </tr>
                                </thead>
                            </table>
                            <table class="main_item align_right">
                                <tbody>
                                    <tr>	
                                        <th>
                                            <button type="button" id="btn_right" onclick="setid()" class="btn">유입경로항목관리</button>
                                            <button type="button" id="btn_right" onclick="setNs()" class="btn">다음예정일항목관리</button>
                                            <button type="button" id="btn_right" onclick="setDB()" class="btn">입학상담등록</button>
                                        </th>
                                    </tr>
                                </tbody>
                            </table>
                        </form>	
                    <div id="counselReceipt_Table">	
                        
                    </div>
                </div>
                </div>
            </div> 
        </article>
    </article>
    <form name="frm" action="counselReceipt" method="post">
		<input type="hidden" name="cd_idx" value="" />
	</form>

	<div id="dialog" hidden="" title="유입경로항목 등록/수정">	
	</div>

	<div id="dialog2" hidden="" title="다음예정일항목 등록/수정">	
	</div>

	<div id="dialog3" hidden="" title="등록">	
	</div>

	<div id="dialog4" hidden="" title="보기/수정">	
	</div>

    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
    <script>
        let select ="";
        let select_year = "";
        let numPerPage = "";
        let value ="";
        let cPage = 1;
        let room_length =Number('${id_length}');
        let ctSelect=$("#ct_select").val();
        let cSelect= $("#c_select").val();

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
            $.ajax({
                url: "counselReceiptMain",
                type: "post",
                data:"listSelect="+encodeURIComponent('${param.listSelect}')+"&cPage="+encodeURIComponent('${param.cPage}'),
            }).done(function(result){
                $("#counselReceipt_Table").html(result);
                var date = new Date();
                var year = date.getFullYear();
                var month = ("0" + (1 + date.getMonth())).slice(-2);
                var day = ("0" + date.getDate()).slice(-2);
                
                var today = year + "-" + month + "-" + day;
                $.ajax({
                    url:"getconsult",
                    type:"post",
                    data:"today="+today,
                    dataType:"json"
                }).done(function(res){
                    let consult_ar = res.consult; //일일상담
                    let str = "";
                    if(consult_ar == null){
                        str+="<div class='data'>금일 상담 예정자가 없습니다.</div>"
                    }else{
                        for(let i =0; i<consult_ar.length;i++){
                            str+="<div class='data'>"+(i+1)+". "+consult_ar[i].ac_name+"("+consult_ar[i].ac_phone+")"+"</div>"
                        }
                    }
                    $("#cd_div2").html(str);
                });

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
                console.log("dd");
                $.ajax({
                    url: "searchCounseldetail",
                    type: "post",
                    data:"select="+encodeURIComponent(select)+"&value="+encodeURIComponent(value)+"&year="+encodeURIComponent(select_year)
                        +"&num="+encodeURIComponent(numPerPage)+"&c_idx="+encodeURIComponent(cSelect)+"&ct_idx="+encodeURIComponent(ctSelect)
                        +"&listSelect="+encodeURIComponent("2")+"&cPage="+encodeURIComponent("1")
                }).done(function(result){
                    $("#counselReceipt_Table").html(result);
                });
            });
            $("#numPerPage").on("change",function(){
                numPerPage = this.value;
                $.ajax({
                    url: "searchCounseldetail",
                    type: "post",
                    data:"select="+encodeURIComponent(select)+"&value="+encodeURIComponent(value)+"&year="+encodeURIComponent(select_year)
                        +"&num="+encodeURIComponent(numPerPage)+"&c_idx="+encodeURIComponent(cSelect)+"&ct_idx="+encodeURIComponent(ctSelect)
                        +"&listSelect="+encodeURIComponent("2")+"&cPage="+encodeURIComponent("1")
                }).done(function(result){
                    $("#counselReceipt_Table").html(result);
                });
            });

            $("#search_bt").click(function(){
                let value = $("#searchValue").val();
                let select = $("#searchType3").val();
            
                $.ajax({
                    url: "searchCounseldetail",
                    type: "post",
                    data:"select="+encodeURIComponent(select)+"&value="+encodeURIComponent(value)+"&year="+encodeURIComponent(select_year)
                        +"&num="+encodeURIComponent(numPerPage)+"&c_idx="+encodeURIComponent(cSelect)+"&ct_idx="+encodeURIComponent(ctSelect)
                        +"&listSelect="+encodeURIComponent("2")+"&cPage="+encodeURIComponent("1")
                }).done(function(result){
                    $("#counselReceipt_Table").html(result);
                });
            });	

            $("#ct_select").change(function(){
                ctSelect =this.value;
                $.ajax({
                    url:"searchCounseldetail",
                    type:"post",
                    data:"select="+encodeURIComponent(select)+"&value="+encodeURIComponent(value)+"&year="+encodeURIComponent(select_year)
                        +"&num="+encodeURIComponent(numPerPage)+"&c_idx="+encodeURIComponent(cSelect)+"&ct_idx="+encodeURIComponent(ctSelect)
                        +"&listSelect="+encodeURIComponent("2")+"&cPage="+encodeURIComponent("1")
                }).done(function(result){
                    $("#counselReceipt_Table").html(result);
                });
            });

            $("#c_select").change(function(){
                cSelect =this.value;
                console.log(cSelect);
                $.ajax({
                    url:"searchCounseldetail",
                    type:"post",
                    data:"select="+encodeURIComponent(select)+"&value="+encodeURIComponent(value)+"&year="+encodeURIComponent(select_year)
                        +"&num="+encodeURIComponent(numPerPage)+"&c_idx="+encodeURIComponent(cSelect)+"&ct_idx="+encodeURIComponent(ctSelect)
                        +"&listSelect="+encodeURIComponent("2")+"&cPage="+encodeURIComponent("1")
                }).done(function(result){
                    $("#counselReceipt_Table").html(result);
                });
            });
        });


    function paging(str) {
        cPage = str;
        $.ajax({
            url:"searchCounseldetail",
            type:"post",
            data:"select="+encodeURIComponent(select)+"&value="+encodeURIComponent(value)+"&year="+encodeURIComponent(select_year)
                +"&num="+encodeURIComponent(numPerPage)+"&c_idx="+encodeURIComponent(cSelect)+"&ct_idx="+encodeURIComponent(ctSelect)+"&listSelect="+encodeURIComponent('${param.listSelect}')+"&cPage="+encodeURIComponent(str),
        }).done(function(result){
            $("#counselReceipt_Table").html(result);
        });
    }

    function setid() {
        $("#dialog").dialog("open");
        $.ajax({
            url:"cr_dialog",
            type:"post",
            data:"&select="+encodeURIComponent("addInflowPath")+"&listSelect=1&cPage=1",
        }).done(function(result){
            $("#dialog").html(result);
            
            $("#cl").click(function(){
                 room_length = 7;
                 $("#dialog").dialog( "close" );
            });
            
            $(".ui-dialog-titlebar-close").click(function(){
                 room_length = 7;
                 $("#dialog").dialog( "close" );
            });

        });
    }

    function setNs() {
        $("#dialog2").dialog("open");
        $.ajax({
            url:"cr_dialog",
            type:"post",
            data:"&select="+encodeURIComponent("addNextscheduled")+"&listSelect=1&cPage=1",
        }).done(function(result){
            $("#dialog2").html(result);
            
            $("#cl").click(function(){
                 room_length = 7;
                 $("#dialog2").dialog( "close" );
            });
            
            $(".ui-dialog-titlebar-close").click(function(){
                 room_length = 7;
                 $("#dialog2").dialog( "close" );
            });

        });
    }

    function setDB() {
        $("#dialog3").dialog("open");
        $.ajax({
            url:"cr_dialog",
            type:"post",
            data:"&select="+encodeURIComponent("addCounselingDetail")+"&listSelect=2&cPage=1",
        }).done(function(result){
            $("#dialog3").html(result);
            
            $("#cl").click(function(){
                 room_length = 7;
                 $("#dialog3").dialog( "close" );
            });
            
            $(".ui-dialog-titlebar-close").click(function(){
                 room_length = 7;
                 $("#dialog3").dialog( "close" );
            });
            $("#c_idx").change(function(){
                let str = $("#c_idx"+this.value).val();
                $("#ct_name").val(str);
            });

        });
    }

    function editCd(cd_idx) {
        $.ajax({
            url:"editCounselingDetail",
            type:"post",
            data:"&cd_idx="+cd_idx,
        }).done(function(result){
            $("#dialog4").html(result);
            
            $("#cc_cancle").click(function(){
                 $("#dialog4").dialog("close");
            });
        });

        $("#dialog4").dialog("open",{
            width:500,
            height:600
        });
    }


    $("#dialog").dialog({
        autoOpen: false,
        width:900,
        modal: true,
    });

    $("#dialog2").dialog({
        autoOpen: false,
        width:900,
        modal: true,
    });

    $("#dialog3").dialog({
        autoOpen: false,
        width:900,
        modal: true,
    });

    $("#dialog4").dialog({
        autoOpen: false,
        width:900,
        modal: true,
    });

    function togglek() {
        var cdDiv = document.getElementById("cd_div");

        if (cdDiv.style.display == "block") {
            cdDiv.style.display = "none";
            $("#togglek").val("금일 상담 예정자 보기");
        } else {
            cdDiv.style.display = "block";
            $("#togglek").val("숨기기");
        }
    }

    function addInflowPath() {
        room_length +=1;
        let str = $("#addInflowPath_tbody").html();
        let str2="<tr><td><strong>"+room_length+"</strong><br/><button type='button' class='btn red'>삭제</button> </td>"
                    +"<td><input type='text' name='InflowPathName' class='text'/> </td>";
        
        $("#addInflowPath_tbody").html(str+str2);
    }
    function addNextscheduled() {
        room_length +=1;
        let str = $("#addNextscheduled_tbody").html();
        let str2="<tr><td><strong>"+room_length+"</strong><br/><button type='button' class='btn red'>삭제</button> </td> <td><input type='text' name='nextscheduledName' class='text'/></td>";
        
        $("#addNextscheduled_tbody").html(str+str2);
    }
    function delId(id_idx){
        if( confirm("삭제하시겠습니까?")){

        rm.action = "delInflowPath";
        document.rm.id_idx.value = id_idx; 
        
        document.rm.submit();
        }
    }
    function delNs(ns_idx){
        if( confirm("삭제하시겠습니까?")){

        rm.action = "delNextscheduled";
        document.rm.ns_idx.value = ns_idx; 
        document.rm.submit();
        }
    }
    function delCd(cd_idx){
        if( confirm("삭제하시겠습니까?")){
        frm.action = "delCounselingDetail";
        document.frm.cd_idx.value =cd_idx; 
        document.frm.submit();
        }
    }
    </script>
</body>
</html>