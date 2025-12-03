-- List all flights between two airports on a given date
SELECT fl.flight_number, fi.flight_date
FROM FlightInstance fi
JOIN Flight fl ON fi.flight_id = fl.flight_id
WHERE fl.departure_airport_id = 1   -- TAS
  AND fl.arrival_airport_id = 2     -- SKD
  AND fi.flight_date = '2025-10-02';


-- Show all passengers booked on a specific flight instance
SELECT p.first_name, p.last_name
FROM BookingSegment bs
JOIN BookingPassenger bp ON bs.booking_id = bp.booking_id
JOIN Passenger p ON bp.passenger_id = p.passenger_id
WHERE bs.flight_instance_id = 4;


-- Count total passengers on a given flight instance
SELECT COUNT(*) AS passenger_count
FROM BookingSegment bs
JOIN BookingPassenger bp ON bs.booking_id = bp.booking_id
WHERE bs.flight_instance_id = 4;


-- Show a passenger’s full booking list
SELECT b.booking_reference, b.status, b.creation_datetime
FROM Booking b
JOIN BookingPassenger bp ON b.booking_id = bp.booking_id
WHERE bp.passenger_id = 1;


-- Show seat assignments for a specific flight instance
SELECT s.seat_number, p.first_name, p.last_name
FROM SeatAssignment sa
JOIN Seat s ON sa.seat_id = s.seat_id
JOIN BookingPassenger bp ON sa.booking_passenger_id = bp.booking_passenger_id
JOIN Passenger p ON bp.passenger_id = p.passenger_id
WHERE sa.flight_instance_id = 2
ORDER BY s.seat_number;


-- Show bookings that are not fully paid
SELECT b.booking_id, b.booking_reference
FROM Booking b
LEFT JOIN Payment p ON b.booking_id = p.booking_id
GROUP BY b.booking_id, b.booking_reference, b.total_amount
HAVING COALESCE(SUM(CASE WHEN p.status='successful' THEN p.amount END), 0) < b.total_amount;


-- Show cancelled flights
SELECT fi.flight_instance_id, fl.flight_number, fi.flight_date
FROM FlightInstance fi
JOIN Flight fl ON fi.flight_id = fl.flight_id
WHERE fi.status = 'cancelled';


-- Find all bookings for a specific passenger by name
SELECT b.booking_reference, b.status
FROM Passenger p
JOIN BookingPassenger bp ON p.passenger_id = bp.passenger_id
JOIN Booking b ON bp.booking_id = b.booking_id
WHERE p.first_name = 'Ali' AND p.last_name = 'Karimov';


-- Count total flights an airline operates
SELECT a.name, COUNT(f.flight_id) AS total_routes
FROM Airline a
JOIN Flight f ON a.airline_id = f.airline_id
GROUP BY a.name;


-- List payments for a given booking
SELECT payment_method, amount, status, payment_datetime
FROM Payment
WHERE booking_id = 1;

