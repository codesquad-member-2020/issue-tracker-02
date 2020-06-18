package com.codesquad.issuetracker;

import static org.springframework.test.web.servlet.setup.MockMvcBuilders.webAppContextSetup;

import com.codesquad.issuetracker.auth.data.User;
import com.codesquad.issuetracker.config.property.AppProperty;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.assertj.core.api.Assertions;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Nested;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.ResultActions;
import org.springframework.test.web.servlet.request.MockHttpServletRequestBuilder;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.web.context.WebApplicationContext;

@DisplayName("Auth")
public class AuthTest {

  @Nested
  @DisplayName("Integration")
  @SpringBootTest
  public class IntegrationTest {

    @Autowired
    private WebApplicationContext webApplicationContext;

    @Autowired
    private AppProperty appProperty;

    private MockMvc mockMvc;
    private User sampleUser;
    private ObjectMapper mapper;

    @BeforeEach
    public void setup() {
      mockMvc = webAppContextSetup(webApplicationContext).build();
      mapper = new ObjectMapper();
      sampleUser = User.builder()
          .nodeId("TESTNODEID")
          .userId("Hyune-c")
          .avatarUrl("https://avatars1.githubusercontent.com/u/55722186?v=4").build();
    }

    @DisplayName("App Scheme 과 일치하는지")
    @Test
    void token() throws Exception {
      // given
      MockHttpServletRequestBuilder createMessage = MockMvcRequestBuilders.post("/api/oauth2/token")
          .contentType(MediaType.APPLICATION_JSON)
          .content(mapper.writeValueAsString(sampleUser));

      // when
      ResultActions resultActions = mockMvc.perform(createMessage);
      System.out.println(resultActions);

      // then
//      resultActions.andExpect(MockMvcResultMatchers.redirectedUrlPattern("github.*"));

      String redirectUrl = resultActions.andReturn().getResponse().getRedirectedUrl();
      Assertions.assertThat(redirectUrl).isNotNull();
      Assertions.assertThat(redirectUrl.startsWith(appProperty.getGithubScheme())).isTrue();
    }
  }
}
