package com.codesquad.issuetracker.milestone.data;

import com.codesquad.issuetracker.issue.data.Issue;
import com.codesquad.issuetracker.milestone.web.model.MileStoneQuery;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToMany;
import javax.persistence.Table;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
@Table(name = "milestone")
@Entity
public class MileStone {

  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Long id;

  private String title;
  private String description;
  private LocalDate dueDate;

  @ManyToMany
  @JoinColumn(name = "issue_id")
  private List<Issue> issues = new ArrayList<>();

  @Builder
  private MileStone(Long id, String title, String description, LocalDate dueDate,
      List<Issue> issues) {
    this.id = id;
    this.title = title;
    this.description = description;
    this.dueDate = dueDate;
    this.issues = issues;
  }

  public static MileStone from(MileStoneQuery mileStoneQuery) {
    return MileStone.builder()
        .title(mileStoneQuery.getTitle())
        .description(mileStoneQuery.getDescription())
        .dueDate(mileStoneQuery.getDueDate())
        .issues(mileStoneQuery.getIssues())
        .build();
  }
}
