-- The following statement uses the abs() function to calculate the 
-- absolute value of -1000:
SELECT abs(-1000) result;

-- The following example illustrates how to calculate the value of 
-- a string that can be converted into a number:
SELECT abs('2000') result;

-- The following example illustrates how to calculate the value of 
-- a string that can be converted into a number:
SELECT abs('3000abs') result;

-- However, the following statement returns 0 because the function 
-- cannot convert the string into a number.
SELECT abs('sqlite4000')result;

-- The following example illustrates how to use an expression with 
-- the abs() function.
SELECT abs(10-200) result;

-- If you execute the following statement, you will get an error message:
SELECT abs(-9223372036854775808); -- ERROR: integer overflow
