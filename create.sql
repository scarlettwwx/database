CREATE TABLE project (
  proID INTEGER PRIMARY KEY NOT NULL,
  name VARCHAR(20),
  details VARCHAR(1000),
  budget INTEGER,
  raisedAmt INTEGER,
  startDate DATE,
  deadline  DATE,
  eid INTEGER,
  urgency INTEGER CHECK(rating > 0 AND rating < 4)
  FOREIGN KEY(eid) REFERENCES employee(eid));

CREATE TABLE report (
  proID INTEGER NOT NULL, 
  rtime DATE NOT NULL, 
  title VARCHAR(100),
  detail VARCHAR(1000),
  PRIMARY KEY(proID, rtime)
  FOREIGN KEY(proID) REFERENCES project(proID)); 

CREATE TABLE payment_in(
  pid INTEGER NOT NULL,
  email VARCHAR(50) NOT NULL,
  proID INTEGER NOT NULL,
  amount INTEGER,
  ptime DATE,
  PRIMARY KEY(pid, email, proID)
  FOREIGN KEY(proID) REFERENCES project(proID),
  FOREIGN KEY(email) REFERENCES donor(email)
)

CREATE TABLE payment_out(
  pid INTEGER NOT NULL,
  hid INTEGER NOT NULL,
  proID INTEGER NOT NULL,
  amount INTEGER NOT NULL,
  ptime DATE NOT NULL,
  PRIMARY KEY(pid, hid, proID)
  FOREIGN KEY(proID) REFERENCES project(proID),
  FOREIGN KEY(hid) REFERENCES healthcare(hid)
)

CREATE TABLE supervisor(
  name VARCHAR(30) PRIMARY KEY NOT NULL
  address VARCHAR(50)
  duty VARCHAR(200)
)

CREATE TABLE healthcare(
  hid INTEGER PRIMARY KEY NOT NULL
  name VARCHAR(50)
  address VARCHAR(50)
)
