package com.mos.global.auth.handler;

import com.google.gson.GsonBuilder;
import lombok.Getter;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

@Getter
@Component
public class OAuthRequestData {

  public String code;

  /* KAKAO
  *     kakao.client.id=
        kakao.client.secret=
        kakao.redirect.url=
        kakao.auth.uri=
        kakao.api.url=
  * */
  public static String KAKAO_API_URI;
  public static String KAKAO_CLIENT_ID;
  public static String KAKAO_CLIENT_SECRET;
  public static String KAKAO_REDIRECT_URL;
  public static String KAKAO_AUTH_URI;

  public OAuthRequestData setCode(String code) {
    this.code = code;
    return this;
  }

  @Value("${kakao.api.url}")
  public void setKakaoApiUri(String kakaoApiUri) {
    KAKAO_API_URI = kakaoApiUri;
  }

  @Value("${kakao.client.id}")
  public void setKakaoClientId(String kakaoClientId) {
    KAKAO_CLIENT_ID = kakaoClientId;
  }

  @Value("${kakao.client.secret}")
  public void setKakaoClientSecret(String kakaoClientSecret) {
    KAKAO_CLIENT_SECRET = kakaoClientSecret;
  }

  @Value("${kakao.redirect.url}")
  public void setKakaoRedirectUrl(String kakaoRedirectUrl) {
    KAKAO_REDIRECT_URL = kakaoRedirectUrl;
  }

  @Value("${kakao.auth.uri}")
  public void setKakaoAuthUri(String kakaoAuthUri) {
    KAKAO_AUTH_URI = kakaoAuthUri;
  }


  /* GITHUB
  *     github.clientId=
        github.clientSecret=
  * */
  public static String GITHUB_CLIENT_ID;
  public static String GITHUB_CLIENT_SECRET;

  @Value("${github.clientId}")
  public static void setGithubClientId(String githubClientId) {
    GITHUB_CLIENT_ID = githubClientId;
  }

  @Value("${github.clientSecret}")
  public static void setGithubClientSecret(String githubClientSecret) {
    GITHUB_CLIENT_SECRET = githubClientSecret;
  }

  @Override
  public String toString() {
    return new GsonBuilder().create().toJson(this);
  }


}