package com.ict.project.control.front;

import java.util.ArrayList;
import java.util.Base64;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.Reader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.configurationprocessor.json.JSONException;
import org.springframework.boot.configurationprocessor.json.JSONObject;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.ict.project.service.GradeCheckService;
import com.ict.project.service.QuestionService;
import com.ict.project.service.SuggestionService;
import com.ict.project.service.TestService;
import com.ict.project.util.Paging;
import com.ict.project.util.Paging2;
import com.ict.project.vo.CourseTypeVO;
import com.ict.project.vo.CourseVO;
import com.ict.project.vo.EvaluationStatusVO;
import com.ict.project.vo.GradeCheckVO;
import com.ict.project.vo.MemberVO;
import com.ict.project.vo.QnaVO;
import com.ict.project.vo.QuestionVO;
import com.ict.project.vo.SubjectVO;
import com.ict.project.vo.StaffVO;
import com.ict.project.vo.SuggestionVO;
import jakarta.servlet.http.HttpServletRequest;
import com.ict.project.vo.TraineeVO;
import com.ict.project.vo.TrainingBookVO;
import com.ict.project.vo.WorkplusVO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import jakarta.servlet.http.HttpSession;
import com.ict.project.vo.AskcounselingVO;
import com.ict.project.vo.CommVO;
import com.ict.project.vo.CounselReceiptVO;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@RestController
@RequestMapping("/login")
public class TestController {
    @Autowired
    private HttpSession session;
    @Autowired
    private TestService t_Service;
    @Autowired
    private HttpServletRequest request;
    @Autowired
    private GradeCheckService g_Service;
    @Autowired
    private QuestionService q_Service;
    @Autowired
    private SuggestionService s_Service;

    private final Logger logger = LoggerFactory.getLogger(this.getClass());

    @RequestMapping("/login")
    public Map<String, Object> test(String m_id, String m_pw) {
        Map<String, Object> map = new HashMap<>();

        MemberVO vo = t_Service.login(m_id, m_pw);
        if (vo != null) {
            map.put("memberVo", vo);
            session.setAttribute("memberVo", vo);
            map.put("m_id", vo.getM_id());
            map.put("m_name", vo.getM_name());
            if (vo.getTr_idx() != null) {
                map.put("tr_idx", vo.getTr_idx());
            }
        }
        return map;
    }

    @RequestMapping("/logout")
    public void logout() {
        session.removeAttribute("memberVo");
    }

    @RequestMapping("/naverLogin")
    public Map<String, Object> naverLogin(String code, String state) throws JSONException {
        Map<String, Object> map = new HashMap<>();
        String encodeState = "";

        // 임의로 입력한 state값을 encoding한다 (근데 작동 안됨)
        try {
            encodeState = URLEncoder.encode(state, "UTF-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        System.out.println("encode: " + encodeState);
        // access_token을 받기 위한 uri
        String token_uri = "https://nid.naver.com/oauth2.0/token?grant_type=authorization_code&client_id=Xcta2ntEsGR7Vtf5pcVC&client_secret=SQjhT74keR&code="
                + code;
        // RestTemplate을 이용해 access_token을 받아온다
        RestTemplate token_rt = new RestTemplate();
        ResponseEntity<String> token_result = token_rt.getForEntity(token_uri, String.class);
        // 받아온 값에서 token값을 뽑아내기 위해 JSONObject로 변환
        JSONObject token_json = new JSONObject(token_result.getBody());
        // JSONObject에서 token값 뽑아내기
        String access_token = token_json.getString("access_token");

        // 얻어낸 access_token을 이용해 회원 profile 정보 얻어내기
        RestTemplate profile_rt = new RestTemplate();
        // 요청 헤더에 access_token 추가
        HttpHeaders userDetailReqHeaders = new HttpHeaders();
        userDetailReqHeaders.add("Authorization", "Bearer " + access_token);
        userDetailReqHeaders.add("Content-type", "application/x-www-form-urlencoded;charset=UTF-8");
        HttpEntity<MultiValueMap<String, String>> naverProfileRequest = new HttpEntity<>(userDetailReqHeaders);

        // 회원 profile 데이터를 가져온다
        ResponseEntity<String> profile_result = profile_rt.exchange(
                "https://openapi.naver.com/v1/nid/me",
                HttpMethod.POST,
                naverProfileRequest,
                String.class);
        // 가져온 데이터에서 email 정보를 뽑아내기 위해 JSONObject로 변환
        JSONObject profile_body = new JSONObject(profile_result.getBody());
        JSONObject profile_json = new JSONObject(profile_body.getString("response"));
        String email = profile_json.getString("email");

        // 얻어낸 email을 이용해서 DB에서 회원가입되어있는지 체크
        // 체크 후 DB에 없는 email이면 회원가입으로 이동,
        // 있는 email이면 memberVO에 해당 vo객체 저장 후 myPage 이동
        MemberVO mvo = t_Service.checkEmail(email);
        boolean checkFlag = false;
        if (mvo != null) {
            map.put("memberVo", mvo);
            map.put("m_id", mvo.getM_id());
            map.put("m_name", mvo.getM_name());
            map.put("tr_idx", mvo.getTr_idx());
            session.setAttribute("memberVo", mvo);
            checkFlag = true;
        }

        // 필요한 정보를 얻었으므로 로그인 연동을 해지하기 위한 uri
        String delete_uri = "https://nid.naver.com/oauth2.0/token?grant_type=delete&client_id=Xcta2ntEsGR7Vtf5pcVC&client_secret=SQjhT74keR&access_token="
                + access_token + "&service_provider='NAVER'";
        RestTemplate delete_rt = new RestTemplate();
        // Naver서버와 연동 및 result를 이용해 결과를 확인할 수 있음
        ResponseEntity<String> delete_result = delete_rt.getForEntity(delete_uri, String.class);

        map.put("checkFlag", checkFlag);

        return map;
    }

    @RequestMapping("/kakaoLogin")
    public Map<String, Object> kakaoLogin(String token) throws Exception {
        Map<String, Object> map = new HashMap<>();

        // profile을 받기 위한 url
        String info_url = "https://kapi.kakao.com/v2/user/me";

        // 얻어낸 access_token을 이용해 회원 profile 정보 얻기위해 RestTemplate객체 생성
        RestTemplate profile_rt = new RestTemplate();
        // 요청 헤더에 access_token 추가
        HttpHeaders userDetailReqHeaders = new HttpHeaders();
        userDetailReqHeaders.add("Authorization", "Bearer " + token);
        userDetailReqHeaders.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
        HttpEntity<MultiValueMap<String, String>> kakaoProfileRequest = new HttpEntity<>(userDetailReqHeaders);

        // 회원 profile 데이터를 가져온다
        ResponseEntity<String> profile_result = profile_rt.exchange(
                info_url,
                HttpMethod.POST,
                kakaoProfileRequest,
                String.class);
        // 가져온 데이터에서 email 정보를 뽑아내기 위해 JSONObject로 변환
        JSONObject profile_body = new JSONObject(profile_result.getBody());
        JSONObject profile_json = new JSONObject(profile_body.getString("kakao_account"));
        JSONObject profile_json2 = new JSONObject(profile_json.getString("profile"));
        System.out.println("json : " + profile_json2);

        // 원래는 얻어낸 json데이터에서 email을 가지고 DB로 가서
        // 해당 객체가 있는지 비교해야함
        // 그런데 kakao는 email을 이제는 안던져줌
        map.put("nickname", profile_json2.getString("nickname"));
        return map;
    }

    @RequestMapping("/googleLogin")
    public Map<String, Object> googleLogin(String token) throws Exception {
        Map<String, Object> map = new HashMap<>();

        // profile을 받기 위한 url
        String info_url = "https://www.googleapis.com/oauth2/v1/userinfo?access_token=" + token;

        // 전달받은 access_token으로 회원 profile 정보 얻기위해 RestTemplate객체 생성
        RestTemplate profile_rt = new RestTemplate();

        // 통신을 위해 Header와 Body 설정
        HttpHeaders httpHeaders = new HttpHeaders();
        httpHeaders.setContentType(MediaType.APPLICATION_JSON);
        MultiValueMap<String, String> body = new LinkedMultiValueMap<>();
        HttpEntity<?> requestMessage = new HttpEntity<>(body, httpHeaders);

        // exchange 함수를 이용해 응답(response)을 받아온다
        ResponseEntity<String> response = profile_rt.exchange(
                info_url,
                HttpMethod.GET,
                requestMessage,
                String.class);

        // 응답(response)에서 필요한 email 정보를 빼내온다
        JSONObject response_body = new JSONObject(response.getBody());
        String email = response_body.getString("email");

        // 얻어낸 email을 이용해서 DB에서 회원가입되어있는지 체크
        // 체크 후 DB에 없는 email이면 회원가입으로 이동,
        // 있는 email이면 memberVO에 해당 vo객체 저장 후 myPage 이동
        MemberVO mvo = t_Service.checkEmail(email);
        boolean checkFlag = false;
        if (mvo != null) {
            map.put("memberVo", mvo);
            map.put("m_id", mvo.getM_id());
            map.put("m_name", mvo.getM_name());
            map.put("tr_idx", mvo.getTr_idx());
            session.setAttribute("memberVo", mvo);
            checkFlag = true;
        }

        map.put("checkFlag", checkFlag);

        return map;
    }

    @RequestMapping("/getMember")
    public Map<String, Object> getMember(String m_id) {
        Map<String, Object> map = new HashMap<>();
        // json으로 보낼때 객체 1개를 보내더라도 꼭 배열 형태로 보내야한다.
        MemberVO[] vo = t_Service.getMember(m_id);
        map.put("memberVo", vo);
        return map;
    }

    @RequestMapping("/getCtList")
    public Map<String, Object> getCtList() {
        Map<String, Object> map = new HashMap<>();
        CourseTypeVO[] ar = t_Service.getCtList();

        for (int i = 0; i < ar.length; i++) {
            if (ar[i].getC_ar().length > 0) {
                ar[i].setCvo(ar[i].getC_ar()[0]);
            }
        }

        map.put("courseTypeAr", ar);
        return map;
    }

    @RequestMapping("/getSfList")
    public Map<String, Object> getSfList() {
        Map<String, Object> map = new HashMap<>();
        StaffVO[] ar = t_Service.getSfList();
        map.put("ar", ar);
        return map;
    }

    @RequestMapping("/ctList")
    public Map<String, Object> ctList(String ct_idx) {
        Map<String, Object> map = new HashMap<>();
        CourseVO[] ar = t_Service.ctList(ct_idx);
        map.put("courseAr", ar);
        return map;
    }

    @RequestMapping("/searchCourse")
    public Map<String, Object> searchCourse(String c_name, String ct_idx) {
        Map<String, Object> map = new HashMap<>();
        CourseVO[] ar = t_Service.searchCourse(c_name, ct_idx);
        if (ar != null && ar.length > 0) {
            map.put("CourseAr", ar);
        } else {
            map.put("CourseAr", null);
        }
        return map;
    }

    @RequestMapping("/addAsk")
    public void addAsk(AskcounselingVO vo) {
        t_Service.addAsk(vo);
    }

    @RequestMapping("/regMember")
    public void regMember(MemberVO vo) {
        t_Service.regMember(vo);
    }

    // 아이디 중복체크 기능
    @RequestMapping("/checkSameId")
    public boolean checkSameId(String m_id) {
        boolean flag = false;
        int cnt = t_Service.checkSameId(m_id);
        // 아이디가 중복되면 true, 중복이 아니면 false를 반환
        if (cnt == 1) {
            flag = true;
        } else {
            flag = false;
        }

        return flag;
    }

    // 이메일 중복체크 기능
    @RequestMapping("/checkSameEmail")
    public boolean checkSameEmail(String m_email) {
        boolean flag = false;
        int cnt = t_Service.checkSameEmail(m_email);
        // 아이디가 중복되면 true, 중복이 아니면 false를 반환
        if (cnt == 1) {
            flag = true;
        } else {
            flag = false;
        }

        return flag;
    }

    // 마이페이지 안에서 수강하는 과정 반환하는 기능
    @RequestMapping("/myCourse")
    public Map<String, Object> myCourse(String m_id) {
        Map<String, Object> map = new HashMap<>();
        CourseVO[] ar = t_Service.myCourse(m_id);
        map.put("ar", ar);
        // 여기서 문의, 답변 관련 목록 찾아서 반환해야됨
        AskcounselingVO[] replyAr = t_Service.myReply(m_id);
        map.put("replyAr", replyAr);
        return map;
    }

    @RequestMapping("/editMyInfo")
    public void editMyInfo(MemberVO vo) {
        MemberVO mvo = (MemberVO) session.getAttribute("memberVo");

        // 정보를 수정하는 회원이 수강생인 경우
        // 수강생 정보도 같이 수정해야한다.
        if (mvo.getTr_idx() != null) {
            TraineeVO tvo = new TraineeVO();
            tvo.setTr_name(vo.getM_name());
            tvo.setTr_phone(vo.getM_phone());
            tvo.setTr_addr(vo.getM_addr());
            tvo.setTr_idx(mvo.getTr_idx());
            t_Service.editTrainee(tvo);
        }

        t_Service.editMyInfo(vo);
    }

    // 정보 수정하기 전 비밀번호 체크
    @RequestMapping("/checkSamePw")
    public Map<String, Object> checkSamePw(String m_id, String m_pw) {
        Map<String, Object> map = new HashMap<>();
        boolean flag = false;

        MemberVO vo = t_Service.checkSamePw(m_id, m_pw);
        if (vo != null) {
            flag = true;
        }
        map.put("flag", flag);

        return map;
    }

    @RequestMapping("/online/add")
    public Map<String, Object> onlineAdd(AskcounselingVO vo) {

        Map<String, Object> map = new HashMap<>();

        int cnt = t_Service.askcounseling(vo);
        map.put("res", cnt);

        return map;
    }

    @RequestMapping("/getCourseVO")
    public Map<String, Object> getCourseVO(String c_idx) {
        Map<String, Object> map = new HashMap<>();
        CourseVO[] ar = t_Service.getCourseVO(c_idx);
        map.put("ar", ar);
        return map;
    }

    @RequestMapping("/enrollCourse")
    public Map<String, Object> enrollCourse(TraineeVO vo) {
        Map<String, Object> map = new HashMap<>();

        // DB에 훈련생 정보 등록
        t_Service.enrollCourse(vo);

        // 전달받은 정보를 가지고 방금 입력한 훈련생 정보 검색
        TraineeVO tvo = t_Service.getTraineeVO(vo.getTr_phone());

        // session에 저장되어있는 로그인한 vo객체 검색
        MemberVO mvo = (MemberVO) session.getAttribute("memberVo");

        // 로그인 vo객체의 id 저장
        String m_id = mvo.getM_id();

        // 로그인한 member에 등록한 수강생 정보 등록
        t_Service.updateTrIdx(m_id, tvo.getTr_idx());

        // sessionStorage에 저장하기 위해 map에 tr_idx 저장
        map.put("tr_idx", tvo.getTr_idx());

        return map;
    }

    @RequestMapping("/trBookList")
    public Map<String, Object> trBookList(String c_idx) {
        Map<String, Object> map = new HashMap<>();
        TrainingBookVO[] ar = t_Service.trBookList(c_idx);
        map.put("ar", ar);
        return map;
    }

    @RequestMapping("/qna/write")
    public Map<String, Object> write(QnaVO vo) {
        Map<String, Object> map = new HashMap<>();

        int cnt = t_Service.qnawrite(vo);
        map.put("res", cnt);
        return map;
    }

    @RequestMapping("/getmemberVO")
    public Map<String, Object> getmember(String m_id) {

        Map<String, Object> map = new HashMap<>();

        MemberVO[] ar = t_Service.getmember(m_id);
        map.put("ar", ar);
        return map;
    }


    @RequestMapping("/qna/commList")
    public Map<String, Object> commList(String qna_idx) {

        Map<String, Object> map = new HashMap<>();

        CommVO[] ar = t_Service.cList(qna_idx);

        map.put("ar", ar);

        return map;
    }

    @RequestMapping("/mySubject")
    public Map<String, Object> mySubject(String c_idx) {
        Map<String, Object> map = new HashMap<>();
        SubjectVO[] ar = t_Service.mySubject(c_idx);
        map.put("ar", ar);

        return map;
    }

    @RequestMapping("/getReply")
    public Map<String, Object> getReply(String ac_idx) {
        Map<String, Object> map = new HashMap<>();

        // 여기서 내가 클릭한 문의의 내용을 가져온다.
        AskcounselingVO[] ar = t_Service.getReply(ac_idx);
        map.put("replyAr", ar);

        return map;
    }

    @RequestMapping("/answerSubmit")
    public Map<String, Object> answerSubmit(String[] mc_ar, String[] sa_ar, String tr_idx, String es_idx) {
        Map<String, Object> map = new HashMap<>();
        System.out.println(tr_idx+ "/"+ es_idx);
        // 제출한 답안을 DB에 저장한다.
        // 제출을 한 수강생과 시험의 정보로 채점해야할 목록을 가져온다
        GradeCheckVO[] gc_ar = g_Service.list(es_idx, tr_idx);
        QuestionVO[] q_ar = q_Service.list(es_idx);
        List<GradeCheckVO> ar1 = new ArrayList<>(); // 객관식 문제 배열
        List<GradeCheckVO> ar2 = new ArrayList<>(); // 주관식 문제 배열

        for (int i = 0; i < gc_ar.length; i++) {
            if (q_ar[i].getQt_type().equals("0")) { // 이게 객관식
                ar1.add(gc_ar[i]);
            } else { // 이게 주관식
                ar2.add(gc_ar[i]);
            }
        }

        // 가져온 채점 목록을 for문을 이용해서 하나씩 채점을 한다
        // 제출한 정답과 qt_correct를 비교하고 같을때만
        // set_grade를 한다
        for (int i = 0; i < ar1.size(); i++) {
            ar1.get(i).setGc_answer(mc_ar[i]);
            g_Service.set_answer(ar1.get(i));
            g_Service.set_grade(ar1.get(i).getGc_idx());
        }

        for (int i = 0; i < ar2.size(); i++) {
            ar2.get(i).setGc_answer(sa_ar[i]);
            g_Service.set_answer(ar2.get(i));
            g_Service.set_grade(ar2.get(i).getGc_idx());
        }

        // 채점이 끝난 후 총 점수를 반환한다
        int totalScore = g_Service.all_grade(es_idx, tr_idx);
        map.put("totalScroe", totalScore);
        return map;
    }

    @RequestMapping("/myExam")
    public Map<String, Object> myExam(String s_idx) {
        Map<String, Object> map = new HashMap<>();

        // list로 해당 문제들을 가져와서 객관식, 주관식으로 나눠서
        // 각각 배열로 저장해야한다.
        QuestionVO[] ar = t_Service.myExam(s_idx);

        // 해당 문제가 있을때(ar이 null이 아닐때)만 각각 배열에 저장한다.
        if (ar != null && ar.length > 0) {
            map.put("es_idx", ar[0].getEs_idx());
            List<QuestionVO> shortAnswer_list = new ArrayList<>();
            List<QuestionVO> multipleChoice_list = new ArrayList<>();

            for (int i = 0; i < ar.length; i++) {
                // Qt_type이 0이면 객관식, 1이면 주관식이므로 각각 list에 저장한다.
                if (ar[i].getQt_type().equals("0")) {
                    multipleChoice_list.add(ar[i]);
                }
                if (ar[i].getQt_type().equals("1")) {
                    shortAnswer_list.add(ar[i]);
                }
            }

            // 객관식 문제의 list가 비어있지 않다면 배열로 변환
            if (!multipleChoice_list.isEmpty()) {
                QuestionVO[] mc_ar = new QuestionVO[multipleChoice_list.size()];
                multipleChoice_list.toArray(mc_ar);
                map.put("mc_ar", mc_ar);
                // 객관식 보기를 따로 배열로 저장
                // 이 부분은 현재 미구현(다시 알아봐야함)
                // int option_cnt = 0;
                //     for (int i = 0; i < mc_ar.length; i++) {
                //         String[] option_ar = new String[mc_ar[i].getQt_select().split("│").length];
                //         option_ar = mc_ar[i].getQt_select().split("│");
                //         map.put("option_ar" + i, option_ar);
                //         option_cnt++;
                //     }
                // map.put("option_cnt", option_cnt);
            }else{
                map.put("mc_ar", null);
            }
            // 주관식 문제의 list가 비어있지 않다면 배열로 변환
            if (!shortAnswer_list.isEmpty()) {
                QuestionVO[] sa_ar = new QuestionVO[shortAnswer_list.size()];
                shortAnswer_list.toArray(sa_ar);
                map.put("sa_ar", sa_ar);
            }else{
                map.put("sa_ar", null);
            }
        }
        return map;
    }

    @RequestMapping("/qna/getqnaList")
    public Map<String, Object> list(String qname, String cPage) {
        Map<String, Object> map = new HashMap<>();
        int nowPage = 1;

        if (qname == null)
            qname = "q";

        if (cPage != null)
            nowPage = Integer.parseInt(cPage);

        int totalRecord = t_Service.count(qname);

        Paging2 page = new Paging2(
                nowPage, totalRecord, 7, 5);

        nowPage = page.getNowPage();
        // 페이징에 필요한 HTML코드를 받아낸다.
        String pageCode = page.getSb().toString();
        // ---------------------------------------------------

        // 뷰페이지에서 표현할 목록 가져오기
        String begin = String.valueOf(page.getBegin());
        String end = String.valueOf(page.getEnd());
        QnaVO[] ar = t_Service.getList(qname, begin, end);

        // ModelAndView에 뷰페이지에서 필요한 정보들을 저장한다.
        map.put("ar", ar);
        map.put("page", page);
        map.put("pageCode", pageCode);
        map.put("totalRecord", totalRecord);
        map.put("nowPage", nowPage);
        map.put("qname", qname);
        map.put("blockList", page.getBlockList());

        return map;
    }

    @RequestMapping("/qna/view")
    public Map<String, Object> view(String qna_idx, String cPage, String qname) {
        Map<String, Object> map = new HashMap<>();

        HttpSession session = request.getSession(true);

        // 세션에 read_list라는 이름으로 등록된 ArrayList<BbsVO>를 얻어낸다.
        Object obj = session.getAttribute("read_list");
        ArrayList<QnaVO> list = null;
        if (obj != null)
            list = (ArrayList<QnaVO>) obj;
        else
            list = new ArrayList<>();

        // 받은 인자들 중 b_idx가 기본키이므로 게시물 얻어내는
        // 조건으로 사용하자!
        QnaVO vo = t_Service.getqna(qna_idx);

        // 이미 읽었던 게시물인지? 확인하자!
        boolean chk = false;
        for (QnaVO qvo : list) {
            if (qvo.getQna_idx().equals(qna_idx)) {
                chk = true;
                break;// 탈출
            }
        } // for의 끝

        // chk가 true이면 이미 읽었던 게시물이다. 즉 할일이 없다.
        // if (!chk) {
        // int hit = Integer.parseInt(vo.getHit()) + 1;
        // vo.setHit(String.valueOf(hit));

        // // b_Service.updateHit(vo); //DB수정
        // }

        map.put("vo", vo);

        return map;
    }

    @RequestMapping("/qna/del")
    public Map<String, Object> del(String qna_idx) {

        Map<String, Object> map = new HashMap<>();

        int cnt = t_Service.del(qna_idx);
        map.put("res", cnt);
        System.out.println(qna_idx);
        return map;
    }

    @RequestMapping("/qna/edit")
    public Map<String, Object> edit(QnaVO vo) {

        Map<String, Object> map = new HashMap<>();

        int cnt = t_Service.edit(vo);
        map.put("res", cnt);
        System.out.println(cnt);
        return map;
    }
  
    @RequestMapping("/after/list")
    public Map<String, Object> afterlist(){

        Map<String,Object> map = new HashMap<>();

        TraineeVO[] ar = t_Service.tlist();
        WorkplusVO[] aa = t_Service.wlist();
        System.out.println(ar.length+"/"+aa.length+"/");
        map.put("ar", ar);
        map.put("aa", aa);

        return map;
    }


}