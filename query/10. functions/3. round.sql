-- The ROUND() function accepts two arguments.
-- 		value: The value is the floating-point value or an expression that 
-- evaluates to a floating-point value.
-- 		precision: The precision is a positive integer. The value is rounded 
-- to its closest representation, not towards zero.
-- If either value or precision is NULL, the ROUND() function returns NULL. 
-- If you omit the precision argument, it is assumed to be zero. This will 
-- result in a whole number although the result is still a floating-point value.
-- Return Type is Real Number


-- The following statement uses the ROUND() function to round a floating-point 
-- value to 2 decimals:
SELECT ROUND(1929.236, 2);

-- The following statement rounds the number 1929.236 to a value with 1 decimal point.
SELECT ROUND(1929.236, 1);

-- The following statement uses the ROUND() function without specifying the 
-- precision argument.
SELECT ROUND(1929.236);

-- This example uses the ROUND() function to round the number 0.5:
SELECT ROUND(0.5);


-- SQLITE VERSION
SELECT sqlite_version();