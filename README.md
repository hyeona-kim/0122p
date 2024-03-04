# (2차) Model-View-Controller Pattern LMS Project
# (3차) SpringBoot-Project LMS
mvc패턴 평가관가관리 시스템 

## 📃 프로젝트 소개 
학생 관리 웹 시스템으로 온라인으로 학생들의 성적,출석 등을 관리하고 교육 전반에 걸쳐 관리자나 담당 강사가 학습을 평가하고 관리에 이르기까지 전반적인 과정들을 통합적으로 운영 및 관리하기 위한 웹 시스템입니다.

## 🖥️ 개발 기간
* 23.01.23일 ~ 24.02.02일 (2차)
* 24.02.02일 ~ (3차)

### 👫 멤버 구성
- 팀장 정재영 jeongjjy - 교과목 기능, 교육과정 게시판, 형상관리
- 팀원 이가은 Lee Ga Eun - 로그인 기능, 메인 페이지 구축, 전체적인 CSS, 카테고리 별 검색 기능, 검색결과에 따른 목록 페이지 구현 및 전체 페이지 페이징 구현, 형상관리 
- 팀원 조성훈 sannabie -  데이터베이스 테이블 생성 및 데이터 추가, 교직원, 학적부 게시판 ,형상관리, PPT 제작, 발표
- 팀원 우선우 tanksoda - 교육과정 리스트의 과정 타입 등록 및 추가 등 기능 구현 
- 팀원 김현아 hyeona-kim - 학생들 목록 페이지 출력 기능, 서류 등록 및 다운로드 등 기능, 형상관리
- 팀원 윤상기 sangkiYoon -

### ⚙️ 개발 환경
- `java 11`
- `JDK 11.0.18`
- **Database : Mysql 8.0 CE**
- **ORM : Mybatis**

## 📌 주요 기능 
- index 페이지 LoginAction 구동
  -- Action 실행시 클릭한 버튼에 따라 동일한 파라미터 (select)에 각각 다른값을 전달하여 파라미터에 담긴 값 (admin, teacher,trainee)중 하나를 가지고 이동할 경로 (viewPath)수정
  ![image](https://github.com/hyeona-kim/1221p/assets/45028751/f36ab6c6-7194-46d5-85ac-cd64be5682b2)
