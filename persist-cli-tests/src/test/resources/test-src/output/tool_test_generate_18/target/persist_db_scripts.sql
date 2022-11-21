DROP TABLE IF EXISTS MedicalNeed;

DROP TABLE IF EXISTS MedicalItem;
CREATE TABLE MedicalItem (
	itemId INT NOT NULL AUTO_INCREMENT,
	name VARCHAR(191) NOT NULL,
	type VARCHAR(191) NOT NULL,
	unit VARCHAR(191) NOT NULL,
	PRIMARY KEY(itemId)
);

CREATE TABLE MedicalNeed (
	needId INT NOT NULL AUTO_INCREMENT,
	beneficiaryId INT NOT NULL,
	period DATETIME NOT NULL,
	urgency VARCHAR(191) NOT NULL,
	quantity INT NOT NULL,
	PRIMARY KEY(needId)
);