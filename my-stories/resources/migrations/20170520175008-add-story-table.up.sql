CREATE TABLE story
(id VARCHAR(36) PRIMARY KEY NOT NULL,
  narrative VARCHAR(255),
  category VARCHAR(100),
  feature VARCHAR(100),
  priority VARCHAR(200),
  tsize CHAR(5),
  projectId VARCHAR(20) REFERENCES project (id))
