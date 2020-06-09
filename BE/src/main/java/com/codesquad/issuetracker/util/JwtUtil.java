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
import org.springframework.stereotype.Component;

@Component
public class JwtUtil {

  private final JwtProperty jwtProperty;

  public JwtUtil(JwtProperty jwtProperty) {
    this.jwtProperty = jwtProperty;
  }

  public String create(Map<String, ?> claims) {
    Instant issuedAt = Instant.now().truncatedTo(ChronoUnit.SECONDS);
    Instant expiration = issuedAt
        .plus(jwtProperty.getExpiredMinute(), ChronoUnit.MINUTES);
    JwtBuilder jwt = Jwts.builder()
        .setHeaderParam("typ", "JWT")
        .setIssuedAt(Date.from(issuedAt))
        .setExpiration(Date.from(expiration));
    for (String key : claims.keySet()) {
      jwt.claim(key, claims.get(key));
    }

    return jwt.signWith(SignatureAlgorithm.HS256, generateKey()).compact();
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
