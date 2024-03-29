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
</head>
<body bgcolor="#eeeeee"> 
    <jsp:include page="${pageContext.request.contextPath }/WEB-INF/views/jsp/top_head.jsp"></jsp:include>
    <div id="course_wrap">
        <select class="select" id="select_course" >
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
                 <!--<li id='l_six'><a onclick="list(6)">채팅방</a></li>-->
            </ul>
        </div>
        <div class="right">
        <hr/>
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

    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
    <script>
        //로그인된 강사 정보 가져오기
        let s_idx = "${vo.sf_idx}";
        // 선택된 과정 정보 가지고오기
        let c_idx ="";
        $(function(){	
            c_idx = "${param.c_idx}";
            $(".selected").removeClass("selected")
            $("#l_two").addClass("selected")
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
                        if(c_idx == data.c_ar[i].c_idx){
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
                    url: "diary_ajax_s",
                    type:"post",
                    data:"listSelect=1&cPage=1&c_idx="+c_idx,
                }).done(function(result){
                    $("#courseLog_Table").html(result);
                    //체크박스
                });
            });
            $("#select_course").change(function(){
                c_idx = this.value;
                $.ajax({
                    url: "diary_ajax_s",
                    type:"post",
                    data:"listSelect=1&cPage=1&c_idx="+c_idx,
                }).done(function(result){
                    $("#courseLog_Table").html(result);
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
            $("#select_course").change(function(){
                c_idx = this.value;
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
            }else if(num =="6"){
                location.href = "staffMain?leftList=6&c_idx="+c_idx;
            }else if(num =="4"){
                location.href = "staffMain?leftList=4&c_idx="+c_idx;
            }else if(num =="5"){
                location.href = "staffMain?leftList=5&c_idx="+c_idx;
            }
        }
        function evaInfo(s_idx) {
            $.ajax({
                url: "diary_ajax_ss",
                type:"post",
                data:"listSelect=1&cPage=1&c_idx="+c_idx+"&s_idx="+s_idx,
            }).done(function(result){
                $("#courseLog_Table").html(result);
            });
        }

        function examInput(s_idx) {
            $.ajax({
                url: "diary_ajax_ss",
                type:"post",
                data:"listSelect=2&cPage=1&c_idx="+c_idx+"&s_idx="+s_idx,
            }).done(function(result){
                $("#courseLog_Table").html(result);
            });
        }

        function editEI(idx){
            $("#dialog").dialog("open");
            $.ajax({
                url: "es_dialog_s",
                type:"post",
                data:"es_idx="+idx+"&s_idx="+s_idx+"&c_idx="+c_idx,
            }).done(function(result){
                $("#dialog").html(result);
                $("#cc_cancle").click(function(){
                    $("#dialog").dialog("close");
                });
                type = $("#selectType").val();
                if(type == '1')
                    $('#totalQuestions').val($("#q1").val());
                else
                    $("#totalQuestions").val($('#q2').val() + "/" + $('#q3').val());
                console.log($("#totalQuestions").val());
                $("#selectType").on("change", function(){
                    type = $("#selectType").val();
                    switch(type){
                        case "1" :{
                            $("#selectType1").show();
                            $("#selectType2").hide();
                            break;
                        }
                        case "2" :{
                            $("#selectType1").hide();
                            $("#selectType2").show();
                            break;
                        }
            
                    }
                });
                $("#q1, #q2, #q3").change(function() {
                        console.log("type+"+type);
                        // 필답형과 단답형 값이 변경될 때마다 합산하여 총 문항수 필드에 넣기
                        if(type == "1"){
                            $('#totalQuestions').val($("#q1").val());
                        }
                        else{
                            $('#totalQuestions').val( $('#q2').val() + "/" + $('#q3').val()); // 합산된 값을 총 문항수 필드에 넣기
                            console.log($('#totalQuestions').val());

                        }
                    });
            });
        }

        $("#dialog").dialog({
			autoOpen: false,
			maxHeight: 900,
			width: 1200,
			modal: true,
        });

       

        function delEs(es_idx){
            
			if( confirm("삭제하시겠습니까?")){
			
                location.href = "delEvaluationStatus_s?es_idx="+es_idx+"&s_idx="+s_idx+"&c_idx="+c_idx;
			}else{
                return;
            }
		}

        function traineeEvaList(es_idx){
            $("#dialog").dialog("open");
            $.ajax({
                url: "list_ajax_s",
                type:"post",
                data:"listSelect=1&es_idx="+es_idx+"&c_idx="+c_idx,
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

        function addEvidence(){
            $("#dialog").dialog("open");
            $.ajax({
                url: "es_dialog2",
                type:"post",
                data:"listSelect=1",
            }).done(function(result){
                $("#dialog").html(result);
             
            });
        }
        function viewExam(es_idx){
            $("#dialog").dialog("open");
            $.ajax({
                url: "es_dialog2",
                type:"post",
                data:"listSelect=2&es_idx="+es_idx+"&s_idx="+s_idx,
            }).done(function(result){
                $("#dialog").html(result);
             
            });
        }

        function editExam(es_idx){
            $("#dialog").dialog("open");
            $.ajax({
                url: "es_dialog2_s",
                type:"post",
                data:"listSelect=5&es_idx="+es_idx+"&s_idx="+s_idx+"&c_idx="+c_idx,
            }).done(function(result){
                $("#dialog").html(result);
                
            });
        }

        function edit(idx, t, score, num){
            let v = 0;
            let id = "qt_score";
            for(let i=0;i < num; i++){
                v += Number($("input[name='"+ id +"']").eq(i).val()); // ... 정수로 변환해서 계산...
                console.log(v + "캥");
            }
            if(score != v){
                alert("총점:" + score + " 배분값:" + v);
                alert("총점보다 값이 크거나 작습니다. 점수를 다시 배분해주세요!");
                return ;
            }
            if(t == "2"){ // 객관식이 있을 경우에만 병합 실행

                id = "qt_select";
                let box = $("#box").html();
                let k ="";
                for(let i=1; i<=idx; i++ ){
                    let a = "";
                    for(let j = 0;j < $("input[name='" + id + i + "']").length;){
                        a += $("input[name='" + id + i + "']").eq(j).val();
                        if(++j < $("input[name='" + id + i + "']").length){
                            a += "│"; // 객관식 문항을 구분하기 위한 구분자이므로 잘 쓰지않는 특수기호를 골라서 사용함
                        }
                    }
                    k += "<input type='hidden' value='" + a + "' name='qt_select' />";
                }
                $("#box").html(box + k);
            } // 주관식 및 서술형의 경우 즉시 이부분으로 옴
            $("#frm").submit();
        }
        
        function delExam(idx){
            if(confirm("삭제하시겠습니까?")){
                alert("삭제되었습니다.")
                location.href="delExam_s?es_idx="+idx+"&s_idx="+s_idx+"&c_idx="+c_idx;
            } else{
                return;
            }
        }


        function examFill(es_idx){
            $("#dialog").dialog("open");
            $.ajax({
                url: "es_dialog2_s",
                type:"post",
                data:"listSelect=3&es_idx="+es_idx+"&s_idx="+s_idx,
            }).done(function(result){
                $("#dialog").html(result);
                
            });
        }

        function addSelect(idx){
            let str = $('#selectExam'+idx).html();
            let id = "idx"+idx;
            let i =  $("input[name='"+id+"']").last().val();
            let str2 = "</br><input type='text' value='" + ++i + "' class='text' style='width: 10%' name='" + id + "' readonly />"
            + "<input type='text' name='qt_select" + idx + "' value='' class='text' style='width: 70%'  placeholder='객관식 문항" + i + "'/>"
            $("#selectExam"+idx).html(str + str2);
        }

        function addExam(idx, t, score, num){
            let v = 0;
            let id = "qt_score";
            for(let i=0;i < num; i++){
                v += Number($("input[name='"+ id +"']").eq(i).val()); // ... 정수로 변환해서 계산...
                console.log(v);
            }
            if(score != v){
                alert("총점:" + score + " 배분값:" + v);
                alert("총점보다 값이 크거나 작습니다. 점수를 다시 배분해주세요!");
                return ;
            }
            if(t == "2"){ // 객관식이 있을 경우에만 병합 실행

                id = "qt_select";
                let box = $("#box").html();
                let k ="";
                for(let i=1; i<=idx; i++ ){
                    let a = "";
                    for(let j = 0;j < $("input[name='" + id + i + "']").length;){
                        a += $("input[name='" + id + i + "']").eq(j).val();
                        if(++j < $("input[name='" + id + i + "']").length){
                            a += "│"; // 객관식 문항을 구분하기 위한 구분자이므로 잘 쓰지않는 특수기호를 골라서 사용함
                        }
                    }
                    k += "<input type='hidden' value='" + a + "' name='qt_select' />";
                }
                $("#box").html(box + k);
            } // 주관식 및 서술형의 경우 즉시 이부분으로 옴
            $("#frm").submit();
        }

        function editExam(es_idx){
            $("#dialog").dialog("open");
            $.ajax({
                url: "es_dialog2",
                type:"post",
                data:"listSelect=5&es_idx="+es_idx+"&s_idx="+s_idx,
            }).done(function(result){
                $("#dialog").html(result);
                
            });
        }

       
        
        
    </script>
</body>
</html>