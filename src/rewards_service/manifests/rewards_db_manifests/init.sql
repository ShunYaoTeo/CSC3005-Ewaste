CREATE DATABASE IF NOT EXISTS rewards_eWaste;
GRANT ALL PRIVILEGES ON rewards_eWaste.* TO 'eWaste_user'@'%';
USE rewards_eWaste;

CREATE TABLE Rewards (
    RewardId INT AUTO_INCREMENT,
    RewardName VARCHAR(255),
    Cost INT,
    PRIMARY KEY (RewardId)
);

CREATE TABLE UserRewards (
    Username VARCHAR(255),
    RewardId INT,
    Redeemed BOOLEAN,
    FOREIGN KEY (RewardId) REFERENCES Rewards(RewardId)
);

CREATE TABLE UserPoints (
    Username VARCHAR(255),
    Points INT,
    PRIMARY KEY (Username)
);


INSERT INTO Rewards (RewardName, Cost) VALUES
("$100 Lazada Code", 10),
("$200 Lazada Code", 20),
("$300 Google Play Store Code", 30),
("$300 Apple Store Code", 40),
("$1000 Shopeepeepee Code", 500)