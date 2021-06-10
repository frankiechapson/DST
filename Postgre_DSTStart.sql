/* ******************************************************************************** 

    Returns the DST start date and time in the specified year.

    select DSTStart ( 2020 );

 ******************************************************************************** */


create or replace function DSTStart( P_YEAR   integer  ) 
 returns timestamp 
language plpgsql
as $$
declare 
    V_Mar1       timestamp := to_timestamp( P_YEAR::varchar(4) || '-03-01 02:00:00', 'YYYY-MM-DD HH24:MI:SS' );
    V_Mar1Day    integer   := extract( dow from V_Mar1 );
    V_MarDiff    integer;
begin
    --Get number of days between Mar 1 and DST end date
    -- Su = 0 = 29 (+28)
    -- Mo = 1 = 28 (+27)
    -- Tu = 2 = 27 (+26)
    -- We = 3 = 26 (+25)
    -- Th = 4 = 25 (+24)
    -- Fr = 5 = 31 (+30)
    -- Sa = 6 = 30 (+29)
    case V_Mar1Day 
      when 0 then V_MarDiff := 28;
      when 1 then V_MarDiff := 27;
      when 2 then V_MarDiff := 26;
      when 3 then V_MarDiff := 25;
      when 4 then V_MarDiff := 24;
      when 5 then V_MarDiff := 30;
      when 6 then V_MarDiff := 29;
    end case;

    return V_Mar1 + ( V_MarDiff::varchar || ' day' )::interval;

end; $$ 



