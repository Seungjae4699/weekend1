package com.weekend1.db;

import javax.sql.DataSource;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.jdbc.datasource.DriverManagerDataSource;

@Configuration
public class DatabaseConfig {
	
	@Bean
    public DataSource dataSource() {
        DriverManagerDataSource dataSource = new DriverManagerDataSource();
        dataSource.setDriverClassName("org.postgresql.Driver");
        dataSource.setUrl("jdbc:postgresql://61.41.100.252:35432/edu_hsj"); 
        dataSource.setUsername("gb_hsj"); // PostgreSQL의 사용자 이름
        dataSource.setPassword("gb1234!@#$"); // PostgreSQL의 암호
        
        return dataSource;
    }
	
}
