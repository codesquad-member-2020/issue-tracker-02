package com.codesquad.issuetracker.milestone.web.model;


import com.codesquad.issuetracker.issue.data.Issue;
import com.codesquad.issuetracker.milestone.data.Milestone;
import java.time.LocalDate;
import java.util.List;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
@AllArgsConstructor(access = AccessLevel.PRIVATE)
public class MilestoneView {

  private final Long id;
  private final String title;
  private final String description;
  private final LocalDate dueDate;
  private final Long issueCount;
  private final Long closeIssueCount;

  public static MilestoneView from(Milestone milestone, List<Issue> issues) {
    return MilestoneView.builder()
        .id(milestone.getId())
        .title(milestone.getTitle())
        .description(milestone.getDescription())
        .dueDate(milestone.getDueDate())
        .issueCount((long) issues.size())
        .closeIssueCount(issues.stream().filter(Issue::getClose).count())
        .build();
  }
}
