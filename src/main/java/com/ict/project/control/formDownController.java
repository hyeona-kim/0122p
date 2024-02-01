package com.ict.project.control;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.ict.project.service.FormDownService;
import com.ict.project.util.FileRenameUtil;
import com.ict.project.util.Paging;
import com.ict.project.vo.FormDownVO;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletInputStream;
import jakarta.servlet.ServletOutputStream;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class formDownController {
    @Autowired
    FormDownService fd_Service;
    @Autowired
    HttpServletRequest request;
    @Autowired
    HttpServletResponse response;
    @Autowired
    ServletContext application;
    @Autowired
    HttpSession session;

    // 서식자료실 메인페이지로 이동하는 기능
    @RequestMapping("formDownload")
    public ModelAndView formDownload(String cPage) {
        ModelAndView mv = new ModelAndView();
        mv.addObject("cPage", cPage);
        mv.setViewName("/jsp/admin/etcList/formDownload/main");
        return mv;
    }

    // 메인페이지로 이동할때 비동기식 통신으로 전체목록을 반환하는 기능
    @RequestMapping("formMainAjax")
    public ModelAndView formMainAjax(String cPage, String numPerPage, String value) {
        ModelAndView mv = new ModelAndView();
        Paging page = null;
        FormDownVO[] ar = null;
        System.out.println("cPage="+cPage);
        if(numPerPage != null || value != null) { // 표시개수를 변경하거나 검색을 했을 때
            boolean change_flag = true;
            mv.addObject("change_flag", change_flag);
            
            System.out.println("npp="+numPerPage+" / sub="+value);
            page = new Paging(Integer.parseInt(numPerPage), 5);
            page.setTotalRecord(fd_Service.searchBothCnt(value));
            if(cPage == null || cPage.equalsIgnoreCase("undefined")) {
                page.setNowPage(1);
            }else {
                page.setNowPage(Integer.parseInt(cPage));
            };
            ar = fd_Service.searchBothForm(value, String.valueOf(page.getBegin()), String.valueOf(page.getEnd()));
        }else { // 처음 자료실 들어올 때
            page = new Paging();
            page.setTotalRecord(fd_Service.cntAllForm());
            if(cPage == null || cPage.equalsIgnoreCase("undefined")) {
                page.setNowPage(1);
            }else {
                page.setNowPage(Integer.parseInt(cPage));
            };
            ar = fd_Service.getFormList(String.valueOf(page.getBegin()), String.valueOf(page.getEnd()));
        }

        mv.addObject("page", page);
        mv.addObject("ar", ar);
        mv.setViewName("/jsp/admin/etcList/formDownload/formMain_ajax");
        return mv;
    }

    // 메인페이지에서 [서식파일 등록]을 클릭했을 때
    // 서식파일 등록 Form을 ajax로 반환하는 기능
    @RequestMapping("addFormDownAjax")
    public String addFormAjax(){
        return "/jsp/admin/etcList/formDownload/addForm_ajax";
    }

    // 서식파일 등록에서 [저장] 또는 서식파일 수정에서 [수정]을 클릭했을 때
    // 해당 제목과 파일을 DB와 서버에 저장하고 메인페이지로 이동하는 기능
    @RequestMapping("addFormDown")
    public ModelAndView addFormDown(FormDownVO vo) {
        ModelAndView mv = new ModelAndView();
        String encType = request.getContentType();

        if(encType.startsWith("multipart")) {
            MultipartFile mf = vo.getFile();
            String fname = null;

            if(mf != null && mf.getSize() > 0) {
                String realPath = application.getRealPath("form_library");

                String oname = mf.getOriginalFilename();

                fname = FileRenameUtil.checkSameFileName(oname, realPath);

                try {
                    mf.transferTo(new File(realPath, fname));
                } catch (Exception e) {
                    e.printStackTrace();
                }
                vo.setFd_fname(fname);
                vo.setFd_oname(oname);
            }
            if(vo.getFd_idx() != null){ // 수정할 때
                fd_Service.editFormDown(vo);
            }else { // 저장할 때
                fd_Service.addFormDown(vo);
            }
        }
        mv.setViewName("redirect:formDownload");
        return mv;
    }

    // 서식자료실 메인페이지에서 [수정]을 클릭했을 때
    // 해당 자료의 정보를 반환하는 기능
    @RequestMapping("editFormDownAjax")
    public ModelAndView editFormDownAjax(String fd_idx) {
        ModelAndView mv = new ModelAndView();

        FormDownVO vo = fd_Service.getFormData(fd_idx);

        mv.addObject("vo", vo);
        mv.setViewName("/jsp/admin/etcList/formDownload/editForm_ajax");

        return mv;
    }

    // 서식자료실 메인페이지에서 [삭제]를 클릭했을 때
    // 해당 자료를 DB에서 삭제하는 기능
    @RequestMapping("deleteFormDown")
    public ModelAndView deleteFormDown(String fd_idx) {
        ModelAndView mv = new ModelAndView();
        fd_Service.deleteFormDown(fd_idx);
        mv.setViewName("redirect:formDownload");
        return mv;
    }

    // 서식자료실 메인페이지에서 [첨부파일]을 클릭했을 때
    // 해당 자료를 다운로드하는 기능
    @RequestMapping("formFileDown")
    public ResponseEntity<Resource> formFileDown(String fd_fname){
        String realPath = application.getRealPath("/form_library/"+fd_fname);

        File file = new File(realPath);

        if(file.exists()) {
            byte[] buf = new byte[4096];
            int size = -1;

            BufferedInputStream bis = null;
            FileInputStream fis = null;

            BufferedOutputStream bos = null;
            ServletOutputStream sos = null;

            try {
                response.setContentType("application/x-msdownload");
                response.setHeader("Content-Disposition", "attachment;filename="+new String(fd_fname.getBytes(), "8859_1"));

                fis = new FileInputStream(file);
                bis = new BufferedInputStream(fis);

                sos = response.getOutputStream();
                bos = new BufferedOutputStream(sos);

                while ((size=bis.read(buf)) != -1) {
                    bos.write(buf, 0, size);
                    bos.flush();
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                try {
                    if(fis != null)
                        fis.close();
                    if(bis != null)
                        bis.close();
                    if(sos != null)
                        sos.close();
                    if(bos != null)
                        bos.close();
                } catch (Exception e) { }
            }
        }
        return null;
    }

    /* @RequestMapping("changeViewNum")
    public ModelAndView changeViewNum(String numPerPage) {
        ModelAndView mv = new ModelAndView();

        Paging page = new Paging(Integer.parseInt(numPerPage), 5);


        return mv;
    } */

}
