-- Fix for RLS infinite recursion error (42P17) between rooms SELECT and room_members INSERT policies
-- Uses PL/pgSQL function to prevent inlining and preserve SECURITY DEFINER context

-- 1. PL/pgSQL prevents query planner inlining and strictly preserves SECURITY DEFINER
CREATE OR REPLACE FUNCTION public.user_is_room_member(p_room_id uuid, p_user_id uuid)
RETURNS boolean
LANGUAGE plpgsql
STABLE
SECURITY DEFINER
SET search_path = public
AS $$
BEGIN
    IF p_room_id IS NULL OR p_user_id IS NULL THEN
        RETURN false;
    END IF;
    
    RETURN EXISTS (
        SELECT 1 
        FROM public.room_members
        WHERE room_id = p_room_id
          AND user_id = p_user_id
    );
END;
$$;

-- Ensure function runs with sufficient privileges to bypass RLS when needed
ALTER FUNCTION public.user_is_room_member(uuid, uuid) OWNER TO supabase_admin;

-- 2. Drop ALL active SELECT and INSERT policies on room_members and rooms
DROP POLICY IF EXISTS "Users can view their own room memberships" ON public.room_members;
DROP POLICY IF EXISTS "Users can add themselves to rooms they created" ON public.room_members;
DROP POLICY IF EXISTS "Members can view their rooms" ON public.rooms;

-- 3. SELECT policy for room_members (Evaluates safely on RETURNING 1)
CREATE POLICY "Users can view their own room memberships"
ON public.room_members
FOR SELECT
TO authenticated
USING (
    user_id = (SELECT auth.uid())
    OR public.user_is_room_member(room_id, (SELECT auth.uid()))
);

-- 4. INSERT policy for room_members
CREATE POLICY "Users can add themselves to rooms they created"
ON public.room_members
FOR INSERT
TO authenticated
WITH CHECK (
    user_id = (SELECT auth.uid())
    AND EXISTS (
        SELECT 1 FROM public.rooms
        WHERE id = room_members.room_id
          AND created_by = (SELECT auth.uid())
    )
);

-- 5. SELECT policy for rooms
CREATE POLICY "Members can view their rooms"
ON public.rooms
FOR SELECT
TO authenticated
USING (
    created_by = (SELECT auth.uid())
    OR public.user_is_room_member(id, (SELECT auth.uid()))
);