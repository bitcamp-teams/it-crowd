package com.mos.domain.noti.dto;

import lombok.Data;

@Data
public class NotiDto {

  private int id;
  private int recipientId;
  private String message;
  private String link;
  private boolean read;
}
