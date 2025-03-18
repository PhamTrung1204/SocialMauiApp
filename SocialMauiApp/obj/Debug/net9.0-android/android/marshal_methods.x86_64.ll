; ModuleID = 'marshal_methods.x86_64.ll'
source_filename = "marshal_methods.x86_64.ll"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-android21"

%struct.MarshalMethodName = type {
	i64, ; uint64_t id
	ptr ; char* name
}

%struct.MarshalMethodsManagedClass = type {
	i32, ; uint32_t token
	ptr ; MonoClass klass
}

@assembly_image_cache = dso_local local_unnamed_addr global [406 x ptr] zeroinitializer, align 16

; Each entry maps hash of an assembly name to an index into the `assembly_image_cache` array
@assembly_image_cache_hashes = dso_local local_unnamed_addr constant [1218 x i64] [
	i64 u0x001e58127c546039, ; 0: lib_System.Globalization.dll.so => 42
	i64 u0x0024d0f62dee05bd, ; 1: Xamarin.KotlinX.Coroutines.Core.dll => 362
	i64 u0x0071cf2d27b7d61e, ; 2: lib_Xamarin.AndroidX.SwipeRefreshLayout.dll.so => 342
	i64 u0x00b3aadb3a4c4038, ; 3: lib_Refit.dll.so => 252
	i64 u0x01109b0e4d99e61f, ; 4: System.ComponentModel.Annotations.dll => 13
	i64 u0x014b43fdeb5d21ad, ; 5: Microsoft.AspNetCore.Authorization.Policy.dll => 186
	i64 u0x018d2cc5e2de2b95, ; 6: lib_Microsoft.AspNetCore.SignalR.Common.dll.so => 203
	i64 u0x02123411c4e01926, ; 7: lib_Xamarin.AndroidX.Navigation.Runtime.dll.so => 331
	i64 u0x022e81ea9c46e03a, ; 8: lib_CommunityToolkit.Maui.Core.dll.so => 177
	i64 u0x022f31be406de945, ; 9: Microsoft.Extensions.Options.ConfigurationExtensions => 233
	i64 u0x0284512fad379f7e, ; 10: System.Runtime.Handles => 105
	i64 u0x02a4c5a44384f885, ; 11: Microsoft.Extensions.Caching.Memory => 215
	i64 u0x02abedc11addc1ed, ; 12: lib_Mono.Android.Runtime.dll.so => 171
	i64 u0x02f55bf70672f5c8, ; 13: lib_System.IO.FileSystem.DriveInfo.dll.so => 48
	i64 u0x032267b2a94db371, ; 14: lib_Xamarin.AndroidX.AppCompat.dll.so => 285
	i64 u0x03621c804933a890, ; 15: System.Buffers => 7
	i64 u0x0363ac97a4cb84e6, ; 16: SQLitePCLRaw.provider.e_sqlite3.dll => 258
	i64 u0x0399610510a38a38, ; 17: lib_System.Private.DataContractSerialization.dll.so => 86
	i64 u0x043032f1d071fae0, ; 18: ru/Microsoft.Maui.Controls.resources => 390
	i64 u0x044440a55165631e, ; 19: lib-cs-Microsoft.Maui.Controls.resources.dll.so => 368
	i64 u0x046eb1581a80c6b0, ; 20: vi/Microsoft.Maui.Controls.resources => 396
	i64 u0x0470607fd33c32db, ; 21: Microsoft.IdentityModel.Abstractions.dll => 237
	i64 u0x047408741db2431a, ; 22: Xamarin.AndroidX.DynamicAnimation => 305
	i64 u0x0517ef04e06e9f76, ; 23: System.Net.Primitives => 71
	i64 u0x0565d18c6da3de38, ; 24: Xamarin.AndroidX.RecyclerView => 335
	i64 u0x057bf9fa9fb09f7c, ; 25: Microsoft.Data.Sqlite.dll => 209
	i64 u0x0581db89237110e9, ; 26: lib_System.Collections.dll.so => 12
	i64 u0x05989cb940b225a9, ; 27: Microsoft.Maui.dll => 245
	i64 u0x05a1c25e78e22d87, ; 28: lib_System.Runtime.CompilerServices.Unsafe.dll.so => 102
	i64 u0x05c27cf2b380bbf2, ; 29: lib_Microsoft.AspNetCore.Hosting.Server.Abstractions.dll.so => 189
	i64 u0x05ef98b6a1db882c, ; 30: lib_Microsoft.Data.Sqlite.dll.so => 209
	i64 u0x06076b5d2b581f08, ; 31: zh-HK/Microsoft.Maui.Controls.resources => 397
	i64 u0x06388ffe9f6c161a, ; 32: System.Xml.Linq.dll => 156
	i64 u0x06600c4c124cb358, ; 33: System.Configuration.dll => 19
	i64 u0x067f95c5ddab55b3, ; 34: lib_Xamarin.AndroidX.Fragment.Ktx.dll.so => 310
	i64 u0x0680a433c781bb3d, ; 35: Xamarin.AndroidX.Collection.Jvm => 292
	i64 u0x069fff96ec92a91d, ; 36: System.Xml.XPath.dll => 161
	i64 u0x070b0847e18dab68, ; 37: Xamarin.AndroidX.Emoji2.ViewsHelper.dll => 307
	i64 u0x0739448d84d3b016, ; 38: lib_Xamarin.AndroidX.VectorDrawable.dll.so => 345
	i64 u0x07469f2eecce9e85, ; 39: mscorlib.dll => 167
	i64 u0x07c57877c7ba78ad, ; 40: ru/Microsoft.Maui.Controls.resources.dll => 390
	i64 u0x07dcdc7460a0c5e4, ; 41: System.Collections.NonGeneric => 10
	i64 u0x08122e52765333c8, ; 42: lib_Microsoft.Extensions.Logging.Debug.dll.so => 230
	i64 u0x088610fc2509f69e, ; 43: lib_Xamarin.AndroidX.VectorDrawable.Animated.dll.so => 346
	i64 u0x08881a0a9768df86, ; 44: lib_Azure.Core.dll.so => 174
	i64 u0x08a7c865576bbde7, ; 45: System.Reflection.Primitives => 96
	i64 u0x08c9d051a4a817e5, ; 46: Xamarin.AndroidX.CustomView.PoolingContainer.dll => 302
	i64 u0x08f3c9788ee2153c, ; 47: Xamarin.AndroidX.DrawerLayout => 304
	i64 u0x09138715c92dba90, ; 48: lib_System.ComponentModel.Annotations.dll.so => 13
	i64 u0x0919c28b89381a0b, ; 49: lib_Microsoft.Extensions.Options.dll.so => 232
	i64 u0x092266563089ae3e, ; 50: lib_System.Collections.NonGeneric.dll.so => 10
	i64 u0x095cacaf6b6a32e4, ; 51: System.Memory.Data => 270
	i64 u0x09d144a7e214d457, ; 52: System.Security.Cryptography => 127
	i64 u0x09e2b9f743db21a8, ; 53: lib_System.Reflection.Metadata.dll.so => 95
	i64 u0x0a805f95d98f597b, ; 54: lib_Microsoft.Extensions.Caching.Abstractions.dll.so => 214
	i64 u0x0abb3e2b271edc45, ; 55: System.Threading.Channels.dll => 140
	i64 u0x0adeb6c0f5699d33, ; 56: Microsoft.Data.SqlClient.dll => 208
	i64 u0x0b06b1feab070143, ; 57: System.Formats.Tar => 39
	i64 u0x0b3b632c3bbee20c, ; 58: sk/Microsoft.Maui.Controls.resources => 391
	i64 u0x0b6aff547b84fbe9, ; 59: Xamarin.KotlinX.Serialization.Core.Jvm => 365
	i64 u0x0b74b547d9e0e85d, ; 60: Microsoft.AspNetCore.SignalR.Protocols.Json.dll => 205
	i64 u0x0be2e1f8ce4064ed, ; 61: Xamarin.AndroidX.ViewPager => 348
	i64 u0x0c3ca6cc978e2aae, ; 62: pt-BR/Microsoft.Maui.Controls.resources => 387
	i64 u0x0c59ad9fbbd43abe, ; 63: Mono.Android => 172
	i64 u0x0c65741e86371ee3, ; 64: lib_Xamarin.Android.Glide.GifDecoder.dll.so => 279
	i64 u0x0c74af560004e816, ; 65: Microsoft.Win32.Registry.dll => 5
	i64 u0x0c7790f60165fc06, ; 66: lib_Microsoft.Maui.Essentials.dll.so => 246
	i64 u0x0c83c82812e96127, ; 67: lib_System.Net.Mail.dll.so => 67
	i64 u0x0cce4bce83380b7f, ; 68: Xamarin.AndroidX.Security.SecurityCrypto => 339
	i64 u0x0d13cd7cce4284e4, ; 69: System.Security.SecureString => 130
	i64 u0x0d3b5ab8b2766190, ; 70: lib_Microsoft.Bcl.AsyncInterfaces.dll.so => 207
	i64 u0x0d63f4f73521c24f, ; 71: lib_Xamarin.AndroidX.SavedState.SavedState.Ktx.dll.so => 338
	i64 u0x0e04e702012f8463, ; 72: Xamarin.AndroidX.Emoji2 => 306
	i64 u0x0e14e73a54dda68e, ; 73: lib_System.Net.NameResolution.dll.so => 68
	i64 u0x0f37dd7a62ae99af, ; 74: lib_Xamarin.AndroidX.Collection.Ktx.dll.so => 293
	i64 u0x0f5e7abaa7cf470a, ; 75: System.Net.HttpListener => 66
	i64 u0x0f948418e9ebd6de, ; 76: Microsoft.AspNetCore.Hosting.Abstractions.dll => 188
	i64 u0x0fdf69c58fad2d0a, ; 77: SocialMauiApp.dll => 0
	i64 u0x1001f97bbe242e64, ; 78: System.IO.UnmanagedMemoryStream => 57
	i64 u0x102861e4055f511a, ; 79: Microsoft.Bcl.AsyncInterfaces.dll => 207
	i64 u0x102a31b45304b1da, ; 80: Xamarin.AndroidX.CustomView => 301
	i64 u0x1065c4cb554c3d75, ; 81: System.IO.IsolatedStorage.dll => 52
	i64 u0x10ca46a12d1cfb88, ; 82: Syncfusion.Maui.Core => 260
	i64 u0x10f6cfcbcf801616, ; 83: System.IO.Compression.Brotli => 43
	i64 u0x111e7120c198511e, ; 84: DocumentFormat.OpenXml.Framework.dll => 180
	i64 u0x1140109eb2e77ceb, ; 85: Microsoft.Extensions.ObjectPool.dll => 231
	i64 u0x114443cdcf2091f1, ; 86: System.Security.Cryptography.Primitives => 125
	i64 u0x11a603952763e1d4, ; 87: System.Net.Mail => 67
	i64 u0x11a70d0e1009fb11, ; 88: System.Net.WebSockets.dll => 81
	i64 u0x11f26371eee0d3c1, ; 89: lib_Xamarin.AndroidX.Lifecycle.Runtime.Ktx.dll.so => 321
	i64 u0x11fbe62d469cc1c8, ; 90: Microsoft.VisualStudio.DesignTools.TapContract.dll => 403
	i64 u0x12128b3f59302d47, ; 91: lib_System.Xml.Serialization.dll.so => 158
	i64 u0x123639456fb056da, ; 92: System.Reflection.Emit.Lightweight.dll => 92
	i64 u0x124908dccbc07697, ; 93: en-US/Syncfusion.Maui.ImageEditor.resources => 400
	i64 u0x12521e9764603eaa, ; 94: lib_System.Resources.Reader.dll.so => 99
	i64 u0x125b7f94acb989db, ; 95: Xamarin.AndroidX.RecyclerView.dll => 335
	i64 u0x126ee4b0de53cbfd, ; 96: Microsoft.IdentityModel.Protocols.OpenIdConnect.dll => 241
	i64 u0x12d3b63863d4ab0b, ; 97: lib_System.Threading.Overlapped.dll.so => 141
	i64 u0x134eab1061c395ee, ; 98: System.Transactions => 151
	i64 u0x137b34d6751da129, ; 99: System.Drawing.Common => 267
	i64 u0x138567fa954faa55, ; 100: Xamarin.AndroidX.Browser => 289
	i64 u0x13a01de0cbc3f06c, ; 101: lib-fr-Microsoft.Maui.Controls.resources.dll.so => 374
	i64 u0x13beedefb0e28a45, ; 102: lib_System.Xml.XmlDocument.dll.so => 162
	i64 u0x13f1e5e209e91af4, ; 103: lib_Java.Interop.dll.so => 169
	i64 u0x13f1e880c25d96d1, ; 104: he/Microsoft.Maui.Controls.resources => 375
	i64 u0x143a1f6e62b82b56, ; 105: Microsoft.IdentityModel.Protocols.OpenIdConnect => 241
	i64 u0x143d8ea60a6a4011, ; 106: Microsoft.Extensions.DependencyInjection.Abstractions => 220
	i64 u0x1497051b917530bd, ; 107: lib_System.Net.WebSockets.dll.so => 81
	i64 u0x14b78ce3adce0011, ; 108: Microsoft.VisualStudio.DesignTools.TapContract => 403
	i64 u0x14e68447938213b7, ; 109: Xamarin.AndroidX.Collection.Ktx.dll => 293
	i64 u0x15089560460fb845, ; 110: Microsoft.AspNetCore.SignalR.Client.Core => 202
	i64 u0x152a448bd1e745a7, ; 111: Microsoft.Win32.Primitives => 4
	i64 u0x1557de0138c445f4, ; 112: lib_Microsoft.Win32.Registry.dll.so => 5
	i64 u0x15bdc156ed462f2f, ; 113: lib_System.IO.FileSystem.dll.so => 51
	i64 u0x15e300c2c1668655, ; 114: System.Resources.Writer.dll => 101
	i64 u0x16054fdcb6b3098b, ; 115: Microsoft.Extensions.DependencyModel.dll => 221
	i64 u0x1695ecefb732cade, ; 116: lib_Syncfusion.Maui.Core.dll.so => 260
	i64 u0x16bf2a22df043a09, ; 117: System.IO.Pipes.dll => 56
	i64 u0x16ea2b318ad2d830, ; 118: System.Security.Cryptography.Algorithms => 120
	i64 u0x16eeae54c7ebcc08, ; 119: System.Reflection.dll => 98
	i64 u0x17125c9a85b4929f, ; 120: lib_netstandard.dll.so => 168
	i64 u0x1716866f7416792e, ; 121: lib_System.Security.AccessControl.dll.so => 118
	i64 u0x174f71c46216e44a, ; 122: Xamarin.KotlinX.Coroutines.Core => 362
	i64 u0x1752c12f1e1fc00c, ; 123: System.Core => 21
	i64 u0x17b56e25558a5d36, ; 124: lib-hu-Microsoft.Maui.Controls.resources.dll.so => 378
	i64 u0x17f9358913beb16a, ; 125: System.Text.Encodings.Web => 137
	i64 u0x1809fb23f29ba44a, ; 126: lib_System.Reflection.TypeExtensions.dll.so => 97
	i64 u0x18402a709e357f3b, ; 127: lib_Xamarin.KotlinX.Serialization.Core.Jvm.dll.so => 365
	i64 u0x18a9befae51bb361, ; 128: System.Net.WebClient => 77
	i64 u0x18f0ce884e87d89a, ; 129: nb/Microsoft.Maui.Controls.resources.dll => 384
	i64 u0x18facb3695ca9224, ; 130: Refit.HttpClientFactory => 253
	i64 u0x193d7a04b7eda8bc, ; 131: lib_Xamarin.AndroidX.Print.dll.so => 333
	i64 u0x19777fba3c41b398, ; 132: Xamarin.AndroidX.Startup.StartupRuntime.dll => 341
	i64 u0x19a4c090f14ebb66, ; 133: System.Security.Claims => 119
	i64 u0x1a63352be1054efd, ; 134: Microsoft.AspNetCore.Hosting.Server.Abstractions.dll => 189
	i64 u0x1a6fceea64859810, ; 135: Azure.Identity => 175
	i64 u0x1a91866a319e9259, ; 136: lib_System.Collections.Concurrent.dll.so => 8
	i64 u0x1aac34d1917ba5d3, ; 137: lib_System.dll.so => 165
	i64 u0x1aad60783ffa3e5b, ; 138: lib-th-Microsoft.Maui.Controls.resources.dll.so => 393
	i64 u0x1aea8f1c3b282172, ; 139: lib_System.Net.Ping.dll.so => 70
	i64 u0x1b4b7a1d0d265fa2, ; 140: Xamarin.Android.Glide.DiskLruCache => 278
	i64 u0x1bbdb16cfa73e785, ; 141: Xamarin.AndroidX.Lifecycle.Runtime.Ktx.Android => 322
	i64 u0x1bc766e07b2b4241, ; 142: Xamarin.AndroidX.ResourceInspection.Annotation.dll => 336
	i64 u0x1bea5a36aa1ed8de, ; 143: Microsoft.AspNetCore.Http.Extensions => 194
	i64 u0x1c292b1598348d77, ; 144: Microsoft.Extensions.Diagnostics.dll => 222
	i64 u0x1c753b5ff15bce1b, ; 145: Mono.Android.Runtime.dll => 171
	i64 u0x1cd47467799d8250, ; 146: System.Threading.Tasks.dll => 145
	i64 u0x1d23eafdc6dc346c, ; 147: System.Globalization.Calendars.dll => 40
	i64 u0x1da4110562816681, ; 148: Xamarin.AndroidX.Security.SecurityCrypto.dll => 339
	i64 u0x1db6820994506bf5, ; 149: System.IO.FileSystem.AccessControl.dll => 47
	i64 u0x1dbb0c2c6a999acb, ; 150: System.Diagnostics.StackTrace => 30
	i64 u0x1e3d87657e9659bc, ; 151: Xamarin.AndroidX.Navigation.UI => 332
	i64 u0x1e71143913d56c10, ; 152: lib-ko-Microsoft.Maui.Controls.resources.dll.so => 382
	i64 u0x1e7c31185e2fb266, ; 153: lib_System.Threading.Tasks.Parallel.dll.so => 144
	i64 u0x1ed8fcce5e9b50a0, ; 154: Microsoft.Extensions.Options.dll => 232
	i64 u0x1f055d15d807e1b2, ; 155: System.Xml.XmlSerializer => 163
	i64 u0x1f1ed22c1085f044, ; 156: lib_System.Diagnostics.FileVersionInfo.dll.so => 28
	i64 u0x1f61df9c5b94d2c1, ; 157: lib_System.Numerics.dll.so => 84
	i64 u0x1f750bb5421397de, ; 158: lib_Xamarin.AndroidX.Tracing.Tracing.dll.so => 343
	i64 u0x1fd24a4951087d1f, ; 159: Microsoft.AspNetCore.Mvc.Core.dll => 197
	i64 u0x20237ea48006d7a8, ; 160: lib_System.Net.WebClient.dll.so => 77
	i64 u0x209375905fcc1bad, ; 161: lib_System.IO.Compression.Brotli.dll.so => 43
	i64 u0x20edad43b59fbd8e, ; 162: System.Security.Permissions.dll => 274
	i64 u0x20fab3cf2dfbc8df, ; 163: lib_System.Diagnostics.Process.dll.so => 29
	i64 u0x2110167c128cba15, ; 164: System.Globalization => 42
	i64 u0x21419508838f7547, ; 165: System.Runtime.CompilerServices.VisualC => 103
	i64 u0x2174319c0d835bc9, ; 166: System.Runtime => 117
	i64 u0x2198e5bc8b7153fa, ; 167: Xamarin.AndroidX.Annotation.Experimental.dll => 283
	i64 u0x2199f06354c82d3b, ; 168: System.ClientModel.dll => 265
	i64 u0x219ea1b751a4dee4, ; 169: lib_System.IO.Compression.ZipFile.dll.so => 45
	i64 u0x21cc7e445dcd5469, ; 170: System.Reflection.Emit.ILGeneration => 91
	i64 u0x220fd4f2e7c48170, ; 171: th/Microsoft.Maui.Controls.resources => 393
	i64 u0x224538d85ed15a82, ; 172: System.IO.Pipes => 56
	i64 u0x22908438c6bed1af, ; 173: lib_System.Threading.Timer.dll.so => 148
	i64 u0x22fbc14e981e3b45, ; 174: lib_Microsoft.VisualStudio.DesignTools.MobileTapContracts.dll.so => 402
	i64 u0x235fb4941dc174e1, ; 175: DocumentFormat.OpenXml => 179
	i64 u0x237be844f1f812c7, ; 176: System.Threading.Thread.dll => 146
	i64 u0x23807c59646ec4f3, ; 177: lib_Microsoft.EntityFrameworkCore.dll.so => 210
	i64 u0x23852b3bdc9f7096, ; 178: System.Resources.ResourceManager => 100
	i64 u0x23986dd7e5d4fc01, ; 179: System.IO.FileSystem.Primitives.dll => 49
	i64 u0x2407aef2bbe8fadf, ; 180: System.Console => 20
	i64 u0x240abe014b27e7d3, ; 181: Xamarin.AndroidX.Core.dll => 298
	i64 u0x247619fe4413f8bf, ; 182: System.Runtime.Serialization.Primitives.dll => 114
	i64 u0x24de8d301281575e, ; 183: Xamarin.Android.Glide => 276
	i64 u0x252073cc3caa62c2, ; 184: fr/Microsoft.Maui.Controls.resources.dll => 374
	i64 u0x256b8d41255f01b1, ; 185: Xamarin.Google.Crypto.Tink.Android => 354
	i64 u0x25a0a7eff76ea08e, ; 186: SQLitePCLRaw.batteries_v2.dll => 255
	i64 u0x2662c629b96b0b30, ; 187: lib_Xamarin.Kotlin.StdLib.dll.so => 358
	i64 u0x268c1439f13bcc29, ; 188: lib_Microsoft.Extensions.Primitives.dll.so => 234
	i64 u0x26a670e154a9c54b, ; 189: System.Reflection.Extensions.dll => 94
	i64 u0x26d077d9678fe34f, ; 190: System.IO.dll => 58
	i64 u0x270a44600c921861, ; 191: System.IdentityModel.Tokens.Jwt => 268
	i64 u0x273f3515de5faf0d, ; 192: id/Microsoft.Maui.Controls.resources.dll => 379
	i64 u0x2742545f9094896d, ; 193: hr/Microsoft.Maui.Controls.resources => 377
	i64 u0x2759af78ab94d39b, ; 194: System.Net.WebSockets => 81
	i64 u0x27b2b16f3e9de038, ; 195: Xamarin.Google.Crypto.Tink.Android.dll => 354
	i64 u0x27b410442fad6cf1, ; 196: Java.Interop.dll => 169
	i64 u0x27b97e0d52c3034a, ; 197: System.Diagnostics.Debug => 26
	i64 u0x2801845a2c71fbfb, ; 198: System.Net.Primitives.dll => 71
	i64 u0x286835e259162700, ; 199: lib_Xamarin.AndroidX.ProfileInstaller.ProfileInstaller.dll.so => 334
	i64 u0x288f0dc6b8b36b5f, ; 200: Refit.dll => 252
	i64 u0x28b311fffbc0f8df, ; 201: Microsoft.AspNetCore.WebUtilities => 206
	i64 u0x28e52865585a1ebe, ; 202: Microsoft.Extensions.Diagnostics.Abstractions.dll => 223
	i64 u0x2927d345f3daec35, ; 203: SkiaSharp.dll => 254
	i64 u0x2949f3617a02c6b2, ; 204: Xamarin.AndroidX.ExifInterface => 308
	i64 u0x298435b07b00e928, ; 205: lib-en-US-Syncfusion.Maui.ImageEditor.resources.dll.so => 400
	i64 u0x29f947844fb7fc11, ; 206: Microsoft.Maui.Controls.HotReload.Forms => 401
	i64 u0x2a128783efe70ba0, ; 207: uk/Microsoft.Maui.Controls.resources.dll => 395
	i64 u0x2a3b095612184159, ; 208: lib_System.Net.NetworkInformation.dll.so => 69
	i64 u0x2a6507a5ffabdf28, ; 209: System.Diagnostics.TraceSource.dll => 33
	i64 u0x2ac82b8d1ecafc7c, ; 210: lib_System.Windows.Extensions.dll.so => 275
	i64 u0x2ad156c8e1354139, ; 211: fi/Microsoft.Maui.Controls.resources => 373
	i64 u0x2ad5d6b13b7a3e04, ; 212: System.ComponentModel.DataAnnotations.dll => 14
	i64 u0x2af298f63581d886, ; 213: System.Text.RegularExpressions.dll => 139
	i64 u0x2af615542f04da50, ; 214: System.IdentityModel.Tokens.Jwt.dll => 268
	i64 u0x2afc1c4f898552ee, ; 215: lib_System.Formats.Asn1.dll.so => 38
	i64 u0x2b148910ed40fbf9, ; 216: zh-Hant/Microsoft.Maui.Controls.resources.dll => 399
	i64 u0x2b6989d78cba9a15, ; 217: Xamarin.AndroidX.Concurrent.Futures.dll => 294
	i64 u0x2c40db0dbedda89b, ; 218: lib_Microsoft.AspNetCore.WebUtilities.dll.so => 206
	i64 u0x2c8bd14bb93a7d82, ; 219: lib-pl-Microsoft.Maui.Controls.resources.dll.so => 386
	i64 u0x2cbd9262ca785540, ; 220: lib_System.Text.Encoding.CodePages.dll.so => 134
	i64 u0x2cc9e1fed6257257, ; 221: lib_System.Reflection.Emit.Lightweight.dll.so => 92
	i64 u0x2cd723e9fe623c7c, ; 222: lib_System.Private.Xml.Linq.dll.so => 88
	i64 u0x2cdbe1c1d4183ec1, ; 223: lib_Syncfusion.Licensing.dll.so => 259
	i64 u0x2d169d318a968379, ; 224: System.Threading.dll => 149
	i64 u0x2d47774b7d993f59, ; 225: sv/Microsoft.Maui.Controls.resources.dll => 392
	i64 u0x2d5ffcae1ad0aaca, ; 226: System.Data.dll => 24
	i64 u0x2db915caf23548d2, ; 227: System.Text.Json.dll => 138
	i64 u0x2dcaa0bb15a4117a, ; 228: System.IO.UnmanagedMemoryStream.dll => 57
	i64 u0x2e5a40c319acb800, ; 229: System.IO.FileSystem => 51
	i64 u0x2e6f1f226821322a, ; 230: el/Microsoft.Maui.Controls.resources.dll => 371
	i64 u0x2e7c9658c7fb7927, ; 231: Microsoft.Extensions.Features.dll => 224
	i64 u0x2f02f94df3200fe5, ; 232: System.Diagnostics.Process => 29
	i64 u0x2f2e98e1c89b1aff, ; 233: System.Xml.ReaderWriter => 157
	i64 u0x2f40b2521deba305, ; 234: lib_Microsoft.SqlServer.Server.dll.so => 249
	i64 u0x2f5911d9ba814e4e, ; 235: System.Diagnostics.Tracing => 34
	i64 u0x2f84070a459bc31f, ; 236: lib_System.Xml.dll.so => 164
	i64 u0x2feb4d2fcda05cfd, ; 237: Microsoft.Extensions.Caching.Abstractions.dll => 214
	i64 u0x2ff49de6a71764a1, ; 238: lib_Microsoft.Extensions.Http.dll.so => 227
	i64 u0x309ee9eeec09a71e, ; 239: lib_Xamarin.AndroidX.Fragment.dll.so => 309
	i64 u0x309f2bedefa9a318, ; 240: Microsoft.IdentityModel.Abstractions => 237
	i64 u0x30c6dda129408828, ; 241: System.IO.IsolatedStorage => 52
	i64 u0x31195fef5d8fb552, ; 242: _Microsoft.Android.Resource.Designer.dll => 405
	i64 u0x312c8ed623cbfc8d, ; 243: Xamarin.AndroidX.Window.dll => 350
	i64 u0x31496b779ed0663d, ; 244: lib_System.Reflection.DispatchProxy.dll.so => 90
	i64 u0x31700b3b2a9fc1c2, ; 245: Microsoft.AspNetCore.SignalR.Core.dll => 204
	i64 u0x32243413e774362a, ; 246: Xamarin.AndroidX.CardView.dll => 290
	i64 u0x3235427f8d12dae1, ; 247: lib_System.Drawing.Primitives.dll.so => 35
	i64 u0x329753a17a517811, ; 248: fr/Microsoft.Maui.Controls.resources => 374
	i64 u0x32aa989ff07a84ff, ; 249: lib_System.Xml.ReaderWriter.dll.so => 157
	i64 u0x33829542f112d59b, ; 250: System.Collections.Immutable => 9
	i64 u0x33a31443733849fe, ; 251: lib-es-Microsoft.Maui.Controls.resources.dll.so => 372
	i64 u0x341abc357fbb4ebf, ; 252: lib_System.Net.Sockets.dll.so => 76
	i64 u0x348d598f4054415e, ; 253: Microsoft.SqlServer.Server => 249
	i64 u0x3496c1e2dcaf5ecc, ; 254: lib_System.IO.Pipes.AccessControl.dll.so => 55
	i64 u0x34dfd74fe2afcf37, ; 255: Microsoft.Maui => 245
	i64 u0x34e292762d9615df, ; 256: cs/Microsoft.Maui.Controls.resources.dll => 368
	i64 u0x3508234247f48404, ; 257: Microsoft.Maui.Controls => 243
	i64 u0x353590da528c9d22, ; 258: System.ComponentModel.Annotations => 13
	i64 u0x3549870798b4cd30, ; 259: lib_Xamarin.AndroidX.ViewPager2.dll.so => 349
	i64 u0x355282fc1c909694, ; 260: Microsoft.Extensions.Configuration => 216
	i64 u0x3552fc5d578f0fbf, ; 261: Xamarin.AndroidX.Arch.Core.Common => 287
	i64 u0x355c649948d55d97, ; 262: lib_System.Runtime.Intrinsics.dll.so => 109
	i64 u0x35ea419d842e2b43, ; 263: Syncfusion.Maui.ImageEditor.dll => 261
	i64 u0x35ea9d1c6834bc8c, ; 264: Xamarin.AndroidX.Lifecycle.ViewModel.Ktx.dll => 325
	i64 u0x3628ab68db23a01a, ; 265: lib_System.Diagnostics.Tools.dll.so => 32
	i64 u0x3673b042508f5b6b, ; 266: lib_System.Runtime.Extensions.dll.so => 104
	i64 u0x36740f1a8ecdc6c4, ; 267: System.Numerics => 84
	i64 u0x36b2b50fdf589ae2, ; 268: System.Reflection.Emit.Lightweight => 92
	i64 u0x36cada77dc79928b, ; 269: System.IO.MemoryMappedFiles => 53
	i64 u0x374ef46b06791af6, ; 270: System.Reflection.Primitives.dll => 96
	i64 u0x376bf93e521a5417, ; 271: lib_Xamarin.Jetbrains.Annotations.dll.so => 357
	i64 u0x37bc29f3183003b6, ; 272: lib_System.IO.dll.so => 58
	i64 u0x380134e03b1e160a, ; 273: System.Collections.Immutable.dll => 9
	i64 u0x38049b5c59b39324, ; 274: System.Runtime.CompilerServices.Unsafe => 102
	i64 u0x385c17636bb6fe6e, ; 275: Xamarin.AndroidX.CustomView.dll => 301
	i64 u0x38869c811d74050e, ; 276: System.Net.NameResolution.dll => 68
	i64 u0x38e93ec1c057cdf6, ; 277: Microsoft.IdentityModel.Protocols => 240
	i64 u0x38f71e7a64343c93, ; 278: lib_Microsoft.AspNetCore.Authorization.Policy.dll.so => 186
	i64 u0x39251dccb84bdcaa, ; 279: lib_System.Configuration.ConfigurationManager.dll.so => 266
	i64 u0x393c226616977fdb, ; 280: lib_Xamarin.AndroidX.ViewPager.dll.so => 348
	i64 u0x395e37c3334cf82a, ; 281: lib-ca-Microsoft.Maui.Controls.resources.dll.so => 367
	i64 u0x39c3107c28752af1, ; 282: lib_Microsoft.Extensions.FileProviders.Abstractions.dll.so => 225
	i64 u0x3a76a7a156f3d989, ; 283: System.IO.Packaging => 269
	i64 u0x3ab5859054645f72, ; 284: System.Security.Cryptography.Primitives.dll => 125
	i64 u0x3ad75090c3fac0e9, ; 285: lib_Xamarin.AndroidX.ResourceInspection.Annotation.dll.so => 336
	i64 u0x3ae44ac43a1fbdbb, ; 286: System.Runtime.Serialization => 116
	i64 u0x3b860f9932505633, ; 287: lib_System.Text.Encoding.Extensions.dll.so => 135
	i64 u0x3bea9ebe8c027c01, ; 288: lib_Microsoft.IdentityModel.Tokens.dll.so => 242
	i64 u0x3c3aafb6b3a00bf6, ; 289: lib_System.Security.Cryptography.X509Certificates.dll.so => 126
	i64 u0x3c4049146b59aa90, ; 290: System.Runtime.InteropServices.JavaScript => 106
	i64 u0x3c5f19e4acdcebd8, ; 291: lib_Microsoft.Data.SqlClient.dll.so => 208
	i64 u0x3c7c495f58ac5ee9, ; 292: Xamarin.Kotlin.StdLib => 358
	i64 u0x3c7e5ed3d5db71bb, ; 293: System.Security => 131
	i64 u0x3ca05b43ec08224f, ; 294: Microsoft.AspNetCore.Http.Extensions.dll => 194
	i64 u0x3cd9d281d402eb9b, ; 295: Xamarin.AndroidX.Browser.dll => 289
	i64 u0x3d1c50cc001a991e, ; 296: Xamarin.Google.Guava.ListenableFuture.dll => 356
	i64 u0x3d2b1913edfc08d7, ; 297: lib_System.Threading.ThreadPool.dll.so => 147
	i64 u0x3d46f0b995082740, ; 298: System.Xml.Linq => 156
	i64 u0x3d551d0efdd24596, ; 299: System.IO.Packaging.dll => 269
	i64 u0x3d8a8f400514a790, ; 300: Xamarin.AndroidX.Fragment.Ktx.dll => 310
	i64 u0x3d9c2a242b040a50, ; 301: lib_Xamarin.AndroidX.Core.dll.so => 298
	i64 u0x3da7781d6333a8fe, ; 302: SQLitePCLRaw.batteries_v2 => 255
	i64 u0x3dbb6b9f5ab90fa7, ; 303: lib_Xamarin.AndroidX.DynamicAnimation.dll.so => 305
	i64 u0x3e5441657549b213, ; 304: Xamarin.AndroidX.ResourceInspection.Annotation => 336
	i64 u0x3e57d4d195c53c2e, ; 305: System.Reflection.TypeExtensions => 97
	i64 u0x3e580c35ecfc1247, ; 306: lib_Microsoft.AspNetCore.Http.dll.so => 190
	i64 u0x3e616ab4ed1f3f15, ; 307: lib_System.Data.dll.so => 24
	i64 u0x3f1d226e6e06db7e, ; 308: Xamarin.AndroidX.SlidingPaneLayout.dll => 340
	i64 u0x3f3c8f45ab6f28c7, ; 309: Microsoft.Identity.Client.Extensions.Msal.dll => 236
	i64 u0x3f510adf788828dd, ; 310: System.Threading.Tasks.Extensions => 143
	i64 u0x3f6f5914291cdcf7, ; 311: Microsoft.Extensions.Hosting.Abstractions => 226
	i64 u0x407740ff2e914d86, ; 312: Xamarin.AndroidX.Print.dll => 333
	i64 u0x407a10bb4bf95829, ; 313: lib_Xamarin.AndroidX.Navigation.Common.dll.so => 329
	i64 u0x407ac43dee26bd5a, ; 314: lib_Azure.Identity.dll.so => 175
	i64 u0x40c98b6bd77346d4, ; 315: Microsoft.VisualBasic.dll => 3
	i64 u0x415e36f6b13ff6f3, ; 316: System.Configuration.ConfigurationManager.dll => 266
	i64 u0x41833cf766d27d96, ; 317: mscorlib => 167
	i64 u0x41cab042be111c34, ; 318: lib_Xamarin.AndroidX.AppCompat.AppCompatResources.dll.so => 286
	i64 u0x423a9ecc4d905a88, ; 319: lib_System.Resources.ResourceManager.dll.so => 100
	i64 u0x423bf51ae7def810, ; 320: System.Xml.XPath => 161
	i64 u0x42462ff15ddba223, ; 321: System.Resources.Reader.dll => 99
	i64 u0x42a31b86e6ccc3f0, ; 322: System.Diagnostics.Contracts => 25
	i64 u0x430e95b891249788, ; 323: lib_System.Reflection.Emit.dll.so => 93
	i64 u0x43375950ec7c1b6a, ; 324: netstandard.dll => 168
	i64 u0x434c4e1d9284cdae, ; 325: Mono.Android.dll => 172
	i64 u0x43505013578652a0, ; 326: lib_Xamarin.AndroidX.Activity.Ktx.dll.so => 281
	i64 u0x437d06c381ed575a, ; 327: lib_Microsoft.VisualBasic.dll.so => 3
	i64 u0x43950f84de7cc79a, ; 328: pl/Microsoft.Maui.Controls.resources.dll => 386
	i64 u0x43ae6dce532612d0, ; 329: DocumentFormat.OpenXml.VariableReplacer.Core.dll => 181
	i64 u0x43e8ca5bc927ff37, ; 330: lib_Xamarin.AndroidX.Emoji2.ViewsHelper.dll.so => 307
	i64 u0x448bd33429269b19, ; 331: Microsoft.CSharp => 1
	i64 u0x4499fa3c8e494654, ; 332: lib_System.Runtime.Serialization.Primitives.dll.so => 114
	i64 u0x4515080865a951a5, ; 333: Xamarin.Kotlin.StdLib.dll => 358
	i64 u0x45344658e8f1a46d, ; 334: Microsoft.AspNetCore.Authentication.Core => 184
	i64 u0x453c1277f85cf368, ; 335: lib_Microsoft.EntityFrameworkCore.Abstractions.dll.so => 211
	i64 u0x4545802489b736b9, ; 336: Xamarin.AndroidX.Fragment.Ktx => 310
	i64 u0x454b4d1e66bb783c, ; 337: Xamarin.AndroidX.Lifecycle.Process => 318
	i64 u0x458d2df79ac57c1d, ; 338: lib_System.IdentityModel.Tokens.Jwt.dll.so => 268
	i64 u0x45c40276a42e283e, ; 339: System.Diagnostics.TraceSource => 33
	i64 u0x45d443f2a29adc37, ; 340: System.AppContext.dll => 6
	i64 u0x45fcc9fd66f25095, ; 341: Microsoft.Extensions.DependencyModel => 221
	i64 u0x46a4213bc97fe5ae, ; 342: lib-ru-Microsoft.Maui.Controls.resources.dll.so => 390
	i64 u0x47358bd471172e1d, ; 343: lib_System.Xml.Linq.dll.so => 156
	i64 u0x4787a936949fcac2, ; 344: System.Memory.Data.dll => 270
	i64 u0x47daf4e1afbada10, ; 345: pt/Microsoft.Maui.Controls.resources => 388
	i64 u0x480c0a47dd42dd81, ; 346: lib_System.IO.MemoryMappedFiles.dll.so => 53
	i64 u0x488d293220a4fe37, ; 347: Xamarin.AndroidX.Legacy.Support.Core.Utils.dll => 312
	i64 u0x48a6d2fa2eb5d049, ; 348: Microsoft.AspNetCore.SignalR.Protocols.Json => 205
	i64 u0x48e9c8e5d5e8555a, ; 349: DocumentFormat.OpenXml.dll => 179
	i64 u0x4953c088b9debf0a, ; 350: lib_System.Security.Permissions.dll.so => 274
	i64 u0x49e952f19a4e2022, ; 351: System.ObjectModel => 85
	i64 u0x49ea01c721d701b5, ; 352: lib_Microsoft.Net.Http.Headers.dll.so => 248
	i64 u0x49f9e6948a8131e4, ; 353: lib_Xamarin.AndroidX.VersionedParcelable.dll.so => 347
	i64 u0x4a5667b2462a664b, ; 354: lib_Xamarin.AndroidX.Navigation.UI.dll.so => 332
	i64 u0x4a78a24dc5b649fc, ; 355: Syncfusion.Maui.Core.dll => 260
	i64 u0x4a7a18981dbd56bc, ; 356: System.IO.Compression.FileSystem.dll => 44
	i64 u0x4aa5c60350917c06, ; 357: lib_Xamarin.AndroidX.Lifecycle.LiveData.Core.Ktx.dll.so => 317
	i64 u0x4b07a0ed0ab33ff4, ; 358: System.Runtime.Extensions.dll => 104
	i64 u0x4b576d47ac054f3c, ; 359: System.IO.FileSystem.AccessControl => 47
	i64 u0x4b5cc074fafbe58e, ; 360: Microsoft.AspNetCore.ResponseCaching.Abstractions => 198
	i64 u0x4b7b6532ded934b7, ; 361: System.Text.Json => 138
	i64 u0x4b8f8ea3c2df6bb0, ; 362: System.ClientModel => 265
	i64 u0x4bbc7df476e2e556, ; 363: Microsoft.AspNetCore.Mvc.Abstractions.dll => 196
	i64 u0x4c7755cf07ad2d5f, ; 364: System.Net.Http.Json.dll => 64
	i64 u0x4ca014ceac582c86, ; 365: Microsoft.EntityFrameworkCore.Relational.dll => 212
	i64 u0x4cc5f15266470798, ; 366: lib_Xamarin.AndroidX.Loader.dll.so => 327
	i64 u0x4cf6f67dc77aacd2, ; 367: System.Net.NetworkInformation.dll => 69
	i64 u0x4d3183dd245425d4, ; 368: System.Net.WebSockets.Client.dll => 80
	i64 u0x4d479f968a05e504, ; 369: System.Linq.Expressions.dll => 59
	i64 u0x4d55a010ffc4faff, ; 370: System.Private.Xml => 89
	i64 u0x4d5cbe77561c5b2e, ; 371: System.Web.dll => 154
	i64 u0x4d6001db23f8cd87, ; 372: lib_System.ClientModel.dll.so => 265
	i64 u0x4d77512dbd86ee4c, ; 373: lib_Xamarin.AndroidX.Arch.Core.Common.dll.so => 287
	i64 u0x4d7793536e79c309, ; 374: System.ServiceProcess => 133
	i64 u0x4d95fccc1f67c7ca, ; 375: System.Runtime.Loader.dll => 110
	i64 u0x4dcf44c3c9b076a2, ; 376: it/Microsoft.Maui.Controls.resources.dll => 380
	i64 u0x4dd9247f1d2c3235, ; 377: Xamarin.AndroidX.Loader.dll => 327
	i64 u0x4e2aeee78e2c4a87, ; 378: Xamarin.AndroidX.ProfileInstaller.ProfileInstaller => 334
	i64 u0x4e32f00cb0937401, ; 379: Mono.Android.Runtime => 171
	i64 u0x4e39d45ce072e04b, ; 380: Microsoft.AspNetCore.SignalR.Common.dll => 203
	i64 u0x4e5eea4668ac2b18, ; 381: System.Text.Encoding.CodePages => 134
	i64 u0x4ebd0c4b82c5eefc, ; 382: lib_System.Threading.Channels.dll.so => 140
	i64 u0x4ee8eaa9c9c1151a, ; 383: System.Globalization.Calendars => 40
	i64 u0x4f21ee6ef9eb527e, ; 384: ca/Microsoft.Maui.Controls.resources => 367
	i64 u0x4fd5f3ee53d0a4f0, ; 385: SQLitePCLRaw.lib.e_sqlite3.android => 257
	i64 u0x4fdc964ec1888e25, ; 386: lib_Microsoft.Extensions.Configuration.Binder.dll.so => 218
	i64 u0x4ff55724131c908c, ; 387: lib_Microsoft.AspNetCore.Mvc.Core.dll.so => 197
	i64 u0x4ffd65baff757598, ; 388: Microsoft.IdentityModel.Tokens => 242
	i64 u0x5037f0be3c28c7a3, ; 389: lib_Microsoft.Maui.Controls.dll.so => 243
	i64 u0x50c3a29b21050d45, ; 390: System.Linq.Parallel.dll => 60
	i64 u0x5112ed116d87baf8, ; 391: CommunityToolkit.Mvvm => 178
	i64 u0x5116b21580ae6eb0, ; 392: Microsoft.Extensions.Configuration.Binder.dll => 218
	i64 u0x5131bbe80989093f, ; 393: Xamarin.AndroidX.Lifecycle.ViewModel.Android.dll => 324
	i64 u0x516324a5050a7e3c, ; 394: System.Net.WebProxy => 79
	i64 u0x516d6f0b21a303de, ; 395: lib_System.Diagnostics.Contracts.dll.so => 25
	i64 u0x51bb8a2afe774e32, ; 396: System.Drawing => 36
	i64 u0x5216f09c5c4c95c8, ; 397: Microsoft.AspNetCore.Authentication.Abstractions => 183
	i64 u0x5247c5c32a4140f0, ; 398: System.Resources.Reader => 99
	i64 u0x526bb15e3c386364, ; 399: Xamarin.AndroidX.Lifecycle.Runtime.Ktx.dll => 321
	i64 u0x526ce79eb8e90527, ; 400: lib_System.Net.Primitives.dll.so => 71
	i64 u0x527497f521875686, ; 401: Microsoft.AspNetCore.Http.Abstractions => 191
	i64 u0x52829f00b4467c38, ; 402: lib_System.Data.Common.dll.so => 22
	i64 u0x529ffe06f39ab8db, ; 403: Xamarin.AndroidX.Core => 298
	i64 u0x52ff996554dbf352, ; 404: Microsoft.Maui.Graphics => 247
	i64 u0x535f7e40e8fef8af, ; 405: lib-sk-Microsoft.Maui.Controls.resources.dll.so => 391
	i64 u0x53978aac584c666e, ; 406: lib_System.Security.Cryptography.Cng.dll.so => 121
	i64 u0x53a96d5c86c9e194, ; 407: System.Net.NetworkInformation => 69
	i64 u0x53be1038a61e8d44, ; 408: System.Runtime.InteropServices.RuntimeInformation.dll => 107
	i64 u0x53c3014b9437e684, ; 409: lib-zh-HK-Microsoft.Maui.Controls.resources.dll.so => 397
	i64 u0x53e450ebd586f842, ; 410: lib_Xamarin.AndroidX.LocalBroadcastManager.dll.so => 328
	i64 u0x5435e6f049e9bc37, ; 411: System.Security.Claims.dll => 119
	i64 u0x54795225dd1587af, ; 412: lib_System.Runtime.dll.so => 117
	i64 u0x547a34f14e5f6210, ; 413: Xamarin.AndroidX.Lifecycle.Common.dll => 313
	i64 u0x556e8b63b660ab8b, ; 414: Xamarin.AndroidX.Lifecycle.Common.Jvm.dll => 314
	i64 u0x5588627c9a108ec9, ; 415: System.Collections.Specialized => 11
	i64 u0x55a898e4f42e3fae, ; 416: Microsoft.VisualBasic.Core.dll => 2
	i64 u0x55fa0c610fe93bb1, ; 417: lib_System.Security.Cryptography.OpenSsl.dll.so => 124
	i64 u0x56442b99bc64bb47, ; 418: System.Runtime.Serialization.Xml.dll => 115
	i64 u0x56a8b26e1aeae27b, ; 419: System.Threading.Tasks.Dataflow => 142
	i64 u0x56f932d61e93c07f, ; 420: System.Globalization.Extensions => 41
	i64 u0x571c5cfbec5ae8e2, ; 421: System.Private.Uri => 87
	i64 u0x576499c9f52fea31, ; 422: Xamarin.AndroidX.Annotation => 282
	i64 u0x578cd35c91d7b347, ; 423: lib_SQLitePCLRaw.core.dll.so => 256
	i64 u0x579a06fed6eec900, ; 424: System.Private.CoreLib.dll => 173
	i64 u0x57adda3c951abb33, ; 425: Microsoft.Extensions.Hosting.Abstractions.dll => 226
	i64 u0x57c542c14049b66d, ; 426: System.Diagnostics.DiagnosticSource => 27
	i64 u0x581a8bd5cfda563e, ; 427: System.Threading.Timer => 148
	i64 u0x584ac38e21d2fde1, ; 428: Microsoft.Extensions.Configuration.Binder => 218
	i64 u0x58601b2dda4a27b9, ; 429: lib-ja-Microsoft.Maui.Controls.resources.dll.so => 381
	i64 u0x58688d9af496b168, ; 430: Microsoft.Extensions.DependencyInjection.dll => 219
	i64 u0x587f59a16b329d9c, ; 431: Microsoft.Net.Http.Headers => 248
	i64 u0x588c167a79db6bfb, ; 432: lib_Xamarin.Google.ErrorProne.Annotations.dll.so => 355
	i64 u0x5906028ae5151104, ; 433: Xamarin.AndroidX.Activity.Ktx => 281
	i64 u0x595a356d23e8da9a, ; 434: lib_Microsoft.CSharp.dll.so => 1
	i64 u0x59c270386bf40142, ; 435: Microsoft.AspNetCore.Hosting.Server.Abstractions => 189
	i64 u0x59f9e60b9475085f, ; 436: lib_Xamarin.AndroidX.Annotation.Experimental.dll.so => 283
	i64 u0x5a70033ca9d003cb, ; 437: lib_System.Memory.Data.dll.so => 270
	i64 u0x5a745f5101a75527, ; 438: lib_System.IO.Compression.FileSystem.dll.so => 44
	i64 u0x5a89a886ae30258d, ; 439: lib_Xamarin.AndroidX.CoordinatorLayout.dll.so => 297
	i64 u0x5a8f6699f4a1caa9, ; 440: lib_System.Threading.dll.so => 149
	i64 u0x5ae8e4f3eae4d547, ; 441: Xamarin.AndroidX.Legacy.Support.Core.Utils => 312
	i64 u0x5ae9cd33b15841bf, ; 442: System.ComponentModel => 18
	i64 u0x5b247cf480c75903, ; 443: Microsoft.AspNetCore.Http.Connections.Common.dll => 193
	i64 u0x5b54391bdc6fcfe6, ; 444: System.Private.DataContractSerialization => 86
	i64 u0x5b5f0e240a06a2a2, ; 445: da/Microsoft.Maui.Controls.resources.dll => 369
	i64 u0x5b8109e8e14c5e3e, ; 446: System.Globalization.Extensions.dll => 41
	i64 u0x5bddd04d72a9e350, ; 447: Xamarin.AndroidX.Lifecycle.LiveData.Core.Ktx => 317
	i64 u0x5bdf16b09da116ab, ; 448: Xamarin.AndroidX.Collection => 291
	i64 u0x5beca398fe6dce6b, ; 449: lib_Microsoft.AspNetCore.Mvc.Abstractions.dll.so => 196
	i64 u0x5c019d5266093159, ; 450: lib_Xamarin.AndroidX.Lifecycle.Runtime.Ktx.Android.dll.so => 322
	i64 u0x5c294d94f201783b, ; 451: lib_Microsoft.AspNetCore.Http.Connections.Client.dll.so => 192
	i64 u0x5c30a4a35f9cc8c4, ; 452: lib_System.Reflection.Extensions.dll.so => 94
	i64 u0x5c393624b8176517, ; 453: lib_Microsoft.Extensions.Logging.dll.so => 228
	i64 u0x5c53c29f5073b0c9, ; 454: System.Diagnostics.FileVersionInfo => 28
	i64 u0x5c87463c575c7616, ; 455: lib_System.Globalization.Extensions.dll.so => 41
	i64 u0x5cbe0283eb598ee8, ; 456: Microsoft.AspNetCore.Routing => 199
	i64 u0x5d0a4a29b02d9d3c, ; 457: System.Net.WebHeaderCollection.dll => 78
	i64 u0x5d40c9b15181641f, ; 458: lib_Xamarin.AndroidX.Emoji2.dll.so => 306
	i64 u0x5d6ca10d35e9485b, ; 459: lib_Xamarin.AndroidX.Concurrent.Futures.dll.so => 294
	i64 u0x5d7ec76c1c703055, ; 460: System.Threading.Tasks.Parallel => 144
	i64 u0x5db0cbbd1028510e, ; 461: lib_System.Runtime.InteropServices.dll.so => 108
	i64 u0x5db30905d3e5013b, ; 462: Xamarin.AndroidX.Collection.Jvm.dll => 292
	i64 u0x5e467bc8f09ad026, ; 463: System.Collections.Specialized.dll => 11
	i64 u0x5e5173b3208d97e7, ; 464: System.Runtime.Handles.dll => 105
	i64 u0x5ea92fdb19ec8c4c, ; 465: System.Text.Encodings.Web.dll => 137
	i64 u0x5eb8046dd40e9ac3, ; 466: System.ComponentModel.Primitives => 16
	i64 u0x5ebd5650f422a0b0, ; 467: lib_DocumentFormat.OpenXml.VariableReplacer.Core.dll.so => 181
	i64 u0x5ec272d219c9aba4, ; 468: System.Security.Cryptography.Csp.dll => 122
	i64 u0x5eee1376d94c7f5e, ; 469: System.Net.HttpListener.dll => 66
	i64 u0x5f36ccf5c6a57e24, ; 470: System.Xml.ReaderWriter.dll => 157
	i64 u0x5f4294b9b63cb842, ; 471: System.Data.Common => 22
	i64 u0x5f7399e166075632, ; 472: lib_SQLitePCLRaw.lib.e_sqlite3.android.dll.so => 257
	i64 u0x5f9a2d823f664957, ; 473: lib-el-Microsoft.Maui.Controls.resources.dll.so => 371
	i64 u0x5fa6da9c3cd8142a, ; 474: lib_Xamarin.KotlinX.Serialization.Core.dll.so => 364
	i64 u0x5fac98e0b37a5b9d, ; 475: System.Runtime.CompilerServices.Unsafe.dll => 102
	i64 u0x5fd02402d97cdaab, ; 476: lib_Microsoft.Extensions.ObjectPool.dll.so => 231
	i64 u0x609f4b7b63d802d4, ; 477: lib_Microsoft.Extensions.DependencyInjection.dll.so => 219
	i64 u0x60cd4e33d7e60134, ; 478: Xamarin.KotlinX.Coroutines.Core.Jvm => 363
	i64 u0x60f62d786afcf130, ; 479: System.Memory => 63
	i64 u0x61bb78c89f867353, ; 480: System.IO => 58
	i64 u0x61be8d1299194243, ; 481: Microsoft.Maui.Controls.Xaml => 244
	i64 u0x61d2cba29557038f, ; 482: de/Microsoft.Maui.Controls.resources => 370
	i64 u0x61d88f399afb2f45, ; 483: lib_System.Runtime.Loader.dll.so => 110
	i64 u0x622eef6f9e59068d, ; 484: System.Private.CoreLib => 173
	i64 u0x63d5e3aa4ef9b931, ; 485: Xamarin.KotlinX.Coroutines.Android.dll => 361
	i64 u0x63f1f6883c1e23c2, ; 486: lib_System.Collections.Immutable.dll.so => 9
	i64 u0x6400f68068c1e9f1, ; 487: Xamarin.Google.Android.Material.dll => 352
	i64 u0x640e3b14dbd325c2, ; 488: System.Security.Cryptography.Algorithms.dll => 120
	i64 u0x64587004560099b9, ; 489: System.Reflection => 98
	i64 u0x648ac567ed0ec666, ; 490: WinRT.Runtime.dll => 251
	i64 u0x64b1529a438a3c45, ; 491: lib_System.Runtime.Handles.dll.so => 105
	i64 u0x64b61dd9da8a4d57, ; 492: System.Net.ServerSentEvents.dll => 271
	i64 u0x6565fba2cd8f235b, ; 493: Xamarin.AndroidX.Lifecycle.ViewModel.Ktx => 325
	i64 u0x658f524e4aba7dad, ; 494: CommunityToolkit.Maui.dll => 176
	i64 u0x659dc45417570048, ; 495: Refit => 252
	i64 u0x65ecac39144dd3cc, ; 496: Microsoft.Maui.Controls.dll => 243
	i64 u0x65ece51227bfa724, ; 497: lib_System.Runtime.Numerics.dll.so => 111
	i64 u0x661722438787b57f, ; 498: Xamarin.AndroidX.Annotation.Jvm.dll => 284
	i64 u0x6679b2337ee6b22a, ; 499: lib_System.IO.FileSystem.Primitives.dll.so => 49
	i64 u0x6692e924eade1b29, ; 500: lib_System.Console.dll.so => 20
	i64 u0x66a4e5c6a3fb0bae, ; 501: lib_Xamarin.AndroidX.Lifecycle.ViewModel.Android.dll.so => 324
	i64 u0x66ad21286ac74b9d, ; 502: lib_System.Drawing.Common.dll.so => 267
	i64 u0x66d13304ce1a3efa, ; 503: Xamarin.AndroidX.CursorAdapter => 300
	i64 u0x672a10d319608935, ; 504: lib_Microsoft.AspNetCore.Http.Connections.Common.dll.so => 193
	i64 u0x674303f65d8fad6f, ; 505: lib_System.Net.Quic.dll.so => 72
	i64 u0x6756ca4cad62e9d6, ; 506: lib_Xamarin.AndroidX.ConstraintLayout.Core.dll.so => 296
	i64 u0x67c0802770244408, ; 507: System.Windows.dll => 155
	i64 u0x68100b69286e27cd, ; 508: lib_System.Formats.Tar.dll.so => 39
	i64 u0x68558ec653afa616, ; 509: lib-da-Microsoft.Maui.Controls.resources.dll.so => 369
	i64 u0x6872ec7a2e36b1ac, ; 510: System.Drawing.Primitives.dll => 35
	i64 u0x68bb2c417aa9b61c, ; 511: Xamarin.KotlinX.AtomicFU.dll => 359
	i64 u0x68fbbbe2eb455198, ; 512: System.Formats.Asn1 => 38
	i64 u0x69063fc0ba8e6bdd, ; 513: he/Microsoft.Maui.Controls.resources.dll => 375
	i64 u0x699dffb2427a2d71, ; 514: SQLitePCLRaw.lib.e_sqlite3.android.dll => 257
	i64 u0x69a3e26c76f6eec4, ; 515: Xamarin.AndroidX.Window.Extensions.Core.Core.dll => 351
	i64 u0x6a4d7577b2317255, ; 516: System.Runtime.InteropServices.dll => 108
	i64 u0x6ace3b74b15ee4a4, ; 517: nb/Microsoft.Maui.Controls.resources => 384
	i64 u0x6afcedb171067e2b, ; 518: System.Core.dll => 21
	i64 u0x6bef98e124147c24, ; 519: Xamarin.Jetbrains.Annotations => 357
	i64 u0x6cd97f370311a542, ; 520: Microsoft.EntityFrameworkCore.SqlServer => 213
	i64 u0x6ce874bff138ce2b, ; 521: Xamarin.AndroidX.Lifecycle.ViewModel.dll => 323
	i64 u0x6d0a12b2adba20d8, ; 522: System.Security.Cryptography.ProtectedData.dll => 273
	i64 u0x6d12bfaa99c72b1f, ; 523: lib_Microsoft.Maui.Graphics.dll.so => 247
	i64 u0x6d70755158ca866e, ; 524: lib_System.ComponentModel.EventBasedAsync.dll.so => 15
	i64 u0x6d79993361e10ef2, ; 525: Microsoft.Extensions.Primitives => 234
	i64 u0x6d7eeca99577fc8b, ; 526: lib_System.Net.WebProxy.dll.so => 79
	i64 u0x6d8515b19946b6a2, ; 527: System.Net.WebProxy.dll => 79
	i64 u0x6d86d56b84c8eb71, ; 528: lib_Xamarin.AndroidX.CursorAdapter.dll.so => 300
	i64 u0x6d9bea6b3e895cf7, ; 529: Microsoft.Extensions.Primitives.dll => 234
	i64 u0x6dd9bf4083de3f6a, ; 530: Xamarin.AndroidX.DocumentFile.dll => 303
	i64 u0x6e25a02c3833319a, ; 531: lib_Xamarin.AndroidX.Navigation.Fragment.dll.so => 330
	i64 u0x6e79c6bd8627412a, ; 532: Xamarin.AndroidX.SavedState.SavedState.Ktx => 338
	i64 u0x6e838d9a2a6f6c9e, ; 533: lib_System.ValueTuple.dll.so => 152
	i64 u0x6e9965ce1095e60a, ; 534: lib_System.Core.dll.so => 21
	i64 u0x6fd2265da78b93a4, ; 535: lib_Microsoft.Maui.dll.so => 245
	i64 u0x6fdfc7de82c33008, ; 536: cs/Microsoft.Maui.Controls.resources => 368
	i64 u0x6ffc4967cc47ba57, ; 537: System.IO.FileSystem.Watcher.dll => 50
	i64 u0x701cd46a1c25a5fe, ; 538: System.IO.FileSystem.dll => 51
	i64 u0x70e99f48c05cb921, ; 539: tr/Microsoft.Maui.Controls.resources.dll => 394
	i64 u0x70fd3deda22442d2, ; 540: lib-nb-Microsoft.Maui.Controls.resources.dll.so => 384
	i64 u0x71485e7ffdb4b958, ; 541: System.Reflection.Extensions => 94
	i64 u0x7162a2fce67a945f, ; 542: lib_Xamarin.Android.Glide.Annotations.dll.so => 277
	i64 u0x717530326f808838, ; 543: lib_Microsoft.Extensions.Diagnostics.Abstractions.dll.so => 223
	i64 u0x71a495ea3761dde8, ; 544: lib-it-Microsoft.Maui.Controls.resources.dll.so => 380
	i64 u0x71ad672adbe48f35, ; 545: System.ComponentModel.Primitives.dll => 16
	i64 u0x7242820f67bc4ad6, ; 546: Microsoft.AspNetCore.SignalR.Common => 203
	i64 u0x725f5a9e82a45c81, ; 547: System.Security.Cryptography.Encoding => 123
	i64 u0x72b1fb4109e08d7b, ; 548: lib-hr-Microsoft.Maui.Controls.resources.dll.so => 377
	i64 u0x72e0300099accce1, ; 549: System.Xml.XPath.XDocument => 160
	i64 u0x730bfb248998f67a, ; 550: System.IO.Compression.ZipFile => 45
	i64 u0x732b2d67b9e5c47b, ; 551: Xamarin.Google.ErrorProne.Annotations.dll => 355
	i64 u0x733c9fa4b145dea1, ; 552: lib_SocialMauiApp.dll.so => 0
	i64 u0x734b76fdc0dc05bb, ; 553: lib_GoogleGson.dll.so => 182
	i64 u0x73a2b85f84dcec96, ; 554: lib_DocumentFormat.OpenXml.dll.so => 179
	i64 u0x73a6be34e822f9d1, ; 555: lib_System.Runtime.Serialization.dll.so => 116
	i64 u0x73e4ce94e2eb6ffc, ; 556: lib_System.Memory.dll.so => 63
	i64 u0x743a1eccf080489a, ; 557: WindowsBase.dll => 166
	i64 u0x746cf89b511b4d40, ; 558: lib_Microsoft.Extensions.Diagnostics.dll.so => 222
	i64 u0x755a91767330b3d4, ; 559: lib_Microsoft.Extensions.Configuration.dll.so => 216
	i64 u0x758463c93f0d589e, ; 560: lib_Microsoft.AspNetCore.Connections.Abstractions.dll.so => 187
	i64 u0x75c326eb821b85c4, ; 561: lib_System.ComponentModel.DataAnnotations.dll.so => 14
	i64 u0x76012e7334db86e5, ; 562: lib_Xamarin.AndroidX.SavedState.dll.so => 337
	i64 u0x76ca07b878f44da0, ; 563: System.Runtime.Numerics.dll => 111
	i64 u0x7736c8a96e51a061, ; 564: lib_Xamarin.AndroidX.Annotation.Jvm.dll.so => 284
	i64 u0x778a805e625329ef, ; 565: System.Linq.Parallel => 60
	i64 u0x779290cc2b801eb7, ; 566: Xamarin.KotlinX.AtomicFU.Jvm => 360
	i64 u0x77d9074d8f33a303, ; 567: lib_System.Net.ServerSentEvents.dll.so => 271
	i64 u0x77f8a4acc2fdc449, ; 568: System.Security.Cryptography.Cng.dll => 121
	i64 u0x780bc73597a503a9, ; 569: lib-ms-Microsoft.Maui.Controls.resources.dll.so => 383
	i64 u0x782c5d8eb99ff201, ; 570: lib_Microsoft.VisualBasic.Core.dll.so => 2
	i64 u0x783606d1e53e7a1a, ; 571: th/Microsoft.Maui.Controls.resources.dll => 393
	i64 u0x7841c47b741b9f64, ; 572: System.Security.Permissions => 274
	i64 u0x78a1938b89c96721, ; 573: Microsoft.AspNetCore.Http.Connections.Common => 193
	i64 u0x78a45e51311409b6, ; 574: Xamarin.AndroidX.Fragment.dll => 309
	i64 u0x78ed4ab8f9d800a1, ; 575: Xamarin.AndroidX.Lifecycle.ViewModel => 323
	i64 u0x7985af0fe05692bb, ; 576: lib_SocialMediaMaui.Shared.dll.so => 404
	i64 u0x79f2a1023f4320f2, ; 577: Microsoft.Win32.SystemEvents => 250
	i64 u0x7a25bdb29108c6e7, ; 578: Microsoft.Extensions.Http => 227
	i64 u0x7a39601d6f0bb831, ; 579: lib_Xamarin.KotlinX.AtomicFU.dll.so => 359
	i64 u0x7a7e7eddf79c5d26, ; 580: lib_Xamarin.AndroidX.Lifecycle.ViewModel.dll.so => 323
	i64 u0x7a9a57d43b0845fa, ; 581: System.AppContext => 6
	i64 u0x7ad0f4f1e5d08183, ; 582: Xamarin.AndroidX.Collection.dll => 291
	i64 u0x7adb8da2ac89b647, ; 583: fi/Microsoft.Maui.Controls.resources.dll => 373
	i64 u0x7b13d9eaa944ade8, ; 584: Xamarin.AndroidX.DynamicAnimation.dll => 305
	i64 u0x7b150145c0a9058c, ; 585: Microsoft.Data.Sqlite => 209
	i64 u0x7b4927e421291c41, ; 586: Microsoft.IdentityModel.JsonWebTokens.dll => 238
	i64 u0x7bef86a4335c4870, ; 587: System.ComponentModel.TypeConverter => 17
	i64 u0x7c0820144cd34d6a, ; 588: sk/Microsoft.Maui.Controls.resources.dll => 391
	i64 u0x7c2a0bd1e0f988fc, ; 589: lib-de-Microsoft.Maui.Controls.resources.dll.so => 370
	i64 u0x7c41d387501568ba, ; 590: System.Net.WebClient.dll => 77
	i64 u0x7c482cd79bd24b13, ; 591: lib_Xamarin.AndroidX.ConstraintLayout.dll.so => 295
	i64 u0x7cc637f941f716d0, ; 592: CommunityToolkit.Maui.Core => 177
	i64 u0x7cd2ec8eaf5241cd, ; 593: System.Security.dll => 131
	i64 u0x7cf9ae50dd350622, ; 594: Xamarin.Jetbrains.Annotations.dll => 357
	i64 u0x7d49c593eeb09ac9, ; 595: Microsoft.AspNetCore.SignalR.Client.dll => 201
	i64 u0x7d649b75d580bb42, ; 596: ms/Microsoft.Maui.Controls.resources.dll => 383
	i64 u0x7d8ee2bdc8e3aad1, ; 597: System.Numerics.Vectors => 83
	i64 u0x7df5df8db8eaa6ac, ; 598: Microsoft.Extensions.Logging.Debug => 230
	i64 u0x7dfc3d6d9d8d7b70, ; 599: System.Collections => 12
	i64 u0x7e2e564fa2f76c65, ; 600: lib_System.Diagnostics.Tracing.dll.so => 34
	i64 u0x7e302e110e1e1346, ; 601: lib_System.Security.Claims.dll.so => 119
	i64 u0x7e4465b3f78ad8d0, ; 602: Xamarin.KotlinX.Serialization.Core.dll => 364
	i64 u0x7e571cad5915e6c3, ; 603: lib_Xamarin.AndroidX.Lifecycle.Process.dll.so => 318
	i64 u0x7e6b1ca712437d7d, ; 604: Xamarin.AndroidX.Emoji2.ViewsHelper => 307
	i64 u0x7e946809d6008ef2, ; 605: lib_System.ObjectModel.dll.so => 85
	i64 u0x7ea0272c1b4a9635, ; 606: lib_Xamarin.Android.Glide.dll.so => 276
	i64 u0x7ecc13347c8fd849, ; 607: lib_System.ComponentModel.dll.so => 18
	i64 u0x7eff369f2e01cf95, ; 608: Microsoft.AspNetCore.Http.Features => 195
	i64 u0x7f00ddd9b9ca5a13, ; 609: Xamarin.AndroidX.ViewPager.dll => 348
	i64 u0x7f9351cd44b1273f, ; 610: Microsoft.Extensions.Configuration.Abstractions => 217
	i64 u0x7fae0ef4dc4770fe, ; 611: Microsoft.Identity.Client => 235
	i64 u0x7fbd557c99b3ce6f, ; 612: lib_Xamarin.AndroidX.Lifecycle.LiveData.Core.dll.so => 316
	i64 u0x7fd75077141d6658, ; 613: Microsoft.AspNetCore.Authorization.Policy => 186
	i64 u0x8076a9a44a2ca331, ; 614: System.Net.Quic => 72
	i64 u0x80b7e726b0280681, ; 615: Microsoft.VisualStudio.DesignTools.MobileTapContracts => 402
	i64 u0x80da183a87731838, ; 616: System.Reflection.Metadata => 95
	i64 u0x80fa55b6d1b0be99, ; 617: SQLitePCLRaw.provider.e_sqlite3 => 258
	i64 u0x812c069d5cdecc17, ; 618: System.dll => 165
	i64 u0x81381be520a60adb, ; 619: Xamarin.AndroidX.Interpolator.dll => 311
	i64 u0x81657cec2b31e8aa, ; 620: System.Net => 82
	i64 u0x81ab745f6c0f5ce6, ; 621: zh-Hant/Microsoft.Maui.Controls.resources => 399
	i64 u0x822aa49008112ebe, ; 622: Microsoft.Extensions.ObjectPool => 231
	i64 u0x8277f2be6b5ce05f, ; 623: Xamarin.AndroidX.AppCompat => 285
	i64 u0x828f06563b30bc50, ; 624: lib_Xamarin.AndroidX.CardView.dll.so => 290
	i64 u0x82920a8d9194a019, ; 625: Xamarin.KotlinX.AtomicFU.Jvm.dll => 360
	i64 u0x82b399cb01b531c4, ; 626: lib_System.Web.dll.so => 154
	i64 u0x82df8f5532a10c59, ; 627: lib_System.Drawing.dll.so => 36
	i64 u0x82f0b6e911d13535, ; 628: lib_System.Transactions.dll.so => 151
	i64 u0x82f6403342e12049, ; 629: uk/Microsoft.Maui.Controls.resources => 395
	i64 u0x83a7afd2c49adc86, ; 630: lib_Microsoft.IdentityModel.Abstractions.dll.so => 237
	i64 u0x83c14ba66c8e2b8c, ; 631: zh-Hans/Microsoft.Maui.Controls.resources => 398
	i64 u0x846ce984efea52c7, ; 632: System.Threading.Tasks.Parallel.dll => 144
	i64 u0x846f52335a832137, ; 633: Microsoft.Extensions.Features => 224
	i64 u0x84ae73148a4557d2, ; 634: lib_System.IO.Pipes.dll.so => 56
	i64 u0x84b01102c12a9232, ; 635: System.Runtime.Serialization.Json.dll => 113
	i64 u0x84cd5cdec0f54bcc, ; 636: lib_Microsoft.EntityFrameworkCore.Relational.dll.so => 212
	i64 u0x84f20950c4c7164b, ; 637: Microsoft.AspNetCore.Http => 190
	i64 u0x84f9060cc4a93c8f, ; 638: lib_SkiaSharp.dll.so => 254
	i64 u0x850c5ba0b57ce8e7, ; 639: lib_Xamarin.AndroidX.Collection.dll.so => 291
	i64 u0x851d02edd334b044, ; 640: Xamarin.AndroidX.VectorDrawable => 345
	i64 u0x85c919db62150978, ; 641: Xamarin.AndroidX.Transition.dll => 344
	i64 u0x8636d45a3b98cdf7, ; 642: Syncfusion.Maui.ImageEditor => 261
	i64 u0x8662aaeb94fef37f, ; 643: lib_System.Dynamic.Runtime.dll.so => 37
	i64 u0x86a909228dc7657b, ; 644: lib-zh-Hant-Microsoft.Maui.Controls.resources.dll.so => 399
	i64 u0x86b3e00c36b84509, ; 645: Microsoft.Extensions.Configuration.dll => 216
	i64 u0x86b62cb077ec4fd7, ; 646: System.Runtime.Serialization.Xml => 115
	i64 u0x8706ffb12bf3f53d, ; 647: Xamarin.AndroidX.Annotation.Experimental => 283
	i64 u0x872a5b14c18d328c, ; 648: System.ComponentModel.DataAnnotations => 14
	i64 u0x872fb9615bc2dff0, ; 649: Xamarin.Android.Glide.Annotations.dll => 277
	i64 u0x87a3c575cf2318ce, ; 650: Syncfusion.Maui.Sliders.dll => 262
	i64 u0x87c4b8a492b176ad, ; 651: Microsoft.EntityFrameworkCore.Abstractions => 211
	i64 u0x87c69b87d9283884, ; 652: lib_System.Threading.Thread.dll.so => 146
	i64 u0x87d6cb5c641c5f07, ; 653: Microsoft.AspNetCore.Http.Abstractions.dll => 191
	i64 u0x87f6569b25707834, ; 654: System.IO.Compression.Brotli.dll => 43
	i64 u0x8842b3a5d2d3fb36, ; 655: Microsoft.Maui.Essentials => 246
	i64 u0x88926583efe7ee86, ; 656: Xamarin.AndroidX.Activity.Ktx.dll => 281
	i64 u0x88ba6bc4f7762b03, ; 657: lib_System.Reflection.dll.so => 98
	i64 u0x88bda98e0cffb7a9, ; 658: lib_Xamarin.KotlinX.Coroutines.Core.Jvm.dll.so => 363
	i64 u0x890981e3e80b7d74, ; 659: lib_Syncfusion.Maui.ImageEditor.dll.so => 261
	i64 u0x8930322c7bd8f768, ; 660: netstandard => 168
	i64 u0x897a606c9e39c75f, ; 661: lib_System.ComponentModel.Primitives.dll.so => 16
	i64 u0x89911a22005b92b7, ; 662: System.IO.FileSystem.DriveInfo.dll => 48
	i64 u0x89c5188089ec2cd5, ; 663: lib_System.Runtime.InteropServices.RuntimeInformation.dll.so => 107
	i64 u0x8a0b6f586fccda8a, ; 664: lib_Microsoft.AspNetCore.Http.Extensions.dll.so => 194
	i64 u0x8a14bf4400a024af, ; 665: lib_Microsoft.AspNetCore.Http.Features.dll.so => 195
	i64 u0x8a19e3dc71b34b2c, ; 666: System.Reflection.TypeExtensions.dll => 97
	i64 u0x8a399a706fcbce4b, ; 667: Microsoft.Extensions.Caching.Abstractions => 214
	i64 u0x8ac8d025b93e29e9, ; 668: Syncfusion.Licensing => 259
	i64 u0x8ad229ea26432ee2, ; 669: Xamarin.AndroidX.Loader => 327
	i64 u0x8b42b55a5bb040b5, ; 670: lib_Microsoft.AspNetCore.SignalR.Protocols.Json.dll.so => 205
	i64 u0x8b4ff5d0fdd5faa1, ; 671: lib_System.Diagnostics.DiagnosticSource.dll.so => 27
	i64 u0x8b541d476eb3774c, ; 672: System.Security.Principal.Windows => 128
	i64 u0x8b8d01333a96d0b5, ; 673: System.Diagnostics.Process.dll => 29
	i64 u0x8b9ceca7acae3451, ; 674: lib-he-Microsoft.Maui.Controls.resources.dll.so => 375
	i64 u0x8ba96f31f69ece34, ; 675: Microsoft.Win32.SystemEvents.dll => 250
	i64 u0x8bb8206f414c7c3b, ; 676: Microsoft.AspNetCore.Authentication.Core.dll => 184
	i64 u0x8c53ae18581b14f0, ; 677: Azure.Core => 174
	i64 u0x8c575135aa1ccef4, ; 678: Microsoft.Extensions.FileProviders.Abstractions => 225
	i64 u0x8cb8f612b633affb, ; 679: Xamarin.AndroidX.SavedState.SavedState.Ktx.dll => 338
	i64 u0x8cdfdb4ce85fb925, ; 680: lib_System.Security.Principal.Windows.dll.so => 128
	i64 u0x8cdfe7b8f4caa426, ; 681: System.IO.Compression.FileSystem => 44
	i64 u0x8cf51f1eb9e90658, ; 682: lib_Microsoft.EntityFrameworkCore.SqlServer.dll.so => 213
	i64 u0x8d0f420977c2c1c7, ; 683: Xamarin.AndroidX.CursorAdapter.dll => 300
	i64 u0x8d52f7ea2796c531, ; 684: Xamarin.AndroidX.Emoji2.dll => 306
	i64 u0x8d5f431bf67cc907, ; 685: SocialMediaMaui.Shared => 404
	i64 u0x8d7b8ab4b3310ead, ; 686: System.Threading => 149
	i64 u0x8da188285aadfe8e, ; 687: System.Collections.Concurrent => 8
	i64 u0x8dce248c34c54ef3, ; 688: lib_Microsoft.AspNetCore.Hosting.Abstractions.dll.so => 188
	i64 u0x8e623fec9635e28f, ; 689: Syncfusion.Maui.Toolkit.resources.dll => 264
	i64 u0x8e937db395a74375, ; 690: lib_Microsoft.Identity.Client.dll.so => 235
	i64 u0x8ed807bfe9858dfc, ; 691: Xamarin.AndroidX.Navigation.Common => 329
	i64 u0x8ee08b8194a30f48, ; 692: lib-hi-Microsoft.Maui.Controls.resources.dll.so => 376
	i64 u0x8ef7601039857a44, ; 693: lib-ro-Microsoft.Maui.Controls.resources.dll.so => 389
	i64 u0x8ef9414937d93a0a, ; 694: SQLitePCLRaw.core.dll => 256
	i64 u0x8f32c6f611f6ffab, ; 695: pt/Microsoft.Maui.Controls.resources.dll => 388
	i64 u0x8f44b45eb046bbd1, ; 696: System.ServiceModel.Web.dll => 132
	i64 u0x8f8829d21c8985a4, ; 697: lib-pt-BR-Microsoft.Maui.Controls.resources.dll.so => 387
	i64 u0x8f97020698a101ba, ; 698: Microsoft.AspNetCore.Routing.dll => 199
	i64 u0x8fbf5b0114c6dcef, ; 699: System.Globalization.dll => 42
	i64 u0x8fcc8c2a81f3d9e7, ; 700: Xamarin.KotlinX.Serialization.Core => 364
	i64 u0x8fd27d934d7b3a55, ; 701: SQLitePCLRaw.core => 256
	i64 u0x90263f8448b8f572, ; 702: lib_System.Diagnostics.TraceSource.dll.so => 33
	i64 u0x90281820febeff00, ; 703: lib_Microsoft.AspNetCore.Routing.Abstractions.dll.so => 200
	i64 u0x903101b46fb73a04, ; 704: _Microsoft.Android.Resource.Designer => 405
	i64 u0x90393bd4865292f3, ; 705: lib_System.IO.Compression.dll.so => 46
	i64 u0x905e2b8e7ae91ae6, ; 706: System.Threading.Tasks.Extensions.dll => 143
	i64 u0x90634f86c5ebe2b5, ; 707: Xamarin.AndroidX.Lifecycle.ViewModel.Android => 324
	i64 u0x907b636704ad79ef, ; 708: lib_Microsoft.Maui.Controls.Xaml.dll.so => 244
	i64 u0x90ae2b5b8b652f2a, ; 709: lib_Microsoft.AspNetCore.SignalR.Client.Core.dll.so => 202
	i64 u0x90e9efbfd68593e0, ; 710: lib_Xamarin.AndroidX.Lifecycle.LiveData.dll.so => 315
	i64 u0x91418dc638b29e68, ; 711: lib_Xamarin.AndroidX.CustomView.dll.so => 301
	i64 u0x9157bd523cd7ed36, ; 712: lib_System.Text.Json.dll.so => 138
	i64 u0x91a74f07b30d37e2, ; 713: System.Linq.dll => 62
	i64 u0x91cb86ea3b17111d, ; 714: System.ServiceModel.Web => 132
	i64 u0x91fa41a87223399f, ; 715: ca/Microsoft.Maui.Controls.resources.dll => 367
	i64 u0x92054e486c0c7ea7, ; 716: System.IO.FileSystem.DriveInfo => 48
	i64 u0x928614058c40c4cd, ; 717: lib_System.Xml.XPath.XDocument.dll.so => 160
	i64 u0x92b138fffca2b01e, ; 718: lib_Xamarin.AndroidX.Arch.Core.Runtime.dll.so => 288
	i64 u0x92dd6c6033393bf7, ; 719: Syncfusion.Maui.Toolkit.resources => 264
	i64 u0x92dfc2bfc6c6a888, ; 720: Xamarin.AndroidX.Lifecycle.LiveData => 315
	i64 u0x933da2c779423d68, ; 721: Xamarin.Android.Glide.Annotations => 277
	i64 u0x9388aad9b7ae40ce, ; 722: lib_Xamarin.AndroidX.Lifecycle.Common.dll.so => 313
	i64 u0x93cfa73ab28d6e35, ; 723: ms/Microsoft.Maui.Controls.resources => 383
	i64 u0x941c00d21e5c0679, ; 724: lib_Xamarin.AndroidX.Transition.dll.so => 344
	i64 u0x944077d8ca3c6580, ; 725: System.IO.Compression.dll => 46
	i64 u0x948cffedc8ed7960, ; 726: System.Xml => 164
	i64 u0x948d746a7702861f, ; 727: Microsoft.IdentityModel.Logging.dll => 239
	i64 u0x94c8990839c4bdb1, ; 728: lib_Xamarin.AndroidX.Interpolator.dll.so => 311
	i64 u0x9502fd818eed2359, ; 729: lib_Microsoft.IdentityModel.Protocols.OpenIdConnect.dll.so => 241
	i64 u0x9564283c37ed59a9, ; 730: lib_Microsoft.IdentityModel.Logging.dll.so => 239
	i64 u0x957a4cdfdcfd6d83, ; 731: Refit.HttpClientFactory.dll => 253
	i64 u0x967fc325e09bfa8c, ; 732: es/Microsoft.Maui.Controls.resources => 372
	i64 u0x9686161486d34b81, ; 733: lib_Xamarin.AndroidX.ExifInterface.dll.so => 308
	i64 u0x96e49b31fe33d427, ; 734: Microsoft.Identity.Client.Extensions.Msal => 236
	i64 u0x9732d8dbddea3d9a, ; 735: id/Microsoft.Maui.Controls.resources => 379
	i64 u0x978be80e5210d31b, ; 736: Microsoft.Maui.Graphics.dll => 247
	i64 u0x97b8c771ea3e4220, ; 737: System.ComponentModel.dll => 18
	i64 u0x97e144c9d3c6976e, ; 738: System.Collections.Concurrent.dll => 8
	i64 u0x984184e3c70d4419, ; 739: GoogleGson => 182
	i64 u0x9843944103683dd3, ; 740: Xamarin.AndroidX.Core.Core.Ktx => 299
	i64 u0x98d720cc4597562c, ; 741: System.Security.Cryptography.OpenSsl => 124
	i64 u0x991d510397f92d9d, ; 742: System.Linq.Expressions => 59
	i64 u0x996ceeb8a3da3d67, ; 743: System.Threading.Overlapped.dll => 141
	i64 u0x999cb19e1a04ffd3, ; 744: CommunityToolkit.Mvvm.dll => 178
	i64 u0x99a00ca5270c6878, ; 745: Xamarin.AndroidX.Navigation.Runtime => 331
	i64 u0x99cdc6d1f2d3a72f, ; 746: ko/Microsoft.Maui.Controls.resources.dll => 382
	i64 u0x9a01b1da98b6ee10, ; 747: Xamarin.AndroidX.Lifecycle.Runtime.dll => 319
	i64 u0x9a0cc42c6f36dfc9, ; 748: lib_Microsoft.IdentityModel.Protocols.dll.so => 240
	i64 u0x9a5ccc274fd6e6ee, ; 749: Jsr305Binding.dll => 353
	i64 u0x9ae6940b11c02876, ; 750: lib_Xamarin.AndroidX.Window.dll.so => 350
	i64 u0x9b211a749105beac, ; 751: System.Transactions.Local => 150
	i64 u0x9b8734714671022d, ; 752: System.Threading.Tasks.Dataflow.dll => 142
	i64 u0x9bc6aea27fbf034f, ; 753: lib_Xamarin.KotlinX.Coroutines.Core.dll.so => 362
	i64 u0x9bd8cc74558ad4c7, ; 754: Xamarin.KotlinX.AtomicFU => 359
	i64 u0x9c244ac7cda32d26, ; 755: System.Security.Cryptography.X509Certificates.dll => 126
	i64 u0x9c465f280cf43733, ; 756: lib_Xamarin.KotlinX.Coroutines.Android.dll.so => 361
	i64 u0x9c8f6872beab6408, ; 757: System.Xml.XPath.XDocument.dll => 160
	i64 u0x9ce01cf91101ae23, ; 758: System.Xml.XmlDocument => 162
	i64 u0x9d128180c81d7ce6, ; 759: Xamarin.AndroidX.CustomView.PoolingContainer => 302
	i64 u0x9d5dbcf5a48583fe, ; 760: lib_Xamarin.AndroidX.Activity.dll.so => 280
	i64 u0x9d74dee1a7725f34, ; 761: Microsoft.Extensions.Configuration.Abstractions.dll => 217
	i64 u0x9d9ab89cba5d9008, ; 762: WinRT.Runtime => 251
	i64 u0x9e4534b6adaf6e84, ; 763: nl/Microsoft.Maui.Controls.resources => 385
	i64 u0x9e4b95dec42769f7, ; 764: System.Diagnostics.Debug.dll => 26
	i64 u0x9eaf1efdf6f7267e, ; 765: Xamarin.AndroidX.Navigation.Common.dll => 329
	i64 u0x9ef542cf1f78c506, ; 766: Xamarin.AndroidX.Lifecycle.LiveData.Core => 316
	i64 u0x9f5c7301a67b9123, ; 767: lib_Syncfusion.Maui.Sliders.dll.so => 262
	i64 u0x9ffbb6b1434ad2df, ; 768: Microsoft.Identity.Client.dll => 235
	i64 u0xa00832eb975f56a8, ; 769: lib_System.Net.dll.so => 82
	i64 u0xa05475503f80b7d9, ; 770: Microsoft.AspNetCore.Connections.Abstractions => 187
	i64 u0xa0ad78236b7b267f, ; 771: Xamarin.AndroidX.Window => 350
	i64 u0xa0d8259f4cc284ec, ; 772: lib_System.Security.Cryptography.dll.so => 127
	i64 u0xa0e17ca50c77a225, ; 773: lib_Xamarin.Google.Crypto.Tink.Android.dll.so => 354
	i64 u0xa0ff9b3e34d92f11, ; 774: lib_System.Resources.Writer.dll.so => 101
	i64 u0xa12fbfb4da97d9f3, ; 775: System.Threading.Timer.dll => 148
	i64 u0xa1440773ee9d341e, ; 776: Xamarin.Google.Android.Material => 352
	i64 u0xa1b9d7c27f47219f, ; 777: Xamarin.AndroidX.Navigation.UI.dll => 332
	i64 u0xa2572680829d2c7c, ; 778: System.IO.Pipelines.dll => 54
	i64 u0xa26597e57ee9c7f6, ; 779: System.Xml.XmlDocument.dll => 162
	i64 u0xa308401900e5bed3, ; 780: lib_mscorlib.dll.so => 167
	i64 u0xa395572e7da6c99d, ; 781: lib_System.Security.dll.so => 131
	i64 u0xa3e683f24b43af6f, ; 782: System.Dynamic.Runtime.dll => 37
	i64 u0xa4145becdee3dc4f, ; 783: Xamarin.AndroidX.VectorDrawable.Animated => 346
	i64 u0xa46aa1eaa214539b, ; 784: ko/Microsoft.Maui.Controls.resources => 382
	i64 u0xa473938c792db0b6, ; 785: Microsoft.AspNetCore.Routing.Abstractions => 200
	i64 u0xa4a372eecb9e4df0, ; 786: Microsoft.Extensions.Diagnostics => 222
	i64 u0xa4d20d2ff0563d26, ; 787: lib_CommunityToolkit.Mvvm.dll.so => 178
	i64 u0xa4edc8f2ceae241a, ; 788: System.Data.Common.dll => 22
	i64 u0xa526fadd66308051, ; 789: Microsoft.EntityFrameworkCore.SqlServer.dll => 213
	i64 u0xa5494f40f128ce6a, ; 790: System.Runtime.Serialization.Formatters.dll => 112
	i64 u0xa54b74df83dce92b, ; 791: System.Reflection.DispatchProxy => 90
	i64 u0xa579ed010d7e5215, ; 792: Xamarin.AndroidX.DocumentFile => 303
	i64 u0xa5b7152421ed6d98, ; 793: lib_System.IO.FileSystem.Watcher.dll.so => 50
	i64 u0xa5c3844f17b822db, ; 794: lib_System.Linq.Parallel.dll.so => 60
	i64 u0xa5ce5c755bde8cb8, ; 795: lib_System.Security.Cryptography.Csp.dll.so => 122
	i64 u0xa5e599d1e0524750, ; 796: System.Numerics.Vectors.dll => 83
	i64 u0xa5f1ba49b85dd355, ; 797: System.Security.Cryptography.dll => 127
	i64 u0xa61975a5a37873ea, ; 798: lib_System.Xml.XmlSerializer.dll.so => 163
	i64 u0xa6593e21584384d2, ; 799: lib_Jsr305Binding.dll.so => 353
	i64 u0xa66cbee0130865f7, ; 800: lib_WindowsBase.dll.so => 166
	i64 u0xa67dbee13e1df9ca, ; 801: Xamarin.AndroidX.SavedState.dll => 337
	i64 u0xa684b098dd27b296, ; 802: lib_Xamarin.AndroidX.Security.SecurityCrypto.dll.so => 339
	i64 u0xa68a420042bb9b1f, ; 803: Xamarin.AndroidX.DrawerLayout.dll => 304
	i64 u0xa6d26156d1cacc7c, ; 804: Xamarin.Android.Glide.dll => 276
	i64 u0xa71fe7d6f6f93efd, ; 805: Microsoft.Data.SqlClient => 208
	i64 u0xa75386b5cb9595aa, ; 806: Xamarin.AndroidX.Lifecycle.Runtime.Android => 320
	i64 u0xa75cf331ee476318, ; 807: lib_Microsoft.AspNetCore.Http.Abstractions.dll.so => 191
	i64 u0xa763fbb98df8d9fb, ; 808: lib_Microsoft.Win32.Primitives.dll.so => 4
	i64 u0xa78ce3745383236a, ; 809: Xamarin.AndroidX.Lifecycle.Common.Jvm => 314
	i64 u0xa797ca094a0a7418, ; 810: lib_Microsoft.AspNetCore.SignalR.Core.dll.so => 204
	i64 u0xa7c31b56b4dc7b33, ; 811: hu/Microsoft.Maui.Controls.resources => 378
	i64 u0xa7eab29ed44b4e7a, ; 812: Mono.Android.Export => 170
	i64 u0xa8195217cbf017b7, ; 813: Microsoft.VisualBasic.Core => 2
	i64 u0xa859a95830f367ff, ; 814: lib_Xamarin.AndroidX.Lifecycle.ViewModel.Ktx.dll.so => 325
	i64 u0xa8b52f21e0dbe690, ; 815: System.Runtime.Serialization.dll => 116
	i64 u0xa8e6320dd07580ef, ; 816: lib_Microsoft.IdentityModel.JsonWebTokens.dll.so => 238
	i64 u0xa8ee4ed7de2efaee, ; 817: Xamarin.AndroidX.Annotation.dll => 282
	i64 u0xa95590e7c57438a4, ; 818: System.Configuration => 19
	i64 u0xa964304b5631e28a, ; 819: CommunityToolkit.Maui.Core.dll => 177
	i64 u0xaa2219c8e3449ff5, ; 820: Microsoft.Extensions.Logging.Abstractions => 229
	i64 u0xaa443ac34067eeef, ; 821: System.Private.Xml.dll => 89
	i64 u0xaa52de307ef5d1dd, ; 822: System.Net.Http => 65
	i64 u0xaa8448d5c2540403, ; 823: System.Windows.Extensions => 275
	i64 u0xaa9a7b0214a5cc5c, ; 824: System.Diagnostics.StackTrace.dll => 30
	i64 u0xaaaf86367285a918, ; 825: Microsoft.Extensions.DependencyInjection.Abstractions.dll => 220
	i64 u0xaaf84bb3f052a265, ; 826: el/Microsoft.Maui.Controls.resources => 371
	i64 u0xab9af77b5b67a0b8, ; 827: Xamarin.AndroidX.ConstraintLayout.Core => 296
	i64 u0xab9c1b2687d86b0b, ; 828: lib_System.Linq.Expressions.dll.so => 59
	i64 u0xabaabcb70f9474ff, ; 829: Microsoft.AspNetCore.Mvc.Abstractions => 196
	i64 u0xac03339b985f4d59, ; 830: Microsoft.AspNetCore.SignalR.Client.Core.dll => 202
	i64 u0xac2af3fa195a15ce, ; 831: System.Runtime.Numerics => 111
	i64 u0xac5376a2a538dc10, ; 832: Xamarin.AndroidX.Lifecycle.LiveData.Core.dll => 316
	i64 u0xac5acae88f60357e, ; 833: System.Diagnostics.Tools.dll => 32
	i64 u0xac79c7e46047ad98, ; 834: System.Security.Principal.Windows.dll => 128
	i64 u0xac98d31068e24591, ; 835: System.Xml.XDocument => 159
	i64 u0xacd46e002c3ccb97, ; 836: ro/Microsoft.Maui.Controls.resources => 389
	i64 u0xacdd9e4180d56dda, ; 837: Xamarin.AndroidX.Concurrent.Futures => 294
	i64 u0xacf42eea7ef9cd12, ; 838: System.Threading.Channels => 140
	i64 u0xad7e82ed3b0f16d0, ; 839: lib_Xamarin.AndroidX.DocumentFile.dll.so => 303
	i64 u0xad89c07347f1bad6, ; 840: nl/Microsoft.Maui.Controls.resources.dll => 385
	i64 u0xadbb53caf78a79d2, ; 841: System.Web.HttpUtility => 153
	i64 u0xadc90ab061a9e6e4, ; 842: System.ComponentModel.TypeConverter.dll => 17
	i64 u0xadca1b9030b9317e, ; 843: Xamarin.AndroidX.Collection.Ktx => 293
	i64 u0xadd8eda2edf396ad, ; 844: Xamarin.Android.Glide.GifDecoder => 279
	i64 u0xadf4cf30debbeb9a, ; 845: System.Net.ServicePoint.dll => 75
	i64 u0xadf511667bef3595, ; 846: System.Net.Security => 74
	i64 u0xae0aaa94fdcfce0f, ; 847: System.ComponentModel.EventBasedAsync.dll => 15
	i64 u0xae282bcd03739de7, ; 848: Java.Interop => 169
	i64 u0xae53579c90db1107, ; 849: System.ObjectModel.dll => 85
	i64 u0xaec7c0c7e2ed4575, ; 850: lib_Xamarin.KotlinX.AtomicFU.Jvm.dll.so => 360
	i64 u0xaf4829c0b3e740ae, ; 851: lib_Syncfusion.Maui.Toolkit.resources.dll.so => 264
	i64 u0xaf732d0b2193b8f5, ; 852: System.Security.Cryptography.OpenSsl.dll => 124
	i64 u0xafdb94dbccd9d11c, ; 853: Xamarin.AndroidX.Lifecycle.LiveData.dll => 315
	i64 u0xafe29f45095518e7, ; 854: lib_Xamarin.AndroidX.Lifecycle.ViewModelSavedState.dll.so => 326
	i64 u0xb03ae931fb25607e, ; 855: Xamarin.AndroidX.ConstraintLayout => 295
	i64 u0xb05cc42cd94c6d9d, ; 856: lib-sv-Microsoft.Maui.Controls.resources.dll.so => 392
	i64 u0xb0ac21bec8f428c5, ; 857: Xamarin.AndroidX.Lifecycle.Runtime.Ktx.Android.dll => 322
	i64 u0xb0bb43dc52ea59f9, ; 858: System.Diagnostics.Tracing.dll => 34
	i64 u0xb1dd05401aa8ee63, ; 859: System.Security.AccessControl => 118
	i64 u0xb220631954820169, ; 860: System.Text.RegularExpressions => 139
	i64 u0xb2376e1dbf8b4ed7, ; 861: System.Security.Cryptography.Csp => 122
	i64 u0xb2a1959fe95c5402, ; 862: lib_System.Runtime.InteropServices.JavaScript.dll.so => 106
	i64 u0xb2a3f67f3bf29fce, ; 863: da/Microsoft.Maui.Controls.resources => 369
	i64 u0xb3011a0a57f7ffb2, ; 864: Microsoft.VisualStudio.DesignTools.MobileTapContracts.dll => 402
	i64 u0xb343b35350be6ef3, ; 865: DocumentFormat.OpenXml.Framework => 180
	i64 u0xb3874072ee0ecf8c, ; 866: Xamarin.AndroidX.VectorDrawable.Animated.dll => 346
	i64 u0xb398860d6ed7ba2f, ; 867: System.Security.Cryptography.ProtectedData => 273
	i64 u0xb3f0a0fcda8d3ebc, ; 868: Xamarin.AndroidX.CardView => 290
	i64 u0xb3f832258cb83db4, ; 869: Syncfusion.Licensing.dll => 259
	i64 u0xb46be1aa6d4fff93, ; 870: hi/Microsoft.Maui.Controls.resources => 376
	i64 u0xb477491be13109d8, ; 871: ar/Microsoft.Maui.Controls.resources => 366
	i64 u0xb4bd7015ecee9d86, ; 872: System.IO.Pipelines => 54
	i64 u0xb4c53d9749c5f226, ; 873: lib_System.IO.FileSystem.AccessControl.dll.so => 47
	i64 u0xb4ff710863453fda, ; 874: System.Diagnostics.FileVersionInfo.dll => 28
	i64 u0xb52aa297a3a175b1, ; 875: lib_Microsoft.AspNetCore.Authentication.Core.dll.so => 184
	i64 u0xb545f78b0415b9b9, ; 876: Microsoft.AspNetCore.WebUtilities.dll => 206
	i64 u0xb5c38bf497a4cfe2, ; 877: lib_System.Threading.Tasks.dll.so => 145
	i64 u0xb5c7fcdafbc67ee4, ; 878: Microsoft.Extensions.Logging.Abstractions.dll => 229
	i64 u0xb5e59badb43e7829, ; 879: Microsoft.AspNetCore.Routing.Abstractions.dll => 200
	i64 u0xb5ea31d5244c6626, ; 880: System.Threading.ThreadPool.dll => 147
	i64 u0xb7212c4683a94afe, ; 881: System.Drawing.Primitives => 35
	i64 u0xb7b7753d1f319409, ; 882: sv/Microsoft.Maui.Controls.resources => 392
	i64 u0xb81a2c6e0aee50fe, ; 883: lib_System.Private.CoreLib.dll.so => 173
	i64 u0xb872c26142d22aa9, ; 884: Microsoft.Extensions.Http.dll => 227
	i64 u0xb8b0a9b3dfbc5cb7, ; 885: Xamarin.AndroidX.Window.Extensions.Core.Core => 351
	i64 u0xb8c60af47c08d4da, ; 886: System.Net.ServicePoint => 75
	i64 u0xb8e68d20aad91196, ; 887: lib_System.Xml.XPath.dll.so => 161
	i64 u0xb9185c33a1643eed, ; 888: Microsoft.CSharp.dll => 1
	i64 u0xb9b8001adf4ed7cc, ; 889: lib_Xamarin.AndroidX.SlidingPaneLayout.dll.so => 340
	i64 u0xb9f64d3b230def68, ; 890: lib-pt-Microsoft.Maui.Controls.resources.dll.so => 388
	i64 u0xb9fc3c8a556e3691, ; 891: ja/Microsoft.Maui.Controls.resources => 381
	i64 u0xba4670aa94a2b3c6, ; 892: lib_System.Xml.XDocument.dll.so => 159
	i64 u0xba48785529705af9, ; 893: System.Collections.dll => 12
	i64 u0xba965b8c86359996, ; 894: lib_System.Windows.dll.so => 155
	i64 u0xbb286883bc35db36, ; 895: System.Transactions.dll => 151
	i64 u0xbb639e0337b3d979, ; 896: Microsoft.AspNetCore.Http.dll => 190
	i64 u0xbb65706fde942ce3, ; 897: System.Net.Sockets => 76
	i64 u0xbb8c8d165ef11460, ; 898: lib_Microsoft.Identity.Client.Extensions.Msal.dll.so => 236
	i64 u0xbba28979413cad9e, ; 899: lib_System.Runtime.CompilerServices.VisualC.dll.so => 103
	i64 u0xbbd180354b67271a, ; 900: System.Runtime.Serialization.Formatters => 112
	i64 u0xbc22a245dab70cb4, ; 901: lib_SQLitePCLRaw.provider.e_sqlite3.dll.so => 258
	i64 u0xbc260cdba33291a3, ; 902: Xamarin.AndroidX.Arch.Core.Common.dll => 287
	i64 u0xbcd36316d29f27b4, ; 903: lib_Microsoft.AspNetCore.Authorization.dll.so => 185
	i64 u0xbcfa7c134d2089f3, ; 904: System.Runtime.Caching => 272
	i64 u0xbd0e2c0d55246576, ; 905: System.Net.Http.dll => 65
	i64 u0xbd3fbd85b9e1cb29, ; 906: lib_System.Net.HttpListener.dll.so => 66
	i64 u0xbd437a2cdb333d0d, ; 907: Xamarin.AndroidX.ViewPager2 => 349
	i64 u0xbd4f572d2bd0a789, ; 908: System.IO.Compression.ZipFile.dll => 45
	i64 u0xbd5d0b88d3d647a5, ; 909: lib_Xamarin.AndroidX.Browser.dll.so => 289
	i64 u0xbd877b14d0b56392, ; 910: System.Runtime.Intrinsics.dll => 109
	i64 u0xbde4cd9bb9008cb3, ; 911: lib_Microsoft.AspNetCore.Authentication.Abstractions.dll.so => 183
	i64 u0xbe4450ecf4d84c63, ; 912: lib_Microsoft.AspNetCore.ResponseCaching.Abstractions.dll.so => 198
	i64 u0xbe65a49036345cf4, ; 913: lib_System.Buffers.dll.so => 7
	i64 u0xbee1b395605474f1, ; 914: System.Drawing.Common.dll => 267
	i64 u0xbee38d4a88835966, ; 915: Xamarin.AndroidX.AppCompat.AppCompatResources => 286
	i64 u0xbef9919db45b4ca7, ; 916: System.IO.Pipes.AccessControl => 55
	i64 u0xbf0fa68611139208, ; 917: lib_Xamarin.AndroidX.Annotation.dll.so => 282
	i64 u0xbfc1e1fb3095f2b3, ; 918: lib_System.Net.Http.Json.dll.so => 64
	i64 u0xc040a4ab55817f58, ; 919: ar/Microsoft.Maui.Controls.resources.dll => 366
	i64 u0xc07cadab29efeba0, ; 920: Xamarin.AndroidX.Core.Core.Ktx.dll => 299
	i64 u0xc0d928351ab5ca77, ; 921: System.Console.dll => 20
	i64 u0xc0f5a221a9383aea, ; 922: System.Runtime.Intrinsics => 109
	i64 u0xc111030af54d7191, ; 923: System.Resources.Writer => 101
	i64 u0xc12b8b3afa48329c, ; 924: lib_System.Linq.dll.so => 62
	i64 u0xc1347413e524ff69, ; 925: lib_Syncfusion.Maui.Toolkit.dll.so => 263
	i64 u0xc183ca0b74453aa9, ; 926: lib_System.Threading.Tasks.Dataflow.dll.so => 142
	i64 u0xc1c2cb7af77b8858, ; 927: Microsoft.EntityFrameworkCore => 210
	i64 u0xc1ebdc7e6a943450, ; 928: Microsoft.AspNetCore.Authorization.dll => 185
	i64 u0xc1ff9ae3cdb6e1e6, ; 929: Xamarin.AndroidX.Activity.dll => 280
	i64 u0xc26c064effb1dea9, ; 930: System.Buffers.dll => 7
	i64 u0xc278de356ad8a9e3, ; 931: Microsoft.IdentityModel.Logging => 239
	i64 u0xc28c50f32f81cc73, ; 932: ja/Microsoft.Maui.Controls.resources.dll => 381
	i64 u0xc2902f6cf5452577, ; 933: lib_Mono.Android.Export.dll.so => 170
	i64 u0xc2a3bca55b573141, ; 934: System.IO.FileSystem.Watcher => 50
	i64 u0xc2bcfec99f69365e, ; 935: Xamarin.AndroidX.ViewPager2.dll => 349
	i64 u0xc30b52815b58ac2c, ; 936: lib_System.Runtime.Serialization.Xml.dll.so => 115
	i64 u0xc3492f8f90f96ce4, ; 937: lib_Microsoft.Extensions.DependencyModel.dll.so => 221
	i64 u0xc36d7d89c652f455, ; 938: System.Threading.Overlapped => 141
	i64 u0xc374571bc2b0b5f8, ; 939: lib_Microsoft.AspNetCore.Routing.dll.so => 199
	i64 u0xc396b285e59e5493, ; 940: GoogleGson.dll => 182
	i64 u0xc39ced8467203460, ; 941: lib_Refit.HttpClientFactory.dll.so => 253
	i64 u0xc3c86c1e5e12f03d, ; 942: WindowsBase => 166
	i64 u0xc421b61fd853169d, ; 943: lib_System.Net.WebSockets.Client.dll.so => 80
	i64 u0xc463e077917aa21d, ; 944: System.Runtime.Serialization.Json => 113
	i64 u0xc472ce300460ccb6, ; 945: Microsoft.EntityFrameworkCore.dll => 210
	i64 u0xc4d3858ed4d08512, ; 946: Xamarin.AndroidX.Lifecycle.ViewModelSavedState.dll => 326
	i64 u0xc4d69851fe06342f, ; 947: lib_Microsoft.Extensions.Caching.Memory.dll.so => 215
	i64 u0xc4f2d57c50beb816, ; 948: lib_Microsoft.Extensions.Features.dll.so => 224
	i64 u0xc50fded0ded1418c, ; 949: lib_System.ComponentModel.TypeConverter.dll.so => 17
	i64 u0xc519125d6bc8fb11, ; 950: lib_System.Net.Requests.dll.so => 73
	i64 u0xc5293b19e4dc230e, ; 951: Xamarin.AndroidX.Navigation.Fragment => 330
	i64 u0xc5325b2fcb37446f, ; 952: lib_System.Private.Xml.dll.so => 89
	i64 u0xc535cb9a21385d9b, ; 953: lib_Xamarin.Android.Glide.DiskLruCache.dll.so => 278
	i64 u0xc5a0f4b95a699af7, ; 954: lib_System.Private.Uri.dll.so => 87
	i64 u0xc5cdcd5b6277579e, ; 955: lib_System.Security.Cryptography.Algorithms.dll.so => 120
	i64 u0xc5de3dcae13c325f, ; 956: Microsoft.AspNetCore.SignalR.Client => 201
	i64 u0xc5ec286825cb0bf4, ; 957: Xamarin.AndroidX.Tracing.Tracing => 343
	i64 u0xc6706bc8aa7fe265, ; 958: Xamarin.AndroidX.Annotation.Jvm => 284
	i64 u0xc6c65ca6318f6fde, ; 959: lib_System.IO.Packaging.dll.so => 269
	i64 u0xc7c01e7d7c93a110, ; 960: System.Text.Encoding.Extensions.dll => 135
	i64 u0xc7ce851898a4548e, ; 961: lib_System.Web.HttpUtility.dll.so => 153
	i64 u0xc809d4089d2556b2, ; 962: System.Runtime.InteropServices.JavaScript.dll => 106
	i64 u0xc858a28d9ee5a6c5, ; 963: lib_System.Collections.Specialized.dll.so => 11
	i64 u0xc8ac7c6bf1c2ec51, ; 964: System.Reflection.DispatchProxy.dll => 90
	i64 u0xc9c62c8f354ac568, ; 965: lib_System.Diagnostics.TextWriterTraceListener.dll.so => 31
	i64 u0xc9e54b32fc19baf3, ; 966: lib_CommunityToolkit.Maui.dll.so => 176
	i64 u0xca32340d8d54dcd5, ; 967: Microsoft.Extensions.Caching.Memory.dll => 215
	i64 u0xca3a723e7342c5b6, ; 968: lib-tr-Microsoft.Maui.Controls.resources.dll.so => 394
	i64 u0xca5801070d9fccfb, ; 969: System.Text.Encoding => 136
	i64 u0xcab3493c70141c2d, ; 970: pl/Microsoft.Maui.Controls.resources => 386
	i64 u0xcacfddc9f7c6de76, ; 971: ro/Microsoft.Maui.Controls.resources.dll => 389
	i64 u0xcadbc92899a777f0, ; 972: Xamarin.AndroidX.Startup.StartupRuntime => 341
	i64 u0xcb45618372c47127, ; 973: Microsoft.EntityFrameworkCore.Relational => 212
	i64 u0xcba1cb79f45292b5, ; 974: Xamarin.Android.Glide.GifDecoder.dll => 279
	i64 u0xcbb5f80c7293e696, ; 975: lib_System.Globalization.Calendars.dll.so => 40
	i64 u0xcbd4fdd9cef4a294, ; 976: lib__Microsoft.Android.Resource.Designer.dll.so => 405
	i64 u0xcc15da1e07bbd994, ; 977: Xamarin.AndroidX.SlidingPaneLayout => 340
	i64 u0xcc182c3afdc374d6, ; 978: Microsoft.Bcl.AsyncInterfaces => 207
	i64 u0xcc2876b32ef2794c, ; 979: lib_System.Text.RegularExpressions.dll.so => 139
	i64 u0xcc579b7a6e965d12, ; 980: DocumentFormat.OpenXml.VariableReplacer.Core => 181
	i64 u0xcc5c3bb714c4561e, ; 981: Xamarin.KotlinX.Coroutines.Core.Jvm.dll => 363
	i64 u0xcc76886e09b88260, ; 982: Xamarin.KotlinX.Serialization.Core.Jvm.dll => 365
	i64 u0xcc9fa2923aa1c9ef, ; 983: System.Diagnostics.Contracts.dll => 25
	i64 u0xcce5f0b382db16b7, ; 984: Microsoft.AspNetCore.Http.Connections.Client => 192
	i64 u0xccf25c4b634ccd3a, ; 985: zh-Hans/Microsoft.Maui.Controls.resources.dll => 398
	i64 u0xcd10a42808629144, ; 986: System.Net.Requests => 73
	i64 u0xcd3586b93136841e, ; 987: lib_System.Runtime.Caching.dll.so => 272
	i64 u0xcdca1b920e9f53ba, ; 988: Xamarin.AndroidX.Interpolator => 311
	i64 u0xcdd0c48b6937b21c, ; 989: Xamarin.AndroidX.SwipeRefreshLayout => 342
	i64 u0xceb28d385f84f441, ; 990: Azure.Core.dll => 174
	i64 u0xcf140ed700bc8e66, ; 991: Microsoft.SqlServer.Server.dll => 249
	i64 u0xcf23d8093f3ceadf, ; 992: System.Diagnostics.DiagnosticSource.dll => 27
	i64 u0xcf5ff6b6b2c4c382, ; 993: System.Net.Mail.dll => 67
	i64 u0xcf8fc898f98b0d34, ; 994: System.Private.Xml.Linq => 88
	i64 u0xd030f32762b3d78f, ; 995: Microsoft.AspNetCore.SignalR.Core => 204
	i64 u0xd04b5f59ed596e31, ; 996: System.Reflection.Metadata.dll => 95
	i64 u0xd063299fcfc0c93f, ; 997: lib_System.Runtime.Serialization.Json.dll.so => 113
	i64 u0xd0de8a113e976700, ; 998: System.Diagnostics.TextWriterTraceListener => 31
	i64 u0xd0fc33d5ae5d4cb8, ; 999: System.Runtime.Extensions => 104
	i64 u0xd1194e1d8a8de83c, ; 1000: lib_Xamarin.AndroidX.Lifecycle.Common.Jvm.dll.so => 314
	i64 u0xd12beacdfc14f696, ; 1001: System.Dynamic.Runtime => 37
	i64 u0xd16fd7fb9bbcd43e, ; 1002: Microsoft.Extensions.Diagnostics.Abstractions => 223
	i64 u0xd198e7ce1b6a8344, ; 1003: System.Net.Quic.dll => 72
	i64 u0xd22a0c4630f2fe66, ; 1004: lib_System.Security.Cryptography.ProtectedData.dll.so => 273
	i64 u0xd3144156a3727ebe, ; 1005: Xamarin.Google.Guava.ListenableFuture => 356
	i64 u0xd333d0af9e423810, ; 1006: System.Runtime.InteropServices => 108
	i64 u0xd33a415cb4278969, ; 1007: System.Security.Cryptography.Encoding.dll => 123
	i64 u0xd3426d966bb704f5, ; 1008: Xamarin.AndroidX.AppCompat.AppCompatResources.dll => 286
	i64 u0xd3651b6fc3125825, ; 1009: System.Private.Uri.dll => 87
	i64 u0xd373685349b1fe8b, ; 1010: Microsoft.Extensions.Logging.dll => 228
	i64 u0xd3801faafafb7698, ; 1011: System.Private.DataContractSerialization.dll => 86
	i64 u0xd3e4c8d6a2d5d470, ; 1012: it/Microsoft.Maui.Controls.resources => 380
	i64 u0xd3edcc1f25459a50, ; 1013: System.Reflection.Emit => 93
	i64 u0xd42655883bb8c19f, ; 1014: Microsoft.EntityFrameworkCore.Abstractions.dll => 211
	i64 u0xd4645626dffec99d, ; 1015: lib_Microsoft.Extensions.DependencyInjection.Abstractions.dll.so => 220
	i64 u0xd4fa0abb79079ea9, ; 1016: System.Security.Principal.dll => 129
	i64 u0xd52f53c4b3d62e11, ; 1017: Microsoft.AspNetCore.Connections.Abstractions.dll => 187
	i64 u0xd5507e11a2b2839f, ; 1018: Xamarin.AndroidX.Lifecycle.ViewModelSavedState => 326
	i64 u0xd5d04bef8478ea19, ; 1019: Xamarin.AndroidX.Tracing.Tracing.dll => 343
	i64 u0xd60815f26a12e140, ; 1020: Microsoft.Extensions.Logging.Debug.dll => 230
	i64 u0xd65786d27a4ad960, ; 1021: lib_Microsoft.Maui.Controls.HotReload.Forms.dll.so => 401
	i64 u0xd6694f8359737e4e, ; 1022: Xamarin.AndroidX.SavedState => 337
	i64 u0xd6949e129339eae5, ; 1023: lib_Xamarin.AndroidX.Core.Core.Ktx.dll.so => 299
	i64 u0xd6d21782156bc35b, ; 1024: Xamarin.AndroidX.SwipeRefreshLayout.dll => 342
	i64 u0xd6de019f6af72435, ; 1025: Xamarin.AndroidX.ConstraintLayout.Core.dll => 296
	i64 u0xd70956d1e6deefb9, ; 1026: Jsr305Binding => 353
	i64 u0xd72329819cbbbc44, ; 1027: lib_Microsoft.Extensions.Configuration.Abstractions.dll.so => 217
	i64 u0xd72c760af136e863, ; 1028: System.Xml.XmlSerializer.dll => 163
	i64 u0xd753f071e44c2a03, ; 1029: lib_System.Security.SecureString.dll.so => 130
	i64 u0xd7b3764ada9d341d, ; 1030: lib_Microsoft.Extensions.Logging.Abstractions.dll.so => 229
	i64 u0xd7f0088bc5ad71f2, ; 1031: Xamarin.AndroidX.VersionedParcelable => 347
	i64 u0xd8fb25e28ae30a12, ; 1032: Xamarin.AndroidX.ProfileInstaller.ProfileInstaller.dll => 334
	i64 u0xda1dfa4c534a9251, ; 1033: Microsoft.Extensions.DependencyInjection => 219
	i64 u0xdad05a11827959a3, ; 1034: System.Collections.NonGeneric.dll => 10
	i64 u0xdaefdfe71aa53cf9, ; 1035: System.IO.FileSystem.Primitives => 49
	i64 u0xdb5383ab5865c007, ; 1036: lib-vi-Microsoft.Maui.Controls.resources.dll.so => 396
	i64 u0xdb58816721c02a59, ; 1037: lib_System.Reflection.Emit.ILGeneration.dll.so => 91
	i64 u0xdbeda89f832aa805, ; 1038: vi/Microsoft.Maui.Controls.resources.dll => 396
	i64 u0xdbf2a779fbc3ac31, ; 1039: System.Transactions.Local.dll => 150
	i64 u0xdbf9607a441b4505, ; 1040: System.Linq => 62
	i64 u0xdbfc90157a0de9b0, ; 1041: lib_System.Text.Encoding.dll.so => 136
	i64 u0xdc75032002d1a212, ; 1042: lib_System.Transactions.Local.dll.so => 150
	i64 u0xdca8be7403f92d4f, ; 1043: lib_System.Linq.Queryable.dll.so => 61
	i64 u0xdce2c53525640bf3, ; 1044: Microsoft.Extensions.Logging => 228
	i64 u0xdd2b722d78ef5f43, ; 1045: System.Runtime.dll => 117
	i64 u0xdd67031857c72f96, ; 1046: lib_System.Text.Encodings.Web.dll.so => 137
	i64 u0xdd92e229ad292030, ; 1047: System.Numerics.dll => 84
	i64 u0xdddcdd701e911af1, ; 1048: lib_Xamarin.AndroidX.Legacy.Support.Core.Utils.dll.so => 312
	i64 u0xdde30e6b77aa6f6c, ; 1049: lib-zh-Hans-Microsoft.Maui.Controls.resources.dll.so => 398
	i64 u0xde110ae80fa7c2e2, ; 1050: System.Xml.XDocument.dll => 159
	i64 u0xde4726fcdf63a198, ; 1051: Xamarin.AndroidX.Transition => 344
	i64 u0xde572c2b2fb32f93, ; 1052: lib_System.Threading.Tasks.Extensions.dll.so => 143
	i64 u0xde8769ebda7d8647, ; 1053: hr/Microsoft.Maui.Controls.resources.dll => 377
	i64 u0xdee075f3477ef6be, ; 1054: Xamarin.AndroidX.ExifInterface.dll => 308
	i64 u0xdf4b773de8fb1540, ; 1055: System.Net.dll => 82
	i64 u0xdf9c7682560a9629, ; 1056: System.Net.ServerSentEvents => 271
	i64 u0xdfa254ebb4346068, ; 1057: System.Net.Ping => 70
	i64 u0xdfa4850418b6c99a, ; 1058: Microsoft.AspNetCore.Hosting.Abstractions => 188
	i64 u0xe0142572c095a480, ; 1059: Xamarin.AndroidX.AppCompat.dll => 285
	i64 u0xe020c74e3723dc6f, ; 1060: Syncfusion.Maui.Toolkit.dll => 263
	i64 u0xe021eaa401792a05, ; 1061: System.Text.Encoding.dll => 136
	i64 u0xe02f89350ec78051, ; 1062: Xamarin.AndroidX.CoordinatorLayout.dll => 297
	i64 u0xe02ff568f8e5f275, ; 1063: Microsoft.AspNetCore.Http.Connections.Client.dll => 192
	i64 u0xe0496b9d65ef5474, ; 1064: Xamarin.Android.Glide.DiskLruCache.dll => 278
	i64 u0xe10b760bb1462e7a, ; 1065: lib_System.Security.Cryptography.Primitives.dll.so => 125
	i64 u0xe1566bbdb759c5af, ; 1066: Microsoft.Maui.Controls.HotReload.Forms.dll => 401
	i64 u0xe192a588d4410686, ; 1067: lib_System.IO.Pipelines.dll.so => 54
	i64 u0xe1a08bd3fa539e0d, ; 1068: System.Runtime.Loader => 110
	i64 u0xe1a77eb8831f7741, ; 1069: System.Security.SecureString.dll => 130
	i64 u0xe1b52f9f816c70ef, ; 1070: System.Private.Xml.Linq.dll => 88
	i64 u0xe1e199c8ab02e356, ; 1071: System.Data.DataSetExtensions.dll => 23
	i64 u0xe1ecfdb7fff86067, ; 1072: System.Net.Security.dll => 74
	i64 u0xe2252a80fe853de4, ; 1073: lib_System.Security.Principal.dll.so => 129
	i64 u0xe22fa4c9c645db62, ; 1074: System.Diagnostics.TextWriterTraceListener.dll => 31
	i64 u0xe24095a7afddaab3, ; 1075: lib_Microsoft.Extensions.Hosting.Abstractions.dll.so => 226
	i64 u0xe2420585aeceb728, ; 1076: System.Net.Requests.dll => 73
	i64 u0xe26692647e6bcb62, ; 1077: Xamarin.AndroidX.Lifecycle.Runtime.Ktx => 321
	i64 u0xe29b73bc11392966, ; 1078: lib-id-Microsoft.Maui.Controls.resources.dll.so => 379
	i64 u0xe2ad448dee50fbdf, ; 1079: System.Xml.Serialization => 158
	i64 u0xe2d920f978f5d85c, ; 1080: System.Data.DataSetExtensions => 23
	i64 u0xe2e426c7714fa0bc, ; 1081: Microsoft.Win32.Primitives.dll => 4
	i64 u0xe2ee754535ca6dd6, ; 1082: SocialMauiApp => 0
	i64 u0xe332bacb3eb4a806, ; 1083: Mono.Android.Export.dll => 170
	i64 u0xe3811d68d4fe8463, ; 1084: pt-BR/Microsoft.Maui.Controls.resources.dll => 387
	i64 u0xe38e8ac420aab422, ; 1085: Microsoft.AspNetCore.Mvc.Core => 197
	i64 u0xe3b7cbae5ad66c75, ; 1086: lib_System.Security.Cryptography.Encoding.dll.so => 123
	i64 u0xe494f7ced4ecd10a, ; 1087: hu/Microsoft.Maui.Controls.resources.dll => 378
	i64 u0xe4a9b1e40d1e8917, ; 1088: lib-fi-Microsoft.Maui.Controls.resources.dll.so => 373
	i64 u0xe4f74a0b5bf9703f, ; 1089: System.Runtime.Serialization.Primitives => 114
	i64 u0xe5434e8a119ceb69, ; 1090: lib_Mono.Android.dll.so => 172
	i64 u0xe55703b9ce5c038a, ; 1091: System.Diagnostics.Tools => 32
	i64 u0xe57013c8afc270b5, ; 1092: Microsoft.VisualBasic => 3
	i64 u0xe57d22ca4aeb4900, ; 1093: System.Configuration.ConfigurationManager => 266
	i64 u0xe62913cc36bc07ec, ; 1094: System.Xml.dll => 164
	i64 u0xe79d45aa815dab7f, ; 1095: System.Runtime.Caching.dll => 272
	i64 u0xe7bea09c4900a191, ; 1096: Xamarin.AndroidX.VectorDrawable.dll => 345
	i64 u0xe7e03cc18dcdeb49, ; 1097: lib_System.Diagnostics.StackTrace.dll.so => 30
	i64 u0xe7e147ff99a7a380, ; 1098: lib_System.Configuration.dll.so => 19
	i64 u0xe7e7d98eda944101, ; 1099: Syncfusion.Maui.Sliders => 262
	i64 u0xe8397cf3948e7cb7, ; 1100: lib_Microsoft.Extensions.Options.ConfigurationExtensions.dll.so => 233
	i64 u0xe86b0df4ba9e5db8, ; 1101: lib_Xamarin.AndroidX.Lifecycle.Runtime.Android.dll.so => 320
	i64 u0xe896622fe0902957, ; 1102: System.Reflection.Emit.dll => 93
	i64 u0xe89a2a9ef110899b, ; 1103: System.Drawing.dll => 36
	i64 u0xe8c5f8c100b5934b, ; 1104: Microsoft.Win32.Registry => 5
	i64 u0xe957c3976986ab72, ; 1105: lib_Xamarin.AndroidX.Window.Extensions.Core.Core.dll.so => 351
	i64 u0xe98163eb702ae5c5, ; 1106: Xamarin.AndroidX.Arch.Core.Runtime => 288
	i64 u0xe994f23ba4c143e5, ; 1107: Xamarin.KotlinX.Coroutines.Android => 361
	i64 u0xe9b9c8c0458fd92a, ; 1108: System.Windows => 155
	i64 u0xe9d166d87a7f2bdb, ; 1109: lib_Xamarin.AndroidX.Startup.StartupRuntime.dll.so => 341
	i64 u0xea008206567504c4, ; 1110: Syncfusion.Maui.Toolkit => 263
	i64 u0xea5a4efc2ad81d1b, ; 1111: Xamarin.Google.ErrorProne.Annotations => 355
	i64 u0xeb2313fe9d65b785, ; 1112: Xamarin.AndroidX.ConstraintLayout.dll => 295
	i64 u0xeb6e275e78cb8d42, ; 1113: Xamarin.AndroidX.LocalBroadcastManager.dll => 328
	i64 u0xeb9e30ac32aac03e, ; 1114: lib_Microsoft.Win32.SystemEvents.dll.so => 250
	i64 u0xebc05bf326a78ad3, ; 1115: System.Windows.Extensions.dll => 275
	i64 u0xebdfa33cea4bfcea, ; 1116: SocialMediaMaui.Shared.dll => 404
	i64 u0xec14f495db71c005, ; 1117: en-US/Syncfusion.Maui.ImageEditor.resources.dll => 400
	i64 u0xec8abb68d340aac6, ; 1118: Microsoft.AspNetCore.Authorization => 185
	i64 u0xed19c616b3fcb7eb, ; 1119: Xamarin.AndroidX.VersionedParcelable.dll => 347
	i64 u0xed60c6fa891c051a, ; 1120: lib_Microsoft.VisualStudio.DesignTools.TapContract.dll.so => 403
	i64 u0xedc4817167106c23, ; 1121: System.Net.Sockets.dll => 76
	i64 u0xedc632067fb20ff3, ; 1122: System.Memory.dll => 63
	i64 u0xedc8e4ca71a02a8b, ; 1123: Xamarin.AndroidX.Navigation.Runtime.dll => 331
	i64 u0xee81f5b3f1c4f83b, ; 1124: System.Threading.ThreadPool => 147
	i64 u0xeeb7ebb80150501b, ; 1125: lib_Xamarin.AndroidX.Collection.Jvm.dll.so => 292
	i64 u0xeefc635595ef57f0, ; 1126: System.Security.Cryptography.Cng => 121
	i64 u0xef03b1b5a04e9709, ; 1127: System.Text.Encoding.CodePages.dll => 134
	i64 u0xef432781d5667f61, ; 1128: Xamarin.AndroidX.Print => 333
	i64 u0xef602c523fe2e87a, ; 1129: lib_Xamarin.Google.Guava.ListenableFuture.dll.so => 356
	i64 u0xef72742e1bcca27a, ; 1130: Microsoft.Maui.Essentials.dll => 246
	i64 u0xefd1e0c4e5c9b371, ; 1131: System.Resources.ResourceManager.dll => 100
	i64 u0xefe8f8d5ed3c72ea, ; 1132: System.Formats.Tar.dll => 39
	i64 u0xefec0b7fdc57ec42, ; 1133: Xamarin.AndroidX.Activity => 280
	i64 u0xf00c29406ea45e19, ; 1134: es/Microsoft.Maui.Controls.resources.dll => 372
	i64 u0xf020834425394c93, ; 1135: Microsoft.AspNetCore.ResponseCaching.Abstractions.dll => 198
	i64 u0xf038bf84c0c27e83, ; 1136: lib_Microsoft.AspNetCore.SignalR.Client.dll.so => 201
	i64 u0xf09e47b6ae914f6e, ; 1137: System.Net.NameResolution => 68
	i64 u0xf0ac2b489fed2e35, ; 1138: lib_System.Diagnostics.Debug.dll.so => 26
	i64 u0xf0bb49dadd3a1fe1, ; 1139: lib_System.Net.ServicePoint.dll.so => 75
	i64 u0xf0de2537ee19c6ca, ; 1140: lib_System.Net.WebHeaderCollection.dll.so => 78
	i64 u0xf1138779fa181c68, ; 1141: lib_Xamarin.AndroidX.Lifecycle.Runtime.dll.so => 319
	i64 u0xf11b621fc87b983f, ; 1142: Microsoft.Maui.Controls.Xaml.dll => 244
	i64 u0xf161f4f3c3b7e62c, ; 1143: System.Data => 24
	i64 u0xf16eb650d5a464bc, ; 1144: System.ValueTuple => 152
	i64 u0xf1c4b4005493d871, ; 1145: System.Formats.Asn1.dll => 38
	i64 u0xf238bd79489d3a96, ; 1146: lib-nl-Microsoft.Maui.Controls.resources.dll.so => 385
	i64 u0xf2feea356ba760af, ; 1147: Xamarin.AndroidX.Arch.Core.Runtime.dll => 288
	i64 u0xf300e085f8acd238, ; 1148: lib_System.ServiceProcess.dll.so => 133
	i64 u0xf34e52b26e7e059d, ; 1149: System.Runtime.CompilerServices.VisualC.dll => 103
	i64 u0xf37221fda4ef8830, ; 1150: lib_Xamarin.Google.Android.Material.dll.so => 352
	i64 u0xf3ad9b8fb3eefd12, ; 1151: lib_System.IO.UnmanagedMemoryStream.dll.so => 57
	i64 u0xf3ddfe05336abf29, ; 1152: System => 165
	i64 u0xf408654b2a135055, ; 1153: System.Reflection.Emit.ILGeneration.dll => 91
	i64 u0xf4103170a1de5bd0, ; 1154: System.Linq.Queryable.dll => 61
	i64 u0xf42ad2f4323b64d3, ; 1155: Microsoft.Net.Http.Headers.dll => 248
	i64 u0xf42d20c23173d77c, ; 1156: lib_System.ServiceModel.Web.dll.so => 132
	i64 u0xf4727d423e5d26f3, ; 1157: SkiaSharp => 254
	i64 u0xf4c1dd70a5496a17, ; 1158: System.IO.Compression => 46
	i64 u0xf4ecf4b9afc64781, ; 1159: System.ServiceProcess.dll => 133
	i64 u0xf4eeeaa566e9b970, ; 1160: lib_Xamarin.AndroidX.CustomView.PoolingContainer.dll.so => 302
	i64 u0xf518f63ead11fcd1, ; 1161: System.Threading.Tasks => 145
	i64 u0xf5e59d7ac34b50aa, ; 1162: Microsoft.IdentityModel.Protocols.dll => 240
	i64 u0xf5fc7602fe27b333, ; 1163: System.Net.WebHeaderCollection => 78
	i64 u0xf6077741019d7428, ; 1164: Xamarin.AndroidX.CoordinatorLayout => 297
	i64 u0xf61ade9836ad4692, ; 1165: Microsoft.IdentityModel.Tokens.dll => 242
	i64 u0xf64aa85b130b0651, ; 1166: lib_DocumentFormat.OpenXml.Framework.dll.so => 180
	i64 u0xf6742cbf457c450b, ; 1167: Xamarin.AndroidX.Lifecycle.Runtime.Android.dll => 320
	i64 u0xf6c0e7d55a7a4e4f, ; 1168: Microsoft.IdentityModel.JsonWebTokens => 238
	i64 u0xf6f893f692f8cb43, ; 1169: Microsoft.Extensions.Options.ConfigurationExtensions.dll => 233
	i64 u0xf70c0a7bf8ccf5af, ; 1170: System.Web => 154
	i64 u0xf77b20923f07c667, ; 1171: de/Microsoft.Maui.Controls.resources.dll => 370
	i64 u0xf7e2cac4c45067b3, ; 1172: lib_System.Numerics.Vectors.dll.so => 83
	i64 u0xf7e74930e0e3d214, ; 1173: zh-HK/Microsoft.Maui.Controls.resources.dll => 397
	i64 u0xf84773b5c81e3cef, ; 1174: lib-uk-Microsoft.Maui.Controls.resources.dll.so => 395
	i64 u0xf8aac5ea82de1348, ; 1175: System.Linq.Queryable => 61
	i64 u0xf8b77539b362d3ba, ; 1176: lib_System.Reflection.Primitives.dll.so => 96
	i64 u0xf8e045dc345b2ea3, ; 1177: lib_Xamarin.AndroidX.RecyclerView.dll.so => 335
	i64 u0xf915dc29808193a1, ; 1178: System.Web.HttpUtility.dll => 153
	i64 u0xf96c777a2a0686f4, ; 1179: hi/Microsoft.Maui.Controls.resources.dll => 376
	i64 u0xf9be54c8bcf8ff3b, ; 1180: System.Security.AccessControl.dll => 118
	i64 u0xf9eec5bb3a6aedc6, ; 1181: Microsoft.Extensions.Options => 232
	i64 u0xfa0e82300e67f913, ; 1182: lib_System.AppContext.dll.so => 6
	i64 u0xfa2fdb27e8a2c8e8, ; 1183: System.ComponentModel.EventBasedAsync => 15
	i64 u0xfa3f278f288b0e84, ; 1184: lib_System.Net.Security.dll.so => 74
	i64 u0xfa504dfa0f097d72, ; 1185: Microsoft.Extensions.FileProviders.Abstractions.dll => 225
	i64 u0xfa5ed7226d978949, ; 1186: lib-ar-Microsoft.Maui.Controls.resources.dll.so => 366
	i64 u0xfa645d91e9fc4cba, ; 1187: System.Threading.Thread => 146
	i64 u0xfad4d2c770e827f9, ; 1188: lib_System.IO.IsolatedStorage.dll.so => 52
	i64 u0xfb022853d73b7fa5, ; 1189: lib_SQLitePCLRaw.batteries_v2.dll.so => 255
	i64 u0xfb06dd2338e6f7c4, ; 1190: System.Net.Ping.dll => 70
	i64 u0xfb087abe5365e3b7, ; 1191: lib_System.Data.DataSetExtensions.dll.so => 23
	i64 u0xfb846e949baff5ea, ; 1192: System.Xml.Serialization.dll => 158
	i64 u0xfbad3e4ce4b98145, ; 1193: System.Security.Cryptography.X509Certificates => 126
	i64 u0xfbd71978549ea473, ; 1194: Microsoft.AspNetCore.Http.Features.dll => 195
	i64 u0xfbf0a31c9fc34bc4, ; 1195: lib_System.Net.Http.dll.so => 65
	i64 u0xfc61ddcf78dd1f54, ; 1196: Xamarin.AndroidX.LocalBroadcastManager => 328
	i64 u0xfc6b7527cc280b3f, ; 1197: lib_System.Runtime.Serialization.Formatters.dll.so => 112
	i64 u0xfc719aec26adf9d9, ; 1198: Xamarin.AndroidX.Navigation.Fragment.dll => 330
	i64 u0xfc82690c2fe2735c, ; 1199: Xamarin.AndroidX.Lifecycle.Process.dll => 318
	i64 u0xfc93fc307d279893, ; 1200: System.IO.Pipes.AccessControl.dll => 55
	i64 u0xfcd302092ada6328, ; 1201: System.IO.MemoryMappedFiles.dll => 53
	i64 u0xfd22f00870e40ae0, ; 1202: lib_Xamarin.AndroidX.DrawerLayout.dll.so => 304
	i64 u0xfd49b3c1a76e2748, ; 1203: System.Runtime.InteropServices.RuntimeInformation => 107
	i64 u0xfd536c702f64dc47, ; 1204: System.Text.Encoding.Extensions => 135
	i64 u0xfd583f7657b6a1cb, ; 1205: Xamarin.AndroidX.Fragment => 309
	i64 u0xfd8dd91a2c26bd5d, ; 1206: Xamarin.AndroidX.Lifecycle.Runtime => 319
	i64 u0xfda36abccf05cf5c, ; 1207: System.Net.WebSockets.Client => 80
	i64 u0xfdbe4710aa9beeff, ; 1208: CommunityToolkit.Maui => 176
	i64 u0xfddbe9695626a7f5, ; 1209: Xamarin.AndroidX.Lifecycle.Common => 313
	i64 u0xfeae9952cf03b8cb, ; 1210: tr/Microsoft.Maui.Controls.resources => 394
	i64 u0xfebe1950717515f9, ; 1211: Xamarin.AndroidX.Lifecycle.LiveData.Core.Ktx.dll => 317
	i64 u0xfedf9d23597e152d, ; 1212: lib_WinRT.Runtime.dll.so => 251
	i64 u0xff1a4e86e72b0140, ; 1213: Microsoft.AspNetCore.Authentication.Abstractions.dll => 183
	i64 u0xff270a55858bac8d, ; 1214: System.Security.Principal => 129
	i64 u0xff9b54613e0d2cc8, ; 1215: System.Net.Http.Json => 64
	i64 u0xffdb7a971be4ec73, ; 1216: System.ValueTuple.dll => 152
	i64 u0xfff40914e0b38d3d ; 1217: Azure.Identity.dll => 175
], align 16

@assembly_image_cache_indices = dso_local local_unnamed_addr constant [1218 x i32] [
	i32 42, i32 362, i32 342, i32 252, i32 13, i32 186, i32 203, i32 331,
	i32 177, i32 233, i32 105, i32 215, i32 171, i32 48, i32 285, i32 7,
	i32 258, i32 86, i32 390, i32 368, i32 396, i32 237, i32 305, i32 71,
	i32 335, i32 209, i32 12, i32 245, i32 102, i32 189, i32 209, i32 397,
	i32 156, i32 19, i32 310, i32 292, i32 161, i32 307, i32 345, i32 167,
	i32 390, i32 10, i32 230, i32 346, i32 174, i32 96, i32 302, i32 304,
	i32 13, i32 232, i32 10, i32 270, i32 127, i32 95, i32 214, i32 140,
	i32 208, i32 39, i32 391, i32 365, i32 205, i32 348, i32 387, i32 172,
	i32 279, i32 5, i32 246, i32 67, i32 339, i32 130, i32 207, i32 338,
	i32 306, i32 68, i32 293, i32 66, i32 188, i32 0, i32 57, i32 207,
	i32 301, i32 52, i32 260, i32 43, i32 180, i32 231, i32 125, i32 67,
	i32 81, i32 321, i32 403, i32 158, i32 92, i32 400, i32 99, i32 335,
	i32 241, i32 141, i32 151, i32 267, i32 289, i32 374, i32 162, i32 169,
	i32 375, i32 241, i32 220, i32 81, i32 403, i32 293, i32 202, i32 4,
	i32 5, i32 51, i32 101, i32 221, i32 260, i32 56, i32 120, i32 98,
	i32 168, i32 118, i32 362, i32 21, i32 378, i32 137, i32 97, i32 365,
	i32 77, i32 384, i32 253, i32 333, i32 341, i32 119, i32 189, i32 175,
	i32 8, i32 165, i32 393, i32 70, i32 278, i32 322, i32 336, i32 194,
	i32 222, i32 171, i32 145, i32 40, i32 339, i32 47, i32 30, i32 332,
	i32 382, i32 144, i32 232, i32 163, i32 28, i32 84, i32 343, i32 197,
	i32 77, i32 43, i32 274, i32 29, i32 42, i32 103, i32 117, i32 283,
	i32 265, i32 45, i32 91, i32 393, i32 56, i32 148, i32 402, i32 179,
	i32 146, i32 210, i32 100, i32 49, i32 20, i32 298, i32 114, i32 276,
	i32 374, i32 354, i32 255, i32 358, i32 234, i32 94, i32 58, i32 268,
	i32 379, i32 377, i32 81, i32 354, i32 169, i32 26, i32 71, i32 334,
	i32 252, i32 206, i32 223, i32 254, i32 308, i32 400, i32 401, i32 395,
	i32 69, i32 33, i32 275, i32 373, i32 14, i32 139, i32 268, i32 38,
	i32 399, i32 294, i32 206, i32 386, i32 134, i32 92, i32 88, i32 259,
	i32 149, i32 392, i32 24, i32 138, i32 57, i32 51, i32 371, i32 224,
	i32 29, i32 157, i32 249, i32 34, i32 164, i32 214, i32 227, i32 309,
	i32 237, i32 52, i32 405, i32 350, i32 90, i32 204, i32 290, i32 35,
	i32 374, i32 157, i32 9, i32 372, i32 76, i32 249, i32 55, i32 245,
	i32 368, i32 243, i32 13, i32 349, i32 216, i32 287, i32 109, i32 261,
	i32 325, i32 32, i32 104, i32 84, i32 92, i32 53, i32 96, i32 357,
	i32 58, i32 9, i32 102, i32 301, i32 68, i32 240, i32 186, i32 266,
	i32 348, i32 367, i32 225, i32 269, i32 125, i32 336, i32 116, i32 135,
	i32 242, i32 126, i32 106, i32 208, i32 358, i32 131, i32 194, i32 289,
	i32 356, i32 147, i32 156, i32 269, i32 310, i32 298, i32 255, i32 305,
	i32 336, i32 97, i32 190, i32 24, i32 340, i32 236, i32 143, i32 226,
	i32 333, i32 329, i32 175, i32 3, i32 266, i32 167, i32 286, i32 100,
	i32 161, i32 99, i32 25, i32 93, i32 168, i32 172, i32 281, i32 3,
	i32 386, i32 181, i32 307, i32 1, i32 114, i32 358, i32 184, i32 211,
	i32 310, i32 318, i32 268, i32 33, i32 6, i32 221, i32 390, i32 156,
	i32 270, i32 388, i32 53, i32 312, i32 205, i32 179, i32 274, i32 85,
	i32 248, i32 347, i32 332, i32 260, i32 44, i32 317, i32 104, i32 47,
	i32 198, i32 138, i32 265, i32 196, i32 64, i32 212, i32 327, i32 69,
	i32 80, i32 59, i32 89, i32 154, i32 265, i32 287, i32 133, i32 110,
	i32 380, i32 327, i32 334, i32 171, i32 203, i32 134, i32 140, i32 40,
	i32 367, i32 257, i32 218, i32 197, i32 242, i32 243, i32 60, i32 178,
	i32 218, i32 324, i32 79, i32 25, i32 36, i32 183, i32 99, i32 321,
	i32 71, i32 191, i32 22, i32 298, i32 247, i32 391, i32 121, i32 69,
	i32 107, i32 397, i32 328, i32 119, i32 117, i32 313, i32 314, i32 11,
	i32 2, i32 124, i32 115, i32 142, i32 41, i32 87, i32 282, i32 256,
	i32 173, i32 226, i32 27, i32 148, i32 218, i32 381, i32 219, i32 248,
	i32 355, i32 281, i32 1, i32 189, i32 283, i32 270, i32 44, i32 297,
	i32 149, i32 312, i32 18, i32 193, i32 86, i32 369, i32 41, i32 317,
	i32 291, i32 196, i32 322, i32 192, i32 94, i32 228, i32 28, i32 41,
	i32 199, i32 78, i32 306, i32 294, i32 144, i32 108, i32 292, i32 11,
	i32 105, i32 137, i32 16, i32 181, i32 122, i32 66, i32 157, i32 22,
	i32 257, i32 371, i32 364, i32 102, i32 231, i32 219, i32 363, i32 63,
	i32 58, i32 244, i32 370, i32 110, i32 173, i32 361, i32 9, i32 352,
	i32 120, i32 98, i32 251, i32 105, i32 271, i32 325, i32 176, i32 252,
	i32 243, i32 111, i32 284, i32 49, i32 20, i32 324, i32 267, i32 300,
	i32 193, i32 72, i32 296, i32 155, i32 39, i32 369, i32 35, i32 359,
	i32 38, i32 375, i32 257, i32 351, i32 108, i32 384, i32 21, i32 357,
	i32 213, i32 323, i32 273, i32 247, i32 15, i32 234, i32 79, i32 79,
	i32 300, i32 234, i32 303, i32 330, i32 338, i32 152, i32 21, i32 245,
	i32 368, i32 50, i32 51, i32 394, i32 384, i32 94, i32 277, i32 223,
	i32 380, i32 16, i32 203, i32 123, i32 377, i32 160, i32 45, i32 355,
	i32 0, i32 182, i32 179, i32 116, i32 63, i32 166, i32 222, i32 216,
	i32 187, i32 14, i32 337, i32 111, i32 284, i32 60, i32 360, i32 271,
	i32 121, i32 383, i32 2, i32 393, i32 274, i32 193, i32 309, i32 323,
	i32 404, i32 250, i32 227, i32 359, i32 323, i32 6, i32 291, i32 373,
	i32 305, i32 209, i32 238, i32 17, i32 391, i32 370, i32 77, i32 295,
	i32 177, i32 131, i32 357, i32 201, i32 383, i32 83, i32 230, i32 12,
	i32 34, i32 119, i32 364, i32 318, i32 307, i32 85, i32 276, i32 18,
	i32 195, i32 348, i32 217, i32 235, i32 316, i32 186, i32 72, i32 402,
	i32 95, i32 258, i32 165, i32 311, i32 82, i32 399, i32 231, i32 285,
	i32 290, i32 360, i32 154, i32 36, i32 151, i32 395, i32 237, i32 398,
	i32 144, i32 224, i32 56, i32 113, i32 212, i32 190, i32 254, i32 291,
	i32 345, i32 344, i32 261, i32 37, i32 399, i32 216, i32 115, i32 283,
	i32 14, i32 277, i32 262, i32 211, i32 146, i32 191, i32 43, i32 246,
	i32 281, i32 98, i32 363, i32 261, i32 168, i32 16, i32 48, i32 107,
	i32 194, i32 195, i32 97, i32 214, i32 259, i32 327, i32 205, i32 27,
	i32 128, i32 29, i32 375, i32 250, i32 184, i32 174, i32 225, i32 338,
	i32 128, i32 44, i32 213, i32 300, i32 306, i32 404, i32 149, i32 8,
	i32 188, i32 264, i32 235, i32 329, i32 376, i32 389, i32 256, i32 388,
	i32 132, i32 387, i32 199, i32 42, i32 364, i32 256, i32 33, i32 200,
	i32 405, i32 46, i32 143, i32 324, i32 244, i32 202, i32 315, i32 301,
	i32 138, i32 62, i32 132, i32 367, i32 48, i32 160, i32 288, i32 264,
	i32 315, i32 277, i32 313, i32 383, i32 344, i32 46, i32 164, i32 239,
	i32 311, i32 241, i32 239, i32 253, i32 372, i32 308, i32 236, i32 379,
	i32 247, i32 18, i32 8, i32 182, i32 299, i32 124, i32 59, i32 141,
	i32 178, i32 331, i32 382, i32 319, i32 240, i32 353, i32 350, i32 150,
	i32 142, i32 362, i32 359, i32 126, i32 361, i32 160, i32 162, i32 302,
	i32 280, i32 217, i32 251, i32 385, i32 26, i32 329, i32 316, i32 262,
	i32 235, i32 82, i32 187, i32 350, i32 127, i32 354, i32 101, i32 148,
	i32 352, i32 332, i32 54, i32 162, i32 167, i32 131, i32 37, i32 346,
	i32 382, i32 200, i32 222, i32 178, i32 22, i32 213, i32 112, i32 90,
	i32 303, i32 50, i32 60, i32 122, i32 83, i32 127, i32 163, i32 353,
	i32 166, i32 337, i32 339, i32 304, i32 276, i32 208, i32 320, i32 191,
	i32 4, i32 314, i32 204, i32 378, i32 170, i32 2, i32 325, i32 116,
	i32 238, i32 282, i32 19, i32 177, i32 229, i32 89, i32 65, i32 275,
	i32 30, i32 220, i32 371, i32 296, i32 59, i32 196, i32 202, i32 111,
	i32 316, i32 32, i32 128, i32 159, i32 389, i32 294, i32 140, i32 303,
	i32 385, i32 153, i32 17, i32 293, i32 279, i32 75, i32 74, i32 15,
	i32 169, i32 85, i32 360, i32 264, i32 124, i32 315, i32 326, i32 295,
	i32 392, i32 322, i32 34, i32 118, i32 139, i32 122, i32 106, i32 369,
	i32 402, i32 180, i32 346, i32 273, i32 290, i32 259, i32 376, i32 366,
	i32 54, i32 47, i32 28, i32 184, i32 206, i32 145, i32 229, i32 200,
	i32 147, i32 35, i32 392, i32 173, i32 227, i32 351, i32 75, i32 161,
	i32 1, i32 340, i32 388, i32 381, i32 159, i32 12, i32 155, i32 151,
	i32 190, i32 76, i32 236, i32 103, i32 112, i32 258, i32 287, i32 185,
	i32 272, i32 65, i32 66, i32 349, i32 45, i32 289, i32 109, i32 183,
	i32 198, i32 7, i32 267, i32 286, i32 55, i32 282, i32 64, i32 366,
	i32 299, i32 20, i32 109, i32 101, i32 62, i32 263, i32 142, i32 210,
	i32 185, i32 280, i32 7, i32 239, i32 381, i32 170, i32 50, i32 349,
	i32 115, i32 221, i32 141, i32 199, i32 182, i32 253, i32 166, i32 80,
	i32 113, i32 210, i32 326, i32 215, i32 224, i32 17, i32 73, i32 330,
	i32 89, i32 278, i32 87, i32 120, i32 201, i32 343, i32 284, i32 269,
	i32 135, i32 153, i32 106, i32 11, i32 90, i32 31, i32 176, i32 215,
	i32 394, i32 136, i32 386, i32 389, i32 341, i32 212, i32 279, i32 40,
	i32 405, i32 340, i32 207, i32 139, i32 181, i32 363, i32 365, i32 25,
	i32 192, i32 398, i32 73, i32 272, i32 311, i32 342, i32 174, i32 249,
	i32 27, i32 67, i32 88, i32 204, i32 95, i32 113, i32 31, i32 104,
	i32 314, i32 37, i32 223, i32 72, i32 273, i32 356, i32 108, i32 123,
	i32 286, i32 87, i32 228, i32 86, i32 380, i32 93, i32 211, i32 220,
	i32 129, i32 187, i32 326, i32 343, i32 230, i32 401, i32 337, i32 299,
	i32 342, i32 296, i32 353, i32 217, i32 163, i32 130, i32 229, i32 347,
	i32 334, i32 219, i32 10, i32 49, i32 396, i32 91, i32 396, i32 150,
	i32 62, i32 136, i32 150, i32 61, i32 228, i32 117, i32 137, i32 84,
	i32 312, i32 398, i32 159, i32 344, i32 143, i32 377, i32 308, i32 82,
	i32 271, i32 70, i32 188, i32 285, i32 263, i32 136, i32 297, i32 192,
	i32 278, i32 125, i32 401, i32 54, i32 110, i32 130, i32 88, i32 23,
	i32 74, i32 129, i32 31, i32 226, i32 73, i32 321, i32 379, i32 158,
	i32 23, i32 4, i32 0, i32 170, i32 387, i32 197, i32 123, i32 378,
	i32 373, i32 114, i32 172, i32 32, i32 3, i32 266, i32 164, i32 272,
	i32 345, i32 30, i32 19, i32 262, i32 233, i32 320, i32 93, i32 36,
	i32 5, i32 351, i32 288, i32 361, i32 155, i32 341, i32 263, i32 355,
	i32 295, i32 328, i32 250, i32 275, i32 404, i32 400, i32 185, i32 347,
	i32 403, i32 76, i32 63, i32 331, i32 147, i32 292, i32 121, i32 134,
	i32 333, i32 356, i32 246, i32 100, i32 39, i32 280, i32 372, i32 198,
	i32 201, i32 68, i32 26, i32 75, i32 78, i32 319, i32 244, i32 24,
	i32 152, i32 38, i32 385, i32 288, i32 133, i32 103, i32 352, i32 57,
	i32 165, i32 91, i32 61, i32 248, i32 132, i32 254, i32 46, i32 133,
	i32 302, i32 145, i32 240, i32 78, i32 297, i32 242, i32 180, i32 320,
	i32 238, i32 233, i32 154, i32 370, i32 83, i32 397, i32 395, i32 61,
	i32 96, i32 335, i32 153, i32 376, i32 118, i32 232, i32 6, i32 15,
	i32 74, i32 225, i32 366, i32 146, i32 52, i32 255, i32 70, i32 23,
	i32 158, i32 126, i32 195, i32 65, i32 328, i32 112, i32 330, i32 318,
	i32 55, i32 53, i32 304, i32 107, i32 135, i32 309, i32 319, i32 80,
	i32 176, i32 313, i32 394, i32 317, i32 251, i32 183, i32 129, i32 64,
	i32 152, i32 175
], align 16

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
@.str.0 = private unnamed_addr constant [40 x i8] c"get_function_pointer MUST be specified\0A\00", align 16

;MarshalMethodName
@.MarshalMethodName.0_name = private unnamed_addr constant [1 x i8] c"\00", align 1

; External functions

; Function attributes: noreturn "no-trapping-math"="true" nounwind "stack-protector-buffer-size"="8"
declare void @abort() local_unnamed_addr #2

; Function attributes: nofree nounwind
declare noundef i32 @puts(ptr noundef) local_unnamed_addr #1
attributes #0 = { memory(write, argmem: none, inaccessiblemem: none) "min-legal-vector-width"="0" mustprogress nofree norecurse nosync "no-trapping-math"="true" nounwind "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+crc32,+cx16,+cx8,+fxsr,+mmx,+popcnt,+sse,+sse2,+sse3,+sse4.1,+sse4.2,+ssse3,+x87" "tune-cpu"="generic" uwtable willreturn }
attributes #1 = { nofree nounwind }
attributes #2 = { noreturn "no-trapping-math"="true" nounwind "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+crc32,+cx16,+cx8,+fxsr,+mmx,+popcnt,+sse,+sse2,+sse3,+sse4.1,+sse4.2,+ssse3,+x87" "tune-cpu"="generic" }

; Metadata
!llvm.module.flags = !{!0, !1}
!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"PIC Level", i32 2}
!llvm.ident = !{!2}
!2 = !{!".NET for Android remotes/origin/release/9.0.1xx @ 1719a35b8a0348a4a8dd0061cfc4dd7fe6612a3c"}
!3 = !{!4, !4, i64 0}
!4 = !{!"any pointer", !5, i64 0}
!5 = !{!"omnipotent char", !6, i64 0}
!6 = !{!"Simple C++ TBAA"}
