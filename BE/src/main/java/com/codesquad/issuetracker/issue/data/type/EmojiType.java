package com.codesquad.issuetracker.issue.data.type;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum EmojiType {
  THUMB_UP("THUMB_UP"), THUMB_DOWN("THUMB_DOWN"), LAUGH("LAUGH"), HOORAY("HOORAY"), CONFUSED(
      "CONFUSED"), HEART("HEART"), ROCKET("ROCKET"), EYES("EYES");

  private final String key;
}
