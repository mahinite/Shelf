The issue is now clear. Let me verify by comparing the exact queries:

**Home screen query (user `3dbbb6d5-bfb1-4aa5-a322-2a7fbfccb681`):**
```json
[{"id":"1efc07dd-9fad-4a4e-9110-fdd1480bcb55","name":"Tuition","created_by":"3dbbb6d5-bfb1-4aa5-a322-2a7fbfccb681","created_at":"2026-08-28 16:51:16.358891+00","subject_count":5}]
```
→ **1 room** (only rooms where user is a member via room_members)

**HierarchyPickerSheet query (no user filter):**
```json
[{"id":"a06c9eef-a0cf-42ae-8314-4f0aa829c8a4","name":"Tuition",...},{"id":"f6909028-87bf-4f6a-96bb-82081f08b85b","name":"Tuition",...},{"id":"407d475c-4cb3-47d1-b19c-d1b5d2779bb3","name":"Gyh",...},{"id":"9f952652-d784-4e43-ad96-628364498ddf","name":"Bb",...},{"id":"cffef7dc-0d38-47e6-aea8-4f84ee9aee51","name":"Tuition",...},{"id":"e20b630a-38e5-4cf1-b5ae-d73bd7eceb5c","name":"Tuition",...},{"id":"365279f1-979e-425b-a602-afec19d95d28","name":"Tuition",...},{"id":"1efc07dd-9fad-4a4e-9110-fdd1480bcb55","name":"Tuition",...},{"id":"c694182a-3c1f-461c-8d4a-13994a5550d1","name":"Tuition",...},{"id":"437a227f-b835-4ed3-b09e-a8f19ca55862","name":"My Room",...}]
```
→ **10 rooms** (ALL rooms in database, including other users' rooms)

The bug is confirmed: **HierarchyPickerSheet._loadRooms() doesn't filter by the current user's room membership**. It loads all rooms from the database, while the Home screen correctly filters to only show rooms where the user is a member (via `room_members!inner` join).

This explains the symptom: after deleting a room from Home, the picker still shows other rooms (including old test "Tuition" rooms) that the user doesn't see on Home. The picker should only show rooms the user has access to.

The fix is to update `HierarchyPickerSheet._loadRooms()` to match the Home screen's query pattern with the `room_members!inner` join and user filter.