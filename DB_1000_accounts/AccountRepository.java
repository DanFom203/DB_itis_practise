package org.example;

import javax.sql.DataSource;
import java.sql.*;

public class AccountRepository {
    private final DataSource dataSource;

    public AccountRepository(DataSource dataSource){
        this.dataSource = dataSource;
    }

    //language=sql
    private static final String SQL_SAVE = "insert into accounts(first_name, last_name, city_id, phone_num, email, tag, patronymic, date_of_birth, profession, nationality) values (?,?,?,?,?,?,?,?,?,?)";

    public void save(Account account) {
        try (Connection connection = dataSource.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SQL_SAVE, PreparedStatement.RETURN_GENERATED_KEYS)) {

            preparedStatement.setString(1, account.getFirstName());
            preparedStatement.setString(2, account.getLastName());
            preparedStatement.setInt(3, account.getCityId());
            preparedStatement.setString(4, account.getPhoneNum());
            preparedStatement.setString(5, account.getEmail());
            preparedStatement.setString(6, account.getTag());
            preparedStatement.setString(7, account.getPatronymic());
            preparedStatement.setDate(8, (Date) account.getDate_of_birth());
            preparedStatement.setString(9, account.getProfession());
            preparedStatement.setString(10, account.getNationality());

            int affect = preparedStatement.executeUpdate();

            if (affect != 1) {
                throw new SQLException("Cannot insert account");
            }

            try (ResultSet generatedIds = preparedStatement.getGeneratedKeys()){
                if (generatedIds.next()) {
                    account.setId(generatedIds.getInt("id"));
                } else {
                    throw new SQLException("Cannot retrieve id");
                }
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
