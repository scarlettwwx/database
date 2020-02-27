--View
DROP VIEW BigProjects;
DROP VIEW GenerousDonors;
-- Create a view that returns the projects (name and proID) that has spent more than 5000 dollars.
CREATE VIEW BigProjects (proId,name) AS
    SELECT project.proID, project.name
    FROM project,
        (SELECT payment_out.proID tid,SUM(payment_out.AMOUNT) tamt
        FROM PAYMENT_OUT
        GROUP BY proID) temp
    WHERE project.proID = temp.tid AND temp.tamt > 5000;

SELECT * FROM BigProjects;
UPDATE BigProjects
    SET NAME = 'Big Project 005'
    WHERE proID = 60005;
-- fails because the view definition contains a GROUP BY

-- Create a view that returns the donors (name and email) that has made a donation to a project with urgency level 3.
CREATE VIEW GenerousDonors (name,email) AS
    SELECT DISTINCT donor.name, donor.email
    FROM donor, (
                SELECT payment_in.email tacc
                FROM payment_in, project
                WHERE payment_in.proID = project.proID AND project.urgency = 3
        ) t
    WHERE donor.email = t.tacc;

SELECT * FROM GenerousDonors;

UPDATE GenerousDonors
SET NAME = 'Generous Donors';