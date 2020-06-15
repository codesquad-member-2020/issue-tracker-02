package com.codesquad.issuetracker.issue.web.model;

import com.codesquad.issuetracker.issue.data.Issue;
import com.codesquad.issuetracker.label.data.Label;
import com.codesquad.issuetracker.milestone.data.Milestone;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
@AllArgsConstructor(access = AccessLevel.PRIVATE)
public class IssueView {

  private final Long id;
  private final Boolean close;
  private final String userId;
  private final String title;
  private final String description;
  private final Set<Label> labels;
  private final Set<Milestone> milestones;
  private final LocalDateTime createdAt;
  private final LocalDateTime updateTimeAt;

  public static IssueView from(Issue issue) {
    Set<Label> labels = issue.getIssueLabelRelations().stream()
        .map(issueLabelRelation -> Label.extractMainInform(issueLabelRelation.getLabel()))
        .collect(Collectors.toSet());
    Set<Milestone> milestones = issue.getIssueMilestoneRelations().stream()
        .map(issueMilestoneRelation -> Milestone
            .extractMainInform(issueMilestoneRelation.getMilestone()))
        .collect(Collectors.toSet());

    return IssueView.builder()
        .id(issue.getId())
        .close(issue.getClose())
        .userId(issue.getUserId())
        .title(issue.getTitle())
        .description(issue.getDescription())
        .labels(labels)
        .milestones(milestones)
        .createdAt(issue.getCreatedAt())
        .updateTimeAt(issue.getUpdateTimeAt())
        .build();
  }

  public static List<IssueView> toList(List<Issue> issues) {
    return issues.stream()
        .map(IssueView::from)
        .collect(Collectors.toList());
  }
}
