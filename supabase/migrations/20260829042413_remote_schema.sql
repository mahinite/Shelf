drop policy "Members can view their rooms" on "public"."rooms";

alter table "public"."scan_batches" drop constraint "scan_batches_scanned_by_fkey";

alter table "public"."scan_batches" alter column "scanned_by" drop not null;

alter table "public"."scan_batches" add constraint "scan_batches_scanned_by_fkey" FOREIGN KEY (scanned_by) REFERENCES public.profiles(id) ON DELETE SET NULL not valid;

alter table "public"."scan_batches" validate constraint "scan_batches_scanned_by_fkey";

set check_function_bodies = off;

CREATE OR REPLACE FUNCTION public.handle_profile_deletion()
 RETURNS trigger
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public'
AS $function$
declare
  r record;
  new_owner uuid;
begin
  for r in select id from public.rooms where created_by = old.id loop
    if (select count(*) from public.room_members where room_id = r.id and user_id <> old.id) = 0 then
      delete from public.rooms where id = r.id;
    else
      select user_id into new_owner
      from public.room_members
      where room_id = r.id and user_id <> old.id
      order by created_at asc
      limit 1;
      update public.rooms set created_by = new_owner where id = r.id;
    end if;
  end loop;
  return old;
end;
$function$
;

CREATE OR REPLACE FUNCTION public.user_is_room_member(p_room_id uuid, p_user_id uuid)
 RETURNS boolean
 LANGUAGE plpgsql
 STABLE SECURITY DEFINER
 SET search_path TO 'public'
AS $function$
begin
    if p_room_id is null or p_user_id is null then
        return false;
    end if;

    return exists (
        select 1
        from public.room_members
        where room_id = p_room_id
          and user_id = p_user_id
    );
end;
$function$
;

grant insert on table "public"."documents" to "authenticated";

grant select on table "public"."profiles" to "authenticated";

grant update on table "public"."profiles" to "authenticated";

grant insert on table "public"."scan_batches" to "authenticated";

grant select on table "public"."scan_batches" to "authenticated";

grant delete on table "public"."scan_pages" to "authenticated";

grant insert on table "public"."scan_pages" to "authenticated";

grant select on table "public"."scan_pages" to "authenticated";


  create policy "Members can view their rooms"
  on "public"."rooms"
  as permissive
  for select
  to authenticated
using (((created_by = ( SELECT auth.uid() AS uid)) OR public.user_is_room_member(id, ( SELECT auth.uid() AS uid))));


CREATE TRIGGER before_profile_delete BEFORE DELETE ON public.profiles FOR EACH ROW EXECUTE FUNCTION public.handle_profile_deletion();


