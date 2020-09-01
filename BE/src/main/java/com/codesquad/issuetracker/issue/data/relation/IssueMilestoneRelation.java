package com.codesquad.issuetracker.issue.data.relation;

import com.codesquad.issuetracker.issue.data.Issue;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@Builder
@AllArgsConstructor(access = AccessLevel.PRIVATE)
@NoArgsConstructor
@Entity
public class IssueMilestoneRelation {

  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Long id;

  @ManyToOne
  @JoinColumn(name = "issue_id")
  private Issue issue;

  private Long milestoneId;

  public static IssueMilestoneRelation of(Issue issue, Long milestoneId) {
    return IssueMilestoneRelation.builder()
        .issue(issue)
        .milestoneId(milestoneId)
        .build();
  }
}
