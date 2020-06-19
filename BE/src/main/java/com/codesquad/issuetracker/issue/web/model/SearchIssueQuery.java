package com.codesquad.issuetracker.issue.web.model;

import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
@AllArgsConstructor
public class SearchIssueQuery {

  @ApiModelProperty(required = false)
  private final String keyword;
}
