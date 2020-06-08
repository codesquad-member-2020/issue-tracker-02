package com.codesquad.issuetracker.auth.data;

import lombok.Getter;
import lombok.NoArgsConstructor;
import org.springframework.security.oauth2.core.user.OAuth2User;

@Getter
@NoArgsConstructor
public class User {

  private String nodeId;
  private String userId;
  private String avatarUrl;

  private User(OAuth2User principal) {
    this.nodeId = principal.getAttribute("node_id");
    this.userId = principal.getAttribute("login");
    this.avatarUrl = principal.getAttribute("avatar_url");
  }

  public static User of(OAuth2User principal) {
    return new User(principal);
  }
}
