package com.codesquad.issuetracker.util;

import com.codesquad.issuetracker.auth.data.User;
import com.codesquad.issuetracker.config.property.JwtProperty;
import com.fasterxml.jackson.databind.ObjectMapper;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.JwtBuilder;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import java.nio.charset.StandardCharsets;
import java.time.Instant;
import java.time.temporal.ChronoUnit;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import lombok.RequiredArgsConstructor;
import org.apache.tomcat.util.codec.binary.Base64;
import org.springframework.stereotype.Component;

@RequiredArgsConstructor
@Component
public class JwtUtil {

  private final JwtProperty jwtProperty;

  public String create(Map<String, Object> claims) {
    Instant issuedAt = Instant.now().truncatedTo(ChronoUnit.SECONDS);
    Instant expiration = issuedAt
        .plus(jwtProperty.getExpiredMinute(), ChronoUnit.MINUTES);
    JwtBuilder jwtBuilder = Jwts.builder()
        .setHeaderParam("typ", "JWT")
        .setIssuedAt(Date.from(issuedAt))
        .setExpiration(Date.from(expiration))
        .setClaims(claims);

    return jwtBuilder.signWith(SignatureAlgorithm.HS256, generateKey()).compact();
  }

  private byte[] generateKey() {
    return jwtProperty.getSecret().getBytes(StandardCharsets.UTF_8);
  }

  public User getGitUser(String jwt) {
    Claims claims = Jwts.parser()
        .setSigningKey(generateKey())
        .parseClaimsJws(jwt)
        .getBody();

    return new ObjectMapper().convertValue(claims.get("User"), User.class);
  }

  public User getAppleUser(String jwt) {
    try {
      ObjectMapper objectMapper = new ObjectMapper();
      HashMap<String, String> body = objectMapper
          .readValue(Base64.decodeBase64(jwt.split("\\.")[1]), HashMap.class);

      return User.builder()
          .nodeId(body.get("sub"))
          .userId(body.get("email"))
          .build();
    } catch (Exception e) {
      throw new RuntimeException("잘못된 Apple JWT 입니다");
    }
  }

  public User getUser(String authorization) {
    String[] splitAuthorization = authorization.split(" ");
    if (splitAuthorization[0].equals("apple")) {
      return getAppleUser(splitAuthorization[1]);
    } else if (splitAuthorization[0].equals("git")) {
      return getGitUser(splitAuthorization[1]);
    } else {
      throw new RuntimeException("잘못된 Authorization Header 입니다");
    }
  }
}
