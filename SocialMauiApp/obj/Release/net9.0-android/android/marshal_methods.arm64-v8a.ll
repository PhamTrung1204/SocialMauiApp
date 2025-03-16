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

@assembly_image_cache = dso_local local_unnamed_addr global [254 x ptr] zeroinitializer, align 8

; Each entry maps hash of an assembly name to an index into the `assembly_image_cache` array
@assembly_image_cache_hashes = dso_local local_unnamed_addr constant [762 x i64] [
	i64 u0x0071cf2d27b7d61e, ; 0: lib_Xamarin.AndroidX.SwipeRefreshLayout.dll.so => 149
	i64 u0x00b3aadb3a4c4038, ; 1: lib_Refit.dll.so => 107
	i64 u0x01109b0e4d99e61f, ; 2: System.ComponentModel.Annotations.dll => 166
	i64 u0x014b43fdeb5d21ad, ; 3: Microsoft.AspNetCore.Authorization.Policy.dll => 47
	i64 u0x018d2cc5e2de2b95, ; 4: lib_Microsoft.AspNetCore.SignalR.Common.dll.so => 64
	i64 u0x02123411c4e01926, ; 5: lib_Xamarin.AndroidX.Navigation.Runtime.dll.so => 145
	i64 u0x022e81ea9c46e03a, ; 6: lib_CommunityToolkit.Maui.Core.dll.so => 39
	i64 u0x02a4c5a44384f885, ; 7: Microsoft.Extensions.Caching.Memory => 75
	i64 u0x02abedc11addc1ed, ; 8: lib_Mono.Android.Runtime.dll.so => 252
	i64 u0x032267b2a94db371, ; 9: lib_Xamarin.AndroidX.AppCompat.dll.so => 127
	i64 u0x03621c804933a890, ; 10: System.Buffers => 160
	i64 u0x0363ac97a4cb84e6, ; 11: SQLitePCLRaw.provider.e_sqlite3.dll => 112
	i64 u0x0399610510a38a38, ; 12: lib_System.Private.DataContractSerialization.dll.so => 204
	i64 u0x043032f1d071fae0, ; 13: ru/Microsoft.Maui.Controls.resources => 24
	i64 u0x044440a55165631e, ; 14: lib-cs-Microsoft.Maui.Controls.resources.dll.so => 2
	i64 u0x046eb1581a80c6b0, ; 15: vi/Microsoft.Maui.Controls.resources => 30
	i64 u0x0470607fd33c32db, ; 16: Microsoft.IdentityModel.Abstractions.dll => 93
	i64 u0x0517ef04e06e9f76, ; 17: System.Net.Primitives => 194
	i64 u0x0565d18c6da3de38, ; 18: Xamarin.AndroidX.RecyclerView => 147
	i64 u0x0581db89237110e9, ; 19: lib_System.Collections.dll.so => 165
	i64 u0x05989cb940b225a9, ; 20: Microsoft.Maui.dll => 101
	i64 u0x05c27cf2b380bbf2, ; 21: lib_Microsoft.AspNetCore.Hosting.Server.Abstractions.dll.so => 50
	i64 u0x06076b5d2b581f08, ; 22: zh-HK/Microsoft.Maui.Controls.resources => 31
	i64 u0x06388ffe9f6c161a, ; 23: System.Xml.Linq.dll => 243
	i64 u0x0680a433c781bb3d, ; 24: Xamarin.AndroidX.Collection.Jvm => 131
	i64 u0x07469f2eecce9e85, ; 25: mscorlib.dll => 248
	i64 u0x07c57877c7ba78ad, ; 26: ru/Microsoft.Maui.Controls.resources.dll => 24
	i64 u0x07dcdc7460a0c5e4, ; 27: System.Collections.NonGeneric => 163
	i64 u0x08881a0a9768df86, ; 28: lib_Azure.Core.dll.so => 36
	i64 u0x08a7c865576bbde7, ; 29: System.Reflection.Primitives => 211
	i64 u0x08f3c9788ee2153c, ; 30: Xamarin.AndroidX.DrawerLayout => 136
	i64 u0x09138715c92dba90, ; 31: lib_System.ComponentModel.Annotations.dll.so => 166
	i64 u0x0919c28b89381a0b, ; 32: lib_Microsoft.Extensions.Options.dll.so => 89
	i64 u0x092266563089ae3e, ; 33: lib_System.Collections.NonGeneric.dll.so => 163
	i64 u0x095cacaf6b6a32e4, ; 34: System.Memory.Data => 122
	i64 u0x09d144a7e214d457, ; 35: System.Security.Cryptography => 229
	i64 u0x0a805f95d98f597b, ; 36: lib_Microsoft.Extensions.Caching.Abstractions.dll.so => 74
	i64 u0x0abb3e2b271edc45, ; 37: System.Threading.Channels.dll => 236
	i64 u0x0adeb6c0f5699d33, ; 38: Microsoft.Data.SqlClient.dll => 69
	i64 u0x0b3b632c3bbee20c, ; 39: sk/Microsoft.Maui.Controls.resources => 25
	i64 u0x0b6aff547b84fbe9, ; 40: Xamarin.KotlinX.Serialization.Core.Jvm => 155
	i64 u0x0b74b547d9e0e85d, ; 41: Microsoft.AspNetCore.SignalR.Protocols.Json.dll => 66
	i64 u0x0be2e1f8ce4064ed, ; 42: Xamarin.AndroidX.ViewPager => 150
	i64 u0x0c3ca6cc978e2aae, ; 43: pt-BR/Microsoft.Maui.Controls.resources => 21
	i64 u0x0c59ad9fbbd43abe, ; 44: Mono.Android => 253
	i64 u0x0c7790f60165fc06, ; 45: lib_Microsoft.Maui.Essentials.dll.so => 102
	i64 u0x0d3b5ab8b2766190, ; 46: lib_Microsoft.Bcl.AsyncInterfaces.dll.so => 68
	i64 u0x0e14e73a54dda68e, ; 47: lib_System.Net.NameResolution.dll.so => 192
	i64 u0x0f948418e9ebd6de, ; 48: Microsoft.AspNetCore.Hosting.Abstractions.dll => 49
	i64 u0x0fdf69c58fad2d0a, ; 49: SocialMauiApp.dll => 157
	i64 u0x102861e4055f511a, ; 50: Microsoft.Bcl.AsyncInterfaces.dll => 68
	i64 u0x102a31b45304b1da, ; 51: Xamarin.AndroidX.CustomView => 135
	i64 u0x10ca46a12d1cfb88, ; 52: Syncfusion.Maui.Core => 114
	i64 u0x10f6cfcbcf801616, ; 53: System.IO.Compression.Brotli => 180
	i64 u0x111e7120c198511e, ; 54: DocumentFormat.OpenXml.Framework.dll => 42
	i64 u0x1140109eb2e77ceb, ; 55: Microsoft.Extensions.ObjectPool.dll => 88
	i64 u0x114443cdcf2091f1, ; 56: System.Security.Cryptography.Primitives => 227
	i64 u0x11a70d0e1009fb11, ; 57: System.Net.WebSockets.dll => 201
	i64 u0x123639456fb056da, ; 58: System.Reflection.Emit.Lightweight.dll => 209
	i64 u0x124908dccbc07697, ; 59: en-US/Syncfusion.Maui.ImageEditor.resources => 34
	i64 u0x125b7f94acb989db, ; 60: Xamarin.AndroidX.RecyclerView.dll => 147
	i64 u0x126ee4b0de53cbfd, ; 61: Microsoft.IdentityModel.Protocols.OpenIdConnect.dll => 97
	i64 u0x138567fa954faa55, ; 62: Xamarin.AndroidX.Browser => 129
	i64 u0x13a01de0cbc3f06c, ; 63: lib-fr-Microsoft.Maui.Controls.resources.dll.so => 8
	i64 u0x13f1e5e209e91af4, ; 64: lib_Java.Interop.dll.so => 251
	i64 u0x13f1e880c25d96d1, ; 65: he/Microsoft.Maui.Controls.resources => 9
	i64 u0x143a1f6e62b82b56, ; 66: Microsoft.IdentityModel.Protocols.OpenIdConnect => 97
	i64 u0x143d8ea60a6a4011, ; 67: Microsoft.Extensions.DependencyInjection.Abstractions => 79
	i64 u0x1497051b917530bd, ; 68: lib_System.Net.WebSockets.dll.so => 201
	i64 u0x15089560460fb845, ; 69: Microsoft.AspNetCore.SignalR.Client.Core => 63
	i64 u0x152a448bd1e745a7, ; 70: Microsoft.Win32.Primitives => 159
	i64 u0x16054fdcb6b3098b, ; 71: Microsoft.Extensions.DependencyModel.dll => 80
	i64 u0x1695ecefb732cade, ; 72: lib_Syncfusion.Maui.Core.dll.so => 114
	i64 u0x16bf2a22df043a09, ; 73: System.IO.Pipes.dll => 185
	i64 u0x16ea2b318ad2d830, ; 74: System.Security.Cryptography.Algorithms => 223
	i64 u0x17125c9a85b4929f, ; 75: lib_netstandard.dll.so => 249
	i64 u0x1716866f7416792e, ; 76: lib_System.Security.AccessControl.dll.so => 221
	i64 u0x17b56e25558a5d36, ; 77: lib-hu-Microsoft.Maui.Controls.resources.dll.so => 12
	i64 u0x17f9358913beb16a, ; 78: System.Text.Encodings.Web => 233
	i64 u0x18402a709e357f3b, ; 79: lib_Xamarin.KotlinX.Serialization.Core.Jvm.dll.so => 155
	i64 u0x18a9befae51bb361, ; 80: System.Net.WebClient => 198
	i64 u0x18f0ce884e87d89a, ; 81: nb/Microsoft.Maui.Controls.resources.dll => 18
	i64 u0x18facb3695ca9224, ; 82: Refit.HttpClientFactory => 108
	i64 u0x19a4c090f14ebb66, ; 83: System.Security.Claims => 222
	i64 u0x1a63352be1054efd, ; 84: Microsoft.AspNetCore.Hosting.Server.Abstractions.dll => 50
	i64 u0x1a6fceea64859810, ; 85: Azure.Identity => 37
	i64 u0x1a91866a319e9259, ; 86: lib_System.Collections.Concurrent.dll.so => 161
	i64 u0x1aac34d1917ba5d3, ; 87: lib_System.dll.so => 247
	i64 u0x1aad60783ffa3e5b, ; 88: lib-th-Microsoft.Maui.Controls.resources.dll.so => 27
	i64 u0x1bea5a36aa1ed8de, ; 89: Microsoft.AspNetCore.Http.Extensions => 55
	i64 u0x1c292b1598348d77, ; 90: Microsoft.Extensions.Diagnostics.dll => 81
	i64 u0x1c753b5ff15bce1b, ; 91: Mono.Android.Runtime.dll => 252
	i64 u0x1db6820994506bf5, ; 92: System.IO.FileSystem.AccessControl.dll => 182
	i64 u0x1dbb0c2c6a999acb, ; 93: System.Diagnostics.StackTrace => 174
	i64 u0x1e3d87657e9659bc, ; 94: Xamarin.AndroidX.Navigation.UI => 146
	i64 u0x1e71143913d56c10, ; 95: lib-ko-Microsoft.Maui.Controls.resources.dll.so => 16
	i64 u0x1ed8fcce5e9b50a0, ; 96: Microsoft.Extensions.Options.dll => 89
	i64 u0x1f055d15d807e1b2, ; 97: System.Xml.XmlSerializer => 246
	i64 u0x1fd24a4951087d1f, ; 98: Microsoft.AspNetCore.Mvc.Core.dll => 58
	i64 u0x20237ea48006d7a8, ; 99: lib_System.Net.WebClient.dll.so => 198
	i64 u0x20535f50a78369d1, ; 100: lib_Mono.HttpUtility.dll.so => 106
	i64 u0x209375905fcc1bad, ; 101: lib_System.IO.Compression.Brotli.dll.so => 180
	i64 u0x20fab3cf2dfbc8df, ; 102: lib_System.Diagnostics.Process.dll.so => 173
	i64 u0x2174319c0d835bc9, ; 103: System.Runtime => 220
	i64 u0x2199f06354c82d3b, ; 104: System.ClientModel.dll => 119
	i64 u0x21cc7e445dcd5469, ; 105: System.Reflection.Emit.ILGeneration => 208
	i64 u0x220fd4f2e7c48170, ; 106: th/Microsoft.Maui.Controls.resources => 27
	i64 u0x224538d85ed15a82, ; 107: System.IO.Pipes => 185
	i64 u0x235fb4941dc174e1, ; 108: DocumentFormat.OpenXml => 41
	i64 u0x237be844f1f812c7, ; 109: System.Threading.Thread.dll => 238
	i64 u0x23807c59646ec4f3, ; 110: lib_Microsoft.EntityFrameworkCore.dll.so => 70
	i64 u0x2407aef2bbe8fadf, ; 111: System.Console => 170
	i64 u0x240abe014b27e7d3, ; 112: Xamarin.AndroidX.Core.dll => 133
	i64 u0x247619fe4413f8bf, ; 113: System.Runtime.Serialization.Primitives.dll => 218
	i64 u0x252073cc3caa62c2, ; 114: fr/Microsoft.Maui.Controls.resources.dll => 8
	i64 u0x25a0a7eff76ea08e, ; 115: SQLitePCLRaw.batteries_v2.dll => 109
	i64 u0x2662c629b96b0b30, ; 116: lib_Xamarin.Kotlin.StdLib.dll.so => 153
	i64 u0x268c1439f13bcc29, ; 117: lib_Microsoft.Extensions.Primitives.dll.so => 90
	i64 u0x270a44600c921861, ; 118: System.IdentityModel.Tokens.Jwt => 121
	i64 u0x273f3515de5faf0d, ; 119: id/Microsoft.Maui.Controls.resources.dll => 13
	i64 u0x2742545f9094896d, ; 120: hr/Microsoft.Maui.Controls.resources => 11
	i64 u0x2759af78ab94d39b, ; 121: System.Net.WebSockets => 201
	i64 u0x27b410442fad6cf1, ; 122: Java.Interop.dll => 251
	i64 u0x2801845a2c71fbfb, ; 123: System.Net.Primitives.dll => 194
	i64 u0x288f0dc6b8b36b5f, ; 124: Refit.dll => 107
	i64 u0x28b311fffbc0f8df, ; 125: Microsoft.AspNetCore.WebUtilities => 67
	i64 u0x28e52865585a1ebe, ; 126: Microsoft.Extensions.Diagnostics.Abstractions.dll => 82
	i64 u0x298435b07b00e928, ; 127: lib-en-US-Syncfusion.Maui.ImageEditor.resources.dll.so => 34
	i64 u0x2a128783efe70ba0, ; 128: uk/Microsoft.Maui.Controls.resources.dll => 29
	i64 u0x2a3b095612184159, ; 129: lib_System.Net.NetworkInformation.dll.so => 193
	i64 u0x2a6507a5ffabdf28, ; 130: System.Diagnostics.TraceSource.dll => 175
	i64 u0x2ad156c8e1354139, ; 131: fi/Microsoft.Maui.Controls.resources => 7
	i64 u0x2af298f63581d886, ; 132: System.Text.RegularExpressions.dll => 235
	i64 u0x2af615542f04da50, ; 133: System.IdentityModel.Tokens.Jwt.dll => 121
	i64 u0x2afc1c4f898552ee, ; 134: lib_System.Formats.Asn1.dll.so => 179
	i64 u0x2b148910ed40fbf9, ; 135: zh-Hant/Microsoft.Maui.Controls.resources.dll => 33
	i64 u0x2c40db0dbedda89b, ; 136: lib_Microsoft.AspNetCore.WebUtilities.dll.so => 67
	i64 u0x2c8bd14bb93a7d82, ; 137: lib-pl-Microsoft.Maui.Controls.resources.dll.so => 20
	i64 u0x2cbd9262ca785540, ; 138: lib_System.Text.Encoding.CodePages.dll.so => 231
	i64 u0x2cc9e1fed6257257, ; 139: lib_System.Reflection.Emit.Lightweight.dll.so => 209
	i64 u0x2cd723e9fe623c7c, ; 140: lib_System.Private.Xml.Linq.dll.so => 206
	i64 u0x2cdbe1c1d4183ec1, ; 141: lib_Syncfusion.Licensing.dll.so => 113
	i64 u0x2d169d318a968379, ; 142: System.Threading.dll => 240
	i64 u0x2d47774b7d993f59, ; 143: sv/Microsoft.Maui.Controls.resources.dll => 26
	i64 u0x2db915caf23548d2, ; 144: System.Text.Json.dll => 234
	i64 u0x2e6f1f226821322a, ; 145: el/Microsoft.Maui.Controls.resources.dll => 5
	i64 u0x2e7c9658c7fb7927, ; 146: Microsoft.Extensions.Features.dll => 83
	i64 u0x2f02f94df3200fe5, ; 147: System.Diagnostics.Process => 173
	i64 u0x2f2e98e1c89b1aff, ; 148: System.Xml.ReaderWriter => 244
	i64 u0x2f40b2521deba305, ; 149: lib_Microsoft.SqlServer.Server.dll.so => 105
	i64 u0x2f5911d9ba814e4e, ; 150: System.Diagnostics.Tracing => 176
	i64 u0x2feb4d2fcda05cfd, ; 151: Microsoft.Extensions.Caching.Abstractions.dll => 74
	i64 u0x2ff49de6a71764a1, ; 152: lib_Microsoft.Extensions.Http.dll.so => 85
	i64 u0x309ee9eeec09a71e, ; 153: lib_Xamarin.AndroidX.Fragment.dll.so => 137
	i64 u0x309f2bedefa9a318, ; 154: Microsoft.IdentityModel.Abstractions => 93
	i64 u0x31195fef5d8fb552, ; 155: _Microsoft.Android.Resource.Designer.dll => 35
	i64 u0x31700b3b2a9fc1c2, ; 156: Microsoft.AspNetCore.SignalR.Core.dll => 65
	i64 u0x32243413e774362a, ; 157: Xamarin.AndroidX.CardView.dll => 130
	i64 u0x3235427f8d12dae1, ; 158: lib_System.Drawing.Primitives.dll.so => 177
	i64 u0x329753a17a517811, ; 159: fr/Microsoft.Maui.Controls.resources => 8
	i64 u0x32aa989ff07a84ff, ; 160: lib_System.Xml.ReaderWriter.dll.so => 244
	i64 u0x33829542f112d59b, ; 161: System.Collections.Immutable => 162
	i64 u0x33a31443733849fe, ; 162: lib-es-Microsoft.Maui.Controls.resources.dll.so => 6
	i64 u0x341abc357fbb4ebf, ; 163: lib_System.Net.Sockets.dll.so => 197
	i64 u0x348d598f4054415e, ; 164: Microsoft.SqlServer.Server => 105
	i64 u0x34dfd74fe2afcf37, ; 165: Microsoft.Maui => 101
	i64 u0x34e292762d9615df, ; 166: cs/Microsoft.Maui.Controls.resources.dll => 2
	i64 u0x3508234247f48404, ; 167: Microsoft.Maui.Controls => 99
	i64 u0x353590da528c9d22, ; 168: System.ComponentModel.Annotations => 166
	i64 u0x3549870798b4cd30, ; 169: lib_Xamarin.AndroidX.ViewPager2.dll.so => 151
	i64 u0x355282fc1c909694, ; 170: Microsoft.Extensions.Configuration => 76
	i64 u0x35ea419d842e2b43, ; 171: Syncfusion.Maui.ImageEditor.dll => 115
	i64 u0x36b2b50fdf589ae2, ; 172: System.Reflection.Emit.Lightweight => 209
	i64 u0x374ef46b06791af6, ; 173: System.Reflection.Primitives.dll => 211
	i64 u0x380134e03b1e160a, ; 174: System.Collections.Immutable.dll => 162
	i64 u0x385c17636bb6fe6e, ; 175: Xamarin.AndroidX.CustomView.dll => 135
	i64 u0x38869c811d74050e, ; 176: System.Net.NameResolution.dll => 192
	i64 u0x38e93ec1c057cdf6, ; 177: Microsoft.IdentityModel.Protocols => 96
	i64 u0x38f71e7a64343c93, ; 178: lib_Microsoft.AspNetCore.Authorization.Policy.dll.so => 47
	i64 u0x39251dccb84bdcaa, ; 179: lib_System.Configuration.ConfigurationManager.dll.so => 120
	i64 u0x393c226616977fdb, ; 180: lib_Xamarin.AndroidX.ViewPager.dll.so => 150
	i64 u0x395e37c3334cf82a, ; 181: lib-ca-Microsoft.Maui.Controls.resources.dll.so => 1
	i64 u0x39c3107c28752af1, ; 182: lib_Microsoft.Extensions.FileProviders.Abstractions.dll.so => 84
	i64 u0x3ab5859054645f72, ; 183: System.Security.Cryptography.Primitives.dll => 227
	i64 u0x3b860f9932505633, ; 184: lib_System.Text.Encoding.Extensions.dll.so => 232
	i64 u0x3bea9ebe8c027c01, ; 185: lib_Microsoft.IdentityModel.Tokens.dll.so => 98
	i64 u0x3c3aafb6b3a00bf6, ; 186: lib_System.Security.Cryptography.X509Certificates.dll.so => 228
	i64 u0x3c5f19e4acdcebd8, ; 187: lib_Microsoft.Data.SqlClient.dll.so => 69
	i64 u0x3c7c495f58ac5ee9, ; 188: Xamarin.Kotlin.StdLib => 153
	i64 u0x3ca05b43ec08224f, ; 189: Microsoft.AspNetCore.Http.Extensions.dll => 55
	i64 u0x3cd9d281d402eb9b, ; 190: Xamarin.AndroidX.Browser.dll => 129
	i64 u0x3d2b1913edfc08d7, ; 191: lib_System.Threading.ThreadPool.dll.so => 239
	i64 u0x3d46f0b995082740, ; 192: System.Xml.Linq => 243
	i64 u0x3d9c2a242b040a50, ; 193: lib_Xamarin.AndroidX.Core.dll.so => 133
	i64 u0x3da7781d6333a8fe, ; 194: SQLitePCLRaw.batteries_v2 => 109
	i64 u0x3e580c35ecfc1247, ; 195: lib_Microsoft.AspNetCore.Http.dll.so => 51
	i64 u0x3f3c8f45ab6f28c7, ; 196: Microsoft.Identity.Client.Extensions.Msal.dll => 92
	i64 u0x3f510adf788828dd, ; 197: System.Threading.Tasks.Extensions => 237
	i64 u0x407a10bb4bf95829, ; 198: lib_Xamarin.AndroidX.Navigation.Common.dll.so => 143
	i64 u0x407ac43dee26bd5a, ; 199: lib_Azure.Identity.dll.so => 37
	i64 u0x415e36f6b13ff6f3, ; 200: System.Configuration.ConfigurationManager.dll => 120
	i64 u0x41833cf766d27d96, ; 201: mscorlib => 248
	i64 u0x41cab042be111c34, ; 202: lib_Xamarin.AndroidX.AppCompat.AppCompatResources.dll.so => 128
	i64 u0x430e95b891249788, ; 203: lib_System.Reflection.Emit.dll.so => 210
	i64 u0x43375950ec7c1b6a, ; 204: netstandard.dll => 249
	i64 u0x434c4e1d9284cdae, ; 205: Mono.Android.dll => 253
	i64 u0x43950f84de7cc79a, ; 206: pl/Microsoft.Maui.Controls.resources.dll => 20
	i64 u0x43ae6dce532612d0, ; 207: DocumentFormat.OpenXml.VariableReplacer.Core.dll => 43
	i64 u0x448bd33429269b19, ; 208: Microsoft.CSharp => 158
	i64 u0x4499fa3c8e494654, ; 209: lib_System.Runtime.Serialization.Primitives.dll.so => 218
	i64 u0x44de556bf0476715, ; 210: Mono.HttpUtility => 106
	i64 u0x4515080865a951a5, ; 211: Xamarin.Kotlin.StdLib.dll => 153
	i64 u0x45344658e8f1a46d, ; 212: Microsoft.AspNetCore.Authentication.Core => 45
	i64 u0x453c1277f85cf368, ; 213: lib_Microsoft.EntityFrameworkCore.Abstractions.dll.so => 71
	i64 u0x458d2df79ac57c1d, ; 214: lib_System.IdentityModel.Tokens.Jwt.dll.so => 121
	i64 u0x45c40276a42e283e, ; 215: System.Diagnostics.TraceSource => 175
	i64 u0x45fcc9fd66f25095, ; 216: Microsoft.Extensions.DependencyModel => 80
	i64 u0x46a4213bc97fe5ae, ; 217: lib-ru-Microsoft.Maui.Controls.resources.dll.so => 24
	i64 u0x47358bd471172e1d, ; 218: lib_System.Xml.Linq.dll.so => 243
	i64 u0x4787a936949fcac2, ; 219: System.Memory.Data.dll => 122
	i64 u0x47daf4e1afbada10, ; 220: pt/Microsoft.Maui.Controls.resources => 22
	i64 u0x48a6d2fa2eb5d049, ; 221: Microsoft.AspNetCore.SignalR.Protocols.Json => 66
	i64 u0x48e9c8e5d5e8555a, ; 222: DocumentFormat.OpenXml.dll => 41
	i64 u0x49e952f19a4e2022, ; 223: System.ObjectModel => 203
	i64 u0x49ea01c721d701b5, ; 224: lib_Microsoft.Net.Http.Headers.dll.so => 104
	i64 u0x4a5667b2462a664b, ; 225: lib_Xamarin.AndroidX.Navigation.UI.dll.so => 146
	i64 u0x4a78a24dc5b649fc, ; 226: Syncfusion.Maui.Core.dll => 114
	i64 u0x4b576d47ac054f3c, ; 227: System.IO.FileSystem.AccessControl => 182
	i64 u0x4b5cc074fafbe58e, ; 228: Microsoft.AspNetCore.ResponseCaching.Abstractions => 59
	i64 u0x4b7b6532ded934b7, ; 229: System.Text.Json => 234
	i64 u0x4b8f8ea3c2df6bb0, ; 230: System.ClientModel => 119
	i64 u0x4bbc7df476e2e556, ; 231: Microsoft.AspNetCore.Mvc.Abstractions.dll => 57
	i64 u0x4c7755cf07ad2d5f, ; 232: System.Net.Http.Json.dll => 190
	i64 u0x4ca014ceac582c86, ; 233: Microsoft.EntityFrameworkCore.Relational.dll => 72
	i64 u0x4cc5f15266470798, ; 234: lib_Xamarin.AndroidX.Loader.dll.so => 142
	i64 u0x4cf6f67dc77aacd2, ; 235: System.Net.NetworkInformation.dll => 193
	i64 u0x4d3183dd245425d4, ; 236: System.Net.WebSockets.Client.dll => 200
	i64 u0x4d479f968a05e504, ; 237: System.Linq.Expressions.dll => 186
	i64 u0x4d55a010ffc4faff, ; 238: System.Private.Xml => 207
	i64 u0x4d6001db23f8cd87, ; 239: lib_System.ClientModel.dll.so => 119
	i64 u0x4d95fccc1f67c7ca, ; 240: System.Runtime.Loader.dll => 214
	i64 u0x4dcf44c3c9b076a2, ; 241: it/Microsoft.Maui.Controls.resources.dll => 14
	i64 u0x4dd9247f1d2c3235, ; 242: Xamarin.AndroidX.Loader.dll => 142
	i64 u0x4e32f00cb0937401, ; 243: Mono.Android.Runtime => 252
	i64 u0x4e39d45ce072e04b, ; 244: Microsoft.AspNetCore.SignalR.Common.dll => 64
	i64 u0x4e5eea4668ac2b18, ; 245: System.Text.Encoding.CodePages => 231
	i64 u0x4ebd0c4b82c5eefc, ; 246: lib_System.Threading.Channels.dll.so => 236
	i64 u0x4f21ee6ef9eb527e, ; 247: ca/Microsoft.Maui.Controls.resources => 1
	i64 u0x4fd5f3ee53d0a4f0, ; 248: SQLitePCLRaw.lib.e_sqlite3.android => 111
	i64 u0x4ff55724131c908c, ; 249: lib_Microsoft.AspNetCore.Mvc.Core.dll.so => 58
	i64 u0x4ffd65baff757598, ; 250: Microsoft.IdentityModel.Tokens => 98
	i64 u0x5037f0be3c28c7a3, ; 251: lib_Microsoft.Maui.Controls.dll.so => 99
	i64 u0x5112ed116d87baf8, ; 252: CommunityToolkit.Mvvm => 40
	i64 u0x5131bbe80989093f, ; 253: Xamarin.AndroidX.Lifecycle.ViewModel.Android.dll => 140
	i64 u0x51bb8a2afe774e32, ; 254: System.Drawing => 178
	i64 u0x5216f09c5c4c95c8, ; 255: Microsoft.AspNetCore.Authentication.Abstractions => 44
	i64 u0x526ce79eb8e90527, ; 256: lib_System.Net.Primitives.dll.so => 194
	i64 u0x527497f521875686, ; 257: Microsoft.AspNetCore.Http.Abstractions => 52
	i64 u0x52829f00b4467c38, ; 258: lib_System.Data.Common.dll.so => 171
	i64 u0x529ffe06f39ab8db, ; 259: Xamarin.AndroidX.Core => 133
	i64 u0x52ff996554dbf352, ; 260: Microsoft.Maui.Graphics => 103
	i64 u0x535f7e40e8fef8af, ; 261: lib-sk-Microsoft.Maui.Controls.resources.dll.so => 25
	i64 u0x53978aac584c666e, ; 262: lib_System.Security.Cryptography.Cng.dll.so => 224
	i64 u0x53a96d5c86c9e194, ; 263: System.Net.NetworkInformation => 193
	i64 u0x53be1038a61e8d44, ; 264: System.Runtime.InteropServices.RuntimeInformation.dll => 212
	i64 u0x53c3014b9437e684, ; 265: lib-zh-HK-Microsoft.Maui.Controls.resources.dll.so => 31
	i64 u0x5435e6f049e9bc37, ; 266: System.Security.Claims.dll => 222
	i64 u0x54795225dd1587af, ; 267: lib_System.Runtime.dll.so => 220
	i64 u0x556e8b63b660ab8b, ; 268: Xamarin.AndroidX.Lifecycle.Common.Jvm.dll => 138
	i64 u0x5588627c9a108ec9, ; 269: System.Collections.Specialized => 164
	i64 u0x56442b99bc64bb47, ; 270: System.Runtime.Serialization.Xml.dll => 219
	i64 u0x571c5cfbec5ae8e2, ; 271: System.Private.Uri => 205
	i64 u0x578cd35c91d7b347, ; 272: lib_SQLitePCLRaw.core.dll.so => 110
	i64 u0x579a06fed6eec900, ; 273: System.Private.CoreLib.dll => 250
	i64 u0x57c542c14049b66d, ; 274: System.Diagnostics.DiagnosticSource => 172
	i64 u0x58601b2dda4a27b9, ; 275: lib-ja-Microsoft.Maui.Controls.resources.dll.so => 15
	i64 u0x58688d9af496b168, ; 276: Microsoft.Extensions.DependencyInjection.dll => 78
	i64 u0x587f59a16b329d9c, ; 277: Microsoft.Net.Http.Headers => 104
	i64 u0x595a356d23e8da9a, ; 278: lib_Microsoft.CSharp.dll.so => 158
	i64 u0x59c270386bf40142, ; 279: Microsoft.AspNetCore.Hosting.Server.Abstractions => 50
	i64 u0x5a70033ca9d003cb, ; 280: lib_System.Memory.Data.dll.so => 122
	i64 u0x5a89a886ae30258d, ; 281: lib_Xamarin.AndroidX.CoordinatorLayout.dll.so => 132
	i64 u0x5a8f6699f4a1caa9, ; 282: lib_System.Threading.dll.so => 240
	i64 u0x5ae9cd33b15841bf, ; 283: System.ComponentModel => 169
	i64 u0x5b247cf480c75903, ; 284: Microsoft.AspNetCore.Http.Connections.Common.dll => 54
	i64 u0x5b54391bdc6fcfe6, ; 285: System.Private.DataContractSerialization => 204
	i64 u0x5b5f0e240a06a2a2, ; 286: da/Microsoft.Maui.Controls.resources.dll => 3
	i64 u0x5beca398fe6dce6b, ; 287: lib_Microsoft.AspNetCore.Mvc.Abstractions.dll.so => 57
	i64 u0x5c294d94f201783b, ; 288: lib_Microsoft.AspNetCore.Http.Connections.Client.dll.so => 53
	i64 u0x5c393624b8176517, ; 289: lib_Microsoft.Extensions.Logging.dll.so => 86
	i64 u0x5cbe0283eb598ee8, ; 290: Microsoft.AspNetCore.Routing => 60
	i64 u0x5d0a4a29b02d9d3c, ; 291: System.Net.WebHeaderCollection.dll => 199
	i64 u0x5db0cbbd1028510e, ; 292: lib_System.Runtime.InteropServices.dll.so => 213
	i64 u0x5db30905d3e5013b, ; 293: Xamarin.AndroidX.Collection.Jvm.dll => 131
	i64 u0x5e467bc8f09ad026, ; 294: System.Collections.Specialized.dll => 164
	i64 u0x5ea92fdb19ec8c4c, ; 295: System.Text.Encodings.Web.dll => 233
	i64 u0x5eb8046dd40e9ac3, ; 296: System.ComponentModel.Primitives => 167
	i64 u0x5ebd5650f422a0b0, ; 297: lib_DocumentFormat.OpenXml.VariableReplacer.Core.dll.so => 43
	i64 u0x5ec272d219c9aba4, ; 298: System.Security.Cryptography.Csp.dll => 225
	i64 u0x5f36ccf5c6a57e24, ; 299: System.Xml.ReaderWriter.dll => 244
	i64 u0x5f4294b9b63cb842, ; 300: System.Data.Common => 171
	i64 u0x5f7399e166075632, ; 301: lib_SQLitePCLRaw.lib.e_sqlite3.android.dll.so => 111
	i64 u0x5f9a2d823f664957, ; 302: lib-el-Microsoft.Maui.Controls.resources.dll.so => 5
	i64 u0x5fd02402d97cdaab, ; 303: lib_Microsoft.Extensions.ObjectPool.dll.so => 88
	i64 u0x609f4b7b63d802d4, ; 304: lib_Microsoft.Extensions.DependencyInjection.dll.so => 78
	i64 u0x60cd4e33d7e60134, ; 305: Xamarin.KotlinX.Coroutines.Core.Jvm => 154
	i64 u0x60f62d786afcf130, ; 306: System.Memory => 189
	i64 u0x61be8d1299194243, ; 307: Microsoft.Maui.Controls.Xaml => 100
	i64 u0x61d2cba29557038f, ; 308: de/Microsoft.Maui.Controls.resources => 4
	i64 u0x61d88f399afb2f45, ; 309: lib_System.Runtime.Loader.dll.so => 214
	i64 u0x622eef6f9e59068d, ; 310: System.Private.CoreLib => 250
	i64 u0x63f1f6883c1e23c2, ; 311: lib_System.Collections.Immutable.dll.so => 162
	i64 u0x6400f68068c1e9f1, ; 312: Xamarin.Google.Android.Material.dll => 152
	i64 u0x640e3b14dbd325c2, ; 313: System.Security.Cryptography.Algorithms.dll => 223
	i64 u0x64b61dd9da8a4d57, ; 314: System.Net.ServerSentEvents.dll => 123
	i64 u0x658f524e4aba7dad, ; 315: CommunityToolkit.Maui.dll => 38
	i64 u0x659dc45417570048, ; 316: Refit => 107
	i64 u0x65ecac39144dd3cc, ; 317: Microsoft.Maui.Controls.dll => 99
	i64 u0x65ece51227bfa724, ; 318: lib_System.Runtime.Numerics.dll.so => 215
	i64 u0x6692e924eade1b29, ; 319: lib_System.Console.dll.so => 170
	i64 u0x66a4e5c6a3fb0bae, ; 320: lib_Xamarin.AndroidX.Lifecycle.ViewModel.Android.dll.so => 140
	i64 u0x66d13304ce1a3efa, ; 321: Xamarin.AndroidX.CursorAdapter => 134
	i64 u0x672a10d319608935, ; 322: lib_Microsoft.AspNetCore.Http.Connections.Common.dll.so => 54
	i64 u0x68558ec653afa616, ; 323: lib-da-Microsoft.Maui.Controls.resources.dll.so => 3
	i64 u0x6872ec7a2e36b1ac, ; 324: System.Drawing.Primitives.dll => 177
	i64 u0x68fbbbe2eb455198, ; 325: System.Formats.Asn1 => 179
	i64 u0x69063fc0ba8e6bdd, ; 326: he/Microsoft.Maui.Controls.resources.dll => 9
	i64 u0x699dffb2427a2d71, ; 327: SQLitePCLRaw.lib.e_sqlite3.android.dll => 111
	i64 u0x6a4d7577b2317255, ; 328: System.Runtime.InteropServices.dll => 213
	i64 u0x6ace3b74b15ee4a4, ; 329: nb/Microsoft.Maui.Controls.resources => 18
	i64 u0x6cd97f370311a542, ; 330: Microsoft.EntityFrameworkCore.SqlServer => 73
	i64 u0x6d0a12b2adba20d8, ; 331: System.Security.Cryptography.ProtectedData.dll => 125
	i64 u0x6d12bfaa99c72b1f, ; 332: lib_Microsoft.Maui.Graphics.dll.so => 103
	i64 u0x6d79993361e10ef2, ; 333: Microsoft.Extensions.Primitives => 90
	i64 u0x6d86d56b84c8eb71, ; 334: lib_Xamarin.AndroidX.CursorAdapter.dll.so => 134
	i64 u0x6d9bea6b3e895cf7, ; 335: Microsoft.Extensions.Primitives.dll => 90
	i64 u0x6e25a02c3833319a, ; 336: lib_Xamarin.AndroidX.Navigation.Fragment.dll.so => 144
	i64 u0x6fd2265da78b93a4, ; 337: lib_Microsoft.Maui.dll.so => 101
	i64 u0x6fdfc7de82c33008, ; 338: cs/Microsoft.Maui.Controls.resources => 2
	i64 u0x6ffc4967cc47ba57, ; 339: System.IO.FileSystem.Watcher.dll => 183
	i64 u0x70e99f48c05cb921, ; 340: tr/Microsoft.Maui.Controls.resources.dll => 28
	i64 u0x70fd3deda22442d2, ; 341: lib-nb-Microsoft.Maui.Controls.resources.dll.so => 18
	i64 u0x717530326f808838, ; 342: lib_Microsoft.Extensions.Diagnostics.Abstractions.dll.so => 82
	i64 u0x71a495ea3761dde8, ; 343: lib-it-Microsoft.Maui.Controls.resources.dll.so => 14
	i64 u0x71ad672adbe48f35, ; 344: System.ComponentModel.Primitives.dll => 167
	i64 u0x7242820f67bc4ad6, ; 345: Microsoft.AspNetCore.SignalR.Common => 64
	i64 u0x725f5a9e82a45c81, ; 346: System.Security.Cryptography.Encoding => 226
	i64 u0x72b1fb4109e08d7b, ; 347: lib-hr-Microsoft.Maui.Controls.resources.dll.so => 11
	i64 u0x733c9fa4b145dea1, ; 348: lib_SocialMauiApp.dll.so => 157
	i64 u0x73a2b85f84dcec96, ; 349: lib_DocumentFormat.OpenXml.dll.so => 41
	i64 u0x73e4ce94e2eb6ffc, ; 350: lib_System.Memory.dll.so => 189
	i64 u0x746cf89b511b4d40, ; 351: lib_Microsoft.Extensions.Diagnostics.dll.so => 81
	i64 u0x755a91767330b3d4, ; 352: lib_Microsoft.Extensions.Configuration.dll.so => 76
	i64 u0x758463c93f0d589e, ; 353: lib_Microsoft.AspNetCore.Connections.Abstractions.dll.so => 48
	i64 u0x76012e7334db86e5, ; 354: lib_Xamarin.AndroidX.SavedState.dll.so => 148
	i64 u0x76ca07b878f44da0, ; 355: System.Runtime.Numerics.dll => 215
	i64 u0x77d9074d8f33a303, ; 356: lib_System.Net.ServerSentEvents.dll.so => 123
	i64 u0x77f8a4acc2fdc449, ; 357: System.Security.Cryptography.Cng.dll => 224
	i64 u0x780bc73597a503a9, ; 358: lib-ms-Microsoft.Maui.Controls.resources.dll.so => 17
	i64 u0x783606d1e53e7a1a, ; 359: th/Microsoft.Maui.Controls.resources.dll => 27
	i64 u0x78a1938b89c96721, ; 360: Microsoft.AspNetCore.Http.Connections.Common => 54
	i64 u0x78a45e51311409b6, ; 361: Xamarin.AndroidX.Fragment.dll => 137
	i64 u0x7985af0fe05692bb, ; 362: lib_SocialMediaMaui.Shared.dll.so => 156
	i64 u0x7a25bdb29108c6e7, ; 363: Microsoft.Extensions.Http => 85
	i64 u0x7adb8da2ac89b647, ; 364: fi/Microsoft.Maui.Controls.resources.dll => 7
	i64 u0x7b4927e421291c41, ; 365: Microsoft.IdentityModel.JsonWebTokens.dll => 94
	i64 u0x7bef86a4335c4870, ; 366: System.ComponentModel.TypeConverter => 168
	i64 u0x7c0820144cd34d6a, ; 367: sk/Microsoft.Maui.Controls.resources.dll => 25
	i64 u0x7c2a0bd1e0f988fc, ; 368: lib-de-Microsoft.Maui.Controls.resources.dll.so => 4
	i64 u0x7c41d387501568ba, ; 369: System.Net.WebClient.dll => 198
	i64 u0x7cc637f941f716d0, ; 370: CommunityToolkit.Maui.Core => 39
	i64 u0x7d49c593eeb09ac9, ; 371: Microsoft.AspNetCore.SignalR.Client.dll => 62
	i64 u0x7d649b75d580bb42, ; 372: ms/Microsoft.Maui.Controls.resources.dll => 17
	i64 u0x7d8ee2bdc8e3aad1, ; 373: System.Numerics.Vectors => 202
	i64 u0x7dfc3d6d9d8d7b70, ; 374: System.Collections => 165
	i64 u0x7e2e564fa2f76c65, ; 375: lib_System.Diagnostics.Tracing.dll.so => 176
	i64 u0x7e302e110e1e1346, ; 376: lib_System.Security.Claims.dll.so => 222
	i64 u0x7e946809d6008ef2, ; 377: lib_System.ObjectModel.dll.so => 203
	i64 u0x7ecc13347c8fd849, ; 378: lib_System.ComponentModel.dll.so => 169
	i64 u0x7eff369f2e01cf95, ; 379: Microsoft.AspNetCore.Http.Features => 56
	i64 u0x7f00ddd9b9ca5a13, ; 380: Xamarin.AndroidX.ViewPager.dll => 150
	i64 u0x7f9351cd44b1273f, ; 381: Microsoft.Extensions.Configuration.Abstractions => 77
	i64 u0x7fae0ef4dc4770fe, ; 382: Microsoft.Identity.Client => 91
	i64 u0x7fbd557c99b3ce6f, ; 383: lib_Xamarin.AndroidX.Lifecycle.LiveData.Core.dll.so => 139
	i64 u0x7fd75077141d6658, ; 384: Microsoft.AspNetCore.Authorization.Policy => 47
	i64 u0x80fa55b6d1b0be99, ; 385: SQLitePCLRaw.provider.e_sqlite3 => 112
	i64 u0x812c069d5cdecc17, ; 386: System.dll => 247
	i64 u0x81ab745f6c0f5ce6, ; 387: zh-Hant/Microsoft.Maui.Controls.resources => 33
	i64 u0x822aa49008112ebe, ; 388: Microsoft.Extensions.ObjectPool => 88
	i64 u0x8277f2be6b5ce05f, ; 389: Xamarin.AndroidX.AppCompat => 127
	i64 u0x828f06563b30bc50, ; 390: lib_Xamarin.AndroidX.CardView.dll.so => 130
	i64 u0x82df8f5532a10c59, ; 391: lib_System.Drawing.dll.so => 178
	i64 u0x82f6403342e12049, ; 392: uk/Microsoft.Maui.Controls.resources => 29
	i64 u0x83a7afd2c49adc86, ; 393: lib_Microsoft.IdentityModel.Abstractions.dll.so => 93
	i64 u0x83c14ba66c8e2b8c, ; 394: zh-Hans/Microsoft.Maui.Controls.resources => 32
	i64 u0x846f52335a832137, ; 395: Microsoft.Extensions.Features => 83
	i64 u0x84ae73148a4557d2, ; 396: lib_System.IO.Pipes.dll.so => 185
	i64 u0x84b01102c12a9232, ; 397: System.Runtime.Serialization.Json.dll => 217
	i64 u0x84cd5cdec0f54bcc, ; 398: lib_Microsoft.EntityFrameworkCore.Relational.dll.so => 72
	i64 u0x84f20950c4c7164b, ; 399: Microsoft.AspNetCore.Http => 51
	i64 u0x8636d45a3b98cdf7, ; 400: Syncfusion.Maui.ImageEditor => 115
	i64 u0x86a909228dc7657b, ; 401: lib-zh-Hant-Microsoft.Maui.Controls.resources.dll.so => 33
	i64 u0x86b3e00c36b84509, ; 402: Microsoft.Extensions.Configuration.dll => 76
	i64 u0x86b62cb077ec4fd7, ; 403: System.Runtime.Serialization.Xml => 219
	i64 u0x87a3c575cf2318ce, ; 404: Syncfusion.Maui.Sliders.dll => 116
	i64 u0x87c4b8a492b176ad, ; 405: Microsoft.EntityFrameworkCore.Abstractions => 71
	i64 u0x87c69b87d9283884, ; 406: lib_System.Threading.Thread.dll.so => 238
	i64 u0x87d6cb5c641c5f07, ; 407: Microsoft.AspNetCore.Http.Abstractions.dll => 52
	i64 u0x87f6569b25707834, ; 408: System.IO.Compression.Brotli.dll => 180
	i64 u0x8842b3a5d2d3fb36, ; 409: Microsoft.Maui.Essentials => 102
	i64 u0x88bda98e0cffb7a9, ; 410: lib_Xamarin.KotlinX.Coroutines.Core.Jvm.dll.so => 154
	i64 u0x890981e3e80b7d74, ; 411: lib_Syncfusion.Maui.ImageEditor.dll.so => 115
	i64 u0x8930322c7bd8f768, ; 412: netstandard => 249
	i64 u0x897a606c9e39c75f, ; 413: lib_System.ComponentModel.Primitives.dll.so => 167
	i64 u0x89c5188089ec2cd5, ; 414: lib_System.Runtime.InteropServices.RuntimeInformation.dll.so => 212
	i64 u0x8a0b6f586fccda8a, ; 415: lib_Microsoft.AspNetCore.Http.Extensions.dll.so => 55
	i64 u0x8a14bf4400a024af, ; 416: lib_Microsoft.AspNetCore.Http.Features.dll.so => 56
	i64 u0x8a399a706fcbce4b, ; 417: Microsoft.Extensions.Caching.Abstractions => 74
	i64 u0x8ac8d025b93e29e9, ; 418: Syncfusion.Licensing => 113
	i64 u0x8ad229ea26432ee2, ; 419: Xamarin.AndroidX.Loader => 142
	i64 u0x8b42b55a5bb040b5, ; 420: lib_Microsoft.AspNetCore.SignalR.Protocols.Json.dll.so => 66
	i64 u0x8b4ff5d0fdd5faa1, ; 421: lib_System.Diagnostics.DiagnosticSource.dll.so => 172
	i64 u0x8b541d476eb3774c, ; 422: System.Security.Principal.Windows => 230
	i64 u0x8b8d01333a96d0b5, ; 423: System.Diagnostics.Process.dll => 173
	i64 u0x8b9ceca7acae3451, ; 424: lib-he-Microsoft.Maui.Controls.resources.dll.so => 9
	i64 u0x8bb8206f414c7c3b, ; 425: Microsoft.AspNetCore.Authentication.Core.dll => 45
	i64 u0x8c53ae18581b14f0, ; 426: Azure.Core => 36
	i64 u0x8c575135aa1ccef4, ; 427: Microsoft.Extensions.FileProviders.Abstractions => 84
	i64 u0x8cdfdb4ce85fb925, ; 428: lib_System.Security.Principal.Windows.dll.so => 230
	i64 u0x8cf51f1eb9e90658, ; 429: lib_Microsoft.EntityFrameworkCore.SqlServer.dll.so => 73
	i64 u0x8d0f420977c2c1c7, ; 430: Xamarin.AndroidX.CursorAdapter.dll => 134
	i64 u0x8d5f431bf67cc907, ; 431: SocialMediaMaui.Shared => 156
	i64 u0x8d7b8ab4b3310ead, ; 432: System.Threading => 240
	i64 u0x8da188285aadfe8e, ; 433: System.Collections.Concurrent => 161
	i64 u0x8dce248c34c54ef3, ; 434: lib_Microsoft.AspNetCore.Hosting.Abstractions.dll.so => 49
	i64 u0x8e623fec9635e28f, ; 435: Syncfusion.Maui.Toolkit.resources.dll => 118
	i64 u0x8e937db395a74375, ; 436: lib_Microsoft.Identity.Client.dll.so => 91
	i64 u0x8ed807bfe9858dfc, ; 437: Xamarin.AndroidX.Navigation.Common => 143
	i64 u0x8ee08b8194a30f48, ; 438: lib-hi-Microsoft.Maui.Controls.resources.dll.so => 10
	i64 u0x8ef7601039857a44, ; 439: lib-ro-Microsoft.Maui.Controls.resources.dll.so => 23
	i64 u0x8ef9414937d93a0a, ; 440: SQLitePCLRaw.core.dll => 110
	i64 u0x8f32c6f611f6ffab, ; 441: pt/Microsoft.Maui.Controls.resources.dll => 22
	i64 u0x8f8829d21c8985a4, ; 442: lib-pt-BR-Microsoft.Maui.Controls.resources.dll.so => 21
	i64 u0x8f97020698a101ba, ; 443: Microsoft.AspNetCore.Routing.dll => 60
	i64 u0x8fd27d934d7b3a55, ; 444: SQLitePCLRaw.core => 110
	i64 u0x90263f8448b8f572, ; 445: lib_System.Diagnostics.TraceSource.dll.so => 175
	i64 u0x90281820febeff00, ; 446: lib_Microsoft.AspNetCore.Routing.Abstractions.dll.so => 61
	i64 u0x903101b46fb73a04, ; 447: _Microsoft.Android.Resource.Designer => 35
	i64 u0x90393bd4865292f3, ; 448: lib_System.IO.Compression.dll.so => 181
	i64 u0x905e2b8e7ae91ae6, ; 449: System.Threading.Tasks.Extensions.dll => 237
	i64 u0x90634f86c5ebe2b5, ; 450: Xamarin.AndroidX.Lifecycle.ViewModel.Android => 140
	i64 u0x907b636704ad79ef, ; 451: lib_Microsoft.Maui.Controls.Xaml.dll.so => 100
	i64 u0x90ae2b5b8b652f2a, ; 452: lib_Microsoft.AspNetCore.SignalR.Client.Core.dll.so => 63
	i64 u0x91418dc638b29e68, ; 453: lib_Xamarin.AndroidX.CustomView.dll.so => 135
	i64 u0x9157bd523cd7ed36, ; 454: lib_System.Text.Json.dll.so => 234
	i64 u0x91a74f07b30d37e2, ; 455: System.Linq.dll => 188
	i64 u0x91fa41a87223399f, ; 456: ca/Microsoft.Maui.Controls.resources.dll => 1
	i64 u0x92dd6c6033393bf7, ; 457: Syncfusion.Maui.Toolkit.resources => 118
	i64 u0x93cfa73ab28d6e35, ; 458: ms/Microsoft.Maui.Controls.resources => 17
	i64 u0x944077d8ca3c6580, ; 459: System.IO.Compression.dll => 181
	i64 u0x948d746a7702861f, ; 460: Microsoft.IdentityModel.Logging.dll => 95
	i64 u0x9502fd818eed2359, ; 461: lib_Microsoft.IdentityModel.Protocols.OpenIdConnect.dll.so => 97
	i64 u0x9564283c37ed59a9, ; 462: lib_Microsoft.IdentityModel.Logging.dll.so => 95
	i64 u0x957a4cdfdcfd6d83, ; 463: Refit.HttpClientFactory.dll => 108
	i64 u0x967fc325e09bfa8c, ; 464: es/Microsoft.Maui.Controls.resources => 6
	i64 u0x96e49b31fe33d427, ; 465: Microsoft.Identity.Client.Extensions.Msal => 92
	i64 u0x9732d8dbddea3d9a, ; 466: id/Microsoft.Maui.Controls.resources => 13
	i64 u0x978be80e5210d31b, ; 467: Microsoft.Maui.Graphics.dll => 103
	i64 u0x97b8c771ea3e4220, ; 468: System.ComponentModel.dll => 169
	i64 u0x97e144c9d3c6976e, ; 469: System.Collections.Concurrent.dll => 161
	i64 u0x991d510397f92d9d, ; 470: System.Linq.Expressions => 186
	i64 u0x999cb19e1a04ffd3, ; 471: CommunityToolkit.Mvvm.dll => 40
	i64 u0x99a00ca5270c6878, ; 472: Xamarin.AndroidX.Navigation.Runtime => 145
	i64 u0x99cdc6d1f2d3a72f, ; 473: ko/Microsoft.Maui.Controls.resources.dll => 16
	i64 u0x9a0cc42c6f36dfc9, ; 474: lib_Microsoft.IdentityModel.Protocols.dll.so => 96
	i64 u0x9b211a749105beac, ; 475: System.Transactions.Local => 241
	i64 u0x9c244ac7cda32d26, ; 476: System.Security.Cryptography.X509Certificates.dll => 228
	i64 u0x9d5dbcf5a48583fe, ; 477: lib_Xamarin.AndroidX.Activity.dll.so => 126
	i64 u0x9d74dee1a7725f34, ; 478: Microsoft.Extensions.Configuration.Abstractions.dll => 77
	i64 u0x9e4534b6adaf6e84, ; 479: nl/Microsoft.Maui.Controls.resources => 19
	i64 u0x9eaf1efdf6f7267e, ; 480: Xamarin.AndroidX.Navigation.Common.dll => 143
	i64 u0x9ef542cf1f78c506, ; 481: Xamarin.AndroidX.Lifecycle.LiveData.Core => 139
	i64 u0x9f5c7301a67b9123, ; 482: lib_Syncfusion.Maui.Sliders.dll.so => 116
	i64 u0x9ffbb6b1434ad2df, ; 483: Microsoft.Identity.Client.dll => 91
	i64 u0xa05475503f80b7d9, ; 484: Microsoft.AspNetCore.Connections.Abstractions => 48
	i64 u0xa0d8259f4cc284ec, ; 485: lib_System.Security.Cryptography.dll.so => 229
	i64 u0xa1440773ee9d341e, ; 486: Xamarin.Google.Android.Material => 152
	i64 u0xa1b9d7c27f47219f, ; 487: Xamarin.AndroidX.Navigation.UI.dll => 146
	i64 u0xa2572680829d2c7c, ; 488: System.IO.Pipelines.dll => 184
	i64 u0xa308401900e5bed3, ; 489: lib_mscorlib.dll.so => 248
	i64 u0xa46aa1eaa214539b, ; 490: ko/Microsoft.Maui.Controls.resources => 16
	i64 u0xa473938c792db0b6, ; 491: Microsoft.AspNetCore.Routing.Abstractions => 61
	i64 u0xa4a372eecb9e4df0, ; 492: Microsoft.Extensions.Diagnostics => 81
	i64 u0xa4d20d2ff0563d26, ; 493: lib_CommunityToolkit.Mvvm.dll.so => 40
	i64 u0xa4edc8f2ceae241a, ; 494: System.Data.Common.dll => 171
	i64 u0xa526fadd66308051, ; 495: Microsoft.EntityFrameworkCore.SqlServer.dll => 73
	i64 u0xa5494f40f128ce6a, ; 496: System.Runtime.Serialization.Formatters.dll => 216
	i64 u0xa5b7152421ed6d98, ; 497: lib_System.IO.FileSystem.Watcher.dll.so => 183
	i64 u0xa5ce5c755bde8cb8, ; 498: lib_System.Security.Cryptography.Csp.dll.so => 225
	i64 u0xa5e599d1e0524750, ; 499: System.Numerics.Vectors.dll => 202
	i64 u0xa5f1ba49b85dd355, ; 500: System.Security.Cryptography.dll => 229
	i64 u0xa61975a5a37873ea, ; 501: lib_System.Xml.XmlSerializer.dll.so => 246
	i64 u0xa67dbee13e1df9ca, ; 502: Xamarin.AndroidX.SavedState.dll => 148
	i64 u0xa68a420042bb9b1f, ; 503: Xamarin.AndroidX.DrawerLayout.dll => 136
	i64 u0xa71fe7d6f6f93efd, ; 504: Microsoft.Data.SqlClient => 69
	i64 u0xa75cf331ee476318, ; 505: lib_Microsoft.AspNetCore.Http.Abstractions.dll.so => 52
	i64 u0xa763fbb98df8d9fb, ; 506: lib_Microsoft.Win32.Primitives.dll.so => 159
	i64 u0xa78ce3745383236a, ; 507: Xamarin.AndroidX.Lifecycle.Common.Jvm => 138
	i64 u0xa797ca094a0a7418, ; 508: lib_Microsoft.AspNetCore.SignalR.Core.dll.so => 65
	i64 u0xa7c31b56b4dc7b33, ; 509: hu/Microsoft.Maui.Controls.resources => 12
	i64 u0xa8e6320dd07580ef, ; 510: lib_Microsoft.IdentityModel.JsonWebTokens.dll.so => 94
	i64 u0xa964304b5631e28a, ; 511: CommunityToolkit.Maui.Core.dll => 39
	i64 u0xaa2219c8e3449ff5, ; 512: Microsoft.Extensions.Logging.Abstractions => 87
	i64 u0xaa443ac34067eeef, ; 513: System.Private.Xml.dll => 207
	i64 u0xaa52de307ef5d1dd, ; 514: System.Net.Http => 191
	i64 u0xaa9a7b0214a5cc5c, ; 515: System.Diagnostics.StackTrace.dll => 174
	i64 u0xaaaf86367285a918, ; 516: Microsoft.Extensions.DependencyInjection.Abstractions.dll => 79
	i64 u0xaaf84bb3f052a265, ; 517: el/Microsoft.Maui.Controls.resources => 5
	i64 u0xab9c1b2687d86b0b, ; 518: lib_System.Linq.Expressions.dll.so => 186
	i64 u0xabaabcb70f9474ff, ; 519: Microsoft.AspNetCore.Mvc.Abstractions => 57
	i64 u0xac03339b985f4d59, ; 520: Microsoft.AspNetCore.SignalR.Client.Core.dll => 63
	i64 u0xac2af3fa195a15ce, ; 521: System.Runtime.Numerics => 215
	i64 u0xac5376a2a538dc10, ; 522: Xamarin.AndroidX.Lifecycle.LiveData.Core.dll => 139
	i64 u0xac79c7e46047ad98, ; 523: System.Security.Principal.Windows.dll => 230
	i64 u0xac98d31068e24591, ; 524: System.Xml.XDocument => 245
	i64 u0xacd46e002c3ccb97, ; 525: ro/Microsoft.Maui.Controls.resources => 23
	i64 u0xacf42eea7ef9cd12, ; 526: System.Threading.Channels => 236
	i64 u0xad89c07347f1bad6, ; 527: nl/Microsoft.Maui.Controls.resources.dll => 19
	i64 u0xadbb53caf78a79d2, ; 528: System.Web.HttpUtility => 242
	i64 u0xadc90ab061a9e6e4, ; 529: System.ComponentModel.TypeConverter.dll => 168
	i64 u0xadf511667bef3595, ; 530: System.Net.Security => 196
	i64 u0xae282bcd03739de7, ; 531: Java.Interop => 251
	i64 u0xae53579c90db1107, ; 532: System.ObjectModel.dll => 203
	i64 u0xaf4829c0b3e740ae, ; 533: lib_Syncfusion.Maui.Toolkit.resources.dll.so => 118
	i64 u0xafe29f45095518e7, ; 534: lib_Xamarin.AndroidX.Lifecycle.ViewModelSavedState.dll.so => 141
	i64 u0xb05cc42cd94c6d9d, ; 535: lib-sv-Microsoft.Maui.Controls.resources.dll.so => 26
	i64 u0xb0bb43dc52ea59f9, ; 536: System.Diagnostics.Tracing.dll => 176
	i64 u0xb1dd05401aa8ee63, ; 537: System.Security.AccessControl => 221
	i64 u0xb220631954820169, ; 538: System.Text.RegularExpressions => 235
	i64 u0xb2376e1dbf8b4ed7, ; 539: System.Security.Cryptography.Csp => 225
	i64 u0xb2a3f67f3bf29fce, ; 540: da/Microsoft.Maui.Controls.resources => 3
	i64 u0xb343b35350be6ef3, ; 541: DocumentFormat.OpenXml.Framework => 42
	i64 u0xb398860d6ed7ba2f, ; 542: System.Security.Cryptography.ProtectedData => 125
	i64 u0xb3f0a0fcda8d3ebc, ; 543: Xamarin.AndroidX.CardView => 130
	i64 u0xb3f832258cb83db4, ; 544: Syncfusion.Licensing.dll => 113
	i64 u0xb46be1aa6d4fff93, ; 545: hi/Microsoft.Maui.Controls.resources => 10
	i64 u0xb477491be13109d8, ; 546: ar/Microsoft.Maui.Controls.resources => 0
	i64 u0xb4bd7015ecee9d86, ; 547: System.IO.Pipelines => 184
	i64 u0xb4c53d9749c5f226, ; 548: lib_System.IO.FileSystem.AccessControl.dll.so => 182
	i64 u0xb52aa297a3a175b1, ; 549: lib_Microsoft.AspNetCore.Authentication.Core.dll.so => 45
	i64 u0xb545f78b0415b9b9, ; 550: Microsoft.AspNetCore.WebUtilities.dll => 67
	i64 u0xb5c7fcdafbc67ee4, ; 551: Microsoft.Extensions.Logging.Abstractions.dll => 87
	i64 u0xb5e59badb43e7829, ; 552: Microsoft.AspNetCore.Routing.Abstractions.dll => 61
	i64 u0xb5ea31d5244c6626, ; 553: System.Threading.ThreadPool.dll => 239
	i64 u0xb7212c4683a94afe, ; 554: System.Drawing.Primitives => 177
	i64 u0xb7b7753d1f319409, ; 555: sv/Microsoft.Maui.Controls.resources => 26
	i64 u0xb81a2c6e0aee50fe, ; 556: lib_System.Private.CoreLib.dll.so => 250
	i64 u0xb872c26142d22aa9, ; 557: Microsoft.Extensions.Http.dll => 85
	i64 u0xb877daefc7c96291, ; 558: Mono.HttpUtility.dll => 106
	i64 u0xb9185c33a1643eed, ; 559: Microsoft.CSharp.dll => 158
	i64 u0xb9f64d3b230def68, ; 560: lib-pt-Microsoft.Maui.Controls.resources.dll.so => 22
	i64 u0xb9fc3c8a556e3691, ; 561: ja/Microsoft.Maui.Controls.resources => 15
	i64 u0xba4670aa94a2b3c6, ; 562: lib_System.Xml.XDocument.dll.so => 245
	i64 u0xba48785529705af9, ; 563: System.Collections.dll => 165
	i64 u0xbb639e0337b3d979, ; 564: Microsoft.AspNetCore.Http.dll => 51
	i64 u0xbb65706fde942ce3, ; 565: System.Net.Sockets => 197
	i64 u0xbb8c8d165ef11460, ; 566: lib_Microsoft.Identity.Client.Extensions.Msal.dll.so => 92
	i64 u0xbbd180354b67271a, ; 567: System.Runtime.Serialization.Formatters => 216
	i64 u0xbc22a245dab70cb4, ; 568: lib_SQLitePCLRaw.provider.e_sqlite3.dll.so => 112
	i64 u0xbcd36316d29f27b4, ; 569: lib_Microsoft.AspNetCore.Authorization.dll.so => 46
	i64 u0xbcfa7c134d2089f3, ; 570: System.Runtime.Caching => 124
	i64 u0xbd0e2c0d55246576, ; 571: System.Net.Http.dll => 191
	i64 u0xbd437a2cdb333d0d, ; 572: Xamarin.AndroidX.ViewPager2 => 151
	i64 u0xbd5d0b88d3d647a5, ; 573: lib_Xamarin.AndroidX.Browser.dll.so => 129
	i64 u0xbde4cd9bb9008cb3, ; 574: lib_Microsoft.AspNetCore.Authentication.Abstractions.dll.so => 44
	i64 u0xbe4450ecf4d84c63, ; 575: lib_Microsoft.AspNetCore.ResponseCaching.Abstractions.dll.so => 59
	i64 u0xbe65a49036345cf4, ; 576: lib_System.Buffers.dll.so => 160
	i64 u0xbee38d4a88835966, ; 577: Xamarin.AndroidX.AppCompat.AppCompatResources => 128
	i64 u0xbfc1e1fb3095f2b3, ; 578: lib_System.Net.Http.Json.dll.so => 190
	i64 u0xc040a4ab55817f58, ; 579: ar/Microsoft.Maui.Controls.resources.dll => 0
	i64 u0xc0d928351ab5ca77, ; 580: System.Console.dll => 170
	i64 u0xc12b8b3afa48329c, ; 581: lib_System.Linq.dll.so => 188
	i64 u0xc1347413e524ff69, ; 582: lib_Syncfusion.Maui.Toolkit.dll.so => 117
	i64 u0xc1c2cb7af77b8858, ; 583: Microsoft.EntityFrameworkCore => 70
	i64 u0xc1ebdc7e6a943450, ; 584: Microsoft.AspNetCore.Authorization.dll => 46
	i64 u0xc1ff9ae3cdb6e1e6, ; 585: Xamarin.AndroidX.Activity.dll => 126
	i64 u0xc26c064effb1dea9, ; 586: System.Buffers.dll => 160
	i64 u0xc278de356ad8a9e3, ; 587: Microsoft.IdentityModel.Logging => 95
	i64 u0xc28c50f32f81cc73, ; 588: ja/Microsoft.Maui.Controls.resources.dll => 15
	i64 u0xc2a3bca55b573141, ; 589: System.IO.FileSystem.Watcher => 183
	i64 u0xc2bcfec99f69365e, ; 590: Xamarin.AndroidX.ViewPager2.dll => 151
	i64 u0xc30b52815b58ac2c, ; 591: lib_System.Runtime.Serialization.Xml.dll.so => 219
	i64 u0xc3492f8f90f96ce4, ; 592: lib_Microsoft.Extensions.DependencyModel.dll.so => 80
	i64 u0xc374571bc2b0b5f8, ; 593: lib_Microsoft.AspNetCore.Routing.dll.so => 60
	i64 u0xc39ced8467203460, ; 594: lib_Refit.HttpClientFactory.dll.so => 108
	i64 u0xc421b61fd853169d, ; 595: lib_System.Net.WebSockets.Client.dll.so => 200
	i64 u0xc463e077917aa21d, ; 596: System.Runtime.Serialization.Json => 217
	i64 u0xc472ce300460ccb6, ; 597: Microsoft.EntityFrameworkCore.dll => 70
	i64 u0xc4d3858ed4d08512, ; 598: Xamarin.AndroidX.Lifecycle.ViewModelSavedState.dll => 141
	i64 u0xc4d69851fe06342f, ; 599: lib_Microsoft.Extensions.Caching.Memory.dll.so => 75
	i64 u0xc4f2d57c50beb816, ; 600: lib_Microsoft.Extensions.Features.dll.so => 83
	i64 u0xc50fded0ded1418c, ; 601: lib_System.ComponentModel.TypeConverter.dll.so => 168
	i64 u0xc519125d6bc8fb11, ; 602: lib_System.Net.Requests.dll.so => 195
	i64 u0xc5293b19e4dc230e, ; 603: Xamarin.AndroidX.Navigation.Fragment => 144
	i64 u0xc5325b2fcb37446f, ; 604: lib_System.Private.Xml.dll.so => 207
	i64 u0xc5a0f4b95a699af7, ; 605: lib_System.Private.Uri.dll.so => 205
	i64 u0xc5cdcd5b6277579e, ; 606: lib_System.Security.Cryptography.Algorithms.dll.so => 223
	i64 u0xc5de3dcae13c325f, ; 607: Microsoft.AspNetCore.SignalR.Client => 62
	i64 u0xc7c01e7d7c93a110, ; 608: System.Text.Encoding.Extensions.dll => 232
	i64 u0xc7ce851898a4548e, ; 609: lib_System.Web.HttpUtility.dll.so => 242
	i64 u0xc858a28d9ee5a6c5, ; 610: lib_System.Collections.Specialized.dll.so => 164
	i64 u0xc9e54b32fc19baf3, ; 611: lib_CommunityToolkit.Maui.dll.so => 38
	i64 u0xca32340d8d54dcd5, ; 612: Microsoft.Extensions.Caching.Memory.dll => 75
	i64 u0xca3a723e7342c5b6, ; 613: lib-tr-Microsoft.Maui.Controls.resources.dll.so => 28
	i64 u0xcab3493c70141c2d, ; 614: pl/Microsoft.Maui.Controls.resources => 20
	i64 u0xcacfddc9f7c6de76, ; 615: ro/Microsoft.Maui.Controls.resources.dll => 23
	i64 u0xcb45618372c47127, ; 616: Microsoft.EntityFrameworkCore.Relational => 72
	i64 u0xcbd4fdd9cef4a294, ; 617: lib__Microsoft.Android.Resource.Designer.dll.so => 35
	i64 u0xcc182c3afdc374d6, ; 618: Microsoft.Bcl.AsyncInterfaces => 68
	i64 u0xcc2876b32ef2794c, ; 619: lib_System.Text.RegularExpressions.dll.so => 235
	i64 u0xcc579b7a6e965d12, ; 620: DocumentFormat.OpenXml.VariableReplacer.Core => 43
	i64 u0xcc5c3bb714c4561e, ; 621: Xamarin.KotlinX.Coroutines.Core.Jvm.dll => 154
	i64 u0xcc76886e09b88260, ; 622: Xamarin.KotlinX.Serialization.Core.Jvm.dll => 155
	i64 u0xcce5f0b382db16b7, ; 623: Microsoft.AspNetCore.Http.Connections.Client => 53
	i64 u0xccf25c4b634ccd3a, ; 624: zh-Hans/Microsoft.Maui.Controls.resources.dll => 32
	i64 u0xcd10a42808629144, ; 625: System.Net.Requests => 195
	i64 u0xcd3586b93136841e, ; 626: lib_System.Runtime.Caching.dll.so => 124
	i64 u0xcdd0c48b6937b21c, ; 627: Xamarin.AndroidX.SwipeRefreshLayout => 149
	i64 u0xceb28d385f84f441, ; 628: Azure.Core.dll => 36
	i64 u0xcf140ed700bc8e66, ; 629: Microsoft.SqlServer.Server.dll => 105
	i64 u0xcf23d8093f3ceadf, ; 630: System.Diagnostics.DiagnosticSource.dll => 172
	i64 u0xcf8fc898f98b0d34, ; 631: System.Private.Xml.Linq => 206
	i64 u0xd030f32762b3d78f, ; 632: Microsoft.AspNetCore.SignalR.Core => 65
	i64 u0xd063299fcfc0c93f, ; 633: lib_System.Runtime.Serialization.Json.dll.so => 217
	i64 u0xd1194e1d8a8de83c, ; 634: lib_Xamarin.AndroidX.Lifecycle.Common.Jvm.dll.so => 138
	i64 u0xd16fd7fb9bbcd43e, ; 635: Microsoft.Extensions.Diagnostics.Abstractions => 82
	i64 u0xd22a0c4630f2fe66, ; 636: lib_System.Security.Cryptography.ProtectedData.dll.so => 125
	i64 u0xd333d0af9e423810, ; 637: System.Runtime.InteropServices => 213
	i64 u0xd33a415cb4278969, ; 638: System.Security.Cryptography.Encoding.dll => 226
	i64 u0xd3426d966bb704f5, ; 639: Xamarin.AndroidX.AppCompat.AppCompatResources.dll => 128
	i64 u0xd3651b6fc3125825, ; 640: System.Private.Uri.dll => 205
	i64 u0xd373685349b1fe8b, ; 641: Microsoft.Extensions.Logging.dll => 86
	i64 u0xd3801faafafb7698, ; 642: System.Private.DataContractSerialization.dll => 204
	i64 u0xd3e4c8d6a2d5d470, ; 643: it/Microsoft.Maui.Controls.resources => 14
	i64 u0xd3edcc1f25459a50, ; 644: System.Reflection.Emit => 210
	i64 u0xd42655883bb8c19f, ; 645: Microsoft.EntityFrameworkCore.Abstractions.dll => 71
	i64 u0xd4645626dffec99d, ; 646: lib_Microsoft.Extensions.DependencyInjection.Abstractions.dll.so => 79
	i64 u0xd52f53c4b3d62e11, ; 647: Microsoft.AspNetCore.Connections.Abstractions.dll => 48
	i64 u0xd5507e11a2b2839f, ; 648: Xamarin.AndroidX.Lifecycle.ViewModelSavedState => 141
	i64 u0xd6694f8359737e4e, ; 649: Xamarin.AndroidX.SavedState => 148
	i64 u0xd6d21782156bc35b, ; 650: Xamarin.AndroidX.SwipeRefreshLayout.dll => 149
	i64 u0xd72329819cbbbc44, ; 651: lib_Microsoft.Extensions.Configuration.Abstractions.dll.so => 77
	i64 u0xd72c760af136e863, ; 652: System.Xml.XmlSerializer.dll => 246
	i64 u0xd7b3764ada9d341d, ; 653: lib_Microsoft.Extensions.Logging.Abstractions.dll.so => 87
	i64 u0xda1dfa4c534a9251, ; 654: Microsoft.Extensions.DependencyInjection => 78
	i64 u0xdad05a11827959a3, ; 655: System.Collections.NonGeneric.dll => 163
	i64 u0xdb5383ab5865c007, ; 656: lib-vi-Microsoft.Maui.Controls.resources.dll.so => 30
	i64 u0xdb58816721c02a59, ; 657: lib_System.Reflection.Emit.ILGeneration.dll.so => 208
	i64 u0xdbeda89f832aa805, ; 658: vi/Microsoft.Maui.Controls.resources.dll => 30
	i64 u0xdbf2a779fbc3ac31, ; 659: System.Transactions.Local.dll => 241
	i64 u0xdbf9607a441b4505, ; 660: System.Linq => 188
	i64 u0xdc75032002d1a212, ; 661: lib_System.Transactions.Local.dll.so => 241
	i64 u0xdca8be7403f92d4f, ; 662: lib_System.Linq.Queryable.dll.so => 187
	i64 u0xdce2c53525640bf3, ; 663: Microsoft.Extensions.Logging => 86
	i64 u0xdd2b722d78ef5f43, ; 664: System.Runtime.dll => 220
	i64 u0xdd67031857c72f96, ; 665: lib_System.Text.Encodings.Web.dll.so => 233
	i64 u0xdde30e6b77aa6f6c, ; 666: lib-zh-Hans-Microsoft.Maui.Controls.resources.dll.so => 32
	i64 u0xde110ae80fa7c2e2, ; 667: System.Xml.XDocument.dll => 245
	i64 u0xde572c2b2fb32f93, ; 668: lib_System.Threading.Tasks.Extensions.dll.so => 237
	i64 u0xde8769ebda7d8647, ; 669: hr/Microsoft.Maui.Controls.resources.dll => 11
	i64 u0xdf9c7682560a9629, ; 670: System.Net.ServerSentEvents => 123
	i64 u0xdfa4850418b6c99a, ; 671: Microsoft.AspNetCore.Hosting.Abstractions => 49
	i64 u0xe0142572c095a480, ; 672: Xamarin.AndroidX.AppCompat.dll => 127
	i64 u0xe020c74e3723dc6f, ; 673: Syncfusion.Maui.Toolkit.dll => 117
	i64 u0xe02f89350ec78051, ; 674: Xamarin.AndroidX.CoordinatorLayout.dll => 132
	i64 u0xe02ff568f8e5f275, ; 675: Microsoft.AspNetCore.Http.Connections.Client.dll => 53
	i64 u0xe10b760bb1462e7a, ; 676: lib_System.Security.Cryptography.Primitives.dll.so => 227
	i64 u0xe192a588d4410686, ; 677: lib_System.IO.Pipelines.dll.so => 184
	i64 u0xe1a08bd3fa539e0d, ; 678: System.Runtime.Loader => 214
	i64 u0xe1b52f9f816c70ef, ; 679: System.Private.Xml.Linq.dll => 206
	i64 u0xe1ecfdb7fff86067, ; 680: System.Net.Security.dll => 196
	i64 u0xe2420585aeceb728, ; 681: System.Net.Requests.dll => 195
	i64 u0xe29b73bc11392966, ; 682: lib-id-Microsoft.Maui.Controls.resources.dll.so => 13
	i64 u0xe2e426c7714fa0bc, ; 683: Microsoft.Win32.Primitives.dll => 159
	i64 u0xe2ee754535ca6dd6, ; 684: SocialMauiApp => 157
	i64 u0xe3811d68d4fe8463, ; 685: pt-BR/Microsoft.Maui.Controls.resources.dll => 21
	i64 u0xe38e8ac420aab422, ; 686: Microsoft.AspNetCore.Mvc.Core => 58
	i64 u0xe3b7cbae5ad66c75, ; 687: lib_System.Security.Cryptography.Encoding.dll.so => 226
	i64 u0xe494f7ced4ecd10a, ; 688: hu/Microsoft.Maui.Controls.resources.dll => 12
	i64 u0xe4a9b1e40d1e8917, ; 689: lib-fi-Microsoft.Maui.Controls.resources.dll.so => 7
	i64 u0xe4f74a0b5bf9703f, ; 690: System.Runtime.Serialization.Primitives => 218
	i64 u0xe5434e8a119ceb69, ; 691: lib_Mono.Android.dll.so => 253
	i64 u0xe57d22ca4aeb4900, ; 692: System.Configuration.ConfigurationManager => 120
	i64 u0xe79d45aa815dab7f, ; 693: System.Runtime.Caching.dll => 124
	i64 u0xe7e03cc18dcdeb49, ; 694: lib_System.Diagnostics.StackTrace.dll.so => 174
	i64 u0xe7e7d98eda944101, ; 695: Syncfusion.Maui.Sliders => 116
	i64 u0xe896622fe0902957, ; 696: System.Reflection.Emit.dll => 210
	i64 u0xe89a2a9ef110899b, ; 697: System.Drawing.dll => 178
	i64 u0xea008206567504c4, ; 698: Syncfusion.Maui.Toolkit => 117
	i64 u0xebdfa33cea4bfcea, ; 699: SocialMediaMaui.Shared.dll => 156
	i64 u0xec14f495db71c005, ; 700: en-US/Syncfusion.Maui.ImageEditor.resources.dll => 34
	i64 u0xec8abb68d340aac6, ; 701: Microsoft.AspNetCore.Authorization => 46
	i64 u0xedc4817167106c23, ; 702: System.Net.Sockets.dll => 197
	i64 u0xedc632067fb20ff3, ; 703: System.Memory.dll => 189
	i64 u0xedc8e4ca71a02a8b, ; 704: Xamarin.AndroidX.Navigation.Runtime.dll => 145
	i64 u0xee81f5b3f1c4f83b, ; 705: System.Threading.ThreadPool => 239
	i64 u0xeeb7ebb80150501b, ; 706: lib_Xamarin.AndroidX.Collection.Jvm.dll.so => 131
	i64 u0xeefc635595ef57f0, ; 707: System.Security.Cryptography.Cng => 224
	i64 u0xef03b1b5a04e9709, ; 708: System.Text.Encoding.CodePages.dll => 231
	i64 u0xef72742e1bcca27a, ; 709: Microsoft.Maui.Essentials.dll => 102
	i64 u0xefec0b7fdc57ec42, ; 710: Xamarin.AndroidX.Activity => 126
	i64 u0xf00c29406ea45e19, ; 711: es/Microsoft.Maui.Controls.resources.dll => 6
	i64 u0xf020834425394c93, ; 712: Microsoft.AspNetCore.ResponseCaching.Abstractions.dll => 59
	i64 u0xf038bf84c0c27e83, ; 713: lib_Microsoft.AspNetCore.SignalR.Client.dll.so => 62
	i64 u0xf09e47b6ae914f6e, ; 714: System.Net.NameResolution => 192
	i64 u0xf0de2537ee19c6ca, ; 715: lib_System.Net.WebHeaderCollection.dll.so => 199
	i64 u0xf11b621fc87b983f, ; 716: Microsoft.Maui.Controls.Xaml.dll => 100
	i64 u0xf1c4b4005493d871, ; 717: System.Formats.Asn1.dll => 179
	i64 u0xf238bd79489d3a96, ; 718: lib-nl-Microsoft.Maui.Controls.resources.dll.so => 19
	i64 u0xf37221fda4ef8830, ; 719: lib_Xamarin.Google.Android.Material.dll.so => 152
	i64 u0xf3ddfe05336abf29, ; 720: System => 247
	i64 u0xf408654b2a135055, ; 721: System.Reflection.Emit.ILGeneration.dll => 208
	i64 u0xf4103170a1de5bd0, ; 722: System.Linq.Queryable.dll => 187
	i64 u0xf42ad2f4323b64d3, ; 723: Microsoft.Net.Http.Headers.dll => 104
	i64 u0xf4c1dd70a5496a17, ; 724: System.IO.Compression => 181
	i64 u0xf5e59d7ac34b50aa, ; 725: Microsoft.IdentityModel.Protocols.dll => 96
	i64 u0xf5fc7602fe27b333, ; 726: System.Net.WebHeaderCollection => 199
	i64 u0xf6077741019d7428, ; 727: Xamarin.AndroidX.CoordinatorLayout => 132
	i64 u0xf61ade9836ad4692, ; 728: Microsoft.IdentityModel.Tokens.dll => 98
	i64 u0xf64aa85b130b0651, ; 729: lib_DocumentFormat.OpenXml.Framework.dll.so => 42
	i64 u0xf6c0e7d55a7a4e4f, ; 730: Microsoft.IdentityModel.JsonWebTokens => 94
	i64 u0xf77b20923f07c667, ; 731: de/Microsoft.Maui.Controls.resources.dll => 4
	i64 u0xf7e2cac4c45067b3, ; 732: lib_System.Numerics.Vectors.dll.so => 202
	i64 u0xf7e74930e0e3d214, ; 733: zh-HK/Microsoft.Maui.Controls.resources.dll => 31
	i64 u0xf84773b5c81e3cef, ; 734: lib-uk-Microsoft.Maui.Controls.resources.dll.so => 29
	i64 u0xf8aac5ea82de1348, ; 735: System.Linq.Queryable => 187
	i64 u0xf8b77539b362d3ba, ; 736: lib_System.Reflection.Primitives.dll.so => 211
	i64 u0xf8e045dc345b2ea3, ; 737: lib_Xamarin.AndroidX.RecyclerView.dll.so => 147
	i64 u0xf915dc29808193a1, ; 738: System.Web.HttpUtility.dll => 242
	i64 u0xf96c777a2a0686f4, ; 739: hi/Microsoft.Maui.Controls.resources.dll => 10
	i64 u0xf9be54c8bcf8ff3b, ; 740: System.Security.AccessControl.dll => 221
	i64 u0xf9eec5bb3a6aedc6, ; 741: Microsoft.Extensions.Options => 89
	i64 u0xfa3f278f288b0e84, ; 742: lib_System.Net.Security.dll.so => 196
	i64 u0xfa504dfa0f097d72, ; 743: Microsoft.Extensions.FileProviders.Abstractions.dll => 84
	i64 u0xfa5ed7226d978949, ; 744: lib-ar-Microsoft.Maui.Controls.resources.dll.so => 0
	i64 u0xfa645d91e9fc4cba, ; 745: System.Threading.Thread => 238
	i64 u0xfb022853d73b7fa5, ; 746: lib_SQLitePCLRaw.batteries_v2.dll.so => 109
	i64 u0xfbad3e4ce4b98145, ; 747: System.Security.Cryptography.X509Certificates => 228
	i64 u0xfbd71978549ea473, ; 748: Microsoft.AspNetCore.Http.Features.dll => 56
	i64 u0xfbf0a31c9fc34bc4, ; 749: lib_System.Net.Http.dll.so => 191
	i64 u0xfc6b7527cc280b3f, ; 750: lib_System.Runtime.Serialization.Formatters.dll.so => 216
	i64 u0xfc719aec26adf9d9, ; 751: Xamarin.AndroidX.Navigation.Fragment.dll => 144
	i64 u0xfd22f00870e40ae0, ; 752: lib_Xamarin.AndroidX.DrawerLayout.dll.so => 136
	i64 u0xfd49b3c1a76e2748, ; 753: System.Runtime.InteropServices.RuntimeInformation => 212
	i64 u0xfd536c702f64dc47, ; 754: System.Text.Encoding.Extensions => 232
	i64 u0xfd583f7657b6a1cb, ; 755: Xamarin.AndroidX.Fragment => 137
	i64 u0xfda36abccf05cf5c, ; 756: System.Net.WebSockets.Client => 200
	i64 u0xfdbe4710aa9beeff, ; 757: CommunityToolkit.Maui => 38
	i64 u0xfeae9952cf03b8cb, ; 758: tr/Microsoft.Maui.Controls.resources => 28
	i64 u0xff1a4e86e72b0140, ; 759: Microsoft.AspNetCore.Authentication.Abstractions.dll => 44
	i64 u0xff9b54613e0d2cc8, ; 760: System.Net.Http.Json => 190
	i64 u0xfff40914e0b38d3d ; 761: Azure.Identity.dll => 37
], align 8

@assembly_image_cache_indices = dso_local local_unnamed_addr constant [762 x i32] [
	i32 149, i32 107, i32 166, i32 47, i32 64, i32 145, i32 39, i32 75,
	i32 252, i32 127, i32 160, i32 112, i32 204, i32 24, i32 2, i32 30,
	i32 93, i32 194, i32 147, i32 165, i32 101, i32 50, i32 31, i32 243,
	i32 131, i32 248, i32 24, i32 163, i32 36, i32 211, i32 136, i32 166,
	i32 89, i32 163, i32 122, i32 229, i32 74, i32 236, i32 69, i32 25,
	i32 155, i32 66, i32 150, i32 21, i32 253, i32 102, i32 68, i32 192,
	i32 49, i32 157, i32 68, i32 135, i32 114, i32 180, i32 42, i32 88,
	i32 227, i32 201, i32 209, i32 34, i32 147, i32 97, i32 129, i32 8,
	i32 251, i32 9, i32 97, i32 79, i32 201, i32 63, i32 159, i32 80,
	i32 114, i32 185, i32 223, i32 249, i32 221, i32 12, i32 233, i32 155,
	i32 198, i32 18, i32 108, i32 222, i32 50, i32 37, i32 161, i32 247,
	i32 27, i32 55, i32 81, i32 252, i32 182, i32 174, i32 146, i32 16,
	i32 89, i32 246, i32 58, i32 198, i32 106, i32 180, i32 173, i32 220,
	i32 119, i32 208, i32 27, i32 185, i32 41, i32 238, i32 70, i32 170,
	i32 133, i32 218, i32 8, i32 109, i32 153, i32 90, i32 121, i32 13,
	i32 11, i32 201, i32 251, i32 194, i32 107, i32 67, i32 82, i32 34,
	i32 29, i32 193, i32 175, i32 7, i32 235, i32 121, i32 179, i32 33,
	i32 67, i32 20, i32 231, i32 209, i32 206, i32 113, i32 240, i32 26,
	i32 234, i32 5, i32 83, i32 173, i32 244, i32 105, i32 176, i32 74,
	i32 85, i32 137, i32 93, i32 35, i32 65, i32 130, i32 177, i32 8,
	i32 244, i32 162, i32 6, i32 197, i32 105, i32 101, i32 2, i32 99,
	i32 166, i32 151, i32 76, i32 115, i32 209, i32 211, i32 162, i32 135,
	i32 192, i32 96, i32 47, i32 120, i32 150, i32 1, i32 84, i32 227,
	i32 232, i32 98, i32 228, i32 69, i32 153, i32 55, i32 129, i32 239,
	i32 243, i32 133, i32 109, i32 51, i32 92, i32 237, i32 143, i32 37,
	i32 120, i32 248, i32 128, i32 210, i32 249, i32 253, i32 20, i32 43,
	i32 158, i32 218, i32 106, i32 153, i32 45, i32 71, i32 121, i32 175,
	i32 80, i32 24, i32 243, i32 122, i32 22, i32 66, i32 41, i32 203,
	i32 104, i32 146, i32 114, i32 182, i32 59, i32 234, i32 119, i32 57,
	i32 190, i32 72, i32 142, i32 193, i32 200, i32 186, i32 207, i32 119,
	i32 214, i32 14, i32 142, i32 252, i32 64, i32 231, i32 236, i32 1,
	i32 111, i32 58, i32 98, i32 99, i32 40, i32 140, i32 178, i32 44,
	i32 194, i32 52, i32 171, i32 133, i32 103, i32 25, i32 224, i32 193,
	i32 212, i32 31, i32 222, i32 220, i32 138, i32 164, i32 219, i32 205,
	i32 110, i32 250, i32 172, i32 15, i32 78, i32 104, i32 158, i32 50,
	i32 122, i32 132, i32 240, i32 169, i32 54, i32 204, i32 3, i32 57,
	i32 53, i32 86, i32 60, i32 199, i32 213, i32 131, i32 164, i32 233,
	i32 167, i32 43, i32 225, i32 244, i32 171, i32 111, i32 5, i32 88,
	i32 78, i32 154, i32 189, i32 100, i32 4, i32 214, i32 250, i32 162,
	i32 152, i32 223, i32 123, i32 38, i32 107, i32 99, i32 215, i32 170,
	i32 140, i32 134, i32 54, i32 3, i32 177, i32 179, i32 9, i32 111,
	i32 213, i32 18, i32 73, i32 125, i32 103, i32 90, i32 134, i32 90,
	i32 144, i32 101, i32 2, i32 183, i32 28, i32 18, i32 82, i32 14,
	i32 167, i32 64, i32 226, i32 11, i32 157, i32 41, i32 189, i32 81,
	i32 76, i32 48, i32 148, i32 215, i32 123, i32 224, i32 17, i32 27,
	i32 54, i32 137, i32 156, i32 85, i32 7, i32 94, i32 168, i32 25,
	i32 4, i32 198, i32 39, i32 62, i32 17, i32 202, i32 165, i32 176,
	i32 222, i32 203, i32 169, i32 56, i32 150, i32 77, i32 91, i32 139,
	i32 47, i32 112, i32 247, i32 33, i32 88, i32 127, i32 130, i32 178,
	i32 29, i32 93, i32 32, i32 83, i32 185, i32 217, i32 72, i32 51,
	i32 115, i32 33, i32 76, i32 219, i32 116, i32 71, i32 238, i32 52,
	i32 180, i32 102, i32 154, i32 115, i32 249, i32 167, i32 212, i32 55,
	i32 56, i32 74, i32 113, i32 142, i32 66, i32 172, i32 230, i32 173,
	i32 9, i32 45, i32 36, i32 84, i32 230, i32 73, i32 134, i32 156,
	i32 240, i32 161, i32 49, i32 118, i32 91, i32 143, i32 10, i32 23,
	i32 110, i32 22, i32 21, i32 60, i32 110, i32 175, i32 61, i32 35,
	i32 181, i32 237, i32 140, i32 100, i32 63, i32 135, i32 234, i32 188,
	i32 1, i32 118, i32 17, i32 181, i32 95, i32 97, i32 95, i32 108,
	i32 6, i32 92, i32 13, i32 103, i32 169, i32 161, i32 186, i32 40,
	i32 145, i32 16, i32 96, i32 241, i32 228, i32 126, i32 77, i32 19,
	i32 143, i32 139, i32 116, i32 91, i32 48, i32 229, i32 152, i32 146,
	i32 184, i32 248, i32 16, i32 61, i32 81, i32 40, i32 171, i32 73,
	i32 216, i32 183, i32 225, i32 202, i32 229, i32 246, i32 148, i32 136,
	i32 69, i32 52, i32 159, i32 138, i32 65, i32 12, i32 94, i32 39,
	i32 87, i32 207, i32 191, i32 174, i32 79, i32 5, i32 186, i32 57,
	i32 63, i32 215, i32 139, i32 230, i32 245, i32 23, i32 236, i32 19,
	i32 242, i32 168, i32 196, i32 251, i32 203, i32 118, i32 141, i32 26,
	i32 176, i32 221, i32 235, i32 225, i32 3, i32 42, i32 125, i32 130,
	i32 113, i32 10, i32 0, i32 184, i32 182, i32 45, i32 67, i32 87,
	i32 61, i32 239, i32 177, i32 26, i32 250, i32 85, i32 106, i32 158,
	i32 22, i32 15, i32 245, i32 165, i32 51, i32 197, i32 92, i32 216,
	i32 112, i32 46, i32 124, i32 191, i32 151, i32 129, i32 44, i32 59,
	i32 160, i32 128, i32 190, i32 0, i32 170, i32 188, i32 117, i32 70,
	i32 46, i32 126, i32 160, i32 95, i32 15, i32 183, i32 151, i32 219,
	i32 80, i32 60, i32 108, i32 200, i32 217, i32 70, i32 141, i32 75,
	i32 83, i32 168, i32 195, i32 144, i32 207, i32 205, i32 223, i32 62,
	i32 232, i32 242, i32 164, i32 38, i32 75, i32 28, i32 20, i32 23,
	i32 72, i32 35, i32 68, i32 235, i32 43, i32 154, i32 155, i32 53,
	i32 32, i32 195, i32 124, i32 149, i32 36, i32 105, i32 172, i32 206,
	i32 65, i32 217, i32 138, i32 82, i32 125, i32 213, i32 226, i32 128,
	i32 205, i32 86, i32 204, i32 14, i32 210, i32 71, i32 79, i32 48,
	i32 141, i32 148, i32 149, i32 77, i32 246, i32 87, i32 78, i32 163,
	i32 30, i32 208, i32 30, i32 241, i32 188, i32 241, i32 187, i32 86,
	i32 220, i32 233, i32 32, i32 245, i32 237, i32 11, i32 123, i32 49,
	i32 127, i32 117, i32 132, i32 53, i32 227, i32 184, i32 214, i32 206,
	i32 196, i32 195, i32 13, i32 159, i32 157, i32 21, i32 58, i32 226,
	i32 12, i32 7, i32 218, i32 253, i32 120, i32 124, i32 174, i32 116,
	i32 210, i32 178, i32 117, i32 156, i32 34, i32 46, i32 197, i32 189,
	i32 145, i32 239, i32 131, i32 224, i32 231, i32 102, i32 126, i32 6,
	i32 59, i32 62, i32 192, i32 199, i32 100, i32 179, i32 19, i32 152,
	i32 247, i32 208, i32 187, i32 104, i32 181, i32 96, i32 199, i32 132,
	i32 98, i32 42, i32 94, i32 4, i32 202, i32 31, i32 29, i32 187,
	i32 211, i32 147, i32 242, i32 10, i32 221, i32 89, i32 196, i32 84,
	i32 0, i32 238, i32 109, i32 228, i32 56, i32 191, i32 216, i32 144,
	i32 136, i32 212, i32 232, i32 137, i32 200, i32 38, i32 28, i32 44,
	i32 190, i32 37
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
