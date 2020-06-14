package com.codesquad.issuetracker.issue.web;

import com.codesquad.issuetracker.auth.data.User;
import com.codesquad.issuetracker.issue.business.IssueService;
import com.codesquad.issuetracker.issue.data.Issue;
import com.codesquad.issuetracker.issue.web.model.IssueQuery;
import com.codesquad.issuetracker.util.JwtUtil;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiOperation;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RequiredArgsConstructor
@RequestMapping("/api/issues")
@RestController
public class IssueController {

  private final IssueService issueService;
  private final JwtUtil jwtUtil;

  @ApiOperation(value = "Issue 들을 가져옵니다")
  @ApiImplicitParam(name = "Authorization", required = true, paramType = "header")
  @GetMapping
  public List<Issue> getIssues() {
    return issueService.getIssues();
  }

  @ApiOperation(value = "특정 Issue 를 가져옵니다")
  @ApiImplicitParam(name = "Authorization", required = true, paramType = "header")
  @GetMapping("{issueId}")
  public Issue getIssue(@PathVariable Long issueId) {
    return issueService.getIssue(issueId);
  }

  @ApiOperation(value = "Issue 를 추가합니다")
  @ApiImplicitParam(name = "Authorization", required = true, paramType = "header")
  @PostMapping
  public Issue create(@RequestBody IssueQuery query, HttpServletRequest request) {
    User user = jwtUtil.parseUser(request.getHeader("Authorization"));
    return issueService.create(user, query);
  }

  @ApiOperation(value = "Issue 를 삭제합니다")
  @ApiImplicitParam(name = "Authorization", required = true, paramType = "header")
  @DeleteMapping("{issueId}")
  public void delete(@PathVariable Long issueId, HttpServletRequest request) {
    User user = jwtUtil.parseUser(request.getHeader("Authorization"));
    issueService.delete(user, issueId);
  }
}
