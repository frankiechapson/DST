create or replace function DSTEnd ( I_YEAR in number ) return date is
/********************************************************************************************************************

    Returns the DST end date and time in the specified year.


    Sample:
    -------
    select DSTEnd ( 2020 ) from dual;

    Result:
    -------
    2020.10.25 03:00:00

    History of changes
    yyyy.mm.dd | Version | Author         | Changes
    -----------+---------+----------------+-------------------------
    2021.06.10 |  1.0    | Ferenc Toth    | Created 

********************************************************************************************************************/

    V_DSTEND             date;
    V_OCT1               date          := to_date( trim( to_char( I_YEAR ) ) || '.10.01 03:00:00', 'yyyy.mm.dd hh24:mi:ss' );
    V_OCT1DAY            varchar2( 5 ) := trim( to_char( V_OCT1 , 'DY', 'NLS_DATE_LANGUAGE=AMERICAN' ) );
    V_OCTDIFF            integer;

begin
    --Get number of days between Oct 1 and DST end date    
    case V_OCT1DAY 
      when 'SUN' then V_OCTDIFF := 28;
      when 'MON' then V_OCTDIFF := 27;
      when 'TUE' then V_OCTDIFF := 26;
      when 'WED' then V_OCTDIFF := 25;
      when 'THU' then V_OCTDIFF := 24;
      when 'FRI' then V_OCTDIFF := 30;
      when 'SAT' then V_OCTDIFF := 29;
    end case;

    V_DSTEND := V_OCT1 + V_OCTDIFF;

    RETURN V_DSTEND;

end;
/

