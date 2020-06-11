package com.codesquad.issuetracker.issue.data;

import com.codesquad.issuetracker.auth.data.User;
import com.codesquad.issuetracker.issue.web.model.IssueQuery;
import com.codesquad.issuetracker.label.data.Label;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToMany;
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
  private String description;

  @CreationTimestamp
  private LocalDateTime createdAt;

  @UpdateTimestamp
  private LocalDateTime updateTimeAt;

  @ManyToMany
  @JoinColumn(name = "label_id")
  private List<Label> labels = new ArrayList<>();


  @Builder
  private Issue(Long id, Boolean close, String userId, String title, String description,
      LocalDateTime createdAt, LocalDateTime updateTimeAt, List<Label> labels) {
    this.id = id;
    this.close = close;
    this.userId = userId;
    this.title = title;
    this.description = description;
    this.createdAt = createdAt;
    this.updateTimeAt = updateTimeAt;
    this.labels = labels;
  }

  public static Issue of(User user, IssueQuery query) {
    return Issue.builder()
        .userId(user.getUserId())
        .title(query.getTitle())
        .description(query.getDescription())
        .labels(query.getLabels())
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
