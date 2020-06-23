package com.codesquad.issuetracker;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatExceptionOfType;
import static org.springframework.test.web.servlet.setup.MockMvcBuilders.webAppContextSetup;

import com.codesquad.issuetracker.auth.data.User;
import com.codesquad.issuetracker.config.property.AppProperty;
import com.codesquad.issuetracker.util.JwtUtil;
import com.fasterxml.jackson.databind.ObjectMapper;
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

    @Autowired
    private JwtUtil jwtUtil;

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
      assertThat(redirectUrl).isNotNull();
      assertThat(redirectUrl.startsWith(appProperty.getGithubScheme())).isTrue();
    }

    @Nested
    @DisplayName("Authorization 으로 전달되는 JWT 에서 User 를 가져오는 것이 잘 되는지")
    @SpringBootTest
    public class JwtTest {

      @DisplayName("Apple JWT 으로")
      @Test
      void parseAppleJwt() throws Exception {
        // given
        String sampleAppleJwt = "eyJraWQiOiI4NkQ4OEtmIiwiYWxnIjoiUlMyNTYifQ.eyJpc3MiOiJodHRwczovL2FwcGxlaWQuYXBwbGUuY29tIiwiYXVkIjoiY29tLmRlbG1hLkFwcGxlTG9naW5TYW1wbGUiLCJleHAiOjE1OTI3NDc2MjQsImlhdCI6MTU5Mjc0NzAyNCwic3ViIjoiMDAwNTQxLmJjMTkzY2RkYWZjODQ2NDhhMzFjMGIyZTM3NDI1Y2QxLjEzMDEiLCJjX2hhc2giOiJyLXAzeHpOWU5tbWxkRnRsaEJIbmV3IiwiZW1haWwiOiJzZHkyODU2QG5hdGUuY29tIiwiZW1haWxfdmVyaWZpZWQiOiJ0cnVlIiwiYXV0aF90aW1lIjoxNTkyNzQ3MDI0LCJub25jZV9zdXBwb3J0ZWQiOnRydWV9.SfrHDhEYVmeYq24U4zMhtlNPnoD7XR16cmm5oy3UMBPPDV9uXVOGI3kaof6-3RfqDp1acFrBizmnkqy_uQRTDyMfzY0Bfx-UqOGBttWg7B3-9lSvaYuUjUrbSP1qMY6nTulliC5uXY5bstbZugOk5NDlCZHgEdP02CK_BPORSGE30dNv_bK_69A64M06Za5zbQ2IkhU-Sa6rMC3d-G-CwcClRrQ6TUKc9zXI4t6m_TwrbrzSTBgLqRZUs5KILGTvfV8zKw9v-GKaWALgHr-UxxskdoMDuXhFD5tsMp8sp0qfu9J4yUDY1vbBfUS8xnyb5nkP8eepRj10BLwOAZZGAw";

        // when
        User appleUser = jwtUtil.getUser(sampleAppleJwt);

        // then
        assertThat(appleUser.getUserId())
            .isNotNull()
            .isEqualTo("sdy2856@nate.com");
        assertThat(appleUser.getNodeId()).isNotNull();
        assertThat(appleUser.getAvatarUrl()).isNull();
      }

      @DisplayName("Git JWT 으로")
      @Test
      void parseGitJwt() throws Exception {
        // given
        String sampleAppleJwt = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE1OTE3MjYxNjIsImV4cCI6MTk1MTcyNjE2MiwiVXNlciI6eyJub2RlSWQiOiJNRFE2VlhObGNqVTFOekl5TVRnMiIsInVzZXJJZCI6Ikh5dW5lLWMiLCJhdmF0YXJVcmwiOiJodHRwczovL2F2YXRhcnMxLmdpdGh1YnVzZXJjb250ZW50LmNvbS91LzU1NzIyMTg2P3Y9NCJ9fQ.ochu0snlMTyK-hTNfNimYqoHOOpxcbLXpvEEcqp-WTY";

        // when
        User appleUser = jwtUtil.getUser(sampleAppleJwt);

        // then
        assertThat(appleUser.getUserId())
            .isNotNull()
            .isEqualTo("Hyune-c");
        assertThat(appleUser.getNodeId()).isNotNull();
        assertThat(appleUser.getAvatarUrl()).isNotNull();
      }
    }
  }
}
