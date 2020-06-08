package com.codesquad.issuetracker;

import com.codesquad.issuetracker.config.property.JwtProperty;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.properties.EnableConfigurationProperties;

@EnableConfigurationProperties(JwtProperty.class)
@SpringBootApplication
public class IssueTrackerApplication {

  public static void main(String[] args) {
    SpringApplication.run(IssueTrackerApplication.class, args);
  }
}
