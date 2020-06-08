package com.codesquad.issuetracker.auth.web;

import com.codesquad.issuetracker.auth.data.User;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RequestMapping("/api/oauth2")
@RestController
public class AuthController {

  @GetMapping("/authorization")
  public User user(@AuthenticationPrincipal OAuth2User principal) {
    return User.of(principal);
  }
}
