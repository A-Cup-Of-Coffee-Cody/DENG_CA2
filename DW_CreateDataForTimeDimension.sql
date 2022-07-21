USE [BikeSalesDWGroup4];

DELETE FROM timeDim;

DECLARE @StartDate DATETIME = '20160101'
--Starting value of Date Range
DECLARE @EndDate DATETIME = '20180403' -- Lastest Date in Orders.csv
--End Value of Date Range

DECLARE @curDate DATE
DECLARE @FirstDayMonth DATE
DECLARE @QtrMonthNo int
DECLARE @FirstDayQtr DATE

SET @curdate = @StartDate
while @curDate < @EndDate 
  Begin

  SET @FirstDayMonth = DateFromParts(Year(@curDate), Month(@curDate), '01')
  SET @QtrMonthNo = ((DatePart(Quarter, @CurDate) - 1) * 3) + 1
  Set @FirstDayQtr = DateFromParts(Year(@curDate), @QtrMonthNo, '01')

  INSERT INTO [timeDim]
  select
    CONVERT (char(8),@curDate,112) as time_id,
    @CurDate AS [Date],
    CONVERT (char(10), @CurDate,101) as FullDateUSA,
    DATEPART(Day, @curDate) AS DayOfMonth,

    --Apply Suffix values like 1st, 2nd 3rd etc..
    CASE 
		WHEN DATEPART(Day,@curDate) IN (11,12,13) 
		  THEN CAST(DATEPART(Day,@curDate) AS VARCHAR) + 'th'
		WHEN RIGHT(DATEPART(Day,@curDate),1) = 1 
		  THEN CAST(DATEPART(Day,@curDate) AS VARCHAR) + 'st'
		WHEN RIGHT(DATEPART(Day,@curDate),1) = 2 
		  THEN CAST(DATEPART(Day,@curDate) AS VARCHAR) + 'nd'
		WHEN RIGHT(DATEPART(Day,@curDate),1) = 3 
		  THEN CAST(DATEPART(Day,@curDate) AS VARCHAR) + 'rd'
		ELSE CAST(DATEPART(Day,@curDate) AS VARCHAR) + 'th' 
	  END AS DaySuffix,

    DATENAME(WeekDay, @curDate) AS DayName,
    DATEPART(weekDay, @curDate) AS DayOfWeekUSA,

    -- Calcuate the Week Number with a Month
    DatePart(DayOfYear, @curDate) AS DayOfYear,
    (DatePart(Week, @curDate) - DatePart(Week, @FirstDayMonth)) + 1 
	       as WeekOfMonth,
    (DatePart(Week, @curDate) - DatePart(Week, @FirstDayQtr)) + 1 
	       as WeekOfQuarter,
    DatePart(Week, @curDate) as WeekOfYear,
    DatePart(Month, @curDate) AS Month,
    Datename(Month, @curDate) AS MonthName,
    ((DatePart(Month, @curDate) - 1) % 3) + 1 As MonthOfQuarter,
    DatePart(Quarter, @curDate) as Quarter,
    CASE DatePart(Quarter, @curDate)
			WHEN 1 THEN 'First'
			WHEN 2 THEN 'Second'
			WHEN 3 THEN 'Third'
			WHEN 4 THEN 'Fourth'
	  END AS QuarterName,
    DatePart(Year, @curDate) as Year,
    CONCAT('CY ', DatePart(Year, @startDate)) as YearName,
    CONCAT(LEFT(DATENAME(Month, @curDate), 3), '-', 
	          DATEPART(Year, @curDate)) AS MonthYear,
    CONCAT(RIGHT(CONCAT('0', DATEPART(Month, @curDate)), 2),  
		      DATEPART(Year, @curDate)) AS MMYYYY,
    @FirstDayMonth as FirstDayOfMonth,
    EOMONTH(@curDate) as LastDayOfMonth,
    DATEADD(Quarter, DATEDIFF(Quarter, 0, @curDate), 0) AS FirstDayOfQuarter,
    DATEADD(Quarter, DATEDIFF(Quarter, -1, @curDate), -1) AS LastDayOfQuarter,
    DateFromParts(Year(@curDate), '01', '01') as FirstDayOfYear,
    DateFromParts(Year(@curDate), '12', '31') as LastDayOfYear,
    CASE
		WHEN DATEPART(WeekDay, @curDate) in (1, 7) THEN 0
		WHEN DATEPART(WeekDay, @curDate) in (2, 3, 4, 5, 6) THEN 1
	  END as IsWeekday

  /* Increate @curDate by 1 day */
  SET @curDate = DateAdd(Day, 1, @curDate)
End

SELECT COUNT(*) AS 'timeDim'
FROM timeDim;
-- 823