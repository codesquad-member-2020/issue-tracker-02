package com.codesquad.issuetracker.auth.web;

import com.codesquad.issuetracker.auth.data.User;
import com.codesquad.issuetracker.config.property.AppProperty;
import com.codesquad.issuetracker.util.JwtUtil;
import com.google.common.collect.ImmutableMap;
import javax.servlet.http.HttpServletResponse;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

@RequestMapping("/api/oauth2")
@RestController
public class AuthController {

  private final JwtUtil jwtUtil;
  private final AppProperty appProperty;

  public AuthController(JwtUtil jwtUtil, AppProperty appProperty) {
    this.jwtUtil = jwtUtil;
    this.appProperty = appProperty;
  }

  @ResponseStatus(HttpStatus.FOUND)
  @GetMapping("/authorization")
  public void authorization(@AuthenticationPrincipal OAuth2User principal,
      HttpServletResponse response) {
    String jwt = jwtUtil.create(ImmutableMap.of("User", User.of(principal)));
    response.setHeader("Location", appProperty.getGithubScheme() + "?token=" + jwt);
  }
}
