<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.logo{
    width: 80%;
    margin: 15px auto;
}
 .top{
    display: flex;
    width: 80%;
    margin: auto;
 }   
 .top>div{
    display: inline-block;
    width: 50%;
    height: 400px;
 }
 .top>div:first-child>img{
    display: inline-block;
    width: 100%;
    height:100%;
    border-radius: 20px 20px;
    margin-bottom: 0;
 }
 .list{
    height: 450px;
    width: 80%;
    background-color: #dedede;
    border-radius: 20px 20px;
    margin: auto;
    display: flex;
    justify-content: space-evenly;
 }
 .list>div{
    display: inline-block;
    width: 17%;
    height: 380px;
    margin-top: 38px;
    background-color: white;
    border-radius: 10px 10px;
 }
 .list>div:active, .list>div:hover{
    background-color: #dedede;
 }
 .list>div>div{
    width: 70%;
    height: 300px;
    margin: auto;
    margin-top: 40px;
 }
 .list>div>div>div:first-child{
   height: 100px;
   font-size: 35px;
   line-height: 100px;
   text-align: center;
   color: #154790;
   font-weight: bold;
 }
 .list>div>div>div:last-child{
    margin: auto;
    width: 70%;
    margin: 20px auto;
 }
 #school{
    line-height: 50px;
 }

 .list>div>div>div>img{
    display: inline-block;
    width: 100%;
    height: 100%;

 }
 .top>div:last-child{
    display: flex;
    justify-content: space-evenly;
    background-color: #154790;
    border-radius: 20px 20px;
 }
 .top>div:last-child>div{
    display: inline-block;
    width: 40%;
    height: 80%;
    border-radius: 20px 20px;
    background-color: #dedede;
    margin-top: 50px;
    display: flex;
    flex-direction: column;
    justify-content: space-evenly;
 }
 .top>div:last-child>div>div{
    height: 40px;
    line-height: 40px;
    text-align: center;
    font-size: 20px;
    color: #154790;
    width: 90%;
    margin: auto;
    border-radius: 10px 10px;
    background-color: white;
    font-weight: 550;
    font-size: 18px;
 }
 .top>div:last-child>div>div:hover,.top>div:last-child>div>div:active{
    background-color: #dedede;
    font-weight: 700;
 }
 .top>div:last-child>div>.none_div{
    background-color: #dedede;
 }
 .top>div:last-child>div>div:first-child{
    background-color: #dedede;
    text-align: center;
 }
 .top>div:last-child>div>div:first-child>img{
    display: inline-block;
    width: 100%;
    height: 100%;
 }
 .top>div:last-child>div>div:last-child{
    background-color: #dedede;
 }
 .top>div:last-child>div>div:last-child>a{
    text-decoration: none;
    color: #5283cc;
 }
 .top>div:last-child>div>div:last-child>a:hover{
    color: #154790;
 }
 .top>div:last-child>div>div:last-child>.disable, .top>div:last-child>div>div:last-child>.disable:hover{
    color: #ababab;
 }
</style>
</head>
<body>
    <article class="logo"><img alt="로고" src="${pageContext.request.contextPath }/image/ict_logo.png" /></article>
    <article class="top">
        <div>
            <img src="${pageContext.request.contextPath }/image/top_main4.jpg"/>
        </div>
        <div>
            <div id="course_log">
                <!--반복문 띄우기 쿨릭시 함수주기.(c_idx가지는 )-->
                
            </div>
            <div>

            </div>
        </div>
    </article>
    <article class="list">
        <div>
            <div  onclick="list(1)">
                <div id="school">학적부<br/>관리</div>
                <div> <img src="${pageContext.request.contextPath }/image/main1.png"/></div>
            </div>
        </div>
        <div>
            <div onclick="list(2)">
                <div  >통합관리</div>
                <div> <img src="${pageContext.request.contextPath }/image/main2.png"/></div>
            </div>
        </div>
        <div>
            <div  onclick="list(3)">
                <div >평가관리</div>
                <div> <img src="${pageContext.request.contextPath }/image/main3.png"/></div>
            </div>
        </div>
        <div>
            <div onclick="list(4)">
                <div  >상담 및 접수</div>
                <div> <img src="${pageContext.request.contextPath }/image/main4.png"/></div>
            </div>
        </div>
        <div>
            <div  onclick="list(5)">
                <div >상담관리</div>
                <div> <img src="${pageContext.request.contextPath }/image/main5.png"/></div>
            </div>
        </div>
    </article>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
    <script>
      
        $(function(){	

            $.ajax({
                url:"main_course",
                type:"post",
            }).done(function(result){
                $("#course_log").html(result);
            });
        });

        function list(num){
            // 메뉴 클릭시 해당 메뉴로 이동한다.
            if(num=="1"){
                location.href="menu?select=schoolRecord";
            }else if(num =="2"){
                location.href="menu?select=totalManage";
            }else if(num =="3"){
                location.href="menu?select=trainingLog";
            }else if(num =="4"){
                location.href="menu?select=counselReceipt";
            }else if(num =="5"){
                location.href="menu?select=counselManage";
            }
        
        }
        function course_log(c_idx){
            console.log(c_idx);
            location.href="trainingDiary?c_idx="+c_idx;
        }
        function paging(nowPage){
            $.ajax({
                url:"main_course",
                type:"post",
                data:"cPage="+nowPage,
            }).done(function(result){
                $("#course_log").html(result);
            });
        }
    </script>
</body>
</html>