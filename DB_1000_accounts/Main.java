package org.example;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

public class Main {
    public static void main(String[] args) {

        HikariConfig hikariConfig = new HikariConfig();
        hikariConfig.setJdbcUrl("jdbc:postgresql://localhost:5432/postgres");
        hikariConfig.setUsername("postgres");
        hikariConfig.setPassword("Danfom2004");
        hikariConfig.setDriverClassName("org.postgresql.Driver");

        HikariDataSource dataSource = new HikariDataSource(hikariConfig);

        AccountRepository accountRepository = new AccountRepository(dataSource);

        FillerApp accountFiller = new FillerApp();

        for (int i = 0; i < 1000; i++) {
            accountRepository.save(accountFiller.fill());
        }
    }
}
