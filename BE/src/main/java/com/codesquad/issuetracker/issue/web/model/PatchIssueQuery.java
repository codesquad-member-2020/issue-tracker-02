package com.codesquad.issuetracker.issue.web.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
@AllArgsConstructor
public class PatchIssueQuery {

  private final Boolean close;
  private final Long attachLabel;
  private final Long detachLabel;
  private final Long attachMilestone;
  private final Long detachMilestone;
}
