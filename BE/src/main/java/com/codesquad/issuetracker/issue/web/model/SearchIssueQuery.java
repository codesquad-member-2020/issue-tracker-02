package com.codesquad.issuetracker.issue.web.model;

import io.swagger.annotations.ApiModelProperty;
import javax.persistence.PostPersist;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
@AllArgsConstructor
public class SearchIssueQuery {

  @ApiModelProperty(required = false)
  private String keyword;

  @ApiModelProperty(required = false)
  private Boolean close;

  @ApiModelProperty(required = false)
  private String userId;

  @ApiModelProperty(required = false)
  private Long labelId;

  @ApiModelProperty(required = false)
  private Long milestoneId;

  @PostPersist
  private void postPersist() {
    close = null;
    labelId = null;
    milestoneId = null;
  }
}
