<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
<style>
	.tr_ul{
		list-style-type: none;
		text-align: left;
	}
	.tr_li{
		display: inline-block;
		width: 80px;
	}
</style>
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
                            <div id="staffList_top" class="title">"${cvo.c_name}"훈련일지</div>
                            <div id="search_area" class="main_item">
                                <div>
                                    <select id="numPerPage" class="select">						
                                        <option>표시개수</option>
                                        <option>5</option>
                                        <option>10</option>
                                        <option>15</option>
                                    </select>
                                    <select id="searchType" class="select">
                                        <option value="0">작성일</option>
                                    </select>
                                    <input type="date" id="searchValue" class="text" style="width: 10%;" />
                                    <button type="button" id="search_bt" class="btn">검색</button>
                                </div>
                                <div class="align_right">
                                    <button type="button" class="btn" onclick="javascript:location.href='t_log?listSelect=1'">목록</button>
                                    <button type="button" class="btn blue" id="print_btn">훈련일지 일괄출력</button>
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
    </article>
    <div id="dialog" hidden></div>
    <div id="write_dialog" hidden></div>
    <div id="t_sign" hidden>
        <div style="width: 500px; margin: auto;">사인을 완료 하신 후 결제 버튼을 눌러주세요.</div>
        <div id="canvas_container" style="width: 500px; height: 300px; margin: auto;" >
            <canvas id="canvas" style="border:1px solid black"></canvas>
        </div>
        <img id="myImage"/>
        <div style="width: 500px; margin:10px auto; text-align: center;">
            <input type="button" class="btn" value="결제" onclick="img()"/>
            <input type="button" class="btn" value="취소" onclick="closeC()"/>
        </div>
    </div>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
    <script>
        var canvas;
        var div;
        let td_idx =0;
        var ctx;
        var drawble = false; //플래그값 설정 (그리기 종료)
        let searchType ="";
        let numPerPage = "";
        let searchValue ="";
        let cPage = "1";
        let c_idx = "${cvo.c_idx}"
        let value = 0;
        let change = true;
        let count = 0;
        let nowValue = 0;
        let bool = false;
        let sf_tmgr =9;
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
        // [초기 전역 변수 객체 등록 실시]
        canvas = $("#canvas");
        div = $("#canvas_container");

        ctx = canvas[0].getContext("2d"); //캔버스 오브젝트 가져온다          

        // [이벤트 등록 함수 호출]
        init();

        // [화면 조절 함수 호출]
        canvasResize();

        $(".subSelect").removeClass("subSelect");
        $("#l_one").addClass("subSelect");
        $.ajax({
            url: "diary_ajax",
            type:"post",
            data:"listSelect=1&cPage=1&num="+numPerPage+"&select="+searchType+"&value="+searchValue+"&c_idx="+c_idx,
        }).done(function(result){
            $("#courseLog_Table").html(result);
            checked();
        });

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
                value = $("#attend").val();
      
                cnt = 4; // 시작값 4


            });
        });
        $("#print_btn").click(function(){
            let c_ar =[];
            $('input:checkbox[name=chk]').each(function (index) {
                if($(this).is(":checked")==true){
                    c_ar.push($(this).val());
                }
            });
            //c_ar 이 체크된 훈련일지의 기본키를 가진 배열이다.
        });
        
    });
        function checked(){
            $("#chk_all").click(function() {
                if($("#chk_all").is(":checked")) $("input[name=chk]").prop("checked", true);
                else $("input[name=chk]").prop("checked", false);
            });
        
            $("input[name=chk]").click(function() {
                var total = $("input[name=chk]").length;
                var checked = $("input[name=chk]:checked").length;
        
                if(total != checked) $("#chk_all").prop("checked", false);
                else $("#chk_all").prop("checked", true); 
            });
        }
        function getTime(frm){
                if(frm.write_date.value.trim().length ==0){
                    alert("날짜를 선택하세요.")
                    frm.write_date.value ="";
                    frm.write_date.focus();
                    return;
                }
                $.ajax({
                    url:"getTime",
                    type:"post",
                    data:"listSelect=3&c_idx="+c_idx+"&cPage=1",
                    dataType:"json",
                }).done(function(data){
                   /*시간표의 정보를 가져올 */
                    if(data == null || Object.entries(data).length == 0){
                        //주간 시간표가 없는경우 
                        alert("등록된 시간표가 존재하지 않습니다.")
                        if(confirm("시간표를 등록하시겠습니까?")){
                            location.href="course?listSelect=3&cPage=1";
                        }
                    }else{
                        //주간시간표
                        dataSetting(data.w_list,data.page,data.week_ar,frm.write_date.value);
                    }
                    
                });
                
          
        }

        function dataSetting(list,page,week_ar,write_date){
            //총 주수만큼 반복문을 돈다/-/g
            write_date =  write_date.replace("-", "");
            write_date =  write_date.replace("-", "");
            let time_ar = [];
            for(let i=0; i<week_ar.length; i++){
                //일주일 반복문
                for(let k=0; k<7; k++){
                    if(week_ar[i].day_ar[k].day == write_date){
                        time_ar=week_ar[i].day_ar[k].time_ar
                    }
                }
            }
            if(time_ar == null)
                alert("해당 날짜의 등록된 일정이 없습니다.")
            else{
                let ar = ["0930","1030","1130","1230","1420","1520","1620","1720"]
                cnt = 8;
                let str ="";
                let ar2 = [false,false,false,false,false,false,false,false];
                for(let t=0; t<8;t++){
                    let b = false;
                    for(let i=0; i<time_ar.length; i++){
                        if(ar[t] == time_ar[i].start_time){
                            b = true;
                            break;
                        }
                    }
                    ar2[t] =b;
                }
                let ar3 =["","","","","","","",""]
                let ar4 =["","","","","","","",""]
                
                for(let t=0; t<8;t++){
                    ar4[t] = "<tr><td><input type='text' value='"+(t+1)+"' class='text'/></td>";
                    if(ar2[t]){
                        for(let i=0; i<time_ar.length; i++){
                            if(ar[t] == time_ar[i].start_time){
                                ar3[t] ="<td><input type='text' class='text'  value='"+time_ar[i].s_name+"'/></td>"+
                                "<td><input type='text' class='text'   value='"+time_ar[i].sf_name+"'/></td>"+
                                "<td><input type='text' class='text'  value='"+time_ar[i].r_name+"'/></td></tr>"
                            }
                        }
                    }else{
                        if(t != 0)
                            ar3[t] = ar3[t-1];
                    }
                }
                
                for(let i=0; i<ar3.length; i++){
                    str += (ar4[i]+ar3[i]);
                }
                $("#innerText").html(str);
            }
        }


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
			maxHeight: 900,
			width: 1200,
			modal: true,
        });

        function setCount(num, i){
            let val = $(".chk" + i + ":checked").length; // 클래스가 같은값들은 같은사람
            if(val > 1 && nowValue != (value - count))
                change = false;
            else{
                change = true;
            }
            
            if(num == null || num.length < 1){
                return;
            }
            if(num == 1){
                count = $("input:checkbox[name=chk1]:checked").length;
                $("#absence").val(count);
                if(change == true)
                    nowValue = $("#attend").val(value - count);
            }
            if(num == 2){
                count = $("input:checkbox[name=chk2]:checked").length;
                $("#tardy").val(count);
                if(change == true)
                    nowValue = $("#attend").val(value - count);
            }
            if(num == 3){
                count = $("input:checkbox[name=chk3]:checked").length;
                $("#earlyLeave").val(count);
                if(change == true)
                    nowValue = $("#attend").val(value - count);
            }
        }
        
        function addList(){

            var row = "<tr>";
                row += "<td><input type='text' value=";
                row += ++cnt; 
                row += " class='text'/></td>";
                row += "<td><input type='text' class='text'/></td>";
                row += "<td><input type='text' class='text'/></td>";
                row += "<td><input type='text' class='text'/></td>";
                row += "</tr>";
               

	        $('#diaryTable').append(row); // 동적으로 row를 추가한다.

        }  
        function delTraining(td_idx){
            if(confirm("정말 삭제하시겠습니까?")){
                location.href="delTraining?td_idx="+td_idx+"&c_idx="+c_idx;
            }
        }
        function addDiary(d_frm){
            //console.log(d_frm.write_date.value.length);
            //유효성검사
            if(d_frm.write_date.value.length == 0){
                alert("훈련날짜를 입력하세요.");
                d_frm.write_date.focus();
                return;
            }
            d_frm.submit();
        }
        function viewTraining(td_idx2){
            $.ajax({
                url:"viewTraining",
                type:"post",
                data:"td_idx="+td_idx2+"&c_idx="+c_idx
            }).done(function(result){
                $("#write_dialog").dialog({
                    width:1000,
                    modal:false,
                    maxHeight:900,
                    position: { my: "center top", at: "center top" }
                }) ;
                //let write_date = '${tdvo.write_date}'
                
                
                $("#write_dialog").html(result);
                //시간표정보 가져오기
                $.ajax({
                    url:"getTime",
                    type:"post",
                    data:"listSelect=3&c_idx="+c_idx+"&cPage=1",
                    dataType:"json",
                }).done(function(data){
                   /*시간표의 정보를 가져올 */
                    if(data == null || Object.entries(data).length == 0){
                        //주간 시간표가 없는경우 
                        $("#innerText").html("<tr><td colspan='4'>등록된 시간표가 없습니다.</td></tr>");
                    }else{
                        //주간시간표
                        dataSetting(data.w_list,data.page,data.week_ar,$("#v_write_date").val(),"view");
                    }
  
                    $("textarea").attr("disabled",true);
                    let tr_length =$("#tr_length").val();

                    let attend = $("#chk1").val().split(",");
                    if(attend.length >0){
                        for(let i=0; i<attend.length;i++){
                            //결석한 애들 반복문
                            for(let k=0; k<tr_length; k++){
                                if($(".chk1"+k).val() == attend[i])
                                    $(".chk1"+k).attr("checked",true);
                            }
                        }
                    }
                    let tardy = $("#chk2").val().split(",");
                    if(tardy.length >0){
                        for(let i=0; i<tardy.length;i++){
                            //결석한 애들 반복문
                            for(let k=0; k<tr_length; k++){
                                if($(".chk2"+k).val() == tardy[i])
                                    $(".chk2"+k).attr("checked",true);
                            }
                        }
                    }
                    let earlyLeave = $("#chk3").val().split(",");
                    if(earlyLeave.length >0){
                        for(let i=0; i<earlyLeave.length;i++){
                            //결석한 애들 반복문
                            for(let k=0; k<tr_length; k++){
                                if($(".chk3"+k).val() == earlyLeave[i])
                                    $(".chk3"+k).attr("checked",true);
                            }
                        }
                    }
                    $("input").attr("disabled",true);
                    $("#chk_all").attr("disabled",false)
                    $(".chk").attr("disabled",false)
                    $("#searchValue").attr("disabled",false)
                });
                
        
            });
        }
        function editTraining(td_idx2){
            $.ajax({
                url:"editTraining",
                type:"post",
                data:"td_idx="+td_idx2+"&c_idx="+c_idx
            }).done(function(result){
                $("#write_dialog").dialog({
                    width:1000,
                    modal:false,
                    maxHeight:900,
                    position: { my: "center top", at: "center top" }
                }) ;
                //let write_date = '${tdvo.write_date}'
                
                
                $("#write_dialog").html(result);
                //시간표정보 가져오기
                $.ajax({
                    url:"getTime",
                    type:"post",
                    data:"listSelect=3&c_idx="+c_idx+"&cPage=1",
                    dataType:"json",
                }).done(function(data){
                   /*시간표의 정보를 가져올 */
                    if(data == null || Object.entries(data).length == 0){
                        //주간 시간표가 없는경우 
                        $("#innerText").html("<tr><td colspan='4'>등록된 시간표가 없습니다.</td></tr>");
                    }else{
                        //주간시간표
                        dataSetting(data.w_list,data.page,data.week_ar,$("#e_write_date").val(),"view");
                    }
  
                    let tr_length =$("#tr_length").val();

                    let attend = $("#chk1").val().split(",");
                    if(attend.length >0){
                        for(let i=0; i<attend.length;i++){
                            //결석한 애들 반복문
                            for(let k=0; k<tr_length; k++){
                                if($(".chk1"+k).val() == attend[i])
                                    $(".chk1"+k).attr("checked",true);
                            }
                        }
                    }
                    let tardy = $("#chk2").val().split(",");
                    if(tardy.length >0){
                        for(let i=0; i<tardy.length;i++){
                            //결석한 애들 반복문
                            for(let k=0; k<tr_length; k++){
                                if($(".chk2"+k).val() == tardy[i])
                                    $(".chk2"+k).attr("checked",true);
                            }
                        }
                    }
                    let earlyLeave = $("#chk3").val().split(",");
                    if(earlyLeave.length >0){
                        for(let i=0; i<earlyLeave.length;i++){
                            //결석한 애들 반복문
                            for(let k=0; k<tr_length; k++){
                                if($(".chk3"+k).val() == earlyLeave[i])
                                    $(".chk3"+k).attr("checked",true);
                            }
                        }
                    }
                });
                $("#cc_cancle").click(function(){
                    $("#write_dialog").dialog("close") 
                });
            });
        }
        
        function sign(str,str2){
            td_idx = str;
            sf_tmgr = str2;
            $("#t_sign").dialog({
                width:800,
                modal:false,
                maxHeight:800,
            });
        }



        function init(){

            //캔버스 사이즈 조절
            $(window).on("resize", canvasResize);
  
            //PC 이벤트 등록
            canvas.on("mousedown", pcDraw);
            canvas.on("mousemove", pcDraw);
            canvas.on("mouseup", pcDraw);
            canvas.on("mouseout", pcDraw);
   
            //모바일 이벤트 등록
            canvas.on("touchstart", mobileDraw);
            canvas.on("touchend", mobileDraw);
            canvas.on("touchcancel", mobileDraw);
            canvas.on("touchmove", mobileDraw);
  
            //버튼 클릭 및 이미지 저장 등록
         };
  
  
  
  
  
         /* [화면 조절 함수] */
         function canvasResize(){
            //캔버스 사이즈 조절
            canvas[0].height = div.height();
            canvas[0].width = div.width();
         };
  
  
  
  
  
         /* [PC 그리기 이벤트 처리] */
         function pcDraw(evt){
            switch(evt.type){
              case "mousedown" : {
                 BodyScrollDisAble(); //body 스크롤 정지
                 drawble = true;
                 ctx.beginPath();
                 ctx.moveTo(getPcPosition(evt).X, getPcPosition(evt).Y);               
              }
              break;
  
              case "mousemove" : {
                 if(drawble){
                    ctx.lineTo(getPcPosition(evt).X, getPcPosition(evt).Y);
                    ctx.stroke();
                 }
              }
              break;
  
              case "mouseup" :
              case "mouseout" : {
                 BodyScrollDisAble(); //body 스크롤 허용
                 drawble = false;
                 ctx.closePath();
              }
              break;
           }
         };
  
         function getPcPosition(evt){          
            var x = evt.pageX - canvas.offset().left;
            var y = evt.pageY - canvas.offset().top;
            return {X:x, Y:y};
         };
  
  
  
  
  
         /* [모바일 그리기 이벤트 처리] */
         function mobileDraw(evt){

            switch(evt.type){
              case "touchstart" : {
                 BodyScrollDisAble(); //body 스크롤 정지
                 drawble = true;
                 ctx.beginPath();
                 ctx.moveTo(getMobilePosition(evt).X, getMobilePosition(evt).Y);
              }
              break;
  
              case "touchmove" : {
                 if(drawble){
                    // 스크롤 및 이동 이벤트 중지
                    evt.preventDefault();
                    ctx.lineTo(getMobilePosition(evt).X, getMobilePosition(evt).Y);
                    ctx.stroke();
                 }
              }
              break;
  
              case "touchend" :
              case "touchcancel" : {
                 BodyScrollDisAble(); //body 스크롤 허용
                 drawble = false;
                 ctx.closePath();
              }
              break;
           }
         };
  
         function getMobilePosition(evt){
            var x = evt.originalEvent.changedTouches[0].pageX - canvas.offset().left;
            var y = evt.originalEvent.changedTouches[0].pageY - canvas.offset().top;
            return {X:x, Y:y};
         }; 
  
         /* [body 영역 스크롤 관리 부분] */
         function BodyScrollDisAble(){      
  
            document.body.style.overflow = "hidden"; //스크롤 막음
         };
         function BodyScrollAble(){  
            document.body.style.overflow = "auto"; //스크롤 허용
         };
         function img(){
            let canvas2 = document.getElementById("canvas");
            let myImage = document.getElementById("myImage")

            let fdata = new FormData();

            
            let imgDataUrl = canvas2.toDataURL('image/png');
            let binaryData = atob(imgDataUrl.split(',')[1]); // base54 데이터 디코딩
            let array = [];
            
            for (let i = 0; i < binaryData.length; i++) {
                array.push(binaryData.charCodeAt(i)); // 하나의 파일로 만들기 위해 모든 값들을 배열에 집어넣음
            }
            
            let file = new File([new Uint8Array(array)], {type: 'image/png'}); // 이미지파일 만들기
            //console.log(c_idx)
            fdata.append("s_file", file);
            fdata.append("c_idx",c_idx)
            fdata.append("td_idx",td_idx)
            fdata.append("sf_tmgr",sf_tmgr)
            //console.log(sf_tmgr)
            $.ajax({
                url: "t_sign",
                data: fdata,
                type: "POST",
                contentType: false, // 파일 첨부시 필요한 속성들
                processData: false,
                cache: false,
                dataType: "json", // 서버에서 보내오는 자원의 타입
            }).done(function(data) {
                f = data.f_name
                if(data.cnt == "1"){
                    alert("저장되었습니다.");
                }else{
                    alert("결제실패.");
                }
                var cnvs = document.getElementById('canvas');
                // context
                var ctx = cnvs.getContext('2d');
    
                // 픽셀 정리
                ctx.clearRect(0, 0, cnvs.width, cnvs.height);
                // 컨텍스트 리셋
                ctx.beginPath();
                $("#t_sign").dialog("close");
                $.ajax({
                    url: "diary_ajax",
                    type:"post",
                    data:"listSelect=1&cPage=1&num="+numPerPage+"&select="+searchType+"&value="+searchValue+"&c_idx="+c_idx,
                }).done(function(result){
                    $("#courseLog_Table").html(result);
                });
            });
        }
        function closeC(){
            $("#t_sign").dialog("close");
              // canvas
            var cnvs = document.getElementById('canvas');
            // context
            var ctx = cnvs.getContext('2d');

            // 픽셀 정리
            ctx.clearRect(0, 0, cnvs.width, cnvs.height);
            // 컨텍스트 리셋
            ctx.beginPath();
        }
        function showSign(str){
            $("#img_div"+str).dialog({
                width:600,
                height:400,
            });
        }
    </script>
</body>
</html>