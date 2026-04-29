package com.bank.transaction.service;

import com.bank.util.OracleErrorMapper;
import org.springframework.stereotype.Service;

import javax.sql.DataSource;
import java.sql.*;

@Service
public class TransactionService {

    private final DataSource dataSource;

    public TransactionService(DataSource dataSource) {
        this.dataSource = dataSource;
    }

//    transfer model
    public Long transferMoney(Long from, Long to, Double amount, String channel) {

        try (Connection conn = dataSource.getConnection()) {

            CallableStatement stmt = conn.prepareCall(
                    "{call pkg_transaction_service.transfer_money(?,?,?,?,?)}"
            );

            stmt.setLong(1, from);
            stmt.setLong(2, to);
            stmt.setDouble(3, amount);
            // stmt.setString(4, type);
            stmt.setString(4, channel);

            // OUT param
            stmt.registerOutParameter(5, Types.NUMERIC);

            stmt.execute();

            return stmt.getLong(5);

        } catch (SQLException e) {
            OracleErrorMapper.handle(e);
        }
        return null;
    }

//    deposit model
    public Long depositMoney(Long accountId, Double amount, String channel){
        try(Connection conn = dataSource.getConnection()){
            CallableStatement stmt = conn.prepareCall(
                    "{call pkg_transaction_service.deposit_money(?,?,?,?)}"
            );

            stmt.setLong(1, accountId);
            stmt.setDouble(2, amount);
            stmt.setString(3, channel);

            stmt.registerOutParameter(4, Types.NUMERIC);

            stmt.execute();

            return stmt.getLong(4);
        }catch (SQLException e) {
            OracleErrorMapper.handle(e);
        }
        return null;
    }

//    withdraw model
    public Long withdrawMoney(Long accountId, Double amount, String channel){
        try(Connection conn = dataSource.getConnection()){
            CallableStatement stmt = conn.prepareCall(
                    "{call pkg_transaction_service.withdraw_money(?,?,?,?)}"
            );
            stmt.setLong(1, accountId);
            stmt.setDouble(2, amount);
            stmt.setString(3, channel);

            stmt.registerOutParameter(4, Types.NUMERIC);

            stmt.execute();

            return stmt.getLong(4);
        }catch (SQLException e) {
            OracleErrorMapper.handle(e);
        }
        return null;
    }
}
