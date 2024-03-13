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
                <header>&nbsp;&nbsp;상담관리</header>
                <div> 
                    <ul>
                        <jsp:include page="./leftList.jsp"></jsp:include>
                    </ul>
                </div>
                <!-- 메인 컨텐츠가 들어오는 영역-->
                <div class="right">
                    <div id="staffWrap">
                        <div id="counselList_top" class="title">교육생별 상담관리 검색</div>
                        <div id="ttop" class="main_item align_right">
                              <button type="button" onclick="set()" class="btn">상담일괄등록</button>   
                        </div>
                        <div id="counsel_Table">
      
                        </div>
                     </div>
				</div>
            </div> 
        </article>
    </article>
    <form name="frm" action="counsel" method="post">
        <input type="hidden" name="so_idx" value="" />
        <input type="hidden" name="c_page" value="1" />
        <input type="hidden" name="c_idx" value="" />
        <input type="hidden" name="listSelect" value="4" />
     </form>
     
     
     <div id="dialog" hidden="" title="상담 일괄등록"></div>   
     <div id="dialog2" hidden="" title="상담내역 및 등록"></div>
     <div id="dialog3" hidden="" title="상담등록"></div>
     <div id="dialog4" hidden="" title="상담수정"></div>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
    <script>
        let select ="4";
        let select_year = "";
        let numPerPage = "";
        let value ="";
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
            $("#l_one").addClass("subSelect");
            $.ajax({
               url: "counselMain",
               type: "post",
               data:"type="+encodeURIComponent("counselMain")+"&listSelect="+encodeURIComponent("4")+"&cPage="+encodeURIComponent('1')+"&c_idx="+encodeURIComponent('${param.c_idx}'),
            }).done(function(result){
               $("#counsel_Table").html(result);
            });
         
         
         let now = new Date();   // 현재 날짜 및 시간
         let year = now.getFullYear();
         let str = "<option>년도선택</option>";
         
         for(let i=year+1; i>year-5; i--){
            str+= "<option value="+i+">"+i+"</option>";
         }      
         

         });   

         function set() {
         $.ajax({
            url:"ss_dialog",
            type:"post",
            data:"&select="+encodeURIComponent("uploadAllCounsel")+"&c_idx="+encodeURIComponent("${param.c_idx}"),
         }).done(function(result){
            $("#dialog").dialog("open");
            $("#dialog").html(result);
            
            $("#cl").click(function(){
                $("#dialog").dialog("close");
            });
         });
         
        }
      function counselList(tr_idx) {
         $.ajax({
            url:"ss_dialog",
            type:"post",
            data:"&select="+encodeURIComponent("counselList")+"&c_idx="+encodeURIComponent("${param.c_idx}")+"&tr_idx="+encodeURIComponent(tr_idx),
         }).done(function(result){
         $("#dialog2").dialog("open");
            $("#dialog2").html(result);
            
            $("#cc_cancle").click(function(){
                $("#dialog2").dialog("close");
            });
         });
        }      

      function counselListAdd(tr_idx, c_idx) {
         $.ajax({
            url:"ss_dialog",
            type:"post",
            data:"&select="+encodeURIComponent("counselListAdd")+"&c_idx="+encodeURIComponent("${param.c_idx}")+"&tr_idx="+encodeURIComponent(tr_idx),
         }).done(function(result){
         $("#dialog3").dialog("open");
            $("#dialog3").html(result);
            
            $("#close").click(function(){
                $("#dialog3").dialog("close");
            });
         });
        }
         function del(so_idx,c_idx){
            if(confirm("삭제하시겠습니까?")){
               frm.action = "delCounsel";    
               document.frm.so_idx.value =so_idx;
               document.frm.c_idx.value =c_idx;
               document.frm.submit();
            
            }
         }
         function update(frm){
            //수정 버튼을 눌렀을때 폼을 보내서 수정한다.
            frm.submit();
         }
        function editCounsel(so_idx, tr_idx) {
            $.ajax({
               url:"ss_dialog",
               type:"post",
               data:"&select="+encodeURIComponent("editCounsel")+"&tr_idx="+encodeURIComponent(tr_idx)+"&so_idx="+encodeURIComponent(so_idx),
            }).done(function(result){
            $("#dialog4").dialog("open");
               $("#dialog4").html(result);

               $("#close").click(function(){
                  $("#dialog4").dialog("close");
               });
            });
        }
        
      function paging(str, c_idx) {
         $.ajax({
            url: "searchCounsel",
            type: "post",
            data:"type="+encodeURIComponent("searchCounsel")+"&select="+encodeURIComponent(select)+"&value="+encodeURIComponent(value)+"&year="+encodeURIComponent(select_year)
               +"&num="+encodeURIComponent(numPerPage)+"&listSelect="+encodeURIComponent('4')+"&cPage="+encodeURIComponent(str)+"&c_idx="+encodeURIComponent(c_idx),
         }).done(function(result){
            $("#counsel_Table").html(result);
         });
      }
      $("#dialog").dialog({
            autoOpen: false,
            width:1500,
            modal: true,
      });


     $("#dialog2").dialog({
      autoOpen: false,
            width:1500,
            modal: true,

     });

     $("#dialog3").dialog({
      autoOpen: false,
            width:1000,
            modal: true,

     });

     $("#dialog4").dialog({
      autoOpen: false,
            width:1200,
            modal: true,

     });
     function total_add(frm){
      frm.submit();
     }
    </script>
</body>
</html>