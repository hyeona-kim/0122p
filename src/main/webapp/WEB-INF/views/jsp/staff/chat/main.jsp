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
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/fullcalendar2.css"/>
</head>
<style>
  #chat{
    width: 800px;
    height: 98%;
    display: flex;
    margin: auto;
    margin-top: 5px;
  }


  #chat> div{
    display: inline-block;
    height: 100%;
  }
  #chat>div:first-child{
    width: 150px;
    background-color:#154790 ;
    text-align: center;

  }

  #chat>div:first-child>#trainees{
    overflow-y: scroll;
    display: inline-block;
    width: 100%;
    height: 85%;
  }
  #chat>div:last-child{
    width: 650px;
    background-color: #dedede;
  }
  #chat>div:last-child>article{
    width: 100%;
    height: 7%;
  
    
  }
  #chat>div:last-child>article:first-child{
    font-size: 30px;
    line-height: 6.3vh;
    text-align: center;
    color: #154790;
    font-weight: bold;
  }
  #chat>div:last-child>article:last-child{
    display: flex;
    height: 93%;
  }
  #chat>div:last-child>article:last-child>div{
    display: inline-block;
    height: 100%;
    width: 50%;
    border: 1px solid red;
  }
  #chat>div:first-child span{
    display: inline-block;
    width: 100px;
    height: 100px;
    background-color: #ffffff;
    border-radius: 50%;
    text-align: center;
    line-height: 100px;
    margin-top: 10px;
  }
    #chat>div:first-child>#trainees>.tr_name{
        color: white;
        font-weight: bold;
        height: 30px;
        line-height: 30px;
    }
  #chat>div:first-child>h2{
    width: 100%;
    border: 1px solid white;
    margin: 0%;

  }
</style>
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
            <div><button type="button" onclick="location.href='ffffff'">채팅방이동</button></div>
            <div id ="chat">
                <div id="mem">
                    <span>${vo.sf_name}</span>
                    <h2></h2>
                    <h4 id="trainees"></h4>
                </div>
                <div id="chat_content">
                    <article id="c_name"></article>
                    <article>
                        <div id="your"></div>
                        <div id="me"></div>
                    </article>
                </div>   
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
        </div>+
    </article>
    <div id="dialog" hidden></div>
    <div id="dialog2" hidden></div>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
    <script src="${pageContext.request.contextPath }/js/fullcalendar.js"></script>
    <script src="${pageContext.request.contextPath }/js/lang/ko.js"></script>
 
    <script>
        //로그인된 강사 정보 가져오기
        let s_idx = "${vo.sf_idx}";
        // 선택된 과정 정보 가지고오기
        let c_idx ="";
        $(function(){	
            c_idx = "${param.c_idx}";
            $(".selected").removeClass("selected")
            $("#l_six").addClass("selected")
            
            $.ajax({
                url:"traineeList",
                type: "post",
                data: "c_idx="+c_idx,
                dataType: "json",
            }).done(function(res){
                console.log(res);//trainees
            });
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
                            $("#c_name").html(data.c_ar[i].c_name)
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
                $("#c_name").html($(".op"+c_idx).html())
                console.log(c_idx);
                $.ajax({
                    url:"traineeList",
                    type: "post",
                    data: "c_idx="+c_idx,
                    dataType: "json",
                }).done(function(res){
                    console.log(res);//trainees
                    let str="";
                    if(res.tr_ar !=null){
                        for(let i=0; i <res.tr_ar.length;i++){
                            str+= "<div class='tr_name'>"+res.tr_ar[i].tr_name+"</div>"
                        }
                    }
                    $("#trainees").html(str);
                    
                });
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

    </script>
</body>
</html>