; ModuleID = 'marshal_methods.arm64-v8a.ll'
source_filename = "marshal_methods.arm64-v8a.ll"
target datalayout = "e-m:e-i8:8:32-i16:16:32-i64:64-i128:128-n32:64-S128"
target triple = "aarch64-unknown-linux-android21"

%struct.MarshalMethodName = type {
	i64, ; uint64_t id
	ptr ; char* name
}

%struct.MarshalMethodsManagedClass = type {
	i32, ; uint32_t token
	ptr ; MonoClass klass
}

@assembly_image_cache = dso_local local_unnamed_addr global [170 x ptr] zeroinitializer, align 8

; Each entry maps hash of an assembly name to an index into the `assembly_image_cache` array
@assembly_image_cache_hashes = dso_local local_unnamed_addr constant [510 x i64] [
	i64 u0x0071cf2d27b7d61e, ; 0: lib_Xamarin.AndroidX.SwipeRefreshLayout.dll.so => 96
	i64 u0x00b3aadb3a4c4038, ; 1: lib_Refit.dll.so => 64
	i64 u0x01109b0e4d99e61f, ; 2: System.ComponentModel.Annotations.dll => 110
	i64 u0x018d2cc5e2de2b95, ; 3: lib_Microsoft.AspNetCore.SignalR.Common.dll.so => 45
	i64 u0x02123411c4e01926, ; 4: lib_Xamarin.AndroidX.Navigation.Runtime.dll.so => 92
	i64 u0x022e81ea9c46e03a, ; 5: lib_CommunityToolkit.Maui.Core.dll.so => 37
	i64 u0x02abedc11addc1ed, ; 6: lib_Mono.Android.Runtime.dll.so => 168
	i64 u0x032267b2a94db371, ; 7: lib_Xamarin.AndroidX.AppCompat.dll.so => 74
	i64 u0x0399610510a38a38, ; 8: lib_System.Private.DataContractSerialization.dll.so => 140
	i64 u0x043032f1d071fae0, ; 9: ru/Microsoft.Maui.Controls.resources => 24
	i64 u0x044440a55165631e, ; 10: lib-cs-Microsoft.Maui.Controls.resources.dll.so => 2
	i64 u0x046eb1581a80c6b0, ; 11: vi/Microsoft.Maui.Controls.resources => 30
	i64 u0x0517ef04e06e9f76, ; 12: System.Net.Primitives => 131
	i64 u0x0565d18c6da3de38, ; 13: Xamarin.AndroidX.RecyclerView => 94
	i64 u0x0581db89237110e9, ; 14: lib_System.Collections.dll.so => 109
	i64 u0x05989cb940b225a9, ; 15: Microsoft.Maui.dll => 61
	i64 u0x06076b5d2b581f08, ; 16: zh-HK/Microsoft.Maui.Controls.resources => 31
	i64 u0x06388ffe9f6c161a, ; 17: System.Xml.Linq.dll => 161
	i64 u0x0680a433c781bb3d, ; 18: Xamarin.AndroidX.Collection.Jvm => 78
	i64 u0x07469f2eecce9e85, ; 19: mscorlib.dll => 164
	i64 u0x07c57877c7ba78ad, ; 20: ru/Microsoft.Maui.Controls.resources.dll => 24
	i64 u0x07dcdc7460a0c5e4, ; 21: System.Collections.NonGeneric => 107
	i64 u0x08f3c9788ee2153c, ; 22: Xamarin.AndroidX.DrawerLayout => 83
	i64 u0x09138715c92dba90, ; 23: lib_System.ComponentModel.Annotations.dll.so => 110
	i64 u0x0919c28b89381a0b, ; 24: lib_Microsoft.Extensions.Options.dll.so => 57
	i64 u0x092266563089ae3e, ; 25: lib_System.Collections.NonGeneric.dll.so => 107
	i64 u0x09d144a7e214d457, ; 26: System.Security.Cryptography => 153
	i64 u0x0abb3e2b271edc45, ; 27: System.Threading.Channels.dll => 157
	i64 u0x0b3b632c3bbee20c, ; 28: sk/Microsoft.Maui.Controls.resources => 25
	i64 u0x0b6aff547b84fbe9, ; 29: Xamarin.KotlinX.Serialization.Core.Jvm => 102
	i64 u0x0b74b547d9e0e85d, ; 30: Microsoft.AspNetCore.SignalR.Protocols.Json.dll => 46
	i64 u0x0be2e1f8ce4064ed, ; 31: Xamarin.AndroidX.ViewPager => 97
	i64 u0x0c3ca6cc978e2aae, ; 32: pt-BR/Microsoft.Maui.Controls.resources => 21
	i64 u0x0c59ad9fbbd43abe, ; 33: Mono.Android => 169
	i64 u0x0c7790f60165fc06, ; 34: lib_Microsoft.Maui.Essentials.dll.so => 62
	i64 u0x0e14e73a54dda68e, ; 35: lib_System.Net.NameResolution.dll.so => 129
	i64 u0x0fdf69c58fad2d0a, ; 36: SocialMauiApp.dll => 104
	i64 u0x102a31b45304b1da, ; 37: Xamarin.AndroidX.CustomView => 82
	i64 u0x10ca46a12d1cfb88, ; 38: Syncfusion.Maui.Core => 67
	i64 u0x10f6cfcbcf801616, ; 39: System.IO.Compression.Brotli => 121
	i64 u0x11a70d0e1009fb11, ; 40: System.Net.WebSockets.dll => 137
	i64 u0x124908dccbc07697, ; 41: en-US/Syncfusion.Maui.ImageEditor.resources => 34
	i64 u0x125b7f94acb989db, ; 42: Xamarin.AndroidX.RecyclerView.dll => 94
	i64 u0x138567fa954faa55, ; 43: Xamarin.AndroidX.Browser => 76
	i64 u0x13a01de0cbc3f06c, ; 44: lib-fr-Microsoft.Maui.Controls.resources.dll.so => 8
	i64 u0x13f1e5e209e91af4, ; 45: lib_Java.Interop.dll.so => 167
	i64 u0x13f1e880c25d96d1, ; 46: he/Microsoft.Maui.Controls.resources => 9
	i64 u0x143d8ea60a6a4011, ; 47: Microsoft.Extensions.DependencyInjection.Abstractions => 50
	i64 u0x1497051b917530bd, ; 48: lib_System.Net.WebSockets.dll.so => 137
	i64 u0x15089560460fb845, ; 49: Microsoft.AspNetCore.SignalR.Client.Core => 44
	i64 u0x1695ecefb732cade, ; 50: lib_Syncfusion.Maui.Core.dll.so => 67
	i64 u0x17125c9a85b4929f, ; 51: lib_netstandard.dll.so => 165
	i64 u0x17b56e25558a5d36, ; 52: lib-hu-Microsoft.Maui.Controls.resources.dll.so => 12
	i64 u0x17f9358913beb16a, ; 53: System.Text.Encodings.Web => 154
	i64 u0x18402a709e357f3b, ; 54: lib_Xamarin.KotlinX.Serialization.Core.Jvm.dll.so => 102
	i64 u0x18f0ce884e87d89a, ; 55: nb/Microsoft.Maui.Controls.resources.dll => 18
	i64 u0x18facb3695ca9224, ; 56: Refit.HttpClientFactory => 65
	i64 u0x19a4c090f14ebb66, ; 57: System.Security.Claims => 151
	i64 u0x1a91866a319e9259, ; 58: lib_System.Collections.Concurrent.dll.so => 105
	i64 u0x1aac34d1917ba5d3, ; 59: lib_System.dll.so => 163
	i64 u0x1aad60783ffa3e5b, ; 60: lib-th-Microsoft.Maui.Controls.resources.dll.so => 27
	i64 u0x1c292b1598348d77, ; 61: Microsoft.Extensions.Diagnostics.dll => 51
	i64 u0x1c753b5ff15bce1b, ; 62: Mono.Android.Runtime.dll => 168
	i64 u0x1e3d87657e9659bc, ; 63: Xamarin.AndroidX.Navigation.UI => 93
	i64 u0x1e71143913d56c10, ; 64: lib-ko-Microsoft.Maui.Controls.resources.dll.so => 16
	i64 u0x1ed8fcce5e9b50a0, ; 65: Microsoft.Extensions.Options.dll => 57
	i64 u0x209375905fcc1bad, ; 66: lib_System.IO.Compression.Brotli.dll.so => 121
	i64 u0x20fab3cf2dfbc8df, ; 67: lib_System.Diagnostics.Process.dll.so => 116
	i64 u0x2174319c0d835bc9, ; 68: System.Runtime => 150
	i64 u0x220fd4f2e7c48170, ; 69: th/Microsoft.Maui.Controls.resources => 27
	i64 u0x237be844f1f812c7, ; 70: System.Threading.Thread.dll => 158
	i64 u0x2407aef2bbe8fadf, ; 71: System.Console => 114
	i64 u0x240abe014b27e7d3, ; 72: Xamarin.AndroidX.Core.dll => 80
	i64 u0x247619fe4413f8bf, ; 73: System.Runtime.Serialization.Primitives.dll => 148
	i64 u0x252073cc3caa62c2, ; 74: fr/Microsoft.Maui.Controls.resources.dll => 8
	i64 u0x2662c629b96b0b30, ; 75: lib_Xamarin.Kotlin.StdLib.dll.so => 100
	i64 u0x268c1439f13bcc29, ; 76: lib_Microsoft.Extensions.Primitives.dll.so => 58
	i64 u0x273f3515de5faf0d, ; 77: id/Microsoft.Maui.Controls.resources.dll => 13
	i64 u0x2742545f9094896d, ; 78: hr/Microsoft.Maui.Controls.resources => 11
	i64 u0x2759af78ab94d39b, ; 79: System.Net.WebSockets => 137
	i64 u0x27b410442fad6cf1, ; 80: Java.Interop.dll => 167
	i64 u0x2801845a2c71fbfb, ; 81: System.Net.Primitives.dll => 131
	i64 u0x288f0dc6b8b36b5f, ; 82: Refit.dll => 64
	i64 u0x28e52865585a1ebe, ; 83: Microsoft.Extensions.Diagnostics.Abstractions.dll => 52
	i64 u0x298435b07b00e928, ; 84: lib-en-US-Syncfusion.Maui.ImageEditor.resources.dll.so => 34
	i64 u0x2a128783efe70ba0, ; 85: uk/Microsoft.Maui.Controls.resources.dll => 29
	i64 u0x2a3b095612184159, ; 86: lib_System.Net.NetworkInformation.dll.so => 130
	i64 u0x2a6507a5ffabdf28, ; 87: System.Diagnostics.TraceSource.dll => 117
	i64 u0x2ad156c8e1354139, ; 88: fi/Microsoft.Maui.Controls.resources => 7
	i64 u0x2af298f63581d886, ; 89: System.Text.RegularExpressions.dll => 156
	i64 u0x2afc1c4f898552ee, ; 90: lib_System.Formats.Asn1.dll.so => 120
	i64 u0x2b148910ed40fbf9, ; 91: zh-Hant/Microsoft.Maui.Controls.resources.dll => 33
	i64 u0x2c8bd14bb93a7d82, ; 92: lib-pl-Microsoft.Maui.Controls.resources.dll.so => 20
	i64 u0x2cd723e9fe623c7c, ; 93: lib_System.Private.Xml.Linq.dll.so => 142
	i64 u0x2cdbe1c1d4183ec1, ; 94: lib_Syncfusion.Licensing.dll.so => 66
	i64 u0x2d169d318a968379, ; 95: System.Threading.dll => 159
	i64 u0x2d47774b7d993f59, ; 96: sv/Microsoft.Maui.Controls.resources.dll => 26
	i64 u0x2db915caf23548d2, ; 97: System.Text.Json.dll => 155
	i64 u0x2e6f1f226821322a, ; 98: el/Microsoft.Maui.Controls.resources.dll => 5
	i64 u0x2e7c9658c7fb7927, ; 99: Microsoft.Extensions.Features.dll => 53
	i64 u0x2f02f94df3200fe5, ; 100: System.Diagnostics.Process => 116
	i64 u0x2f2e98e1c89b1aff, ; 101: System.Xml.ReaderWriter => 162
	i64 u0x2ff49de6a71764a1, ; 102: lib_Microsoft.Extensions.Http.dll.so => 54
	i64 u0x309ee9eeec09a71e, ; 103: lib_Xamarin.AndroidX.Fragment.dll.so => 84
	i64 u0x31195fef5d8fb552, ; 104: _Microsoft.Android.Resource.Designer.dll => 35
	i64 u0x32243413e774362a, ; 105: Xamarin.AndroidX.CardView.dll => 77
	i64 u0x3235427f8d12dae1, ; 106: lib_System.Drawing.Primitives.dll.so => 118
	i64 u0x329753a17a517811, ; 107: fr/Microsoft.Maui.Controls.resources => 8
	i64 u0x32aa989ff07a84ff, ; 108: lib_System.Xml.ReaderWriter.dll.so => 162
	i64 u0x33829542f112d59b, ; 109: System.Collections.Immutable => 106
	i64 u0x33a31443733849fe, ; 110: lib-es-Microsoft.Maui.Controls.resources.dll.so => 6
	i64 u0x341abc357fbb4ebf, ; 111: lib_System.Net.Sockets.dll.so => 134
	i64 u0x34dfd74fe2afcf37, ; 112: Microsoft.Maui => 61
	i64 u0x34e292762d9615df, ; 113: cs/Microsoft.Maui.Controls.resources.dll => 2
	i64 u0x3508234247f48404, ; 114: Microsoft.Maui.Controls => 59
	i64 u0x353590da528c9d22, ; 115: System.ComponentModel.Annotations => 110
	i64 u0x3549870798b4cd30, ; 116: lib_Xamarin.AndroidX.ViewPager2.dll.so => 98
	i64 u0x355282fc1c909694, ; 117: Microsoft.Extensions.Configuration => 47
	i64 u0x35ea419d842e2b43, ; 118: Syncfusion.Maui.ImageEditor.dll => 68
	i64 u0x380134e03b1e160a, ; 119: System.Collections.Immutable.dll => 106
	i64 u0x385c17636bb6fe6e, ; 120: Xamarin.AndroidX.CustomView.dll => 82
	i64 u0x38869c811d74050e, ; 121: System.Net.NameResolution.dll => 129
	i64 u0x393c226616977fdb, ; 122: lib_Xamarin.AndroidX.ViewPager.dll.so => 97
	i64 u0x395e37c3334cf82a, ; 123: lib-ca-Microsoft.Maui.Controls.resources.dll.so => 1
	i64 u0x3c3aafb6b3a00bf6, ; 124: lib_System.Security.Cryptography.X509Certificates.dll.so => 152
	i64 u0x3c7c495f58ac5ee9, ; 125: Xamarin.Kotlin.StdLib => 100
	i64 u0x3cd9d281d402eb9b, ; 126: Xamarin.AndroidX.Browser.dll => 76
	i64 u0x3d46f0b995082740, ; 127: System.Xml.Linq => 161
	i64 u0x3d9c2a242b040a50, ; 128: lib_Xamarin.AndroidX.Core.dll.so => 80
	i64 u0x407a10bb4bf95829, ; 129: lib_Xamarin.AndroidX.Navigation.Common.dll.so => 90
	i64 u0x41833cf766d27d96, ; 130: mscorlib => 164
	i64 u0x41cab042be111c34, ; 131: lib_Xamarin.AndroidX.AppCompat.AppCompatResources.dll.so => 75
	i64 u0x43375950ec7c1b6a, ; 132: netstandard.dll => 165
	i64 u0x434c4e1d9284cdae, ; 133: Mono.Android.dll => 169
	i64 u0x43950f84de7cc79a, ; 134: pl/Microsoft.Maui.Controls.resources.dll => 20
	i64 u0x4499fa3c8e494654, ; 135: lib_System.Runtime.Serialization.Primitives.dll.so => 148
	i64 u0x4515080865a951a5, ; 136: Xamarin.Kotlin.StdLib.dll => 100
	i64 u0x45c40276a42e283e, ; 137: System.Diagnostics.TraceSource => 117
	i64 u0x46a4213bc97fe5ae, ; 138: lib-ru-Microsoft.Maui.Controls.resources.dll.so => 24
	i64 u0x47358bd471172e1d, ; 139: lib_System.Xml.Linq.dll.so => 161
	i64 u0x47daf4e1afbada10, ; 140: pt/Microsoft.Maui.Controls.resources => 22
	i64 u0x48a6d2fa2eb5d049, ; 141: Microsoft.AspNetCore.SignalR.Protocols.Json => 46
	i64 u0x49e952f19a4e2022, ; 142: System.ObjectModel => 139
	i64 u0x4a5667b2462a664b, ; 143: lib_Xamarin.AndroidX.Navigation.UI.dll.so => 93
	i64 u0x4a78a24dc5b649fc, ; 144: Syncfusion.Maui.Core.dll => 67
	i64 u0x4b7b6532ded934b7, ; 145: System.Text.Json => 155
	i64 u0x4c7755cf07ad2d5f, ; 146: System.Net.Http.Json.dll => 127
	i64 u0x4cc5f15266470798, ; 147: lib_Xamarin.AndroidX.Loader.dll.so => 89
	i64 u0x4cf6f67dc77aacd2, ; 148: System.Net.NetworkInformation.dll => 130
	i64 u0x4d3183dd245425d4, ; 149: System.Net.WebSockets.Client.dll => 136
	i64 u0x4d479f968a05e504, ; 150: System.Linq.Expressions.dll => 124
	i64 u0x4d55a010ffc4faff, ; 151: System.Private.Xml => 143
	i64 u0x4d95fccc1f67c7ca, ; 152: System.Runtime.Loader.dll => 145
	i64 u0x4dcf44c3c9b076a2, ; 153: it/Microsoft.Maui.Controls.resources.dll => 14
	i64 u0x4dd9247f1d2c3235, ; 154: Xamarin.AndroidX.Loader.dll => 89
	i64 u0x4e32f00cb0937401, ; 155: Mono.Android.Runtime => 168
	i64 u0x4e39d45ce072e04b, ; 156: Microsoft.AspNetCore.SignalR.Common.dll => 45
	i64 u0x4ebd0c4b82c5eefc, ; 157: lib_System.Threading.Channels.dll.so => 157
	i64 u0x4f21ee6ef9eb527e, ; 158: ca/Microsoft.Maui.Controls.resources => 1
	i64 u0x5037f0be3c28c7a3, ; 159: lib_Microsoft.Maui.Controls.dll.so => 59
	i64 u0x5112ed116d87baf8, ; 160: CommunityToolkit.Mvvm => 38
	i64 u0x5131bbe80989093f, ; 161: Xamarin.AndroidX.Lifecycle.ViewModel.Android.dll => 87
	i64 u0x51bb8a2afe774e32, ; 162: System.Drawing => 119
	i64 u0x526ce79eb8e90527, ; 163: lib_System.Net.Primitives.dll.so => 131
	i64 u0x529ffe06f39ab8db, ; 164: Xamarin.AndroidX.Core => 80
	i64 u0x52ff996554dbf352, ; 165: Microsoft.Maui.Graphics => 63
	i64 u0x535f7e40e8fef8af, ; 166: lib-sk-Microsoft.Maui.Controls.resources.dll.so => 25
	i64 u0x53a96d5c86c9e194, ; 167: System.Net.NetworkInformation => 130
	i64 u0x53c3014b9437e684, ; 168: lib-zh-HK-Microsoft.Maui.Controls.resources.dll.so => 31
	i64 u0x5435e6f049e9bc37, ; 169: System.Security.Claims.dll => 151
	i64 u0x54795225dd1587af, ; 170: lib_System.Runtime.dll.so => 150
	i64 u0x556e8b63b660ab8b, ; 171: Xamarin.AndroidX.Lifecycle.Common.Jvm.dll => 85
	i64 u0x5588627c9a108ec9, ; 172: System.Collections.Specialized => 108
	i64 u0x56442b99bc64bb47, ; 173: System.Runtime.Serialization.Xml.dll => 149
	i64 u0x571c5cfbec5ae8e2, ; 174: System.Private.Uri => 141
	i64 u0x579a06fed6eec900, ; 175: System.Private.CoreLib.dll => 166
	i64 u0x57c542c14049b66d, ; 176: System.Diagnostics.DiagnosticSource => 115
	i64 u0x58601b2dda4a27b9, ; 177: lib-ja-Microsoft.Maui.Controls.resources.dll.so => 15
	i64 u0x58688d9af496b168, ; 178: Microsoft.Extensions.DependencyInjection.dll => 49
	i64 u0x5a89a886ae30258d, ; 179: lib_Xamarin.AndroidX.CoordinatorLayout.dll.so => 79
	i64 u0x5a8f6699f4a1caa9, ; 180: lib_System.Threading.dll.so => 159
	i64 u0x5ae9cd33b15841bf, ; 181: System.ComponentModel => 113
	i64 u0x5b247cf480c75903, ; 182: Microsoft.AspNetCore.Http.Connections.Common.dll => 41
	i64 u0x5b54391bdc6fcfe6, ; 183: System.Private.DataContractSerialization => 140
	i64 u0x5b5f0e240a06a2a2, ; 184: da/Microsoft.Maui.Controls.resources.dll => 3
	i64 u0x5c294d94f201783b, ; 185: lib_Microsoft.AspNetCore.Http.Connections.Client.dll.so => 40
	i64 u0x5c393624b8176517, ; 186: lib_Microsoft.Extensions.Logging.dll.so => 55
	i64 u0x5d0a4a29b02d9d3c, ; 187: System.Net.WebHeaderCollection.dll => 135
	i64 u0x5db0cbbd1028510e, ; 188: lib_System.Runtime.InteropServices.dll.so => 144
	i64 u0x5db30905d3e5013b, ; 189: Xamarin.AndroidX.Collection.Jvm.dll => 78
	i64 u0x5e467bc8f09ad026, ; 190: System.Collections.Specialized.dll => 108
	i64 u0x5ea92fdb19ec8c4c, ; 191: System.Text.Encodings.Web.dll => 154
	i64 u0x5eb8046dd40e9ac3, ; 192: System.ComponentModel.Primitives => 111
	i64 u0x5f36ccf5c6a57e24, ; 193: System.Xml.ReaderWriter.dll => 162
	i64 u0x5f9a2d823f664957, ; 194: lib-el-Microsoft.Maui.Controls.resources.dll.so => 5
	i64 u0x609f4b7b63d802d4, ; 195: lib_Microsoft.Extensions.DependencyInjection.dll.so => 49
	i64 u0x60cd4e33d7e60134, ; 196: Xamarin.KotlinX.Coroutines.Core.Jvm => 101
	i64 u0x60f62d786afcf130, ; 197: System.Memory => 126
	i64 u0x61be8d1299194243, ; 198: Microsoft.Maui.Controls.Xaml => 60
	i64 u0x61d2cba29557038f, ; 199: de/Microsoft.Maui.Controls.resources => 4
	i64 u0x61d88f399afb2f45, ; 200: lib_System.Runtime.Loader.dll.so => 145
	i64 u0x622eef6f9e59068d, ; 201: System.Private.CoreLib => 166
	i64 u0x63f1f6883c1e23c2, ; 202: lib_System.Collections.Immutable.dll.so => 106
	i64 u0x6400f68068c1e9f1, ; 203: Xamarin.Google.Android.Material.dll => 99
	i64 u0x64b61dd9da8a4d57, ; 204: System.Net.ServerSentEvents.dll => 72
	i64 u0x658f524e4aba7dad, ; 205: CommunityToolkit.Maui.dll => 36
	i64 u0x659dc45417570048, ; 206: Refit => 64
	i64 u0x65ecac39144dd3cc, ; 207: Microsoft.Maui.Controls.dll => 59
	i64 u0x65ece51227bfa724, ; 208: lib_System.Runtime.Numerics.dll.so => 146
	i64 u0x6692e924eade1b29, ; 209: lib_System.Console.dll.so => 114
	i64 u0x66a4e5c6a3fb0bae, ; 210: lib_Xamarin.AndroidX.Lifecycle.ViewModel.Android.dll.so => 87
	i64 u0x66d13304ce1a3efa, ; 211: Xamarin.AndroidX.CursorAdapter => 81
	i64 u0x672a10d319608935, ; 212: lib_Microsoft.AspNetCore.Http.Connections.Common.dll.so => 41
	i64 u0x68558ec653afa616, ; 213: lib-da-Microsoft.Maui.Controls.resources.dll.so => 3
	i64 u0x6872ec7a2e36b1ac, ; 214: System.Drawing.Primitives.dll => 118
	i64 u0x68fbbbe2eb455198, ; 215: System.Formats.Asn1 => 120
	i64 u0x69063fc0ba8e6bdd, ; 216: he/Microsoft.Maui.Controls.resources.dll => 9
	i64 u0x6a4d7577b2317255, ; 217: System.Runtime.InteropServices.dll => 144
	i64 u0x6ace3b74b15ee4a4, ; 218: nb/Microsoft.Maui.Controls.resources => 18
	i64 u0x6d12bfaa99c72b1f, ; 219: lib_Microsoft.Maui.Graphics.dll.so => 63
	i64 u0x6d79993361e10ef2, ; 220: Microsoft.Extensions.Primitives => 58
	i64 u0x6d86d56b84c8eb71, ; 221: lib_Xamarin.AndroidX.CursorAdapter.dll.so => 81
	i64 u0x6d9bea6b3e895cf7, ; 222: Microsoft.Extensions.Primitives.dll => 58
	i64 u0x6e25a02c3833319a, ; 223: lib_Xamarin.AndroidX.Navigation.Fragment.dll.so => 91
	i64 u0x6fd2265da78b93a4, ; 224: lib_Microsoft.Maui.dll.so => 61
	i64 u0x6fdfc7de82c33008, ; 225: cs/Microsoft.Maui.Controls.resources => 2
	i64 u0x70e99f48c05cb921, ; 226: tr/Microsoft.Maui.Controls.resources.dll => 28
	i64 u0x70fd3deda22442d2, ; 227: lib-nb-Microsoft.Maui.Controls.resources.dll.so => 18
	i64 u0x717530326f808838, ; 228: lib_Microsoft.Extensions.Diagnostics.Abstractions.dll.so => 52
	i64 u0x71a495ea3761dde8, ; 229: lib-it-Microsoft.Maui.Controls.resources.dll.so => 14
	i64 u0x71ad672adbe48f35, ; 230: System.ComponentModel.Primitives.dll => 111
	i64 u0x7242820f67bc4ad6, ; 231: Microsoft.AspNetCore.SignalR.Common => 45
	i64 u0x72b1fb4109e08d7b, ; 232: lib-hr-Microsoft.Maui.Controls.resources.dll.so => 11
	i64 u0x733c9fa4b145dea1, ; 233: lib_SocialMauiApp.dll.so => 104
	i64 u0x73e4ce94e2eb6ffc, ; 234: lib_System.Memory.dll.so => 126
	i64 u0x746cf89b511b4d40, ; 235: lib_Microsoft.Extensions.Diagnostics.dll.so => 51
	i64 u0x755a91767330b3d4, ; 236: lib_Microsoft.Extensions.Configuration.dll.so => 47
	i64 u0x758463c93f0d589e, ; 237: lib_Microsoft.AspNetCore.Connections.Abstractions.dll.so => 39
	i64 u0x76012e7334db86e5, ; 238: lib_Xamarin.AndroidX.SavedState.dll.so => 95
	i64 u0x76ca07b878f44da0, ; 239: System.Runtime.Numerics.dll => 146
	i64 u0x77d9074d8f33a303, ; 240: lib_System.Net.ServerSentEvents.dll.so => 72
	i64 u0x780bc73597a503a9, ; 241: lib-ms-Microsoft.Maui.Controls.resources.dll.so => 17
	i64 u0x783606d1e53e7a1a, ; 242: th/Microsoft.Maui.Controls.resources.dll => 27
	i64 u0x78a1938b89c96721, ; 243: Microsoft.AspNetCore.Http.Connections.Common => 41
	i64 u0x78a45e51311409b6, ; 244: Xamarin.AndroidX.Fragment.dll => 84
	i64 u0x7985af0fe05692bb, ; 245: lib_SocialMediaMaui.Shared.dll.so => 103
	i64 u0x7a25bdb29108c6e7, ; 246: Microsoft.Extensions.Http => 54
	i64 u0x7adb8da2ac89b647, ; 247: fi/Microsoft.Maui.Controls.resources.dll => 7
	i64 u0x7bef86a4335c4870, ; 248: System.ComponentModel.TypeConverter => 112
	i64 u0x7c0820144cd34d6a, ; 249: sk/Microsoft.Maui.Controls.resources.dll => 25
	i64 u0x7c2a0bd1e0f988fc, ; 250: lib-de-Microsoft.Maui.Controls.resources.dll.so => 4
	i64 u0x7cc637f941f716d0, ; 251: CommunityToolkit.Maui.Core => 37
	i64 u0x7d49c593eeb09ac9, ; 252: Microsoft.AspNetCore.SignalR.Client.dll => 43
	i64 u0x7d649b75d580bb42, ; 253: ms/Microsoft.Maui.Controls.resources.dll => 17
	i64 u0x7d8ee2bdc8e3aad1, ; 254: System.Numerics.Vectors => 138
	i64 u0x7dfc3d6d9d8d7b70, ; 255: System.Collections => 109
	i64 u0x7e302e110e1e1346, ; 256: lib_System.Security.Claims.dll.so => 151
	i64 u0x7e946809d6008ef2, ; 257: lib_System.ObjectModel.dll.so => 139
	i64 u0x7ecc13347c8fd849, ; 258: lib_System.ComponentModel.dll.so => 113
	i64 u0x7eff369f2e01cf95, ; 259: Microsoft.AspNetCore.Http.Features => 42
	i64 u0x7f00ddd9b9ca5a13, ; 260: Xamarin.AndroidX.ViewPager.dll => 97
	i64 u0x7f9351cd44b1273f, ; 261: Microsoft.Extensions.Configuration.Abstractions => 48
	i64 u0x7fbd557c99b3ce6f, ; 262: lib_Xamarin.AndroidX.Lifecycle.LiveData.Core.dll.so => 86
	i64 u0x812c069d5cdecc17, ; 263: System.dll => 163
	i64 u0x81ab745f6c0f5ce6, ; 264: zh-Hant/Microsoft.Maui.Controls.resources => 33
	i64 u0x8277f2be6b5ce05f, ; 265: Xamarin.AndroidX.AppCompat => 74
	i64 u0x828f06563b30bc50, ; 266: lib_Xamarin.AndroidX.CardView.dll.so => 77
	i64 u0x82df8f5532a10c59, ; 267: lib_System.Drawing.dll.so => 119
	i64 u0x82f6403342e12049, ; 268: uk/Microsoft.Maui.Controls.resources => 29
	i64 u0x83c14ba66c8e2b8c, ; 269: zh-Hans/Microsoft.Maui.Controls.resources => 32
	i64 u0x846f52335a832137, ; 270: Microsoft.Extensions.Features => 53
	i64 u0x8636d45a3b98cdf7, ; 271: Syncfusion.Maui.ImageEditor => 68
	i64 u0x86a909228dc7657b, ; 272: lib-zh-Hant-Microsoft.Maui.Controls.resources.dll.so => 33
	i64 u0x86b3e00c36b84509, ; 273: Microsoft.Extensions.Configuration.dll => 47
	i64 u0x86b62cb077ec4fd7, ; 274: System.Runtime.Serialization.Xml => 149
	i64 u0x87a3c575cf2318ce, ; 275: Syncfusion.Maui.Sliders.dll => 69
	i64 u0x87c69b87d9283884, ; 276: lib_System.Threading.Thread.dll.so => 158
	i64 u0x87f6569b25707834, ; 277: System.IO.Compression.Brotli.dll => 121
	i64 u0x8842b3a5d2d3fb36, ; 278: Microsoft.Maui.Essentials => 62
	i64 u0x88bda98e0cffb7a9, ; 279: lib_Xamarin.KotlinX.Coroutines.Core.Jvm.dll.so => 101
	i64 u0x890981e3e80b7d74, ; 280: lib_Syncfusion.Maui.ImageEditor.dll.so => 68
	i64 u0x8930322c7bd8f768, ; 281: netstandard => 165
	i64 u0x897a606c9e39c75f, ; 282: lib_System.ComponentModel.Primitives.dll.so => 111
	i64 u0x8a14bf4400a024af, ; 283: lib_Microsoft.AspNetCore.Http.Features.dll.so => 42
	i64 u0x8ac8d025b93e29e9, ; 284: Syncfusion.Licensing => 66
	i64 u0x8ad229ea26432ee2, ; 285: Xamarin.AndroidX.Loader => 89
	i64 u0x8b42b55a5bb040b5, ; 286: lib_Microsoft.AspNetCore.SignalR.Protocols.Json.dll.so => 46
	i64 u0x8b4ff5d0fdd5faa1, ; 287: lib_System.Diagnostics.DiagnosticSource.dll.so => 115
	i64 u0x8b8d01333a96d0b5, ; 288: System.Diagnostics.Process.dll => 116
	i64 u0x8b9ceca7acae3451, ; 289: lib-he-Microsoft.Maui.Controls.resources.dll.so => 9
	i64 u0x8d0f420977c2c1c7, ; 290: Xamarin.AndroidX.CursorAdapter.dll => 81
	i64 u0x8d5f431bf67cc907, ; 291: SocialMediaMaui.Shared => 103
	i64 u0x8d7b8ab4b3310ead, ; 292: System.Threading => 159
	i64 u0x8da188285aadfe8e, ; 293: System.Collections.Concurrent => 105
	i64 u0x8e623fec9635e28f, ; 294: Syncfusion.Maui.Toolkit.resources.dll => 71
	i64 u0x8ed807bfe9858dfc, ; 295: Xamarin.AndroidX.Navigation.Common => 90
	i64 u0x8ee08b8194a30f48, ; 296: lib-hi-Microsoft.Maui.Controls.resources.dll.so => 10
	i64 u0x8ef7601039857a44, ; 297: lib-ro-Microsoft.Maui.Controls.resources.dll.so => 23
	i64 u0x8f32c6f611f6ffab, ; 298: pt/Microsoft.Maui.Controls.resources.dll => 22
	i64 u0x8f8829d21c8985a4, ; 299: lib-pt-BR-Microsoft.Maui.Controls.resources.dll.so => 21
	i64 u0x90263f8448b8f572, ; 300: lib_System.Diagnostics.TraceSource.dll.so => 117
	i64 u0x903101b46fb73a04, ; 301: _Microsoft.Android.Resource.Designer => 35
	i64 u0x90393bd4865292f3, ; 302: lib_System.IO.Compression.dll.so => 122
	i64 u0x90634f86c5ebe2b5, ; 303: Xamarin.AndroidX.Lifecycle.ViewModel.Android => 87
	i64 u0x907b636704ad79ef, ; 304: lib_Microsoft.Maui.Controls.Xaml.dll.so => 60
	i64 u0x90ae2b5b8b652f2a, ; 305: lib_Microsoft.AspNetCore.SignalR.Client.Core.dll.so => 44
	i64 u0x91418dc638b29e68, ; 306: lib_Xamarin.AndroidX.CustomView.dll.so => 82
	i64 u0x9157bd523cd7ed36, ; 307: lib_System.Text.Json.dll.so => 155
	i64 u0x91a74f07b30d37e2, ; 308: System.Linq.dll => 125
	i64 u0x91fa41a87223399f, ; 309: ca/Microsoft.Maui.Controls.resources.dll => 1
	i64 u0x92dd6c6033393bf7, ; 310: Syncfusion.Maui.Toolkit.resources => 71
	i64 u0x93cfa73ab28d6e35, ; 311: ms/Microsoft.Maui.Controls.resources => 17
	i64 u0x944077d8ca3c6580, ; 312: System.IO.Compression.dll => 122
	i64 u0x957a4cdfdcfd6d83, ; 313: Refit.HttpClientFactory.dll => 65
	i64 u0x967fc325e09bfa8c, ; 314: es/Microsoft.Maui.Controls.resources => 6
	i64 u0x9732d8dbddea3d9a, ; 315: id/Microsoft.Maui.Controls.resources => 13
	i64 u0x978be80e5210d31b, ; 316: Microsoft.Maui.Graphics.dll => 63
	i64 u0x97b8c771ea3e4220, ; 317: System.ComponentModel.dll => 113
	i64 u0x97e144c9d3c6976e, ; 318: System.Collections.Concurrent.dll => 105
	i64 u0x991d510397f92d9d, ; 319: System.Linq.Expressions => 124
	i64 u0x999cb19e1a04ffd3, ; 320: CommunityToolkit.Mvvm.dll => 38
	i64 u0x99a00ca5270c6878, ; 321: Xamarin.AndroidX.Navigation.Runtime => 92
	i64 u0x99cdc6d1f2d3a72f, ; 322: ko/Microsoft.Maui.Controls.resources.dll => 16
	i64 u0x9c244ac7cda32d26, ; 323: System.Security.Cryptography.X509Certificates.dll => 152
	i64 u0x9d5dbcf5a48583fe, ; 324: lib_Xamarin.AndroidX.Activity.dll.so => 73
	i64 u0x9d74dee1a7725f34, ; 325: Microsoft.Extensions.Configuration.Abstractions.dll => 48
	i64 u0x9e4534b6adaf6e84, ; 326: nl/Microsoft.Maui.Controls.resources => 19
	i64 u0x9eaf1efdf6f7267e, ; 327: Xamarin.AndroidX.Navigation.Common.dll => 90
	i64 u0x9ef542cf1f78c506, ; 328: Xamarin.AndroidX.Lifecycle.LiveData.Core => 86
	i64 u0x9f5c7301a67b9123, ; 329: lib_Syncfusion.Maui.Sliders.dll.so => 69
	i64 u0xa05475503f80b7d9, ; 330: Microsoft.AspNetCore.Connections.Abstractions => 39
	i64 u0xa0d8259f4cc284ec, ; 331: lib_System.Security.Cryptography.dll.so => 153
	i64 u0xa1440773ee9d341e, ; 332: Xamarin.Google.Android.Material => 99
	i64 u0xa1b9d7c27f47219f, ; 333: Xamarin.AndroidX.Navigation.UI.dll => 93
	i64 u0xa2572680829d2c7c, ; 334: System.IO.Pipelines.dll => 123
	i64 u0xa308401900e5bed3, ; 335: lib_mscorlib.dll.so => 164
	i64 u0xa46aa1eaa214539b, ; 336: ko/Microsoft.Maui.Controls.resources => 16
	i64 u0xa4a372eecb9e4df0, ; 337: Microsoft.Extensions.Diagnostics => 51
	i64 u0xa4d20d2ff0563d26, ; 338: lib_CommunityToolkit.Mvvm.dll.so => 38
	i64 u0xa5494f40f128ce6a, ; 339: System.Runtime.Serialization.Formatters.dll => 147
	i64 u0xa5e599d1e0524750, ; 340: System.Numerics.Vectors.dll => 138
	i64 u0xa5f1ba49b85dd355, ; 341: System.Security.Cryptography.dll => 153
	i64 u0xa67dbee13e1df9ca, ; 342: Xamarin.AndroidX.SavedState.dll => 95
	i64 u0xa68a420042bb9b1f, ; 343: Xamarin.AndroidX.DrawerLayout.dll => 83
	i64 u0xa78ce3745383236a, ; 344: Xamarin.AndroidX.Lifecycle.Common.Jvm => 85
	i64 u0xa7c31b56b4dc7b33, ; 345: hu/Microsoft.Maui.Controls.resources => 12
	i64 u0xa964304b5631e28a, ; 346: CommunityToolkit.Maui.Core.dll => 37
	i64 u0xaa2219c8e3449ff5, ; 347: Microsoft.Extensions.Logging.Abstractions => 56
	i64 u0xaa443ac34067eeef, ; 348: System.Private.Xml.dll => 143
	i64 u0xaa52de307ef5d1dd, ; 349: System.Net.Http => 128
	i64 u0xaaaf86367285a918, ; 350: Microsoft.Extensions.DependencyInjection.Abstractions.dll => 50
	i64 u0xaaf84bb3f052a265, ; 351: el/Microsoft.Maui.Controls.resources => 5
	i64 u0xab9c1b2687d86b0b, ; 352: lib_System.Linq.Expressions.dll.so => 124
	i64 u0xac03339b985f4d59, ; 353: Microsoft.AspNetCore.SignalR.Client.Core.dll => 44
	i64 u0xac2af3fa195a15ce, ; 354: System.Runtime.Numerics => 146
	i64 u0xac5376a2a538dc10, ; 355: Xamarin.AndroidX.Lifecycle.LiveData.Core.dll => 86
	i64 u0xacd46e002c3ccb97, ; 356: ro/Microsoft.Maui.Controls.resources => 23
	i64 u0xacf42eea7ef9cd12, ; 357: System.Threading.Channels => 157
	i64 u0xad89c07347f1bad6, ; 358: nl/Microsoft.Maui.Controls.resources.dll => 19
	i64 u0xadbb53caf78a79d2, ; 359: System.Web.HttpUtility => 160
	i64 u0xadc90ab061a9e6e4, ; 360: System.ComponentModel.TypeConverter.dll => 112
	i64 u0xadf511667bef3595, ; 361: System.Net.Security => 133
	i64 u0xae282bcd03739de7, ; 362: Java.Interop => 167
	i64 u0xae53579c90db1107, ; 363: System.ObjectModel.dll => 139
	i64 u0xaf4829c0b3e740ae, ; 364: lib_Syncfusion.Maui.Toolkit.resources.dll.so => 71
	i64 u0xafe29f45095518e7, ; 365: lib_Xamarin.AndroidX.Lifecycle.ViewModelSavedState.dll.so => 88
	i64 u0xb05cc42cd94c6d9d, ; 366: lib-sv-Microsoft.Maui.Controls.resources.dll.so => 26
	i64 u0xb220631954820169, ; 367: System.Text.RegularExpressions => 156
	i64 u0xb2a3f67f3bf29fce, ; 368: da/Microsoft.Maui.Controls.resources => 3
	i64 u0xb3f0a0fcda8d3ebc, ; 369: Xamarin.AndroidX.CardView => 77
	i64 u0xb3f832258cb83db4, ; 370: Syncfusion.Licensing.dll => 66
	i64 u0xb46be1aa6d4fff93, ; 371: hi/Microsoft.Maui.Controls.resources => 10
	i64 u0xb477491be13109d8, ; 372: ar/Microsoft.Maui.Controls.resources => 0
	i64 u0xb4bd7015ecee9d86, ; 373: System.IO.Pipelines => 123
	i64 u0xb5c7fcdafbc67ee4, ; 374: Microsoft.Extensions.Logging.Abstractions.dll => 56
	i64 u0xb7212c4683a94afe, ; 375: System.Drawing.Primitives => 118
	i64 u0xb7b7753d1f319409, ; 376: sv/Microsoft.Maui.Controls.resources => 26
	i64 u0xb81a2c6e0aee50fe, ; 377: lib_System.Private.CoreLib.dll.so => 166
	i64 u0xb872c26142d22aa9, ; 378: Microsoft.Extensions.Http.dll => 54
	i64 u0xb9f64d3b230def68, ; 379: lib-pt-Microsoft.Maui.Controls.resources.dll.so => 22
	i64 u0xb9fc3c8a556e3691, ; 380: ja/Microsoft.Maui.Controls.resources => 15
	i64 u0xba48785529705af9, ; 381: System.Collections.dll => 109
	i64 u0xbb65706fde942ce3, ; 382: System.Net.Sockets => 134
	i64 u0xbbd180354b67271a, ; 383: System.Runtime.Serialization.Formatters => 147
	i64 u0xbd0e2c0d55246576, ; 384: System.Net.Http.dll => 128
	i64 u0xbd437a2cdb333d0d, ; 385: Xamarin.AndroidX.ViewPager2 => 98
	i64 u0xbd5d0b88d3d647a5, ; 386: lib_Xamarin.AndroidX.Browser.dll.so => 76
	i64 u0xbee38d4a88835966, ; 387: Xamarin.AndroidX.AppCompat.AppCompatResources => 75
	i64 u0xbfc1e1fb3095f2b3, ; 388: lib_System.Net.Http.Json.dll.so => 127
	i64 u0xc040a4ab55817f58, ; 389: ar/Microsoft.Maui.Controls.resources.dll => 0
	i64 u0xc0d928351ab5ca77, ; 390: System.Console.dll => 114
	i64 u0xc12b8b3afa48329c, ; 391: lib_System.Linq.dll.so => 125
	i64 u0xc1347413e524ff69, ; 392: lib_Syncfusion.Maui.Toolkit.dll.so => 70
	i64 u0xc1ff9ae3cdb6e1e6, ; 393: Xamarin.AndroidX.Activity.dll => 73
	i64 u0xc28c50f32f81cc73, ; 394: ja/Microsoft.Maui.Controls.resources.dll => 15
	i64 u0xc2bcfec99f69365e, ; 395: Xamarin.AndroidX.ViewPager2.dll => 98
	i64 u0xc30b52815b58ac2c, ; 396: lib_System.Runtime.Serialization.Xml.dll.so => 149
	i64 u0xc39ced8467203460, ; 397: lib_Refit.HttpClientFactory.dll.so => 65
	i64 u0xc421b61fd853169d, ; 398: lib_System.Net.WebSockets.Client.dll.so => 136
	i64 u0xc4d3858ed4d08512, ; 399: Xamarin.AndroidX.Lifecycle.ViewModelSavedState.dll => 88
	i64 u0xc4f2d57c50beb816, ; 400: lib_Microsoft.Extensions.Features.dll.so => 53
	i64 u0xc50fded0ded1418c, ; 401: lib_System.ComponentModel.TypeConverter.dll.so => 112
	i64 u0xc519125d6bc8fb11, ; 402: lib_System.Net.Requests.dll.so => 132
	i64 u0xc5293b19e4dc230e, ; 403: Xamarin.AndroidX.Navigation.Fragment => 91
	i64 u0xc5325b2fcb37446f, ; 404: lib_System.Private.Xml.dll.so => 143
	i64 u0xc5a0f4b95a699af7, ; 405: lib_System.Private.Uri.dll.so => 141
	i64 u0xc5de3dcae13c325f, ; 406: Microsoft.AspNetCore.SignalR.Client => 43
	i64 u0xc7ce851898a4548e, ; 407: lib_System.Web.HttpUtility.dll.so => 160
	i64 u0xc858a28d9ee5a6c5, ; 408: lib_System.Collections.Specialized.dll.so => 108
	i64 u0xc9e54b32fc19baf3, ; 409: lib_CommunityToolkit.Maui.dll.so => 36
	i64 u0xca3a723e7342c5b6, ; 410: lib-tr-Microsoft.Maui.Controls.resources.dll.so => 28
	i64 u0xcab3493c70141c2d, ; 411: pl/Microsoft.Maui.Controls.resources => 20
	i64 u0xcacfddc9f7c6de76, ; 412: ro/Microsoft.Maui.Controls.resources.dll => 23
	i64 u0xcbd4fdd9cef4a294, ; 413: lib__Microsoft.Android.Resource.Designer.dll.so => 35
	i64 u0xcc2876b32ef2794c, ; 414: lib_System.Text.RegularExpressions.dll.so => 156
	i64 u0xcc5c3bb714c4561e, ; 415: Xamarin.KotlinX.Coroutines.Core.Jvm.dll => 101
	i64 u0xcc76886e09b88260, ; 416: Xamarin.KotlinX.Serialization.Core.Jvm.dll => 102
	i64 u0xcce5f0b382db16b7, ; 417: Microsoft.AspNetCore.Http.Connections.Client => 40
	i64 u0xccf25c4b634ccd3a, ; 418: zh-Hans/Microsoft.Maui.Controls.resources.dll => 32
	i64 u0xcd10a42808629144, ; 419: System.Net.Requests => 132
	i64 u0xcdd0c48b6937b21c, ; 420: Xamarin.AndroidX.SwipeRefreshLayout => 96
	i64 u0xcf23d8093f3ceadf, ; 421: System.Diagnostics.DiagnosticSource.dll => 115
	i64 u0xcf8fc898f98b0d34, ; 422: System.Private.Xml.Linq => 142
	i64 u0xd1194e1d8a8de83c, ; 423: lib_Xamarin.AndroidX.Lifecycle.Common.Jvm.dll.so => 85
	i64 u0xd16fd7fb9bbcd43e, ; 424: Microsoft.Extensions.Diagnostics.Abstractions => 52
	i64 u0xd333d0af9e423810, ; 425: System.Runtime.InteropServices => 144
	i64 u0xd3426d966bb704f5, ; 426: Xamarin.AndroidX.AppCompat.AppCompatResources.dll => 75
	i64 u0xd3651b6fc3125825, ; 427: System.Private.Uri.dll => 141
	i64 u0xd373685349b1fe8b, ; 428: Microsoft.Extensions.Logging.dll => 55
	i64 u0xd3801faafafb7698, ; 429: System.Private.DataContractSerialization.dll => 140
	i64 u0xd3e4c8d6a2d5d470, ; 430: it/Microsoft.Maui.Controls.resources => 14
	i64 u0xd4645626dffec99d, ; 431: lib_Microsoft.Extensions.DependencyInjection.Abstractions.dll.so => 50
	i64 u0xd52f53c4b3d62e11, ; 432: Microsoft.AspNetCore.Connections.Abstractions.dll => 39
	i64 u0xd5507e11a2b2839f, ; 433: Xamarin.AndroidX.Lifecycle.ViewModelSavedState => 88
	i64 u0xd6694f8359737e4e, ; 434: Xamarin.AndroidX.SavedState => 95
	i64 u0xd6d21782156bc35b, ; 435: Xamarin.AndroidX.SwipeRefreshLayout.dll => 96
	i64 u0xd72329819cbbbc44, ; 436: lib_Microsoft.Extensions.Configuration.Abstractions.dll.so => 48
	i64 u0xd7b3764ada9d341d, ; 437: lib_Microsoft.Extensions.Logging.Abstractions.dll.so => 56
	i64 u0xda1dfa4c534a9251, ; 438: Microsoft.Extensions.DependencyInjection => 49
	i64 u0xdad05a11827959a3, ; 439: System.Collections.NonGeneric.dll => 107
	i64 u0xdb5383ab5865c007, ; 440: lib-vi-Microsoft.Maui.Controls.resources.dll.so => 30
	i64 u0xdbeda89f832aa805, ; 441: vi/Microsoft.Maui.Controls.resources.dll => 30
	i64 u0xdbf9607a441b4505, ; 442: System.Linq => 125
	i64 u0xdce2c53525640bf3, ; 443: Microsoft.Extensions.Logging => 55
	i64 u0xdd2b722d78ef5f43, ; 444: System.Runtime.dll => 150
	i64 u0xdd67031857c72f96, ; 445: lib_System.Text.Encodings.Web.dll.so => 154
	i64 u0xdde30e6b77aa6f6c, ; 446: lib-zh-Hans-Microsoft.Maui.Controls.resources.dll.so => 32
	i64 u0xde8769ebda7d8647, ; 447: hr/Microsoft.Maui.Controls.resources.dll => 11
	i64 u0xdf9c7682560a9629, ; 448: System.Net.ServerSentEvents => 72
	i64 u0xe0142572c095a480, ; 449: Xamarin.AndroidX.AppCompat.dll => 74
	i64 u0xe020c74e3723dc6f, ; 450: Syncfusion.Maui.Toolkit.dll => 70
	i64 u0xe02f89350ec78051, ; 451: Xamarin.AndroidX.CoordinatorLayout.dll => 79
	i64 u0xe02ff568f8e5f275, ; 452: Microsoft.AspNetCore.Http.Connections.Client.dll => 40
	i64 u0xe192a588d4410686, ; 453: lib_System.IO.Pipelines.dll.so => 123
	i64 u0xe1a08bd3fa539e0d, ; 454: System.Runtime.Loader => 145
	i64 u0xe1b52f9f816c70ef, ; 455: System.Private.Xml.Linq.dll => 142
	i64 u0xe1ecfdb7fff86067, ; 456: System.Net.Security.dll => 133
	i64 u0xe2420585aeceb728, ; 457: System.Net.Requests.dll => 132
	i64 u0xe29b73bc11392966, ; 458: lib-id-Microsoft.Maui.Controls.resources.dll.so => 13
	i64 u0xe2ee754535ca6dd6, ; 459: SocialMauiApp => 104
	i64 u0xe3811d68d4fe8463, ; 460: pt-BR/Microsoft.Maui.Controls.resources.dll => 21
	i64 u0xe494f7ced4ecd10a, ; 461: hu/Microsoft.Maui.Controls.resources.dll => 12
	i64 u0xe4a9b1e40d1e8917, ; 462: lib-fi-Microsoft.Maui.Controls.resources.dll.so => 7
	i64 u0xe4f74a0b5bf9703f, ; 463: System.Runtime.Serialization.Primitives => 148
	i64 u0xe5434e8a119ceb69, ; 464: lib_Mono.Android.dll.so => 169
	i64 u0xe7e7d98eda944101, ; 465: Syncfusion.Maui.Sliders => 69
	i64 u0xe89a2a9ef110899b, ; 466: System.Drawing.dll => 119
	i64 u0xea008206567504c4, ; 467: Syncfusion.Maui.Toolkit => 70
	i64 u0xebdfa33cea4bfcea, ; 468: SocialMediaMaui.Shared.dll => 103
	i64 u0xec14f495db71c005, ; 469: en-US/Syncfusion.Maui.ImageEditor.resources.dll => 34
	i64 u0xedc4817167106c23, ; 470: System.Net.Sockets.dll => 134
	i64 u0xedc632067fb20ff3, ; 471: System.Memory.dll => 126
	i64 u0xedc8e4ca71a02a8b, ; 472: Xamarin.AndroidX.Navigation.Runtime.dll => 92
	i64 u0xeeb7ebb80150501b, ; 473: lib_Xamarin.AndroidX.Collection.Jvm.dll.so => 78
	i64 u0xef72742e1bcca27a, ; 474: Microsoft.Maui.Essentials.dll => 62
	i64 u0xefec0b7fdc57ec42, ; 475: Xamarin.AndroidX.Activity => 73
	i64 u0xf00c29406ea45e19, ; 476: es/Microsoft.Maui.Controls.resources.dll => 6
	i64 u0xf038bf84c0c27e83, ; 477: lib_Microsoft.AspNetCore.SignalR.Client.dll.so => 43
	i64 u0xf09e47b6ae914f6e, ; 478: System.Net.NameResolution => 129
	i64 u0xf0de2537ee19c6ca, ; 479: lib_System.Net.WebHeaderCollection.dll.so => 135
	i64 u0xf11b621fc87b983f, ; 480: Microsoft.Maui.Controls.Xaml.dll => 60
	i64 u0xf1c4b4005493d871, ; 481: System.Formats.Asn1.dll => 120
	i64 u0xf238bd79489d3a96, ; 482: lib-nl-Microsoft.Maui.Controls.resources.dll.so => 19
	i64 u0xf37221fda4ef8830, ; 483: lib_Xamarin.Google.Android.Material.dll.so => 99
	i64 u0xf3ddfe05336abf29, ; 484: System => 163
	i64 u0xf4c1dd70a5496a17, ; 485: System.IO.Compression => 122
	i64 u0xf5fc7602fe27b333, ; 486: System.Net.WebHeaderCollection => 135
	i64 u0xf6077741019d7428, ; 487: Xamarin.AndroidX.CoordinatorLayout => 79
	i64 u0xf77b20923f07c667, ; 488: de/Microsoft.Maui.Controls.resources.dll => 4
	i64 u0xf7e2cac4c45067b3, ; 489: lib_System.Numerics.Vectors.dll.so => 138
	i64 u0xf7e74930e0e3d214, ; 490: zh-HK/Microsoft.Maui.Controls.resources.dll => 31
	i64 u0xf84773b5c81e3cef, ; 491: lib-uk-Microsoft.Maui.Controls.resources.dll.so => 29
	i64 u0xf8e045dc345b2ea3, ; 492: lib_Xamarin.AndroidX.RecyclerView.dll.so => 94
	i64 u0xf915dc29808193a1, ; 493: System.Web.HttpUtility.dll => 160
	i64 u0xf96c777a2a0686f4, ; 494: hi/Microsoft.Maui.Controls.resources.dll => 10
	i64 u0xf9eec5bb3a6aedc6, ; 495: Microsoft.Extensions.Options => 57
	i64 u0xfa3f278f288b0e84, ; 496: lib_System.Net.Security.dll.so => 133
	i64 u0xfa5ed7226d978949, ; 497: lib-ar-Microsoft.Maui.Controls.resources.dll.so => 0
	i64 u0xfa645d91e9fc4cba, ; 498: System.Threading.Thread => 158
	i64 u0xfbad3e4ce4b98145, ; 499: System.Security.Cryptography.X509Certificates => 152
	i64 u0xfbd71978549ea473, ; 500: Microsoft.AspNetCore.Http.Features.dll => 42
	i64 u0xfbf0a31c9fc34bc4, ; 501: lib_System.Net.Http.dll.so => 128
	i64 u0xfc6b7527cc280b3f, ; 502: lib_System.Runtime.Serialization.Formatters.dll.so => 147
	i64 u0xfc719aec26adf9d9, ; 503: Xamarin.AndroidX.Navigation.Fragment.dll => 91
	i64 u0xfd22f00870e40ae0, ; 504: lib_Xamarin.AndroidX.DrawerLayout.dll.so => 83
	i64 u0xfd583f7657b6a1cb, ; 505: Xamarin.AndroidX.Fragment => 84
	i64 u0xfda36abccf05cf5c, ; 506: System.Net.WebSockets.Client => 136
	i64 u0xfdbe4710aa9beeff, ; 507: CommunityToolkit.Maui => 36
	i64 u0xfeae9952cf03b8cb, ; 508: tr/Microsoft.Maui.Controls.resources => 28
	i64 u0xff9b54613e0d2cc8 ; 509: System.Net.Http.Json => 127
], align 8

@assembly_image_cache_indices = dso_local local_unnamed_addr constant [510 x i32] [
	i32 96, i32 64, i32 110, i32 45, i32 92, i32 37, i32 168, i32 74,
	i32 140, i32 24, i32 2, i32 30, i32 131, i32 94, i32 109, i32 61,
	i32 31, i32 161, i32 78, i32 164, i32 24, i32 107, i32 83, i32 110,
	i32 57, i32 107, i32 153, i32 157, i32 25, i32 102, i32 46, i32 97,
	i32 21, i32 169, i32 62, i32 129, i32 104, i32 82, i32 67, i32 121,
	i32 137, i32 34, i32 94, i32 76, i32 8, i32 167, i32 9, i32 50,
	i32 137, i32 44, i32 67, i32 165, i32 12, i32 154, i32 102, i32 18,
	i32 65, i32 151, i32 105, i32 163, i32 27, i32 51, i32 168, i32 93,
	i32 16, i32 57, i32 121, i32 116, i32 150, i32 27, i32 158, i32 114,
	i32 80, i32 148, i32 8, i32 100, i32 58, i32 13, i32 11, i32 137,
	i32 167, i32 131, i32 64, i32 52, i32 34, i32 29, i32 130, i32 117,
	i32 7, i32 156, i32 120, i32 33, i32 20, i32 142, i32 66, i32 159,
	i32 26, i32 155, i32 5, i32 53, i32 116, i32 162, i32 54, i32 84,
	i32 35, i32 77, i32 118, i32 8, i32 162, i32 106, i32 6, i32 134,
	i32 61, i32 2, i32 59, i32 110, i32 98, i32 47, i32 68, i32 106,
	i32 82, i32 129, i32 97, i32 1, i32 152, i32 100, i32 76, i32 161,
	i32 80, i32 90, i32 164, i32 75, i32 165, i32 169, i32 20, i32 148,
	i32 100, i32 117, i32 24, i32 161, i32 22, i32 46, i32 139, i32 93,
	i32 67, i32 155, i32 127, i32 89, i32 130, i32 136, i32 124, i32 143,
	i32 145, i32 14, i32 89, i32 168, i32 45, i32 157, i32 1, i32 59,
	i32 38, i32 87, i32 119, i32 131, i32 80, i32 63, i32 25, i32 130,
	i32 31, i32 151, i32 150, i32 85, i32 108, i32 149, i32 141, i32 166,
	i32 115, i32 15, i32 49, i32 79, i32 159, i32 113, i32 41, i32 140,
	i32 3, i32 40, i32 55, i32 135, i32 144, i32 78, i32 108, i32 154,
	i32 111, i32 162, i32 5, i32 49, i32 101, i32 126, i32 60, i32 4,
	i32 145, i32 166, i32 106, i32 99, i32 72, i32 36, i32 64, i32 59,
	i32 146, i32 114, i32 87, i32 81, i32 41, i32 3, i32 118, i32 120,
	i32 9, i32 144, i32 18, i32 63, i32 58, i32 81, i32 58, i32 91,
	i32 61, i32 2, i32 28, i32 18, i32 52, i32 14, i32 111, i32 45,
	i32 11, i32 104, i32 126, i32 51, i32 47, i32 39, i32 95, i32 146,
	i32 72, i32 17, i32 27, i32 41, i32 84, i32 103, i32 54, i32 7,
	i32 112, i32 25, i32 4, i32 37, i32 43, i32 17, i32 138, i32 109,
	i32 151, i32 139, i32 113, i32 42, i32 97, i32 48, i32 86, i32 163,
	i32 33, i32 74, i32 77, i32 119, i32 29, i32 32, i32 53, i32 68,
	i32 33, i32 47, i32 149, i32 69, i32 158, i32 121, i32 62, i32 101,
	i32 68, i32 165, i32 111, i32 42, i32 66, i32 89, i32 46, i32 115,
	i32 116, i32 9, i32 81, i32 103, i32 159, i32 105, i32 71, i32 90,
	i32 10, i32 23, i32 22, i32 21, i32 117, i32 35, i32 122, i32 87,
	i32 60, i32 44, i32 82, i32 155, i32 125, i32 1, i32 71, i32 17,
	i32 122, i32 65, i32 6, i32 13, i32 63, i32 113, i32 105, i32 124,
	i32 38, i32 92, i32 16, i32 152, i32 73, i32 48, i32 19, i32 90,
	i32 86, i32 69, i32 39, i32 153, i32 99, i32 93, i32 123, i32 164,
	i32 16, i32 51, i32 38, i32 147, i32 138, i32 153, i32 95, i32 83,
	i32 85, i32 12, i32 37, i32 56, i32 143, i32 128, i32 50, i32 5,
	i32 124, i32 44, i32 146, i32 86, i32 23, i32 157, i32 19, i32 160,
	i32 112, i32 133, i32 167, i32 139, i32 71, i32 88, i32 26, i32 156,
	i32 3, i32 77, i32 66, i32 10, i32 0, i32 123, i32 56, i32 118,
	i32 26, i32 166, i32 54, i32 22, i32 15, i32 109, i32 134, i32 147,
	i32 128, i32 98, i32 76, i32 75, i32 127, i32 0, i32 114, i32 125,
	i32 70, i32 73, i32 15, i32 98, i32 149, i32 65, i32 136, i32 88,
	i32 53, i32 112, i32 132, i32 91, i32 143, i32 141, i32 43, i32 160,
	i32 108, i32 36, i32 28, i32 20, i32 23, i32 35, i32 156, i32 101,
	i32 102, i32 40, i32 32, i32 132, i32 96, i32 115, i32 142, i32 85,
	i32 52, i32 144, i32 75, i32 141, i32 55, i32 140, i32 14, i32 50,
	i32 39, i32 88, i32 95, i32 96, i32 48, i32 56, i32 49, i32 107,
	i32 30, i32 30, i32 125, i32 55, i32 150, i32 154, i32 32, i32 11,
	i32 72, i32 74, i32 70, i32 79, i32 40, i32 123, i32 145, i32 142,
	i32 133, i32 132, i32 13, i32 104, i32 21, i32 12, i32 7, i32 148,
	i32 169, i32 69, i32 119, i32 70, i32 103, i32 34, i32 134, i32 126,
	i32 92, i32 78, i32 62, i32 73, i32 6, i32 43, i32 129, i32 135,
	i32 60, i32 120, i32 19, i32 99, i32 163, i32 122, i32 135, i32 79,
	i32 4, i32 138, i32 31, i32 29, i32 94, i32 160, i32 10, i32 57,
	i32 133, i32 0, i32 158, i32 152, i32 42, i32 128, i32 147, i32 91,
	i32 83, i32 84, i32 136, i32 36, i32 28, i32 127
], align 4

@marshal_methods_number_of_classes = dso_local local_unnamed_addr constant i32 0, align 4

@marshal_methods_class_cache = dso_local local_unnamed_addr global [0 x %struct.MarshalMethodsManagedClass] zeroinitializer, align 8

; Names of classes in which marshal methods reside
@mm_class_names = dso_local local_unnamed_addr constant [0 x ptr] zeroinitializer, align 8

@mm_method_names = dso_local local_unnamed_addr constant [1 x %struct.MarshalMethodName] [
	%struct.MarshalMethodName {
		i64 u0x0000000000000000, ; name: 
		ptr @.MarshalMethodName.0_name; char* name
	} ; 0
], align 8

; get_function_pointer (uint32_t mono_image_index, uint32_t class_index, uint32_t method_token, void*& target_ptr)
@get_function_pointer = internal dso_local unnamed_addr global ptr null, align 8

; Functions

; Function attributes: memory(write, argmem: none, inaccessiblemem: none) "min-legal-vector-width"="0" mustprogress nofree norecurse nosync "no-trapping-math"="true" nounwind "stack-protector-buffer-size"="8" uwtable willreturn
define void @xamarin_app_init(ptr nocapture noundef readnone %env, ptr noundef %fn) local_unnamed_addr #0
{
	%fnIsNull = icmp eq ptr %fn, null
	br i1 %fnIsNull, label %1, label %2

1: ; preds = %0
	%putsResult = call noundef i32 @puts(ptr @.str.0)
	call void @abort()
	unreachable 

2: ; preds = %1, %0
	store ptr %fn, ptr @get_function_pointer, align 8, !tbaa !3
	ret void
}

; Strings
@.str.0 = private unnamed_addr constant [40 x i8] c"get_function_pointer MUST be specified\0A\00", align 1

;MarshalMethodName
@.MarshalMethodName.0_name = private unnamed_addr constant [1 x i8] c"\00", align 1

; External functions

; Function attributes: noreturn "no-trapping-math"="true" nounwind "stack-protector-buffer-size"="8"
declare void @abort() local_unnamed_addr #2

; Function attributes: nofree nounwind
declare noundef i32 @puts(ptr noundef) local_unnamed_addr #1
attributes #0 = { memory(write, argmem: none, inaccessiblemem: none) "min-legal-vector-width"="0" mustprogress nofree norecurse nosync "no-trapping-math"="true" nounwind "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+fix-cortex-a53-835769,+neon,+outline-atomics,+v8a" uwtable willreturn }
attributes #1 = { nofree nounwind }
attributes #2 = { noreturn "no-trapping-math"="true" nounwind "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+fix-cortex-a53-835769,+neon,+outline-atomics,+v8a" }

; Metadata
!llvm.module.flags = !{!0, !1, !7, !8, !9, !10}
!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"PIC Level", i32 2}
!llvm.ident = !{!2}
!2 = !{!".NET for Android remotes/origin/release/9.0.1xx @ 1719a35b8a0348a4a8dd0061cfc4dd7fe6612a3c"}
!3 = !{!4, !4, i64 0}
!4 = !{!"any pointer", !5, i64 0}
!5 = !{!"omnipotent char", !6, i64 0}
!6 = !{!"Simple C++ TBAA"}
!7 = !{i32 1, !"branch-target-enforcement", i32 0}
!8 = !{i32 1, !"sign-return-address", i32 0}
!9 = !{i32 1, !"sign-return-address-all", i32 0}
!10 = !{i32 1, !"sign-return-address-with-bkey", i32 0}
