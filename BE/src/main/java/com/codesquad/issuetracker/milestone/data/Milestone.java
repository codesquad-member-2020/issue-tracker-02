package com.codesquad.issuetracker.milestone.data;

import com.codesquad.issuetracker.issue.data.IssueMilestoneRelation;
import com.codesquad.issuetracker.milestone.web.model.MilestoneQuery;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonInclude.Include;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.CascadeType;
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

  @Builder.Default
  @JsonInclude(Include.NON_NULL)
  @OneToMany(mappedBy = "milestone", fetch = FetchType.EAGER, cascade = CascadeType.PERSIST)
  private List<IssueMilestoneRelation> issueMilestoneRelations = new ArrayList<>();

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
