**Yes – `hierarchy_picker_sheet.dart` was changed in this session.**  
The modifications consisted solely of **removing dead code** (unused imports, unused state fields, and the assignments that wrote to those fields). No new code was added.

---

### Diff (unified format) – before → after

```diff
@@
-import '../../features/documents/widgets/document_list_item.dart';
-
 import '../../features/rooms/models/room.dart';
@@
-import '../theme/app_theme.dart';
-
 import '../widgets/tactile.dart';
@@
-   Room? _selectedRoom;
-   Subject? _selectedSubject;
   Chapter? _selectedChapter;
   Document? _selectedDocument;
@@
-                 _selectedRoom = room;
                  _loadSubjects(room.id);
@@
-                 _selectedSubject = subject;
                  _loadChapters(subject.id);
```

**Explanation of the diff**

| Change | Reason |
|--------|--------|
| Removed import of `document_list_item.dart` (line 10) and `app_theme.dart` (line 14). | Both imports were flagged as unused by `flutter analyze`. |
| Deleted the fields `_selectedRoom` and `_selectedSubject`. | The fields were never read after being set, causing “unused field” warnings. |
| Removed the assignments `_selectedRoom = room;` and `_selectedSubject = subject;` inside the tap handlers. | With the fields gone, the assignments were dead code; the picker now relies only on `_selectedChapter` / `_selectedDocument`, which are the values actually used when the user confirms the selection. |

All other code in the file remains untouched, preserving the existing navigation, data loading, and the confirm‑button logic that correctly returns the chosen **Chapter** or **Document**.


flutter logs

PS D:\Code\Shelf dart> flutter logs
Showing A059 logs:
I/flutter (15454): [scan] _handleScanTap ENTERED, context.mounted=true
I/flutter (15454): [scan] calling FlutterDocScanner().getScannedDocumentAsImages()
D/FlutterJNI(15454): Sending viewport metrics to the engine.
I/flutter (15454): [scan] scanner returned. result==null? false. runtimeType=ImageScanResult. toString="ImageScanResult(images: [file:///data/user/0/com.example.shelf/cache/mlkit_docscan_ui_client/849283710032071.jpg, file:///data/user/0/com.example.shelf/cache/mlkit_docscan_ui_client/849283738493373.jpg], count: 2)"
I/flutter (15454): [scan] imagePaths count=2
I/flutter (15454): [scan] imagePaths=2 paths. About to call Navigator.push to ScanConfigScreen.
I/flutter (15454): [scan] calling Navigator.of(context).push(MaterialPageRoute(builder: ScanConfigScreen))
I/flutter (15454): [scan] Navigator.push returned (sync). Awaiting frame.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
E/flutter (15454): [ERROR:flutter/runtime/dart_vm_initializer.cc(40)] Unhandled Exception: PostgrestException(message: column rooms.subject_count does not exist, code: 42703, details: Bad Request, hint: null)
E/flutter (15454): #0      PostgrestBuilder._parseResponse (package:postgrest/src/postgrest_builder.dart:584:5)
E/flutter (15454): #1      PostgrestBuilder._execute (package:postgrest/src/postgrest_builder.dart:412:18)
E/flutter (15454): <asynchronous suspension>
E/flutter (15454): <asynchronous suspension>
E/flutter (15454):
E/flutter (15454): <async call site>
E/flutter (15454): #0      PostgrestBuilder.then (package:postgrest/src/postgrest_builder.dart:694:36)
E/flutter (15454): #1      _HierarchyPickerSheetState._loadRooms (package:shelf/core/widgets/hierarchy_picker_sheet.dart:57:18)
E/flutter (15454): #2      _HierarchyPickerSheetState.initState (package:shelf/core/widgets/hierarchy_picker_sheet.dart:53:5)
E/flutter (15454): #3      StatefulElement._firstBuild (package:flutter/src/widgets/framework.dart:5963:55)
E/flutter (15454): #4      ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #5      Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #6      Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #7      ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #8      Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #9      ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #10     ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #11     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #12     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #13     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #14     Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #15     ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #16     ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #17     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #18     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #19     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #20     StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (15454): #21     Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #22     ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #23     StatefulElement._firstBuild (package:flutter/src/widgets/framework.dart:5986:11)
E/flutter (15454): #24     ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #25     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #26     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #27     SingleChildRenderObjectElement.mount (package:flutter/src/widgets/framework.dart:7128:14)
E/flutter (15454): #28     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #29     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #30     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #31     Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #32     ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #33     ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #34     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #35     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #36     SingleChildRenderObjectElement.mount (package:flutter/src/widgets/framework.dart:7128:14)
E/flutter (15454): #37     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #38     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #39     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #40     Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #41     ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #42     ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #43     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #44     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #45     SingleChildRenderObjectElement.mount (package:flutter/src/widgets/framework.dart:7128:14)
E/flutter (15454): #46     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #47     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #48     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #49     StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (15454): #50     Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #51     ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #52     StatefulElement._firstBuild (package:flutter/src/widgets/framework.dart:5986:11)
E/flutter (15454): #53     ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #54     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #55     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #56     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #57     StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (15454): #58     Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #59     ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #60     StatefulElement._firstBuild (package:flutter/src/widgets/framework.dart:5986:11)
E/flutter (15454): #61     ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #62     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #63     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #64     SingleChildRenderObjectElement.mount (package:flutter/src/widgets/framework.dart:7128:14)
E/flutter (15454): #65     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #66     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #67     SingleChildRenderObjectElement.mount (package:flutter/src/widgets/framework.dart:7128:14)
E/flutter (15454): #68     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #69     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #70     SingleChildRenderObjectElement.mount (package:flutter/src/widgets/framework.dart:7128:14)
E/flutter (15454): #71     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #72     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #73     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #74     StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (15454): #75     Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #76     ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #77     StatefulElement._firstBuild (package:flutter/src/widgets/framework.dart:5986:11)
E/flutter (15454): #78     ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #79     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #80     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #81     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #82     Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #83     ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #84     ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #85     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #86     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #87     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #88     StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (15454): #89     Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #90     ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #91     StatefulElement._firstBuild (package:flutter/src/widgets/framework.dart:5986:11)
E/flutter (15454): #92     ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #93     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #94     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #95     SingleChildRenderObjectElement.mount (package:flutter/src/widgets/framework.dart:7128:14)
E/flutter (15454): #96     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #97     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #98     SingleChildRenderObjectElement.mount (package:flutter/src/widgets/framework.dart:7128:14)
E/flutter (15454): #99     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #100    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #101    SingleChildRenderObjectElement.mount (package:flutter/src/widgets/framework.dart:7128:14)
E/flutter (15454): #102    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #103    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #104    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #105    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (15454): #106    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #107    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #108    StatefulElement._firstBuild (package:flutter/src/widgets/framework.dart:5986:11)
E/flutter (15454): #109    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #110    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #111    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #112    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #113    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (15454): #114    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #115    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #116    StatefulElement._firstBuild (package:flutter/src/widgets/framework.dart:5986:11)
E/flutter (15454): #117    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #118    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #119    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #120    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #121    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #122    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #123    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #124    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #125    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #126    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #127    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #128    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #129    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #130    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #131    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #132    SingleChildRenderObjectElement.mount (package:flutter/src/widgets/framework.dart:7128:14)
E/flutter (15454): #133    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #134    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #135    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #136    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #137    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #138    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #139    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #140    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #141    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #142    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #143    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #144    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #145    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #146    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #147    SingleChildRenderObjectElement.mount (package:flutter/src/widgets/framework.dart:7128:14)
E/flutter (15454): #148    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #149    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #150    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #151    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #152    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #153    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #154    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #155    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #156    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #157    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #158    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #159    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #160    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #161    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #162    SingleChildRenderObjectElement.mount (package:flutter/src/widgets/framework.dart:7128:14)
E/flutter (15454): #163    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #164    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #165    SingleChildRenderObjectElement.mount (package:flutter/src/widgets/framework.dart:7128:14)
E/flutter (15454): #166    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #167    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #168    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #169    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (15454): #170    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #171    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #172    StatefulElement._firstBuild (package:flutter/src/widgets/framework.dart:5986:11)
E/flutter (15454): #173    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #174    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #175    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #176    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #177    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (15454): #178    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #179    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #180    StatefulElement._firstBuild (package:flutter/src/widgets/framework.dart:5986:11)
E/flutter (15454): #181    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #182    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #183    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #184    SingleChildRenderObjectElement.mount (package:flutter/src/widgets/framework.dart:7128:14)
E/flutter (15454): #185    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #186    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #187    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #188    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #189    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #190    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #191    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #192    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #193    SingleChildRenderObjectElement.mount (package:flutter/src/widgets/framework.dart:7128:14)
E/flutter (15454): #194    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #195    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #196    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #197    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (15454): #198    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #199    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #200    StatefulElement._firstBuild (package:flutter/src/widgets/framework.dart:5986:11)
E/flutter (15454): #201    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #202    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #203    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #204    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #205    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #206    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #207    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #208    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #209    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #210    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #211    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #212    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #213    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #214    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #215    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #216    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #217    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (15454): #218    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #219    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #220    StatefulElement._firstBuild (package:flutter/src/widgets/framework.dart:5986:11)
E/flutter (15454): #221    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #222    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #223    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #224    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #225    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #226    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #227    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #228    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #229    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #230    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #231    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #232    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #233    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #234    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #235    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #236    SingleChildRenderObjectElement.mount (package:flutter/src/widgets/framework.dart:7128:14)
E/flutter (15454): #237    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #238    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #239    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #240    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #241    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #242    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #243    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #244    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #245    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #246    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #247    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #248    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #249    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #250    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #251    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #252    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (15454): #253    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #254    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #255    StatefulElement._firstBuild (package:flutter/src/widgets/framework.dart:5986:11)
E/flutter (15454): #256    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #257    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #258    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #259    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #260    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (15454): #261    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #262    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #263    StatefulElement._firstBuild (package:flutter/src/widgets/framework.dart:5986:11)
E/flutter (15454): #264    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #265    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #266    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #267    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #268    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (15454): #269    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #270    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #271    StatefulElement._firstBuild (package:flutter/src/widgets/framework.dart:5986:11)
E/flutter (15454): #272    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #273    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #274    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #275    SingleChildRenderObjectElement.mount (package:flutter/src/widgets/framework.dart:7128:14)
E/flutter (15454): #276    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #277    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #278    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #279    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #280    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #281    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #282    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #283    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #284    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #285    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #286    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #287    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #288    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #289    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #290    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #291    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #292    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #293    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #294    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #295    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #296    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #297    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (15454): #298    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #299    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #300    StatefulElement._firstBuild (package:flutter/src/widgets/framework.dart:5986:11)
E/flutter (15454): #301    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #302    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #303    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #304    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #305    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (15454): #306    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #307    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #308    StatefulElement._firstBuild (package:flutter/src/widgets/framework.dart:5986:11)
E/flutter (15454): #309    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #310    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #311    MultiChildRenderObjectElement.inflateWidget (package:flutter/src/widgets/framework.dart:7277:36)
E/flutter (15454): #312    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #313    Element.updateChildren (package:flutter/src/widgets/framework.dart:4268:32)
E/flutter (15454): #314    MultiChildRenderObjectElement.update (package:flutter/src/widgets/framework.dart:7308:17)
E/flutter (15454): #315    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
E/flutter (15454): #316    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #317    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (15454): #318    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #319    StatefulElement.update (package:flutter/src/widgets/framework.dart:6020:5)
E/flutter (15454): #320    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
E/flutter (15454): #321    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #322    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #323    ProxyElement.update (package:flutter/src/widgets/framework.dart:6162:5)
E/flutter (15454): #324    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
E/flutter (15454): #325    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #326    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #327    ProxyElement.update (package:flutter/src/widgets/framework.dart:6162:5)
E/flutter (15454): #328    _InheritedNotifierElement.update (package:flutter/src/widgets/inherited_notifier.dart:108:11)
E/flutter (15454): #329    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
E/flutter (15454): #330    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #331    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (15454): #332    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #333    StatefulElement.update (package:flutter/src/widgets/framework.dart:6020:5)
E/flutter (15454): #334    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
E/flutter (15454): #335    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #336    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #337    ProxyElement.update (package:flutter/src/widgets/framework.dart:6162:5)
E/flutter (15454): #338    _InheritedNotifierElement.update (package:flutter/src/widgets/inherited_notifier.dart:108:11)
E/flutter (15454): #339    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
E/flutter (15454): #340    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #341    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (15454): #342    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #343    StatefulElement.update (package:flutter/src/widgets/framework.dart:6020:5)
E/flutter (15454): #344    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
E/flutter (15454): #345    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #346    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (15454): #347    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #348    StatefulElement.update (package:flutter/src/widgets/framework.dart:6020:5)
E/flutter (15454): #349    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
E/flutter (15454): #350    SingleChildRenderObjectElement.update (package:flutter/src/widgets/framework.dart:7135:14)
E/flutter (15454): #351    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
E/flutter (15454): #352    SingleChildRenderObjectElement.update (package:flutter/src/widgets/framework.dart:7135:14)
E/flutter (15454): #353    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
E/flutter (15454): #354    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #355    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #356    ProxyElement.update (package:flutter/src/widgets/framework.dart:6162:5)
E/flutter (15454): #357    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
E/flutter (15454): #358    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #359    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #360    ProxyElement.update (package:flutter/src/widgets/framework.dart:6162:5)
E/flutter (15454): #361    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
E/flutter (15454): #362    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #363    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (15454): #364    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #365    BuildScope._tryRebuild (package:flutter/src/widgets/framework.dart:2763:15)
E/flutter (15454): #366    BuildScope._flushDirtyElements (package:flutter/src/widgets/framework.dart:2820:11)
E/flutter (15454): #367    BuildOwner.buildScope (package:flutter/src/widgets/framework.dart:3124:18)
E/flutter (15454): #368    WidgetsBinding.drawFrame (package:flutter/src/widgets/binding.dart:1571:21)
E/flutter (15454): #369    RendererBinding._handlePersistentFrameCallback (package:flutter/src/rendering/binding.dart:558:5)
E/flutter (15454): #370    SchedulerBinding._invokeFrameCallback (package:flutter/src/scheduler/binding.dart:1430:15)
E/flutter (15454): #371    SchedulerBinding.handleDrawFrame (package:flutter/src/scheduler/binding.dart:1345:9)
E/flutter (15454): #372    SchedulerBinding._handleDrawFrame (package:flutter/src/scheduler/binding.dart:1198:5)
E/flutter (15454): #373    _invoke (dart:ui/hooks.dart:441:13)
E/flutter (15454): #374    PlatformDispatcher._drawFrame (dart:ui/platform_dispatcher.dart:450:5)
E/flutter (15454): #375    _drawFrame (dart:ui/hooks.dart:413:31)
E/flutter (15454):
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
E/flutter (15454): [ERROR:flutter/runtime/dart_vm_initializer.cc(40)] Unhandled Exception: PostgrestException(message: column rooms.subject_count does not exist, code: 42703, details: Bad Request, hint: null)
E/flutter (15454): #0      PostgrestBuilder._parseResponse (package:postgrest/src/postgrest_builder.dart:584:5)
E/flutter (15454): #1      PostgrestBuilder._execute (package:postgrest/src/postgrest_builder.dart:412:18)
E/flutter (15454): <asynchronous suspension>
E/flutter (15454): <asynchronous suspension>
E/flutter (15454):
E/flutter (15454): <async call site>
E/flutter (15454): #0      PostgrestBuilder.then (package:postgrest/src/postgrest_builder.dart:694:36)
E/flutter (15454): #1      _HierarchyPickerSheetState._loadRooms (package:shelf/core/widgets/hierarchy_picker_sheet.dart:57:18)
E/flutter (15454): #2      _HierarchyPickerSheetState.initState (package:shelf/core/widgets/hierarchy_picker_sheet.dart:53:5)
E/flutter (15454): #3      StatefulElement._firstBuild (package:flutter/src/widgets/framework.dart:5963:55)
E/flutter (15454): #4      ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #5      Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #6      Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #7      ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #8      Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #9      ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #10     ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #11     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #12     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #13     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #14     Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #15     ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #16     ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #17     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #18     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #19     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #20     StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (15454): #21     Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #22     ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #23     StatefulElement._firstBuild (package:flutter/src/widgets/framework.dart:5986:11)
E/flutter (15454): #24     ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #25     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #26     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #27     SingleChildRenderObjectElement.mount (package:flutter/src/widgets/framework.dart:7128:14)
E/flutter (15454): #28     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #29     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #30     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #31     Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #32     ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #33     ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #34     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #35     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #36     SingleChildRenderObjectElement.mount (package:flutter/src/widgets/framework.dart:7128:14)
E/flutter (15454): #37     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #38     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #39     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #40     Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #41     ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #42     ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #43     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #44     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #45     SingleChildRenderObjectElement.mount (package:flutter/src/widgets/framework.dart:7128:14)
E/flutter (15454): #46     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #47     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #48     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #49     StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (15454): #50     Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #51     ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #52     StatefulElement._firstBuild (package:flutter/src/widgets/framework.dart:5986:11)
E/flutter (15454): #53     ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #54     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #55     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #56     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #57     StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (15454): #58     Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #59     ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #60     StatefulElement._firstBuild (package:flutter/src/widgets/framework.dart:5986:11)
E/flutter (15454): #61     ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #62     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #63     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #64     SingleChildRenderObjectElement.mount (package:flutter/src/widgets/framework.dart:7128:14)
E/flutter (15454): #65     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #66     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #67     SingleChildRenderObjectElement.mount (package:flutter/src/widgets/framework.dart:7128:14)
E/flutter (15454): #68     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #69     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #70     SingleChildRenderObjectElement.mount (package:flutter/src/widgets/framework.dart:7128:14)
E/flutter (15454): #71     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #72     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #73     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #74     StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (15454): #75     Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #76     ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #77     StatefulElement._firstBuild (package:flutter/src/widgets/framework.dart:5986:11)
E/flutter (15454): #78     ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #79     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #80     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #81     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #82     Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #83     ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #84     ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #85     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #86     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #87     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #88     StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (15454): #89     Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #90     ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #91     StatefulElement._firstBuild (package:flutter/src/widgets/framework.dart:5986:11)
E/flutter (15454): #92     ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #93     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #94     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #95     SingleChildRenderObjectElement.mount (package:flutter/src/widgets/framework.dart:7128:14)
E/flutter (15454): #96     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #97     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #98     SingleChildRenderObjectElement.mount (package:flutter/src/widgets/framework.dart:7128:14)
E/flutter (15454): #99     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #100    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #101    SingleChildRenderObjectElement.mount (package:flutter/src/widgets/framework.dart:7128:14)
E/flutter (15454): #102    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #103    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #104    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #105    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (15454): #106    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #107    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #108    StatefulElement._firstBuild (package:flutter/src/widgets/framework.dart:5986:11)
E/flutter (15454): #109    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #110    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #111    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #112    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #113    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (15454): #114    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #115    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #116    StatefulElement._firstBuild (package:flutter/src/widgets/framework.dart:5986:11)
E/flutter (15454): #117    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #118    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #119    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #120    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #121    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #122    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #123    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #124    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #125    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #126    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #127    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #128    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #129    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #130    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #131    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #132    SingleChildRenderObjectElement.mount (package:flutter/src/widgets/framework.dart:7128:14)
E/flutter (15454): #133    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #134    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #135    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #136    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #137    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #138    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #139    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #140    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #141    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #142    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #143    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #144    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #145    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #146    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #147    SingleChildRenderObjectElement.mount (package:flutter/src/widgets/framework.dart:7128:14)
E/flutter (15454): #148    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #149    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #150    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #151    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #152    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #153    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #154    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #155    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #156    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #157    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #158    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #159    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #160    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #161    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #162    SingleChildRenderObjectElement.mount (package:flutter/src/widgets/framework.dart:7128:14)
E/flutter (15454): #163    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #164    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #165    SingleChildRenderObjectElement.mount (package:flutter/src/widgets/framework.dart:7128:14)
E/flutter (15454): #166    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #167    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #168    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #169    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (15454): #170    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #171    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #172    StatefulElement._firstBuild (package:flutter/src/widgets/framework.dart:5986:11)
E/flutter (15454): #173    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #174    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #175    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #176    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #177    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (15454): #178    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #179    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #180    StatefulElement._firstBuild (package:flutter/src/widgets/framework.dart:5986:11)
E/flutter (15454): #181    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #182    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #183    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #184    SingleChildRenderObjectElement.mount (package:flutter/src/widgets/framework.dart:7128:14)
E/flutter (15454): #185    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #186    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #187    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #188    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #189    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #190    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #191    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #192    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #193    SingleChildRenderObjectElement.mount (package:flutter/src/widgets/framework.dart:7128:14)
E/flutter (15454): #194    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #195    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #196    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #197    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (15454): #198    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #199    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #200    StatefulElement._firstBuild (package:flutter/src/widgets/framework.dart:5986:11)
E/flutter (15454): #201    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #202    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #203    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #204    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #205    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #206    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #207    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #208    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #209    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #210    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #211    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #212    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #213    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #214    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #215    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #216    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #217    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (15454): #218    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #219    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #220    StatefulElement._firstBuild (package:flutter/src/widgets/framework.dart:5986:11)
E/flutter (15454): #221    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #222    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #223    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #224    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #225    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #226    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #227    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #228    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #229    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #230    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #231    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #232    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #233    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #234    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #235    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #236    SingleChildRenderObjectElement.mount (package:flutter/src/widgets/framework.dart:7128:14)
E/flutter (15454): #237    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #238    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #239    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #240    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #241    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #242    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #243    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #244    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #245    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #246    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #247    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #248    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #249    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #250    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #251    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #252    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (15454): #253    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #254    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #255    StatefulElement._firstBuild (package:flutter/src/widgets/framework.dart:5986:11)
E/flutter (15454): #256    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #257    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #258    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #259    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #260    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (15454): #261    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #262    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #263    StatefulElement._firstBuild (package:flutter/src/widgets/framework.dart:5986:11)
E/flutter (15454): #264    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #265    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #266    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #267    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #268    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (15454): #269    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #270    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #271    StatefulElement._firstBuild (package:flutter/src/widgets/framework.dart:5986:11)
E/flutter (15454): #272    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #273    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #274    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #275    SingleChildRenderObjectElement.mount (package:flutter/src/widgets/framework.dart:7128:14)
E/flutter (15454): #276    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #277    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #278    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #279    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #280    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #281    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #282    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #283    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #284    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #285    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #286    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #287    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #288    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #289    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #290    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #291    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #292    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #293    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #294    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #295    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #296    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #297    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (15454): #298    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #299    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #300    StatefulElement._firstBuild (package:flutter/src/widgets/framework.dart:5986:11)
E/flutter (15454): #301    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #302    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #303    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #304    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #305    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (15454): #306    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #307    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #308    StatefulElement._firstBuild (package:flutter/src/widgets/framework.dart:5986:11)
E/flutter (15454): #309    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #310    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #311    MultiChildRenderObjectElement.inflateWidget (package:flutter/src/widgets/framework.dart:7277:36)
E/flutter (15454): #312    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #313    Element.updateChildren (package:flutter/src/widgets/framework.dart:4268:32)
E/flutter (15454): #314    MultiChildRenderObjectElement.update (package:flutter/src/widgets/framework.dart:7308:17)
E/flutter (15454): #315    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
E/flutter (15454): #316    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #317    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (15454): #318    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #319    StatefulElement.update (package:flutter/src/widgets/framework.dart:6020:5)
E/flutter (15454): #320    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
E/flutter (15454): #321    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #322    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #323    ProxyElement.update (package:flutter/src/widgets/framework.dart:6162:5)
E/flutter (15454): #324    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
E/flutter (15454): #325    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #326    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #327    ProxyElement.update (package:flutter/src/widgets/framework.dart:6162:5)
E/flutter (15454): #328    _InheritedNotifierElement.update (package:flutter/src/widgets/inherited_notifier.dart:108:11)
E/flutter (15454): #329    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
E/flutter (15454): #330    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #331    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (15454): #332    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #333    StatefulElement.update (package:flutter/src/widgets/framework.dart:6020:5)
E/flutter (15454): #334    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
E/flutter (15454): #335    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #336    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #337    ProxyElement.update (package:flutter/src/widgets/framework.dart:6162:5)
E/flutter (15454): #338    _InheritedNotifierElement.update (package:flutter/src/widgets/inherited_notifier.dart:108:11)
E/flutter (15454): #339    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
E/flutter (15454): #340    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #341    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (15454): #342    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #343    StatefulElement.update (package:flutter/src/widgets/framework.dart:6020:5)
E/flutter (15454): #344    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
E/flutter (15454): #345    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #346    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (15454): #347    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #348    StatefulElement.update (package:flutter/src/widgets/framework.dart:6020:5)
E/flutter (15454): #349    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
E/flutter (15454): #350    SingleChildRenderObjectElement.update (package:flutter/src/widgets/framework.dart:7135:14)
E/flutter (15454): #351    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
E/flutter (15454): #352    SingleChildRenderObjectElement.update (package:flutter/src/widgets/framework.dart:7135:14)
E/flutter (15454): #353    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
E/flutter (15454): #354    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #355    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #356    ProxyElement.update (package:flutter/src/widgets/framework.dart:6162:5)
E/flutter (15454): #357    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
E/flutter (15454): #358    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #359    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #360    ProxyElement.update (package:flutter/src/widgets/framework.dart:6162:5)
E/flutter (15454): #361    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
E/flutter (15454): #362    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #363    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (15454): #364    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #365    BuildScope._tryRebuild (package:flutter/src/widgets/framework.dart:2763:15)
E/flutter (15454): #366    BuildScope._flushDirtyElements (package:flutter/src/widgets/framework.dart:2820:11)
E/flutter (15454): #367    BuildOwner.buildScope (package:flutter/src/widgets/framework.dart:3124:18)
E/flutter (15454): #368    WidgetsBinding.drawFrame (package:flutter/src/widgets/binding.dart:1571:21)
E/flutter (15454): #369    RendererBinding._handlePersistentFrameCallback (package:flutter/src/rendering/binding.dart:558:5)
E/flutter (15454): #370    SchedulerBinding._invokeFrameCallback (package:flutter/src/scheduler/binding.dart:1430:15)
E/flutter (15454): #371    SchedulerBinding.handleDrawFrame (package:flutter/src/scheduler/binding.dart:1345:9)
E/flutter (15454): #372    SchedulerBinding._handleDrawFrame (package:flutter/src/scheduler/binding.dart:1198:5)
E/flutter (15454): #373    _invoke (dart:ui/hooks.dart:441:13)
E/flutter (15454): #374    PlatformDispatcher._drawFrame (dart:ui/platform_dispatcher.dart:450:5)
E/flutter (15454): #375    _drawFrame (dart:ui/hooks.dart:413:31)
E/flutter (15454):
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
E/flutter (15454): [ERROR:flutter/runtime/dart_vm_initializer.cc(40)] Unhandled Exception: PostgrestException(message: column rooms.subject_count does not exist, code: 42703, details: Bad Request, hint: null)
E/flutter (15454): #0      PostgrestBuilder._parseResponse (package:postgrest/src/postgrest_builder.dart:584:5)
E/flutter (15454): #1      PostgrestBuilder._execute (package:postgrest/src/postgrest_builder.dart:412:18)
E/flutter (15454): <asynchronous suspension>
E/flutter (15454): <asynchronous suspension>
E/flutter (15454):
E/flutter (15454): <async call site>
E/flutter (15454): #0      PostgrestBuilder.then (package:postgrest/src/postgrest_builder.dart:694:36)
E/flutter (15454): #1      _HierarchyPickerSheetState._loadRooms (package:shelf/core/widgets/hierarchy_picker_sheet.dart:57:18)
E/flutter (15454): #2      _HierarchyPickerSheetState.initState (package:shelf/core/widgets/hierarchy_picker_sheet.dart:53:5)
E/flutter (15454): #3      StatefulElement._firstBuild (package:flutter/src/widgets/framework.dart:5963:55)
E/flutter (15454): #4      ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #5      Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #6      Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #7      ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #8      Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #9      ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #10     ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #11     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #12     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #13     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #14     Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #15     ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #16     ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #17     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #18     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #19     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #20     StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (15454): #21     Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #22     ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #23     StatefulElement._firstBuild (package:flutter/src/widgets/framework.dart:5986:11)
E/flutter (15454): #24     ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #25     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #26     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #27     SingleChildRenderObjectElement.mount (package:flutter/src/widgets/framework.dart:7128:14)
E/flutter (15454): #28     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #29     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #30     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #31     Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #32     ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #33     ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #34     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #35     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #36     SingleChildRenderObjectElement.mount (package:flutter/src/widgets/framework.dart:7128:14)
E/flutter (15454): #37     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #38     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #39     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #40     Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #41     ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #42     ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #43     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #44     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #45     SingleChildRenderObjectElement.mount (package:flutter/src/widgets/framework.dart:7128:14)
E/flutter (15454): #46     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #47     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #48     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #49     StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (15454): #50     Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #51     ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #52     StatefulElement._firstBuild (package:flutter/src/widgets/framework.dart:5986:11)
E/flutter (15454): #53     ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #54     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #55     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #56     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #57     StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (15454): #58     Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #59     ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #60     StatefulElement._firstBuild (package:flutter/src/widgets/framework.dart:5986:11)
E/flutter (15454): #61     ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #62     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #63     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #64     SingleChildRenderObjectElement.mount (package:flutter/src/widgets/framework.dart:7128:14)
E/flutter (15454): #65     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #66     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #67     SingleChildRenderObjectElement.mount (package:flutter/src/widgets/framework.dart:7128:14)
E/flutter (15454): #68     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #69     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #70     SingleChildRenderObjectElement.mount (package:flutter/src/widgets/framework.dart:7128:14)
E/flutter (15454): #71     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #72     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #73     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #74     StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (15454): #75     Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #76     ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #77     StatefulElement._firstBuild (package:flutter/src/widgets/framework.dart:5986:11)
E/flutter (15454): #78     ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #79     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #80     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #81     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #82     Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #83     ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #84     ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #85     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #86     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #87     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #88     StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (15454): #89     Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #90     ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #91     StatefulElement._firstBuild (package:flutter/src/widgets/framework.dart:5986:11)
E/flutter (15454): #92     ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #93     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #94     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #95     SingleChildRenderObjectElement.mount (package:flutter/src/widgets/framework.dart:7128:14)
E/flutter (15454): #96     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #97     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #98     SingleChildRenderObjectElement.mount (package:flutter/src/widgets/framework.dart:7128:14)
E/flutter (15454): #99     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #100    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #101    SingleChildRenderObjectElement.mount (package:flutter/src/widgets/framework.dart:7128:14)
E/flutter (15454): #102    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #103    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #104    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #105    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (15454): #106    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #107    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #108    StatefulElement._firstBuild (package:flutter/src/widgets/framework.dart:5986:11)
E/flutter (15454): #109    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #110    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #111    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #112    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #113    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (15454): #114    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #115    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #116    StatefulElement._firstBuild (package:flutter/src/widgets/framework.dart:5986:11)
E/flutter (15454): #117    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #118    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #119    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #120    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #121    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #122    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #123    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #124    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #125    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #126    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #127    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #128    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #129    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #130    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #131    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #132    SingleChildRenderObjectElement.mount (package:flutter/src/widgets/framework.dart:7128:14)
E/flutter (15454): #133    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #134    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #135    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #136    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #137    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #138    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #139    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #140    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #141    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #142    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #143    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #144    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #145    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #146    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #147    SingleChildRenderObjectElement.mount (package:flutter/src/widgets/framework.dart:7128:14)
E/flutter (15454): #148    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #149    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #150    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #151    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #152    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #153    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #154    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #155    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #156    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #157    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #158    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #159    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #160    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #161    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #162    SingleChildRenderObjectElement.mount (package:flutter/src/widgets/framework.dart:7128:14)
E/flutter (15454): #163    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #164    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #165    SingleChildRenderObjectElement.mount (package:flutter/src/widgets/framework.dart:7128:14)
E/flutter (15454): #166    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #167    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #168    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #169    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (15454): #170    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #171    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #172    StatefulElement._firstBuild (package:flutter/src/widgets/framework.dart:5986:11)
E/flutter (15454): #173    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #174    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #175    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #176    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #177    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (15454): #178    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #179    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #180    StatefulElement._firstBuild (package:flutter/src/widgets/framework.dart:5986:11)
E/flutter (15454): #181    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #182    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #183    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #184    SingleChildRenderObjectElement.mount (package:flutter/src/widgets/framework.dart:7128:14)
E/flutter (15454): #185    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #186    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #187    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #188    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #189    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #190    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #191    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #192    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #193    SingleChildRenderObjectElement.mount (package:flutter/src/widgets/framework.dart:7128:14)
E/flutter (15454): #194    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #195    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #196    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #197    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (15454): #198    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #199    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #200    StatefulElement._firstBuild (package:flutter/src/widgets/framework.dart:5986:11)
E/flutter (15454): #201    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #202    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #203    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #204    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #205    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #206    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #207    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #208    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #209    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #210    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #211    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #212    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #213    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #214    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #215    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #216    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #217    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (15454): #218    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #219    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #220    StatefulElement._firstBuild (package:flutter/src/widgets/framework.dart:5986:11)
E/flutter (15454): #221    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #222    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #223    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #224    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #225    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #226    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #227    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #228    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #229    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #230    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #231    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #232    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #233    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #234    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #235    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #236    SingleChildRenderObjectElement.mount (package:flutter/src/widgets/framework.dart:7128:14)
E/flutter (15454): #237    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #238    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #239    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #240    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #241    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #242    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #243    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #244    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #245    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #246    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #247    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #248    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #249    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #250    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #251    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #252    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (15454): #253    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #254    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #255    StatefulElement._firstBuild (package:flutter/src/widgets/framework.dart:5986:11)
E/flutter (15454): #256    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #257    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #258    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #259    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #260    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (15454): #261    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #262    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #263    StatefulElement._firstBuild (package:flutter/src/widgets/framework.dart:5986:11)
E/flutter (15454): #264    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #265    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #266    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #267    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #268    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (15454): #269    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #270    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #271    StatefulElement._firstBuild (package:flutter/src/widgets/framework.dart:5986:11)
E/flutter (15454): #272    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #273    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #274    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #275    SingleChildRenderObjectElement.mount (package:flutter/src/widgets/framework.dart:7128:14)
E/flutter (15454): #276    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #277    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #278    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #279    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #280    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #281    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #282    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #283    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #284    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #285    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #286    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #287    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #288    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #289    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #290    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #291    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #292    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #293    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #294    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #295    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #296    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #297    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (15454): #298    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #299    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #300    StatefulElement._firstBuild (package:flutter/src/widgets/framework.dart:5986:11)
E/flutter (15454): #301    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #302    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #303    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #304    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #305    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (15454): #306    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #307    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #308    StatefulElement._firstBuild (package:flutter/src/widgets/framework.dart:5986:11)
E/flutter (15454): #309    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #310    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #311    MultiChildRenderObjectElement.inflateWidget (package:flutter/src/widgets/framework.dart:7277:36)
E/flutter (15454): #312    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #313    Element.updateChildren (package:flutter/src/widgets/framework.dart:4268:32)
E/flutter (15454): #314    MultiChildRenderObjectElement.update (package:flutter/src/widgets/framework.dart:7308:17)
E/flutter (15454): #315    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
E/flutter (15454): #316    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #317    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (15454): #318    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #319    StatefulElement.update (package:flutter/src/widgets/framework.dart:6020:5)
E/flutter (15454): #320    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
E/flutter (15454): #321    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #322    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #323    ProxyElement.update (package:flutter/src/widgets/framework.dart:6162:5)
E/flutter (15454): #324    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
E/flutter (15454): #325    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #326    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #327    ProxyElement.update (package:flutter/src/widgets/framework.dart:6162:5)
E/flutter (15454): #328    _InheritedNotifierElement.update (package:flutter/src/widgets/inherited_notifier.dart:108:11)
E/flutter (15454): #329    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
E/flutter (15454): #330    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #331    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (15454): #332    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #333    StatefulElement.update (package:flutter/src/widgets/framework.dart:6020:5)
E/flutter (15454): #334    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
E/flutter (15454): #335    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #336    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #337    ProxyElement.update (package:flutter/src/widgets/framework.dart:6162:5)
E/flutter (15454): #338    _InheritedNotifierElement.update (package:flutter/src/widgets/inherited_notifier.dart:108:11)
E/flutter (15454): #339    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
E/flutter (15454): #340    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #341    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (15454): #342    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #343    StatefulElement.update (package:flutter/src/widgets/framework.dart:6020:5)
E/flutter (15454): #344    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
E/flutter (15454): #345    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #346    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (15454): #347    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #348    StatefulElement.update (package:flutter/src/widgets/framework.dart:6020:5)
E/flutter (15454): #349    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
E/flutter (15454): #350    SingleChildRenderObjectElement.update (package:flutter/src/widgets/framework.dart:7135:14)
E/flutter (15454): #351    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
E/flutter (15454): #352    SingleChildRenderObjectElement.update (package:flutter/src/widgets/framework.dart:7135:14)
E/flutter (15454): #353    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
E/flutter (15454): #354    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #355    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #356    ProxyElement.update (package:flutter/src/widgets/framework.dart:6162:5)
E/flutter (15454): #357    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
E/flutter (15454): #358    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #359    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #360    ProxyElement.update (package:flutter/src/widgets/framework.dart:6162:5)
E/flutter (15454): #361    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
E/flutter (15454): #362    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #363    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (15454): #364    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #365    BuildScope._tryRebuild (package:flutter/src/widgets/framework.dart:2763:15)
E/flutter (15454): #366    BuildScope._flushDirtyElements (package:flutter/src/widgets/framework.dart:2820:11)
E/flutter (15454): #367    BuildOwner.buildScope (package:flutter/src/widgets/framework.dart:3124:18)
E/flutter (15454): #368    WidgetsBinding.drawFrame (package:flutter/src/widgets/binding.dart:1571:21)
E/flutter (15454): #369    RendererBinding._handlePersistentFrameCallback (package:flutter/src/rendering/binding.dart:558:5)
E/flutter (15454): #370    SchedulerBinding._invokeFrameCallback (package:flutter/src/scheduler/binding.dart:1430:15)
E/flutter (15454): #371    SchedulerBinding.handleDrawFrame (package:flutter/src/scheduler/binding.dart:1345:9)
E/flutter (15454): #372    SchedulerBinding._handleDrawFrame (package:flutter/src/scheduler/binding.dart:1198:5)
E/flutter (15454): #373    _invoke (dart:ui/hooks.dart:441:13)
E/flutter (15454): #374    PlatformDispatcher._drawFrame (dart:ui/platform_dispatcher.dart:450:5)
E/flutter (15454): #375    _drawFrame (dart:ui/hooks.dart:413:31)
E/flutter (15454):
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
E/flutter (15454): [ERROR:flutter/runtime/dart_vm_initializer.cc(40)] Unhandled Exception: PostgrestException(message: column rooms.subject_count does not exist, code: 42703, details: Bad Request, hint: null)
E/flutter (15454): #0      PostgrestBuilder._parseResponse (package:postgrest/src/postgrest_builder.dart:584:5)
E/flutter (15454): #1      PostgrestBuilder._execute (package:postgrest/src/postgrest_builder.dart:412:18)
E/flutter (15454): <asynchronous suspension>
E/flutter (15454): <asynchronous suspension>
E/flutter (15454):
E/flutter (15454): <async call site>
E/flutter (15454): #0      PostgrestBuilder.then (package:postgrest/src/postgrest_builder.dart:694:36)
E/flutter (15454): #1      _HierarchyPickerSheetState._loadRooms (package:shelf/core/widgets/hierarchy_picker_sheet.dart:57:18)
E/flutter (15454): #2      _HierarchyPickerSheetState.initState (package:shelf/core/widgets/hierarchy_picker_sheet.dart:53:5)
E/flutter (15454): #3      StatefulElement._firstBuild (package:flutter/src/widgets/framework.dart:5963:55)
E/flutter (15454): #4      ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #5      Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #6      Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #7      ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #8      Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #9      ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #10     ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #11     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #12     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #13     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #14     Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #15     ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #16     ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #17     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #18     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #19     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #20     StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (15454): #21     Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #22     ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #23     StatefulElement._firstBuild (package:flutter/src/widgets/framework.dart:5986:11)
E/flutter (15454): #24     ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #25     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #26     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #27     SingleChildRenderObjectElement.mount (package:flutter/src/widgets/framework.dart:7128:14)
E/flutter (15454): #28     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #29     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #30     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #31     Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #32     ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #33     ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #34     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #35     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #36     SingleChildRenderObjectElement.mount (package:flutter/src/widgets/framework.dart:7128:14)
E/flutter (15454): #37     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #38     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #39     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #40     Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #41     ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #42     ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #43     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #44     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #45     SingleChildRenderObjectElement.mount (package:flutter/src/widgets/framework.dart:7128:14)
E/flutter (15454): #46     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #47     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #48     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #49     StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (15454): #50     Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #51     ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #52     StatefulElement._firstBuild (package:flutter/src/widgets/framework.dart:5986:11)
E/flutter (15454): #53     ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #54     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #55     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #56     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #57     StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (15454): #58     Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #59     ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #60     StatefulElement._firstBuild (package:flutter/src/widgets/framework.dart:5986:11)
E/flutter (15454): #61     ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #62     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #63     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #64     SingleChildRenderObjectElement.mount (package:flutter/src/widgets/framework.dart:7128:14)
E/flutter (15454): #65     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #66     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #67     SingleChildRenderObjectElement.mount (package:flutter/src/widgets/framework.dart:7128:14)
E/flutter (15454): #68     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #69     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #70     SingleChildRenderObjectElement.mount (package:flutter/src/widgets/framework.dart:7128:14)
E/flutter (15454): #71     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #72     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #73     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #74     StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (15454): #75     Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #76     ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #77     StatefulElement._firstBuild (package:flutter/src/widgets/framework.dart:5986:11)
E/flutter (15454): #78     ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #79     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #80     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #81     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #82     Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #83     ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #84     ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #85     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #86     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #87     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #88     StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (15454): #89     Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #90     ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #91     StatefulElement._firstBuild (package:flutter/src/widgets/framework.dart:5986:11)
E/flutter (15454): #92     ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #93     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #94     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #95     SingleChildRenderObjectElement.mount (package:flutter/src/widgets/framework.dart:7128:14)
E/flutter (15454): #96     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #97     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #98     SingleChildRenderObjectElement.mount (package:flutter/src/widgets/framework.dart:7128:14)
E/flutter (15454): #99     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #100    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #101    SingleChildRenderObjectElement.mount (package:flutter/src/widgets/framework.dart:7128:14)
E/flutter (15454): #102    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #103    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #104    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #105    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (15454): #106    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #107    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #108    StatefulElement._firstBuild (package:flutter/src/widgets/framework.dart:5986:11)
E/flutter (15454): #109    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #110    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #111    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #112    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #113    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (15454): #114    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #115    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #116    StatefulElement._firstBuild (package:flutter/src/widgets/framework.dart:5986:11)
E/flutter (15454): #117    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #118    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #119    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #120    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #121    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #122    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #123    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #124    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #125    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #126    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #127    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #128    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #129    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #130    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #131    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #132    SingleChildRenderObjectElement.mount (package:flutter/src/widgets/framework.dart:7128:14)
E/flutter (15454): #133    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #134    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #135    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #136    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #137    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #138    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #139    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #140    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #141    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #142    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #143    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #144    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #145    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #146    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #147    SingleChildRenderObjectElement.mount (package:flutter/src/widgets/framework.dart:7128:14)
E/flutter (15454): #148    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #149    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #150    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #151    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #152    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #153    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #154    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #155    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #156    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #157    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #158    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #159    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #160    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #161    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #162    SingleChildRenderObjectElement.mount (package:flutter/src/widgets/framework.dart:7128:14)
E/flutter (15454): #163    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #164    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #165    SingleChildRenderObjectElement.mount (package:flutter/src/widgets/framework.dart:7128:14)
E/flutter (15454): #166    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #167    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #168    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #169    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (15454): #170    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #171    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #172    StatefulElement._firstBuild (package:flutter/src/widgets/framework.dart:5986:11)
E/flutter (15454): #173    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #174    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #175    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #176    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #177    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (15454): #178    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #179    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #180    StatefulElement._firstBuild (package:flutter/src/widgets/framework.dart:5986:11)
E/flutter (15454): #181    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #182    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #183    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #184    SingleChildRenderObjectElement.mount (package:flutter/src/widgets/framework.dart:7128:14)
E/flutter (15454): #185    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #186    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #187    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #188    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #189    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #190    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #191    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #192    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #193    SingleChildRenderObjectElement.mount (package:flutter/src/widgets/framework.dart:7128:14)
E/flutter (15454): #194    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #195    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #196    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #197    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (15454): #198    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #199    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #200    StatefulElement._firstBuild (package:flutter/src/widgets/framework.dart:5986:11)
E/flutter (15454): #201    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #202    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #203    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #204    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #205    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #206    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #207    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #208    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #209    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #210    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #211    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #212    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #213    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #214    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #215    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #216    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #217    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (15454): #218    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #219    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #220    StatefulElement._firstBuild (package:flutter/src/widgets/framework.dart:5986:11)
E/flutter (15454): #221    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #222    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #223    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #224    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #225    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #226    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #227    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #228    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #229    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #230    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #231    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #232    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #233    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #234    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #235    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #236    SingleChildRenderObjectElement.mount (package:flutter/src/widgets/framework.dart:7128:14)
E/flutter (15454): #237    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #238    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #239    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #240    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #241    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #242    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #243    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #244    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #245    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #246    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #247    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #248    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #249    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #250    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #251    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #252    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (15454): #253    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #254    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #255    StatefulElement._firstBuild (package:flutter/src/widgets/framework.dart:5986:11)
E/flutter (15454): #256    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #257    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #258    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #259    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #260    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (15454): #261    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #262    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #263    StatefulElement._firstBuild (package:flutter/src/widgets/framework.dart:5986:11)
E/flutter (15454): #264    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #265    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #266    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #267    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #268    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (15454): #269    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #270    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #271    StatefulElement._firstBuild (package:flutter/src/widgets/framework.dart:5986:11)
E/flutter (15454): #272    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #273    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #274    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #275    SingleChildRenderObjectElement.mount (package:flutter/src/widgets/framework.dart:7128:14)
E/flutter (15454): #276    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #277    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #278    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #279    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #280    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #281    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #282    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #283    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #284    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #285    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #286    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #287    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #288    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #289    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #290    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #291    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #292    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #293    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #294    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #295    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #296    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #297    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (15454): #298    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #299    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #300    StatefulElement._firstBuild (package:flutter/src/widgets/framework.dart:5986:11)
E/flutter (15454): #301    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #302    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #303    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #304    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #305    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (15454): #306    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #307    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #308    StatefulElement._firstBuild (package:flutter/src/widgets/framework.dart:5986:11)
E/flutter (15454): #309    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #310    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #311    MultiChildRenderObjectElement.inflateWidget (package:flutter/src/widgets/framework.dart:7277:36)
E/flutter (15454): #312    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #313    Element.updateChildren (package:flutter/src/widgets/framework.dart:4268:32)
E/flutter (15454): #314    MultiChildRenderObjectElement.update (package:flutter/src/widgets/framework.dart:7308:17)
E/flutter (15454): #315    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
E/flutter (15454): #316    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #317    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (15454): #318    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #319    StatefulElement.update (package:flutter/src/widgets/framework.dart:6020:5)
E/flutter (15454): #320    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
E/flutter (15454): #321    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #322    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #323    ProxyElement.update (package:flutter/src/widgets/framework.dart:6162:5)
E/flutter (15454): #324    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
E/flutter (15454): #325    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #326    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #327    ProxyElement.update (package:flutter/src/widgets/framework.dart:6162:5)
E/flutter (15454): #328    _InheritedNotifierElement.update (package:flutter/src/widgets/inherited_notifier.dart:108:11)
E/flutter (15454): #329    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
E/flutter (15454): #330    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #331    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (15454): #332    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #333    StatefulElement.update (package:flutter/src/widgets/framework.dart:6020:5)
E/flutter (15454): #334    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
E/flutter (15454): #335    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #336    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #337    ProxyElement.update (package:flutter/src/widgets/framework.dart:6162:5)
E/flutter (15454): #338    _InheritedNotifierElement.update (package:flutter/src/widgets/inherited_notifier.dart:108:11)
E/flutter (15454): #339    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
E/flutter (15454): #340    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #341    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (15454): #342    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #343    StatefulElement.update (package:flutter/src/widgets/framework.dart:6020:5)
E/flutter (15454): #344    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
E/flutter (15454): #345    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #346    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (15454): #347    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #348    StatefulElement.update (package:flutter/src/widgets/framework.dart:6020:5)
E/flutter (15454): #349    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
E/flutter (15454): #350    SingleChildRenderObjectElement.update (package:flutter/src/widgets/framework.dart:7135:14)
E/flutter (15454): #351    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
E/flutter (15454): #352    SingleChildRenderObjectElement.update (package:flutter/src/widgets/framework.dart:7135:14)
E/flutter (15454): #353    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
E/flutter (15454): #354    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #355    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #356    ProxyElement.update (package:flutter/src/widgets/framework.dart:6162:5)
E/flutter (15454): #357    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
E/flutter (15454): #358    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #359    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #360    ProxyElement.update (package:flutter/src/widgets/framework.dart:6162:5)
E/flutter (15454): #361    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
E/flutter (15454): #362    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #363    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (15454): #364    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #365    BuildScope._tryRebuild (package:flutter/src/widgets/framework.dart:2763:15)
E/flutter (15454): #366    BuildScope._flushDirtyElements (package:flutter/src/widgets/framework.dart:2820:11)
E/flutter (15454): #367    BuildOwner.buildScope (package:flutter/src/widgets/framework.dart:3124:18)
E/flutter (15454): #368    WidgetsBinding.drawFrame (package:flutter/src/widgets/binding.dart:1571:21)
E/flutter (15454): #369    RendererBinding._handlePersistentFrameCallback (package:flutter/src/rendering/binding.dart:558:5)
E/flutter (15454): #370    SchedulerBinding._invokeFrameCallback (package:flutter/src/scheduler/binding.dart:1430:15)
E/flutter (15454): #371    SchedulerBinding.handleDrawFrame (package:flutter/src/scheduler/binding.dart:1345:9)
E/flutter (15454): #372    SchedulerBinding._handleDrawFrame (package:flutter/src/scheduler/binding.dart:1198:5)
E/flutter (15454): #373    _invoke (dart:ui/hooks.dart:441:13)
E/flutter (15454): #374    PlatformDispatcher._drawFrame (dart:ui/platform_dispatcher.dart:450:5)
E/flutter (15454): #375    _drawFrame (dart:ui/hooks.dart:413:31)
E/flutter (15454):
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
D/FlutterJNI(15454): Sending viewport metrics to the engine.
E/flutter (15454): [ERROR:flutter/runtime/dart_vm_initializer.cc(40)] Unhandled Exception: PostgrestException(message: column rooms.subject_count does not exist, code: 42703, details: Bad Request, hint: null)
E/flutter (15454): #0      PostgrestBuilder._parseResponse (package:postgrest/src/postgrest_builder.dart:584:5)
E/flutter (15454): #1      PostgrestBuilder._execute (package:postgrest/src/postgrest_builder.dart:412:18)
E/flutter (15454): <asynchronous suspension>
E/flutter (15454): <asynchronous suspension>
E/flutter (15454):
E/flutter (15454): <async call site>
E/flutter (15454): #0      PostgrestBuilder.then (package:postgrest/src/postgrest_builder.dart:694:36)
E/flutter (15454): #1      _HierarchyPickerSheetState._loadRooms (package:shelf/core/widgets/hierarchy_picker_sheet.dart:57:18)
E/flutter (15454): #2      _HierarchyPickerSheetState.initState (package:shelf/core/widgets/hierarchy_picker_sheet.dart:53:5)
E/flutter (15454): #3      StatefulElement._firstBuild (package:flutter/src/widgets/framework.dart:5963:55)
E/flutter (15454): #4      ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #5      Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #6      Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #7      ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #8      Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #9      ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #10     ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #11     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #12     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #13     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #14     Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #15     ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #16     ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #17     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #18     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #19     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #20     StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (15454): #21     Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #22     ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #23     StatefulElement._firstBuild (package:flutter/src/widgets/framework.dart:5986:11)
E/flutter (15454): #24     ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #25     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #26     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #27     SingleChildRenderObjectElement.mount (package:flutter/src/widgets/framework.dart:7128:14)
E/flutter (15454): #28     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #29     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #30     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #31     Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #32     ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #33     ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #34     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #35     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #36     SingleChildRenderObjectElement.mount (package:flutter/src/widgets/framework.dart:7128:14)
E/flutter (15454): #37     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #38     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #39     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #40     Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #41     ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #42     ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #43     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #44     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #45     SingleChildRenderObjectElement.mount (package:flutter/src/widgets/framework.dart:7128:14)
E/flutter (15454): #46     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #47     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #48     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #49     StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (15454): #50     Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #51     ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #52     StatefulElement._firstBuild (package:flutter/src/widgets/framework.dart:5986:11)
E/flutter (15454): #53     ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #54     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #55     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #56     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #57     StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (15454): #58     Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #59     ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #60     StatefulElement._firstBuild (package:flutter/src/widgets/framework.dart:5986:11)
E/flutter (15454): #61     ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #62     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #63     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #64     SingleChildRenderObjectElement.mount (package:flutter/src/widgets/framework.dart:7128:14)
E/flutter (15454): #65     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #66     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #67     SingleChildRenderObjectElement.mount (package:flutter/src/widgets/framework.dart:7128:14)
E/flutter (15454): #68     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #69     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #70     SingleChildRenderObjectElement.mount (package:flutter/src/widgets/framework.dart:7128:14)
E/flutter (15454): #71     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #72     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #73     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #74     StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (15454): #75     Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #76     ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #77     StatefulElement._firstBuild (package:flutter/src/widgets/framework.dart:5986:11)
E/flutter (15454): #78     ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #79     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #80     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #81     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #82     Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #83     ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #84     ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #85     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #86     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #87     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #88     StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (15454): #89     Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #90     ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #91     StatefulElement._firstBuild (package:flutter/src/widgets/framework.dart:5986:11)
E/flutter (15454): #92     ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #93     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #94     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #95     SingleChildRenderObjectElement.mount (package:flutter/src/widgets/framework.dart:7128:14)
E/flutter (15454): #96     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #97     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #98     SingleChildRenderObjectElement.mount (package:flutter/src/widgets/framework.dart:7128:14)
E/flutter (15454): #99     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #100    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #101    SingleChildRenderObjectElement.mount (package:flutter/src/widgets/framework.dart:7128:14)
E/flutter (15454): #102    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #103    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #104    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #105    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (15454): #106    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #107    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #108    StatefulElement._firstBuild (package:flutter/src/widgets/framework.dart:5986:11)
E/flutter (15454): #109    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #110    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #111    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #112    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #113    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (15454): #114    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #115    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #116    StatefulElement._firstBuild (package:flutter/src/widgets/framework.dart:5986:11)
E/flutter (15454): #117    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #118    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #119    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #120    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #121    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #122    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #123    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #124    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #125    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #126    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #127    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #128    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #129    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #130    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #131    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #132    SingleChildRenderObjectElement.mount (package:flutter/src/widgets/framework.dart:7128:14)
E/flutter (15454): #133    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #134    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #135    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #136    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #137    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #138    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #139    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #140    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #141    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #142    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #143    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #144    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #145    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #146    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #147    SingleChildRenderObjectElement.mount (package:flutter/src/widgets/framework.dart:7128:14)
E/flutter (15454): #148    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #149    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #150    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #151    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #152    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #153    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #154    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #155    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #156    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #157    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #158    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #159    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #160    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #161    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #162    SingleChildRenderObjectElement.mount (package:flutter/src/widgets/framework.dart:7128:14)
E/flutter (15454): #163    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #164    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #165    SingleChildRenderObjectElement.mount (package:flutter/src/widgets/framework.dart:7128:14)
E/flutter (15454): #166    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #167    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #168    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #169    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (15454): #170    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #171    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #172    StatefulElement._firstBuild (package:flutter/src/widgets/framework.dart:5986:11)
E/flutter (15454): #173    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #174    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #175    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #176    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #177    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (15454): #178    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #179    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #180    StatefulElement._firstBuild (package:flutter/src/widgets/framework.dart:5986:11)
E/flutter (15454): #181    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #182    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #183    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #184    SingleChildRenderObjectElement.mount (package:flutter/src/widgets/framework.dart:7128:14)
E/flutter (15454): #185    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #186    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #187    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #188    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #189    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #190    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #191    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #192    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #193    SingleChildRenderObjectElement.mount (package:flutter/src/widgets/framework.dart:7128:14)
E/flutter (15454): #194    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #195    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #196    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #197    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (15454): #198    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #199    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #200    StatefulElement._firstBuild (package:flutter/src/widgets/framework.dart:5986:11)
E/flutter (15454): #201    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #202    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #203    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #204    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #205    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #206    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #207    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #208    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #209    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #210    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #211    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #212    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #213    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #214    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #215    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #216    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #217    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (15454): #218    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #219    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #220    StatefulElement._firstBuild (package:flutter/src/widgets/framework.dart:5986:11)
E/flutter (15454): #221    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #222    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #223    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #224    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #225    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #226    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #227    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #228    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #229    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #230    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #231    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #232    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #233    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #234    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #235    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #236    SingleChildRenderObjectElement.mount (package:flutter/src/widgets/framework.dart:7128:14)
E/flutter (15454): #237    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #238    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #239    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #240    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #241    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #242    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #243    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #244    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #245    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #246    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #247    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #248    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #249    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #250    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #251    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #252    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (15454): #253    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #254    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #255    StatefulElement._firstBuild (package:flutter/src/widgets/framework.dart:5986:11)
E/flutter (15454): #256    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #257    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #258    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #259    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #260    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (15454): #261    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #262    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #263    StatefulElement._firstBuild (package:flutter/src/widgets/framework.dart:5986:11)
E/flutter (15454): #264    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #265    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #266    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #267    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #268    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (15454): #269    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #270    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #271    StatefulElement._firstBuild (package:flutter/src/widgets/framework.dart:5986:11)
E/flutter (15454): #272    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #273    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #274    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #275    SingleChildRenderObjectElement.mount (package:flutter/src/widgets/framework.dart:7128:14)
E/flutter (15454): #276    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #277    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #278    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #279    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #280    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #281    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #282    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #283    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #284    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #285    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #286    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #287    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #288    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #289    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #290    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #291    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #292    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #293    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #294    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #295    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #296    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #297    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (15454): #298    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #299    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #300    StatefulElement._firstBuild (package:flutter/src/widgets/framework.dart:5986:11)
E/flutter (15454): #301    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #302    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #303    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #304    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #305    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (15454): #306    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #307    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (15454): #308    StatefulElement._firstBuild (package:flutter/src/widgets/framework.dart:5986:11)
E/flutter (15454): #309    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (15454): #310    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (15454): #311    MultiChildRenderObjectElement.inflateWidget (package:flutter/src/widgets/framework.dart:7277:36)
E/flutter (15454): #312    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (15454): #313    Element.updateChildren (package:flutter/src/widgets/framework.dart:4268:32)
E/flutter (15454): #314    MultiChildRenderObjectElement.update (package:flutter/src/widgets/framework.dart:7308:17)
E/flutter (15454): #315    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
E/flutter (15454): #316    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #317    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (15454): #318    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #319    StatefulElement.update (package:flutter/src/widgets/framework.dart:6020:5)
E/flutter (15454): #320    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
E/flutter (15454): #321    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #322    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #323    ProxyElement.update (package:flutter/src/widgets/framework.dart:6162:5)
E/flutter (15454): #324    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
E/flutter (15454): #325    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #326    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #327    ProxyElement.update (package:flutter/src/widgets/framework.dart:6162:5)
E/flutter (15454): #328    _InheritedNotifierElement.update (package:flutter/src/widgets/inherited_notifier.dart:108:11)
E/flutter (15454): #329    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
E/flutter (15454): #330    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #331    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (15454): #332    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #333    StatefulElement.update (package:flutter/src/widgets/framework.dart:6020:5)
E/flutter (15454): #334    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
E/flutter (15454): #335    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #336    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #337    ProxyElement.update (package:flutter/src/widgets/framework.dart:6162:5)
E/flutter (15454): #338    _InheritedNotifierElement.update (package:flutter/src/widgets/inherited_notifier.dart:108:11)
E/flutter (15454): #339    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
E/flutter (15454): #340    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #341    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (15454): #342    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #343    StatefulElement.update (package:flutter/src/widgets/framework.dart:6020:5)
E/flutter (15454): #344    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
E/flutter (15454): #345    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #346    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (15454): #347    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #348    StatefulElement.update (package:flutter/src/widgets/framework.dart:6020:5)
E/flutter (15454): #349    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
E/flutter (15454): #350    SingleChildRenderObjectElement.update (package:flutter/src/widgets/framework.dart:7135:14)
E/flutter (15454): #351    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
E/flutter (15454): #352    SingleChildRenderObjectElement.update (package:flutter/src/widgets/framework.dart:7135:14)
E/flutter (15454): #353    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
E/flutter (15454): #354    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #355    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #356    ProxyElement.update (package:flutter/src/widgets/framework.dart:6162:5)
E/flutter (15454): #357    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
E/flutter (15454): #358    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #359    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #360    ProxyElement.update (package:flutter/src/widgets/framework.dart:6162:5)
E/flutter (15454): #361    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
E/flutter (15454): #362    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (15454): #363    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (15454): #364    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (15454): #365    BuildScope._tryRebuild (package:flutter/src/widgets/framework.dart:2763:15)
E/flutter (15454): #366    BuildScope._flushDirtyElements (package:flutter/src/widgets/framework.dart:2820:11)
E/flutter (15454): #367    BuildOwner.buildScope (package:flutter/src/widgets/framework.dart:3124:18)
E/flutter (15454): #368    WidgetsBinding.drawFrame (package:flutter/src/widgets/binding.dart:1571:21)
E/flutter (15454): #369    RendererBinding._handlePersistentFrameCallback (package:flutter/src/rendering/binding.dart:558:5)
E/flutter (15454): #370    SchedulerBinding._invokeFrameCallback (package:flutter/src/scheduler/binding.dart:1430:15)
E/flutter (15454): #371    SchedulerBinding.handleDrawFrame (package:flutter/src/scheduler/binding.dart:1345:9)
E/flutter (15454): #372    SchedulerBinding._handleDrawFrame (package:flutter/src/scheduler/binding.dart:1198:5)
E/flutter (15454): #373    _invoke (dart:ui/hooks.dart:441:13)
E/flutter (15454): #374    PlatformDispatcher._drawFrame (dart:ui/platform_dispatcher.dart:450:5)
E/flutter (15454): #375    _drawFrame (dart:ui/hooks.dart:413:31)





New error
Analyze the file located at D:\Code\Shelf dart\docs\report\report-8.15pm-2.9.26.md to identify any reported failures or errors within the post-scan workflow. 

Specifically, investigate a reported issue where the "choose destination" step fails. While the preceding steps—screen configuration, document naming, and the option to add to existing or create new—function correctly, the destination selector fails to populate. Instead of displaying available rooms or directories for saving the document, it displays a blank screen. 

Based on the report, determine the likely cause of this error and provide a technical explanation for why the destination selector is failing to load.



Hypothesis:

I have everything needed. The error is unambiguous and is reproduced at lines 112, 549, and 1012 of the report — all three are the same root cause.

## Analysis of the Destination Picker Failure

### The reported symptom vs. the report

The user's verbal description says "the destination selector displays a blank screen." The report itself doesn't narrate a blank screen, but it contains the smoking gun: an `Unhandled Exception` that originates precisely inside the destination selector the moment it tries to populate.

### The root cause (from `flutter logs` in the report)

```
E/flutter (15454): [ERROR:flutter/runtime/dart_vm_initializer.cc(40)] Unhandled Exception:
   PostgrestException(message: column rooms.subject_count does not exist,
                       code: 42703,
                       details: Bad Request,
                       hint: null)
   #0 PostgrestBuilder._parseResponse (package:postgrest/src/postgrest_builder.dart:584:5)
   #1 PostgrestBuilder._execute       (package:postgrest/src/postgrest_builder.dart:412:18)
   <async call site>
   #0 PostgrestBuilder.then (package:postgrest/src/postgrest_builder.dart:694:36)
   #1 _HierarchyPickerSheetState._loadRooms (package:shelf/core/widgets/hierarchy_picker_sheet.dart:57:18)
   #2 _HierarchyPickerSheetState.initState  (package:shelf/core/widgets/hierarchy_picker_sheet.dart:53:5)
```

The stack trace pinpoints the failure to `lib/core/widgets/hierarchy_picker_sheet.dart` line 57, inside `_loadRooms`, called from `initState` at line 53.

### The offending line

In `hierarchy_picker_sheet.dart` (lines 56–65):

```dart
Future<void> _loadRooms() async {
  final data = await Supabase.instance.client
      .from('rooms')
      .select('id, name, subject_count')   // <-- line 59: SELECTs a non-existent column
      .order('position', ascending: true);
  setState(() {
    _rooms = (data as List).map((json) => Room.fromJson(json)).toList();
    _level = 0;
  });
}
```

Postgres responds with HTTP 400 / PostgREST code `42703` (undefined_column): `column rooms.subject_count does not exist`. The error fires **every frame** in the logs because:

1. `_loadRooms()` is called from `initState()`.
2. It has **no `try/catch`**, so the `PostgrestException` propagates as an unhandled async error.
3. Because `_rooms` is never assigned, the state stays empty.
4. The exception is thrown on every rebuild attempt (the long frame-element loop visible in the log is Flutter repeatedly trying to mount/rebuild the sheet, each time the future resolves to an error), but `setState` is never reached, so the UI never updates.

### Why the picker appears blank — technical explanation

The destination selector is a `HierarchyPickerSheet` that is built around four drill-down levels: **Rooms → Subjects → Chapters → Documents**. The very first level (`Rooms`) is loaded eagerly in `initState()` via `_loadRooms()`. If that fetch fails:

1. **The state list `_rooms` remains `[]`** (initialized at line 41). The `ListView`/`ListView.builder` over `_rooms` therefore renders zero children.
2. **No loading indicator and no error UI is shown**, because the sheet's `build()` method has no branches for "loading" or "error" — it only iterates `_rooms`/`_subjects`/etc. With an empty list, the screen shows only the sheet chrome (header + Select button) and an otherwise blank body.
3. **The exception escapes the `Future`** because the `.select(...).order(...)` chain isn't wrapped in `try { ... } catch { ... }`. PostgREST raises `PostgrestException`; without a catch, it becomes an unhandled async error and the `setState` on line 61 is never executed.
4. The picker can never be dismissed by completing a selection (no room = nothing to tap), and the user has no signal explaining why the body is empty — exactly matching the "blank screen" symptom.

The error is identical for each subsequent mount (lines 112, 549, 1012 in the report) because the sheet is reopened by the scan flow and `initState` runs again, throwing the same exception each time. The earlier steps ("screen configuration", "document naming", "add existing vs. create new") are unaffected because they execute in `ScanConfigScreen` and never call `_loadRooms`.

### Likely cause (per ground rules — stop, report, don't improvise)

The `rooms` table in Supabase does not have a column called `subject_count`. The Flutter code on line 59 of `hierarchy_picker_sheet.dart` requests that column, which causes PostgREST to return 400 / `42703 undefined_column` on every call to `_loadRooms`. Because the error is unhandled and `setState` is never reached, the rooms list is permanently empty and the picker renders a blank body.

### Possible explanations to verify before any fix (not assumptions — items to check)

1. **Schema drift / missing column.** The `rooms` table was never given a `subject_count` column — it was assumed to exist. Verify with:
   ```sql
   SELECT column_name FROM information_schema.columns
    WHERE table_schema = 'public' AND table_name = 'rooms';
   ```
2. **Schema rename.** A column that *was* named `subject_count` was renamed (e.g., to `subjects_count` or `num_subjects`) by a migration that the Flutter code wasn't updated to match. Check `supabase/migrations/*` for `ALTER TABLE rooms RENAME COLUMN subject_count ...`.
3. **It was a view, not the table.** The code targets `from('rooms')`, but if `rooms` was redefined as a Postgres view that doesn't expose `subject_count`, the same 42703 is raised. Confirm with `\d+ public.rooms` in psql.
4. **Stale generated Dart model.** `Room.fromJson` references `subject_count`, but if the column was supposed to be added and a migration was never applied to the target environment (dev/prod/staging), the runtime hits the missing column. Compare migration history against the running database.

### Minimal fix candidates (do not apply without confirmation)

- **Database side:** add the missing column, e.g.
  ```sql
  ALTER TABLE public.rooms
    ADD COLUMN IF NOT EXISTS subject_count int NOT NULL DEFAULT 0;
  ```
  (and backfill if needed). This is the most likely fix if `subject_count` was always intended to exist.
- **Client side:** drop `subject_count` from the `.select(...)` list and from `Room.fromJson` if the column genuinely does not need to be on the client (e.g., compute it via a view or RPC later).
- **Defensive code (recommended regardless):** wrap `_loadRooms`/`_loadSubjects`/`_loadChapters` in `try/catch`, and surface an error/empty state in the sheet's `build()` so future query failures do not silently render as a blank screen.

The file `lib/core/widgets/hierarchy_picker_sheet.dart` lines 53, 57, and 59 are the exact lines to inspect and patch.