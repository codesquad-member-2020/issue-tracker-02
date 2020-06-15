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
import java.util.Map;
import lombok.RequiredArgsConstructor;
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

  public User parseUser(String jwt) {
    Claims claims = Jwts.parser()
        .setSigningKey(generateKey())
        .parseClaimsJws(jwt)
        .getBody();

    return new ObjectMapper().convertValue(claims.get("User"), User.class);
  }
}
