package org.example;

import lombok.*;
import java.util.Date;

@Builder
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class Account {
    private int id;
    private String firstName;
    private String lastName;
    private Integer cityId;
    private String phoneNum;
    private String email;
    private String tag;
    private String patronymic;
    private Date date_of_birth;
    private String profession;
    private String nationality;
}
