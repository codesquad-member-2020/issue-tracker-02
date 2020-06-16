package com.codesquad.issuetracker.milestone.data;

import com.codesquad.issuetracker.milestone.web.model.MilestoneQuery;
import java.time.LocalDate;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor(access = AccessLevel.PRIVATE)
@Entity
public class Milestone {

  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Long id;

  private String title;
  private String description;
  private LocalDate dueDate;

  public static Milestone extractMainInform(Milestone milestone) {
    return Milestone.builder()
        .id(milestone.getId())
        .title(milestone.getTitle())
        .description(milestone.getDescription())
        .dueDate(milestone.getDueDate())
        .build();
  }

  public static Milestone from(MilestoneQuery mileStoneQuery) {
    return Milestone.builder()
        .title(mileStoneQuery.getTitle())
        .description(mileStoneQuery.getDescription())
        .dueDate(mileStoneQuery.getDueDate())
        .build();
  }
}
