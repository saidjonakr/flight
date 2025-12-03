-- ============================
-- AIRLINE
-- ============================
INSERT INTO Airline (airline_id, code, name, contact_phone, contact_email, country) VALUES
(1, 'UZB', 'UZB Air',        '+998-71-100-0001', 'info@uzbair.uz',        'Uzbekistan'),
(2, 'SRG', 'SilkRegional',   '+998-66-200-0002', 'support@silkregional.uz','Uzbekistan'),
(3, 'STW', 'SteppeWings',    '+971-4-300-0003',  'contact@steppewings.ae','UAE');

-- ============================
-- AIRPORT
-- ============================
INSERT INTO Airport (airport_id, code, name, city, country, time_zone) VALUES
(1,  'TAS', 'Tashkent International Airport', 'Tashkent',  'Uzbekistan', 'Asia/Tashkent'),
(2,  'SKD', 'Samarkand International Airport','Samarkand', 'Uzbekistan', 'Asia/Tashkent'),
(3,  'BHK', 'Bukhara International Airport',  'Bukhara',   'Uzbekistan', 'Asia/Tashkent'),
(4,  'NMA', 'Namangan Airport',               'Namangan',  'Uzbekistan', 'Asia/Tashkent'),
(5,  'FEG', 'Fergana International Airport',  'Fergana',   'Uzbekistan', 'Asia/Tashkent'),
(6,  'UGC', 'Urgench International Airport',  'Urgench',   'Uzbekistan', 'Asia/Tashkent'),
(7,  'ALA', 'Almaty International Airport',   'Almaty',    'Kazakhstan', 'Asia/Almaty'),
(8,  'NQZ', 'Astana Nursultan Nazarbayev',    'Astana',    'Kazakhstan', 'Asia/Almaty'),
(9,  'DXB', 'Dubai International Airport',    'Dubai',     'UAE',        'Asia/Dubai'),
(10, 'IST', 'Istanbul Airport',               'Istanbul',  'Turkey',     'Europe/Istanbul');

-- ============================
-- AIRCRAFT TYPE
-- ============================
INSERT INTO AircraftType (aircraft_type_id, model, manufacturer, total_seat_capacity) VALUES
(1, 'A320-200', 'Airbus', 20),   -- 5 rows x 4 seats
(2, 'B737-800', 'Boeing', 24),   -- 6 rows x 4 seats
(3, 'E190',     'Embraer',16);   -- 4 rows x 4 seats

-- ============================
-- CABIN CLASS
-- ============================
INSERT INTO CabinClass (cabin_class_id, code, name) VALUES
(1, 'Y', 'Economy'),
(2, 'J', 'Business');

-- ============================
-- FLIGHT (ROUTES)
-- ============================
INSERT INTO Flight (
    flight_id, airline_id, flight_number,
    departure_airport_id, arrival_airport_id,
    sched_departure_time, sched_arrival_time,
    aircraft_type_id
) VALUES
(1, 1, 'UZB101', 1, 2, '08:30', '09:20', 1),  -- TAS -> SKD
(2, 1, 'UZB202', 1, 3, '10:00', '11:00', 1),  -- TAS -> BHK
(3, 1, 'UZB303', 1, 7, '14:00', '15:30', 2),  -- TAS -> ALA
(4, 2, 'SRG410', 2, 3, '09:00', '09:40', 3),  -- SKD -> BHK
(5, 2, 'SRG511', 2, 8, '16:00', '18:30', 2),  -- SKD -> NQZ
(6, 2, 'SRG612', 3, 1, '19:00', '19:50', 1),  -- BHK -> TAS
(7, 3, 'STW701', 1, 9, '22:00', '01:30', 2),  -- TAS -> DXB
(8, 3, 'STW802', 9, 10,'03:00', '06:30', 2);  -- DXB -> IST

-- ============================
-- FLIGHT INSTANCES (DATES)
-- ============================
INSERT INTO FlightInstance (
    flight_instance_id, flight_id, flight_date, status,
    actual_departure_datetime, actual_arrival_datetime
) VALUES
-- Flight 1 UZB101 TAS-SKD
(1, 1, '2025-10-01', 'departed', '2025-10-01 08:35', '2025-10-01 09:25'),
(2, 1, '2025-10-02', 'arrived',  '2025-10-02 08:30', '2025-10-02 09:18'),
(3, 1, '2025-10-03', 'scheduled',NULL,                NULL),

-- Flight 2 UZB202 TAS-BHK
(4, 2, '2025-10-01', 'arrived',  '2025-10-01 10:02', '2025-10-01 10:59'),
(5, 2, '2025-10-02', 'cancelled',NULL,                NULL),
(6, 2, '2025-10-03', 'scheduled',NULL,                NULL),

-- Flight 3 UZB303 TAS-ALA
(7, 3, '2025-10-01', 'departed', '2025-10-01 14:05', '2025-10-01 15:32'),
(8, 3, '2025-10-02', 'arrived',  '2025-10-02 13:58', '2025-10-02 15:25'),
(9, 3, '2025-10-03', 'scheduled',NULL,                NULL),

-- Flight 4 SRG410 SKD-BHK
(10, 4, '2025-10-01', 'arrived',  '2025-10-01 09:02', '2025-10-01 09:35'),
(11, 4, '2025-10-02', 'scheduled',NULL,               NULL),
(12, 4, '2025-10-03', 'scheduled',NULL,               NULL),

-- Flight 5 SRG511 SKD-NQZ
(13, 5, '2025-10-01', 'scheduled',NULL,               NULL),
(14, 5, '2025-10-02', 'scheduled',NULL,               NULL),
(15, 5, '2025-10-03', 'scheduled',NULL,               NULL),

-- Flight 6 SRG612 BHK-TAS
(16, 6, '2025-10-01', 'scheduled',NULL,               NULL),
(17, 6, '2025-10-02', 'scheduled',NULL,               NULL),
(18, 6, '2025-10-03', 'scheduled',NULL,               NULL),

-- Flight 7 STW701 TAS-DXB
(19, 7, '2025-10-01', 'scheduled',NULL,               NULL),
(20, 7, '2025-10-02', 'scheduled',NULL,               NULL),
(21, 7, '2025-10-03', 'scheduled',NULL,               NULL),

-- Flight 8 STW802 DXB-IST
(22, 8, '2025-10-02', 'scheduled',NULL,               NULL),
(23, 8, '2025-10-03', 'scheduled',NULL,               NULL),
(24, 8, '2025-10-04', 'scheduled',NULL,               NULL);

-- ============================
-- FLIGHT CABIN FARES
-- ============================
INSERT INTO FlightCabinFare (
    flight_cabin_fare_id, flight_id, cabin_class_id,
    base_fare_amount, currency_code, fare_type
) VALUES
-- Flight 1 UZB101
(1, 1, 1,  80.00, 'USD', 'non_refundable'),
(2, 1, 2, 160.00, 'USD', 'flexible'),
-- Flight 2 UZB202
(3, 2, 1,  90.00, 'USD', 'non_refundable'),
(4, 2, 2, 170.00, 'USD', 'flexible'),
-- Flight 3 UZB303
(5, 3, 1, 130.00, 'USD', 'non_refundable'),
(6, 3, 2, 260.00, 'USD', 'refundable'),
-- Flight 4 SRG410
(7, 4, 1,  70.00, 'USD', 'non_refundable'),
(8, 4, 2, 150.00, 'USD', 'refundable'),
-- Flight 5 SRG511
(9, 5, 1, 140.00, 'USD', 'non_refundable'),
(10,5, 2, 280.00, 'USD', 'refundable'),
-- Flight 6 SRG612
(11,6, 1,  85.00, 'USD', 'non_refundable'),
(12,6, 2, 165.00, 'USD', 'flexible'),
-- Flight 7 STW701
(13,7, 1, 250.00, 'USD', 'non_refundable'),
(14,7, 2, 480.00, 'USD', 'refundable'),
-- Flight 8 STW802
(15,8, 1, 220.00, 'USD', 'non_refundable'),
(16,8, 2, 450.00, 'USD', 'refundable');

-- ============================
-- PASSENGERS
-- ============================
INSERT INTO Passenger (
    passenger_id, first_name, last_name, date_of_birth,
    email, phone, id_document_number, id_document_type,
    frequent_flyer_number, frequent_flyer_program
) VALUES
(1,  'Ali',      'Karimov',   '1990-01-15', 'ali.karimov@example.com',   '+998-90-111-1111', 'AA1234567', 'Passport', 'UZB001', 'UZB Air Plus'),
(2,  'Laylo',    'Rasulova',  '1995-03-22', 'laylo.rasulova@example.com','+998-91-222-2222', 'BB2345678', 'Passport', NULL,     NULL),
(3,  'Javlon',   'Saidov',    '1988-07-09', 'javlon.saidov@example.com', '+998-93-333-3333', 'CC3456789', 'Passport', 'SRG777', 'SilkRegional Club'),
(4,  'Aziza',    'Nurmatova', '2000-11-30', 'aziza.nur@example.com',     '+998-94-444-4444', 'DD4567890', 'ID Card',  NULL,     NULL),
(5,  'Timur',    'Yuldashev', '1985-05-05', 'timur.y@example.com',       '+998-90-555-5555', 'EE5678901', 'Passport', NULL,     NULL),
(6,  'Madina',   'Olimova',   '1992-02-14', 'madina.o@example.com',      '+998-97-666-6666', 'FF6789012', 'Passport', 'STW999','SteppeWings Miles'),
(7,  'Sardor',   'Abdullaev', '1998-09-18', 'sardor.a@example.com',      '+998-95-777-7777', 'GG7890123', 'ID Card',  NULL,     NULL),
(8,  'Nigora',   'Ismailova', '1991-06-11', 'nigora.i@example.com',      '+998-99-888-8888', 'HH8901234', 'Passport', NULL,     NULL),
(9,  'Bobur',    'Ergashev',  '1983-12-03', 'bobur.e@example.com',       '+998-90-999-9999', 'II9012345', 'Passport', NULL,     NULL),
(10, 'Dilshod',  'Aliyev',    '1996-04-27', 'dilshod.a@example.com',     '+998-93-101-0101', 'JJ0123456', 'Passport', NULL,     NULL),
(11, 'Zuhra',    'Mintova',   '2002-08-08', 'zuhra.m@example.com',       '+998-91-202-0202', 'KK1234500', 'ID Card',  NULL,     NULL),
(12, 'Michael',  'Smith',     '1989-10-21', 'michael.s@example.com',     '+44-20-7000-1234','PA9876543', 'Passport', NULL,     NULL);

-- ============================
-- BOOKINGS
-- ============================
INSERT INTO Booking (
    booking_id, booking_reference, creation_datetime,
    status, total_amount, currency_code,
    contact_email, contact_phone
) VALUES
(1, 'AB12CD', '2025-09-20 10:15', 'ticketed', 160.00, 'USD', 'ali.karimov@example.com',   '+998-90-111-1111'),
(2, 'EF34GH', '2025-09-20 11:00', 'ticketed', 320.00, 'USD', 'laylo.rasulova@example.com','+998-91-222-2222'),
(3, 'IJ56KL', '2025-09-21 09:45', 'booked',   230.00, 'USD', 'javlon.saidov@example.com', '+998-93-333-3333'),
(4, 'MN78OP', '2025-09-21 15:20', 'ticketed', 260.00, 'USD', 'aziza.nur@example.com',     '+998-94-444-4444'),
(5, 'QR90ST', '2025-09-22 08:10', 'ticketed', 520.00, 'USD', 'timur.y@example.com',       '+998-90-555-5555'),
(6, 'UV12WX', '2025-09-22 09:00', 'ticketed', 730.00, 'USD', 'madina.o@example.com',      '+998-97-666-6666'),
(7, 'YZ34AA', '2025-09-23 13:35', 'booked',   140.00, 'USD', 'sardor.a@example.com',      '+998-95-777-7777'),
(8, 'BB56CC', '2025-09-24 16:00', 'ticketed', 900.00, 'USD', 'michael.s@example.com',     '+44-20-7000-1234');

-- ============================
-- BOOKING PASSENGERS
-- ============================
INSERT INTO BookingPassenger (
    booking_passenger_id, booking_id, passenger_id, passenger_role
) VALUES
-- Booking 1: single passenger Ali
(1, 1, 1, 'primary'),
-- Booking 2: Laylo + Aziza
(2, 2, 2, 'primary'),
(3, 2, 4, 'secondary'),
-- Booking 3: Javlon only (still booked)
(4, 3, 3, 'primary'),
-- Booking 4: Aziza + Timur (round trip)
(5, 4, 4, 'primary'),
(6, 4, 5, 'secondary'),
-- Booking 5: family of 3 (Timur, Madina, Sardor)
(7, 5, 5, 'primary'),
(8, 5, 6, 'secondary'),
(9, 5, 7, 'child'),
-- Booking 6: group of 4 (Madina, Nigora, Bobur, Dilshod)
(10,6, 6, 'primary'),
(11,6, 8, 'secondary'),
(12,6, 9, 'secondary'),
(13,6,10, 'secondary'),
-- Booking 7: Sardor only
(14,7, 7, 'primary'),
-- Booking 8: long-haul Michael + Zuhra
(15,8,12, 'primary'),
(16,8,11, 'secondary');

-- ============================
-- BOOKING SEGMENTS
-- ============================
INSERT INTO BookingSegment (
    booking_segment_id, booking_id, flight_instance_id,
    cabin_class_id, segment_order
) VALUES
-- Booking 1: Ali, TAS -> SKD (FlightInstance 2)
(1, 1, 2, 1, 1),

-- Booking 2: Laylo & Aziza, TAS -> BHK (FlightInstance 4)
(2, 2, 4, 1, 1),

-- Booking 3: Javlon, TAS -> ALA (FlightInstance 7)
(3, 3, 7, 2, 1),

-- Booking 4: Aziza & Timur, SKD -> BHK then BHK -> TAS (roundtrip)
(4, 4, 10, 1, 1),  -- SKD -> BHK
(5, 4, 16, 1, 2),  -- BHK -> TAS

-- Booking 5: family, TAS -> BHK (FI 6) then BHK -> TAS (FI 17)
(6, 5, 6, 1, 1),
(7, 5, 17,1, 2),

-- Booking 6: group, TAS -> DXB (FI 19)
(8, 6, 19,1, 1),

-- Booking 7: Sardor, SKD -> NQZ (FI 13)
(9, 7, 13,1, 1),

-- Booking 8: Michael & Zuhra, TAS -> DXB (FI 20) then DXB -> IST (FI 22)
(10,8, 20,2, 1),
(11,8, 22,2, 2);

-- ============================
-- TICKETS
-- ============================
INSERT INTO Ticket (
    ticket_id, ticket_number, booking_id,
    booking_passenger_id, booking_segment_id,
    issue_datetime, fare_amount, currency_code, status
) VALUES
-- Booking 1: Ali, 1 segment
(1, '781000000001', 1, 1, 1, '2025-09-20 10:20', 160.00, 'USD', 'used'),

-- Booking 2: Laylo & Aziza, same segment 2
(2, '781000000002', 2, 2, 2, '2025-09-20 11:05', 160.00, 'USD', 'used'),
(3, '781000000003', 2, 3, 2, '2025-09-20 11:05', 160.00, 'USD', 'used'),

-- Booking 3: Javlon, not ticketed yet? status booked, so no ticket or mark as valid
(4, '781000000004', 3, 4, 3, '2025-09-21 10:00', 230.00, 'USD', 'valid'),

-- Booking 4: Aziza & Timur, 2 segments, 4 pax tickets
(5, '781000000005', 4, 5, 4, '2025-09-21 15:30', 130.00, 'USD', 'valid'),
(6, '781000000006', 4, 5, 5, '2025-09-21 15:30', 130.00, 'USD', 'valid'),
(7, '781000000007', 4, 6, 4, '2025-09-21 15:30', 130.00, 'USD', 'valid'),
(8, '781000000008', 4, 6, 5, '2025-09-21 15:30', 130.00, 'USD', 'valid'),

-- Booking 5: family of 3, 2 segments
(9,  '781000000009', 5, 7, 6, '2025-09-22 08:20', 130.00, 'USD', 'valid'),
(10, '781000000010', 5, 7, 7, '2025-09-22 08:20', 130.00, 'USD', 'valid'),
(11, '781000000011', 5, 8, 6, '2025-09-22 08:20', 130.00, 'USD', 'valid'),
(12, '781000000012', 5, 8, 7, '2025-09-22 08:20', 130.00, 'USD', 'valid'),
(13, '781000000013', 5, 9, 6, '2025-09-22 08:20', 130.00, 'USD', 'valid'),
(14, '781000000014', 5, 9, 7, '2025-09-22 08:20', 130.00, 'USD', 'valid'),

-- Booking 6: group of 4, 1 segment
(15, '781000000015', 6, 10, 8, '2025-09-22 09:10', 180.00, 'USD', 'valid'),
(16, '781000000016', 6, 11, 8, '2025-09-22 09:10', 180.00, 'USD', 'valid'),
(17, '781000000017', 6, 12, 8, '2025-09-22 09:10', 180.00, 'USD', 'valid'),
(18, '781000000018', 6, 13, 8, '2025-09-22 09:10', 180.00, 'USD', 'valid'),

-- Booking 7: Sardor, 1 segment
(19, '781000000019', 7, 14, 9, '2025-09-23 13:40', 140.00, 'USD', 'valid'),

-- Booking 8: Michael & Zuhra, 2 segments each
(20, '781000000020', 8, 15, 10, '2025-09-24 16:10', 450.00, 'USD', 'valid'),
(21, '781000000021', 8, 15, 11, '2025-09-24 16:10', 450.00, 'USD', 'valid'),
(22, '781000000022', 8, 16, 10, '2025-09-24 16:10', 450.00, 'USD', 'valid'),
(23, '781000000023', 8, 16, 11, '2025-09-24 16:10', 450.00, 'USD', 'valid');

-- ============================
-- SEATS (LAYOUT PER AIRCRAFT TYPE)
-- A320-200: aircraft_type_id = 1, rows 1-5, seats A-D (20 seats)
-- ============================
INSERT INTO Seat (seat_id, aircraft_type_id, seat_number, cabin_class_id) VALUES
-- A320-200, rows 1-2 Business (J), 3-5 Economy (Y)
(1, 1, '1A', 2), (2, 1, '1B', 2), (3, 1, '1C', 2), (4, 1, '1D', 2),
(5, 1, '2A', 2), (6, 1, '2B', 2), (7, 1, '2C', 2), (8, 1, '2D', 2),
(9, 1, '3A', 1), (10,1, '3B', 1), (11,1, '3C', 1), (12,1, '3D', 1),
(13,1, '4A', 1), (14,1, '4B', 1), (15,1, '4C', 1), (16,1, '4D', 1),
(17,1, '5A', 1), (18,1, '5B', 1), (19,1, '5C', 1), (20,1, '5D', 1);

-- B737-800: aircraft_type_id = 2, rows 1-6, seats A-D (24 seats)
INSERT INTO Seat (seat_id, aircraft_type_id, seat_number, cabin_class_id) VALUES
(21, 2, '1A', 2), (22, 2, '1B', 2), (23, 2, '1C', 2), (24, 2, '1D', 2),
(25, 2, '2A', 2), (26, 2, '2B', 2), (27, 2, '2C', 2), (28, 2, '2D', 2),
(29, 2, '3A', 1), (30, 2, '3B', 1), (31, 2, '3C', 1), (32, 2, '3D', 1),
(33, 2, '4A', 1), (34, 2, '4B', 1), (35, 2, '4C', 1), (36, 2, '4D', 1),
(37, 2, '5A', 1), (38, 2, '5B', 1), (39, 2, '5C', 1), (40, 2, '5D', 1),
(41, 2, '6A', 1), (42, 2, '6B', 1), (43, 2, '6C', 1), (44, 2, '6D', 1);

-- E190: aircraft_type_id = 3, rows 1-4, seats A-D (16 seats)
INSERT INTO Seat (seat_id, aircraft_type_id, seat_number, cabin_class_id) VALUES
(45, 3, '1A', 2), (46, 3, '1B', 2), (47, 3, '1C', 2), (48, 3, '1D', 2),
(49, 3, '2A', 1), (50, 3, '2B', 1), (51, 3, '2C', 1), (52, 3, '2D', 1),
(53, 3, '3A', 1), (54, 3, '3B', 1), (55, 3, '3C', 1), (56, 3, '3D', 1),
(57, 3, '4A', 1), (58, 3, '4B', 1), (59, 3, '4C', 1), (60, 3, '4D', 1);

-- ============================
-- SEAT ASSIGNMENTS
-- (Make sure each (flight_instance_id, seat_id) is unique)
-- ============================
INSERT INTO SeatAssignment (
    seat_assignment_id, flight_instance_id, seat_id,
    booking_passenger_id, booking_segment_id
) VALUES
-- FlightInstance 2 (UZB101, TAS->SKD) for Booking 1 (Ali)
(1, 2, 9,  1, 1),   -- 3A

-- FlightInstance 4 (UZB202, TAS->BHK) for Booking 2 (Laylo & Aziza)
(2, 4, 10, 2, 2),   -- 3B Laylo
(3, 4, 11, 3, 2),   -- 3C Aziza

-- FlightInstance 7 (UZB303, TAS->ALA) for Booking 3 (Javlon, business)
(4, 7, 21, 4, 3),   -- 1A (business on B737)

-- FlightInstance 10 (SRG410 SKD->BHK) Booking 4 (Aziza & Timur)
(5, 10, 53, 5, 4),  -- 3A
(6, 10, 54, 6, 4),  -- 3B

-- FlightInstance 16 (SRG612 BHK->TAS) Booking 4 (Aziza & Timur, segment 5)
(7, 16, 13, 5, 5),  -- 4A
(8, 16, 14, 6, 5),  -- 4B

-- FlightInstance 6 (UZB202 TAS->BHK) Booking 5 family segment 6
(9,  6, 15, 7, 6),  -- 4C Timur
(10, 6, 16, 8, 6),  -- 4D Madina
(11, 6, 17, 9, 6),  -- 5A Sardor

-- FlightInstance 17 (SRG612 BHK->TAS) Booking 5 family segment 7
(12, 17, 18, 7, 7), -- 5B
(13, 17, 19, 8, 7), -- 5C
(14, 17, 20, 9, 7), -- 5D

-- FlightInstance 19 (STW701 TAS->DXB) Booking 6 group segment 8
(15, 19, 29, 10, 8), -- 3A
(16, 19, 30, 11, 8), -- 3B
(17, 19, 31, 12, 8), -- 3C
(18, 19, 32, 13, 8), -- 3D

-- FlightInstance 13 (SRG511 SKD->NQZ) Booking 7 segment 9
(19, 13, 33, 14, 9), -- 4A

-- FlightInstance 20 (STW701 TAS->DXB) Booking 8 segment 10 (Business)
(20, 20, 22, 15, 10), -- 1B Michael
(21, 20, 23, 16, 10), -- 1C Zuhra

-- FlightInstance 22 (STW802 DXB->IST) Booking 8 segment 11 (Business)
(22, 22, 24, 15, 11), -- 1D Michael
(23, 22, 25, 16, 11); -- 2A Zuhra

-- ============================
-- PAYMENTS
-- ============================
INSERT INTO Payment (
    payment_id, booking_id, amount, currency_code,
    payment_method, payment_datetime, status
) VALUES
-- Booking 1: one successful card payment
(1, 1, 160.00, 'USD', 'card',  '2025-09-20 10:16', 'successful'),

-- Booking 2: first card failed, then wallet successful
(2, 2, 320.00, 'USD', 'card',  '2025-09-20 11:01', 'failed'),
(3, 2, 320.00, 'USD', 'wallet','2025-09-20 11:03', 'successful'),

-- Booking 3: only authorization (card) still pending/booked
(4, 3, 230.00, 'USD', 'card',  '2025-09-21 09:46', 'successful'),

-- Booking 4: cash payment at airport
(5, 4, 260.00, 'USD', 'cash',  '2025-09-21 15:22', 'successful'),

-- Booking 5: partial then full
(6, 5, 200.00, 'USD', 'card',  '2025-09-22 08:11', 'successful'),
(7, 5, 320.00, 'USD', 'card',  '2025-09-22 08:12', 'successful'),

-- Booking 6: one large card payment
(8, 6, 730.00, 'USD', 'card',  '2025-09-22 09:01', 'successful'),

-- Booking 7: unpaid / failed
(9, 7, 140.00, 'USD', 'card',  '2025-09-23 13:36', 'failed'),

-- Booking 8: payment later refunded (e.g., disruption)
(10,8, 900.00, 'USD', 'card',  '2025-09-24 16:02', 'successful'),
(11,8, 900.00, 'USD', 'card',  '2025-09-25 10:00', 'refunded');
