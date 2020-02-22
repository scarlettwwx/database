DROP TABLE donor;
DROP TABLE individual;
DROP TABLE organization;
DROP TABLE healthcare_provider;
DROP TABLE employee;
DROP TABLE beneficiary;
DROP TABLE project;
DROP TABLE report;
DROP TABLE payment_in;
DROP TABLE payment_out;
DROP TABLE supervisor;
DROP TABLE supervises;
DROP TABLE enrolls;
DROP TABLE receiveService;
DROP TABLE workfor;
DROP TABLE authors;
DROP TABLE reviews;

-- Entity Set --
CREATE TABLE donor
(
    name VARCHAR(20),
    email VARCHAR(50) PRIMARY KEY NOT NULL,
    password VARCHAR(10) NOT NULL,
    bank_acc INTEGER
);

CREATE TABLE individual
(
    email VARCHAR(50) PRIMARY KEY NOT NULL,
    FOREIGN KEY (email) REFERENCES donor(email)
);

CREATE TABLE organization
(
    email VARCHAR(50) PRIMARY KEY NOT NULL,
    type VARCHAR(20) NOT NULL,
    CONSTRAINT check_type CHECK (type IN ('profitable','non-profitable')),
    FOREIGN KEY (email) REFERENCES donor(email)
);

CREATE TABLE healthcare_provider
(
    hid INTEGER PRIMARY KEY NOT NULL,
    name VARCHAR(20),
    addr VARCHAR(100)
);

CREATE TABLE employee
(
    eid INTEGER PRIMARY KEY NOT NULL,
    position VARCHAR(20),
    name VARCHAR(20)
);

CREATE TABLE beneficiary
(
    bid INTEGER PRIMARY KEY NOT NULL,
    name VARCHAR(20),
    date_of_birth DATE,
    reason_details VARCHAR(500)
);

CREATE TABLE project (
  proID INTEGER PRIMARY KEY NOT NULL,
  name VARCHAR(100),
  details VARCHAR(1000),
  budget INTEGER,
  raisedAmt INTEGER,
  startDate DATE,
  deadline  DATE,
  eid INTEGER,
  urgency INTEGER CHECK(urgency > 0 AND urgency < 4),
  FOREIGN KEY (eid) REFERENCES employee(eid)
  );

CREATE TABLE report (
  proID INTEGER NOT NULL, 
  rtime DATE NOT NULL, 
  title VARCHAR(100),
  detail VARCHAR(1000),
  PRIMARY KEY(proID, rtime),
  FOREIGN KEY(proID) REFERENCES project(proID)); 

CREATE TABLE payment_in(
  pid INTEGER NOT NULL,
  email VARCHAR(50) NOT NULL,
  proID INTEGER NOT NULL,
  amount INTEGER,
  ptime DATE,
  PRIMARY KEY(pid, email, proID),
  FOREIGN KEY(proID) REFERENCES project(proID),
  FOREIGN KEY(email) REFERENCES donor(email)
);

CREATE TABLE payment_out(
  pid INTEGER NOT NULL,
  hid INTEGER NOT NULL,
  proID INTEGER NOT NULL,
  amount INTEGER NOT NULL,
  ptime DATE NOT NULL,
  PRIMARY KEY(pid, hid, proID),
  FOREIGN KEY(proID) REFERENCES project(proID),
  FOREIGN KEY(hid) REFERENCES healthcare_provider(hid)
);

CREATE TABLE supervisor(
  name VARCHAR(30) PRIMARY KEY NOT NULL,
  address VARCHAR(50),
  duty VARCHAR(200)
);

-- Relationships --

CREATE TABLE supervises
(
    name VARCHAR(20) NOT NULL,
    address VARCHAR(100) NOT NULL,
    proID INTEGER NOT NULL,
    PRIMARY KEY (name, address, proID),
    FOREIGN KEY (name, address) REFERENCES supervisor(name, address),
    FOREIGN KEY (proID) REFERENCES project(proID)
);

CREATE TABLE enrolls
(
    bid INTEGER NOT NULL,
    proID INTEGER NOT NULL,
    eid INTEGER NOT NULL,
    PRIMARY KEY (bid,proID,eid),
    FOREIGN KEY (bid) REFERENCES beneficiary(bid),
    FOREIGN KEY (proID) REFERENCES project(proID),
    FOREIGN KEY (eid) REFERENCES employee(eid)
);

CREATE TABLE receiveService
(
    bid INTEGER NOT NULL,
    hid INTEGER NOT NULL,
    amount INTEGER,
    PRIMARY KEY (bid,hid),
    FOREIGN KEY (bid) REFERENCES beneficiary(bid),
    FOREIGN KEY (hid) REFERENCES healthcare_provider(hid)
);
                                        
CREATE TABLE reviews(
  email VARCHAR(50) NOT NULL,
  proID INTEGER NOT NULL,
  grade INTEGER,
  comment VARCHAR(50),
  PRIMARY KEY(email, proID),
  FOREIGN KEY(proID) REFERENCES project(proID),
  FOREIGN KEY(email) REFERENCES donor(email)
);

CREATE TABLE workfor(
  eid INTEGER NOT NULL,
  proID INTEGER NOT NULL,
  PRIMARY KEY (eid,proID),
  FOREIGN KEY(proID) REFERENCES project(proID),
  FOREIGN KEY(eid) REFERENCES employee(eid)
);

CREATE TABLE authors(
  eid INTEGER NOT NULL,
  proID INTEGER NOT NULL,
  --title VARCHAR(50) NOT NULL,
  rtime DATE NOT NULL,
  --PRIMARY KEY(eid, proID,rtime, title),
  PRIMARY KEY (eid,proID,rtime),
  FOREIGN KEY(proID) REFERENCES project(proID),
  FOREIGN KEY(eid) REFERENCES employee(eid),
  FOREIGN KEY(proId,rtime) REFERENCES report(proId, rtime)

);


