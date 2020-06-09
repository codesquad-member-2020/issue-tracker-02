package com.codesquad.issuetracker.issue.web;

import com.codesquad.issuetracker.auth.data.User;
import com.codesquad.issuetracker.issue.business.IssueService;
import com.codesquad.issuetracker.issue.data.Issue;
import com.codesquad.issuetracker.util.JwtUtil;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiOperation;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RequiredArgsConstructor
@RequestMapping("/api/issue")
@RestController
public class IssueController {

  private final IssueService issueService;
  private final JwtUtil jwtUtil;

  @ApiOperation(value = "Issue 를 가져옵니다")
  @ApiImplicitParam(name = "Authorization", required = true, paramType = "header")
  @GetMapping
  public List<Issue> getIssues(HttpServletRequest request) {
    User user = jwtUtil.parseUser(request.getHeader("Authorization"));
    return issueService.getIssues(user);
  }
}
