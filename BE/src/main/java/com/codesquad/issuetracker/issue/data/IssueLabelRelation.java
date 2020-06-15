package com.codesquad.issuetracker.issue.data;

import com.codesquad.issuetracker.label.data.Label;
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
public class IssueLabelRelation {

  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Long id;

  @ManyToOne
  @JoinColumn(name = "issue_id")
  private Issue issue;

  @ManyToOne
  @JoinColumn(name = "label_id")
  private Label label;

  public static IssueLabelRelation of(Issue issue, Label label) {
    return IssueLabelRelation.builder()
        .issue(issue)
        .label(label)
        .build();
  }
}
