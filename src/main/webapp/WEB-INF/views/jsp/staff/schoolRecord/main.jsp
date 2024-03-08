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
<body bgcolor="#eeeeee"> 
    <jsp:include page="${pageContext.request.contextPath }/WEB-INF/views/jsp/top_head.jsp"></jsp:include>
    <div id="course_wrap">
        <select class="select" id="select_course" >
            <option>과정을 선택 해주세요</option>
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
            <div id="courseLog_Table" class="main_item" style="color: #154790; font-weight: bold;">
                <span class="man">●</span>남자 
                <span class="woman">●</span>여자 
                <span class="giveup">■</span>수강포기
                <span class="employ">■</span>조기취업
                <span class="finish">■</span>조기수료
                <span class="none">■</span>미수료
                <span class="weeding">■</span>제적
                <div align="right">
                    <button type="button" class="btn" style="margin-right: 3px;" onclick="allGradeList('${param.c_idx}')">훈련생종합성적표</button> 
                </div>
            </div>
            <div id="btn_area" class="main_item align_center">
                <button type="button" class="btn" onclick="btn1(1)">정보변경</button> 
                <button type="button" class="btn" onclick="btn1(2)">신상기록부</button> 
                <button type="button" class="btn" onclick="btn1(3)">사후관리카드</button> 
                <button type="button" class="btn" onclick="btn1(5)">상담관리</button> 
                <button type="button" class="btn" onclick="btn1(6)">성적표</button> 
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
        <div id="btn_dialog" hidden>
            <div id="btn_title" class="title"></div>
            <div id="btn_content"></div>
        </div>
        <div id="detail_dialog" hidden></div>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script>
        //로그인된 강사 정보 가져오기
        let s_idx = "${vo.sf_idx}";
        // 선택된 과정 정보 가지고오기
        let c_idx ="";
        let selectTr=""; //훈련생
        let length = 0;
        $(function(){	
            c_idx = "${param.c_idx}";
            $(".selected").removeClass("selected")
            $("#l_four").addClass("selected")
            console.log(s_idx);
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
                }else{
                    str = "<option>:::존재하는 과정이 없습니다:::</option>";
                    $("#menu_list").html("<li id='l_five'><a onclick='list(5)'>일정보기</a></li>");
                    $("#l_five").addClass("selected");
                }
            
                $("#select_course").html(str);
                $.ajax({
                    url: "traineeTotal",
                    type: "post",
                    data:"listSelect="+encodeURIComponent("2")+"&c_idx="+c_idx
                }).done(function(result){
                    let html = `<span class='man'>●</span>남자
                                <span class='woman'>●</span>여자
                                <span class='giveup'>■</span>수강포기
                                <span class='employ'>■</span>조기취업
                                <span class='finish'>■</span>조기수료
                                <span class='none'>■</span>미수료
                                <span class='weeding'>■</span>제적
                                <div align='right'><button type='button' class='btn' style='margin-right: 3px;' onclick='allGradeList("${param.c_idx}")'>훈련생종합성적표</button>
                                </div>`;
                    $("#courseLog_Table").html(html+result);
                    length = $("#t_ar_length").val();
                });

            });

            $("#select_course").change(function(){
                c_idx = this.value

                $.ajax({
                    url: "traineeTotal",
                    type: "post",
                    data:"listSelect="+encodeURIComponent("2")+"&c_idx="+c_idx
                }).done(function(result){
                    let html = `<span class='man'>●</span>남자
                                <span class='woman'>●</span>여자
                                <span class='giveup'>■</span>수강포기
                                <span class='employ'>■</span>조기취업
                                <span class='finish'>■</span>조기수료
                                <span class='none'>■</span>미수료
                                <span class='weeding'>■</span>제적
                                <div align='right'><button type='button' class='btn' style='margin-right: 3px;' onclick='allGradeList("`+c_idx+`")'>훈련생종합성적표</button>
                                </div>`;
                    $("#courseLog_Table").html(html+result);
                    length = $("#t_ar_length").val();
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
        });
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
                                    location.href ="logout";
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
        function traineeSelect(tr_idx,tt){
            selectTr =tr_idx;
            $(".tr_select").removeClass("tr_select");
            tt.setAttribute('class','info tr_select');
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
        
        function btn1(num){
            //btn_content
            
            if(length == 0){
                alert("해당 과정의 훈련생이 없습니다. 훈련생을 등록하세요.")
            }else{
                let ar = $(".tr_select");
                if(ar.length == 0){
                    alert("훈련생을 선택하세요.")
                    return;
                }
                if(num==1){
                    //정보변경
                    $("#btn_content").html("");
                    $("#btn_title").html("정보변경")
                    $("#btn_dialog").dialog({
                        width:1200,
                        maxHeight:900,
                        position: { my: "center top", at: "center top" }
                    })
                    $.ajax({
                        url:"s_traineeEdit",
                        type:"get",
                        data:"tr_idx="+selectTr+"&c_idx="+c_idx,
                    }).done(function(result){
                        $("#btn_content").html(result);

                        for(let i=1;i<=10;i++){
                            //console.log($("#op"+i).val());
                            if($("#op"+i).val() ==$("#nowstatus").val()){
                                $("#op"+i).attr("selected",true);
                            }
                            
                        }
                        $("#list_btn").click(function(){
                            $("#btn_dialog").dialog("close");
                        })

                        $("#cancel_date").change(function(){
                            alert("제적/취소일을 등록하시면 상태가 변경됩니다.");
                      
                            let date1 = new Date($("#start_date").val()); //개강일
                            let date2 = new Date($(this).val()); //취소일
                            if(date1>date2){    
                                //취소
                                //op10
                                $("#op10").attr("selected",true);
                            }else{
                                //제적
                                //op9
                                $("#op9").attr("selected",true);
                            }
                            
                        });
                    })
                }else if(num ==2){
                    //신상기록부
                    $("#btn_content").html("");
                    $("#btn_title").html("신상기록부")
                    $("#btn_dialog").dialog({
                        width:1200,
                        maxHeight:900,
                        position: { my: "center top", at: "center top" }
                    })
                    //traineewrite
                    $.ajax({
                        url: "s_traineewrite",
                        type: "post",
                        data:"tr_idx="+selectTr+"&c_idx="+c_idx
                     }).done(function(result){
                        $("#btn_content").html(result);
                        $("#writec_btn").click(function(){
                            $("#btn_dialog").dialog("close");
                        })
                     });
                }else if(num ==3){
                    //사후관리카드
                    $("#btn_content").html("");
                    $("#btn_title").html("사후관리카드")
                    $("#btn_dialog").dialog({
                        width:1200,
                        maxHeight:900,
                        position: { my: "center top", at: "center top" }
                    })
                    
                    
                    $.ajax({
                        url: "s_mangecard",
                        type: "post",
                        data:"tr_idx="+selectTr+"&c_idx="+c_idx,
                     }).done(function(result){
                        $("#btn_content").html(result);
                        $("#afterC_btn").click(function(){
                            $("#btn_dialog").dialog("close");
                        })
                     });
                     
                }else if(num ==5){
                    //상담관리
                    
                    $("#btn_title").html("상담관리")
                    $("#btn_content").html("");
                    $("#btn_dialog").dialog({
                        width:1200,
                        maxHeight:900,
                        position: { my: "center top", at: "center top" }
                    })

                    $.ajax({
                        url: "s_counseling",
                        type: "post",
                        data:"tr_idx="+selectTr+"&c_idx="+c_idx
                     }).done(function(result){
                        $("#btn_content").html(result);
                        $("#c_canclebtn").click(function(){
                            $("#btn_dialog").dialog("close")
                        })
                     });


                }else if(num == 6){
                    //성적표
                    $("#btn_title").html("성적표")
                    $("#btn_content").html("");
                    $("#btn_dialog").dialog({
                        width:1200,
                        maxHeight:900,
                        position: { my: "center top", at: "center top" }
                    })
                }
            }
           
        }
        function sendData(fff){
            fff.submit();
        }	
        function checkPost() {
            new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("sample6_extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("sample6_extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode;
                document.getElementById("sample6_address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("sample6_detailAddress").focus();
            }
        }).open();
    }
    function sendwrite(qqq){
        qqq.submit();
    }
    
    function editform(qwe){
        qwe.submit();
    }
    function c_detail(so_idx){
        $("#detail_dialog").dialog({
            width:1200,
            maxHeight:900,
            position: { my: "center top", at: "center top" }
        })
        console.log(so_idx);
        $.ajax({
            url:"s_counseling_detail",
            type:"post",
            data:"so_idx="+so_idx+"&tr_idx="+selectTr,
        }).done(function(result){
            //console.log(result)
            $("#detail_dialog").html(result)

            // option태그 수정
            let ar = $(".opmenu")
            for(let i =0;i<ar.length; i++){
                if(ar[i].value === $("#so_menu_value").val()){
                    $(ar[i]).attr("selected",true);
                }
            }
            $("#close").click(function(){
                $("#detail_dialog").dialog("close")
            })

            
        })
    }
    function del_counsel(so_idx,c_idx){
        if(confirm("삭제하시겠습니까?")){
            $.ajax({
                url:"s_delCounsel",
                type:"post",
                data:"so_idx="+so_idx,
                dataType:"json"
            }).done(function(data){
                if(data.cnt == 1){
                    alert("삭제되었습니다.")
                }else{
                    alert("삭제 실패");                   
                }
                $("#detail_dialog").dialog("close");
                $("#btn_dialog").dialog("close");
                btn1("5");
            });
        }
     }

     function update_counsel(frm){
        let so_day = frm.so_day.value;
        let so_tname = frm.so_tname.value;
        let so_menu = frm.so_menu.value;
        let so_pd = frm.so_pd.value;
        let so_idx = frm.so_idx.value;
        let so_subject = frm.so_subject.value;
        if(confirm("수정하시겠습니까?")){
            $.ajax({
                url:"s_updateCounsel",
                type:"post",
                data: "so_day="+so_day+"&so_tname="+so_tname+"&so_menu="+so_menu+"&so_pd="+so_pd+"&so_idx="+so_idx+"&so_subject="+so_subject,
                dataType:"json"
            }).done(function(data){
                if(data.cnt == 1){
                    alert("수정되었습니다.")
                }else{
                    alert("수정 실패");                   
                }
                $("#detail_dialog").dialog("close");
                $("#btn_dialog").dialog("close");
                btn1("5");
            });
        }
     }
    function add_counsel(){
        $("#detail_dialog").dialog({
            width:1200,
            maxHeight:900,
            position: { my: "center top", at: "center top" }
        })
        console.log(selectTr)
        $.ajax({
            url:"s_add_counsel",
            type:"post",
            data:"tr_idx="+selectTr,
        }).done(function(result){

            $("#detail_dialog").html(result)

            $("#close").click(function(){
                $("#detail_dialog").dialog("close")
            })
            
        })
	}
    function total_add(frm){
        frm.submit();
        
    }

    function allGradeList(c_idx){
        console.log(c_idx);
        $("#dialog").dialog("open");
        $.ajax({
			url: "allGrade_ajax_s",
			type:"post",
			data:"c_idx="+c_idx,
		}).done(function(result){
			$("#dialog").html(result);
		});
    }
    $("#dialog").dialog({
        autoOpen: false,
        maxHeight: 900,
        width: 1200,
        modal: true,
    });




    </script>
</body>
</html>