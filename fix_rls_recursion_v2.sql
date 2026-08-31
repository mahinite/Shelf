-- Fix for RLS infinite recursion error (42P17) between rooms SELECT and room_members INSERT policies
-- Breaks the cycle by using a SECURITY DEFINER helper function owned by supabase_admin for authorization checks

-- Create helper function to check room membership with SECURITY DEFINER and owned by supabase_admin
CREATE OR REPLACE FUNCTION public.user_is_room_member(p_room_id uuid, p_user_id uuid)
RETURNS boolean
LANGUAGE sql
SECURITY DEFINER
SET search_path = public
AS $$
  SELECT
    CASE
      WHEN p_room_id IS NULL OR p_user_id IS NULL THEN false
      ELSE EXISTS (
        SELECT 1
        FROM room_members
        WHERE room_id = p_room_id
          AND user_id = p_user_id
      )
    END
$$;

-- Change owner to supabase_admin so the function executes with bypass RLS privileges
ALTER FUNCTION public.user_is_room_member(p_room_id uuid, p_user_id uuid) OWNER TO supabase_admin;

-- Update rooms table SELECT policy to use helper function
DROP POLICY IF EXISTS "Rooms select policy" ON rooms;
CREATE POLICY "Rooms select policy" ON rooms
FOR SELECT
USING (public.user_is_room_member(id, auth.uid()));

-- Update room_members table INSERT policy to use helper function
DROP POLICY IF EXISTS "Room members insert policy" ON room_members;
CREATE POLICY "Room members insert policy" ON room_members
FOR INSERT
WITH CHECK (public.user_is_room_member(room_id, auth.uid()));