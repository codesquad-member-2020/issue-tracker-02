package com.codesquad.issuetracker.milestone.web.model;


import io.swagger.annotations.ApiModelProperty;
import java.time.LocalDate;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import org.springframework.format.annotation.DateTimeFormat;

@Getter
@Builder
@AllArgsConstructor
public class MilestoneQuery {

  private final String title;
  private final String description;

  @ApiModelProperty(example = "2022-12-07")
  @DateTimeFormat(pattern = "yyyy-MM-dd")
  private final LocalDate dueDate;
}
