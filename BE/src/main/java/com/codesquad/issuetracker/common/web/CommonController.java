package com.codesquad.issuetracker.common.web;

import com.codesquad.issuetracker.issue.data.Reply.EmojiType;
import io.swagger.annotations.ApiOperation;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RequiredArgsConstructor
@RequestMapping("/api/common")
@RestController
public class CommonController {

  @ApiOperation(value = "전체 Emoji 를 가져옵니다")
  @GetMapping("/emojis")
  public EmojiType[] emojis() {
    return EmojiType.values();
  }
}
