create or replace function DSTStart ( I_YEAR in number ) return date is
/********************************************************************************************************************

    Returns the DST start date and time in the specified year.


    Sample:
    -------
    select DSTStart ( 2020 ) from dual;

    Result:
    -------
    2020.03.29 02:00:00

    History of changes
    yyyy.mm.dd | Version | Author         | Changes
    -----------+---------+----------------+-------------------------
    2021.06.10 |  1.0    | Ferenc Toth    | Created 

********************************************************************************************************************/

    V_DSTSTART           date;
    V_MAR1               date          := to_date( trim( to_char( I_YEAR ) ) || '.03.01 02:00:00', 'yyyy.mm.dd hh24:mi:ss' );
    V_MAR1DAY            varchar2( 5 ) := trim( to_char( V_MAR1 , 'DY', 'NLS_DATE_LANGUAGE=AMERICAN' ) );
    V_MARDIFF            integer;

begin
    --Get number of days between MAR 1 and DST end date    
    case V_MAR1DAY 
      when 'SUN' then V_MARDIFF := 28;
      when 'MON' then V_MARDIFF := 27;
      when 'TUE' then V_MARDIFF := 26;
      when 'WED' then V_MARDIFF := 25;
      when 'THU' then V_MARDIFF := 24;
      when 'FRI' then V_MARDIFF := 30;
      when 'SAT' then V_MARDIFF := 29;
    end case;

    V_DSTSTART := V_MAR1 + V_MARDIFF;

    RETURN V_DSTSTART;

end;
/

