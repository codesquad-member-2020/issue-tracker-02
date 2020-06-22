package com.codesquad.issuetracker.issue.web.model;

import com.codesquad.issuetracker.issue.data.Issue;
import com.codesquad.issuetracker.issue.data.Reply;
import com.codesquad.issuetracker.label.data.Label;
import com.codesquad.issuetracker.milestone.data.Milestone;
import java.time.LocalDateTime;
import java.util.HashSet;
import java.util.Set;
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

  @Builder.Default
  private final Set<Reply> replies = new HashSet<>();

  private final LocalDateTime createdAt;
  private final LocalDateTime updateTimeAt;

  public static IssueView from(Issue issue, Set<Label> labels, Set<Milestone> milestones) {
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

  public static IssueView from(Issue issue, Set<Label> labels, Set<Milestone> milestones,
      Set<Reply> replies) {
    return IssueView.builder()
        .id(issue.getId())
        .close(issue.getClose())
        .userId(issue.getUserId())
        .title(issue.getTitle())
        .description(issue.getDescription())
        .labels(labels)
        .milestones(milestones)
        .replies(replies)
        .createdAt(issue.getCreatedAt())
        .updateTimeAt(issue.getUpdateTimeAt())
        .build();
  }
}
