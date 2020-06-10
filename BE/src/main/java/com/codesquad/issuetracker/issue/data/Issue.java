package com.codesquad.issuetracker.issue.data;

import com.codesquad.issuetracker.auth.data.User;
import com.codesquad.issuetracker.issue.web.model.IssueQuery;
import java.time.LocalDateTime;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.PrePersist;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

@Getter
@NoArgsConstructor
@Entity
public class Issue {

  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Long id;

  private Boolean close;
  private String userId;
  private String title;
  private String content;

  @CreationTimestamp
  private LocalDateTime createdAt;

  @UpdateTimestamp
  private LocalDateTime updateTimeAt;

  @Builder
  private Issue(Long id, Boolean close, String userId, String title, String content,
      LocalDateTime createdAt, LocalDateTime updateTimeAt) {
    this.id = id;
    this.close = close;
    this.userId = userId;
    this.title = title;
    this.content = content;
    this.createdAt = createdAt;
    this.updateTimeAt = updateTimeAt;
  }

  public static Issue of(User user, IssueQuery query) {
    return Issue.builder()
        .userId(user.getUserId())
        .title(query.getTitle())
        .content(query.getContent())
        .build();
  }

  public Boolean isSameUser(User user) {
    return this.userId.equals(user.getUserId());
  }

  @PrePersist
  public void prePersist() {
    this.close = false;
  }
}
