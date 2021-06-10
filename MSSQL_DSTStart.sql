create FUNCTION DSTStart( @Year   char( 4 )  ) RETURNS DateTime AS 
BEGIN
/* #1.0 2020.01.01 by TF: created */
DECLARE @DSTStart           AS DATETIME
      , @Mar1               AS DATETIME
      , @Mar1Day            AS INT
      , @MarDiff            AS INT

    SELECT @Mar1      = CONVERT( CHAR(16), @Year + '-03-01 02:00:00', 126 )
         , @Mar1Day   = DATEPART( WEEKDAY, @Mar1 )

    --Get number of days between Mar 1 and DST start date
    -- Su = 1 = 29 (+28)
    -- Mo = 2 = 28 (+27)
    -- Tu = 3 = 27 (+26)
    -- We = 4 = 26 (+25)
    -- Th = 5 = 25 (+24)
    -- Fr = 6 = 31 (+30)
    -- Sa = 7 = 30 (+29)
    IF @Mar1Day = 1 SET @MarDiff = 28
    IF @Mar1Day = 2 SET @MarDiff = 27
    IF @Mar1Day = 3 SET @MarDiff = 26
    IF @Mar1Day = 4 SET @MarDiff = 25
    IF @Mar1Day = 5 SET @MarDiff = 24
    IF @Mar1Day = 6 SET @MarDiff = 30
    IF @Mar1Day = 7 SET @MarDiff = 29

    SELECT @DSTStart  = DATEADD( DAY, @MarDiff, @Mar1 )

    RETURN @DSTStart
END
GO



