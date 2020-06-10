package com.codesquad.issuetracker.auth.data;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.springframework.security.oauth2.core.user.OAuth2User;

@Getter
@NoArgsConstructor
public class User {

  private String nodeId;
  private String userId;
  private String avatarUrl;

  @Builder
  private User(String nodeId, String userId, String avatarUrl) {
    this.nodeId = nodeId;
    this.userId = userId;
    this.avatarUrl = avatarUrl;
  }

  public static User of(OAuth2User principal) {
    return User.builder()
        .nodeId(principal.getAttribute("node_id"))
        .userId(principal.getAttribute("login"))
        .avatarUrl(principal.getAttribute("avatar_url")).build();
  }
}
