PS D:\Code\Shelf dart> flutter logs
Showing A059 logs:
I/flutter (28121): [scan] _handleScanTap ENTERED, context.mounted=true
I/flutter (28121): [scan] calling FlutterDocScanner().getScannedDocumentAsImages()
D/FlutterJNI(28121): Sending viewport metrics to the engine.
I/flutter (28121): [scan] scanner returned. result==null? false. runtimeType=ImageScanResult. toString="ImageScanResult(images: [file:///data/user/0/com.example.shelf/cache/mlkit_docscan_ui_client/930527254761820.jpg, file:///data/user/0/com.example.shelf/cache/mlkit_docscan_ui_client/930527295519059.jpg], count: 2)"
I/flutter (28121): [scan] imagePaths count=2
I/flutter (28121): [scan] imagePaths=2 paths. About to call Navigator.push to ScanConfigScreen.
I/flutter (28121): [scan] calling Navigator.of(context).push(MaterialPageRoute(builder: ScanConfigScreen))
I/flutter (28121): [scan] Navigator.push returned (sync). Awaiting frame.
D/FlutterJNI(28121): Sending viewport metrics to the engine.
D/FlutterJNI(28121): Sending viewport metrics to the engine.
D/FlutterJNI(28121): Sending viewport metrics to the engine.
D/FlutterJNI(28121): Sending viewport metrics to the engine.
D/FlutterJNI(28121): Sending viewport metrics to the engine.
D/FlutterJNI(28121): Sending viewport metrics to the engine.
D/FlutterJNI(28121): Sending viewport metrics to the engine.
D/FlutterJNI(28121): Sending viewport metrics to the engine.
D/FlutterJNI(28121): Sending viewport metrics to the engine.
D/FlutterJNI(28121): Sending viewport metrics to the engine.
D/FlutterJNI(28121): Sending viewport metrics to the engine.
D/FlutterJNI(28121): Sending viewport metrics to the engine.
D/FlutterJNI(28121): Sending viewport metrics to the engine.
D/FlutterJNI(28121): Sending viewport metrics to the engine.
D/FlutterJNI(28121): Sending viewport metrics to the engine.
D/FlutterJNI(28121): Sending viewport metrics to the engine.
D/FlutterJNI(28121): Sending viewport metrics to the engine.
D/FlutterJNI(28121): Sending viewport metrics to the engine.
D/FlutterJNI(28121): Sending viewport metrics to the engine.
D/FlutterJNI(28121): Sending viewport metrics to the engine.
D/FlutterJNI(28121): Sending viewport metrics to the engine.
D/FlutterJNI(28121): Sending viewport metrics to the engine.
D/FlutterJNI(28121): Sending viewport metrics to the engine.
D/FlutterJNI(28121): Sending viewport metrics to the engine.
D/FlutterJNI(28121): Sending viewport metrics to the engine.
D/FlutterJNI(28121): Sending viewport metrics to the engine.
D/FlutterJNI(28121): Sending viewport metrics to the engine.
D/FlutterJNI(28121): Sending viewport metrics to the engine.
D/FlutterJNI(28121): Sending viewport metrics to the engine.
D/FlutterJNI(28121): Sending viewport metrics to the engine.
D/FlutterJNI(28121): Sending viewport metrics to the engine.
D/FlutterJNI(28121): Sending viewport metrics to the engine.
D/FlutterJNI(28121): Sending viewport metrics to the engine.
D/FlutterJNI(28121): Sending viewport metrics to the engine.
D/FlutterJNI(28121): Sending viewport metrics to the engine.
D/FlutterJNI(28121): Sending viewport metrics to the engine.
D/FlutterJNI(28121): Sending viewport metrics to the engine.
D/FlutterJNI(28121): Sending viewport metrics to the engine.
D/FlutterJNI(28121): Sending viewport metrics to the engine.
D/FlutterJNI(28121): Sending viewport metrics to the engine.
D/FlutterJNI(28121): Sending viewport metrics to the engine.
D/FlutterJNI(28121): Sending viewport metrics to the engine.
D/FlutterJNI(28121): Sending viewport metrics to the engine.
D/FlutterJNI(28121): Sending viewport metrics to the engine.
D/FlutterJNI(28121): Sending viewport metrics to the engine.
E/flutter (28121): [ERROR:flutter/runtime/dart_vm_initializer.cc(40)] Unhandled Exception: PostgrestException(message: column rooms.position does not exist, code: 42703, details: Bad Request, hint: null)
E/flutter (28121): #0      PostgrestBuilder._parseResponse (package:postgrest/src/postgrest_builder.dart:584:5)
E/flutter (28121): #1      PostgrestBuilder._execute (package:postgrest/src/postgrest_builder.dart:412:18)
E/flutter (28121): <asynchronous suspension>
E/flutter (28121): <asynchronous suspension>
E/flutter (28121):
E/flutter (28121): <async call site>
E/flutter (28121): #0      PostgrestBuilder.then (package:postgrest/src/postgrest_builder.dart:694:36)
E/flutter (28121): #1      _HierarchyPickerSheetState._loadRooms (package:shelf/core/widgets/hierarchy_picker_sheet.dart:60:18)
E/flutter (28121): #2      _HierarchyPickerSheetState.initState (package:shelf/core/widgets/hierarchy_picker_sheet.dart:56:5)
E/flutter (28121): #3      StatefulElement._firstBuild (package:flutter/src/widgets/framework.dart:5963:55)
E/flutter (28121): #4      ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (28121): #5      Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (28121): #6      Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (28121): #7      ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (28121): #8      Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (28121): #9      ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (28121): #10     ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (28121): #11     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (28121): #12     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (28121): #13     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (28121): #14     Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (28121): #15     ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (28121): #16     ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (28121): #17     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (28121): #18     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (28121): #19     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (28121): #20     StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (28121): #21     Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (28121): #22     ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (28121): #23     StatefulElement._firstBuild (package:flutter/src/widgets/framework.dart:5986:11)
E/flutter (28121): #24     ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (28121): #25     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (28121): #26     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (28121): #27     SingleChildRenderObjectElement.mount (package:flutter/src/widgets/framework.dart:7128:14)
E/flutter (28121): #28     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (28121): #29     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (28121): #30     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (28121): #31     Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (28121): #32     ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (28121): #33     ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (28121): #34     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (28121): #35     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (28121): #36     SingleChildRenderObjectElement.mount (package:flutter/src/widgets/framework.dart:7128:14)
E/flutter (28121): #37     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (28121): #38     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (28121): #39     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (28121): #40     Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (28121): #41     ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (28121): #42     ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (28121): #43     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (28121): #44     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (28121): #45     SingleChildRenderObjectElement.mount (package:flutter/src/widgets/framework.dart:7128:14)
E/flutter (28121): #46     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (28121): #47     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (28121): #48     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (28121): #49     StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (28121): #50     Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (28121): #51     ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (28121): #52     StatefulElement._firstBuild (package:flutter/src/widgets/framework.dart:5986:11)
E/flutter (28121): #53     ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (28121): #54     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (28121): #55     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (28121): #56     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (28121): #57     StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (28121): #58     Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (28121): #59     ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (28121): #60     StatefulElement._firstBuild (package:flutter/src/widgets/framework.dart:5986:11)
E/flutter (28121): #61     ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (28121): #62     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (28121): #63     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (28121): #64     SingleChildRenderObjectElement.mount (package:flutter/src/widgets/framework.dart:7128:14)
E/flutter (28121): #65     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (28121): #66     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (28121): #67     SingleChildRenderObjectElement.mount (package:flutter/src/widgets/framework.dart:7128:14)
E/flutter (28121): #68     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (28121): #69     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (28121): #70     SingleChildRenderObjectElement.mount (package:flutter/src/widgets/framework.dart:7128:14)
E/flutter (28121): #71     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (28121): #72     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (28121): #73     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (28121): #74     StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (28121): #75     Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (28121): #76     ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (28121): #77     StatefulElement._firstBuild (package:flutter/src/widgets/framework.dart:5986:11)
E/flutter (28121): #78     ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (28121): #79     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (28121): #80     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (28121): #81     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (28121): #82     Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (28121): #83     ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (28121): #84     ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (28121): #85     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (28121): #86     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (28121): #87     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (28121): #88     StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (28121): #89     Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (28121): #90     ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (28121): #91     StatefulElement._firstBuild (package:flutter/src/widgets/framework.dart:5986:11)
E/flutter (28121): #92     ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (28121): #93     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (28121): #94     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (28121): #95     SingleChildRenderObjectElement.mount (package:flutter/src/widgets/framework.dart:7128:14)
E/flutter (28121): #96     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (28121): #97     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (28121): #98     SingleChildRenderObjectElement.mount (package:flutter/src/widgets/framework.dart:7128:14)
E/flutter (28121): #99     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (28121): #100    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (28121): #101    SingleChildRenderObjectElement.mount (package:flutter/src/widgets/framework.dart:7128:14)
E/flutter (28121): #102    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (28121): #103    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (28121): #104    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (28121): #105    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (28121): #106    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (28121): #107    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (28121): #108    StatefulElement._firstBuild (package:flutter/src/widgets/framework.dart:5986:11)
E/flutter (28121): #109    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (28121): #110    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (28121): #111    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (28121): #112    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (28121): #113    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (28121): #114    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (28121): #115    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (28121): #116    StatefulElement._firstBuild (package:flutter/src/widgets/framework.dart:5986:11)
E/flutter (28121): #117    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (28121): #118    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (28121): #119    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (28121): #120    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (28121): #121    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (28121): #122    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (28121): #123    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (28121): #124    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (28121): #125    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (28121): #126    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (28121): #127    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (28121): #128    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (28121): #129    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (28121): #130    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (28121): #131    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (28121): #132    SingleChildRenderObjectElement.mount (package:flutter/src/widgets/framework.dart:7128:14)
E/flutter (28121): #133    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (28121): #134    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (28121): #135    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (28121): #136    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (28121): #137    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (28121): #138    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (28121): #139    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (28121): #140    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (28121): #141    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (28121): #142    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (28121): #143    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (28121): #144    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (28121): #145    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (28121): #146    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (28121): #147    SingleChildRenderObjectElement.mount (package:flutter/src/widgets/framework.dart:7128:14)
E/flutter (28121): #148    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (28121): #149    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (28121): #150    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (28121): #151    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (28121): #152    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (28121): #153    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (28121): #154    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (28121): #155    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (28121): #156    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (28121): #157    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (28121): #158    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (28121): #159    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (28121): #160    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (28121): #161    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (28121): #162    SingleChildRenderObjectElement.mount (package:flutter/src/widgets/framework.dart:7128:14)
E/flutter (28121): #163    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (28121): #164    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (28121): #165    SingleChildRenderObjectElement.mount (package:flutter/src/widgets/framework.dart:7128:14)
E/flutter (28121): #166    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (28121): #167    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (28121): #168    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (28121): #169    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (28121): #170    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (28121): #171    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (28121): #172    StatefulElement._firstBuild (package:flutter/src/widgets/framework.dart:5986:11)
E/flutter (28121): #173    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (28121): #174    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (28121): #175    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (28121): #176    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (28121): #177    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (28121): #178    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (28121): #179    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (28121): #180    StatefulElement._firstBuild (package:flutter/src/widgets/framework.dart:5986:11)
E/flutter (28121): #181    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (28121): #182    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (28121): #183    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (28121): #184    SingleChildRenderObjectElement.mount (package:flutter/src/widgets/framework.dart:7128:14)
E/flutter (28121): #185    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (28121): #186    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (28121): #187    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (28121): #188    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (28121): #189    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (28121): #190    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (28121): #191    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (28121): #192    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (28121): #193    SingleChildRenderObjectElement.mount (package:flutter/src/widgets/framework.dart:7128:14)
E/flutter (28121): #194    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (28121): #195    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (28121): #196    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (28121): #197    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (28121): #198    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (28121): #199    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (28121): #200    StatefulElement._firstBuild (package:flutter/src/widgets/framework.dart:5986:11)
E/flutter (28121): #201    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (28121): #202    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (28121): #203    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (28121): #204    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (28121): #205    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (28121): #206    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (28121): #207    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (28121): #208    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (28121): #209    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (28121): #210    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (28121): #211    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (28121): #212    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (28121): #213    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (28121): #214    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (28121): #215    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (28121): #216    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (28121): #217    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (28121): #218    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (28121): #219    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (28121): #220    StatefulElement._firstBuild (package:flutter/src/widgets/framework.dart:5986:11)
E/flutter (28121): #221    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (28121): #222    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (28121): #223    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (28121): #224    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (28121): #225    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (28121): #226    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (28121): #227    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (28121): #228    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (28121): #229    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (28121): #230    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (28121): #231    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (28121): #232    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (28121): #233    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (28121): #234    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (28121): #235    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (28121): #236    SingleChildRenderObjectElement.mount (package:flutter/src/widgets/framework.dart:7128:14)
E/flutter (28121): #237    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (28121): #238    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (28121): #239    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (28121): #240    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (28121): #241    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (28121): #242    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (28121): #243    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (28121): #244    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (28121): #245    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (28121): #246    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (28121): #247    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (28121): #248    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (28121): #249    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (28121): #250    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (28121): #251    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (28121): #252    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (28121): #253    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (28121): #254    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (28121): #255    StatefulElement._firstBuild (package:flutter/src/widgets/framework.dart:5986:11)
E/flutter (28121): #256    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (28121): #257    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (28121): #258    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (28121): #259    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (28121): #260    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (28121): #261    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (28121): #262    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (28121): #263    StatefulElement._firstBuild (package:flutter/src/widgets/framework.dart:5986:11)
E/flutter (28121): #264    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (28121): #265    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (28121): #266    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (28121): #267    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (28121): #268    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (28121): #269    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (28121): #270    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (28121): #271    StatefulElement._firstBuild (package:flutter/src/widgets/framework.dart:5986:11)
E/flutter (28121): #272    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (28121): #273    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (28121): #274    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (28121): #275    SingleChildRenderObjectElement.mount (package:flutter/src/widgets/framework.dart:7128:14)
E/flutter (28121): #276    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (28121): #277    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (28121): #278    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (28121): #279    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (28121): #280    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (28121): #281    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (28121): #282    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (28121): #283    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (28121): #284    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (28121): #285    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (28121): #286    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (28121): #287    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (28121): #288    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (28121): #289    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (28121): #290    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (28121): #291    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (28121): #292    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (28121): #293    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (28121): #294    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (28121): #295    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (28121): #296    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (28121): #297    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (28121): #298    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (28121): #299    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (28121): #300    StatefulElement._firstBuild (package:flutter/src/widgets/framework.dart:5986:11)
E/flutter (28121): #301    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (28121): #302    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (28121): #303    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (28121): #304    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (28121): #305    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (28121): #306    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (28121): #307    ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
E/flutter (28121): #308    StatefulElement._firstBuild (package:flutter/src/widgets/framework.dart:5986:11)
E/flutter (28121): #309    ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
E/flutter (28121): #310    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
E/flutter (28121): #311    MultiChildRenderObjectElement.inflateWidget (package:flutter/src/widgets/framework.dart:7277:36)
E/flutter (28121): #312    Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
E/flutter (28121): #313    Element.updateChildren (package:flutter/src/widgets/framework.dart:4268:32)
E/flutter (28121): #314    MultiChildRenderObjectElement.update (package:flutter/src/widgets/framework.dart:7308:17)
E/flutter (28121): #315    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
E/flutter (28121): #316    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (28121): #317    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (28121): #318    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (28121): #319    StatefulElement.update (package:flutter/src/widgets/framework.dart:6020:5)
E/flutter (28121): #320    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
E/flutter (28121): #321    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (28121): #322    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (28121): #323    ProxyElement.update (package:flutter/src/widgets/framework.dart:6162:5)
E/flutter (28121): #324    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
E/flutter (28121): #325    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (28121): #326    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (28121): #327    ProxyElement.update (package:flutter/src/widgets/framework.dart:6162:5)
E/flutter (28121): #328    _InheritedNotifierElement.update (package:flutter/src/widgets/inherited_notifier.dart:108:11)
E/flutter (28121): #329    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
E/flutter (28121): #330    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (28121): #331    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (28121): #332    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (28121): #333    StatefulElement.update (package:flutter/src/widgets/framework.dart:6020:5)
E/flutter (28121): #334    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
E/flutter (28121): #335    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (28121): #336    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (28121): #337    ProxyElement.update (package:flutter/src/widgets/framework.dart:6162:5)
E/flutter (28121): #338    _InheritedNotifierElement.update (package:flutter/src/widgets/inherited_notifier.dart:108:11)
E/flutter (28121): #339    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
E/flutter (28121): #340    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (28121): #341    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (28121): #342    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (28121): #343    StatefulElement.update (package:flutter/src/widgets/framework.dart:6020:5)
E/flutter (28121): #344    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
E/flutter (28121): #345    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (28121): #346    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (28121): #347    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (28121): #348    StatefulElement.update (package:flutter/src/widgets/framework.dart:6020:5)
E/flutter (28121): #349    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
E/flutter (28121): #350    SingleChildRenderObjectElement.update (package:flutter/src/widgets/framework.dart:7135:14)
E/flutter (28121): #351    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
E/flutter (28121): #352    SingleChildRenderObjectElement.update (package:flutter/src/widgets/framework.dart:7135:14)
E/flutter (28121): #353    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
E/flutter (28121): #354    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (28121): #355    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (28121): #356    ProxyElement.update (package:flutter/src/widgets/framework.dart:6162:5)
E/flutter (28121): #357    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
E/flutter (28121): #358    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (28121): #359    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (28121): #360    ProxyElement.update (package:flutter/src/widgets/framework.dart:6162:5)
E/flutter (28121): #361    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
E/flutter (28121): #362    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
E/flutter (28121): #363    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
E/flutter (28121): #364    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
E/flutter (28121): #365    BuildScope._tryRebuild (package:flutter/src/widgets/framework.dart:2763:15)
E/flutter (28121): #366    BuildScope._flushDirtyElements (package:flutter/src/widgets/framework.dart:2820:11)
E/flutter (28121): #367    BuildOwner.buildScope (package:flutter/src/widgets/framework.dart:3124:18)
E/flutter (28121): #368    WidgetsBinding.drawFrame (package:flutter/src/widgets/binding.dart:1571:21)
E/flutter (28121): #369    RendererBinding._handlePersistentFrameCallback (package:flutter/src/rendering/binding.dart:558:5)
E/flutter (28121): #370    SchedulerBinding._invokeFrameCallback (package:flutter/src/scheduler/binding.dart:1430:15)
E/flutter (28121): #371    SchedulerBinding.handleDrawFrame (package:flutter/src/scheduler/binding.dart:1345:9)
E/flutter (28121): #372    SchedulerBinding._handleDrawFrame (package:flutter/src/scheduler/binding.dart:1198:5)
E/flutter (28121): #373    _invoke (dart:ui/hooks.dart:441:13)
E/flutter (28121): #374    PlatformDispatcher._drawFrame (dart:ui/platform_dispatcher.dart:450:5)
E/flutter (28121): #375    _drawFrame (dart:ui/hooks.dart:413:31)
E/flutter (28121):
D/FlutterJNI(28121): Sending viewport metrics to the engine.
D/FlutterJNI(28121): Sending viewport metrics to the engine.
D/FlutterJNI(28121): Sending viewport metrics to the engine.
D/FlutterJNI(28121): Sending viewport metrics to the engine.
D/FlutterJNI(28121): Sending viewport metrics to the engine.
D/FlutterJNI(28121): Sending viewport metrics to the engine.
D/FlutterJNI(28121): Sending viewport metrics to the engine.
D/FlutterJNI(28121): Sending viewport metrics to the engine.
D/FlutterJNI(28121): Sending viewport metrics to the engine.
D/FlutterJNI(28121): Sending viewport metrics to the engine.
D/FlutterJNI(28121): Sending viewport metrics to the engine.
D/FlutterJNI(28121): Sending viewport metrics to the engine.
D/FlutterJNI(28121): Sending viewport metrics to the engine.
D/FlutterJNI(28121): Sending viewport metrics to the engine.
D/FlutterJNI(28121): Sending viewport metrics to the engine.
D/FlutterJNI(28121): Sending viewport metrics to the engine.
D/FlutterJNI(28121): Sending viewport metrics to the engine.
D/FlutterJNI(28121): Sending viewport metrics to the engine.
D/FlutterJNI(28121): Sending viewport metrics to the engine.
D/FlutterJNI(28121): Sending viewport metrics to the engine.
D/FlutterJNI(28121): Sending viewport metrics to the engine.
D/FlutterJNI(28121): Sending viewport metrics to the engine.
D/FlutterJNI(28121): Sending viewport metrics to the engine.
D/FlutterJNI(28121): Sending viewport metrics to the engine.
D/FlutterJNI(28121): Sending viewport metrics to the engine.
D/FlutterJNI(28121): Sending viewport metrics to the engine.
D/FlutterJNI(28121): Sending viewport metrics to the engine.
D/FlutterJNI(28121): Sending viewport metrics to the engine.
D/FlutterJNI(28121): Sending viewport metrics to the engine.
D/FlutterJNI(28121): Sending viewport metrics to the engine



D:\Code\Shelf dart\lib\core\widgets\hierarchy_picker_sheet.dart :


import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../features/rooms/models/room.dart';
import '../../features/rooms/widgets/room_card.dart';
import '../../features/subjects/models/subject.dart';
import '../../features/subjects/widgets/subject_list_item.dart';
import '../../features/chapters/models/chapter.dart';
import '../../features/documents/models/document.dart';
import '../../features/documents/widgets/document_list_item.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';
import '../theme/app_theme.dart';
import '../widgets/tactile.dart';

/// Mode determines the final selection type.
enum HierarchyPickerMode { pickChapter, pickDocument }

/// A reusable hierarchical picker sheet that drills from Rooms → Subjects → Chapters
/// and optionally into Documents. It mirrors the existing UI components.
class HierarchyPickerSheet extends StatefulWidget {
  const HierarchyPickerSheet({
    super.key,
    required this.mode,
    required this.onChapterPicked,
    this.onDocumentPicked,
  });

  final HierarchyPickerMode mode;
  final void Function(Chapter) onChapterPicked;
  final void Function(Document)? onDocumentPicked;

  @override
  State<HierarchyPickerSheet> createState() => _HierarchyPickerSheetState();
}

class _HierarchyPickerSheetState extends State<HierarchyPickerSheet> {
  // 0: rooms, 1: subjects, 2: chapters, 3: documents (only in pickDocument mode)
  int _level = 0;
  List<Room> _rooms = [];
  List<Subject> _subjects = [];
  List<Chapter> _chapters = [];
  List<Document> _documents = [];

  Room? _selectedRoom;
  Subject? _selectedSubject;
  Chapter? _selectedChapter;
  Document? _selectedDocument;
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadRooms();
  }

  Future<void> _loadRooms() async {
    final data = await Supabase.instance.client
        .from('rooms')
        .select('id, name, subjects:count')
        .order('position', ascending: true);
    setState(() {
      _rooms = (data as List).map((json) => Room.fromJson(json)).toList();
      _level = 0;
    });
  }

  Future<void> _loadSubjects(String roomId) async {
    final data = await Supabase.instance.client
        .from('subjects')
        .select('id, name, chapter_count')
        .eq('room_id', roomId)
        .order('position', ascending: true);
    setState(() {
      _subjects = (data as List).map((json) => Subject.fromJson(json)).toList();
      _level = 1;
    });
  }

  Future<void> _loadChapters(String subjectId) async {
    final data = await Supabase.instance.client
        .from('chapters')
        .select('id, name, position')
        .eq('subject_id', subjectId)
        .order('position', ascending: true);
    setState(() {
      _chapters = (data as List).map((json) => Chapter.fromJson(json)).toList();
      _level = 2;
    });
  }

  Future<void> _loadDocuments(String chapterId) async {
    final data = await Supabase.instance.client
        .from('documents')
        .select('id, title, page_count, chapter_id')
        .eq('chapter_id', chapterId)
        .order('position', ascending: true);
    setState(() {
      _documents = (data as List).map((json) => Document.fromJson(json)).toList();
      _level = 3;
    });
  }

  void _goBack() {
    if (_level == 0) return;
    setState(() {
      if (_level == 3) {
        // back from documents to chapters
        _level = 2;
        _documents = [];
      } else if (_level == 2) {
        // back from chapters to subjects
        _level = 1;
        _chapters = [];
        _selectedChapter = null;
      } else if (_level == 1) {
        // back from subjects to rooms
        _level = 0;
        _subjects = [];
        _selectedSubject = null;
      }
    });
  }

  Widget _buildHeader() {
    String title;
    switch (_level) {
      case 0:
        title = 'Select Room';
        break;
      case 1:
        title = 'Select Subject';
        break;
      case 2:
        title = 'Select Chapter';
        break;
      case 3:
        title = 'Select Document';
        break;
      default:
        title = '';
    }
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.containerMargin),
      child: Row(
        children: [
          if (_level > 0)
            IconButton(
              icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
              onPressed: _goBack,
            ),
          Expanded(
            child: Text(title, style: AppTextStyles.sectionTitle),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          _buildHeader(),
          const Divider(height: 1, thickness: 1),
          Expanded(
            child: _buildBody(),
          ),
          if ((_level == 2 && widget.mode == HierarchyPickerMode.pickChapter) ||
              (_level == 3 && widget.mode == HierarchyPickerMode.pickDocument))
            Padding(
              padding: const EdgeInsets.all(AppSpacing.containerMargin),
              child: Tactile(
                onTap: () {
                  if (widget.mode == HierarchyPickerMode.pickChapter && _selectedChapter != null) {
                    widget.onChapterPicked(_selectedChapter!);
                    Navigator.of(context).pop();
                  } else if (widget.mode == HierarchyPickerMode.pickDocument && _selectedDocument != null) {
                    widget.onDocumentPicked!(_selectedDocument!);
                    Navigator.of(context).pop();
                  }
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
color: ((widget.mode == HierarchyPickerMode.pickChapter && _selectedChapter != null) ||
                             (widget.mode == HierarchyPickerMode.pickDocument && _selectedDocument != null))
                         ? AppColors.primaryButton
                         : AppColors.border,
                    borderRadius: BorderRadius.circular(AppRadius.md),
                  ),
                  child: Text(
                    'Select',
                    style: AppTextStyles.buttonLabel.copyWith(
color: ((widget.mode == HierarchyPickerMode.pickChapter && _selectedChapter != null) ||
                               (widget.mode == HierarchyPickerMode.pickDocument && _selectedDocument != null))
                           ? AppColors.onPrimaryButton
                           : AppColors.textSecondary,
                    ),
                  ),
),
               ),
             ),
         ],
      ),
    );
  }

  Widget _buildBody() {
    switch (_level) {
      case 0:
        return ListView.builder(
          padding: const EdgeInsets.all(AppSpacing.containerMargin),
          itemCount: _rooms.length,
          itemBuilder: (c, i) {
            final room = _rooms[i];
            return RoomCard(
              room: room,
              onTap: () {
                _selectedRoom = room;
                _loadSubjects(room.id);
              },
            );
          },
        );
      case 1:
        return ListView.builder(
          padding: const EdgeInsets.all(AppSpacing.containerMargin),
          itemCount: _subjects.length,
          itemBuilder: (c, i) {
            final subject = _subjects[i];
            return SubjectListItem(
              subject: subject,
              onTap: () {
                _selectedSubject = subject;
                _loadChapters(subject.id);
              },
            );
          },
        );
      case 2:
        return ListView.separated(
          padding: const EdgeInsets.all(AppSpacing.containerMargin),
          itemCount: _chapters.length,
          separatorBuilder: (_, __) => const Divider(height: 1),
          itemBuilder: (c, i) {
            final chapter = _chapters[i];
            return ListTile(
              title: Text(chapter.name, style: AppTextStyles.body),
              trailing: _selectedChapter == chapter
                  ? const Icon(Icons.check, color: AppColors.primaryButton)
                  : const Icon(Icons.chevron_right, color: AppColors.textSecondary),
              selected: _selectedChapter == chapter,
              selectedTileColor: AppColors.surfaceCard,
              onTap: () async {
                setState(() => _selectedChapter = chapter);
                if (widget.mode == HierarchyPickerMode.pickChapter) {
                  // wait for user to confirm via Select button
                } else {
                  // pick document mode – load documents
                  await _loadDocuments(chapter.id);
                }
              },
            );
          },
        );
      case 3:
        return ListView.separated(
          padding: const EdgeInsets.all(AppSpacing.containerMargin),
          itemCount: _documents.length,
          separatorBuilder: (_, __) => const Divider(height: 1),
          itemBuilder: (c, i) {
            final doc = _documents[i];
            return ListTile(
              title: Text(doc.title, style: AppTextStyles.body),
              trailing: _selectedDocument == doc
                  ? const Icon(Icons.check, color: AppColors.primaryButton)
                  : const Icon(Icons.chevron_right, color: AppColors.textSecondary),
              selected: _selectedDocument == doc,
              selectedTileColor: AppColors.surfaceCard,
              onTap: () {
                setState(() => _selectedDocument = doc);
              },
            );
          },
        );
      default:
        return const SizedBox.shrink();
    }
  }
}


Hypothesis of root cause:
## Root Cause Analysis

### The Crash

The unhandled exception thrown on line 56 (line 64 in the stack) is:

```
PostgrestException(message: column rooms.position does not exist, code: 42703, details: Bad Request, hint: null)
```

Originating in `_HierarchyPickerSheetState._loadRooms` (`lib/core/widgets/hierarchy_picker_sheet.dart:60`).

The query being executed is:

```dart
.from('rooms')
.select('id, name, subjects:count')
.order('position', ascending: true);
```

Postgres returns HTTP 400 ("Bad Request") because the `rooms` table has **no column named `position`**, but the Dart code is sorting by it.

### Why the "Select Destination" feature fails

The `_loadRooms()` method is invoked from `initState()`. Because the exception is **not caught**, it propagates as an unhandled async error and:

1. The `setState(...)` call on line 64 is never reached, so `_rooms` stays `[]` and `_level` stays `0`.
2. The error bubbles all the way up through `StatefulElement._firstBuild`, repeatedly rebuilding and tearing down widgets (this is the noisy `D/FlutterJNI Sending viewport metrics...` storm and the long stack trace).
3. The user sees a broken/blank `HierarchyPickerSheet` instead of a list of rooms — so no destinations can be tapped, no `Select` button can be enabled, and the "select destination" flow cannot proceed.

### Why it's failing now

Two possibilities:

1. **Schema drift.** The `rooms` table schema was changed (e.g., the sort column was renamed to something like `sort_order`, `ordinal`, or removed entirely) but the client query was not updated. The other loaders in the same file also use `order('position', ...)` on `subjects`, `chapters`, and `documents` — any of them could regress the same way, but `rooms` is hit first because it's the entry point.
2. **Stale cache / wrong environment.** If `position` was recently renamed or dropped on a migration that hasn't been replicated locally, the production table is fine but the dev DB returns this error. Less likely, since the error is clean and consistent.

### Fixes

**Fix 1 (required): match the actual sort column.** Change the `order` clause on line 63 to use whichever column the `rooms` table actually has. For example:

```dart
.order('created_at', ascending: true)   // or whatever the real column is
```

Apply the same audit to `_loadSubjects` (line 75), `_loadChapters` (line 87), and `_loadDocuments` (line 99) — they all `.order('position', ...)`.

**Fix 2 (strongly recommended): guard against async exceptions during `initState`.** Even with the query fixed, any future Postgrest error will again take down the sheet silently. Wrap the loads in try/catch and surface `_errorMessage` in the UI:

```dart
Future<void> _loadRooms() async {
  setState(() => _isLoading = true);
  try {
    final data = await Supabase.instance.client
        .from('rooms')
        .select('id, name, subjects:count')
        .order('<correct_column>', ascending: true);
    setState(() {
      _rooms = (data as List).map((json) => Room.fromJson(json)).toList();
      _level = 0;
      _isLoading = false;
    });
  } catch (e) {
    setState(() {
      _errorMessage = 'Failed to load rooms: $e';
      _isLoading = false;
    });
  }
}
```

Then render `_errorMessage` (and a retry button) in `_buildBody()` instead of the silent empty list.

**Fix 3 (defensive): validate schema assumptions with a quick verification step.** Before fixing, confirm the actual `rooms` columns:

```sql
SELECT column_name FROM information_schema.columns
WHERE table_schema = 'public' AND table_name = 'rooms';
```

Pick the right sort column, update `hierarchy_picker_sheet.dart` accordingly, then re-run the scan flow end-to-end.

**Fix 4 (root-cause hygiene):** if the project truly intends to support drag-and-drop reordering across `rooms`, `subjects`, `chapters`, and `documents`, add a `position INT` (or `sort_order INT`) column via a migration to all four tables so the existing `.order('position', ...)` calls become correct instead of being patched away.

### Summary

The "Select Destination" feature is broken because `HierarchyPickerSheet._loadRooms` sorts by `rooms.position`, which does not exist in the database (Postgres error 42703). The unhandled exception prevents the room list from ever being rendered, so users see an empty/broken sheet and cannot pick a destination. The immediate fix is to change the `.order('position', ...)` to the column that actually exists on `rooms`, repeat the audit for the other three tables, and wrap the loaders in try/catch so future schema drift degrades to a visible error message rather than a silent empty sheet.