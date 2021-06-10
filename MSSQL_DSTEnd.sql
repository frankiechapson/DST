create FUNCTION DSTEnd( @Year   char( 4 )  ) RETURNS DateTime AS 
BEGIN
/* #1.0 2020.01.01 by TF: created */
DECLARE @DSTEnd             AS DATETIME
      , @Oct1               AS DATETIME
      , @Oct1Day            AS INT
      , @OctDiff            AS INT

    SELECT @Oct1      = CONVERT( CHAR(16), @Year + '-10-01 03:00:00', 126 )
         , @Oct1Day   = DATEPART( WEEKDAY, @Oct1 )

    --Get number of days between Oct 1 and DST end date
    -- Su = 1 = 29 (+28)
    -- Mo = 2 = 28 (+27)
    -- Tu = 3 = 27 (+26)
    -- We = 4 = 26 (+25)
    -- Th = 5 = 25 (+24)
    -- Fr = 6 = 31 (+30)
    -- Sa = 7 = 30 (+29)
    IF @Oct1Day = 1 SET @OctDiff = 28
    IF @Oct1Day = 2 SET @OctDiff = 27
    IF @Oct1Day = 3 SET @OctDiff = 26
    IF @Oct1Day = 4 SET @OctDiff = 25
    IF @Oct1Day = 5 SET @OctDiff = 24
    IF @Oct1Day = 6 SET @OctDiff = 30
    IF @Oct1Day = 7 SET @OctDiff = 29

    SELECT @DSTEnd  = DATEADD( DAY, @OctDiff, @Oct1 )

    RETURN @DSTEnd
END
GO
