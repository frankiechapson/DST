/* ******************************************************************************** 

    Returns the DST end date and time in the specified year.

    select DSTEnd ( 2020 );

 ******************************************************************************** */


create or replace function DSTEnd( P_YEAR   integer  ) 
 returns timestamp 
language plpgsql
as $$
declare 
    V_Oct1       timestamp := to_timestamp( P_YEAR::varchar(4) || '-10-01 03:00:00', 'YYYY-MM-DD HH24:MI:SS' );
    V_Oct1Day    integer   := extract( dow from V_Oct1 );
    V_OctDiff    integer;
begin
    --Get number of days between Oct 1 and DST end date
    -- Su = 0 = 29 (+28)
    -- Mo = 1 = 28 (+27)
    -- Tu = 2 = 27 (+26)
    -- We = 3 = 26 (+25)
    -- Th = 4 = 25 (+24)
    -- Fr = 5 = 31 (+30)
    -- Sa = 6 = 30 (+29)
    case V_Oct1Day 
      when 0 then V_OctDiff := 28;
      when 1 then V_OctDiff := 27;
      when 2 then V_OctDiff := 26;
      when 3 then V_OctDiff := 25;
      when 4 then V_OctDiff := 24;
      when 5 then V_OctDiff := 30;
      when 6 then V_OctDiff := 29;
    end case;

    return V_Oct1 + ( V_OctDiff::varchar || ' day' )::interval;

end; $$ 



