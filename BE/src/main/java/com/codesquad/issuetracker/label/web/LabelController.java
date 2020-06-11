package com.codesquad.issuetracker.label.web;

import com.codesquad.issuetracker.auth.data.User;
import com.codesquad.issuetracker.label.business.LabelService;
import com.codesquad.issuetracker.label.data.Label;
import com.codesquad.issuetracker.label.web.model.LabelQuery;
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
@RequestMapping("/api/labels")
@RestController
public class LabelController {

  private final LabelService labelService;
  private final JwtUtil jwtUtil;

  @ApiOperation(value = "Label 들을 가져옵니다")
  @ApiImplicitParam(name = "Authorization", required = true, paramType = "header")
  @GetMapping
  public List<Label> getLabels(HttpServletRequest request) {
    User user = jwtUtil.parseUser(request.getHeader("Authorization"));
    return labelService.getLabels();
  }

  @ApiOperation(value = "특정 Label 를 가져옵니다")
  @ApiImplicitParam(name = "Authorization", required = true, paramType = "header")
  @GetMapping("{labelId}")
  public Label getLabel(@PathVariable Long labelId, HttpServletRequest request) {
    User user = jwtUtil.parseUser(request.getHeader("Authorization"));
    return labelService.getLabel(labelId);
  }

  @ApiOperation(value = "Label 를 추가합니다")
  @ApiImplicitParam(name = "Authorization", required = true, paramType = "header")
  @PostMapping
  public Label create(@RequestBody LabelQuery query, HttpServletRequest request) {
    User user = jwtUtil.parseUser(request.getHeader("Authorization"));
    return labelService.create(query);
  }

  @ApiOperation(value = "Label 를 삭제합니다")
  @ApiImplicitParam(name = "Authorization", required = true, paramType = "header")
  @DeleteMapping("{labelId}")
  public void delete(@PathVariable Long labelId, HttpServletRequest request) {
    User user = jwtUtil.parseUser(request.getHeader("Authorization"));
    labelService.delete(labelId);
  }
}
