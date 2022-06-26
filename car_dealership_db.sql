CREATE TABLE "city" (
  "city_id" SERIAL,
  "city_name" VARCHAR(45),
  PRIMARY KEY ("city_id")
);

CREATE TABLE "address" (
  "address_id" SERIAL,
  "city_id" INTEGER,
  "postal_code" VARCHAR(45),
  "address_name" VARCHAR(45),
  PRIMARY KEY ("address_id"),
  CONSTRAINT "FK_address.city_id"
    FOREIGN KEY ("city_id")
      REFERENCES "city"("city_id")
);

CREATE TABLE "customer" (
  "customer_id" SERIAL,
  "first_name" VARCHAR(45),
  "last_name" VARCHAR(45),
  "email" VARCHAR(45),
  "address_id" INTEGER,
  "phone" VARCHAR(20),
  PRIMARY KEY ("customer_id"),
  CONSTRAINT "FK_customer.address_id"
    FOREIGN KEY ("address_id")
      REFERENCES "address"("address_id")
);

CREATE TABLE "parts_inventory" (
  "part_id" SERIAL,
  "part_name" VARCHAR(45),
  "amount" NUMERIC(6, 2),
  PRIMARY KEY ("part_id")
);

CREATE TABLE "staff" (
  "staff_id" INTEGER,
  "first_name" VARCHAR(45),
  "last_name" VARCHAR(45),
  "email" VARCHAR(45),
  "password" VARCHAR(45),
  PRIMARY KEY ("staff_id")
);




CREATE TABLE "service" (
  "service_id" SERIAL,
  "service_type" VARCHAR(20),
  "amount" NUMERIC(6,2),
  PRIMARY KEY ("service_id")
);

CREATE TABLE "car" (
  "car_id" SERIAL,
  "serial_number" INTEGER,
  "make" VARCHAR(15),
  "model" VARCHAR(15),
  "year" INTEGER,
  "used_or_new" VARCHAR(5),
  PRIMARY KEY ("car_id")
);

CREATE TABLE "invoice" (
  "invoice_id" SERIAL,
  "amount" NUMERIC(8,2),
  "date" DATE,
  "car_id" INTEGER,
  "customer_id" INTEGER,
  "staff_id" INTEGER,
  "ticket_id" INTEGER,
  PRIMARY KEY ("invoice_id"),
  CONSTRAINT "FK_invoice.customer_id"
    FOREIGN KEY ("customer_id")
      REFERENCES "customer"("customer_id"),
  CONSTRAINT "FK_invoice.staff_id"
    FOREIGN KEY ("staff_id")
      REFERENCES "staff"("staff_id"),
  CONSTRAINT "FK_invoice.car_id"
    FOREIGN KEY ("car_id")
      REFERENCES "car"("car_id")
);

CREATE TABLE "parts_log" (
  "parts_log_id" SERIAL,
  "part_id" INTEGER,
  "mechanic_id" INTEGER,
  "invoice_id" INTEGER,
  PRIMARY KEY ("parts_log_id"),
  CONSTRAINT "FK_parts_log.part_id"
    FOREIGN KEY ("part_id")
      REFERENCES "parts_inventory"("part_id"),
  CONSTRAINT "FK_parts_log.invoice_id"
    FOREIGN KEY ("invoice_id")
      REFERENCES "invoice"("invoice_id")
);

CREATE TABLE "service_log" (
  "service_log_id" SERIAL,
  "service_id" INTEGER,
  "mechanic_id" INTEGER,
  "invoice_id" INTEGER,
  PRIMARY KEY ("service_log_id"),
  CONSTRAINT "FK_service_log.invoice_id"
    FOREIGN KEY ("invoice_id")
      REFERENCES "invoice"("invoice_id")
);

SELECT *
FROM car;

CREATE OR REPLACE FUNCTION add_car (_car_id INTEGER, _serial_number INTEGER, _make VARCHAR(15), _model VARCHAR(15),
                                    _year INTEGER, _condition VARCHAR(5))
RETURNS void
AS $CAR$
BEGIN 
    INSERT INTO car VALUES(_car_id, _serial_number, _make, _model, _year, _condition);
END;
$CAR$
LANGUAGE plpgsql

SELECT add_car(1, 10, 'Jaguar', 'E_Type', 1960, 'Used');
SELECT add_car(2, 37, 'Chevy', 'Corvette', 1967, 'Used');
SELECT add_car(3, 709, 'Lamborghini', 'Miura', 1966, 'Used');

SELECT *
FROM customer;

CREATE OR REPLACE FUNCTION add_customer (_customer_id INTEGER, _first_name VARCHAR(45), _last_name VARCHAR(45), _email VARCHAR(45),
                                    _address_id INTEGER, _phone VARCHAR(20))
RETURNS void
AS $CUSTOMER$
BEGIN 
    INSERT INTO customer VALUES(_customer_id, _first_name, _last_name, _email, _address_id, _phone);
END;
$CUSTOMER$
LANGUAGE plpgsql;

SELECT *
FROM city;

INSERT INTO city VALUES(1, 'New York');
INSERT INTO city VALUES(2, 'Chicago');
INSERT INTO city VALUES(3, 'Los Angeles');

SELECT *
FROM address;

INSERT INTO address VALUES(1, 1, 10001, '17 Main Street');
INSERT INTO address VALUES(2, 1, 10034, '135 Bronx Ave');
INSERT INTO address VALUES(3, 2, 60007, '123 Have Not Been St');
INSERT INTO address VALUES(4, 3, 90210, '44 La Havana Blvd');

SELECT *
FROM customer;

SELECT add_customer(1, 'Jordy', 'Caceres', 'anything@gmail.com', 1, '212-123-4567');
SELECT add_customer(2, 'Coding', 'Temple', 'ct@gmail.com', 3, '1-800-5657');

INSERT INTO parts_inventory VALUES(1, 'carburator', 154.00);
INSERT INTO parts_inventory VALUES(2, 'battery', 100.00);
INSERT INTO parts_inventory VALUES(3, 'chassis', 4000.00);
INSERT INTO parts_inventory VALUES(4, 'engine', 9000.00);

SELECT*
FROM parts_inventory;

SELECT*
FROM service;

INSERT INTO service VALUES(1, 'oil change', 35.00);
INSERT INTO service VALUES(2, 'wheel alignment', 100.00);
INSERT INTO service VALUES(3, 'tire rotation', 25.00);
INSERT INTO service VALUES(4, 'brake repair', 300.00);

SELECT *
FROM invoice;

INSERT INTO staff VALUES(1, 'Terrell', 'McKinney', 'tmk@ct.com', '123');
INSERT INTO staff VALUES(2, 'Ryan', 'Rhoades', 'teamrocket@ct.com', '456');



INSERT INTO invoice VALUES(1, 999999.99, NOW()::date, 1, 1, 1);
INSERT INTO invoice VALUES(2, 299.37, NOW()::date, 1, 1, 1);

ALTER TABLE invoice DROP COLUMN ticket_id;

SELECT *
FROM parts_log;

INSERT INTO parts_log VALUES(1, 1, 1, 2);
INSERT INTO parts_log VALUES(2, 2, 1, 2);