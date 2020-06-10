package com.codesquad.issuetracker.auth.web;

import com.codesquad.issuetracker.auth.data.User;
import com.codesquad.issuetracker.config.property.AppProperty;
import com.codesquad.issuetracker.util.JwtUtil;
import com.google.common.collect.ImmutableMap;
import io.swagger.annotations.ApiOperation;
import javax.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

@RequiredArgsConstructor
@RequestMapping("/api/oauth2")
@RestController
public class AuthController {

  private final JwtUtil jwtUtil;
  private final AppProperty appProperty;

  @ApiOperation(value = "Git 로그인의 콜백 API 입니다", notes =
      "본 API 는 github 에서 사용하는 것으로 Client 가 직접 호출하는 것이 아닙니다\n\n"
          + "Client Login API : 52.79.81.75:8080/oauth2/authorization/github")
  @ResponseStatus(HttpStatus.FOUND)
  @GetMapping("/authorization")
  public void authorization(@AuthenticationPrincipal OAuth2User principal,
      HttpServletResponse response) {
    String jwt = jwtUtil.create(ImmutableMap.of("User", User.of(principal)));
    response.setHeader("Location", appProperty.getGithubScheme() + "?token=" + jwt);
  }
}
