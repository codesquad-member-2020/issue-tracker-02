package com.codesquad.issuetracker.milestone.web;

import com.codesquad.issuetracker.auth.data.User;
import com.codesquad.issuetracker.milestone.business.MileStoneService;
import com.codesquad.issuetracker.milestone.data.MileStone;
import com.codesquad.issuetracker.milestone.web.model.GetMileStonesView;
import com.codesquad.issuetracker.milestone.web.model.MileStoneQuery;
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
@RequestMapping("/api/milestones")
@RestController
public class MileStoneController {

  private final MileStoneService mileStoneService;
  private final JwtUtil jwtUtil;

  @ApiOperation(value = "MileStone 들을 가져옵니다")
  @ApiImplicitParam(name = "Authorization", required = true, paramType = "header")
  @GetMapping
  public List<GetMileStonesView> getMileStones(HttpServletRequest request) {
    User user = jwtUtil.parseUser(request.getHeader("Authorization"));
    return mileStoneService.getMileStones();
  }

  @ApiOperation(value = "특정 MileStone 를 가져옵니다")
  @ApiImplicitParam(name = "Authorization", required = true, paramType = "header")
  @GetMapping("{mileStoneId}")
  public MileStone getMileStone(@PathVariable Long mileStoneId, HttpServletRequest request) {
    User user = jwtUtil.parseUser(request.getHeader("Authorization"));
    return mileStoneService.getMileStone(mileStoneId);
  }

  @ApiOperation(value = "MileStone 를 추가합니다")
  @ApiImplicitParam(name = "Authorization", required = true, paramType = "header")
  @PostMapping
  public MileStone create(@RequestBody MileStoneQuery query, HttpServletRequest request) {
    User user = jwtUtil.parseUser(request.getHeader("Authorization"));
    return mileStoneService.create(query);
  }

  @ApiOperation(value = "MileStone 를 삭제합니다")
  @ApiImplicitParam(name = "Authorization", required = true, paramType = "header")
  @DeleteMapping("{mileStoneId}")
  public void delete(@PathVariable Long mileStoneId, HttpServletRequest request) {
    User user = jwtUtil.parseUser(request.getHeader("Authorization"));
    mileStoneService.delete(mileStoneId);
  }
}
