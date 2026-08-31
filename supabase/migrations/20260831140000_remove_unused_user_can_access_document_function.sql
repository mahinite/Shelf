-- Migration: remove_unused_user_can_access_document_function
-- Reason: This function took the user id as a caller-supplied parameter rather than deriving it from auth.uid(). It was never used and poses a security risk if called directly.
-- Dropping the function eliminates the risk.
DROP FUNCTION IF EXISTS public.user_can_access_document(uuid, uuid);
