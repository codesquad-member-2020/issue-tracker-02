package com.codesquad.issuetracker.issue.data;

import java.time.LocalDateTime;
import java.util.Set;
import javax.persistence.ElementCollection;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.CreationTimestamp;

@Getter
@NoArgsConstructor
@Entity
public class Reply {

  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Long id;

  private String userId;
  private String content;

  @ElementCollection(fetch = FetchType.EAGER)
  @Enumerated(EnumType.STRING)
  private Set<EmojiType> emojis;

  @CreationTimestamp
  private LocalDateTime createdAt;

  public enum EmojiType {
    THUMB_UP, THUMB_DOWN, LAUGH, HOORAY, CONFUSED, HEART, ROCKET, EYES;
  }
}
