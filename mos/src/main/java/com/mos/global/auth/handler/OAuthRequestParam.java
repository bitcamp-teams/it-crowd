package com.mos.global.auth.handler;

import com.mos.global.auth.handler.OAuthRequestData;
import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum OAuthRequestParam {
  /* KAKAO */
  KAKAO_AUTHORIZATION_CODE("grant_type","authorization_code"),
  KAKAO_API_URI(null, OAuthRequestData.KAKAO_API_URI),
  KAKAO_CLIENT_ID("client_id", OAuthRequestData.KAKAO_CLIENT_ID),
  KAKAO_CLIENT_SECRET("client_secret", OAuthRequestData.KAKAO_CLIENT_SECRET),
  KAKAO_REDIRECT_URL("redirect_uri", OAuthRequestData.KAKAO_REDIRECT_URL),
  KAKAO_AUTH_URI(null, OAuthRequestData.KAKAO_AUTH_URI),

  /* GITHUB */
  GITHUB_CLIENT_ID("client_id", OAuthRequestData.GITHUB_CLIENT_ID),
  GITHUB_CLIENT_SECRET("client_secret", OAuthRequestData.GITHUB_CLIENT_SECRET);

  private final String key;
  private final String param;
}