package com.codesquad.issuetracker.issue.data;

import com.codesquad.issuetracker.auth.data.User;
import com.codesquad.issuetracker.issue.data.relation.IssueLabelRelation;
import com.codesquad.issuetracker.issue.data.relation.IssueMilestoneRelation;
import com.codesquad.issuetracker.issue.web.model.IssueQuery;
import com.codesquad.issuetracker.issue.web.model.PutIssueQuery;
import java.time.LocalDateTime;
import java.util.HashSet;
import java.util.LinkedHashSet;
import java.util.Objects;
import java.util.Set;
import java.util.stream.Collectors;
import javax.persistence.ElementCollection;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

@Getter
@Builder
@AllArgsConstructor(access = AccessLevel.PRIVATE)
@NoArgsConstructor
@Entity
public class Issue {

  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Long id;

  @Builder.Default
  private Boolean close = false;
  private String userId;
  private String title;
  private String description;

  @Builder.Default
  @OneToMany(mappedBy = "issue", fetch = FetchType.EAGER, orphanRemoval = true)
  private Set<IssueLabelRelation> issueLabelRelations = new LinkedHashSet<>();

  @Builder.Default
  @OneToMany(mappedBy = "issue", fetch = FetchType.EAGER, orphanRemoval = true)
  private Set<IssueMilestoneRelation> issueMilestoneRelations = new HashSet<>();

  @Builder.Default
  @ElementCollection(fetch = FetchType.EAGER)
  private Set<Reply> replies = new HashSet<>();

  @CreationTimestamp
  private LocalDateTime createdAt;

  @UpdateTimestamp
  private LocalDateTime updateTimeAt;

  public static Issue from(User user, IssueQuery query) {
    return Issue.builder()
        .userId(user.getUserId())
        .title(query.getTitle())
        .description(query.getDescription())
        .build();
  }

  public void update(PutIssueQuery query) {
    title = query.getTitle();
    description = query.getDescription();
  }

  public void updateStatus(Boolean status) {
    if (Objects.nonNull(status)) {
      close = status;
    }
  }

  public Boolean isSameUser(User user) {
    return userId.equals(user.getUserId());
  }

  public Set<Long> getIdOfLabels() {
    return issueLabelRelations.stream()
        .map(IssueLabelRelation::getLabelId)
        .collect(Collectors.toSet());
  }

  public Set<Long> getIdOfMilestones() {
    return issueMilestoneRelations.stream()
        .map(IssueMilestoneRelation::getMilestoneId)
        .collect(Collectors.toSet());
  }
}
