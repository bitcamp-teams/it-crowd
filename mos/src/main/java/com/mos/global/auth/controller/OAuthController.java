package com.mos.global.auth.controller;

import com.mos.domain.member.dto.MemberDto;
import com.mos.domain.member.dto.MemberJoinDto;
import com.mos.domain.member.service.MemberService;
import com.mos.global.auth.LoginUser;
import com.mos.global.auth.handler.LoginApiManager;
import com.mos.global.auth.handler.OAuthRequestParam;
import com.mos.global.auth.handler.response.LoginResponseHandler;

import javax.servlet.http.HttpSession;

import lombok.RequiredArgsConstructor;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.http.HttpEntity;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.reactive.function.client.WebClient;

import static com.mos.global.auth.handler.LoginApiProvider.*;

@RequiredArgsConstructor
@Controller
@CrossOrigin("*")
@RequestMapping()
public class OAuthController {

  private static final Log log = LogFactory.getLog(OAuthController.class);

  private final MemberService memberService;
  private final LoginApiManager loginApiManager;
  private final WebClient webClient;

  @GetMapping("/auth/login")
  public String login(Model model) {
    // 카카오
    model.addAttribute("kakaoUrl",
        OAuthRequestParam.KAKAO_AUTH_URI.getParam() +
        "/oauth/authorize?client_id=" + OAuthRequestParam.KAKAO_CLIENT_ID.getParam()
        + "&redirect_uri=" + OAuthRequestParam.KAKAO_REDIRECT_URL.getParam()
        + "&response_type=code");
    // 깃헙
    model.addAttribute("clientId", OAuthRequestParam.GITHUB_CLIENT_ID.getParam());
    // 구글
    model.addAttribute("googleUrl",
        "https://accounts.google.com/o/oauth2/v2/auth?client_id=" + OAuthRequestParam.GOOGLE_CLIENT_ID.getParam()
        + "&redirect_uri=" + OAuthRequestParam.GOOGLE_REDIRECT_URI.getParam()
        + "&response_type=code&scope=email");

    return "auth/login";
  }

  // 카카오
  @GetMapping("/auth/kakao/callback")
  public String callback(@RequestParam String code, Model model, HttpSession session) throws Exception {
    LoginResponseHandler kakaoInfo =
        loginApiManager.getProvider("KAKAO").getUserInfo(webClient, code);
    model.addAttribute("platform", KAKAO.name());
    return url(session, kakaoInfo);
  }

  // 깃헙
  @GetMapping("login/oauth2/code/github")
  public String githubLogin(@RequestParam String code, Model model, HttpSession session) {
    LoginResponseHandler githubInfo =
        loginApiManager.getProvider("GITHUB").getUserInfo(webClient, code);
    model.addAttribute("platform", GITHUB.name());
    return url(session, githubInfo);
  }

  // 구글
  @GetMapping("login/oauth2/code/google")
  public String googleOAuth(@RequestParam String code, Model model, HttpSession session) {
    LoginResponseHandler googleInfo =
        loginApiManager.getProvider("GOOGLE").getUserInfo(webClient, code);
    model.addAttribute("platform", GOOGLE.name());
    return url(session, googleInfo);
  }


  @GetMapping("auth/logout")
  public String logout(HttpSession session) throws Exception {
    session.invalidate();
    return "redirect:/";
  }

  @GetMapping("auth/form")
  public String form(@LoginUser MemberDto user, Model model) throws Exception {
    model.addAttribute("user", user);
    return "auth/form";
  }




//  @PostMapping("signup")
//  public void signup(@RequestParam String username) {
//    // 중복확인 완료한 후 가입을 진행하던 중
//    // 그 시점에 같은 닉네임으로 가입을 완료한 사람이 있다면??
//
//    /*MemberDto member = memberService.getName(username);
//
//    if (memberService.getName(username) != null) {
//      System.out.println("중복된 닉네임입니다.");
//      return "auth/signup";
//    }
//
//    System.out.println("사용가능한 닉네임입니다!!");
//    return "auth/signup";*/
//  }

  // 닉네임 중복확인
  @GetMapping("checkUsername")
  public ResponseEntity<String> checkUsername(@RequestParam String username) {
    MemberDto member = memberService.getName(username);

    if (member != null) {
      // 이미 존재하는 닉네임인 경우
      return ResponseEntity.ok("duplicate");
    } else {
      // 존재하지 않는 닉네임인 경우
      return ResponseEntity.ok("available");
    }
  }

  private String url(HttpSession session, LoginResponseHandler info) {
    if (memberService.existsByEmail(info.getEmail())) {
      // OAuth 이메일 이외에 다른 정보도 받을 경우 회원정보 업데이트 쿼리 필요함
      session.setAttribute("accessToken", info.getToken());
      session.setAttribute("loginUser", memberService.get(info.getEmail()));
      return "redirect:/";
    } else {
      session.setAttribute("loginUser", MemberDto.builder().email(info.getEmail()).build());
    }
    return "forward:/auth/form";
  }





}
