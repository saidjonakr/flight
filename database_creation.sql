-- 1. Core reference tables

CREATE TABLE Airline (
    airline_id         SERIAL PRIMARY KEY,
    code               VARCHAR(5) NOT NULL UNIQUE,
    name               VARCHAR(100) NOT NULL,
    contact_phone      VARCHAR(30),
    contact_email      VARCHAR(100),
    country            VARCHAR(50)
);

CREATE TABLE Airport (
    airport_id         SERIAL PRIMARY KEY,
    code               VARCHAR(3) NOT NULL UNIQUE,
    name               VARCHAR(100) NOT NULL,
    city               VARCHAR(100) NOT NULL,
    country            VARCHAR(50) NOT NULL,
    time_zone          VARCHAR(50) NOT NULL
);

CREATE TABLE AircraftType (
    aircraft_type_id   SERIAL PRIMARY KEY,
    model              VARCHAR(50) NOT NULL,
    manufacturer       VARCHAR(50) NOT NULL,
    total_seat_capacity INT NOT NULL CHECK (total_seat_capacity > 0)
);

CREATE TABLE CabinClass (
    cabin_class_id     SERIAL PRIMARY KEY,
    code               VARCHAR(5) NOT NULL,
    name               VARCHAR(50) NOT NULL
    -- optional: UNIQUE(code)
);

-- 2. Flights & instances

CREATE TABLE Flight (
    flight_id              SERIAL PRIMARY KEY,
    airline_id             INT NOT NULL,
    flight_number          VARCHAR(10) NOT NULL,
    departure_airport_id   INT NOT NULL,
    arrival_airport_id     INT NOT NULL,
    sched_departure_time   TIME NOT NULL,
    sched_arrival_time     TIME NOT NULL,
    aircraft_type_id       INT NOT NULL,
    CONSTRAINT fk_flight_airline
        FOREIGN KEY (airline_id) REFERENCES Airline(airline_id),
    CONSTRAINT fk_flight_departure_airport
        FOREIGN KEY (departure_airport_id) REFERENCES Airport(airport_id),
    CONSTRAINT fk_flight_arrival_airport
        FOREIGN KEY (arrival_airport_id) REFERENCES Airport(airport_id),
    CONSTRAINT fk_flight_aircraft_type
        FOREIGN KEY (aircraft_type_id) REFERENCES AircraftType(aircraft_type_id)
    -- optional: UNIQUE(airline_id, flight_number)
);

CREATE TABLE FlightInstance (
    flight_instance_id         SERIAL PRIMARY KEY,
    flight_id                  INT NOT NULL,
    flight_date                DATE NOT NULL,
    status                     VARCHAR(20) NOT NULL CHECK (status IN
                                   ('scheduled', 'delayed', 'cancelled', 'departed', 'arrived')),
    actual_departure_datetime  TIMESTAMP,
    actual_arrival_datetime    TIMESTAMP,
    CONSTRAINT fk_flightinstance_flight
        FOREIGN KEY (flight_id) REFERENCES Flight(flight_id)
);

CREATE INDEX idx_flightinstance_flight_date
    ON FlightInstance (flight_id, flight_date);

CREATE TABLE FlightCabinFare (
    flight_cabin_fare_id   SERIAL PRIMARY KEY,
    flight_id              INT NOT NULL,
    cabin_class_id         INT NOT NULL,
    base_fare_amount       NUMERIC(10,2) NOT NULL CHECK (base_fare_amount >= 0),
    currency_code          VARCHAR(3) NOT NULL,
    fare_type              VARCHAR(20) NOT NULL CHECK (fare_type IN
                                   ('refundable', 'non_refundable', 'flexible')),
    CONSTRAINT fk_fcf_flight
        FOREIGN KEY (flight_id) REFERENCES Flight(flight_id),
    CONSTRAINT fk_fcf_cabin_class
        FOREIGN KEY (cabin_class_id) REFERENCES CabinClass(cabin_class_id),
    CONSTRAINT uq_fcf_flight_class
        UNIQUE (flight_id, cabin_class_id)
);

-- 3. Passengers & bookings

CREATE TABLE Passenger (
    passenger_id        SERIAL PRIMARY KEY,
    first_name          VARCHAR(50) NOT NULL,
    last_name           VARCHAR(50) NOT NULL,
    date_of_birth       DATE NOT NULL,
    email               VARCHAR(100),
    phone               VARCHAR(30),
    id_document_number  VARCHAR(50),
    id_document_type    VARCHAR(30),
    frequent_flyer_number   VARCHAR(50),
    frequent_flyer_program  VARCHAR(50)
);

CREATE TABLE Booking (
    booking_id          SERIAL PRIMARY KEY,
    booking_reference   VARCHAR(10) NOT NULL UNIQUE,
    creation_datetime   TIMESTAMP NOT NULL,
    status              VARCHAR(20) NOT NULL CHECK (status IN
                                   ('booked', 'ticketed', 'cancelled')),
    total_amount        NUMERIC(10,2) NOT NULL CHECK (total_amount >= 0),
    currency_code       VARCHAR(3) NOT NULL,
    contact_email       VARCHAR(100),
    contact_phone       VARCHAR(30)
);

CREATE INDEX idx_booking_status ON Booking(status);

CREATE TABLE BookingPassenger (
    booking_passenger_id    SERIAL PRIMARY KEY,
    booking_id              INT NOT NULL,
    passenger_id            INT NOT NULL,
    passenger_role          VARCHAR(20),
    CONSTRAINT fk_bp_booking
        FOREIGN KEY (booking_id) REFERENCES Booking(booking_id),
    CONSTRAINT fk_bp_passenger
        FOREIGN KEY (passenger_id) REFERENCES Passenger(passenger_id),
    CONSTRAINT uq_bp_booking_passenger
        UNIQUE (booking_id, passenger_id)
);

CREATE TABLE BookingSegment (
    booking_segment_id      SERIAL PRIMARY KEY,
    booking_id              INT NOT NULL,
    flight_instance_id      INT NOT NULL,
    cabin_class_id          INT NOT NULL,
    segment_order           INT NOT NULL,
    CONSTRAINT fk_bs_booking
        FOREIGN KEY (booking_id) REFERENCES Booking(booking_id),
    CONSTRAINT fk_bs_flight_instance
        FOREIGN KEY (flight_instance_id) REFERENCES FlightInstance(flight_instance_id),
    CONSTRAINT fk_bs_cabin_class
        FOREIGN KEY (cabin_class_id) REFERENCES CabinClass(cabin_class_id),
    CONSTRAINT uq_bs_booking_order
        UNIQUE (booking_id, segment_order)
);

-- 4. Tickets

CREATE TABLE Ticket (
    ticket_id               SERIAL PRIMARY KEY,
    ticket_number           VARCHAR(20) NOT NULL UNIQUE,
    booking_id              INT NOT NULL,
    booking_passenger_id    INT NOT NULL,
    booking_segment_id      INT NOT NULL,
    issue_datetime          TIMESTAMP NOT NULL,
    fare_amount             NUMERIC(10,2) NOT NULL CHECK (fare_amount >= 0),
    currency_code           VARCHAR(3) NOT NULL,
    status                  VARCHAR(20) NOT NULL CHECK (status IN
                                   ('valid', 'used', 'refunded', 'void')),
    CONSTRAINT fk_ticket_booking
        FOREIGN KEY (booking_id) REFERENCES Booking(booking_id),
    CONSTRAINT fk_ticket_booking_passenger
        FOREIGN KEY (booking_passenger_id) REFERENCES BookingPassenger(booking_passenger_id),
    CONSTRAINT fk_ticket_booking_segment
        FOREIGN KEY (booking_segment_id) REFERENCES BookingSegment(booking_segment_id)
);

-- 5. Seats & seat assignments

CREATE TABLE Seat (
    seat_id             SERIAL PRIMARY KEY,
    aircraft_type_id    INT NOT NULL,
    seat_number         VARCHAR(5) NOT NULL,
    cabin_class_id      INT NOT NULL,
    CONSTRAINT fk_seat_aircraft_type
        FOREIGN KEY (aircraft_type_id) REFERENCES AircraftType(aircraft_type_id),
    CONSTRAINT fk_seat_cabin_class
        FOREIGN KEY (cabin_class_id) REFERENCES CabinClass(cabin_class_id),
    CONSTRAINT uq_seat_aircraft_number
        UNIQUE (aircraft_type_id, seat_number)
);

CREATE TABLE SeatAssignment (
    seat_assignment_id      SERIAL PRIMARY KEY,
    flight_instance_id      INT NOT NULL,
    seat_id                 INT NOT NULL,
    booking_passenger_id    INT NOT NULL,
    booking_segment_id      INT NOT NULL,
    CONSTRAINT fk_sa_flight_instance
        FOREIGN KEY (flight_instance_id) REFERENCES FlightInstance(flight_instance_id),
    CONSTRAINT fk_sa_seat
        FOREIGN KEY (seat_id) REFERENCES Seat(seat_id),
    CONSTRAINT fk_sa_booking_passenger
        FOREIGN KEY (booking_passenger_id) REFERENCES BookingPassenger(booking_passenger_id),
    CONSTRAINT fk_sa_booking_segment
        FOREIGN KEY (booking_segment_id) REFERENCES BookingSegment(booking_segment_id),
    CONSTRAINT uq_sa_flight_seat
        UNIQUE (flight_instance_id, seat_id)
);

-- 6. Payments

CREATE TABLE Payment (
    payment_id          SERIAL PRIMARY KEY,
    booking_id          INT NOT NULL,
    amount              NUMERIC(10,2) NOT NULL CHECK (amount >= 0),
    currency_code       VARCHAR(3) NOT NULL,
    payment_method      VARCHAR(20) NOT NULL CHECK (payment_method IN
                                   ('card', 'cash', 'wallet')),
    payment_datetime    TIMESTAMP NOT NULL,
    status              VARCHAR(20) NOT NULL CHECK (status IN
                                   ('successful', 'failed', 'refunded')),
    CONSTRAINT fk_payment_booking
        FOREIGN KEY (booking_id) REFERENCES Booking(booking_id)
);

CREATE INDEX idx_payment_booking ON Payment(booking_id);
