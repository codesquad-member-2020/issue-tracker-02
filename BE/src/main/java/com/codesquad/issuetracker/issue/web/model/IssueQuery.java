package com.codesquad.issuetracker.issue.web.model;


import com.codesquad.issuetracker.label.data.Label;
import java.util.List;
import lombok.Getter;

@Getter
public class IssueQuery {

  private String title;
  private String content;
  private List<Label> labels;
}
