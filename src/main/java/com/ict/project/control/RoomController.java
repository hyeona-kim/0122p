package com.ict.project.control;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ict.project.util.ChatRoomRepository;

import java.util.List;

@Controller
@RequiredArgsConstructor
@RequestMapping(value = "/chat")
@Log4j2
public class RoomController {

    private final ChatRoomRepository repository;

    // 채팅방 목록 조회
    @GetMapping(value = "/rooms")
    public ModelAndView rooms() {

        log.info("# All Chat Rooms");
        ModelAndView mv = new ModelAndView("chat/rooms");

        mv.addObject("list", repository.findAllRooms());
        mv.setViewName("jsp/staff/chat/rooms");
        return mv;
    }

    // 채팅방 개설
    @PostMapping(value = "/room")
    public String create(@RequestParam String name, RedirectAttributes rttr) {

        log.info("# Create Chat Room , name: " + name);
        rttr.addFlashAttribute("roomName", repository.createChatRoomDTO(name));
        return "redirect:/chat/rooms";
    }

    // 채팅방 조회
    @GetMapping("/room")
    public ModelAndView getRoom(String roomId) {

        log.info("# get Chat Room, roomID : " + roomId);
        ModelAndView mv = new ModelAndView();

        mv.addObject("room", repository.findRoomById(roomId));
        System.out.println(repository.findRoomById(roomId).getName());
        mv.setViewName("jsp/staff/chat/room");
        return mv;

    }
}