package com.study.controller.member;

import com.study.domain.member.MemberDto;
import com.study.service.member.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("member")
public class MemberController {
    @Autowired
    private MemberService service;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @GetMapping("signup")
    public void signup() {

    }

    @PostMapping("signup")
    public String signup(MemberDto member, RedirectAttributes rttr) {

        int cnt = service.insert(member);

        // 가입이 되면
        rttr.addFlashAttribute("message", "회원가입이 완료되었습니다");
        return "redirect:/board/list";

    }

    @GetMapping("list")
    @PreAuthorize("hasAuthority('admin')")
    public void list(Model model) {
        model.addAttribute("memberList", service.list());
    }

//    @GetMapping({"info", "modify"})
//    @PreAuthorize("hasAuthority('admin') or (authentication.name == #id)")
//    public void member(String id, Model model) {
//        model.addAttribute("member", service.getById(id));
//    }

    @GetMapping({"info"})
    @PreAuthorize("hasAuthority('admin') or (authentication.name == #id)")
    public void member(String id, Model model) {
        model.addAttribute("member", service.getById(id));
    }
    @GetMapping({ "modify"})
    @PreAuthorize("(authentication.name == #id)")
    public void member1(String id, Model model) {
        model.addAttribute("member", service.getById(id));
    }

    @PostMapping("modify")
    @PreAuthorize("authentication.name == #member.id")
    public String modify(MemberDto member, String oldPassword, RedirectAttributes rttr) {

        MemberDto oldmember = service.getById(member.getId());

        rttr.addAttribute("id", member.getId());
        boolean passwordMatch = passwordEncoder.matches(oldPassword, oldmember.getPassword());
        if (passwordMatch) {
            int cnt = service.modify(member);

            if (cnt == 1) {
                rttr.addFlashAttribute("message","회원 정보가 수정되었습니다");
                return "redirect:/member/list";
            } else {
                rttr.addFlashAttribute("message", "회원 정보가 수정되지 않았습니다");
                return "redirect:/member/modify";
            }
        } else {
            rttr.addFlashAttribute("message", "회원 정보가 수정되지 않았습니다.");
            return "redirect:/member/modify";
        }
    }

    @PostMapping("remove")
    public String remove(String id, String oldPassword, RedirectAttributes rttr, HttpServletRequest request) throws Exception {

        MemberDto oldmember = service.getById(id);

        boolean passwordMatch = passwordEncoder.matches(oldPassword, oldmember.getPassword());

        if (passwordMatch) {
            service.remove(id);

            rttr.addFlashAttribute("message", "회원 탈퇴하였습니다.");
            request.logout();
            return "redirect:/board/list";

        } else {
            rttr.addAttribute("id", id);
            rttr.addFlashAttribute("message", "암호가 일치하지 않습니다.");
            return "redirect:/member/info";
        }
    }

    @GetMapping("existId/{id}")
    @ResponseBody
    public Map<String, Object> existId(@PathVariable String id) {
        Map<String, Object> map = new HashMap<>();

        MemberDto member = service.getById(id);

        if (member == null) {
            map.put("status", "not exist");
            map.put("message", "사용 가능한 아이디 입니다");
        } else {
            map.put("status", "exist");
            map.put("message", "이미 존재하는 아이디 입니다");
        }
        return map;
    }

    @GetMapping("existNickName/{userNickName}")
    @ResponseBody
    public Map<String, Object> existNickName(@PathVariable String userNickName) {
        Map<String, Object> map = new HashMap<>();

        MemberDto member = service.getByNickName(userNickName);

        if (member == null) {
            map.put("status", "not exist");
            map.put("message", "사용 가능한 닉네임 입니다");
        } else {
            map.put("status", "exist");
            map.put("message", "이미 존재하는 닉네임 입니다");
        }
        return map;
    }

    @PostMapping("existEmail")
    @ResponseBody
    public Map<String, Object> existEmail(@RequestBody Map<String, String> req) {
        Map<String, Object> map = new HashMap<>();

        MemberDto member = service.getByEmail(req.get("userEmail"));

        if (member == null) {
            map.put("status", "not exist");
            map.put("message", "사용 가능한 이메일 입니다");
        } else {
            map.put("status", "exist");
            map.put("message", "이미 존재하는 이메일 입니다");
        }
        return map;
    }

    @GetMapping("login")
    public void login() {

    }

}
