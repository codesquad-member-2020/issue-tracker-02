package com.codesquad.issuetracker.label.web;

import com.codesquad.issuetracker.label.business.LabelService;
import com.codesquad.issuetracker.label.web.model.LabelQuery;
import com.codesquad.issuetracker.label.web.model.LabelView;
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
@RequestMapping("/api/labels")
@RestController
public class LabelController {

  private final LabelService labelService;

  @ApiOperation(value = "Label 들을 가져옵니다")
  @GetMapping
  public List<LabelView> getLabels() {
    return labelService.getLabels();
  }

  @ApiOperation(value = "특정 Label 을 가져옵니다")
  @GetMapping("{labelId}")
  public LabelView getLabel(@PathVariable Long labelId) {
    return labelService.getLabel(labelId);
  }

  @ApiOperation(value = "Label 을 추가합니다")
  @PostMapping
  public LabelView create(@RequestBody LabelQuery query) {
    return labelService.create(query);
  }

  @ApiOperation(value = "Label 을 삭제합니다")
  @DeleteMapping("{labelId}")
  public void delete(@PathVariable Long labelId) {
    labelService.delete(labelId);
  }

  @ApiOperation(value = "Label 을 수정합니다")
  @PutMapping
  public LabelView put(@PathVariable Long labelId, @RequestBody LabelQuery query) {
    return labelService.put(labelId, query);
  }
}
