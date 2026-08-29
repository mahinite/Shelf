


SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;


COMMENT ON SCHEMA "public" IS 'standard public schema';



CREATE EXTENSION IF NOT EXISTS "pg_stat_statements" WITH SCHEMA "extensions";






CREATE EXTENSION IF NOT EXISTS "pgcrypto" WITH SCHEMA "extensions";






CREATE EXTENSION IF NOT EXISTS "supabase_vault" WITH SCHEMA "vault";






CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA "extensions";






CREATE OR REPLACE FUNCTION "public"."handle_new_user"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
begin
  insert into public.profiles (
    id,
    display_name
  )
  values (
    new.id,
    new.raw_user_meta_data ->> 'display_name'
  );

  return new;
end;
$$;


ALTER FUNCTION "public"."handle_new_user"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."rls_auto_enable"() RETURNS "event_trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO 'pg_catalog'
    AS $$
DECLARE
  cmd record;
BEGIN
  FOR cmd IN
    SELECT *
    FROM pg_event_trigger_ddl_commands()
    WHERE command_tag IN ('CREATE TABLE', 'CREATE TABLE AS', 'SELECT INTO')
      AND object_type IN ('table','partitioned table')
  LOOP
     IF cmd.schema_name IS NOT NULL AND cmd.schema_name IN ('public') AND cmd.schema_name NOT IN ('pg_catalog','information_schema') AND cmd.schema_name NOT LIKE 'pg_toast%' AND cmd.schema_name NOT LIKE 'pg_temp%' THEN
      BEGIN
        EXECUTE format('alter table if exists %s enable row level security', cmd.object_identity);
        RAISE LOG 'rls_auto_enable: enabled RLS on %', cmd.object_identity;
      EXCEPTION
        WHEN OTHERS THEN
          RAISE LOG 'rls_auto_enable: failed to enable RLS on %', cmd.object_identity;
      END;
     ELSE
        RAISE LOG 'rls_auto_enable: skip % (either system schema or not in enforced list: %.)', cmd.object_identity, cmd.schema_name;
     END IF;
  END LOOP;
END;
$$;


ALTER FUNCTION "public"."rls_auto_enable"() OWNER TO "postgres";

SET default_tablespace = '';

SET default_table_access_method = "heap";


CREATE TABLE IF NOT EXISTS "public"."chapters" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "subject_id" "uuid" NOT NULL,
    "name" "text" NOT NULL,
    "position" integer DEFAULT 0 NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL
);


ALTER TABLE "public"."chapters" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."documents" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "chapter_id" "uuid" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "file_path" "text",
    "file_size" bigint,
    "page_count" integer,
    "position" integer DEFAULT 0 NOT NULL,
    "title" "text" NOT NULL
);


ALTER TABLE "public"."documents" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."profiles" (
    "id" "uuid" NOT NULL,
    "display_name" "text",
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL
);


ALTER TABLE "public"."profiles" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."room_members" (
    "room_id" "uuid" NOT NULL,
    "user_id" "uuid" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL
);


ALTER TABLE "public"."room_members" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."rooms" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "name" "text" NOT NULL,
    "created_by" "uuid" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL
);


ALTER TABLE "public"."rooms" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."scan_batches" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "document_id" "uuid" NOT NULL,
    "scanned_by" "uuid" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL
);


ALTER TABLE "public"."scan_batches" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."scan_pages" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "batch_id" "uuid" NOT NULL,
    "page_order" integer NOT NULL,
    "file_path" "text" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "document_id" "uuid" NOT NULL
);


ALTER TABLE "public"."scan_pages" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."subjects" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "room_id" "uuid" NOT NULL,
    "name" "text" NOT NULL,
    "color" "text",
    "position" integer DEFAULT 0 NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL
);


ALTER TABLE "public"."subjects" OWNER TO "postgres";


ALTER TABLE ONLY "public"."chapters"
    ADD CONSTRAINT "chapters_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."documents"
    ADD CONSTRAINT "documents_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."profiles"
    ADD CONSTRAINT "profiles_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."room_members"
    ADD CONSTRAINT "room_members_pkey" PRIMARY KEY ("room_id", "user_id");



ALTER TABLE ONLY "public"."rooms"
    ADD CONSTRAINT "rooms_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."scan_batches"
    ADD CONSTRAINT "scan_batches_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."scan_pages"
    ADD CONSTRAINT "scan_pages_batch_id_page_number_key" UNIQUE ("batch_id", "page_order");



ALTER TABLE ONLY "public"."scan_pages"
    ADD CONSTRAINT "scan_pages_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."subjects"
    ADD CONSTRAINT "subjects_pkey" PRIMARY KEY ("id");



CREATE INDEX "idx_chapters_subject_id" ON "public"."chapters" USING "btree" ("subject_id");



CREATE INDEX "idx_documents_chapter_id" ON "public"."documents" USING "btree" ("chapter_id");



CREATE INDEX "idx_room_members_user_id" ON "public"."room_members" USING "btree" ("user_id");



CREATE INDEX "idx_rooms_created_by" ON "public"."rooms" USING "btree" ("created_by");



CREATE INDEX "idx_scan_batches_document_id" ON "public"."scan_batches" USING "btree" ("document_id");



CREATE INDEX "idx_scan_batches_scanned_by" ON "public"."scan_batches" USING "btree" ("scanned_by");



CREATE INDEX "idx_scan_pages_batch_id" ON "public"."scan_pages" USING "btree" ("batch_id");



CREATE INDEX "idx_scan_pages_document_id" ON "public"."scan_pages" USING "btree" ("document_id");



CREATE INDEX "idx_subjects_room_id" ON "public"."subjects" USING "btree" ("room_id");



ALTER TABLE ONLY "public"."chapters"
    ADD CONSTRAINT "chapters_subject_id_fkey" FOREIGN KEY ("subject_id") REFERENCES "public"."subjects"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."documents"
    ADD CONSTRAINT "documents_chapter_id_fkey" FOREIGN KEY ("chapter_id") REFERENCES "public"."chapters"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."profiles"
    ADD CONSTRAINT "profiles_id_fkey" FOREIGN KEY ("id") REFERENCES "auth"."users"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."room_members"
    ADD CONSTRAINT "room_members_room_id_fkey" FOREIGN KEY ("room_id") REFERENCES "public"."rooms"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."room_members"
    ADD CONSTRAINT "room_members_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."profiles"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."rooms"
    ADD CONSTRAINT "rooms_created_by_fkey" FOREIGN KEY ("created_by") REFERENCES "public"."profiles"("id") ON DELETE RESTRICT;



ALTER TABLE ONLY "public"."scan_batches"
    ADD CONSTRAINT "scan_batches_document_id_fkey" FOREIGN KEY ("document_id") REFERENCES "public"."documents"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."scan_batches"
    ADD CONSTRAINT "scan_batches_scanned_by_fkey" FOREIGN KEY ("scanned_by") REFERENCES "public"."profiles"("id") ON DELETE RESTRICT;



ALTER TABLE ONLY "public"."scan_pages"
    ADD CONSTRAINT "scan_pages_batch_id_fkey" FOREIGN KEY ("batch_id") REFERENCES "public"."scan_batches"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."scan_pages"
    ADD CONSTRAINT "scan_pages_document_id_fkey" FOREIGN KEY ("document_id") REFERENCES "public"."documents"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."subjects"
    ADD CONSTRAINT "subjects_room_id_fkey" FOREIGN KEY ("room_id") REFERENCES "public"."rooms"("id") ON DELETE CASCADE;



CREATE POLICY "Authenticated users can create rooms" ON "public"."rooms" FOR INSERT TO "authenticated" WITH CHECK (("created_by" = ( SELECT "auth"."uid"() AS "uid")));



CREATE POLICY "Members can create chapters" ON "public"."chapters" FOR INSERT TO "authenticated" WITH CHECK ((EXISTS ( SELECT 1
   FROM ("public"."room_members" "rm"
     JOIN "public"."subjects" "s" ON (("s"."room_id" = "rm"."room_id")))
  WHERE (("s"."id" = "chapters"."subject_id") AND ("rm"."user_id" = ( SELECT "auth"."uid"() AS "uid"))))));



CREATE POLICY "Members can create documents" ON "public"."documents" FOR INSERT TO "authenticated" WITH CHECK ((EXISTS ( SELECT 1
   FROM (("public"."room_members" "rm"
     JOIN "public"."subjects" "s" ON (("s"."room_id" = "rm"."room_id")))
     JOIN "public"."chapters" "c" ON (("c"."subject_id" = "s"."id")))
  WHERE (("c"."id" = "documents"."chapter_id") AND ("rm"."user_id" = ( SELECT "auth"."uid"() AS "uid"))))));



CREATE POLICY "Members can create scan batches" ON "public"."scan_batches" FOR INSERT TO "authenticated" WITH CHECK ((("scanned_by" = ( SELECT "auth"."uid"() AS "uid")) AND (EXISTS ( SELECT 1
   FROM ((("public"."room_members" "rm"
     JOIN "public"."subjects" "s" ON (("s"."room_id" = "rm"."room_id")))
     JOIN "public"."chapters" "c" ON (("c"."subject_id" = "s"."id")))
     JOIN "public"."documents" "d" ON (("d"."chapter_id" = "c"."id")))
  WHERE (("d"."id" = "scan_batches"."document_id") AND ("rm"."user_id" = ( SELECT "auth"."uid"() AS "uid")))))));



CREATE POLICY "Members can create scan pages" ON "public"."scan_pages" FOR INSERT TO "authenticated" WITH CHECK ((EXISTS ( SELECT 1
   FROM (((("public"."scan_batches" "sb"
     JOIN "public"."documents" "d" ON (("d"."id" = "sb"."document_id")))
     JOIN "public"."chapters" "c" ON (("c"."id" = "d"."chapter_id")))
     JOIN "public"."subjects" "s" ON (("s"."id" = "c"."subject_id")))
     JOIN "public"."room_members" "rm" ON (("rm"."room_id" = "s"."room_id")))
  WHERE (("sb"."id" = "scan_pages"."batch_id") AND ("scan_pages"."document_id" = "sb"."document_id") AND ("sb"."scanned_by" = ( SELECT "auth"."uid"() AS "uid")) AND ("rm"."user_id" = ( SELECT "auth"."uid"() AS "uid"))))));



CREATE POLICY "Members can create subjects" ON "public"."subjects" FOR INSERT TO "authenticated" WITH CHECK ((EXISTS ( SELECT 1
   FROM "public"."room_members" "rm"
  WHERE (("rm"."room_id" = "subjects"."room_id") AND ("rm"."user_id" = ( SELECT "auth"."uid"() AS "uid"))))));



CREATE POLICY "Members can view their rooms" ON "public"."rooms" FOR SELECT TO "authenticated" USING ((("created_by" = ( SELECT "auth"."uid"() AS "uid")) OR (EXISTS ( SELECT 1
   FROM "public"."room_members" "rm"
  WHERE (("rm"."room_id" = "rooms"."id") AND ("rm"."user_id" = ( SELECT "auth"."uid"() AS "uid")))))));



CREATE POLICY "Room members can view chapters" ON "public"."chapters" FOR SELECT TO "authenticated" USING ((EXISTS ( SELECT 1
   FROM ("public"."room_members" "rm"
     JOIN "public"."subjects" "s" ON (("s"."room_id" = "rm"."room_id")))
  WHERE (("s"."id" = "chapters"."subject_id") AND ("rm"."user_id" = ( SELECT "auth"."uid"() AS "uid"))))));



CREATE POLICY "Room members can view documents" ON "public"."documents" FOR SELECT TO "authenticated" USING ((EXISTS ( SELECT 1
   FROM (("public"."room_members" "rm"
     JOIN "public"."subjects" "s" ON (("s"."room_id" = "rm"."room_id")))
     JOIN "public"."chapters" "c" ON (("c"."subject_id" = "s"."id")))
  WHERE (("c"."id" = "documents"."chapter_id") AND ("rm"."user_id" = ( SELECT "auth"."uid"() AS "uid"))))));



CREATE POLICY "Room members can view scan batches" ON "public"."scan_batches" FOR SELECT TO "authenticated" USING ((EXISTS ( SELECT 1
   FROM ((("public"."room_members" "rm"
     JOIN "public"."subjects" "s" ON (("s"."room_id" = "rm"."room_id")))
     JOIN "public"."chapters" "c" ON (("c"."subject_id" = "s"."id")))
     JOIN "public"."documents" "d" ON (("d"."chapter_id" = "c"."id")))
  WHERE (("d"."id" = "scan_batches"."document_id") AND ("rm"."user_id" = ( SELECT "auth"."uid"() AS "uid"))))));



CREATE POLICY "Room members can view scan pages" ON "public"."scan_pages" FOR SELECT TO "authenticated" USING ((EXISTS ( SELECT 1
   FROM (((("public"."room_members" "rm"
     JOIN "public"."subjects" "s" ON (("s"."room_id" = "rm"."room_id")))
     JOIN "public"."chapters" "c" ON (("c"."subject_id" = "s"."id")))
     JOIN "public"."documents" "d" ON (("d"."chapter_id" = "c"."id")))
     JOIN "public"."scan_batches" "sb" ON (("sb"."document_id" = "d"."id")))
  WHERE (("sb"."id" = "scan_pages"."batch_id") AND ("rm"."user_id" = ( SELECT "auth"."uid"() AS "uid"))))));



CREATE POLICY "Room members can view subjects" ON "public"."subjects" FOR SELECT TO "authenticated" USING ((EXISTS ( SELECT 1
   FROM "public"."room_members" "rm"
  WHERE (("rm"."room_id" = "subjects"."room_id") AND ("rm"."user_id" = ( SELECT "auth"."uid"() AS "uid"))))));



CREATE POLICY "Uploaders can delete their own scan pages" ON "public"."scan_pages" FOR DELETE TO "authenticated" USING ((EXISTS ( SELECT 1
   FROM "public"."scan_batches" "sb"
  WHERE (("sb"."id" = "scan_pages"."batch_id") AND ("sb"."scanned_by" = ( SELECT "auth"."uid"() AS "uid"))))));



CREATE POLICY "Users can add themselves to rooms they created" ON "public"."room_members" FOR INSERT TO "authenticated" WITH CHECK ((("user_id" = ( SELECT "auth"."uid"() AS "uid")) AND (EXISTS ( SELECT 1
   FROM "public"."rooms"
  WHERE (("rooms"."id" = "room_members"."room_id") AND ("rooms"."created_by" = ( SELECT "auth"."uid"() AS "uid")))))));



CREATE POLICY "Users can update their own profile" ON "public"."profiles" FOR UPDATE TO "authenticated" USING (("id" = ( SELECT "auth"."uid"() AS "uid"))) WITH CHECK (("id" = ( SELECT "auth"."uid"() AS "uid")));



CREATE POLICY "Users can view their own profile" ON "public"."profiles" FOR SELECT TO "authenticated" USING (("id" = ( SELECT "auth"."uid"() AS "uid")));



CREATE POLICY "Users can view their own room memberships" ON "public"."room_members" FOR SELECT TO "authenticated" USING (("user_id" = ( SELECT "auth"."uid"() AS "uid")));



ALTER TABLE "public"."chapters" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."documents" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."profiles" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."room_members" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."rooms" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."scan_batches" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."scan_pages" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."subjects" ENABLE ROW LEVEL SECURITY;




ALTER PUBLICATION "supabase_realtime" OWNER TO "postgres";

ALTER PUBLICATION "supabase_realtime" ADD TABLE "public"."subjects";
ALTER PUBLICATION "supabase_realtime" ADD TABLE "public"."chapters";
ALTER PUBLICATION "supabase_realtime" ADD TABLE "public"."documents";


GRANT USAGE ON SCHEMA "public" TO "postgres";
GRANT USAGE ON SCHEMA "public" TO "anon";
GRANT USAGE ON SCHEMA "public" TO "authenticated";
GRANT USAGE ON SCHEMA "public" TO "service_role";






















































































































































REVOKE ALL ON FUNCTION "public"."handle_new_user"() FROM PUBLIC;



REVOKE ALL ON FUNCTION "public"."rls_auto_enable"() FROM PUBLIC;


















GRANT REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLE "public"."chapters" TO "anon";
GRANT SELECT,INSERT,REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLE "public"."chapters" TO "authenticated";
GRANT REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLE "public"."chapters" TO "service_role";



GRANT REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLE "public"."documents" TO "anon";
GRANT SELECT,REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLE "public"."documents" TO "authenticated";
GRANT REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLE "public"."documents" TO "service_role";



GRANT REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLE "public"."profiles" TO "anon";
GRANT REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLE "public"."profiles" TO "authenticated";
GRANT REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLE "public"."profiles" TO "service_role";



GRANT REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLE "public"."room_members" TO "anon";
GRANT SELECT,INSERT,REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLE "public"."room_members" TO "authenticated";
GRANT REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLE "public"."room_members" TO "service_role";



GRANT REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLE "public"."rooms" TO "anon";
GRANT SELECT,INSERT,REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLE "public"."rooms" TO "authenticated";
GRANT REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLE "public"."rooms" TO "service_role";



GRANT REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLE "public"."scan_batches" TO "anon";
GRANT REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLE "public"."scan_batches" TO "authenticated";
GRANT REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLE "public"."scan_batches" TO "service_role";



GRANT REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLE "public"."scan_pages" TO "anon";
GRANT REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLE "public"."scan_pages" TO "authenticated";
GRANT REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLE "public"."scan_pages" TO "service_role";



GRANT REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLE "public"."subjects" TO "anon";
GRANT SELECT,INSERT,REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLE "public"."subjects" TO "authenticated";
GRANT REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLE "public"."subjects" TO "service_role";









ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "postgres";






ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "postgres";






ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLES TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLES TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLES TO "service_role";



































drop extension if exists "pg_net";

revoke delete on table "public"."chapters" from "anon";

revoke insert on table "public"."chapters" from "anon";

revoke select on table "public"."chapters" from "anon";

revoke update on table "public"."chapters" from "anon";

revoke delete on table "public"."chapters" from "authenticated";

revoke update on table "public"."chapters" from "authenticated";

revoke delete on table "public"."chapters" from "service_role";

revoke insert on table "public"."chapters" from "service_role";

revoke select on table "public"."chapters" from "service_role";

revoke update on table "public"."chapters" from "service_role";

revoke delete on table "public"."documents" from "anon";

revoke insert on table "public"."documents" from "anon";

revoke select on table "public"."documents" from "anon";

revoke update on table "public"."documents" from "anon";

revoke delete on table "public"."documents" from "authenticated";

revoke insert on table "public"."documents" from "authenticated";

revoke update on table "public"."documents" from "authenticated";

revoke delete on table "public"."documents" from "service_role";

revoke insert on table "public"."documents" from "service_role";

revoke select on table "public"."documents" from "service_role";

revoke update on table "public"."documents" from "service_role";

revoke delete on table "public"."profiles" from "anon";

revoke insert on table "public"."profiles" from "anon";

revoke select on table "public"."profiles" from "anon";

revoke update on table "public"."profiles" from "anon";

revoke delete on table "public"."profiles" from "authenticated";

revoke insert on table "public"."profiles" from "authenticated";

revoke select on table "public"."profiles" from "authenticated";

revoke update on table "public"."profiles" from "authenticated";

revoke delete on table "public"."profiles" from "service_role";

revoke insert on table "public"."profiles" from "service_role";

revoke select on table "public"."profiles" from "service_role";

revoke update on table "public"."profiles" from "service_role";

revoke delete on table "public"."room_members" from "anon";

revoke insert on table "public"."room_members" from "anon";

revoke select on table "public"."room_members" from "anon";

revoke update on table "public"."room_members" from "anon";

revoke delete on table "public"."room_members" from "authenticated";

revoke update on table "public"."room_members" from "authenticated";

revoke delete on table "public"."room_members" from "service_role";

revoke insert on table "public"."room_members" from "service_role";

revoke select on table "public"."room_members" from "service_role";

revoke update on table "public"."room_members" from "service_role";

revoke delete on table "public"."rooms" from "anon";

revoke insert on table "public"."rooms" from "anon";

revoke select on table "public"."rooms" from "anon";

revoke update on table "public"."rooms" from "anon";

revoke delete on table "public"."rooms" from "authenticated";

revoke update on table "public"."rooms" from "authenticated";

revoke delete on table "public"."rooms" from "service_role";

revoke insert on table "public"."rooms" from "service_role";

revoke select on table "public"."rooms" from "service_role";

revoke update on table "public"."rooms" from "service_role";

revoke delete on table "public"."scan_batches" from "anon";

revoke insert on table "public"."scan_batches" from "anon";

revoke select on table "public"."scan_batches" from "anon";

revoke update on table "public"."scan_batches" from "anon";

revoke delete on table "public"."scan_batches" from "authenticated";

revoke insert on table "public"."scan_batches" from "authenticated";

revoke select on table "public"."scan_batches" from "authenticated";

revoke update on table "public"."scan_batches" from "authenticated";

revoke delete on table "public"."scan_batches" from "service_role";

revoke insert on table "public"."scan_batches" from "service_role";

revoke select on table "public"."scan_batches" from "service_role";

revoke update on table "public"."scan_batches" from "service_role";

revoke delete on table "public"."scan_pages" from "anon";

revoke insert on table "public"."scan_pages" from "anon";

revoke select on table "public"."scan_pages" from "anon";

revoke update on table "public"."scan_pages" from "anon";

revoke delete on table "public"."scan_pages" from "authenticated";

revoke insert on table "public"."scan_pages" from "authenticated";

revoke select on table "public"."scan_pages" from "authenticated";

revoke update on table "public"."scan_pages" from "authenticated";

revoke delete on table "public"."scan_pages" from "service_role";

revoke insert on table "public"."scan_pages" from "service_role";

revoke select on table "public"."scan_pages" from "service_role";

revoke update on table "public"."scan_pages" from "service_role";

revoke delete on table "public"."subjects" from "anon";

revoke insert on table "public"."subjects" from "anon";

revoke select on table "public"."subjects" from "anon";

revoke update on table "public"."subjects" from "anon";

revoke delete on table "public"."subjects" from "authenticated";

revoke update on table "public"."subjects" from "authenticated";

revoke delete on table "public"."subjects" from "service_role";

revoke insert on table "public"."subjects" from "service_role";

revoke select on table "public"."subjects" from "service_role";

revoke update on table "public"."subjects" from "service_role";

CREATE TRIGGER on_auth_user_created AFTER INSERT ON auth.users FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();


