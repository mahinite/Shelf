CREATE OR REPLACE FUNCTION public.user_can_access_document(
    p_user_id uuid,
    p_document_id uuid
)
RETURNS boolean
LANGUAGE sql
STABLE
SECURITY DEFINER
AS $$
    SELECT EXISTS (
        SELECT 1
        FROM public.documents d
        JOIN public.chapters c ON d.chapter_id = c.id
        JOIN public.subjects s ON c.subject_id = s.id
        JOIN public.room_members rm ON s.room_id = rm.room_id
        WHERE d.id = p_document_id
          AND rm.user_id = p_user_id
    );
$$;