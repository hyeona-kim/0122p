<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/main.css"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/right.css"/>
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/fullcalendar.css"/>
<style>
    #faculty{
		display: inline-block;
		padding: 6px 6px;
		border: none;
		border-radius: 5px 5px;
		background-color: #a2caf8;
		color: white;
	}
	#director{
		display: inline-block;
		padding: 6px 6px;
		border: none;
		border-radius: 5px 5px;
		background-color: #F55944;
		color: white;
	}
    #manager{
        display: inline-block;
		padding: 6px 6px;
		border: none;
		border-radius: 5px 5px;
		background-color: #154790;
		color: white;
    }
    .top>div:first-child>div:last-child>div:last-child>article{
        margin: 0;
    }
 
    .tr_ul{
        list-style-type: none;
        text-align: left;
    }
    .tr_li{
        display: inline-block;
        width: 80px;
    }

</style>
</head>
<body>
    <jsp:include page="${pageContext.request.contextPath }/WEB-INF/views/jsp/top_head.jsp"></jsp:include>

    <article class="top">
        <div>
            <!-- 
                전체적인 관리 페이지 ( view용 )
                오늘날짜 O
                최근문의 
                지원자수 (결재금액)
                공지사항 
            -->
            <div>
                <div id="today">TODAY</div>
                <div>
                    <div id="time"></div>
                    <div id="day"></div>
                    <select class="select" id="day_select">
                        <option value="0">오늘</option>
                        <option value="1">일주일</option>
                        <option value="2">한달</option>
                    </select>
                    <article>
                        <table>
                            <caption>접수내역</caption>
                            <colgroup>
                                <col width="33.3%"/>
                                <col width="33.3%"/>
                                <col width="33.3%"/>
                            </colgroup>
                            <tr>
                                <th>문의</th>
                                <th>상담</th>
                                <th>교재결제</th>
                            </tr>
                            <tr>
                                <td id="inquiry">(0)건</td>
                                <td id="consult">(0)건</td>
                                <td id="bookpay">(0)건</td>
                            </tr>
                            <tr>
                                <th colspan="3" id="total_pay">결제 총액 (0)원</th>
                            </tr>
                        </table>
                    </article>
                </div>
            </div>
            <div>
                <div id="today">훈련일지[금일 결재상신내역]</div>
                <div>
                    <article>
                        <div class="main_item">
                            <input type="button" class="btn" onclick="javascript:location.href='t_log?listSelect=1&cPage=1'" value="훈련일지바로가기"/>
                        </div>
                        <div id="td_list">
                            
                        </div>
                    </article>
                </div>
            </div>
        </div>
        <div id="calendar_wrap">
            <span>
                <a href="calendar">일정관리</a>
            </span>
            <div class="calendar" id="calendar">

            </div>
        </div>
    </article>
    <article class="staff">
        <div>
            <div class="title">관리메뉴</div>
            <article>
                <div class="select" id="1">교직원 관리</div>
                <div class="select" id="2">입학상담관리</div>
                <div class="select" id="4">전체메뉴보기</div>
            </article>
        </div>    
        <div id="menu">
            <div class="first">
                <span>원하시는 관리메뉴를 선택해주세요 </span>
            </div>
        </div>
    </article>
    <%-- ========== 교직원 등록,수정 폼 시작 ========== --%>
    <div id="addForm" type="hidden">
        
    </div>
    <%-- ========== 교직원 등록,수정 폼 끝 ========== --%>
    <div id="viewTd" hidden>
        
    </div>
    <div id="t_sign" hidden>
        <div style="width: 500px; margin: auto;">사인을 완료 하신 후 결제 버튼을 눌러주세요.</div>
        <div id="canvas_container" style="width: 500px; height: 300px; margin: auto;" >
            <canvas id="canvas" style="border:1px solid black"></canvas>
        </div>
        <img id="myImage"/>
        <div style="width: 500px; margin:10px auto; text-align: center;">
            <input type="button" class="btn i_btn" value="결제" onclick="img()" />
            <input type="button" class="btn i_btn" value="취소" onclick="closeC()"/>
        </div>
    </div>
    <div id="detailCI" hidden>

    </div>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
    <script src="${pageContext.request.contextPath }/js/fullcalendar.js"></script>
	<script src="${pageContext.request.contextPath }/js/lang/ko.js"></script>
    <script>
        let f = "";
        let i = '${sessionScope.vo.sf_idx}';
        let t = '${sessionScope.vo.sf_tmgr}';
        let m = '${sessionScope.vo.sf_mgr}'; 
        let day_select = 0;
        let calendarEl =null;
        let calendar = null;
        let ar = [];
        let events_ar = [];
        var canvas;
        var div;
        let s_sf_tmgr =-1;
        let s_td_idx =-1;
        let s_c_idx =-1;
        var drawble = false;
        document.addEventListener('DOMContentLoaded', function() {  
            canvas = $("#canvas");
            div = $("#canvas_container");
    
            ctx = canvas[0].getContext("2d"); //캔버스 오브젝트 가져온다          
    
            // [이벤트 등록 함수 호출]
            init2();
            
            // [화면 조절 함수 호출]
            canvasResize();

            init();
            init3();
            $.ajax({
                url :"http://localhost:5000/list",
                type:"get",
                dataType:"json"
            }).done(function(data){
                //console.log(data);
                ar = data;
                for(let i=0; i<ar.length; i++){
                    if(ar[i].status == 0){
                        events_ar.push(ar[i])
                    }
                }
                calendarEl = document.getElementById('calendar');    
                calendar = new FullCalendar.Calendar(calendarEl,{  
                    headerToolbar:{
                        right:'prev,next',
                        center:'title',
                        left:'today'
                    },
                    locale: "ko",                  
                    dayMaxEventRows: 1,         
                    googleCalendarApiKey: 'AIzaSyCy-89GuDIuHHF68AJMQUc_Z0A7ZUogmkE',        
             
                    showNonCurrentDates:false,      
                    eventSources: [           
                    {             
                        googleCalendarId: "ko.south_korea#holiday@group.v.calendar.google.com",        
                        className: 'korea_holiday',             
                        color: '#dedede',
                        textColor:'red',           
                    },           
                    ],
                    events: events_ar,
                    editable: false,
                    //droppable을 사용할때 droppable true 드롭이벤트
                    droppable: false,
                    
                });
                
                calendar.render();

            });
        });
        function clock() {
            var date = new Date();
            var years = date.getFullYear();
            var month = Number(date.getMonth())+1;
            month = (month<10)?"0"+month:month;
            var clockDate = date.getDate();
            var day = date.getDay();
            var week = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
            var hours = date.getHours();
            hours = (hours < 10)? "0"+hours:hours;
            var a_hours = hours-12;
            if(a_hours>0){
                hours = "PM "+a_hours;
            }else{
                hours = "AM "+ hours;
            }

            
            var minutes = date.getMinutes();
            minutes = (minutes < 10)?"0"+minutes: minutes;

            var seconds = date.getSeconds();
            seconds=(seconds < 10)?"0"+seconds:seconds;
            clockDate = (clockDate<10)?"0"+clockDate:clockDate
            $("#day").html(years+"-"+month+"-"+ clockDate+"  "+(week[day]));
            $("#time").html(hours+":"+minutes+":"+seconds+"");
        }
        function init() {
            clock();
            setInterval(clock, 1000);
        }
        function init3() {
            getInfo();
            setInterval(getInfo, 60000);
        }
        function getInfo(){
            console.log(day_select);
            $.ajax({
                url:"getCountast",
                type:"post",
                data:"select="+day_select,
                dataType:"json"
            }).done(function(res){
                console.log(res);
                $("#inquiry").html(res.inquiry+"건");
                $("#consult").html(res.consult+"건");
                $("#bookpay").html(res.bookpay+"건");
                $("#total_pay").html("총 결제금액 "+res.total_pay+"원")
            });
        }
        $(function(){
            
            $.ajax({
                url:"main_info",
                type:"post",
                dataType:"json"
           }).done(function(res){
                let page = res.page;
                let td_ar = res.td_ar;
                let str = "";
                //console.log(res);
                if(td_ar == null){
                    str +="<div id='noSign'>결제할 내용이 없습니다</div>"
                }else{
                    if( td_ar.length ==5){
                        for(let i=0; i<td_ar.length; i++){
                            str +="<div class='sign' >"+td_ar[i].write_date+"</div><input type='hidden' class='"+td_ar[i].c_idx+"' value='"+td_ar[i].td_idx+"'/>"
                        }
                    }else{
                        for(let i=0; i<td_ar.length; i++){
                            str +="<div class='sign'>"+td_ar[i].write_date+"</div><input type='hidden' class='"+td_ar[i].c_idx+"' value='"+td_ar[i].td_idx+"'/>"
                        }
                        for(let i=0; i<(5-td_ar.length); i++){
                            str +="<div class='sign_disabled'></div>"
                        }
                    }
                }
                str+="<div>"
                if(page.totalRecord >0){
                    if(page.nowPage == 1){
                        str += "<a class='disable'>◀</a>"
                    }else{
                        str += "<a href='javascript:paging2("+(page.nowPage-1)+")'>◀</a>"
                    }
                    if(page.nowPage != page.totalPage){
                        str += "<a href='javascript:paging2("+(page.nowPage+1)+")'>▶</a>"
                    }else{
                        str += "<a class='disable'>▶</a>"
                    }
                }

                
                str+="</div>"
                $("#td_list").html(str);
                $(".sign").click(function(){
                    
                    let c_idx= $(this).next().attr('class');
                    $("#viewTd").dialog({
                        width:1200,
                        maxHeight:900,
                        modal:false,
                        position: { my: "center top", at: "center top" }
                    })
                    $.ajax({
                        url:"a_viewTD",
                        data:"td_idx="+$(this).next().val(),
                        type:"post"
                    }).done(function(res){
                        $("#viewTd").html(res);
                        
                    });
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
                        $(".i_btn").attr("disabled",false)
                        $("#sign_btn").attr("disabled",false)
                
                    });
                })
           })
            $(".select").click(function(){
                $(".selected").removeClass("selected");
                $(this).addClass("selected");
                let select = $(this).attr('id');
                if(select == "1"){
                    $.ajax({
                        url :"staffList",
                        type:"post",
                        data:"main=admin&cPage=1"
                    }).done(function(res){
                        $("#menu").html(res);
                    });
                }else if(select =="2"){
                    //$("#menu").html("입학상담관리");
                    $.ajax({
                        url :"counseling_main",
                        type:"post",
                        data:"main=counseling&cPage=1"
                    }).done(function(res){
                        $("#menu").html(res);
                        //inquiry_ajax consult_ajax (->목록뽑기)
                        $("#allinquiry").click(function(){
                            $("#inquiry_ajax").dialog({
                                width: 680,
                                maxHeight:900,
                                position: { my: "center top", at: "center top" },
                                modal:true,
                            })
                            
                        });
                        $("#allconsult").click(function(){
                            $("#consult_ajax").dialog({
                                width: 680,
                                maxHeight:900,
                                position: { my: "center top", at: "center top" },
                                modal:true,
                            })
                            
                        });
                    });
                }else if( select =="3"){
                    $("#menu").html("사후관리");
                }else if( select =="4"){
                    $.ajax({
                        url :"staffList",
                        type:"post",
                        data:"main=admin"
                    }).done(function(res){
                        $("#menu").html(res);
                    });

                }
            });
            $("#day_select").change(function(){
                day_select = this.value;
                getInfo();
            });
        });
        function paging(cPage){
            $.ajax({
                url :"staffList",
                type:"post",
                data:"main=admin&cPage="+cPage
            }).done(function(res){
                $("#menu").html(res);
            });
        }
        function unblockStaff(idx) {
			if(confirm("해제하시겠습니까?")){
				location.href="unblockStaff?sf_idx="+idx+"&main=ok";
			}else{
				return false;
			};
		};
        /* 교직원현황 - [수정]버튼을 클릭했을 때
		 비동기통신을 이용해 dialog를 띄우는 기능 */
		function editStaffForm(idx) {
			// 오직 자기 자신의 정보만 수정이 가능하게 해야하므로 로그인한 사람의 idx와 비교
			if(i != idx && t == '0')
				alert("권한이 없습니다.");
			else{

				$.ajax({
					url: "staffEditForm",
					type: "post",
					data: "sf_idx="+idx + "&place=1"
				}).done(function(result){
					$("#addForm").dialog("open");
					$("#addForm").html(result);
					$("#cc_btn").click(function(){
						$("#addForm").dialog("close");
					});
				});
				
				$("#addForm").dialog({
					title : '교직원수정',
					modal : true,
					width : 1000,
					maxHeight : 800
				});
			}
		};
			
        /* 교직원수정 폼에서 [수정]버튼을 클릭했을 때 수행하는 곳 */
        function editStaff(idx) {
            // 이름, 직급, 아이디, 암호, 입사일 유효성 검사
            // 퇴사일은 값이 없어도 Controller에서 처리함
            let ar = document.forms[0].elements;
            for(let i=0 ; i<ar.length-12; i++){
                
                if(ar[i].value ==""){
                    alert(ar[i].dataset.str+"을 입력하세요");
                    ar[i].focus();
                    return; // 수행 중단
                };
            };

        // 연락처 맨 앞자리 유효성 검사
        if(ar[8].value.trim().length != '3'){
            alert(ar[8].dataset.str+"을 입력하세요");
            ar[8].focus();
            return; // 수행 중단
        };

        // 연락처 가운데, 뒷자리 유효성 검사
        for(let i=9 ; i<ar.length-8; i++){
            if(ar[i].value.trim().length != '4'){
                alert(ar[i].dataset.str+"을 입력하세요");
                ar[i].focus();
                return; // 수행 중단
            };
        };
        if(confirm("수정하시겠습니까?")){
            if($("#authority").val() == '3' && t == '1' && idx != i){
                if(!confirm("권한 양도시 열람 및 수정의 제한이 생기실 수 있습니다. 정말로 양도하시겠습니까?")){
                    return;
                }
            }
            $("#sf_fname").val(f);
            alert("수정되었습니다");
            $("#frm2").submit();
        } else {
            return;
        }
    };
    
        /* 교직원현황 - [삭제]버튼을 클릭했을 때 data를 삭제하는 곳
            교직원의 status를 0->1 로 변경해서 보이지 않게 한다 */
        function delStaff(idx, tcr, mgr, tmgr) { // 관리자는 교강사를, 최고관리자는 관리자, 강사 모두를 삭제 가능하다
            // 교강사는 관리자체가 불가능하므로 관리자 이상급의 권한만 확인한다.
            let chk = false;
            if(tmgr != '1'){ // 최고 관리자는 삭제될 수 없으므로 비교
                if(t == '1') {
                    chk = true;
                } else if(m == '1' && mgr == '0') { // 로그인한 사람이 관리자이고 삭제하려는 직급이 강사일때
                    chk = true;
                } else { // 관리자가 관리자를 삭제하려 했을 때
                    alert("권한이 없습니다.");
                }
            } else {
                alert("최고 관리자는 삭제가 불가능합니다.");	
            }

            if (chk){
                if(confirm("삭제하시겠습니까?")){
                    location.href="delStaff?sf_idx="+idx;
                }else{
                    return false;
                }
            }
        };

        function changeCertifi() {
			/* option에서 선택된 값을 value에 저장 */
			let value = $("#certification").val();
			
			switch(value){
				case "none":{
					$("#certi_image").hide();
					$("#certi_sign").hide();				
				}
				break;
				case "image":{
					$("#certi_image").show();
					$("#certi_sign").hide();			
				}
				break;
				case "sign":{
					$("#certi_image").hide();
					$("#certi_sign").show();
					
					var canvas = $("#signature")[0];
					var signature = new SignaturePad(canvas, {
									minWidth : 2,
									maxWidth : 2,
									penColor : "rgb(0, 0, 0)"
					});
					
					/* 교직원등록에서 전자서명패드를 clear하는 기능 */
					$("#clear_btn").bind("click", function() {
						signature.clear();
					});
				}
				break;
			};
		};

        function addSign(){
			if( $("#certification").val() == "sign"){

				let canvas = document.getElementById("signature");

				let fdata = new FormData();

			  
				let imgDataUrl = canvas.toDataURL('image/png');
				let binaryData = atob(imgDataUrl.split(',')[1]); // base54 데이터 디코딩
				let array = [];
			  
				for (let i = 0; i < binaryData.length; i++) {
					array.push(binaryData.charCodeAt(i)); // 하나의 파일로 만들기 위해 모든 값들을 배열에 집어넣음
				}
			  
				let file = new File([new Uint8Array(array)], {type: 'image/png'}); // 이미지파일 만들기

				fdata.append("s_file", file);

				$.ajax({
					url: "addSign",
					data: fdata,
					type: "POST",
					contentType: false, // 파일 첨부시 필요한 속성들
					processData: false,
					cache: false,
					dataType: "json", // 서버에서 보내오는 자원의 타입
				}).done(function(data) {
					f = data.f_name
					alert("파일이 저장되었습니다.");
					$("#certi_sign").hide();
				});
			}
			
		}
        function paging2(str){
            $.ajax({
                url:"main_info",
                type:"post",
                data:"cPage="+str,
                dataType:"json"
           }).done(function(res){
                let page = res.page;
                let td_ar = res.td_ar;
                let str = "";
                //console.log(res);
                if(td_ar == null){
                    str +="<div id='noSign' >결제할 내용이 없습니다</div>"
                }else{
                    if( td_ar.length ==5){
                        for(let i=0; i<td_ar.length; i++){
                            str +="<div class='sign'>"+td_ar[i].write_date+"</div><input type='hidden' class='"+td_ar[i].c_idx+"' value='"+td_ar[i].td_idx+"'/>"
                        }
                    }else{
                        for(let i=0; i<td_ar.length; i++){
                            str +="<div class='sign'>"+td_ar[i].write_date+"</div><input type='hidden' class='"+td_ar[i].c_idx+"' value='"+td_ar[i].td_idx+"'/>"
                        }
                        for(let i=0; i<(5-td_ar.length); i++){
                            str +="<div class='sign_disabled'></div>"
                        }
                    }
                }
                str+="<div>"
                if(page.totalRecord >0){
                    if(page.nowPage == 1){
                        str += "<a class='disable'>◀</a>"
                    }else{
                        str += "<a href='javascript:paging2("+(page.nowPage-1)+")'>◀</a>"
                    }

                    if(page.nowPage != page.totalPage){
                        str += "<a href='javascript:paging2("+(page.nowPage+1)+")'>▶</a>"
                    }else{
                        str += "<a class='disable'>▶</a>"
                    }
                }

                str+="</div>"
                $("#td_list").html(str);
                $(".sign").click(function(){
                    let c_idx= $(this).next().attr('class');
                    $("#viewTd").dialog({
                        width:1200,
                        maxHeight:900,
                        modal:false,
                        position: { my: "center top", at: "center top" }
                    })
                    $.ajax({
                        url:"a_viewTD",
                        data:"td_idx="+$(this).next().val(),
                        type:"post"
                    }).done(function(res){
                        $("#viewTd").html(res);
                        
                    });
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
                        $(".i_btn").attr("disabled",false)
                        $("#sign_btn").attr("disabled",false)
                    });
                    
                })
           })
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
        function gosign(str,str2,str3){
            s_sf_tmgr = str;
            s_td_idx = str2;
            s_c_idx = str3;
            $("#t_sign").dialog({
                width:800,
                modal:false,
                maxHeight:800,
            });
        }
        function init2(){
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
            fdata.append("c_idx",s_c_idx)
            fdata.append("td_idx",s_td_idx)
            fdata.append("sf_tmgr",s_sf_tmgr)
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
                
                location.reload(true);
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
        function consult(str){
            //기본키를 가져온다 상담을 가져와서 띄어준다.
            console.log("상담"+str);
            $.ajax({
                url:"selectASK",
                type:"post",
                data:"ac_idx="+str,
            }).done(function(res){
                $("#detailCI").dialog({
                    width:700,
                    maxHeight:900,
                    position: { my: "center top", at: "center top" },
                    modal:true,
                });
                $("#detailCI").html(res);
                $("#c_add_btn").click(function(){
                    let ac_answer_date = $("#ac_answer_date").val();
                    let ac_idx = $("#ac_idx").val();
                    if(ac_answer_date.length ==0 ){
                        alert("날짜을 입력하세요.")
                        $("#ac_answer_date").focus();
                        $("#ac_answer_date").val("");
                        return;
                    }

                    $.ajax({
                        url:"updateCI",
                        data:"ac_answer_date="+ac_answer_date+"&ac_idx="+ac_idx,
                        type:"post"
                    }).done(function(data){
                        if(data.cnt ==1){
                            alert("저장되었습니다.")
                        }else{
                            alert("저장실패")
                        }
                        location.reload(true);
                    });
                })
            }); 
        }
        function inquiry(str){
            console.log("문의"+str);
            // 기본키를 가져온다 문의를 가져와서 띄어준다.
            $.ajax({
                url:"selectASK",
                type:"post",
                data:"ac_idx="+str,
            }).done(function(res){
                $("#detailCI").dialog({
                    width:700,
                    maxHeight:900,
                    position: { my: "center top", at: "center top" },
                    modal:true,
                });
                $("#detailCI").html(res);
                $("#i_add_btn").click(function(){
                    let ac_answer = $("#ac_answer").val();
                    let ac_idx = $("#ac_idx").val();
                    if(ac_answer.length ==0 ){
                        alert("날짜을 입력하세요.")
                        $("#ac_answer").focus();
                        $("#ac_answer").val("");
                        return;
                    }

                    $.ajax({
                        url:"updateCI",
                        data:"ac_answer="+ac_answer+"&ac_idx="+ac_idx,
                        type:"post"
                    }).done(function(data){
                        if(data.cnt ==1){
                            alert("저장되었습니다.")
                        }else{
                            alert("저장실패")
                        }
                        location.reload(true);
                    });
                })
            }); 
        }
    </script>
</body>
</html>