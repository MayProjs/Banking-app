CREATE TABLE transaction_channels(
    channel_code VARCHAR2(30) PRIMARY KEY
);


INSERT INTO transaction_channels VALUES ('NET_BANKING');
INSERT INTO transaction_channels VALUES ('UPI');
INSERT INTO transaction_channels VALUES ('ATM');

INSERT INTO transaction_channels VALUES ('UNKNOWN');