package com.codesquad.issuetracker.milestone.web;

import com.codesquad.issuetracker.milestone.business.MilestoneService;
import com.codesquad.issuetracker.milestone.web.model.MilestoneQuery;
import com.codesquad.issuetracker.milestone.web.model.MilestoneView;
import io.swagger.annotations.ApiOperation;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RequiredArgsConstructor
@RequestMapping("/api/milestones")
@RestController
public class MilestoneController {

  private final MilestoneService mileStoneService;

  @ApiOperation(value = "MileStone 들을 가져옵니다")
  @GetMapping
  public List<MilestoneView> getMileStones() {
    return mileStoneService.getMilestones();
  }

  @ApiOperation(value = "특정 MileStone 를 가져옵니다")
  @GetMapping("/{mileStoneId}")
  public MilestoneView getMileStone(@PathVariable Long mileStoneId) {
    return mileStoneService.getMilestone(mileStoneId);
  }

  @ApiOperation(value = "MileStone 를 추가합니다")
  @PostMapping
  public MilestoneView create(@RequestBody MilestoneQuery query) {
    return mileStoneService.create(query);
  }

  @ApiOperation(value = "MileStone 를 삭제합니다")
  @DeleteMapping("/{mileStoneId}")
  public void delete(@PathVariable Long mileStoneId) {
    mileStoneService.delete(mileStoneId);
  }

  @ApiOperation(value = "MileStone 를 수정합니다")
  @PutMapping("/{milestoneId}")
  public MilestoneView put(@PathVariable Long milestoneId, @RequestBody MilestoneQuery query) {
    return mileStoneService.put(milestoneId, query);
  }
}
