package com.codesquad.issuetracker.issue.data;

import com.codesquad.issuetracker.issue.data.type.EmojiType;
import java.time.LocalDateTime;
import java.util.Objects;
import javax.persistence.Embeddable;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import lombok.Getter;
import org.hibernate.annotations.CreationTimestamp;

@Getter
@Embeddable
public class Reply {

  private String userId;
  private String contents;

  @Enumerated(EnumType.STRING)
  private EmojiType emoji;

  @CreationTimestamp
  private LocalDateTime createdAt;

  @Override
  public boolean equals(Object o) {
    if (this == o) {
      return true;
    }
    if (!(o instanceof Reply)) {
      return false;
    }
    Reply reply = (Reply) o;
    return Objects.equals(getUserId(), reply.getUserId()) &&
        Objects.equals(getContents(), reply.getContents()) &&
        getEmoji() == reply.getEmoji() &&
        Objects.equals(getCreatedAt(), reply.getCreatedAt());
  }

  @Override
  public int hashCode() {
    return Objects.hash(getUserId(), getContents(), getEmoji(), getCreatedAt());
  }
}
