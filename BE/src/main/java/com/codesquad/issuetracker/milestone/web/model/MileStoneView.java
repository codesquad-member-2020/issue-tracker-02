package com.codesquad.issuetracker.milestone.web.model;


import com.codesquad.issuetracker.issue.data.Issue;
import com.codesquad.issuetracker.milestone.data.MileStone;
import java.time.LocalDate;
import java.util.List;
import lombok.Builder;
import lombok.Getter;

@Getter
public class MileStoneView {

  private final Long id;
  private final String title;
  private final String description;
  private final LocalDate dueDate;
  private final Long issueCount;
  private final Long closeIssueCount;

  @Builder
  private MileStoneView(Long id, String title, String description, LocalDate dueDate,
      Long issueCount,
      Long closeIssueCount) {
    this.id = id;
    this.title = title;
    this.description = description;
    this.dueDate = dueDate;
    this.issueCount = issueCount;
    this.closeIssueCount = closeIssueCount;
  }

  public static MileStoneView from(MileStone findMileStone) {
    List<Issue> issues = findMileStone.getIssues();
    return MileStoneView.builder()
        .id(findMileStone.getId())
        .title(findMileStone.getTitle())
        .description(findMileStone.getDescription())
        .dueDate(findMileStone.getDueDate())
        .issueCount((long) issues.size())
        .closeIssueCount(issues.stream().filter(Issue::getClose).count())
        .build();
  }
}
