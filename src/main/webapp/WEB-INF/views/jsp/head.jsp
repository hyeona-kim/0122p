<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <input type="checkbox" id="menuicon"/>
    <div class="main_menu">
        <label for="menuicon" id="menubtn" >
            <span></span>
            <span></span>
            <span></span>
        </label>
        <ul class="navi">
            <li>
                <a href="counselReceipt?listSelect=1&cPage=1" class="menu1" id="first">상담 및 접수</a>
                <ul class="sub_manu" id="first">
                    <li>상담및접수</li>
                    <li><a href="counselReceipt?listSelect=1&cPage=1">&nbsp;&nbsp;&nbsp;면접평가표관리</a></li>
                    <li><a href="counselReceipt?listSelect=2&cPage=1">&nbsp;&nbsp;&nbsp;입학상담내역</a></li>
                    <li><a href="counselReceipt?listSelect=3&cPage=1">&nbsp;&nbsp;&nbsp;일일모집현황</a></li>
                    <li><a href="counselReceipt?listSelect=4&cPage=1">&nbsp;&nbsp;&nbsp;교육생등록현황</a></li>
                    <li><a href="counselReceipt?listSelect=5&cPage=1">&nbsp;&nbsp;&nbsp;수강생파일등록</a></li>
                </ul>
            </li>
            <li>
                <a href="course?listSelect=1&cPage=1" class="menu1">과정등록</a>
                <ul class="sub_manu">
                    <li>과정등록</li>
                    <li><a href="course?listSelect=1&cPage=1">&nbsp;&nbsp;&nbsp;교육과정현황</a></li>
                    <li><a href="course?listSelect=2&cPage=1">&nbsp;&nbsp;&nbsp;교수계획서 / 학습안내서</a></li>
                    <li><a href="course?listSelect=3&cPage=1">&nbsp;&nbsp;&nbsp;시간표만들기(HRD)</a></li>
                </ul>
            </li>
            <li>
                <a href="" class="menu1">학적부</a>
                <ul class="sub_manu">
                    <li>학적부</li>
                    <li><a href="suggestionList?cPage=1">&nbsp;&nbsp;&nbsp;고충 및 건의사항</a></li>
                    <li><a href="traincurrent">&nbsp;&nbsp;&nbsp;과정별 훈련생 현황</a></li>
                    <li><a href="trainupload">&nbsp;&nbsp;&nbsp;훈련생확인서류등록</a></li>
                    <li><a href="trainconfirm">&nbsp;&nbsp;&nbsp;훈련생확인서류관리</a></li>
                    <li><a href="boardMainList">&nbsp;&nbsp;&nbsp;게시판</a></li>
                </ul>
            </li>
            <li>
                <a href="" class="menu1">상담관리</a>
                <ul class="sub_manu">
                    <li>상담관리</li>
                    <li><a href="counsel?listSelect=1&cPage=1">&nbsp;&nbsp;&nbsp;과정별 상담관리</a></li>
                    <li><a href="counsel?listSelect=2&cPage=1">&nbsp;&nbsp;&nbsp;일자별 상담관리</a></li>
                    <li><a href="counsel?listSelect=3&cPage=1">&nbsp;&nbsp;&nbsp;교육생별 상담관리</a></li>
                </ul>
            </li>
            <li>
                <a href="" class="menu1">훈련일지</a>
                <ul class="sub_manu">
                    <li>훈련일지</li>
                    <li><a href="t_log?listSelect=1&cPage=1">&nbsp;&nbsp;&nbsp;훈련일지</a></li>
                    <li><a href="t_log?listSelect=2&cPage=1">&nbsp;&nbsp;&nbsp;보강훈련일지</a></li>                    
                </ul>
            </li>
            <li>
                <a href="" class="menu1">사전평가</a>
                <ul class="sub_manu"> 
                    <li>사전평가</li>
                </ul>
            </li>
            <li>
                <a href="" class="menu1">자기/수행평가</a>
                <ul class="sub_manu">
                    <li>자기/수행평가</li>
                </ul>
            </li>
            <li>
                <a href="" class="menu1">평가관리</a>
                <ul class="sub_manu">
                    <li>평가관리</li>
                </ul>
            </li>
            <li>
                <a href="" class="menu1">설문관리</a>
                <ul class="sub_manu">
                    <li>설문관리</li>
                </ul>
            </li>
            <li>
                <a href="" class="menu1">증서관리</a>
                <ul class="sub_manu">
                    <li>증서관리</li>
                </ul>
            </li>
            <li>
                <a href="" class="menu1">사후관리</a>
                <ul class="sub_manu">
                    <li>사후관리</li>
                </ul>
            </li>
            <li>
                <a href="" class="menu1">통합관리</a>
                <ul class="sub_manu">
                    <li>통합관리</li>
                    <li><a href="total?listSelect=1&cPage=1">&nbsp;&nbsp;&nbsp;과정별 통합관리</a></li>
                    <li><a href="total?listSelect=2&cPage=1">&nbsp;&nbsp;&nbsp;과정별 학생관리</a></li>
                    <li><a href="total?listSelect=3&cPage=1">&nbsp;&nbsp;&nbsp;일정관리</a></li>
                </ul>
            </li>
            <li>
                <a href="" class="menu1">자료실</a>
                <ul class="sub_manu">
                    <li>자료실</li>
                </ul>
            </li>
            <li>
                <a href="" class="menu1">커뮤니티</a>
                <ul class="sub_manu">
                    <li>커뮤니티</li>
                </ul>
            </li>
            <li>
                <a href="" class="menu1">로그현황</a>
                <ul class="sub_manu">
                    <li>로그현황</li>
                </ul>
            </li>
            <li>
                <a href="" class="menu1">기타관리</a>
                <ul class="sub_manu">
                    <li>기타관리</li>
                    <li><a href="staffList">&nbsp;&nbsp;&nbsp;&nbsp;교직원현황</a></li>
                    <li><a href="weeklyMeeting">&nbsp;&nbsp;&nbsp;&nbsp;주간회의록</a></li>	
                    <li><a href="formDownload">&nbsp;&nbsp;&nbsp;&nbsp;서식자료실</a></li>	
                    <li><a href="">&nbsp;&nbsp;&nbsp;&nbsp;훈련교재현황</a></li>	
                    <li><a href="">&nbsp;&nbsp;&nbsp;&nbsp;훈련시설현황</a></li>	
                    <li><a href="">&nbsp;&nbsp;&nbsp;&nbsp;훈련장비현황</a></li>	
                    <li><a href="">&nbsp;&nbsp;&nbsp;&nbsp;휴일일정관리</a></li>	
                </ul>
            </li>
            <li>
                <a href="" class="menu1">시스템문의</a>
            </li>
        </ul>
    </div>