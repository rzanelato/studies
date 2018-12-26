DROP DATABASE IF EXISTS vintage_barbers;
CREATE DATABASE vintage_barbers;
USE vintage_barbers;
	
	
CREATE TABLE user_type (
	user_typeID				INT		(3)		NOT NULL	AUTO_INCREMENT,
	type_name				VARCHAR	(60)	NOT NULL,
	CONSTRAINT PK_UserType 		PRIMARY KEY (user_typeID)
);

ALTER TABLE user_type AUTO_INCREMENT=1;
 
CREATE TABLE users (
	userID					INT    	(10)    NOT NULL	AUTO_INCREMENT,
    email       			VARCHAR	(60)    NOT NULL,
    passWd   	 			VARCHAR	(60)    NOT NULL,
    first_name  			VARCHAR	(60)    NOT NULL,
    last_name   			VARCHAR	(60)    NOT NULL,
	mobileNo 	    		INT    	(15)    NOT NULL,
	user_typeID   			INT		(3)		NOT NULL,
	created_on				DATETIME		NOT NULL	DEFAULT NOW(),
    CONSTRAINT PK_User 			PRIMARY KEY (userID),
	CONSTRAINT FK_User_Type		FOREIGN KEY (user_typeID)		REFERENCES user_type (user_typeID)
);

CREATE TABLE shops (
	shopCode     			VARCHAR (10)    NOT NULL,
	shopName   				VARCHAR	(60)    NOT NULL,
	phoneNo 				INT		(15)	NOT NULL,
	stAddress				VARCHAR	(60)    NOT NULL,
	county					VARCHAR	(60)	NOT NULL,
	city					VARCHAR (50)	NOT NULL,
	CONSTRAINT PK_BarberShop	PRIMARY KEY (shopCode)
);

CREATE TABLE barbers (
    userID					INT		(10)	NOT NULL,
	shopCode    			VARCHAR (10)	NOT NULL,
    work_hour_start			TIME			NOT NULL,
    work_hour_end			TIME			NOT NULL,
    CONSTRAINT COMP_Shop_Staff	PRIMARY KEY (userID, shopCode),
    CONSTRAINT FK_User_Barber	FOREIGN KEY	(userID)			REFERENCES users (userID),
    CONSTRAINT FK_Shop			FOREIGN KEY (shopCode)			REFERENCES shops (shopCode)
);

ALTER TABLE barbers AUTO_INCREMENT=1;

CREATE TABLE appointment_status (
	statusID				INT	(3)			NOT NULL	AUTO_INCREMENT,
	status_name 			VARCHAR (60)	NOT NULL,
	CONSTRAINT PK_Appt_Status 	PRIMARY KEY (statusID)
); 

ALTER TABLE appointment_status AUTO_INCREMENT = 1;


CREATE TABLE services (
	serviceID				INT 	(3)		NOT NULL	AUTO_INCREMENT,
	serviceName				VARCHAR	(60)	NOT NULL,
	price					DOUBLE 	(10,2)	NOT NULL,
	CONSTRAINT PK_Services  	PRIMARY KEY	(serviceID)
);

ALTER TABLE services AUTO_INCREMENT = 1;

CREATE TABLE booking_channel (
	booking_channelID		INT		(3)		NOT NULL	AUTO_INCREMENT,
    channel_name			VARCHAR (60)	NOT NULL,
    CONSTRAINT PK_Services  	PRIMARY KEY	(booking_channelID)
);

ALTER TABLE booking_channel AUTO_INCREMENT = 1;

CREATE TABLE appointments (
    apptID      			INT    	(10)    NOT NULL	AUTO_INCREMENT,
    start_time				DATETIME		NOT NULL,
    end_time				DATETIME		NOT NULL,
    custID     				INT     (10),
	cust_name				VARCHAR (100),
	cust_phone				VARCHAR	(60),
    barberID    			INT     (10),
	shopCode    			VARCHAR (10)    NOT NULL, 
	statusID				INT 	(3)     NOT NULL,	
	created_on				DATETIME		NOT NULL	DEFAULT NOW(),
    reviewID				INT 	(10),
    booking_channelID		INT		(3)		NOT NULL,
    CONSTRAINT PK_Appointment  	PRIMARY KEY	(apptID),
	CONSTRAINT FK_Cust_Appt 	FOREIGN KEY (custID)			REFERENCES users (userID),    
	CONSTRAINT FK_Barber_Appt	FOREIGN KEY (barberID)			REFERENCES users (userID),
    CONSTRAINT FK_Shop_Appt		FOREIGN KEY (shopCode)  		REFERENCES shops (shopCode),
	CONSTRAINT FK_Status		FOREIGN	KEY	(statusID)			REFERENCES appointment_status(statusID),
    CONSTRAINT FK_Book_Channel	FOREIGN KEY	(booking_channelID)	REFERENCES booking_channel (booking_channelID)
 
);

ALTER TABLE appointments AUTO_INCREMENT = 1;

CREATE TABLE bookedServices (
	apptID					INT 	(10)	NOT NULL,
	serviceID				INT 	(3)		NOT NULL,
    CONSTRAINT COMP_Booked_Serv	PRIMARY KEY (apptID, serviceID),
	CONSTRAINT FK_Services  	FOREIGN KEY	(serviceID)			REFERENCES services (serviceID),
	CONSTRAINT FK_Appt_Serv		FOREIGN KEY (apptID)			REFERENCES appointments (apptID)	
);

CREATE TABLE reviews (
	reviewID				INT 	(10)	NOT NULL	AUTO_INCREMENT,
    custID					INT     (10)	NOT NULL,
    barberID				INT 	(10)	NOT NULL,
    anonymous				CHAR	(1)		NOT NULL,
    wait_time_rating		INT		(2),
    service_rating			INT     (2),
    overall_rating			INT		(2),
    review					VARCHAR (1000),
    recommended_barber		CHAR	(1),
    review_date				DATETIME	NOT NULL	DEFAULT NOW(),
    CONSTRAINT PK_Reviews 			PRIMARY KEY	(reviewID),
	CONSTRAINT FK_Cust_User 		FOREIGN KEY (custID)		REFERENCES users (userID),
	CONSTRAINT FK_Barber_User 		FOREIGN KEY (barberID)		REFERENCES users (userID)

);	

ALTER TABLE appointments ADD CONSTRAINT FK_Reviews FOREIGN	KEY	(reviewID) REFERENCES reviews (reviewID);

