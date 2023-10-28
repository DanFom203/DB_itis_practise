package org.example;




import net.datafaker.Faker;

import java.sql.Date;


public class FillerApp {
    Faker faker;
    String[] list = new String[]{"user", "producer"};

    public FillerApp() {
        faker = new Faker();
    }

    public Account fill() {
        return Account.builder()
                .firstName(faker.name().firstName())
                .lastName(faker.name().lastName())
                .cityId(faker.random().nextInt(1,2))
                .phoneNum(faker.phoneNumber().subscriberNumber(10))
                .email(faker.internet().emailAddress())
                .tag(list[faker.random().nextInt(0,1)])
                .patronymic(faker.name().firstName())
                .date_of_birth(Date.valueOf(faker.date().birthday(1, 110).toLocalDateTime().toLocalDate()))
                .profession(faker.job().title())
                .nationality(faker.nation().nationality())
                .build();
    }
}
