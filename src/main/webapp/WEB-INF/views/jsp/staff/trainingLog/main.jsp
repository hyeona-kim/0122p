<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/main.css"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/main_staff.css"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/right.css"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/paging.css"/>
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
<style>
    .tr_ul{
		list-style-type: none;
		text-align: left;
	}
	.tr_li{
		display: inline-block;
		width: 80px;
	}
    .viewTable th{
        background-color: #dedede;
        color: black;
    }
</style>
</head>
<body bgcolor="#eeeeee"> 
    <jsp:include page="${pageContext.request.contextPath }/WEB-INF/views/jsp/top_head.jsp"></jsp:include>
    <div id="course_wrap">
        <select class="select" id="select_course">
            <option>과정을 선택 해주세요</option>
            <option>ㅎㅇ</option>
            <option>ㅎㅇ</option>
        </select>
        <span>
            <a id="my_page"><img alt="마이페이지" src="${pageContext.request.contextPath }/image/myPage2.png"/></a>
        </span>
        <ul class="mypage_ul" id="mypage_ul">
            <li><a onclick="changePass()">비밀번호변경</a></li>
            <li><a onclick="changeMe()">정보수정</a></li>
            <li><a onclick="message()">쪽지</a></li>
        </ul>
    </div>
    <article id="top">
        <div class="left">
            <ul id="menu_list">
                <li id='l_one'><a onclick="list(1)">훈련일지</a></li>
                <li id='l_two'><a onclick="list(2)">평가관리</a></li>
                <li id='l_four'><a onclick="list(4)">과정별 훈련생 관리</a></li>
                <li id='l_five'><a onclick="list(5)">일정보기</a></li>
            </ul>
        </div>
        <div class="right">
            <div class="main_item">
                <div class="align_right">
                    <button type="button" class="btn" id="write_btn">훈련일지 등록</button>
                </div>
            </div>
            <div id="courseLog_Table">
                <!--비동기 통신으로 가져올 내용 -->
            </div>
        </div>
        <!-- 비밀번호 변경을 위한 div -->
        <div hidden id="checkPassword">
            <div class="title">
                비밀번호 확인
            </div>
            <table class="table">
                <tbody>
                    <tr>
                        <td>비밀번호</td>
                        <td><input type="password" class="text" id="password"/></td>
                    </tr>
                </tbody>
                <tfoot>
                    <tr>
                        <td colspan="2">
                            <input type="button" class="btn" value="확인" id="ppchk_btn"/>
                            <input type="button" class="btn red2" value="취소" onclick="cancle('checkPassword')"/>
                        </td>
                    </tr>
                </tfoot>
            </table>
        </div>

        <div hidden id="changePassword">
            <div class="title">
                변경할 비밀번호를 입력해주세요.
            </div>
            <table class="table">
                <tbody>
                    <tr>
                        <td>비밀번호</td>
                        <td><input type="password" class="text" id="password2"/></td>
                    </tr>
                </tbody>
                <tfoot>
                    <tr>
                        <td colspan="2">
                            <input type="button" class="btn" value="수정" id="ppchange_btn"/>
                            <input type="button" class="btn red2" value="취소" onclick="cancle('changePassword')"/>
                        </td>
                    </tr>
                </tfoot>
            </table>
        </div>
        </article>
        <div id="dialog" hidden></div>
        <div id="dialog2" hidden></div>
        <div id="write_dialog" hidden></div>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
    <script>
        //로그인된 강사 정보 가져오기
        let s_idx = "${vo.sf_idx}";
        // 선택된 과정 정보 가지고오기
        let c_idx ="";
        let cPage = "";
        let value = 0;
        let change = true;
        let count = 0;
        let nowValue = 0;
        let bool = false;
        $(function(){	
            c_idx = "${param.c_idx}";
            $(".selected").removeClass("selected")
            $("#l_one").addClass("selected")

            $.ajax({
                url:"staffCourse",
                type:"post",
                data:"sf_idx="+s_idx,
                dataType:"json",
            }).done(function(data){
                let str = "";
                if(data.c_ar != null){
                    for(let i =0; i<data.c_ar.length; i++){
                        if(c_idx ==data.c_ar[i].c_idx){
                            str += "<option value ='"+data.c_ar[i].c_idx+"' class='op"+data.c_ar[i].c_idx+"' selected>"+data.c_ar[i].c_name+"</option>";
                        }else{
                            str += "<option value ='"+data.c_ar[i].c_idx+"' class='op"+data.c_ar[i].c_idx+"'>"+data.c_ar[i].c_name+"</option>";
                        }
                    }
                    if(c_idx == ""){
                        c_idx = data.c_ar[0].c_idx;
                    }
                }else{
                    str = "<option>:::존재하는 과정이 없습니다:::</option>";
                    $("#menu_list").html("<li id='l_five'><a onclick='list(5)'>일정보기</a></li>");
                
                    location.href = "staffMain?leftList=5&c_idx="+c_idx;
                }
                
                $("#select_course").html(str);
                
                $.ajax({
                    url: "s_diary_ajax",
                    type:"post",
                    data:"listSelect=1&cPage=1&c_idx="+c_idx,
                }).done(function(result){
                    $("#courseLog_Table").html(result);
                    //체크박스
                    checked();
                });
            });
            $("#select_course").change(function(){
                c_idx = this.value;
                $.ajax({
                    url: "s_diary_ajax",
                    type:"post",
                    data:"listSelect=1&cPage=1&c_idx="+c_idx,
                }).done(function(result){
                    $("#courseLog_Table").html(result);
                    checked();
                });
            }); 

            /* 마이페이지 ul 띄우기 숨기기 */
            $("#my_page").mouseover(function(){
                $("#mypage_ul").css("display","block")
            });
            $("#my_page").mouseout(function(){
                $("#mypage_ul").css("display","none")
            });
            $("#mypage_ul").mouseover(function(){
                $("#mypage_ul").css("display","block")
            });
            $("#mypage_ul").mouseout(function(){
                $("#mypage_ul").css("display","none")
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
            $("#write_btn").click(function(){
                $("#write_dialog").dialog({
                    width:1000,
                    modal:false,
                    maxHeight:900,
                    position: { my: "center top", at: "center top" }
                });
                $.ajax({
                    url:"s_tl_dialog",
                    type:"post",
                    data:"c_idx="+c_idx
                }).done(function(result){
                    $("#write_dialog").html(result);
                    $("#cc_cancle").click(function(){
                        $("#write_dialog").dialog("close") 
                    })
                    value = $("#attend").val();
                    cnt = 4; // 시작값 4
                });
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
        function changePass(){
            /*패스워드 바꾸기*/
            $("#checkPassword").dialog({
                width:600,
            });
            $("#ppc_btn").click(function(){
                $("#checkPassword").dialog("close");
            })
            $("#ppchk_btn").click(function(){
                let value = $("#password").val();
                $.ajax({
                    url:"checkPass",
                    type:"post",
                    data:"sf_idx="+s_idx+"&password="+value,
                    dataType:"json",
                }).done(function(data){
                    if(data.sf_vo == null){
                        alert("비밀번호가 잘못되었습니다.");
                        $("#password").focus();
                        $("#password").val("");
                    }else{
                        $("#checkPassword").dialog("close");
                        alert("확인되었습니다.");
                        /*title보여주기 */
                        
                        $("#changePassword").dialog({
                            width:600,
                        });

                        $("#ppchange_btn").click(function(){
                            value = $("#password2").val();
                            $.ajax({
                                url:"changePass",
                                type:"post",
                                data:"sf_idx="+s_idx+"&password="+value,
                                dataType:"json",
                            }).done(function(data){
                                if(data.cnt ==1){
                                    alert("변경되었습니다.다시 로그인해주세요")
                                    $("#changePassword").dialog("close");
                                    location.href ="logoutlll";
                                }else{
                                    alert("변경 실패")
                                    $("#changePassword").dialog("close");
                                }
                                
                            });
                        });
                    }
                });
            });
           
        }
        function changeMe(){
            $("#checkPassword").dialog({
                width:600,
            });
            $("#ppc_btn").click(function(){
                $("#checkPassword").dialog("close");
            });

            $("#ppchk_btn").click(function(){
                let value2 = $("#password").val();
                $.ajax({
                    url:"checkPass",
                    type:"post",
                    data:"sf_idx="+s_idx+"&password="+value2,
                    dataType:"json",
                }).done(function(data){
                    if(data.sf_vo == null){
                        alert("비밀번호가 잘못되었습니다.");
                        $("#password").focus();
                        $("#password").val("");
                    }else{
                        $("#checkPassword").dialog("close");
                        
                        alert("확인되었습니다.");
                        $.ajax({
                            url:"changeMe",
                            type:"post",
                            data:"sf_idx="+s_idx,
                        }).done(function(result){
                            $("#dialog").dialog({
                                width: 800,
                            });
                            $("#dialog").html(result);

                            $("#mec_btn").click(function(){
                                $("#dialog").dialog("close");
                            })
                            $("#meedit_btn").click(function(){
                                let frm = document.me_form;
                                let sf_id = frm.sf_id.value;
                                let sf_email = frm.sf_email.value;
                                let sf_phone = frm.sf_phone.value;

                                $.ajax({
                                    url:"editMe",
                                    type:"post",
                                    data:"sf_idx="+s_idx+"&sf_id="+sf_id+"&sf_email="+sf_email+"&sf_phone="+sf_phone,
                                    dataType:"json",
                                }).done(function(data){
                                    if(data.cnt ==1){
                                        alert("변경되었습니다.")
                                        $("#dialog").dialog("close");
                                    }else{
                                        alert("변경 실패")
                                        $("#dialog").dialog("close");
                                    }
                                })
                            });

                        });
                    }
                });
            });
            


           
        }
        function cancle(str){
            $("#"+str).dialog("close");
        }

        function list(num){
            // 메뉴 클릭시 해당 메뉴로 이동한다.
            // 즉시 이동시에는 무조건 c_idx의 값을 가져가고 초기에 그 값으로 세팅해 주어야한다 
            // $("op"+c_idx).attr("selected",true);
            if(num=="1"){
                location.href = "staffMain?leftList=1&c_idx="+c_idx;
            }else if(num =="2"){
                location.href = "staffMain?leftList=2&c_idx="+c_idx;
            }else if(num =="3"){
                location.href = "staffMain?leftList=3&c_idx="+c_idx;
            }else if(num =="4"){
                location.href = "staffMain?leftList=4&c_idx="+c_idx;
            }else if(num =="5"){
                location.href = "staffMain?leftList=5&c_idx="+c_idx;
            }
        }
        function paging(str){
            cPage = str;
            $.ajax({
                url: "s_diary_ajax",
                type:"post",
                data:"listSelect=1&cPage="+cPage+"&c_idx="+c_idx,
            }).done(function(result){
                $("#courseLog_Table").html(result);
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
                    alert("등록된 시간표가 존재하지 않습니다. 시간표를 관리하기 위해서는 관리자에게 문의해주세요.")
                }else{
                    //주간시간표
                    dataSetting(data.w_list,data.page,data.week_ar,frm.write_date.value);
                }
                
            });
            
      
    }

    function dataSetting(list,page,week_ar,write_date,view){
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
        if(time_ar == null){
            if(view != null){
                $("#innerText").html("<tr><td colspan='4'>등록된 시간표가 없습니다.</td></tr>");
            }else{
                alert("해당 날짜의 등록된 일정이 없습니다.")
            }
        }
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
                location.href="s_delTraining?td_idx="+td_idx+"&c_idx="+c_idx;
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
                url:"s_viewTraining",
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
                });
                
        
            });
        }
        function editTraining(td_idx2){
            $.ajax({
                url:"s_editTraining",
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
    </script>
</body>
</html>