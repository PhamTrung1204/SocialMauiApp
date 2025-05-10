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

@assembly_image_cache = dso_local local_unnamed_addr global [177 x ptr] zeroinitializer, align 8

; Each entry maps hash of an assembly name to an index into the `assembly_image_cache` array
@assembly_image_cache_hashes = dso_local local_unnamed_addr constant [531 x i64] [
	i64 u0x0071cf2d27b7d61e, ; 0: lib_Xamarin.AndroidX.SwipeRefreshLayout.dll.so => 101
	i64 u0x00b3aadb3a4c4038, ; 1: lib_Refit.dll.so => 65
	i64 u0x01109b0e4d99e61f, ; 2: System.ComponentModel.Annotations.dll => 116
	i64 u0x018d2cc5e2de2b95, ; 3: lib_Microsoft.AspNetCore.SignalR.Common.dll.so => 45
	i64 u0x02123411c4e01926, ; 4: lib_Xamarin.AndroidX.Navigation.Runtime.dll.so => 96
	i64 u0x022e81ea9c46e03a, ; 5: lib_CommunityToolkit.Maui.Core.dll.so => 37
	i64 u0x02abedc11addc1ed, ; 6: lib_Mono.Android.Runtime.dll.so => 175
	i64 u0x032267b2a94db371, ; 7: lib_Xamarin.AndroidX.AppCompat.dll.so => 75
	i64 u0x0399610510a38a38, ; 8: lib_System.Private.DataContractSerialization.dll.so => 147
	i64 u0x043032f1d071fae0, ; 9: ru/Microsoft.Maui.Controls.resources => 24
	i64 u0x044440a55165631e, ; 10: lib-cs-Microsoft.Maui.Controls.resources.dll.so => 2
	i64 u0x046eb1581a80c6b0, ; 11: vi/Microsoft.Maui.Controls.resources => 30
	i64 u0x0517ef04e06e9f76, ; 12: System.Net.Primitives => 138
	i64 u0x0565d18c6da3de38, ; 13: Xamarin.AndroidX.RecyclerView => 98
	i64 u0x0581db89237110e9, ; 14: lib_System.Collections.dll.so => 115
	i64 u0x05989cb940b225a9, ; 15: Microsoft.Maui.dll => 61
	i64 u0x06076b5d2b581f08, ; 16: zh-HK/Microsoft.Maui.Controls.resources => 31
	i64 u0x06388ffe9f6c161a, ; 17: System.Xml.Linq.dll => 168
	i64 u0x0680a433c781bb3d, ; 18: Xamarin.AndroidX.Collection.Jvm => 80
	i64 u0x07469f2eecce9e85, ; 19: mscorlib.dll => 171
	i64 u0x07c57877c7ba78ad, ; 20: ru/Microsoft.Maui.Controls.resources.dll => 24
	i64 u0x07dcdc7460a0c5e4, ; 21: System.Collections.NonGeneric => 113
	i64 u0x08f3c9788ee2153c, ; 22: Xamarin.AndroidX.DrawerLayout => 85
	i64 u0x09138715c92dba90, ; 23: lib_System.ComponentModel.Annotations.dll.so => 116
	i64 u0x0919c28b89381a0b, ; 24: lib_Microsoft.Extensions.Options.dll.so => 57
	i64 u0x092266563089ae3e, ; 25: lib_System.Collections.NonGeneric.dll.so => 113
	i64 u0x09d144a7e214d457, ; 26: System.Security.Cryptography => 160
	i64 u0x0abb3e2b271edc45, ; 27: System.Threading.Channels.dll => 164
	i64 u0x0b3b632c3bbee20c, ; 28: sk/Microsoft.Maui.Controls.resources => 25
	i64 u0x0b6aff547b84fbe9, ; 29: Xamarin.KotlinX.Serialization.Core.Jvm => 108
	i64 u0x0b74b547d9e0e85d, ; 30: Microsoft.AspNetCore.SignalR.Protocols.Json.dll => 46
	i64 u0x0be2e1f8ce4064ed, ; 31: Xamarin.AndroidX.ViewPager => 102
	i64 u0x0c3ca6cc978e2aae, ; 32: pt-BR/Microsoft.Maui.Controls.resources => 21
	i64 u0x0c59ad9fbbd43abe, ; 33: Mono.Android => 176
	i64 u0x0c7790f60165fc06, ; 34: lib_Microsoft.Maui.Essentials.dll.so => 62
	i64 u0x0cce4bce83380b7f, ; 35: Xamarin.AndroidX.Security.SecurityCrypto => 100
	i64 u0x0e14e73a54dda68e, ; 36: lib_System.Net.NameResolution.dll.so => 136
	i64 u0x0fdf69c58fad2d0a, ; 37: SocialMauiApp.dll => 110
	i64 u0x102a31b45304b1da, ; 38: Xamarin.AndroidX.CustomView => 84
	i64 u0x10ca46a12d1cfb88, ; 39: Syncfusion.Maui.Core => 68
	i64 u0x10f6cfcbcf801616, ; 40: System.IO.Compression.Brotli => 128
	i64 u0x11a70d0e1009fb11, ; 41: System.Net.WebSockets.dll => 144
	i64 u0x11d2a2a57f14fcae, ; 42: Xamarin.AndroidX.Biometric => 77
	i64 u0x124908dccbc07697, ; 43: en-US/Syncfusion.Maui.ImageEditor.resources => 34
	i64 u0x125b7f94acb989db, ; 44: Xamarin.AndroidX.RecyclerView.dll => 98
	i64 u0x138567fa954faa55, ; 45: Xamarin.AndroidX.Browser => 78
	i64 u0x13a01de0cbc3f06c, ; 46: lib-fr-Microsoft.Maui.Controls.resources.dll.so => 8
	i64 u0x13f1e5e209e91af4, ; 47: lib_Java.Interop.dll.so => 174
	i64 u0x13f1e880c25d96d1, ; 48: he/Microsoft.Maui.Controls.resources => 9
	i64 u0x143d8ea60a6a4011, ; 49: Microsoft.Extensions.DependencyInjection.Abstractions => 50
	i64 u0x1497051b917530bd, ; 50: lib_System.Net.WebSockets.dll.so => 144
	i64 u0x15089560460fb845, ; 51: Microsoft.AspNetCore.SignalR.Client.Core => 44
	i64 u0x1695ecefb732cade, ; 52: lib_Syncfusion.Maui.Core.dll.so => 68
	i64 u0x17125c9a85b4929f, ; 53: lib_netstandard.dll.so => 172
	i64 u0x1752c12f1e1fc00c, ; 54: System.Core => 121
	i64 u0x17b56e25558a5d36, ; 55: lib-hu-Microsoft.Maui.Controls.resources.dll.so => 12
	i64 u0x17f9358913beb16a, ; 56: System.Text.Encodings.Web => 161
	i64 u0x18402a709e357f3b, ; 57: lib_Xamarin.KotlinX.Serialization.Core.Jvm.dll.so => 108
	i64 u0x18f0ce884e87d89a, ; 58: nb/Microsoft.Maui.Controls.resources.dll => 18
	i64 u0x18facb3695ca9224, ; 59: Refit.HttpClientFactory => 66
	i64 u0x19a4c090f14ebb66, ; 60: System.Security.Claims => 158
	i64 u0x1a91866a319e9259, ; 61: lib_System.Collections.Concurrent.dll.so => 111
	i64 u0x1aac34d1917ba5d3, ; 62: lib_System.dll.so => 170
	i64 u0x1aad60783ffa3e5b, ; 63: lib-th-Microsoft.Maui.Controls.resources.dll.so => 27
	i64 u0x1c292b1598348d77, ; 64: Microsoft.Extensions.Diagnostics.dll => 51
	i64 u0x1c753b5ff15bce1b, ; 65: Mono.Android.Runtime.dll => 175
	i64 u0x1da4110562816681, ; 66: Xamarin.AndroidX.Security.SecurityCrypto.dll => 100
	i64 u0x1e3d87657e9659bc, ; 67: Xamarin.AndroidX.Navigation.UI => 97
	i64 u0x1e71143913d56c10, ; 68: lib-ko-Microsoft.Maui.Controls.resources.dll.so => 16
	i64 u0x1ed8fcce5e9b50a0, ; 69: Microsoft.Extensions.Options.dll => 57
	i64 u0x209375905fcc1bad, ; 70: lib_System.IO.Compression.Brotli.dll.so => 128
	i64 u0x20fab3cf2dfbc8df, ; 71: lib_System.Diagnostics.Process.dll.so => 123
	i64 u0x2174319c0d835bc9, ; 72: System.Runtime => 157
	i64 u0x220fd4f2e7c48170, ; 73: th/Microsoft.Maui.Controls.resources => 27
	i64 u0x237be844f1f812c7, ; 74: System.Threading.Thread.dll => 165
	i64 u0x2407aef2bbe8fadf, ; 75: System.Console => 120
	i64 u0x240abe014b27e7d3, ; 76: Xamarin.AndroidX.Core.dll => 82
	i64 u0x247619fe4413f8bf, ; 77: System.Runtime.Serialization.Primitives.dll => 155
	i64 u0x252073cc3caa62c2, ; 78: fr/Microsoft.Maui.Controls.resources.dll => 8
	i64 u0x256b8d41255f01b1, ; 79: Xamarin.Google.Crypto.Tink.Android => 105
	i64 u0x2662c629b96b0b30, ; 80: lib_Xamarin.Kotlin.StdLib.dll.so => 106
	i64 u0x268c1439f13bcc29, ; 81: lib_Microsoft.Extensions.Primitives.dll.so => 58
	i64 u0x273f3515de5faf0d, ; 82: id/Microsoft.Maui.Controls.resources.dll => 13
	i64 u0x2742545f9094896d, ; 83: hr/Microsoft.Maui.Controls.resources => 11
	i64 u0x2759af78ab94d39b, ; 84: System.Net.WebSockets => 144
	i64 u0x27b2b16f3e9de038, ; 85: Xamarin.Google.Crypto.Tink.Android.dll => 105
	i64 u0x27b410442fad6cf1, ; 86: Java.Interop.dll => 174
	i64 u0x2801845a2c71fbfb, ; 87: System.Net.Primitives.dll => 138
	i64 u0x288f0dc6b8b36b5f, ; 88: Refit.dll => 65
	i64 u0x28e52865585a1ebe, ; 89: Microsoft.Extensions.Diagnostics.Abstractions.dll => 52
	i64 u0x298435b07b00e928, ; 90: lib-en-US-Syncfusion.Maui.ImageEditor.resources.dll.so => 34
	i64 u0x2a128783efe70ba0, ; 91: uk/Microsoft.Maui.Controls.resources.dll => 29
	i64 u0x2a3b095612184159, ; 92: lib_System.Net.NetworkInformation.dll.so => 137
	i64 u0x2a6507a5ffabdf28, ; 93: System.Diagnostics.TraceSource.dll => 124
	i64 u0x2ad156c8e1354139, ; 94: fi/Microsoft.Maui.Controls.resources => 7
	i64 u0x2af298f63581d886, ; 95: System.Text.RegularExpressions.dll => 163
	i64 u0x2afc1c4f898552ee, ; 96: lib_System.Formats.Asn1.dll.so => 127
	i64 u0x2b148910ed40fbf9, ; 97: zh-Hant/Microsoft.Maui.Controls.resources.dll => 33
	i64 u0x2c8bd14bb93a7d82, ; 98: lib-pl-Microsoft.Maui.Controls.resources.dll.so => 20
	i64 u0x2cd723e9fe623c7c, ; 99: lib_System.Private.Xml.Linq.dll.so => 149
	i64 u0x2cdbe1c1d4183ec1, ; 100: lib_Syncfusion.Licensing.dll.so => 67
	i64 u0x2d169d318a968379, ; 101: System.Threading.dll => 166
	i64 u0x2d47774b7d993f59, ; 102: sv/Microsoft.Maui.Controls.resources.dll => 26
	i64 u0x2db915caf23548d2, ; 103: System.Text.Json.dll => 162
	i64 u0x2e6f1f226821322a, ; 104: el/Microsoft.Maui.Controls.resources.dll => 5
	i64 u0x2e7c9658c7fb7927, ; 105: Microsoft.Extensions.Features.dll => 53
	i64 u0x2f02f94df3200fe5, ; 106: System.Diagnostics.Process => 123
	i64 u0x2f2e98e1c89b1aff, ; 107: System.Xml.ReaderWriter => 169
	i64 u0x2ff49de6a71764a1, ; 108: lib_Microsoft.Extensions.Http.dll.so => 54
	i64 u0x309ee9eeec09a71e, ; 109: lib_Xamarin.AndroidX.Fragment.dll.so => 86
	i64 u0x31195fef5d8fb552, ; 110: _Microsoft.Android.Resource.Designer.dll => 35
	i64 u0x32243413e774362a, ; 111: Xamarin.AndroidX.CardView.dll => 79
	i64 u0x3235427f8d12dae1, ; 112: lib_System.Drawing.Primitives.dll.so => 125
	i64 u0x329753a17a517811, ; 113: fr/Microsoft.Maui.Controls.resources => 8
	i64 u0x32aa989ff07a84ff, ; 114: lib_System.Xml.ReaderWriter.dll.so => 169
	i64 u0x33829542f112d59b, ; 115: System.Collections.Immutable => 112
	i64 u0x33a31443733849fe, ; 116: lib-es-Microsoft.Maui.Controls.resources.dll.so => 6
	i64 u0x341abc357fbb4ebf, ; 117: lib_System.Net.Sockets.dll.so => 141
	i64 u0x34dfd74fe2afcf37, ; 118: Microsoft.Maui => 61
	i64 u0x34e292762d9615df, ; 119: cs/Microsoft.Maui.Controls.resources.dll => 2
	i64 u0x3508234247f48404, ; 120: Microsoft.Maui.Controls => 59
	i64 u0x353590da528c9d22, ; 121: System.ComponentModel.Annotations => 116
	i64 u0x3549870798b4cd30, ; 122: lib_Xamarin.AndroidX.ViewPager2.dll.so => 103
	i64 u0x355282fc1c909694, ; 123: Microsoft.Extensions.Configuration => 47
	i64 u0x35ea419d842e2b43, ; 124: Syncfusion.Maui.ImageEditor.dll => 69
	i64 u0x380134e03b1e160a, ; 125: System.Collections.Immutable.dll => 112
	i64 u0x385c17636bb6fe6e, ; 126: Xamarin.AndroidX.CustomView.dll => 84
	i64 u0x38869c811d74050e, ; 127: System.Net.NameResolution.dll => 136
	i64 u0x393c226616977fdb, ; 128: lib_Xamarin.AndroidX.ViewPager.dll.so => 102
	i64 u0x395e37c3334cf82a, ; 129: lib-ca-Microsoft.Maui.Controls.resources.dll.so => 1
	i64 u0x3c3aafb6b3a00bf6, ; 130: lib_System.Security.Cryptography.X509Certificates.dll.so => 159
	i64 u0x3c7c495f58ac5ee9, ; 131: Xamarin.Kotlin.StdLib => 106
	i64 u0x3cd9d281d402eb9b, ; 132: Xamarin.AndroidX.Browser.dll => 78
	i64 u0x3d46f0b995082740, ; 133: System.Xml.Linq => 168
	i64 u0x3d9c2a242b040a50, ; 134: lib_Xamarin.AndroidX.Core.dll.so => 82
	i64 u0x407a10bb4bf95829, ; 135: lib_Xamarin.AndroidX.Navigation.Common.dll.so => 94
	i64 u0x41833cf766d27d96, ; 136: mscorlib => 171
	i64 u0x41cab042be111c34, ; 137: lib_Xamarin.AndroidX.AppCompat.AppCompatResources.dll.so => 76
	i64 u0x43375950ec7c1b6a, ; 138: netstandard.dll => 172
	i64 u0x434c4e1d9284cdae, ; 139: Mono.Android.dll => 176
	i64 u0x43950f84de7cc79a, ; 140: pl/Microsoft.Maui.Controls.resources.dll => 20
	i64 u0x4499fa3c8e494654, ; 141: lib_System.Runtime.Serialization.Primitives.dll.so => 155
	i64 u0x4515080865a951a5, ; 142: Xamarin.Kotlin.StdLib.dll => 106
	i64 u0x45c40276a42e283e, ; 143: System.Diagnostics.TraceSource => 124
	i64 u0x46a4213bc97fe5ae, ; 144: lib-ru-Microsoft.Maui.Controls.resources.dll.so => 24
	i64 u0x47358bd471172e1d, ; 145: lib_System.Xml.Linq.dll.so => 168
	i64 u0x47daf4e1afbada10, ; 146: pt/Microsoft.Maui.Controls.resources => 22
	i64 u0x48a6d2fa2eb5d049, ; 147: Microsoft.AspNetCore.SignalR.Protocols.Json => 46
	i64 u0x49e952f19a4e2022, ; 148: System.ObjectModel => 146
	i64 u0x4a5667b2462a664b, ; 149: lib_Xamarin.AndroidX.Navigation.UI.dll.so => 97
	i64 u0x4a78a24dc5b649fc, ; 150: Syncfusion.Maui.Core.dll => 68
	i64 u0x4b7b6532ded934b7, ; 151: System.Text.Json => 162
	i64 u0x4c7755cf07ad2d5f, ; 152: System.Net.Http.Json.dll => 134
	i64 u0x4cc5f15266470798, ; 153: lib_Xamarin.AndroidX.Loader.dll.so => 93
	i64 u0x4cf6f67dc77aacd2, ; 154: System.Net.NetworkInformation.dll => 137
	i64 u0x4d3183dd245425d4, ; 155: System.Net.WebSockets.Client.dll => 143
	i64 u0x4d479f968a05e504, ; 156: System.Linq.Expressions.dll => 131
	i64 u0x4d55a010ffc4faff, ; 157: System.Private.Xml => 150
	i64 u0x4d95fccc1f67c7ca, ; 158: System.Runtime.Loader.dll => 152
	i64 u0x4dcf44c3c9b076a2, ; 159: it/Microsoft.Maui.Controls.resources.dll => 14
	i64 u0x4dd9247f1d2c3235, ; 160: Xamarin.AndroidX.Loader.dll => 93
	i64 u0x4e32f00cb0937401, ; 161: Mono.Android.Runtime => 175
	i64 u0x4e39d45ce072e04b, ; 162: Microsoft.AspNetCore.SignalR.Common.dll => 45
	i64 u0x4ebd0c4b82c5eefc, ; 163: lib_System.Threading.Channels.dll.so => 164
	i64 u0x4f21ee6ef9eb527e, ; 164: ca/Microsoft.Maui.Controls.resources => 1
	i64 u0x5037f0be3c28c7a3, ; 165: lib_Microsoft.Maui.Controls.dll.so => 59
	i64 u0x5112ed116d87baf8, ; 166: CommunityToolkit.Mvvm => 38
	i64 u0x5131bbe80989093f, ; 167: Xamarin.AndroidX.Lifecycle.ViewModel.Android.dll => 91
	i64 u0x51bb8a2afe774e32, ; 168: System.Drawing => 126
	i64 u0x526ce79eb8e90527, ; 169: lib_System.Net.Primitives.dll.so => 138
	i64 u0x529ffe06f39ab8db, ; 170: Xamarin.AndroidX.Core => 82
	i64 u0x52ff996554dbf352, ; 171: Microsoft.Maui.Graphics => 63
	i64 u0x535f7e40e8fef8af, ; 172: lib-sk-Microsoft.Maui.Controls.resources.dll.so => 25
	i64 u0x53a96d5c86c9e194, ; 173: System.Net.NetworkInformation => 137
	i64 u0x53c3014b9437e684, ; 174: lib-zh-HK-Microsoft.Maui.Controls.resources.dll.so => 31
	i64 u0x5435e6f049e9bc37, ; 175: System.Security.Claims.dll => 158
	i64 u0x54795225dd1587af, ; 176: lib_System.Runtime.dll.so => 157
	i64 u0x547a34f14e5f6210, ; 177: Xamarin.AndroidX.Lifecycle.Common.dll => 87
	i64 u0x556e8b63b660ab8b, ; 178: Xamarin.AndroidX.Lifecycle.Common.Jvm.dll => 88
	i64 u0x5588627c9a108ec9, ; 179: System.Collections.Specialized => 114
	i64 u0x56442b99bc64bb47, ; 180: System.Runtime.Serialization.Xml.dll => 156
	i64 u0x571c5cfbec5ae8e2, ; 181: System.Private.Uri => 148
	i64 u0x579a06fed6eec900, ; 182: System.Private.CoreLib.dll => 173
	i64 u0x57c542c14049b66d, ; 183: System.Diagnostics.DiagnosticSource => 122
	i64 u0x58601b2dda4a27b9, ; 184: lib-ja-Microsoft.Maui.Controls.resources.dll.so => 15
	i64 u0x58688d9af496b168, ; 185: Microsoft.Extensions.DependencyInjection.dll => 49
	i64 u0x5a89a886ae30258d, ; 186: lib_Xamarin.AndroidX.CoordinatorLayout.dll.so => 81
	i64 u0x5a8f6699f4a1caa9, ; 187: lib_System.Threading.dll.so => 166
	i64 u0x5ae9cd33b15841bf, ; 188: System.ComponentModel => 119
	i64 u0x5b247cf480c75903, ; 189: Microsoft.AspNetCore.Http.Connections.Common.dll => 41
	i64 u0x5b54391bdc6fcfe6, ; 190: System.Private.DataContractSerialization => 147
	i64 u0x5b5f0e240a06a2a2, ; 191: da/Microsoft.Maui.Controls.resources.dll => 3
	i64 u0x5c294d94f201783b, ; 192: lib_Microsoft.AspNetCore.Http.Connections.Client.dll.so => 40
	i64 u0x5c393624b8176517, ; 193: lib_Microsoft.Extensions.Logging.dll.so => 55
	i64 u0x5d0a4a29b02d9d3c, ; 194: System.Net.WebHeaderCollection.dll => 142
	i64 u0x5db0cbbd1028510e, ; 195: lib_System.Runtime.InteropServices.dll.so => 151
	i64 u0x5db30905d3e5013b, ; 196: Xamarin.AndroidX.Collection.Jvm.dll => 80
	i64 u0x5e467bc8f09ad026, ; 197: System.Collections.Specialized.dll => 114
	i64 u0x5ea92fdb19ec8c4c, ; 198: System.Text.Encodings.Web.dll => 161
	i64 u0x5eb8046dd40e9ac3, ; 199: System.ComponentModel.Primitives => 117
	i64 u0x5f36ccf5c6a57e24, ; 200: System.Xml.ReaderWriter.dll => 169
	i64 u0x5f9a2d823f664957, ; 201: lib-el-Microsoft.Maui.Controls.resources.dll.so => 5
	i64 u0x609f4b7b63d802d4, ; 202: lib_Microsoft.Extensions.DependencyInjection.dll.so => 49
	i64 u0x60cd4e33d7e60134, ; 203: Xamarin.KotlinX.Coroutines.Core.Jvm => 107
	i64 u0x60f62d786afcf130, ; 204: System.Memory => 133
	i64 u0x61be8d1299194243, ; 205: Microsoft.Maui.Controls.Xaml => 60
	i64 u0x61d2cba29557038f, ; 206: de/Microsoft.Maui.Controls.resources => 4
	i64 u0x61d88f399afb2f45, ; 207: lib_System.Runtime.Loader.dll.so => 152
	i64 u0x622eef6f9e59068d, ; 208: System.Private.CoreLib => 173
	i64 u0x63f1f6883c1e23c2, ; 209: lib_System.Collections.Immutable.dll.so => 112
	i64 u0x6400f68068c1e9f1, ; 210: Xamarin.Google.Android.Material.dll => 104
	i64 u0x64b61dd9da8a4d57, ; 211: System.Net.ServerSentEvents.dll => 73
	i64 u0x658f524e4aba7dad, ; 212: CommunityToolkit.Maui.dll => 36
	i64 u0x659dc45417570048, ; 213: Refit => 65
	i64 u0x65ecac39144dd3cc, ; 214: Microsoft.Maui.Controls.dll => 59
	i64 u0x65ece51227bfa724, ; 215: lib_System.Runtime.Numerics.dll.so => 153
	i64 u0x6692e924eade1b29, ; 216: lib_System.Console.dll.so => 120
	i64 u0x66a4e5c6a3fb0bae, ; 217: lib_Xamarin.AndroidX.Lifecycle.ViewModel.Android.dll.so => 91
	i64 u0x66d13304ce1a3efa, ; 218: Xamarin.AndroidX.CursorAdapter => 83
	i64 u0x672a10d319608935, ; 219: lib_Microsoft.AspNetCore.Http.Connections.Common.dll.so => 41
	i64 u0x68558ec653afa616, ; 220: lib-da-Microsoft.Maui.Controls.resources.dll.so => 3
	i64 u0x6872ec7a2e36b1ac, ; 221: System.Drawing.Primitives.dll => 125
	i64 u0x68fbbbe2eb455198, ; 222: System.Formats.Asn1 => 127
	i64 u0x69063fc0ba8e6bdd, ; 223: he/Microsoft.Maui.Controls.resources.dll => 9
	i64 u0x6a4d7577b2317255, ; 224: System.Runtime.InteropServices.dll => 151
	i64 u0x6ace3b74b15ee4a4, ; 225: nb/Microsoft.Maui.Controls.resources => 18
	i64 u0x6afcedb171067e2b, ; 226: System.Core.dll => 121
	i64 u0x6c0fad39f1ea366b, ; 227: Plugin.Fingerprint.dll => 64
	i64 u0x6ce874bff138ce2b, ; 228: Xamarin.AndroidX.Lifecycle.ViewModel.dll => 90
	i64 u0x6d12bfaa99c72b1f, ; 229: lib_Microsoft.Maui.Graphics.dll.so => 63
	i64 u0x6d79993361e10ef2, ; 230: Microsoft.Extensions.Primitives => 58
	i64 u0x6d86d56b84c8eb71, ; 231: lib_Xamarin.AndroidX.CursorAdapter.dll.so => 83
	i64 u0x6d9bea6b3e895cf7, ; 232: Microsoft.Extensions.Primitives.dll => 58
	i64 u0x6e25a02c3833319a, ; 233: lib_Xamarin.AndroidX.Navigation.Fragment.dll.so => 95
	i64 u0x6e9965ce1095e60a, ; 234: lib_System.Core.dll.so => 121
	i64 u0x6fd2265da78b93a4, ; 235: lib_Microsoft.Maui.dll.so => 61
	i64 u0x6fdfc7de82c33008, ; 236: cs/Microsoft.Maui.Controls.resources => 2
	i64 u0x70e99f48c05cb921, ; 237: tr/Microsoft.Maui.Controls.resources.dll => 28
	i64 u0x70fd3deda22442d2, ; 238: lib-nb-Microsoft.Maui.Controls.resources.dll.so => 18
	i64 u0x717530326f808838, ; 239: lib_Microsoft.Extensions.Diagnostics.Abstractions.dll.so => 52
	i64 u0x71a495ea3761dde8, ; 240: lib-it-Microsoft.Maui.Controls.resources.dll.so => 14
	i64 u0x71ad672adbe48f35, ; 241: System.ComponentModel.Primitives.dll => 117
	i64 u0x7242820f67bc4ad6, ; 242: Microsoft.AspNetCore.SignalR.Common => 45
	i64 u0x72b1fb4109e08d7b, ; 243: lib-hr-Microsoft.Maui.Controls.resources.dll.so => 11
	i64 u0x733c9fa4b145dea1, ; 244: lib_SocialMauiApp.dll.so => 110
	i64 u0x73e4ce94e2eb6ffc, ; 245: lib_System.Memory.dll.so => 133
	i64 u0x746cf89b511b4d40, ; 246: lib_Microsoft.Extensions.Diagnostics.dll.so => 51
	i64 u0x755a91767330b3d4, ; 247: lib_Microsoft.Extensions.Configuration.dll.so => 47
	i64 u0x758463c93f0d589e, ; 248: lib_Microsoft.AspNetCore.Connections.Abstractions.dll.so => 39
	i64 u0x76012e7334db86e5, ; 249: lib_Xamarin.AndroidX.SavedState.dll.so => 99
	i64 u0x76ca07b878f44da0, ; 250: System.Runtime.Numerics.dll => 153
	i64 u0x77d9074d8f33a303, ; 251: lib_System.Net.ServerSentEvents.dll.so => 73
	i64 u0x780bc73597a503a9, ; 252: lib-ms-Microsoft.Maui.Controls.resources.dll.so => 17
	i64 u0x783606d1e53e7a1a, ; 253: th/Microsoft.Maui.Controls.resources.dll => 27
	i64 u0x78a1938b89c96721, ; 254: Microsoft.AspNetCore.Http.Connections.Common => 41
	i64 u0x78a45e51311409b6, ; 255: Xamarin.AndroidX.Fragment.dll => 86
	i64 u0x78ed4ab8f9d800a1, ; 256: Xamarin.AndroidX.Lifecycle.ViewModel => 90
	i64 u0x7985af0fe05692bb, ; 257: lib_SocialMediaMaui.Shared.dll.so => 109
	i64 u0x7a25bdb29108c6e7, ; 258: Microsoft.Extensions.Http => 54
	i64 u0x7a7e7eddf79c5d26, ; 259: lib_Xamarin.AndroidX.Lifecycle.ViewModel.dll.so => 90
	i64 u0x7adb8da2ac89b647, ; 260: fi/Microsoft.Maui.Controls.resources.dll => 7
	i64 u0x7bef86a4335c4870, ; 261: System.ComponentModel.TypeConverter => 118
	i64 u0x7c0820144cd34d6a, ; 262: sk/Microsoft.Maui.Controls.resources.dll => 25
	i64 u0x7c2a0bd1e0f988fc, ; 263: lib-de-Microsoft.Maui.Controls.resources.dll.so => 4
	i64 u0x7cc637f941f716d0, ; 264: CommunityToolkit.Maui.Core => 37
	i64 u0x7d49c593eeb09ac9, ; 265: Microsoft.AspNetCore.SignalR.Client.dll => 43
	i64 u0x7d649b75d580bb42, ; 266: ms/Microsoft.Maui.Controls.resources.dll => 17
	i64 u0x7d8ee2bdc8e3aad1, ; 267: System.Numerics.Vectors => 145
	i64 u0x7dfc3d6d9d8d7b70, ; 268: System.Collections => 115
	i64 u0x7e302e110e1e1346, ; 269: lib_System.Security.Claims.dll.so => 158
	i64 u0x7e946809d6008ef2, ; 270: lib_System.ObjectModel.dll.so => 146
	i64 u0x7ecc13347c8fd849, ; 271: lib_System.ComponentModel.dll.so => 119
	i64 u0x7eff369f2e01cf95, ; 272: Microsoft.AspNetCore.Http.Features => 42
	i64 u0x7f00ddd9b9ca5a13, ; 273: Xamarin.AndroidX.ViewPager.dll => 102
	i64 u0x7f9351cd44b1273f, ; 274: Microsoft.Extensions.Configuration.Abstractions => 48
	i64 u0x7fbd557c99b3ce6f, ; 275: lib_Xamarin.AndroidX.Lifecycle.LiveData.Core.dll.so => 89
	i64 u0x812c069d5cdecc17, ; 276: System.dll => 170
	i64 u0x81ab745f6c0f5ce6, ; 277: zh-Hant/Microsoft.Maui.Controls.resources => 33
	i64 u0x8277f2be6b5ce05f, ; 278: Xamarin.AndroidX.AppCompat => 75
	i64 u0x828f06563b30bc50, ; 279: lib_Xamarin.AndroidX.CardView.dll.so => 79
	i64 u0x82df8f5532a10c59, ; 280: lib_System.Drawing.dll.so => 126
	i64 u0x82f6403342e12049, ; 281: uk/Microsoft.Maui.Controls.resources => 29
	i64 u0x83c14ba66c8e2b8c, ; 282: zh-Hans/Microsoft.Maui.Controls.resources => 32
	i64 u0x846f52335a832137, ; 283: Microsoft.Extensions.Features => 53
	i64 u0x8636d45a3b98cdf7, ; 284: Syncfusion.Maui.ImageEditor => 69
	i64 u0x86a909228dc7657b, ; 285: lib-zh-Hant-Microsoft.Maui.Controls.resources.dll.so => 33
	i64 u0x86b3e00c36b84509, ; 286: Microsoft.Extensions.Configuration.dll => 47
	i64 u0x86b62cb077ec4fd7, ; 287: System.Runtime.Serialization.Xml => 156
	i64 u0x87a3c575cf2318ce, ; 288: Syncfusion.Maui.Sliders.dll => 70
	i64 u0x87c69b87d9283884, ; 289: lib_System.Threading.Thread.dll.so => 165
	i64 u0x87f6569b25707834, ; 290: System.IO.Compression.Brotli.dll => 128
	i64 u0x8842b3a5d2d3fb36, ; 291: Microsoft.Maui.Essentials => 62
	i64 u0x88bda98e0cffb7a9, ; 292: lib_Xamarin.KotlinX.Coroutines.Core.Jvm.dll.so => 107
	i64 u0x890981e3e80b7d74, ; 293: lib_Syncfusion.Maui.ImageEditor.dll.so => 69
	i64 u0x8930322c7bd8f768, ; 294: netstandard => 172
	i64 u0x897a606c9e39c75f, ; 295: lib_System.ComponentModel.Primitives.dll.so => 117
	i64 u0x8a14bf4400a024af, ; 296: lib_Microsoft.AspNetCore.Http.Features.dll.so => 42
	i64 u0x8ac8d025b93e29e9, ; 297: Syncfusion.Licensing => 67
	i64 u0x8ad229ea26432ee2, ; 298: Xamarin.AndroidX.Loader => 93
	i64 u0x8b42b55a5bb040b5, ; 299: lib_Microsoft.AspNetCore.SignalR.Protocols.Json.dll.so => 46
	i64 u0x8b4ff5d0fdd5faa1, ; 300: lib_System.Diagnostics.DiagnosticSource.dll.so => 122
	i64 u0x8b8d01333a96d0b5, ; 301: System.Diagnostics.Process.dll => 123
	i64 u0x8b9ceca7acae3451, ; 302: lib-he-Microsoft.Maui.Controls.resources.dll.so => 9
	i64 u0x8d0f420977c2c1c7, ; 303: Xamarin.AndroidX.CursorAdapter.dll => 83
	i64 u0x8d5f431bf67cc907, ; 304: SocialMediaMaui.Shared => 109
	i64 u0x8d7b8ab4b3310ead, ; 305: System.Threading => 166
	i64 u0x8da188285aadfe8e, ; 306: System.Collections.Concurrent => 111
	i64 u0x8e623fec9635e28f, ; 307: Syncfusion.Maui.Toolkit.resources.dll => 72
	i64 u0x8ed807bfe9858dfc, ; 308: Xamarin.AndroidX.Navigation.Common => 94
	i64 u0x8ee08b8194a30f48, ; 309: lib-hi-Microsoft.Maui.Controls.resources.dll.so => 10
	i64 u0x8ef7601039857a44, ; 310: lib-ro-Microsoft.Maui.Controls.resources.dll.so => 23
	i64 u0x8f32c6f611f6ffab, ; 311: pt/Microsoft.Maui.Controls.resources.dll => 22
	i64 u0x8f8829d21c8985a4, ; 312: lib-pt-BR-Microsoft.Maui.Controls.resources.dll.so => 21
	i64 u0x90263f8448b8f572, ; 313: lib_System.Diagnostics.TraceSource.dll.so => 124
	i64 u0x903101b46fb73a04, ; 314: _Microsoft.Android.Resource.Designer => 35
	i64 u0x90393bd4865292f3, ; 315: lib_System.IO.Compression.dll.so => 129
	i64 u0x90634f86c5ebe2b5, ; 316: Xamarin.AndroidX.Lifecycle.ViewModel.Android => 91
	i64 u0x907b636704ad79ef, ; 317: lib_Microsoft.Maui.Controls.Xaml.dll.so => 60
	i64 u0x90ae2b5b8b652f2a, ; 318: lib_Microsoft.AspNetCore.SignalR.Client.Core.dll.so => 44
	i64 u0x91418dc638b29e68, ; 319: lib_Xamarin.AndroidX.CustomView.dll.so => 84
	i64 u0x9157bd523cd7ed36, ; 320: lib_System.Text.Json.dll.so => 162
	i64 u0x91a74f07b30d37e2, ; 321: System.Linq.dll => 132
	i64 u0x91fa41a87223399f, ; 322: ca/Microsoft.Maui.Controls.resources.dll => 1
	i64 u0x92dd6c6033393bf7, ; 323: Syncfusion.Maui.Toolkit.resources => 72
	i64 u0x9388aad9b7ae40ce, ; 324: lib_Xamarin.AndroidX.Lifecycle.Common.dll.so => 87
	i64 u0x93cfa73ab28d6e35, ; 325: ms/Microsoft.Maui.Controls.resources => 17
	i64 u0x944077d8ca3c6580, ; 326: System.IO.Compression.dll => 129
	i64 u0x957a4cdfdcfd6d83, ; 327: Refit.HttpClientFactory.dll => 66
	i64 u0x967fc325e09bfa8c, ; 328: es/Microsoft.Maui.Controls.resources => 6
	i64 u0x9732d8dbddea3d9a, ; 329: id/Microsoft.Maui.Controls.resources => 13
	i64 u0x978be80e5210d31b, ; 330: Microsoft.Maui.Graphics.dll => 63
	i64 u0x97b8c771ea3e4220, ; 331: System.ComponentModel.dll => 119
	i64 u0x97e144c9d3c6976e, ; 332: System.Collections.Concurrent.dll => 111
	i64 u0x991d510397f92d9d, ; 333: System.Linq.Expressions => 131
	i64 u0x999cb19e1a04ffd3, ; 334: CommunityToolkit.Mvvm.dll => 38
	i64 u0x99a00ca5270c6878, ; 335: Xamarin.AndroidX.Navigation.Runtime => 96
	i64 u0x99cdc6d1f2d3a72f, ; 336: ko/Microsoft.Maui.Controls.resources.dll => 16
	i64 u0x9c244ac7cda32d26, ; 337: System.Security.Cryptography.X509Certificates.dll => 159
	i64 u0x9d5dbcf5a48583fe, ; 338: lib_Xamarin.AndroidX.Activity.dll.so => 74
	i64 u0x9d74dee1a7725f34, ; 339: Microsoft.Extensions.Configuration.Abstractions.dll => 48
	i64 u0x9e4534b6adaf6e84, ; 340: nl/Microsoft.Maui.Controls.resources => 19
	i64 u0x9eaf1efdf6f7267e, ; 341: Xamarin.AndroidX.Navigation.Common.dll => 94
	i64 u0x9ef542cf1f78c506, ; 342: Xamarin.AndroidX.Lifecycle.LiveData.Core => 89
	i64 u0x9f5c7301a67b9123, ; 343: lib_Syncfusion.Maui.Sliders.dll.so => 70
	i64 u0xa05475503f80b7d9, ; 344: Microsoft.AspNetCore.Connections.Abstractions => 39
	i64 u0xa0d8259f4cc284ec, ; 345: lib_System.Security.Cryptography.dll.so => 160
	i64 u0xa0e17ca50c77a225, ; 346: lib_Xamarin.Google.Crypto.Tink.Android.dll.so => 105
	i64 u0xa1440773ee9d341e, ; 347: Xamarin.Google.Android.Material => 104
	i64 u0xa1b9d7c27f47219f, ; 348: Xamarin.AndroidX.Navigation.UI.dll => 97
	i64 u0xa2572680829d2c7c, ; 349: System.IO.Pipelines.dll => 130
	i64 u0xa308401900e5bed3, ; 350: lib_mscorlib.dll.so => 171
	i64 u0xa46aa1eaa214539b, ; 351: ko/Microsoft.Maui.Controls.resources => 16
	i64 u0xa4a372eecb9e4df0, ; 352: Microsoft.Extensions.Diagnostics => 51
	i64 u0xa4d20d2ff0563d26, ; 353: lib_CommunityToolkit.Mvvm.dll.so => 38
	i64 u0xa5494f40f128ce6a, ; 354: System.Runtime.Serialization.Formatters.dll => 154
	i64 u0xa5e599d1e0524750, ; 355: System.Numerics.Vectors.dll => 145
	i64 u0xa5f1ba49b85dd355, ; 356: System.Security.Cryptography.dll => 160
	i64 u0xa67dbee13e1df9ca, ; 357: Xamarin.AndroidX.SavedState.dll => 99
	i64 u0xa684b098dd27b296, ; 358: lib_Xamarin.AndroidX.Security.SecurityCrypto.dll.so => 100
	i64 u0xa68a420042bb9b1f, ; 359: Xamarin.AndroidX.DrawerLayout.dll => 85
	i64 u0xa78ce3745383236a, ; 360: Xamarin.AndroidX.Lifecycle.Common.Jvm => 88
	i64 u0xa7c31b56b4dc7b33, ; 361: hu/Microsoft.Maui.Controls.resources => 12
	i64 u0xa964304b5631e28a, ; 362: CommunityToolkit.Maui.Core.dll => 37
	i64 u0xaa2219c8e3449ff5, ; 363: Microsoft.Extensions.Logging.Abstractions => 56
	i64 u0xaa443ac34067eeef, ; 364: System.Private.Xml.dll => 150
	i64 u0xaa52de307ef5d1dd, ; 365: System.Net.Http => 135
	i64 u0xaaaf86367285a918, ; 366: Microsoft.Extensions.DependencyInjection.Abstractions.dll => 50
	i64 u0xaaf84bb3f052a265, ; 367: el/Microsoft.Maui.Controls.resources => 5
	i64 u0xab9c1b2687d86b0b, ; 368: lib_System.Linq.Expressions.dll.so => 131
	i64 u0xac03339b985f4d59, ; 369: Microsoft.AspNetCore.SignalR.Client.Core.dll => 44
	i64 u0xac2af3fa195a15ce, ; 370: System.Runtime.Numerics => 153
	i64 u0xac5376a2a538dc10, ; 371: Xamarin.AndroidX.Lifecycle.LiveData.Core.dll => 89
	i64 u0xacd46e002c3ccb97, ; 372: ro/Microsoft.Maui.Controls.resources => 23
	i64 u0xacf42eea7ef9cd12, ; 373: System.Threading.Channels => 164
	i64 u0xad89c07347f1bad6, ; 374: nl/Microsoft.Maui.Controls.resources.dll => 19
	i64 u0xadbb53caf78a79d2, ; 375: System.Web.HttpUtility => 167
	i64 u0xadc90ab061a9e6e4, ; 376: System.ComponentModel.TypeConverter.dll => 118
	i64 u0xadf511667bef3595, ; 377: System.Net.Security => 140
	i64 u0xae282bcd03739de7, ; 378: Java.Interop => 174
	i64 u0xae53579c90db1107, ; 379: System.ObjectModel.dll => 146
	i64 u0xaf4829c0b3e740ae, ; 380: lib_Syncfusion.Maui.Toolkit.resources.dll.so => 72
	i64 u0xafe29f45095518e7, ; 381: lib_Xamarin.AndroidX.Lifecycle.ViewModelSavedState.dll.so => 92
	i64 u0xb05cc42cd94c6d9d, ; 382: lib-sv-Microsoft.Maui.Controls.resources.dll.so => 26
	i64 u0xb220631954820169, ; 383: System.Text.RegularExpressions => 163
	i64 u0xb2a3f67f3bf29fce, ; 384: da/Microsoft.Maui.Controls.resources => 3
	i64 u0xb3f0a0fcda8d3ebc, ; 385: Xamarin.AndroidX.CardView => 79
	i64 u0xb3f832258cb83db4, ; 386: Syncfusion.Licensing.dll => 67
	i64 u0xb46be1aa6d4fff93, ; 387: hi/Microsoft.Maui.Controls.resources => 10
	i64 u0xb477491be13109d8, ; 388: ar/Microsoft.Maui.Controls.resources => 0
	i64 u0xb4bd7015ecee9d86, ; 389: System.IO.Pipelines => 130
	i64 u0xb5c7fcdafbc67ee4, ; 390: Microsoft.Extensions.Logging.Abstractions.dll => 56
	i64 u0xb7212c4683a94afe, ; 391: System.Drawing.Primitives => 125
	i64 u0xb7b7753d1f319409, ; 392: sv/Microsoft.Maui.Controls.resources => 26
	i64 u0xb81a2c6e0aee50fe, ; 393: lib_System.Private.CoreLib.dll.so => 173
	i64 u0xb872c26142d22aa9, ; 394: Microsoft.Extensions.Http.dll => 54
	i64 u0xb9f64d3b230def68, ; 395: lib-pt-Microsoft.Maui.Controls.resources.dll.so => 22
	i64 u0xb9fc3c8a556e3691, ; 396: ja/Microsoft.Maui.Controls.resources => 15
	i64 u0xba48785529705af9, ; 397: System.Collections.dll => 115
	i64 u0xbb65706fde942ce3, ; 398: System.Net.Sockets => 141
	i64 u0xbbd180354b67271a, ; 399: System.Runtime.Serialization.Formatters => 154
	i64 u0xbc1c174a8f6053a0, ; 400: Plugin.Fingerprint => 64
	i64 u0xbd0e2c0d55246576, ; 401: System.Net.Http.dll => 135
	i64 u0xbd437a2cdb333d0d, ; 402: Xamarin.AndroidX.ViewPager2 => 103
	i64 u0xbd5d0b88d3d647a5, ; 403: lib_Xamarin.AndroidX.Browser.dll.so => 78
	i64 u0xbee38d4a88835966, ; 404: Xamarin.AndroidX.AppCompat.AppCompatResources => 76
	i64 u0xbfc1e1fb3095f2b3, ; 405: lib_System.Net.Http.Json.dll.so => 134
	i64 u0xc040a4ab55817f58, ; 406: ar/Microsoft.Maui.Controls.resources.dll => 0
	i64 u0xc0d928351ab5ca77, ; 407: System.Console.dll => 120
	i64 u0xc12b8b3afa48329c, ; 408: lib_System.Linq.dll.so => 132
	i64 u0xc1347413e524ff69, ; 409: lib_Syncfusion.Maui.Toolkit.dll.so => 71
	i64 u0xc1ff9ae3cdb6e1e6, ; 410: Xamarin.AndroidX.Activity.dll => 74
	i64 u0xc28c50f32f81cc73, ; 411: ja/Microsoft.Maui.Controls.resources.dll => 15
	i64 u0xc2bcfec99f69365e, ; 412: Xamarin.AndroidX.ViewPager2.dll => 103
	i64 u0xc30b52815b58ac2c, ; 413: lib_System.Runtime.Serialization.Xml.dll.so => 156
	i64 u0xc39ced8467203460, ; 414: lib_Refit.HttpClientFactory.dll.so => 66
	i64 u0xc421b61fd853169d, ; 415: lib_System.Net.WebSockets.Client.dll.so => 143
	i64 u0xc4d3858ed4d08512, ; 416: Xamarin.AndroidX.Lifecycle.ViewModelSavedState.dll => 92
	i64 u0xc4f2d57c50beb816, ; 417: lib_Microsoft.Extensions.Features.dll.so => 53
	i64 u0xc50fded0ded1418c, ; 418: lib_System.ComponentModel.TypeConverter.dll.so => 118
	i64 u0xc519125d6bc8fb11, ; 419: lib_System.Net.Requests.dll.so => 139
	i64 u0xc5293b19e4dc230e, ; 420: Xamarin.AndroidX.Navigation.Fragment => 95
	i64 u0xc5325b2fcb37446f, ; 421: lib_System.Private.Xml.dll.so => 150
	i64 u0xc5a0f4b95a699af7, ; 422: lib_System.Private.Uri.dll.so => 148
	i64 u0xc5de3dcae13c325f, ; 423: Microsoft.AspNetCore.SignalR.Client => 43
	i64 u0xc7ce851898a4548e, ; 424: lib_System.Web.HttpUtility.dll.so => 167
	i64 u0xc858a28d9ee5a6c5, ; 425: lib_System.Collections.Specialized.dll.so => 114
	i64 u0xc9e54b32fc19baf3, ; 426: lib_CommunityToolkit.Maui.dll.so => 36
	i64 u0xca3a723e7342c5b6, ; 427: lib-tr-Microsoft.Maui.Controls.resources.dll.so => 28
	i64 u0xcab3493c70141c2d, ; 428: pl/Microsoft.Maui.Controls.resources => 20
	i64 u0xcacfddc9f7c6de76, ; 429: ro/Microsoft.Maui.Controls.resources.dll => 23
	i64 u0xcbd4fdd9cef4a294, ; 430: lib__Microsoft.Android.Resource.Designer.dll.so => 35
	i64 u0xcc2876b32ef2794c, ; 431: lib_System.Text.RegularExpressions.dll.so => 163
	i64 u0xcc5c3bb714c4561e, ; 432: Xamarin.KotlinX.Coroutines.Core.Jvm.dll => 107
	i64 u0xcc76886e09b88260, ; 433: Xamarin.KotlinX.Serialization.Core.Jvm.dll => 108
	i64 u0xcce5f0b382db16b7, ; 434: Microsoft.AspNetCore.Http.Connections.Client => 40
	i64 u0xccf25c4b634ccd3a, ; 435: zh-Hans/Microsoft.Maui.Controls.resources.dll => 32
	i64 u0xcd10a42808629144, ; 436: System.Net.Requests => 139
	i64 u0xcdd0c48b6937b21c, ; 437: Xamarin.AndroidX.SwipeRefreshLayout => 101
	i64 u0xce57238a2f68613f, ; 438: lib_Plugin.Fingerprint.dll.so => 64
	i64 u0xcf23d8093f3ceadf, ; 439: System.Diagnostics.DiagnosticSource.dll => 122
	i64 u0xcf8fc898f98b0d34, ; 440: System.Private.Xml.Linq => 149
	i64 u0xd1194e1d8a8de83c, ; 441: lib_Xamarin.AndroidX.Lifecycle.Common.Jvm.dll.so => 88
	i64 u0xd16fd7fb9bbcd43e, ; 442: Microsoft.Extensions.Diagnostics.Abstractions => 52
	i64 u0xd333d0af9e423810, ; 443: System.Runtime.InteropServices => 151
	i64 u0xd3426d966bb704f5, ; 444: Xamarin.AndroidX.AppCompat.AppCompatResources.dll => 76
	i64 u0xd3651b6fc3125825, ; 445: System.Private.Uri.dll => 148
	i64 u0xd373685349b1fe8b, ; 446: Microsoft.Extensions.Logging.dll => 55
	i64 u0xd3801faafafb7698, ; 447: System.Private.DataContractSerialization.dll => 147
	i64 u0xd3e4c8d6a2d5d470, ; 448: it/Microsoft.Maui.Controls.resources => 14
	i64 u0xd4645626dffec99d, ; 449: lib_Microsoft.Extensions.DependencyInjection.Abstractions.dll.so => 50
	i64 u0xd52f53c4b3d62e11, ; 450: Microsoft.AspNetCore.Connections.Abstractions.dll => 39
	i64 u0xd5507e11a2b2839f, ; 451: Xamarin.AndroidX.Lifecycle.ViewModelSavedState => 92
	i64 u0xd6694f8359737e4e, ; 452: Xamarin.AndroidX.SavedState => 99
	i64 u0xd6d21782156bc35b, ; 453: Xamarin.AndroidX.SwipeRefreshLayout.dll => 101
	i64 u0xd72329819cbbbc44, ; 454: lib_Microsoft.Extensions.Configuration.Abstractions.dll.so => 48
	i64 u0xd7b3764ada9d341d, ; 455: lib_Microsoft.Extensions.Logging.Abstractions.dll.so => 56
	i64 u0xda1dfa4c534a9251, ; 456: Microsoft.Extensions.DependencyInjection => 49
	i64 u0xdad05a11827959a3, ; 457: System.Collections.NonGeneric.dll => 113
	i64 u0xdb5383ab5865c007, ; 458: lib-vi-Microsoft.Maui.Controls.resources.dll.so => 30
	i64 u0xdbeda89f832aa805, ; 459: vi/Microsoft.Maui.Controls.resources.dll => 30
	i64 u0xdbf9607a441b4505, ; 460: System.Linq => 132
	i64 u0xdce2c53525640bf3, ; 461: Microsoft.Extensions.Logging => 55
	i64 u0xdd2b722d78ef5f43, ; 462: System.Runtime.dll => 157
	i64 u0xdd67031857c72f96, ; 463: lib_System.Text.Encodings.Web.dll.so => 161
	i64 u0xdde30e6b77aa6f6c, ; 464: lib-zh-Hans-Microsoft.Maui.Controls.resources.dll.so => 32
	i64 u0xde8769ebda7d8647, ; 465: hr/Microsoft.Maui.Controls.resources.dll => 11
	i64 u0xdf9c7682560a9629, ; 466: System.Net.ServerSentEvents => 73
	i64 u0xe0142572c095a480, ; 467: Xamarin.AndroidX.AppCompat.dll => 75
	i64 u0xe020c74e3723dc6f, ; 468: Syncfusion.Maui.Toolkit.dll => 71
	i64 u0xe02f89350ec78051, ; 469: Xamarin.AndroidX.CoordinatorLayout.dll => 81
	i64 u0xe02ff568f8e5f275, ; 470: Microsoft.AspNetCore.Http.Connections.Client.dll => 40
	i64 u0xe0a0a4c883f4beeb, ; 471: lib_Xamarin.AndroidX.Biometric.dll.so => 77
	i64 u0xe192a588d4410686, ; 472: lib_System.IO.Pipelines.dll.so => 130
	i64 u0xe1a08bd3fa539e0d, ; 473: System.Runtime.Loader => 152
	i64 u0xe1b52f9f816c70ef, ; 474: System.Private.Xml.Linq.dll => 149
	i64 u0xe1ecfdb7fff86067, ; 475: System.Net.Security.dll => 140
	i64 u0xe2420585aeceb728, ; 476: System.Net.Requests.dll => 139
	i64 u0xe29b73bc11392966, ; 477: lib-id-Microsoft.Maui.Controls.resources.dll.so => 13
	i64 u0xe2ee754535ca6dd6, ; 478: SocialMauiApp => 110
	i64 u0xe3811d68d4fe8463, ; 479: pt-BR/Microsoft.Maui.Controls.resources.dll => 21
	i64 u0xe494f7ced4ecd10a, ; 480: hu/Microsoft.Maui.Controls.resources.dll => 12
	i64 u0xe4a9b1e40d1e8917, ; 481: lib-fi-Microsoft.Maui.Controls.resources.dll.so => 7
	i64 u0xe4f74a0b5bf9703f, ; 482: System.Runtime.Serialization.Primitives => 155
	i64 u0xe5434e8a119ceb69, ; 483: lib_Mono.Android.dll.so => 176
	i64 u0xe7e7d98eda944101, ; 484: Syncfusion.Maui.Sliders => 70
	i64 u0xe89a2a9ef110899b, ; 485: System.Drawing.dll => 126
	i64 u0xea008206567504c4, ; 486: Syncfusion.Maui.Toolkit => 71
	i64 u0xebdfa33cea4bfcea, ; 487: SocialMediaMaui.Shared.dll => 109
	i64 u0xec14f495db71c005, ; 488: en-US/Syncfusion.Maui.ImageEditor.resources.dll => 34
	i64 u0xedc4817167106c23, ; 489: System.Net.Sockets.dll => 141
	i64 u0xedc632067fb20ff3, ; 490: System.Memory.dll => 133
	i64 u0xedc8e4ca71a02a8b, ; 491: Xamarin.AndroidX.Navigation.Runtime.dll => 96
	i64 u0xeeb7ebb80150501b, ; 492: lib_Xamarin.AndroidX.Collection.Jvm.dll.so => 80
	i64 u0xeedf6bb58bca9075, ; 493: Xamarin.AndroidX.Biometric.dll => 77
	i64 u0xef72742e1bcca27a, ; 494: Microsoft.Maui.Essentials.dll => 62
	i64 u0xefec0b7fdc57ec42, ; 495: Xamarin.AndroidX.Activity => 74
	i64 u0xf00c29406ea45e19, ; 496: es/Microsoft.Maui.Controls.resources.dll => 6
	i64 u0xf038bf84c0c27e83, ; 497: lib_Microsoft.AspNetCore.SignalR.Client.dll.so => 43
	i64 u0xf09e47b6ae914f6e, ; 498: System.Net.NameResolution => 136
	i64 u0xf0de2537ee19c6ca, ; 499: lib_System.Net.WebHeaderCollection.dll.so => 142
	i64 u0xf11b621fc87b983f, ; 500: Microsoft.Maui.Controls.Xaml.dll => 60
	i64 u0xf1c4b4005493d871, ; 501: System.Formats.Asn1.dll => 127
	i64 u0xf238bd79489d3a96, ; 502: lib-nl-Microsoft.Maui.Controls.resources.dll.so => 19
	i64 u0xf37221fda4ef8830, ; 503: lib_Xamarin.Google.Android.Material.dll.so => 104
	i64 u0xf3ddfe05336abf29, ; 504: System => 170
	i64 u0xf4c1dd70a5496a17, ; 505: System.IO.Compression => 129
	i64 u0xf5fc7602fe27b333, ; 506: System.Net.WebHeaderCollection => 142
	i64 u0xf6077741019d7428, ; 507: Xamarin.AndroidX.CoordinatorLayout => 81
	i64 u0xf77b20923f07c667, ; 508: de/Microsoft.Maui.Controls.resources.dll => 4
	i64 u0xf7e2cac4c45067b3, ; 509: lib_System.Numerics.Vectors.dll.so => 145
	i64 u0xf7e74930e0e3d214, ; 510: zh-HK/Microsoft.Maui.Controls.resources.dll => 31
	i64 u0xf84773b5c81e3cef, ; 511: lib-uk-Microsoft.Maui.Controls.resources.dll.so => 29
	i64 u0xf8e045dc345b2ea3, ; 512: lib_Xamarin.AndroidX.RecyclerView.dll.so => 98
	i64 u0xf915dc29808193a1, ; 513: System.Web.HttpUtility.dll => 167
	i64 u0xf96c777a2a0686f4, ; 514: hi/Microsoft.Maui.Controls.resources.dll => 10
	i64 u0xf9eec5bb3a6aedc6, ; 515: Microsoft.Extensions.Options => 57
	i64 u0xfa3f278f288b0e84, ; 516: lib_System.Net.Security.dll.so => 140
	i64 u0xfa5ed7226d978949, ; 517: lib-ar-Microsoft.Maui.Controls.resources.dll.so => 0
	i64 u0xfa645d91e9fc4cba, ; 518: System.Threading.Thread => 165
	i64 u0xfbad3e4ce4b98145, ; 519: System.Security.Cryptography.X509Certificates => 159
	i64 u0xfbd71978549ea473, ; 520: Microsoft.AspNetCore.Http.Features.dll => 42
	i64 u0xfbf0a31c9fc34bc4, ; 521: lib_System.Net.Http.dll.so => 135
	i64 u0xfc6b7527cc280b3f, ; 522: lib_System.Runtime.Serialization.Formatters.dll.so => 154
	i64 u0xfc719aec26adf9d9, ; 523: Xamarin.AndroidX.Navigation.Fragment.dll => 95
	i64 u0xfd22f00870e40ae0, ; 524: lib_Xamarin.AndroidX.DrawerLayout.dll.so => 85
	i64 u0xfd583f7657b6a1cb, ; 525: Xamarin.AndroidX.Fragment => 86
	i64 u0xfda36abccf05cf5c, ; 526: System.Net.WebSockets.Client => 143
	i64 u0xfdbe4710aa9beeff, ; 527: CommunityToolkit.Maui => 36
	i64 u0xfddbe9695626a7f5, ; 528: Xamarin.AndroidX.Lifecycle.Common => 87
	i64 u0xfeae9952cf03b8cb, ; 529: tr/Microsoft.Maui.Controls.resources => 28
	i64 u0xff9b54613e0d2cc8 ; 530: System.Net.Http.Json => 134
], align 8

@assembly_image_cache_indices = dso_local local_unnamed_addr constant [531 x i32] [
	i32 101, i32 65, i32 116, i32 45, i32 96, i32 37, i32 175, i32 75,
	i32 147, i32 24, i32 2, i32 30, i32 138, i32 98, i32 115, i32 61,
	i32 31, i32 168, i32 80, i32 171, i32 24, i32 113, i32 85, i32 116,
	i32 57, i32 113, i32 160, i32 164, i32 25, i32 108, i32 46, i32 102,
	i32 21, i32 176, i32 62, i32 100, i32 136, i32 110, i32 84, i32 68,
	i32 128, i32 144, i32 77, i32 34, i32 98, i32 78, i32 8, i32 174,
	i32 9, i32 50, i32 144, i32 44, i32 68, i32 172, i32 121, i32 12,
	i32 161, i32 108, i32 18, i32 66, i32 158, i32 111, i32 170, i32 27,
	i32 51, i32 175, i32 100, i32 97, i32 16, i32 57, i32 128, i32 123,
	i32 157, i32 27, i32 165, i32 120, i32 82, i32 155, i32 8, i32 105,
	i32 106, i32 58, i32 13, i32 11, i32 144, i32 105, i32 174, i32 138,
	i32 65, i32 52, i32 34, i32 29, i32 137, i32 124, i32 7, i32 163,
	i32 127, i32 33, i32 20, i32 149, i32 67, i32 166, i32 26, i32 162,
	i32 5, i32 53, i32 123, i32 169, i32 54, i32 86, i32 35, i32 79,
	i32 125, i32 8, i32 169, i32 112, i32 6, i32 141, i32 61, i32 2,
	i32 59, i32 116, i32 103, i32 47, i32 69, i32 112, i32 84, i32 136,
	i32 102, i32 1, i32 159, i32 106, i32 78, i32 168, i32 82, i32 94,
	i32 171, i32 76, i32 172, i32 176, i32 20, i32 155, i32 106, i32 124,
	i32 24, i32 168, i32 22, i32 46, i32 146, i32 97, i32 68, i32 162,
	i32 134, i32 93, i32 137, i32 143, i32 131, i32 150, i32 152, i32 14,
	i32 93, i32 175, i32 45, i32 164, i32 1, i32 59, i32 38, i32 91,
	i32 126, i32 138, i32 82, i32 63, i32 25, i32 137, i32 31, i32 158,
	i32 157, i32 87, i32 88, i32 114, i32 156, i32 148, i32 173, i32 122,
	i32 15, i32 49, i32 81, i32 166, i32 119, i32 41, i32 147, i32 3,
	i32 40, i32 55, i32 142, i32 151, i32 80, i32 114, i32 161, i32 117,
	i32 169, i32 5, i32 49, i32 107, i32 133, i32 60, i32 4, i32 152,
	i32 173, i32 112, i32 104, i32 73, i32 36, i32 65, i32 59, i32 153,
	i32 120, i32 91, i32 83, i32 41, i32 3, i32 125, i32 127, i32 9,
	i32 151, i32 18, i32 121, i32 64, i32 90, i32 63, i32 58, i32 83,
	i32 58, i32 95, i32 121, i32 61, i32 2, i32 28, i32 18, i32 52,
	i32 14, i32 117, i32 45, i32 11, i32 110, i32 133, i32 51, i32 47,
	i32 39, i32 99, i32 153, i32 73, i32 17, i32 27, i32 41, i32 86,
	i32 90, i32 109, i32 54, i32 90, i32 7, i32 118, i32 25, i32 4,
	i32 37, i32 43, i32 17, i32 145, i32 115, i32 158, i32 146, i32 119,
	i32 42, i32 102, i32 48, i32 89, i32 170, i32 33, i32 75, i32 79,
	i32 126, i32 29, i32 32, i32 53, i32 69, i32 33, i32 47, i32 156,
	i32 70, i32 165, i32 128, i32 62, i32 107, i32 69, i32 172, i32 117,
	i32 42, i32 67, i32 93, i32 46, i32 122, i32 123, i32 9, i32 83,
	i32 109, i32 166, i32 111, i32 72, i32 94, i32 10, i32 23, i32 22,
	i32 21, i32 124, i32 35, i32 129, i32 91, i32 60, i32 44, i32 84,
	i32 162, i32 132, i32 1, i32 72, i32 87, i32 17, i32 129, i32 66,
	i32 6, i32 13, i32 63, i32 119, i32 111, i32 131, i32 38, i32 96,
	i32 16, i32 159, i32 74, i32 48, i32 19, i32 94, i32 89, i32 70,
	i32 39, i32 160, i32 105, i32 104, i32 97, i32 130, i32 171, i32 16,
	i32 51, i32 38, i32 154, i32 145, i32 160, i32 99, i32 100, i32 85,
	i32 88, i32 12, i32 37, i32 56, i32 150, i32 135, i32 50, i32 5,
	i32 131, i32 44, i32 153, i32 89, i32 23, i32 164, i32 19, i32 167,
	i32 118, i32 140, i32 174, i32 146, i32 72, i32 92, i32 26, i32 163,
	i32 3, i32 79, i32 67, i32 10, i32 0, i32 130, i32 56, i32 125,
	i32 26, i32 173, i32 54, i32 22, i32 15, i32 115, i32 141, i32 154,
	i32 64, i32 135, i32 103, i32 78, i32 76, i32 134, i32 0, i32 120,
	i32 132, i32 71, i32 74, i32 15, i32 103, i32 156, i32 66, i32 143,
	i32 92, i32 53, i32 118, i32 139, i32 95, i32 150, i32 148, i32 43,
	i32 167, i32 114, i32 36, i32 28, i32 20, i32 23, i32 35, i32 163,
	i32 107, i32 108, i32 40, i32 32, i32 139, i32 101, i32 64, i32 122,
	i32 149, i32 88, i32 52, i32 151, i32 76, i32 148, i32 55, i32 147,
	i32 14, i32 50, i32 39, i32 92, i32 99, i32 101, i32 48, i32 56,
	i32 49, i32 113, i32 30, i32 30, i32 132, i32 55, i32 157, i32 161,
	i32 32, i32 11, i32 73, i32 75, i32 71, i32 81, i32 40, i32 77,
	i32 130, i32 152, i32 149, i32 140, i32 139, i32 13, i32 110, i32 21,
	i32 12, i32 7, i32 155, i32 176, i32 70, i32 126, i32 71, i32 109,
	i32 34, i32 141, i32 133, i32 96, i32 80, i32 77, i32 62, i32 74,
	i32 6, i32 43, i32 136, i32 142, i32 60, i32 127, i32 19, i32 104,
	i32 170, i32 129, i32 142, i32 81, i32 4, i32 145, i32 31, i32 29,
	i32 98, i32 167, i32 10, i32 57, i32 140, i32 0, i32 165, i32 159,
	i32 42, i32 135, i32 154, i32 95, i32 85, i32 86, i32 143, i32 36,
	i32 87, i32 28, i32 134
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
