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
                        <div id="staffList_top" class="title">과정별 교수계획서 및 학습 안내서</div>
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
                        </form>	
                        <div id="courseLog_Table">	
                            
                        </div>
                    </div>
				</div>
            </div> 
        </article>
    </article>
    <div id="dialog" hidden="" title="교육과정등록">	
        <!--학습 안내서를 등록하는 테이블 -->
    </div>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
    <script>
        let select ="1";
        let select_year = "";
        let numPerPage = "";
        let value ="";
        let cPage = 1;
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
                url: "courseMain",
                type: "post",
                data:"listSelect="+encodeURIComponent('${param.listSelect}')+"&cPage="+encodeURIComponent('${param.cPage}'),
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
                console.log("dd");
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
            cPage = str;
            $.ajax({
                url:"searchCourse",
                type:"post",
                data:"select="+encodeURIComponent(select)+"&value="+encodeURIComponent(value)+"&year="+encodeURIComponent(select_year)
                    +"&num="+encodeURIComponent(numPerPage)+"&listSelect="+encodeURIComponent('${param.listSelect}')+"&cPage="+encodeURIComponent(str),
            }).done(function(result){
                $("#courseLog_Table").html(result);
            });
        }

        function set(c_idx){
            //console.log(c_idx);
            //이 비동기 통신을 하면서fileVo객체를 받아온다 과정에대한 c_idx를 가지고가서 출력하고 그 과정명을h2태그에 띄어준다 
            
            $("#dialog").dialog("open");
            $.ajax({
                url:"course_file",
                type:"post",
                data:"cPage="+encodeURIComponent(cPage)+"&listSelect=2&c_idx="+c_idx
            }).done(function(result){
                $("#dialog").html(result);
                $("#cc_cancle2").click(function(){
                    $("#dialog").dialog("close");
                });
            });
            
        }

        $("#dialog").dialog({
            autoOpen: false,
            width:900,
            modal: true,
        });
    </script>
</body>
</html>