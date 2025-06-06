; ModuleID = 'typemaps.arm64-v8a.ll'
source_filename = "typemaps.arm64-v8a.ll"
target datalayout = "e-m:e-i8:8:32-i16:16:32-i64:64-i128:128-n32:64-S128"
target triple = "aarch64-unknown-linux-android21"

%struct.TypeMapJava = type {
	i32, ; uint32_t module_index
	i32, ; uint32_t type_token_id
	i32 ; uint32_t java_name_index
}

%struct.TypeMapModule = type {
	[16 x i8], ; uint8_t module_uuid[16]
	i32, ; uint32_t entry_count
	i32, ; uint32_t duplicate_count
	ptr, ; TypeMapModuleEntry map
	ptr, ; TypeMapModuleEntry duplicate_map
	ptr, ; char* assembly_name
	ptr, ; MonoImage image
	i32, ; uint32_t java_name_width
	ptr ; uint8_t java_map
}

%struct.TypeMapModuleEntry = type {
	i32, ; uint32_t type_token_id
	i32 ; uint32_t java_map_index
}

@map_module_count = dso_local local_unnamed_addr constant i32 43, align 4

@java_type_count = dso_local local_unnamed_addr constant i32 1283, align 4

; Managed modules map
@map_modules = dso_local local_unnamed_addr global [43 x %struct.TypeMapModule] [
	%struct.TypeMapModule {
		[16 x i8] [ i8 u0x00, i8 u0x73, i8 u0x87, i8 u0x1b, i8 u0x6b, i8 u0x54, i8 u0x10, i8 u0x41, i8 u0xad, i8 u0x31, i8 u0x94, i8 u0x52, i8 u0x25, i8 u0x5a, i8 u0x3e, i8 u0x13 ], ; module_uuid: 1b877300-546b-4110-ad31-9452255a3e13
		i32 1, ; uint32_t entry_count
		i32 0, ; uint32_t duplicate_count
		ptr @module0_managed_to_java, ; TypeMapModuleEntry* map
		ptr null, ; TypeMapModuleEntry* duplicate_map
		ptr @.TypeMapModule.0_assembly_name, ; assembly_name: Xamarin.AndroidX.Lifecycle.ViewModelSavedState
		ptr null, ; MonoImage* image
		i32 0, ; uint32_t java_name_width
		ptr null; uint8_t* java_map
	}, ; 0
	%struct.TypeMapModule {
		[16 x i8] [ i8 u0x15, i8 u0x28, i8 u0xbe, i8 u0x12, i8 u0xf0, i8 u0x1e, i8 u0x4b, i8 u0x4e, i8 u0xbf, i8 u0x45, i8 u0x4b, i8 u0x9d, i8 u0xfd, i8 u0xff, i8 u0x3f, i8 u0xc1 ], ; module_uuid: 12be2815-1ef0-4e4b-bf45-4b9dfdff3fc1
		i32 14, ; uint32_t entry_count
		i32 0, ; uint32_t duplicate_count
		ptr @module1_managed_to_java, ; TypeMapModuleEntry* map
		ptr null, ; TypeMapModuleEntry* duplicate_map
		ptr @.TypeMapModule.1_assembly_name, ; assembly_name: Syncfusion.Maui.Toolkit
		ptr null, ; MonoImage* image
		i32 0, ; uint32_t java_name_width
		ptr null; uint8_t* java_map
	}, ; 1
	%struct.TypeMapModule {
		[16 x i8] [ i8 u0x1b, i8 u0xbd, i8 u0xcf, i8 u0x66, i8 u0xab, i8 u0x94, i8 u0x1f, i8 u0x4a, i8 u0xb9, i8 u0x8b, i8 u0x37, i8 u0x45, i8 u0x19, i8 u0xa8, i8 u0xa6, i8 u0xe4 ], ; module_uuid: 66cfbd1b-94ab-4a1f-b98b-374519a8a6e4
		i32 3, ; uint32_t entry_count
		i32 2, ; uint32_t duplicate_count
		ptr @module2_managed_to_java, ; TypeMapModuleEntry* map
		ptr @module2_managed_to_java_duplicates, ; TypeMapModuleEntry* duplicate_map
		ptr @.TypeMapModule.2_assembly_name, ; assembly_name: Xamarin.AndroidX.Lifecycle.LiveData.Core
		ptr null, ; MonoImage* image
		i32 0, ; uint32_t java_name_width
		ptr null; uint8_t* java_map
	}, ; 2
	%struct.TypeMapModule {
		[16 x i8] [ i8 u0x30, i8 u0x50, i8 u0x4e, i8 u0xc0, i8 u0xf8, i8 u0x82, i8 u0xe8, i8 u0x43, i8 u0xad, i8 u0x35, i8 u0xa3, i8 u0xe7, i8 u0x12, i8 u0xfa, i8 u0xe9, i8 u0x61 ], ; module_uuid: c04e5030-82f8-43e8-ad35-a3e712fae961
		i32 6, ; uint32_t entry_count
		i32 0, ; uint32_t duplicate_count
		ptr @module3_managed_to_java, ; TypeMapModuleEntry* map
		ptr null, ; TypeMapModuleEntry* duplicate_map
		ptr @.TypeMapModule.3_assembly_name, ; assembly_name: Xamarin.AndroidX.Security.SecurityCrypto
		ptr null, ; MonoImage* image
		i32 0, ; uint32_t java_name_width
		ptr null; uint8_t* java_map
	}, ; 3
	%struct.TypeMapModule {
		[16 x i8] [ i8 u0x39, i8 u0x5c, i8 u0x76, i8 u0xf3, i8 u0x1a, i8 u0x7d, i8 u0x5d, i8 u0x47, i8 u0x87, i8 u0xac, i8 u0x97, i8 u0x2c, i8 u0xf3, i8 u0xcc, i8 u0xf4, i8 u0x0c ], ; module_uuid: f3765c39-7d1a-475d-87ac-972cf3ccf40c
		i32 7, ; uint32_t entry_count
		i32 4, ; uint32_t duplicate_count
		ptr @module4_managed_to_java, ; TypeMapModuleEntry* map
		ptr @module4_managed_to_java_duplicates, ; TypeMapModuleEntry* duplicate_map
		ptr @.TypeMapModule.4_assembly_name, ; assembly_name: Xamarin.AndroidX.ViewPager
		ptr null, ; MonoImage* image
		i32 0, ; uint32_t java_name_width
		ptr null; uint8_t* java_map
	}, ; 4
	%struct.TypeMapModule {
		[16 x i8] [ i8 u0x44, i8 u0xe1, i8 u0x8a, i8 u0xe0, i8 u0x0a, i8 u0x29, i8 u0x3c, i8 u0x44, i8 u0xad, i8 u0xf0, i8 u0xce, i8 u0xb6, i8 u0x54, i8 u0x2c, i8 u0xb9, i8 u0x9e ], ; module_uuid: e08ae144-290a-443c-adf0-ceb6542cb99e
		i32 4, ; uint32_t entry_count
		i32 1, ; uint32_t duplicate_count
		ptr @module5_managed_to_java, ; TypeMapModuleEntry* map
		ptr @module5_managed_to_java_duplicates, ; TypeMapModuleEntry* duplicate_map
		ptr @.TypeMapModule.5_assembly_name, ; assembly_name: Xamarin.AndroidX.DrawerLayout
		ptr null, ; MonoImage* image
		i32 0, ; uint32_t java_name_width
		ptr null; uint8_t* java_map
	}, ; 5
	%struct.TypeMapModule {
		[16 x i8] [ i8 u0x45, i8 u0x09, i8 u0x02, i8 u0x14, i8 u0x68, i8 u0x15, i8 u0x7f, i8 u0x4d, i8 u0x85, i8 u0x5c, i8 u0x68, i8 u0x9e, i8 u0x9d, i8 u0x3f, i8 u0xce, i8 u0x8d ], ; module_uuid: 14020945-1568-4d7f-855c-689e9d3fce8d
		i32 25, ; uint32_t entry_count
		i32 19, ; uint32_t duplicate_count
		ptr @module6_managed_to_java, ; TypeMapModuleEntry* map
		ptr @module6_managed_to_java_duplicates, ; TypeMapModuleEntry* duplicate_map
		ptr @.TypeMapModule.6_assembly_name, ; assembly_name: Xamarin.Kotlin.StdLib
		ptr null, ; MonoImage* image
		i32 0, ; uint32_t java_name_width
		ptr null; uint8_t* java_map
	}, ; 6
	%struct.TypeMapModule {
		[16 x i8] [ i8 u0x4c, i8 u0x6c, i8 u0x1d, i8 u0x93, i8 u0x76, i8 u0x86, i8 u0x9f, i8 u0x4f, i8 u0x89, i8 u0x14, i8 u0x66, i8 u0x5a, i8 u0x4d, i8 u0x44, i8 u0x54, i8 u0x6b ], ; module_uuid: 931d6c4c-8676-4f9f-8914-665a4d44546b
		i32 3, ; uint32_t entry_count
		i32 1, ; uint32_t duplicate_count
		ptr @module7_managed_to_java, ; TypeMapModuleEntry* map
		ptr @module7_managed_to_java_duplicates, ; TypeMapModuleEntry* duplicate_map
		ptr @.TypeMapModule.7_assembly_name, ; assembly_name: Xamarin.AndroidX.CoordinatorLayout
		ptr null, ; MonoImage* image
		i32 0, ; uint32_t java_name_width
		ptr null; uint8_t* java_map
	}, ; 7
	%struct.TypeMapModule {
		[16 x i8] [ i8 u0x50, i8 u0xaa, i8 u0x09, i8 u0x2a, i8 u0xf0, i8 u0x0c, i8 u0x46, i8 u0x47, i8 u0xb7, i8 u0xf9, i8 u0x9d, i8 u0xb5, i8 u0x2d, i8 u0x99, i8 u0xc0, i8 u0xaf ], ; module_uuid: 2a09aa50-0cf0-4746-b7f9-9db52d99c0af
		i32 72, ; uint32_t entry_count
		i32 4, ; uint32_t duplicate_count
		ptr @module8_managed_to_java, ; TypeMapModuleEntry* map
		ptr @module8_managed_to_java_duplicates, ; TypeMapModuleEntry* duplicate_map
		ptr @.TypeMapModule.8_assembly_name, ; assembly_name: Microsoft.Maui
		ptr null, ; MonoImage* image
		i32 0, ; uint32_t java_name_width
		ptr null; uint8_t* java_map
	}, ; 8
	%struct.TypeMapModule {
		[16 x i8] [ i8 u0x58, i8 u0x87, i8 u0xba, i8 u0xf9, i8 u0x1d, i8 u0xc6, i8 u0x08, i8 u0x45, i8 u0x8b, i8 u0xc4, i8 u0x92, i8 u0xad, i8 u0xb5, i8 u0xed, i8 u0x18, i8 u0xa1 ], ; module_uuid: f9ba8758-c61d-4508-8bc4-92adb5ed18a1
		i32 1, ; uint32_t entry_count
		i32 0, ; uint32_t duplicate_count
		ptr @module9_managed_to_java, ; TypeMapModuleEntry* map
		ptr null, ; TypeMapModuleEntry* duplicate_map
		ptr @.TypeMapModule.9_assembly_name, ; assembly_name: Microsoft.Maui.Graphics
		ptr null, ; MonoImage* image
		i32 0, ; uint32_t java_name_width
		ptr null; uint8_t* java_map
	}, ; 9
	%struct.TypeMapModule {
		[16 x i8] [ i8 u0x68, i8 u0xa4, i8 u0xff, i8 u0x2f, i8 u0xd3, i8 u0x82, i8 u0x20, i8 u0x4e, i8 u0x86, i8 u0x02, i8 u0xa2, i8 u0xc1, i8 u0xbf, i8 u0xcd, i8 u0xee, i8 u0xb8 ], ; module_uuid: 2fffa468-82d3-4e20-8602-a2c1bfcdeeb8
		i32 7, ; uint32_t entry_count
		i32 1, ; uint32_t duplicate_count
		ptr @module10_managed_to_java, ; TypeMapModuleEntry* map
		ptr @module10_managed_to_java_duplicates, ; TypeMapModuleEntry* duplicate_map
		ptr @.TypeMapModule.10_assembly_name, ; assembly_name: Xamarin.AndroidX.Browser
		ptr null, ; MonoImage* image
		i32 0, ; uint32_t java_name_width
		ptr null; uint8_t* java_map
	}, ; 10
	%struct.TypeMapModule {
		[16 x i8] [ i8 u0x6d, i8 u0x4f, i8 u0x32, i8 u0xa3, i8 u0x1a, i8 u0xe2, i8 u0x47, i8 u0x49, i8 u0xb8, i8 u0x9e, i8 u0x18, i8 u0x15, i8 u0xab, i8 u0x66, i8 u0x2f, i8 u0xfe ], ; module_uuid: a3324f6d-e21a-4947-b89e-1815ab662ffe
		i32 6, ; uint32_t entry_count
		i32 1, ; uint32_t duplicate_count
		ptr @module11_managed_to_java, ; TypeMapModuleEntry* map
		ptr @module11_managed_to_java_duplicates, ; TypeMapModuleEntry* duplicate_map
		ptr @.TypeMapModule.11_assembly_name, ; assembly_name: Xamarin.AndroidX.Navigation.Runtime
		ptr null, ; MonoImage* image
		i32 0, ; uint32_t java_name_width
		ptr null; uint8_t* java_map
	}, ; 11
	%struct.TypeMapModule {
		[16 x i8] [ i8 u0x6d, i8 u0xaf, i8 u0x89, i8 u0xc0, i8 u0x18, i8 u0x01, i8 u0x90, i8 u0x4b, i8 u0xa9, i8 u0xff, i8 u0x9c, i8 u0x05, i8 u0xf1, i8 u0x4f, i8 u0xb8, i8 u0xed ], ; module_uuid: c089af6d-0118-4b90-a9ff-9c05f14fb8ed
		i32 5, ; uint32_t entry_count
		i32 3, ; uint32_t duplicate_count
		ptr @module12_managed_to_java, ; TypeMapModuleEntry* map
		ptr @module12_managed_to_java_duplicates, ; TypeMapModuleEntry* duplicate_map
		ptr @.TypeMapModule.12_assembly_name, ; assembly_name: Xamarin.AndroidX.Lifecycle.Common.Jvm
		ptr null, ; MonoImage* image
		i32 0, ; uint32_t java_name_width
		ptr null; uint8_t* java_map
	}, ; 12
	%struct.TypeMapModule {
		[16 x i8] [ i8 u0x71, i8 u0x79, i8 u0x9b, i8 u0x0c, i8 u0xac, i8 u0xb0, i8 u0x36, i8 u0x48, i8 u0x99, i8 u0x18, i8 u0x48, i8 u0x99, i8 u0xcb, i8 u0x87, i8 u0x0b, i8 u0x43 ], ; module_uuid: 0c9b7971-b0ac-4836-9918-4899cb870b43
		i32 9, ; uint32_t entry_count
		i32 5, ; uint32_t duplicate_count
		ptr @module13_managed_to_java, ; TypeMapModuleEntry* map
		ptr @module13_managed_to_java_duplicates, ; TypeMapModuleEntry* duplicate_map
		ptr @.TypeMapModule.13_assembly_name, ; assembly_name: Xamarin.AndroidX.Lifecycle.ViewModel.Android
		ptr null, ; MonoImage* image
		i32 0, ; uint32_t java_name_width
		ptr null; uint8_t* java_map
	}, ; 13
	%struct.TypeMapModule {
		[16 x i8] [ i8 u0x78, i8 u0x67, i8 u0x74, i8 u0xb5, i8 u0x94, i8 u0xe6, i8 u0x87, i8 u0x4f, i8 u0x9b, i8 u0x52, i8 u0x9a, i8 u0x7c, i8 u0x7f, i8 u0xaf, i8 u0x53, i8 u0x9e ], ; module_uuid: b5746778-e694-4f87-9b52-9a7c7faf539e
		i32 67, ; uint32_t entry_count
		i32 25, ; uint32_t duplicate_count
		ptr @module14_managed_to_java, ; TypeMapModuleEntry* map
		ptr @module14_managed_to_java_duplicates, ; TypeMapModuleEntry* duplicate_map
		ptr @.TypeMapModule.14_assembly_name, ; assembly_name: Xamarin.Google.Android.Material
		ptr null, ; MonoImage* image
		i32 0, ; uint32_t java_name_width
		ptr null; uint8_t* java_map
	}, ; 14
	%struct.TypeMapModule {
		[16 x i8] [ i8 u0x7e, i8 u0xa5, i8 u0x40, i8 u0x6b, i8 u0x27, i8 u0x47, i8 u0xb4, i8 u0x4b, i8 u0x80, i8 u0xb0, i8 u0xd8, i8 u0x55, i8 u0x0c, i8 u0x3e, i8 u0x21, i8 u0x1b ], ; module_uuid: 6b40a57e-4727-4bb4-80b0-d8550c3e211b
		i32 2, ; uint32_t entry_count
		i32 0, ; uint32_t duplicate_count
		ptr @module15_managed_to_java, ; TypeMapModuleEntry* map
		ptr null, ; TypeMapModuleEntry* duplicate_map
		ptr @.TypeMapModule.15_assembly_name, ; assembly_name: SocialMauiApp
		ptr null, ; MonoImage* image
		i32 0, ; uint32_t java_name_width
		ptr null; uint8_t* java_map
	}, ; 15
	%struct.TypeMapModule {
		[16 x i8] [ i8 u0x80, i8 u0xe0, i8 u0xdb, i8 u0xc8, i8 u0x3d, i8 u0x7a, i8 u0xad, i8 u0x4d, i8 u0xa8, i8 u0x0b, i8 u0x66, i8 u0xde, i8 u0xd0, i8 u0x2e, i8 u0x1c, i8 u0x83 ], ; module_uuid: c8dbe080-7a3d-4dad-a80b-66ded02e1c83
		i32 7, ; uint32_t entry_count
		i32 5, ; uint32_t duplicate_count
		ptr @module16_managed_to_java, ; TypeMapModuleEntry* map
		ptr @module16_managed_to_java_duplicates, ; TypeMapModuleEntry* duplicate_map
		ptr @.TypeMapModule.16_assembly_name, ; assembly_name: Xamarin.AndroidX.ViewPager2
		ptr null, ; MonoImage* image
		i32 0, ; uint32_t java_name_width
		ptr null; uint8_t* java_map
	}, ; 16
	%struct.TypeMapModule {
		[16 x i8] [ i8 u0x82, i8 u0xbd, i8 u0xd2, i8 u0xcc, i8 u0x10, i8 u0xfe, i8 u0xa2, i8 u0x40, i8 u0xb7, i8 u0xff, i8 u0xba, i8 u0x3e, i8 u0x66, i8 u0x56, i8 u0xfa, i8 u0x56 ], ; module_uuid: ccd2bd82-fe10-40a2-b7ff-ba3e6656fa56
		i32 39, ; uint32_t entry_count
		i32 0, ; uint32_t duplicate_count
		ptr @module17_managed_to_java, ; TypeMapModuleEntry* map
		ptr null, ; TypeMapModuleEntry* duplicate_map
		ptr @.TypeMapModule.17_assembly_name, ; assembly_name: Syncfusion.Maui.Core
		ptr null, ; MonoImage* image
		i32 0, ; uint32_t java_name_width
		ptr null; uint8_t* java_map
	}, ; 17
	%struct.TypeMapModule {
		[16 x i8] [ i8 u0x96, i8 u0x88, i8 u0x6a, i8 u0x19, i8 u0xa4, i8 u0x53, i8 u0x58, i8 u0x45, i8 u0x9e, i8 u0xce, i8 u0xd1, i8 u0xe8, i8 u0x3d, i8 u0x30, i8 u0xe7, i8 u0xc0 ], ; module_uuid: 196a8896-53a4-4558-9ece-d1e83d30e7c0
		i32 41, ; uint32_t entry_count
		i32 21, ; uint32_t duplicate_count
		ptr @module18_managed_to_java, ; TypeMapModuleEntry* map
		ptr @module18_managed_to_java_duplicates, ; TypeMapModuleEntry* duplicate_map
		ptr @.TypeMapModule.18_assembly_name, ; assembly_name: Xamarin.AndroidX.RecyclerView
		ptr null, ; MonoImage* image
		i32 0, ; uint32_t java_name_width
		ptr null; uint8_t* java_map
	}, ; 18
	%struct.TypeMapModule {
		[16 x i8] [ i8 u0x97, i8 u0x1c, i8 u0x5a, i8 u0x41, i8 u0x1a, i8 u0x60, i8 u0xbc, i8 u0x4c, i8 u0xa1, i8 u0xef, i8 u0xce, i8 u0x05, i8 u0x54, i8 u0x99, i8 u0x77, i8 u0x7d ], ; module_uuid: 415a1c97-601a-4cbc-a1ef-ce055499777d
		i32 13, ; uint32_t entry_count
		i32 6, ; uint32_t duplicate_count
		ptr @module19_managed_to_java, ; TypeMapModuleEntry* map
		ptr @module19_managed_to_java_duplicates, ; TypeMapModuleEntry* duplicate_map
		ptr @.TypeMapModule.19_assembly_name, ; assembly_name: Xamarin.AndroidX.Activity
		ptr null, ; MonoImage* image
		i32 0, ; uint32_t java_name_width
		ptr null; uint8_t* java_map
	}, ; 19
	%struct.TypeMapModule {
		[16 x i8] [ i8 u0x9e, i8 u0xa1, i8 u0x74, i8 u0xed, i8 u0xbe, i8 u0x02, i8 u0xd6, i8 u0x45, i8 u0x84, i8 u0x7a, i8 u0xac, i8 u0xd9, i8 u0xc0, i8 u0xa3, i8 u0xf6, i8 u0x23 ], ; module_uuid: ed74a19e-02be-45d6-847a-acd9c0a3f623
		i32 1, ; uint32_t entry_count
		i32 1, ; uint32_t duplicate_count
		ptr @module20_managed_to_java, ; TypeMapModuleEntry* map
		ptr @module20_managed_to_java_duplicates, ; TypeMapModuleEntry* duplicate_map
		ptr @.TypeMapModule.20_assembly_name, ; assembly_name: Xamarin.AndroidX.CursorAdapter
		ptr null, ; MonoImage* image
		i32 0, ; uint32_t java_name_width
		ptr null; uint8_t* java_map
	}, ; 20
	%struct.TypeMapModule {
		[16 x i8] [ i8 u0x9e, i8 u0xd0, i8 u0xab, i8 u0x8d, i8 u0x8a, i8 u0xae, i8 u0xcd, i8 u0x43, i8 u0x83, i8 u0x09, i8 u0xe2, i8 u0x35, i8 u0xfb, i8 u0x7c, i8 u0x26, i8 u0xab ], ; module_uuid: 8dabd09e-ae8a-43cd-8309-e235fb7c26ab
		i32 75, ; uint32_t entry_count
		i32 24, ; uint32_t duplicate_count
		ptr @module21_managed_to_java, ; TypeMapModuleEntry* map
		ptr @module21_managed_to_java_duplicates, ; TypeMapModuleEntry* duplicate_map
		ptr @.TypeMapModule.21_assembly_name, ; assembly_name: Xamarin.AndroidX.Core
		ptr null, ; MonoImage* image
		i32 0, ; uint32_t java_name_width
		ptr null; uint8_t* java_map
	}, ; 21
	%struct.TypeMapModule {
		[16 x i8] [ i8 u0xaf, i8 u0x43, i8 u0x82, i8 u0xe5, i8 u0x8f, i8 u0x4e, i8 u0xf0, i8 u0x40, i8 u0x91, i8 u0xeb, i8 u0x00, i8 u0xb9, i8 u0x04, i8 u0xdf, i8 u0x4f, i8 u0x3e ], ; module_uuid: e58243af-4e8f-40f0-91eb-00b904df4f3e
		i32 5, ; uint32_t entry_count
		i32 5, ; uint32_t duplicate_count
		ptr @module22_managed_to_java, ; TypeMapModuleEntry* map
		ptr @module22_managed_to_java_duplicates, ; TypeMapModuleEntry* duplicate_map
		ptr @.TypeMapModule.22_assembly_name, ; assembly_name: Xamarin.KotlinX.Coroutines.Core.Jvm
		ptr null, ; MonoImage* image
		i32 0, ; uint32_t java_name_width
		ptr null; uint8_t* java_map
	}, ; 22
	%struct.TypeMapModule {
		[16 x i8] [ i8 u0xba, i8 u0xb0, i8 u0x10, i8 u0x0a, i8 u0x8e, i8 u0xc2, i8 u0x1a, i8 u0x4a, i8 u0xb3, i8 u0xb2, i8 u0x66, i8 u0x24, i8 u0x14, i8 u0x88, i8 u0xb5, i8 u0x1b ], ; module_uuid: 0a10b0ba-c28e-4a1a-b3b2-66241488b51b
		i32 9, ; uint32_t entry_count
		i32 0, ; uint32_t duplicate_count
		ptr @module23_managed_to_java, ; TypeMapModuleEntry* map
		ptr null, ; TypeMapModuleEntry* duplicate_map
		ptr @.TypeMapModule.23_assembly_name, ; assembly_name: Microsoft.Maui.Essentials
		ptr null, ; MonoImage* image
		i32 0, ; uint32_t java_name_width
		ptr null; uint8_t* java_map
	}, ; 23
	%struct.TypeMapModule {
		[16 x i8] [ i8 u0xbb, i8 u0x4a, i8 u0x01, i8 u0xf7, i8 u0x3c, i8 u0x34, i8 u0xb9, i8 u0x41, i8 u0x8c, i8 u0xeb, i8 u0x74, i8 u0x2d, i8 u0xc7, i8 u0xd5, i8 u0x80, i8 u0x8c ], ; module_uuid: f7014abb-343c-41b9-8ceb-742dc7d5808c
		i32 1, ; uint32_t entry_count
		i32 0, ; uint32_t duplicate_count
		ptr @module24_managed_to_java, ; TypeMapModuleEntry* map
		ptr null, ; TypeMapModuleEntry* duplicate_map
		ptr @.TypeMapModule.24_assembly_name, ; assembly_name: Plugin.Fingerprint
		ptr null, ; MonoImage* image
		i32 0, ; uint32_t java_name_width
		ptr null; uint8_t* java_map
	}, ; 24
	%struct.TypeMapModule {
		[16 x i8] [ i8 u0xbf, i8 u0x8d, i8 u0x20, i8 u0x8b, i8 u0xce, i8 u0x92, i8 u0x9c, i8 u0x44, i8 u0x9f, i8 u0x49, i8 u0x4d, i8 u0x15, i8 u0xfd, i8 u0xac, i8 u0x48, i8 u0x67 ], ; module_uuid: 8b208dbf-92ce-449c-9f49-4d15fdac4867
		i32 59, ; uint32_t entry_count
		i32 20, ; uint32_t duplicate_count
		ptr @module25_managed_to_java, ; TypeMapModuleEntry* map
		ptr @module25_managed_to_java_duplicates, ; TypeMapModuleEntry* duplicate_map
		ptr @.TypeMapModule.25_assembly_name, ; assembly_name: Xamarin.AndroidX.AppCompat
		ptr null, ; MonoImage* image
		i32 0, ; uint32_t java_name_width
		ptr null; uint8_t* java_map
	}, ; 25
	%struct.TypeMapModule {
		[16 x i8] [ i8 u0xc5, i8 u0xac, i8 u0x2f, i8 u0xaa, i8 u0xf4, i8 u0x4c, i8 u0x88, i8 u0x4d, i8 u0xab, i8 u0xa0, i8 u0x33, i8 u0xa5, i8 u0x18, i8 u0x5e, i8 u0xa8, i8 u0xba ], ; module_uuid: aa2facc5-4cf4-4d88-aba0-33a5185ea8ba
		i32 10, ; uint32_t entry_count
		i32 9, ; uint32_t duplicate_count
		ptr @module26_managed_to_java, ; TypeMapModuleEntry* map
		ptr @module26_managed_to_java_duplicates, ; TypeMapModuleEntry* duplicate_map
		ptr @.TypeMapModule.26_assembly_name, ; assembly_name: Xamarin.KotlinX.Serialization.Core.Jvm
		ptr null, ; MonoImage* image
		i32 0, ; uint32_t java_name_width
		ptr null; uint8_t* java_map
	}, ; 26
	%struct.TypeMapModule {
		[16 x i8] [ i8 u0xcf, i8 u0x2f, i8 u0xa2, i8 u0x94, i8 u0xf8, i8 u0x7b, i8 u0x3d, i8 u0x4a, i8 u0xa1, i8 u0x2b, i8 u0x10, i8 u0x82, i8 u0x44, i8 u0xcf, i8 u0x73, i8 u0x49 ], ; module_uuid: 94a22fcf-7bf8-4a3d-a12b-108244cf7349
		i32 5, ; uint32_t entry_count
		i32 4, ; uint32_t duplicate_count
		ptr @module27_managed_to_java, ; TypeMapModuleEntry* map
		ptr @module27_managed_to_java_duplicates, ; TypeMapModuleEntry* duplicate_map
		ptr @.TypeMapModule.27_assembly_name, ; assembly_name: Xamarin.AndroidX.Loader
		ptr null, ; MonoImage* image
		i32 0, ; uint32_t java_name_width
		ptr null; uint8_t* java_map
	}, ; 27
	%struct.TypeMapModule {
		[16 x i8] [ i8 u0xcf, i8 u0x6a, i8 u0xb6, i8 u0xa5, i8 u0x9c, i8 u0xbe, i8 u0xce, i8 u0x4b, i8 u0xaa, i8 u0x08, i8 u0xfe, i8 u0x80, i8 u0x16, i8 u0x67, i8 u0x1d, i8 u0x70 ], ; module_uuid: a5b66acf-be9c-4bce-aa08-fe8016671d70
		i32 4, ; uint32_t entry_count
		i32 1, ; uint32_t duplicate_count
		ptr @module28_managed_to_java, ; TypeMapModuleEntry* map
		ptr @module28_managed_to_java_duplicates, ; TypeMapModuleEntry* duplicate_map
		ptr @.TypeMapModule.28_assembly_name, ; assembly_name: Xamarin.AndroidX.Navigation.UI
		ptr null, ; MonoImage* image
		i32 0, ; uint32_t java_name_width
		ptr null; uint8_t* java_map
	}, ; 28
	%struct.TypeMapModule {
		[16 x i8] [ i8 u0xdd, i8 u0xf6, i8 u0xfd, i8 u0xb3, i8 u0xe5, i8 u0xef, i8 u0x72, i8 u0x4f, i8 u0x8b, i8 u0x1d, i8 u0x03, i8 u0x63, i8 u0x27, i8 u0xd4, i8 u0x53, i8 u0x86 ], ; module_uuid: b3fdf6dd-efe5-4f72-8b1d-036327d45386
		i32 1, ; uint32_t entry_count
		i32 1, ; uint32_t duplicate_count
		ptr @module29_managed_to_java, ; TypeMapModuleEntry* map
		ptr @module29_managed_to_java_duplicates, ; TypeMapModuleEntry* duplicate_map
		ptr @.TypeMapModule.29_assembly_name, ; assembly_name: Xamarin.AndroidX.CustomView
		ptr null, ; MonoImage* image
		i32 0, ; uint32_t java_name_width
		ptr null; uint8_t* java_map
	}, ; 29
	%struct.TypeMapModule {
		[16 x i8] [ i8 u0xe2, i8 u0x1f, i8 u0x41, i8 u0x2a, i8 u0x72, i8 u0x2c, i8 u0xcc, i8 u0x47, i8 u0x84, i8 u0xb8, i8 u0x95, i8 u0xb4, i8 u0x91, i8 u0xa8, i8 u0x21, i8 u0xe6 ], ; module_uuid: 2a411fe2-2c72-47cc-84b8-95b491a821e6
		i32 3, ; uint32_t entry_count
		i32 0, ; uint32_t duplicate_count
		ptr @module30_managed_to_java, ; TypeMapModuleEntry* map
		ptr null, ; TypeMapModuleEntry* duplicate_map
		ptr @.TypeMapModule.30_assembly_name, ; assembly_name: Xamarin.AndroidX.Navigation.Fragment
		ptr null, ; MonoImage* image
		i32 0, ; uint32_t java_name_width
		ptr null; uint8_t* java_map
	}, ; 30
	%struct.TypeMapModule {
		[16 x i8] [ i8 u0xe3, i8 u0x19, i8 u0xfc, i8 u0xaa, i8 u0xce, i8 u0x87, i8 u0x6e, i8 u0x4b, i8 u0x92, i8 u0xf0, i8 u0xdb, i8 u0x31, i8 u0x33, i8 u0x50, i8 u0xc7, i8 u0xac ], ; module_uuid: aafc19e3-87ce-4b6e-92f0-db313350c7ac
		i32 3, ; uint32_t entry_count
		i32 0, ; uint32_t duplicate_count
		ptr @module31_managed_to_java, ; TypeMapModuleEntry* map
		ptr null, ; TypeMapModuleEntry* duplicate_map
		ptr @.TypeMapModule.31_assembly_name, ; assembly_name: CommunityToolkit.Maui.Core
		ptr null, ; MonoImage* image
		i32 0, ; uint32_t java_name_width
		ptr null; uint8_t* java_map
	}, ; 31
	%struct.TypeMapModule {
		[16 x i8] [ i8 u0xea, i8 u0x07, i8 u0x0c, i8 u0x83, i8 u0x5a, i8 u0xfa, i8 u0xc3, i8 u0x4c, i8 u0xa7, i8 u0x69, i8 u0xab, i8 u0xe6, i8 u0x89, i8 u0x8e, i8 u0xc0, i8 u0x56 ], ; module_uuid: 830c07ea-fa5a-4cc3-a769-abe6898ec056
		i32 11, ; uint32_t entry_count
		i32 2, ; uint32_t duplicate_count
		ptr @module32_managed_to_java, ; TypeMapModuleEntry* map
		ptr @module32_managed_to_java_duplicates, ; TypeMapModuleEntry* duplicate_map
		ptr @.TypeMapModule.32_assembly_name, ; assembly_name: Xamarin.AndroidX.Biometric
		ptr null, ; MonoImage* image
		i32 0, ; uint32_t java_name_width
		ptr null; uint8_t* java_map
	}, ; 32
	%struct.TypeMapModule {
		[16 x i8] [ i8 u0xeb, i8 u0xac, i8 u0x4a, i8 u0x5f, i8 u0x9a, i8 u0x7a, i8 u0x1d, i8 u0x4e, i8 u0x88, i8 u0x7b, i8 u0x9b, i8 u0xac, i8 u0x25, i8 u0xab, i8 u0xc0, i8 u0x68 ], ; module_uuid: 5f4aaceb-7a9a-4e1d-887b-9bac25abc068
		i32 2, ; uint32_t entry_count
		i32 1, ; uint32_t duplicate_count
		ptr @module33_managed_to_java, ; TypeMapModuleEntry* map
		ptr @module33_managed_to_java_duplicates, ; TypeMapModuleEntry* duplicate_map
		ptr @.TypeMapModule.33_assembly_name, ; assembly_name: Xamarin.AndroidX.SavedState
		ptr null, ; MonoImage* image
		i32 0, ; uint32_t java_name_width
		ptr null; uint8_t* java_map
	}, ; 33
	%struct.TypeMapModule {
		[16 x i8] [ i8 u0xec, i8 u0x79, i8 u0x89, i8 u0x4f, i8 u0x5b, i8 u0x27, i8 u0x82, i8 u0x4e, i8 u0x88, i8 u0x83, i8 u0x12, i8 u0xc8, i8 u0x96, i8 u0x09, i8 u0x2f, i8 u0xb6 ], ; module_uuid: 4f8979ec-275b-4e82-8883-12c896092fb6
		i32 107, ; uint32_t entry_count
		i32 0, ; uint32_t duplicate_count
		ptr @module34_managed_to_java, ; TypeMapModuleEntry* map
		ptr null, ; TypeMapModuleEntry* duplicate_map
		ptr @.TypeMapModule.34_assembly_name, ; assembly_name: Microsoft.Maui.Controls
		ptr null, ; MonoImage* image
		i32 0, ; uint32_t java_name_width
		ptr null; uint8_t* java_map
	}, ; 34
	%struct.TypeMapModule {
		[16 x i8] [ i8 u0xed, i8 u0x58, i8 u0x19, i8 u0x5e, i8 u0xc8, i8 u0x2f, i8 u0x77, i8 u0x42, i8 u0xae, i8 u0xc7, i8 u0x28, i8 u0xa8, i8 u0x98, i8 u0xc9, i8 u0x25, i8 u0x38 ], ; module_uuid: 5e1958ed-2fc8-4277-aec7-28a898c92538
		i32 30, ; uint32_t entry_count
		i32 19, ; uint32_t duplicate_count
		ptr @module35_managed_to_java, ; TypeMapModuleEntry* map
		ptr @module35_managed_to_java_duplicates, ; TypeMapModuleEntry* duplicate_map
		ptr @.TypeMapModule.35_assembly_name, ; assembly_name: Xamarin.Google.Crypto.Tink.Android
		ptr null, ; MonoImage* image
		i32 0, ; uint32_t java_name_width
		ptr null; uint8_t* java_map
	}, ; 35
	%struct.TypeMapModule {
		[16 x i8] [ i8 u0xf0, i8 u0x70, i8 u0x03, i8 u0x46, i8 u0x96, i8 u0x7a, i8 u0x2a, i8 u0x40, i8 u0xb7, i8 u0x96, i8 u0x14, i8 u0x14, i8 u0x3a, i8 u0x2b, i8 u0x76, i8 u0xea ], ; module_uuid: 460370f0-7a96-402a-b796-14143a2b76ea
		i32 580, ; uint32_t entry_count
		i32 215, ; uint32_t duplicate_count
		ptr @module36_managed_to_java, ; TypeMapModuleEntry* map
		ptr @module36_managed_to_java_duplicates, ; TypeMapModuleEntry* duplicate_map
		ptr @.TypeMapModule.36_assembly_name, ; assembly_name: Mono.Android
		ptr null, ; MonoImage* image
		i32 0, ; uint32_t java_name_width
		ptr null; uint8_t* java_map
	}, ; 36
	%struct.TypeMapModule {
		[16 x i8] [ i8 u0xf0, i8 u0xb0, i8 u0xf0, i8 u0xf0, i8 u0x84, i8 u0xb1, i8 u0x30, i8 u0x49, i8 u0x89, i8 u0xe8, i8 u0xd2, i8 u0xe3, i8 u0xa7, i8 u0xd1, i8 u0xbf, i8 u0x13 ], ; module_uuid: f0f0b0f0-b184-4930-89e8-d2e3a7d1bf13
		i32 17, ; uint32_t entry_count
		i32 6, ; uint32_t duplicate_count
		ptr @module37_managed_to_java, ; TypeMapModuleEntry* map
		ptr @module37_managed_to_java_duplicates, ; TypeMapModuleEntry* duplicate_map
		ptr @.TypeMapModule.37_assembly_name, ; assembly_name: Xamarin.AndroidX.Navigation.Common
		ptr null, ; MonoImage* image
		i32 0, ; uint32_t java_name_width
		ptr null; uint8_t* java_map
	}, ; 37
	%struct.TypeMapModule {
		[16 x i8] [ i8 u0xf1, i8 u0x9b, i8 u0x36, i8 u0x4f, i8 u0x66, i8 u0x3e, i8 u0xfb, i8 u0x49, i8 u0xb5, i8 u0x15, i8 u0x91, i8 u0xa9, i8 u0xa6, i8 u0xce, i8 u0xa1, i8 u0xc2 ], ; module_uuid: 4f369bf1-3e66-49fb-b515-91a9a6cea1c2
		i32 20, ; uint32_t entry_count
		i32 10, ; uint32_t duplicate_count
		ptr @module38_managed_to_java, ; TypeMapModuleEntry* map
		ptr @module38_managed_to_java_duplicates, ; TypeMapModuleEntry* duplicate_map
		ptr @.TypeMapModule.38_assembly_name, ; assembly_name: Xamarin.AndroidX.Fragment
		ptr null, ; MonoImage* image
		i32 0, ; uint32_t java_name_width
		ptr null; uint8_t* java_map
	}, ; 38
	%struct.TypeMapModule {
		[16 x i8] [ i8 u0xf6, i8 u0x61, i8 u0xa9, i8 u0x62, i8 u0xb2, i8 u0xfb, i8 u0x6d, i8 u0x4e, i8 u0xa4, i8 u0xf8, i8 u0x84, i8 u0xdb, i8 u0xeb, i8 u0x61, i8 u0xab, i8 u0x87 ], ; module_uuid: 62a961f6-fbb2-4e6d-a4f8-84dbeb61ab87
		i32 2, ; uint32_t entry_count
		i32 0, ; uint32_t duplicate_count
		ptr @module39_managed_to_java, ; TypeMapModuleEntry* map
		ptr null, ; TypeMapModuleEntry* duplicate_map
		ptr @.TypeMapModule.39_assembly_name, ; assembly_name: Xamarin.AndroidX.AppCompat.AppCompatResources
		ptr null, ; MonoImage* image
		i32 0, ; uint32_t java_name_width
		ptr null; uint8_t* java_map
	}, ; 39
	%struct.TypeMapModule {
		[16 x i8] [ i8 u0xf9, i8 u0xa2, i8 u0x1b, i8 u0x81, i8 u0x88, i8 u0xa0, i8 u0xfa, i8 u0x44, i8 u0xa4, i8 u0xff, i8 u0xc7, i8 u0xd6, i8 u0xb9, i8 u0x06, i8 u0xb1, i8 u0xef ], ; module_uuid: 811ba2f9-a088-44fa-a4ff-c7d6b906b1ef
		i32 1, ; uint32_t entry_count
		i32 0, ; uint32_t duplicate_count
		ptr @module40_managed_to_java, ; TypeMapModuleEntry* map
		ptr null, ; TypeMapModuleEntry* duplicate_map
		ptr @.TypeMapModule.40_assembly_name, ; assembly_name: Xamarin.AndroidX.Collection.Jvm
		ptr null, ; MonoImage* image
		i32 0, ; uint32_t java_name_width
		ptr null; uint8_t* java_map
	}, ; 40
	%struct.TypeMapModule {
		[16 x i8] [ i8 u0xf9, i8 u0xf1, i8 u0x00, i8 u0x54, i8 u0x1e, i8 u0xae, i8 u0xbf, i8 u0x41, i8 u0x9a, i8 u0xb8, i8 u0x76, i8 u0x88, i8 u0x03, i8 u0xb7, i8 u0xf0, i8 u0x49 ], ; module_uuid: 5400f1f9-ae1e-41bf-9ab8-768803b7f049
		i32 4, ; uint32_t entry_count
		i32 2, ; uint32_t duplicate_count
		ptr @module41_managed_to_java, ; TypeMapModuleEntry* map
		ptr @module41_managed_to_java_duplicates, ; TypeMapModuleEntry* duplicate_map
		ptr @.TypeMapModule.41_assembly_name, ; assembly_name: Xamarin.AndroidX.SwipeRefreshLayout
		ptr null, ; MonoImage* image
		i32 0, ; uint32_t java_name_width
		ptr null; uint8_t* java_map
	}, ; 41
	%struct.TypeMapModule {
		[16 x i8] [ i8 u0xfd, i8 u0x91, i8 u0x8b, i8 u0x46, i8 u0xc9, i8 u0xc0, i8 u0x04, i8 u0x40, i8 u0x95, i8 u0x62, i8 u0x23, i8 u0xe9, i8 u0xf5, i8 u0xe7, i8 u0xf0, i8 u0xb0 ], ; module_uuid: 468b91fd-c0c9-4004-9562-23e9f5e7f0b0
		i32 1, ; uint32_t entry_count
		i32 0, ; uint32_t duplicate_count
		ptr @module42_managed_to_java, ; TypeMapModuleEntry* map
		ptr null, ; TypeMapModuleEntry* duplicate_map
		ptr @.TypeMapModule.42_assembly_name, ; assembly_name: Xamarin.AndroidX.CardView
		ptr null, ; MonoImage* image
		i32 0, ; uint32_t java_name_width
		ptr null; uint8_t* java_map
	} ; 42
], align 8

; Java types name hashes
@map_java_hashes = dso_local local_unnamed_addr constant [1283 x i64] [
	i64 u0x00063287e4c20d8e, ; 0 => android/widget/AbsListView$OnScrollListener
	i64 u0x00372cd76802b508, ; 1 => com/google/android/material/navigation/NavigationView$OnNavigationItemSelectedListener
	i64 u0x0054e7b33c6d2262, ; 2 => com/google/android/material/bottomnavigation/BottomNavigationView
	i64 u0x00734c8bf6bec5f5, ; 3 => androidx/biometric/BiometricViewModel
	i64 u0x00acd1e6ad3a3aeb, ; 4 => androidx/core/view/autofill/AutofillIdCompat
	i64 u0x013d70f30586d278, ; 5 => javax/net/ssl/KeyManagerFactory
	i64 u0x017c0bbcb46cf6dd, ; 6 => android/widget/AutoCompleteTextView
	i64 u0x01a16e6c243bd5d5, ; 7 => mono/com/google/android/material/navigation/NavigationBarView_OnItemSelectedListenerImplementor
	i64 u0x01afc15612f0c88a, ; 8 => com/google/android/material/tabs/TabLayoutMediator$TabConfigurationStrategy
	i64 u0x01beb04ccd88502c, ; 9 => java/util/ListIterator
	i64 u0x01cd624f1e38cc9f, ; 10 => java/lang/Byte
	i64 u0x020b1cbd9e125d93, ; 11 => crc645d80431ce5f73f11/SimpleViewHolder
	i64 u0x0286e891cbd384d2, ; 12 => crc640ec207abc449b2ca/ShellSearchView
	i64 u0x02e426fc27cd6822, ; 13 => android/provider/MediaStore$Images$Media
	i64 u0x0304e457b1d15194, ; 14 => android/view/ViewGroup$MarginLayoutParams
	i64 u0x0318f6ff5c94fca0, ; 15 => androidx/navigation/NavDeepLinkBuilder
	i64 u0x0322801148f8b287, ; 16 => androidx/activity/result/contract/ActivityResultContract$SynchronousResult
	i64 u0x03b201bf817739ef, ; 17 => java/util/TimerTask
	i64 u0x03cc98b851d4262c, ; 18 => javax/net/ssl/SSLContext
	i64 u0x04048be4ab87bfe3, ; 19 => com/google/android/material/appbar/AppBarLayout$ScrollingViewBehavior
	i64 u0x041aa4da751eea19, ; 20 => android/text/style/CharacterStyle
	i64 u0x04a9190501fc149a, ; 21 => java/lang/reflect/AccessibleObject
	i64 u0x052f7633c840a026, ; 22 => mono/androidx/appcompat/widget/SearchView_OnCloseListenerImplementor
	i64 u0x0577cfd0edc0d47c, ; 23 => android/view/View$OnFocusChangeListener
	i64 u0x05dce036569f9c03, ; 24 => androidx/lifecycle/LiveData
	i64 u0x067b9514e9165133, ; 25 => crc64fcf28c0e24b4cc31/ButtonHandler_ButtonClickListener
	i64 u0x06c347d38116f240, ; 26 => android/content/res/TypedArray
	i64 u0x06f84afe4273c430, ; 27 => java/net/InetSocketAddress
	i64 u0x0739ad5d57f8f5c2, ; 28 => androidx/appcompat/widget/AppCompatImageView
	i64 u0x07ccfc99029994fb, ; 29 => androidx/recyclerview/widget/RecyclerView$ItemAnimator$ItemHolderInfo
	i64 u0x07ede16120373a51, ; 30 => androidx/appcompat/view/menu/SubMenuBuilder
	i64 u0x083e83bb2321dd50, ; 31 => java/util/Random
	i64 u0x084bde0945f24428, ; 32 => androidx/navigation/fragment/FragmentNavigator$Destination
	i64 u0x087fb80a227e5598, ; 33 => android/view/OrientationEventListener
	i64 u0x08ba5597603eed52, ; 34 => androidx/core/view/WindowInsetsAnimationControlListenerCompat
	i64 u0x0905261267c34df0, ; 35 => mono/android/content/DialogInterface_OnShowListenerImplementor
	i64 u0x0909c0d22f42a50c, ; 36 => android/security/KeyStoreException
	i64 u0x094bbc5afd8d66c7, ; 37 => com/google/android/material/appbar/AppBarLayout$BaseBehavior$BaseDragCallback
	i64 u0x09b247fe94b37abd, ; 38 => mono/android/view/animation/Animation_AnimationListenerImplementor
	i64 u0x09df54a3005226e6, ; 39 => crc640ec207abc449b2ca/ContainerView
	i64 u0x09f386b034c10e2a, ; 40 => java/util/function/IntFunction
	i64 u0x0a0991adfec5ebd3, ; 41 => mono/android/animation/ValueAnimator_AnimatorUpdateListenerImplementor
	i64 u0x0a364502506e12a9, ; 42 => android/os/CancellationSignal
	i64 u0x0a49aab6fb8903b8, ; 43 => android/app/ActionBar
	i64 u0x0a8602f2e894a9bc, ; 44 => crc64e1fb321c08285b90/ListViewAdapter
	i64 u0x0a8a26238002df46, ; 45 => crc6452ffdc5b34af3a0f/MauiScrollView
	i64 u0x0ab77b7a4f03d9cf, ; 46 => android/widget/Adapter
	i64 u0x0adc614c080c1813, ; 47 => androidx/biometric/BiometricManager
	i64 u0x0aeeacad96ad560e, ; 48 => android/renderscript/Allocation$MipmapControl
	i64 u0x0af6bbc9a990389a, ; 49 => androidx/recyclerview/widget/RecyclerView$ViewCacheExtension
	i64 u0x0b0564f1b7e44272, ; 50 => crc6452ffdc5b34af3a0f/StackNavigationManager_Callbacks
	i64 u0x0b1da699fb29019a, ; 51 => android/os/BaseBundle
	i64 u0x0b3678817eae3b5c, ; 52 => androidx/biometric/BiometricPrompt$AuthenticationResult
	i64 u0x0b6d47b337d450b1, ; 53 => androidx/lifecycle/viewmodel/ViewModelInitializer
	i64 u0x0b821ae2cca6f82f, ; 54 => android/content/DialogInterface$OnCancelListener
	i64 u0x0b95dc6056abf25b, ; 55 => android/widget/FrameLayout
	i64 u0x0c44130caa233945, ; 56 => mono/android/runtime/JavaObject
	i64 u0x0c6bd98168627900, ; 57 => android/text/InputFilter
	i64 u0x0c85b86a8e0eff58, ; 58 => com/google/android/material/appbar/HeaderBehavior
	i64 u0x0d9335f0988cd796, ; 59 => java/util/HashMap
	i64 u0x0d9e37c6bdb77f79, ; 60 => crc645d80431ce5f73f11/SimpleItemTouchHelperCallback
	i64 u0x0e38d8eb3df32a4b, ; 61 => com/google/android/material/bottomnavigation/BottomNavigationView$OnNavigationItemSelectedListener
	i64 u0x0e69182a0612bdd6, ; 62 => android/content/DialogInterface$OnDismissListener
	i64 u0x0e9385169570cf56, ; 63 => android/graphics/ColorMatrix
	i64 u0x0e96356971bc08ab, ; 64 => androidx/security/crypto/MasterKey$Builder
	i64 u0x0ec3cd3f9f5973bd, ; 65 => android/graphics/drawable/GradientDrawable$Orientation
	i64 u0x0ed9459c549526c1, ; 66 => androidx/core/view/accessibility/AccessibilityNodeInfoCompat
	i64 u0x0eda567aa6841ee4, ; 67 => android/graphics/Region$Op
	i64 u0x0ee5ee864926cdee, ; 68 => android/graphics/Path$FillType
	i64 u0x0f17a8f7ec719595, ; 69 => com/google/android/material/tabs/TabLayout$TabView
	i64 u0x0f3fd32f189104c9, ; 70 => com/google/android/material/appbar/ViewOffsetBehavior
	i64 u0x0f76e24fc1b42556, ; 71 => android/text/SpannableStringInternal
	i64 u0x0fbb00760377c24f, ; 72 => kotlinx/coroutines/flow/FlowCollector
	i64 u0x0fbc66cd2b1b4e77, ; 73 => androidx/recyclerview/widget/ItemTouchHelper
	i64 u0x0fbd1a2d794a9718, ; 74 => android/widget/ListAdapter
	i64 u0x0fc3f48bd51825ba, ; 75 => androidx/recyclerview/widget/LinearSnapHelper
	i64 u0x0fde55aa845991e2, ; 76 => android/graphics/drawable/Drawable$ConstantState
	i64 u0x0fdf6e61cfd83719, ; 77 => crc64fcf28c0e24b4cc31/ButtonHandler_ButtonTouchListener
	i64 u0x1014bd1f67aeb8ec, ; 78 => crc64e1fb321c08285b90/ListViewRenderer_SwipeRefreshLayoutWithFixedNestedScrolling
	i64 u0x102731205d6f1f1c, ; 79 => android/graphics/Path
	i64 u0x103d8579c39974d7, ; 80 => androidx/core/view/DisplayCutoutCompat
	i64 u0x1050b555cc009f77, ; 81 => crc6452ffdc5b34af3a0f/MauiSwipeView
	i64 u0x106be7c89662702e, ; 82 => java/net/Proxy$Type
	i64 u0x107b4c2c21d9edc5, ; 83 => android/os/PersistableBundle
	i64 u0x109c056c6dd543bd, ; 84 => crc6452ffdc5b34af3a0f/MauiMaterialButton_MauiResizableDrawable
	i64 u0x10c9b82608fa3cb1, ; 85 => crc64b5e713d400f589b7/MauiDrawable
	i64 u0x10cc64dc53558d33, ; 86 => android/content/ComponentName
	i64 u0x10e015905ca8bd0f, ; 87 => java/security/cert/Certificate
	i64 u0x10e1dea8929df694, ; 88 => android/graphics/drawable/DrawableContainer
	i64 u0x110217f9f8accd72, ; 89 => android/view/WindowInsetsController
	i64 u0x1129f447a445239d, ; 90 => crc64fcf28c0e24b4cc31/HybridWebViewHandler_HybridWebViewJavaScriptInterface
	i64 u0x116532ec07ee0771, ; 91 => java/security/spec/KeySpec
	i64 u0x116c2eefcbe49da3, ; 92 => crc645d80431ce5f73f11/SelectableItemsViewAdapter_2
	i64 u0x1180f07c8e6b509c, ; 93 => android/graphics/drawable/GradientDrawable
	i64 u0x11b3df35e5eac800, ; 94 => androidx/appcompat/app/ActionBar$OnNavigationListener
	i64 u0x11cef49ec24439a7, ; 95 => androidx/core/graphics/Insets
	i64 u0x11d17bb5232d3c3a, ; 96 => android/view/ContentInfo
	i64 u0x11ea3ec2f9841e81, ; 97 => android/view/View$OnLayoutChangeListener
	i64 u0x126fd2f9b666ff17, ; 98 => android/text/style/MetricAffectingSpan
	i64 u0x1280a30643599898, ; 99 => androidx/recyclerview/widget/SnapHelper
	i64 u0x12c273589e7bbe16, ; 100 => android/view/DragEvent
	i64 u0x12d291163c1f15a6, ; 101 => crc64e1fb321c08285b90/EntryCellView
	i64 u0x12f689238a395eea, ; 102 => androidx/appcompat/widget/SearchView$OnSuggestionListener
	i64 u0x13325e9f8e28a522, ; 103 => mono/androidx/viewpager/widget/ViewPager_OnPageChangeListenerImplementor
	i64 u0x1344670b61795353, ; 104 => crc64159f3caeb1269279/MauiDrawingView
	i64 u0x134fb5354fb590b7, ; 105 => kotlin/reflect/KCallable
	i64 u0x1377bd48a9f09d19, ; 106 => androidx/recyclerview/widget/RecyclerView$OnScrollListener
	i64 u0x13be6b0dbad58d9c, ; 107 => crc64354973402314325c/CustomImageView
	i64 u0x13e5902d3b855db6, ; 108 => javax/net/ssl/TrustManagerFactory
	i64 u0x13e7a20cea38d010, ; 109 => kotlin/reflect/KFunction
	i64 u0x146350135c295cb0, ; 110 => android/animation/Animator$AnimatorListener
	i64 u0x14967cd55ee6609b, ; 111 => android/graphics/BitmapShader
	i64 u0x150e9f9d467462d4, ; 112 => java/io/RandomAccessFile
	i64 u0x1556d5a2db34c54b, ; 113 => crc64f5844edce43316e7/OnTouchListener
	i64 u0x15682bdd2dfb6d3f, ; 114 => android/widget/RemoteViews
	i64 u0x15771589264f32c6, ; 115 => java/util/List
	i64 u0x1644b711fd942b58, ; 116 => crc645d80431ce5f73f11/EdgeSnapHelper
	i64 u0x16698ccdb078d100, ; 117 => androidx/core/app/ActivityOptionsCompat
	i64 u0x167be582da7ac6ee, ; 118 => android/view/WindowInsetsController$OnControllableInsetsChangedListener
	i64 u0x16b07129ee36476e, ; 119 => android/os/PowerManager
	i64 u0x16c70a05a8455695, ; 120 => android/view/inputmethod/InputMethodManager
	i64 u0x1709693bced8b619, ; 121 => android/view/animation/Animation
	i64 u0x1759b71b41bc5f1b, ; 122 => android/content/pm/PackageItemInfo
	i64 u0x176fd822b3e49dca, ; 123 => crc649c9364508479c7e4/NativeSnapLayout_FlingGestureListener
	i64 u0x17948f96f25227f0, ; 124 => crc64f728827fec74e9c3/Toolbar_Container
	i64 u0x17baebf9734ef906, ; 125 => kotlinx/serialization/KSerializer
	i64 u0x17e1aa318b621d80, ; 126 => androidx/lifecycle/LifecycleOwner
	i64 u0x1830778aad99d496, ; 127 => androidx/lifecycle/ViewModelProvider
	i64 u0x1895f55b7520a32a, ; 128 => android/view/accessibility/AccessibilityNodeInfo$ExtraRenderingInfo
	i64 u0x18c2a1de38f367ba, ; 129 => crc64e1fb321c08285b90/TableViewModelRenderer
	i64 u0x190f07cff0012f30, ; 130 => crc64e1fb321c08285b90/ListViewRenderer_ListViewSwipeRefreshLayoutListener
	i64 u0x193ea5b13d78ca47, ; 131 => androidx/appcompat/view/menu/MenuPresenter
	i64 u0x1950fac852291891, ; 132 => android/view/WindowInsetsAnimationControlListener
	i64 u0x19f3c4c90080c938, ; 133 => com/microsoft/maui/BuildConfig
	i64 u0x1a0754d23187e313, ; 134 => crc6479d6f9e48582dc67/GestureDetector_ScrollListener
	i64 u0x1a49d63abc7952ea, ; 135 => android/webkit/MimeTypeMap
	i64 u0x1a65dab33401d766, ; 136 => androidx/navigation/NavController$OnDestinationChangedListener
	i64 u0x1aaa6a9aa98275b2, ; 137 => com/google/android/material/appbar/AppBarLayout$ChildScrollEffect
	i64 u0x1b88d684ca2a0819, ; 138 => crc6479d6f9e48582dc67/WindowOverlayStack
	i64 u0x1b89ef46042e2c03, ; 139 => android/text/method/MetaKeyKeyListener
	i64 u0x1cac6d98e4847d8c, ; 140 => crc6445ad3511b80f6fdf/GestureDetector_ScaleListener
	i64 u0x1cbdcf00c44f2034, ; 141 => androidx/lifecycle/Observer
	i64 u0x1da654e027889141, ; 142 => crc640ec207abc449b2ca/ShellFlyoutRenderer
	i64 u0x1dc163de5519f3ef, ; 143 => com/google/android/material/shape/CornerSize
	i64 u0x1df6cb381b21c3e5, ; 144 => crc6452ffdc5b34af3a0f/LayoutViewGroup
	i64 u0x1e0000284caa3573, ; 145 => android/os/LocaleList
	i64 u0x1e04bf19f9c14045, ; 146 => android/util/AttributeSet
	i64 u0x1e25af870a8898ca, ; 147 => android/animation/ValueAnimator$DurationScaleChangeListener
	i64 u0x1e549855226528a2, ; 148 => java/io/InterruptedIOException
	i64 u0x1e69018626ef9ffb, ; 149 => android/os/Handler
	i64 u0x1e72ebd893590a84, ; 150 => mono/androidx/core/view/WindowInsetsControllerCompat_OnControllableInsetsChangedListenerImplementor
	i64 u0x1e957b3efd87ae08, ; 151 => android/content/res/ColorStateList
	i64 u0x1ed94df1d9fa38c4, ; 152 => java/text/NumberFormat
	i64 u0x1eec52f0d8ec6767, ; 153 => crc64f5844edce43316e7/CustomImageView
	i64 u0x1eef7492beaf81e2, ; 154 => android/os/IInterface
	i64 u0x1f76a92524b92e96, ; 155 => android/graphics/Region
	i64 u0x1fb6522f1211b131, ; 156 => androidx/core/view/WindowInsetsCompat
	i64 u0x1fe6d4c31f9a7383, ; 157 => android/net/NetworkCapabilities
	i64 u0x1fefdd3f153911b5, ; 158 => androidx/biometric/FingerprintDialogFragment
	i64 u0x208c2e59c4c6d758, ; 159 => java/util/function/ToIntFunction
	i64 u0x211719e0e41e966a, ; 160 => android/graphics/drawable/StateListDrawable
	i64 u0x218f07bbf08c531e, ; 161 => kotlin/coroutines/CoroutineContext$Key
	i64 u0x21b381333982058e, ; 162 => javax/net/SocketFactory
	i64 u0x22436d73eb9797a7, ; 163 => android/content/IntentFilter
	i64 u0x225c20a45cb91cd7, ; 164 => java/lang/Error
	i64 u0x228edb5145b4bbc1, ; 165 => android/view/InputEvent
	i64 u0x22f341dcea6f3d85, ; 166 => androidx/core/content/pm/PackageInfoCompat
	i64 u0x23142080c6b7a295, ; 167 => android/graphics/drawable/BitmapDrawable
	i64 u0x23243faa046cf4fb, ; 168 => crc645d80431ce5f73f11/ItemsViewAdapter_2
	i64 u0x234193b9a430beb1, ; 169 => crc645d80431ce5f73f11/MauiCarouselRecyclerView
	i64 u0x2413290612c4bce3, ; 170 => mono/androidx/recyclerview/widget/RecyclerView_OnChildAttachStateChangeListenerImplementor
	i64 u0x24336b0b8aaf4cfe, ; 171 => androidx/appcompat/app/ActionBarDrawerToggle$Delegate
	i64 u0x24519c116d0ca8a6, ; 172 => crc64e1fb321c08285b90/ViewCellRenderer_ViewCellContainer_LongPressGestureListener
	i64 u0x24d34cdbf04208f8, ; 173 => android/window/InputTransferToken
	i64 u0x24f44152583c2169, ; 174 => androidx/core/view/WindowInsetsCompat$Type
	i64 u0x24f448339156297b, ; 175 => crc645d80431ce5f73f11/EndSingleSnapHelper
	i64 u0x24f7c38731b35c70, ; 176 => com/google/android/material/tabs/TabLayoutMediator
	i64 u0x250f0166bb46cb93, ; 177 => android/webkit/WebChromeClient
	i64 u0x25530a8d502e8309, ; 178 => crc6452ffdc5b34af3a0f/StepperHandlerManager_StepperListener
	i64 u0x255b92ba6ba38e24, ; 179 => android/net/LinkProperties
	i64 u0x2564914306a7d978, ; 180 => crc6452ffdc5b34af3a0f/MauiAccessibilityDelegateCompat
	i64 u0x257965de19f948c8, ; 181 => crc648a9457dd5f66374f/ExtMauiScrollView
	i64 u0x258a3fdaab536970, ; 182 => crc64e1fb321c08285b90/BaseCellView
	i64 u0x25be0d44e61e2384, ; 183 => crc6452ffdc5b34af3a0f/AccessibilityDelegateCompatWrapper
	i64 u0x25c6e6948f7aabe5, ; 184 => crc64338477404e88479c/ColorChangeRevealDrawable
	i64 u0x265bae6014cc5793, ; 185 => androidx/security/crypto/EncryptedSharedPreferences$PrefKeyEncryptionScheme
	i64 u0x2693484b17161b0e, ; 186 => com/google/crypto/tink/shaded/protobuf/InvalidProtocolBufferException
	i64 u0x26d52b7ae9ae9bc7, ; 187 => android/webkit/WebMessage
	i64 u0x272ea4375d87e30b, ; 188 => androidx/activity/result/ActivityResultCallback
	i64 u0x287bcca10e29c798, ; 189 => android/webkit/CookieManager
	i64 u0x28a48ae9efc00f97, ; 190 => androidx/biometric/BiometricPrompt$CryptoObject
	i64 u0x28cad0b9244cc1b5, ; 191 => android/widget/ListView
	i64 u0x294713a0194d0119, ; 192 => mono/android/animation/AnimatorEventDispatcher
	i64 u0x296b87a36177ce1f, ; 193 => androidx/navigation/NavDeepLink
	i64 u0x2975831afa63f308, ; 194 => android/view/SearchEvent
	i64 u0x297a06a76a1a32e8, ; 195 => crc6452ffdc5b34af3a0f/MauiHybridWebView
	i64 u0x29c713799a61dfd3, ; 196 => android/graphics/PathEffect
	i64 u0x29d10d5373d0de51, ; 197 => android/app/TimePickerDialog
	i64 u0x29d741b98267cff9, ; 198 => crc645d80431ce5f73f11/EmptyViewAdapter
	i64 u0x29eea0438b34229e, ; 199 => android/widget/SearchView
	i64 u0x2a15272bf231e341, ; 200 => android/widget/EditText
	i64 u0x2a863404765de198, ; 201 => android/provider/DocumentsContract
	i64 u0x2aee053a4160bbec, ; 202 => kotlinx/coroutines/flow/Flow
	i64 u0x2b430359e9717bb9, ; 203 => crc64c0976fbcdb365652/StaticTextLayout
	i64 u0x2b4dc18b8f592fba, ; 204 => android/view/inputmethod/ExtractedText
	i64 u0x2b72e127ba0bb70a, ; 205 => crc6486af4e8104107bae/DropdownViewExt
	i64 u0x2bcca4a8219ac237, ; 206 => javax/security/cert/X509Certificate
	i64 u0x2bd1ad3b5c2d27f0, ; 207 => android/graphics/BlendMode
	i64 u0x2bf6d6708afd9c04, ; 208 => androidx/savedstate/SavedStateRegistry
	i64 u0x2bf6dde72be3597b, ; 209 => crc640ec207abc449b2ca/ShellFlyoutLayout
	i64 u0x2bfb1e07ada83eca, ; 210 => androidx/lifecycle/viewmodel/CreationExtras$Key
	i64 u0x2c0c9dbeeb804874, ; 211 => android/widget/AdapterView
	i64 u0x2c30d6ecce5695fb, ; 212 => java/text/Format
	i64 u0x2c3a98b68817eb58, ; 213 => crc64e1fb321c08285b90/EntryCellEditText
	i64 u0x2c546f8dca46e363, ; 214 => androidx/navigation/NavType
	i64 u0x2ce3c962a914d7c5, ; 215 => crc64f728827fec74e9c3/TapWindowTracker_GestureListener
	i64 u0x2cf8d24c3d21e911, ; 216 => android/text/TextPaint
	i64 u0x2d266277f4578de8, ; 217 => kotlinx/serialization/encoding/Encoder
	i64 u0x2d394d9ef707bb4c, ; 218 => android/widget/AbsSeekBar
	i64 u0x2d6a6698637888af, ; 219 => com/google/android/material/tabs/TabLayout
	i64 u0x2dad289fa6207670, ; 220 => android/text/style/BackgroundColorSpan
	i64 u0x2e7ac01fdc3e9e8d, ; 221 => android/text/style/WrapTogetherSpan
	i64 u0x2eacb325830db74c, ; 222 => android/database/ContentObserver
	i64 u0x2ed22baacaa732af, ; 223 => com/google/crypto/tink/shaded/protobuf/Internal
	i64 u0x2ee44e544e7f31fb, ; 224 => crc645d80431ce5f73f11/SpacingItemDecoration
	i64 u0x2f6abb1a95f52f9b, ; 225 => com/google/crypto/tink/shaded/protobuf/CodedOutputStream
	i64 u0x2ff9fb2c70f4f954, ; 226 => java/lang/SecurityException
	i64 u0x301a44a43e303285, ; 227 => crc645d80431ce5f73f11/SingleSnapHelper
	i64 u0x304444061162dbb8, ; 228 => androidx/appcompat/widget/AppCompatTextView
	i64 u0x3068b2cc16f39dc1, ; 229 => android/view/ContextMenu$ContextMenuInfo
	i64 u0x30abf4d5cd5193ea, ; 230 => kotlin/reflect/KAnnotatedElement
	i64 u0x3124bf0069caf930, ; 231 => crc640360c8a960a6805b/CustomAccessibilityProvider
	i64 u0x315ed2c3714b7af8, ; 232 => kotlinx/serialization/encoding/CompositeDecoder
	i64 u0x316137951e53b82f, ; 233 => android/graphics/BlurMaskFilter
	i64 u0x31f6cbff3196a79a, ; 234 => android/content/IntentSender
	i64 u0x321c29cf8c6f7a93, ; 235 => android/content/res/Resources
	i64 u0x322a6d58316feaad, ; 236 => com/google/android/material/shape/ShapePathModel
	i64 u0x32d6a1d6ee9f6d5a, ; 237 => android/content/Intent
	i64 u0x32e9b956c200241a, ; 238 => android/net/NetworkRequest
	i64 u0x32f4c79d0d754da7, ; 239 => android/content/ClipDescription
	i64 u0x332031975eda7654, ; 240 => java/lang/Boolean
	i64 u0x333c1e7a72efe803, ; 241 => com/google/android/material/shape/ShapePath
	i64 u0x33446dc637a16331, ; 242 => android/view/Menu
	i64 u0x339314fb190f366a, ; 243 => androidx/appcompat/widget/Toolbar$OnMenuItemClickListener
	i64 u0x33d52fa94ce94e04, ; 244 => androidx/core/internal/view/SupportMenuItem
	i64 u0x33ff30e6692ebacc, ; 245 => androidx/core/widget/NestedScrollView$OnScrollChangeListener
	i64 u0x3436cf09b45d055e, ; 246 => java/security/Principal
	i64 u0x348d00618320f783, ; 247 => androidx/core/view/accessibility/AccessibilityNodeInfoCompat$TouchDelegateInfoCompat
	i64 u0x34922aa49b075749, ; 248 => androidx/activity/result/ActivityResultLauncher
	i64 u0x3493d4f185c2b950, ; 249 => android/view/animation/LinearInterpolator
	i64 u0x34a4414d9498be08, ; 250 => androidx/core/view/WindowInsetsControllerCompat
	i64 u0x34c0bb7ce9387e9b, ; 251 => crc64159f3caeb1269279/MauiPopup
	i64 u0x34d3edeaafb781d0, ; 252 => android/text/InputFilter$LengthFilter
	i64 u0x3546d62b6750666a, ; 253 => crc645d80431ce5f73f11/TextViewHolder
	i64 u0x354fcde9fba66be0, ; 254 => android/content/DialogInterface$OnClickListener
	i64 u0x35e989807a64bcd9, ; 255 => java/lang/IllegalStateException
	i64 u0x3611feb7c92af67a, ; 256 => android/content/SharedPreferences$Editor
	i64 u0x3655063d24206f71, ; 257 => android/app/DatePickerDialog$OnDateSetListener
	i64 u0x3690c8ddd0de1650, ; 258 => android/util/Pair
	i64 u0x36919b6683653a07, ; 259 => crc6452ffdc5b34af3a0f/SwipeViewPager
	i64 u0x3695825e95d58a86, ; 260 => java/lang/ClassLoader
	i64 u0x36a21a5536d10d64, ; 261 => android/view/LayoutInflater
	i64 u0x374e29f85377aa8d, ; 262 => androidx/activity/BackEventCompat
	i64 u0x374e88907ca71674, ; 263 => crc6479d6f9e48582dc67/HorizontalScrollViewer
	i64 u0x37605836d2882b8e, ; 264 => androidx/collection/SparseArrayCompat
	i64 u0x37b71a054ebc0df3, ; 265 => android/animation/AnimatorListenerAdapter
	i64 u0x37c2da9e97cb47f0, ; 266 => android/text/method/KeyListener
	i64 u0x3805860ad72c98d9, ; 267 => crc64f5844edce43316e7/ButtonView
	i64 u0x38a041da7c763f23, ; 268 => android/view/animation/Animation$AnimationListener
	i64 u0x38a444992a5ec975, ; 269 => androidx/recyclerview/widget/GridLayoutManager
	i64 u0x38bd0b281100230c, ; 270 => androidx/recyclerview/widget/RecyclerView$OnItemTouchListener
	i64 u0x38efa7482f45a90d, ; 271 => crc640ec207abc449b2ca/CustomFrameLayout
	i64 u0x38f8abd8c74c4199, ; 272 => androidx/core/widget/CompoundButtonCompat
	i64 u0x3904a04f5caccc84, ; 273 => android/view/animation/AnimationUtils
	i64 u0x392f671daea03e4a, ; 274 => com/google/crypto/tink/shaded/protobuf/Parser
	i64 u0x39598be8860f4637, ; 275 => androidx/fragment/app/FragmentHostCallback
	i64 u0x399255970a652898, ; 276 => android/view/View$DragShadowBuilder
	i64 u0x3a0b11ff22c4d637, ; 277 => android/view/accessibility/AccessibilityManager$AccessibilityStateChangeListener
	i64 u0x3a57b897b48a0e4a, ; 278 => android/net/Network
	i64 u0x3a5f163c839674eb, ; 279 => crc6452ffdc5b34af3a0f/MauiPickerBase
	i64 u0x3a8127906692d290, ; 280 => android/graphics/Matrix
	i64 u0x3a8e7c9f52fffa08, ; 281 => android/text/method/DigitsKeyListener
	i64 u0x3ade0c7da62503ba, ; 282 => crc64338477404e88479c/PointerGestureHandler
	i64 u0x3afd599e8e209ab1, ; 283 => java/security/Signature
	i64 u0x3b01cd169489a0ba, ; 284 => android/view/inputmethod/InputConnection
	i64 u0x3b42d29f06c95015, ; 285 => android/view/accessibility/AccessibilityNodeInfo
	i64 u0x3b4546021c55bbd5, ; 286 => android/text/StaticLayout$Builder
	i64 u0x3b7b23577919968e, ; 287 => crc640516eac8f2b5dac9/LayoutViewGroupExt
	i64 u0x3b897751150d7c41, ; 288 => crc649ff77a65592e7d55/TabbedPageManager_TempView
	i64 u0x3bbcf2fd26063dab, ; 289 => androidx/activity/result/ActivityResultRegistry
	i64 u0x3befb3da59a57d28, ; 290 => androidx/navigation/NavArgument
	i64 u0x3c26f488127fabb3, ; 291 => crc640ec207abc449b2ca/ShellContentFragment
	i64 u0x3c7b6b371fdb815e, ; 292 => crc6479d6f9e48582dc67/NativeListViewScrollView
	i64 u0x3cbc5ad3e546be58, ; 293 => crc64338477404e88479c/MultiPageFragmentStateAdapter_1
	i64 u0x3d671e7233f17019, ; 294 => crc64e1fb321c08285b90/CellAdapter
	i64 u0x3d6c541ff5df241e, ; 295 => android/view/contentcapture/ContentCaptureSession
	i64 u0x3daecfd1865916e7, ; 296 => mono/android/widget/PopupWindow_OnDismissListenerImplementor
	i64 u0x3e63d052c6c91768, ; 297 => android/graphics/drawable/shapes/RectShape
	i64 u0x3ea0e9f234b8572a, ; 298 => android/graphics/DashPathEffect
	i64 u0x3ef4d22bf3b2260b, ; 299 => android/webkit/WebResourceResponse
	i64 u0x3f61da37fb333b04, ; 300 => android/app/ActionBar$LayoutParams
	i64 u0x3f97d8ee32f8b25b, ; 301 => android/view/ViewParent
	i64 u0x400d948c9d7f86fc, ; 302 => android/text/method/NumberKeyListener
	i64 u0x406e54c64b3bee74, ; 303 => android/runtime/JavaProxyThrowable
	i64 u0x40990721bf4c1086, ; 304 => android/widget/PopupWindow
	i64 u0x40b96fc75df9616d, ; 305 => android/view/GestureDetector$OnGestureListener
	i64 u0x40c05cff47992547, ; 306 => android/view/ViewGroup
	i64 u0x40e478bf1fb132e1, ; 307 => crc64e1fb321c08285b90/TextCellRenderer_TextCellView
	i64 u0x4102c960330b5936, ; 308 => crc64e1fb321c08285b90/ViewCellRenderer_ViewCellContainer_TapGestureListener
	i64 u0x412d3dac9f7de53a, ; 309 => android/view/View$OnScrollChangeListener
	i64 u0x415e631ae10d9777, ; 310 => androidx/fragment/app/FragmentTransaction
	i64 u0x41ac0ab939dc266a, ; 311 => android/view/MenuItem$OnActionExpandListener
	i64 u0x41bebe9788d0065d, ; 312 => java/util/concurrent/Future
	i64 u0x41d091ef7039ab94, ; 313 => java/net/URLConnection
	i64 u0x41ebcd9abfe3ee7f, ; 314 => androidx/core/content/LocusIdCompat
	i64 u0x4209344bc1b095c1, ; 315 => java/net/ProtocolException
	i64 u0x420a04e6f6999834, ; 316 => crc6479d6f9e48582dc67/GestureDetector_ScaleListener
	i64 u0x42281d946d89f4bf, ; 317 => android/text/StaticLayout
	i64 u0x42ccc2c64993f27f, ; 318 => android/animation/ValueAnimator$AnimatorUpdateListener
	i64 u0x42e91d1f598314ca, ; 319 => android/database/DataSetObserver
	i64 u0x4326e660e16a4f2a, ; 320 => kotlin/jvm/functions/Function2
	i64 u0x438a96bd0d28ce85, ; 321 => android/graphics/ColorMatrixColorFilter
	i64 u0x439a14affe23e7c0, ; 322 => androidx/appcompat/view/ActionMode$Callback
	i64 u0x43b039b3078a25e0, ; 323 => androidx/viewpager/widget/PagerAdapter
	i64 u0x43bf06faa05dffed, ; 324 => androidx/loader/content/Loader
	i64 u0x440eda1cb69308a3, ; 325 => androidx/fragment/app/FragmentManager
	i64 u0x441028a345627265, ; 326 => androidx/viewpager2/widget/ViewPager2$PageTransformer
	i64 u0x447911f99b272892, ; 327 => androidx/recyclerview/widget/RecyclerView$ChildDrawingOrderCallback
	i64 u0x44d834af2d043447, ; 328 => com/google/crypto/tink/shaded/protobuf/Internal$EnumLiteMap
	i64 u0x452ac893c1084d31, ; 329 => com/google/crypto/tink/shaded/protobuf/AbstractMessageLite
	i64 u0x45cbc3db291fc315, ; 330 => com/google/android/material/internal/ScrimInsetsFrameLayout
	i64 u0x45d7140e988e2635, ; 331 => crc64c0976fbcdb365652/CustomAccessibilityProvider
	i64 u0x45e22fe78680c395, ; 332 => android/view/animation/BaseInterpolator
	i64 u0x45e88f6bf8474d57, ; 333 => crc64e53d2f592022988e/ConnectivityBroadcastReceiver
	i64 u0x4600774174055c9e, ; 334 => com/google/crypto/tink/shaded/protobuf/GeneratedMessageLite$GeneratedExtension
	i64 u0x461cbd479244c30e, ; 335 => androidx/recyclerview/widget/GridLayoutManager$SpanSizeLookup
	i64 u0x46471c60ac99f101, ; 336 => androidx/appcompat/view/menu/MenuItemImpl
	i64 u0x46d1db9e48980f43, ; 337 => androidx/browser/customtabs/CustomTabsIntent$Builder
	i64 u0x4768ffd64bb01691, ; 338 => android/view/WindowInsets$Type
	i64 u0x482246ca274ee68f, ; 339 => androidx/activity/contextaware/OnContextAvailableListener
	i64 u0x48d8183d1b1e372d, ; 340 => crc64354973402314325c/ViewHolder
	i64 u0x48e1abb584b78c94, ; 341 => java/io/Writer
	i64 u0x4976930bddc9561a, ; 342 => com/microsoft/maui/PlatformContentViewGroup
	i64 u0x498bbf94c21599c2, ; 343 => androidx/core/view/accessibility/AccessibilityNodeInfoCompat$CollectionInfoCompat
	i64 u0x49f836b50dc30062, ; 344 => androidx/core/app/ComponentActivity$ExtraData
	i64 u0x4a1368574f17ef4a, ; 345 => crc6452ffdc5b34af3a0f/MauiLayerDrawable
	i64 u0x4a39213a97fe1b2f, ; 346 => java/net/ConnectException
	i64 u0x4a62077e41e01226, ; 347 => android/view/View$OnKeyListener
	i64 u0x4aee09df55dd86b2, ; 348 => android/graphics/RadialGradient
	i64 u0x4b259e47b25e5c84, ; 349 => androidx/appcompat/view/menu/MenuPresenter$Callback
	i64 u0x4b9890541bbe42b9, ; 350 => android/text/SpannableStringBuilder
	i64 u0x4b9f25f301daddd8, ; 351 => androidx/core/view/ViewPropertyAnimatorListener
	i64 u0x4bc067aaf3d10a65, ; 352 => androidx/recyclerview/widget/RecyclerView$ItemAnimator$ItemAnimatorFinishedListener
	i64 u0x4bc3254021830535, ; 353 => androidx/fragment/app/Fragment
	i64 u0x4c0f941e09b60a45, ; 354 => mono/androidx/navigation/NavController_OnDestinationChangedListenerImplementor
	i64 u0x4c3e8bbf51390507, ; 355 => android/graphics/Path$Direction
	i64 u0x4c6e9166f44886c9, ; 356 => androidx/recyclerview/widget/LinearLayoutManager
	i64 u0x4d3c4bca1c8dea14, ; 357 => kotlin/reflect/KTypeProjection
	i64 u0x4d42113f2af39c56, ; 358 => crc64338477404e88479c/GradientStrokeDrawable
	i64 u0x4d5913834f8ec110, ; 359 => android/content/DialogInterface
	i64 u0x4de23e4f12b0e274, ; 360 => android/text/style/TypefaceSpan
	i64 u0x4e6ec1690cfd5ab7, ; 361 => androidx/fragment/app/FragmentOnAttachListener
	i64 u0x4e7e0c32a0c92595, ; 362 => android/animation/Animator
	i64 u0x4ee5d68bf049f647, ; 363 => android/graphics/PointF
	i64 u0x4f2963385866e7a0, ; 364 => androidx/appcompat/widget/ContentFrameLayout
	i64 u0x4f858ea9c9162f43, ; 365 => android/os/IBinder
	i64 u0x4f9ad430b1a97fe6, ; 366 => android/widget/ScrollView
	i64 u0x4fb6b2906496a2f4, ; 367 => crc645d80431ce5f73f11/ScrollHelper
	i64 u0x5000d515ab59fda0, ; 368 => mono/com/google/android/material/checkbox/MaterialCheckBox_OnCheckedStateChangedListenerImplementor
	i64 u0x50292cbe4e8d7a66, ; 369 => com/google/android/material/navigation/NavigationBarView$OnItemSelectedListener
	i64 u0x50c99fed15830727, ; 370 => androidx/appcompat/graphics/drawable/DrawableWrapperCompat
	i64 u0x50d702ac1a779d77, ; 371 => mono/android/content/DialogInterface_OnClickListenerImplementor
	i64 u0x50dc1d14cbccd085, ; 372 => androidx/core/widget/TextViewCompat
	i64 u0x510b4a194e70a8b9, ; 373 => android/webkit/WebChromeClient$FileChooserParams
	i64 u0x513e52254d0e24b4, ; 374 => android/graphics/drawable/shapes/OvalShape
	i64 u0x516bd5763f07d608, ; 375 => android/net/Uri
	i64 u0x5181b129b1a25949, ; 376 => java/lang/Class
	i64 u0x5184aae28f8d70df, ; 377 => android/text/TextDirectionHeuristic
	i64 u0x51bfc104622f66ab, ; 378 => crc648a9457dd5f66374f/LayoutViewGroupExtension
	i64 u0x5238ad63b58da994, ; 379 => java/lang/ClassCastException
	i64 u0x525031aa556acae7, ; 380 => android/widget/ImageView$ScaleType
	i64 u0x529e559bd64e4c22, ; 381 => javax/net/ssl/HttpsURLConnection
	i64 u0x52a862f1811707ab, ; 382 => android/graphics/drawable/PaintDrawable
	i64 u0x53358f28c966fd3d, ; 383 => androidx/recyclerview/widget/LinearSmoothScroller
	i64 u0x53a75440048b66bb, ; 384 => mono/com/google/android/material/button/MaterialButton_OnCheckedChangeListenerImplementor
	i64 u0x53cee5bff10d5b09, ; 385 => androidx/lifecycle/SavedStateHandle
	i64 u0x53f1a1773a4ecbf7, ; 386 => android/content/res/Resources$Theme
	i64 u0x53f952e9c06f6806, ; 387 => androidx/recyclerview/widget/RecyclerView$LayoutManager$LayoutPrefetchRegistry
	i64 u0x53ffea4cdfcba029, ; 388 => android/widget/CheckBox
	i64 u0x5457a3ee93e79e1b, ; 389 => android/view/inputmethod/EditorInfo
	i64 u0x54ac420c61df93e4, ; 390 => android/text/style/UnderlineSpan
	i64 u0x54c5d3387059fe2c, ; 391 => mono/android/view/View_OnClickListenerImplementor
	i64 u0x54c8b157aaa152c8, ; 392 => androidx/fragment/app/FragmentManager$BackStackEntry
	i64 u0x54e75191bbca79dd, ; 393 => java/nio/ByteBuffer
	i64 u0x54f3fe7b69fcb0b9, ; 394 => androidx/core/app/SharedElementCallback$OnSharedElementsReadyListener
	i64 u0x551ac881eb4466c0, ; 395 => java/lang/Number
	i64 u0x5583d0b8a719d478, ; 396 => com/google/android/material/navigation/NavigationBarView
	i64 u0x55f72f5bdbb6740d, ; 397 => android/webkit/WebResourceRequest
	i64 u0x56365290d5a06704, ; 398 => java/lang/LinkageError
	i64 u0x5666c9382435fd16, ; 399 => com/google/android/material/checkbox/MaterialCheckBox
	i64 u0x566ecc3ae60a3cb4, ; 400 => com/google/crypto/tink/shaded/protobuf/Internal$BooleanList
	i64 u0x5670d8d609f8e657, ; 401 => android/view/inputmethod/CompletionInfo
	i64 u0x567e316d6f33b908, ; 402 => com/microsoft/maui/PlatformFontSpan
	i64 u0x567fec0de4828e4d, ; 403 => androidx/navigation/NavDestination
	i64 u0x5681ede87251094b, ; 404 => android/graphics/Point
	i64 u0x56b3097a5575b1b4, ; 405 => androidx/fragment/app/strictmode/FragmentStrictMode$Policy
	i64 u0x56b969a6299088b8, ; 406 => crc6452ffdc5b34af3a0f/MauiSwipeRefreshLayout
	i64 u0x56edd703570382fd, ; 407 => androidx/appcompat/app/AlertDialog_IDialogInterfaceOnCancelListenerImplementor
	i64 u0x5719cb7a45389d03, ; 408 => android/view/accessibility/AccessibilityRecord
	i64 u0x572c24ab8c2a9676, ; 409 => crc6488302ad6e9e4df1a/ImageLoaderResultCallback
	i64 u0x578cde9a6ed73057, ; 410 => android/graphics/ColorFilter
	i64 u0x57fe4a40460344db, ; 411 => android/os/Build$VERSION
	i64 u0x586ab22a14755113, ; 412 => androidx/appcompat/app/ActionBar$Tab
	i64 u0x587b88a96aea462f, ; 413 => androidx/core/view/MenuItemCompat$OnActionExpandListener
	i64 u0x588a8f57ed71ef4b, ; 414 => android/renderscript/Allocation
	i64 u0x588dc256d5772acc, ; 415 => android/content/pm/Signature
	i64 u0x58a16f68a40a6aaa, ; 416 => androidx/loader/content/Loader$OnLoadCompleteListener
	i64 u0x58b5a8bb573bb08d, ; 417 => androidx/security/crypto/EncryptedSharedPreferences$PrefValueEncryptionScheme
	i64 u0x58cef513210a5ef8, ; 418 => androidx/appcompat/widget/ScrollingTabContainerView
	i64 u0x58eaa41af58865c7, ; 419 => android/view/GestureDetector
	i64 u0x58f3414ff259c4b8, ; 420 => android/view/WindowManager
	i64 u0x5953ba6ba835be62, ; 421 => androidx/appcompat/widget/AppCompatRadioButton
	i64 u0x59c187e6ae5a875c, ; 422 => crc645d80431ce5f73f11/MauiRecyclerView_3
	i64 u0x5a0112c65ffedf51, ; 423 => crc64338477404e88479c/TapAndPanGestureDetector
	i64 u0x5a0481aecc8a3ce2, ; 424 => androidx/activity/ComponentActivity
	i64 u0x5a6af884fe3c181e, ; 425 => android/os/Bundle
	i64 u0x5a77a96ff0678558, ; 426 => crc64b5e713d400f589b7/LinearGradientShaderFactory
	i64 u0x5a792352facc703d, ; 427 => android/view/ScaleGestureDetector
	i64 u0x5a98238ba3158bd9, ; 428 => crc64f5844edce43316e7/Mapping_CustomPathDrawable
	i64 u0x5ad53467a1dc26c5, ; 429 => com/google/crypto/tink/shaded/protobuf/ExtensionRegistryLite
	i64 u0x5aeee04bda9a96eb, ; 430 => com/google/android/material/checkbox/MaterialCheckBox$OnErrorChangedListener
	i64 u0x5b4122135dd0a9b0, ; 431 => androidx/recyclerview/widget/RecyclerView$AdapterDataObserver
	i64 u0x5b4fb71e2ebac7d6, ; 432 => androidx/coordinatorlayout/widget/CoordinatorLayout
	i64 u0x5b81bc1333f27da7, ; 433 => android/os/Environment
	i64 u0x5b905726d9bc975f, ; 434 => android/widget/TextView
	i64 u0x5bfd65ae1a6e6ffc, ; 435 => android/app/Activity
	i64 u0x5bff61abc9367a53, ; 436 => android/graphics/drawable/ColorDrawable
	i64 u0x5c015cc2ad92408f, ; 437 => crc64354973402314325c/ItemAdapter
	i64 u0x5c0f804d17af3757, ; 438 => com/google/crypto/tink/shaded/protobuf/Internal$LongList
	i64 u0x5c2a60c822a3770a, ; 439 => android/view/Choreographer
	i64 u0x5c4e90a903a58960, ; 440 => java/lang/Cloneable
	i64 u0x5c654b241f6531ca, ; 441 => androidx/core/view/ViewCompat$OnUnhandledKeyEventListenerCompat
	i64 u0x5c7bc6ce7a367246, ; 442 => crc649ff9379e8ecbf267/ItemAdapter
	i64 u0x5c9a08d12cd9a5b9, ; 443 => android/view/ActionProvider
	i64 u0x5cba207f014f46ab, ; 444 => kotlin/jvm/functions/Function0
	i64 u0x5d89d4b8c5a3d9db, ; 445 => crc64338477404e88479c/DragAndDropGestureHandler_CustomLocalStateData
	i64 u0x5ddf7f807cfc0078, ; 446 => androidx/drawerlayout/widget/DrawerLayout$DrawerListener
	i64 u0x5e1c513312ebc1b3, ; 447 => android/view/KeyEvent
	i64 u0x5e38b925960b7be9, ; 448 => android/graphics/Rect
	i64 u0x5ee70ac3ebe949b0, ; 449 => androidx/appcompat/app/AlertDialog
	i64 u0x5f5a9fc3430795a4, ; 450 => android/content/ContextWrapper
	i64 u0x5f7e709faf8646e0, ; 451 => java/lang/Short
	i64 u0x5fcf59a6fdef477c, ; 452 => crc640360c8a960a6805b/StaticTextLayout
	i64 u0x6026ccdf174d8a44, ; 453 => androidx/fragment/app/Fragment$SavedState
	i64 u0x60512d5bcf66b69d, ; 454 => crc64338477404e88479c/ModalNavigationManager_ModalFragment_CustomComponentDialog
	i64 u0x6052034b1fd2f322, ; 455 => mono/androidx/viewpager/widget/ViewPager_OnAdapterChangeListenerImplementor
	i64 u0x606c0552cf86ec9a, ; 456 => androidx/recyclerview/widget/PagerSnapHelper
	i64 u0x60758c46d2753a9b, ; 457 => com/microsoft/maui/PlatformAppCompatTextView
	i64 u0x60cf40adaa3f6dc9, ; 458 => com/google/crypto/tink/shaded/protobuf/Internal$ProtobufList
	i64 u0x60f4eef2e292de33, ; 459 => android/graphics/LinearGradient
	i64 u0x61030996527b4bbc, ; 460 => android/app/UiModeManager
	i64 u0x61183bfd8b6bd8fc, ; 461 => crc640ec207abc449b2ca/ShellFlyoutRecyclerAdapter
	i64 u0x612a41da6ab82674, ; 462 => crc6452ffdc5b34af3a0f/NavigationRootManager_ElementBasedFragment
	i64 u0x6149cc868c1eff6d, ; 463 => android/view/SurfaceControlInputReceiver
	i64 u0x617ee4cf898cf958, ; 464 => android/renderscript/ScriptIntrinsic
	i64 u0x61aac7c4ec0352fc, ; 465 => com/google/crypto/tink/shaded/protobuf/LazyFieldLite
	i64 u0x61e294aa76550052, ; 466 => java/util/Comparator
	i64 u0x620acfa7c9394d4b, ; 467 => androidx/customview/widget/Openable
	i64 u0x6219335ac57fb821, ; 468 => java/io/Serializable
	i64 u0x6220c7ea6623515a, ; 469 => com/google/android/material/shape/CornerTreatment
	i64 u0x6260a9d5dac2c97c, ; 470 => androidx/core/view/ViewStructureCompat
	i64 u0x6298165c6bad7ccc, ; 471 => com/google/android/material/tabs/TabLayout$BaseOnTabSelectedListener
	i64 u0x62daf35c931c09d6, ; 472 => android/content/BroadcastReceiver
	i64 u0x63179c6d1be54723, ; 473 => androidx/biometric/BiometricFragment
	i64 u0x632306ed61138328, ; 474 => android/widget/FrameLayout$LayoutParams
	i64 u0x632b2c8978b75d3a, ; 475 => androidx/browser/customtabs/CustomTabsIntent
	i64 u0x6341d902373b98e2, ; 476 => com/google/android/material/tabs/TabLayout$Tab
	i64 u0x6398dbf9569985fe, ; 477 => androidx/recyclerview/widget/RecyclerView$LayoutManager
	i64 u0x63a4d78ba35c4679, ; 478 => androidx/core/view/ActionProvider$SubUiVisibilityListener
	i64 u0x6408578172862f8d, ; 479 => java/lang/Void
	i64 u0x6451356d5ed6f4a3, ; 480 => com/google/crypto/tink/shaded/protobuf/WireFormat
	i64 u0x64b068dd4783bc6b, ; 481 => androidx/appcompat/widget/SearchView$OnQueryTextListener
	i64 u0x6517c35353b9c5e6, ; 482 => crc6452ffdc5b34af3a0f/ScopedFragment
	i64 u0x6531c3e6b4a10d86, ; 483 => android/app/AlertDialog$Builder
	i64 u0x6582dfd3e9045b28, ; 484 => androidx/core/view/DragAndDropPermissionsCompat
	i64 u0x6586889e8594dad8, ; 485 => android/widget/BaseAdapter
	i64 u0x658dbda6541675f0, ; 486 => android/graphics/Paint$FontMetricsInt
	i64 u0x659c2abe67a29887, ; 487 => java/lang/Iterable
	i64 u0x65b48068a8beab4c, ; 488 => org/xmlpull/v1/XmlPullParserException
	i64 u0x65f6b14b7e978927, ; 489 => java/io/IOException
	i64 u0x665e90753f8d897c, ; 490 => androidx/core/view/accessibility/AccessibilityNodeProviderCompat
	i64 u0x665f83e363ae9dac, ; 491 => android/graphics/Shader
	i64 u0x667b50f3f2edbb73, ; 492 => android/graphics/drawable/ShapeDrawable$ShaderFactory
	i64 u0x6764a13a5d25a65c, ; 493 => androidx/recyclerview/widget/RecyclerView$ItemDecoration
	i64 u0x67765cb3732f0b32, ; 494 => android/text/Layout$Alignment
	i64 u0x67dc7ca4607a2fb3, ; 495 => crc6452ffdc5b34af3a0f/MauiHybridWebViewClient
	i64 u0x683b34ba77d878ed, ; 496 => java/util/concurrent/TimeUnit
	i64 u0x683ec3c5964ae14b, ; 497 => android/view/MenuItem$OnMenuItemClickListener
	i64 u0x6855fe4074b200b4, ; 498 => crc64b5e713d400f589b7/RadialGradientShaderFactory
	i64 u0x6890915f17dcdf32, ; 499 => android/graphics/Bitmap$CompressFormat
	i64 u0x68ac1b9ebadea92e, ; 500 => com/google/android/material/elevation/ElevationOverlayProvider
	i64 u0x68b44b76762752b2, ; 501 => android/app/DatePickerDialog
	i64 u0x68cf9abeceb59cea, ; 502 => androidx/core/text/PrecomputedTextCompat
	i64 u0x6922efe928410687, ; 503 => crc64e1fb321c08285b90/ListViewRenderer
	i64 u0x698099bd1c6d8d21, ; 504 => crc64e1fb321c08285b90/ConditionalFocusLayout
	i64 u0x6a38c6c5c11ae340, ; 505 => crc6452ffdc5b34af3a0f/StepperHandlerHolder
	i64 u0x6aa7d9af28b4551f, ; 506 => java/net/SocketTimeoutException
	i64 u0x6adf1754236db113, ; 507 => androidx/viewpager2/widget/ViewPager2$OnPageChangeCallback
	i64 u0x6b03329dfc544596, ; 508 => crc6452ffdc5b34af3a0f/MauiWebView
	i64 u0x6b0a83c98bac3d79, ; 509 => com/google/crypto/tink/shaded/protobuf/ByteString$Output
	i64 u0x6b51aa65df315197, ; 510 => com/google/android/material/appbar/HeaderScrollingViewBehavior
	i64 u0x6b6e62f3c48710bf, ; 511 => androidx/navigation/NavInflater
	i64 u0x6bb31a092bd1feb9, ; 512 => androidx/recyclerview/widget/OrientationHelper
	i64 u0x6bb600235e010d5b, ; 513 => android/view/KeyboardShortcutInfo
	i64 u0x6be9c486e045423d, ; 514 => com/google/android/material/appbar/AppBarLayout
	i64 u0x6bed14024a62c9d6, ; 515 => androidx/recyclerview/widget/RecyclerView$Adapter$StateRestorationPolicy
	i64 u0x6bf4e69d043f6219, ; 516 => androidx/recyclerview/widget/RecyclerView$State
	i64 u0x6c0d9fe36996eebe, ; 517 => com/google/crypto/tink/shaded/protobuf/GeneratedMessageLite$MethodToInvoke
	i64 u0x6c769f2fd757cb88, ; 518 => androidx/biometric/BiometricPrompt$PromptInfo
	i64 u0x6c87c98e7c02707b, ; 519 => androidx/viewpager2/widget/ViewPager2
	i64 u0x6c8e9e8bc1dbc29c, ; 520 => crc64e6d0b84c6264ccdd/AuthenticationHandler
	i64 u0x6c9ebc339853fa5a, ; 521 => androidx/recyclerview/widget/RecyclerView$RecycledViewPool
	i64 u0x6d4390d548910036, ; 522 => com/google/crypto/tink/shaded/protobuf/UnknownFieldSetLite
	i64 u0x6d5687238e2037cb, ; 523 => android/text/TextUtils
	i64 u0x6d6e4849a9c9cd73, ; 524 => androidx/fragment/app/FragmentContainerView
	i64 u0x6d736771e9774ab2, ; 525 => androidx/core/view/WindowInsetsAnimationControllerCompat
	i64 u0x6d7628a92227cba3, ; 526 => android/security/keystore/KeyGenParameterSpec
	i64 u0x6dbc029eb41711b7, ; 527 => crc6452ffdc5b34af3a0f/WrapperView
	i64 u0x6dbcd0082585a8fa, ; 528 => androidx/appcompat/app/ActionBar$LayoutParams
	i64 u0x6dc0577159300216, ; 529 => androidx/appcompat/widget/TooltipCompat
	i64 u0x6e08471d92d44bae, ; 530 => kotlinx/serialization/SerializationStrategy
	i64 u0x6e0fb15bd0f04d15, ; 531 => java/lang/StackTraceElement
	i64 u0x6e5d338a24aafe63, ; 532 => crc6452ffdc5b34af3a0f/NavigationViewFragment
	i64 u0x6e5d903dea237f3d, ; 533 => crc648a9457dd5f66374f/ExtMauiHorizontalScrollView
	i64 u0x6e64d524730b0605, ; 534 => androidx/navigation/NavGraph
	i64 u0x6ea4b64ad16a7f22, ; 535 => crc640ec207abc449b2ca/RecyclerViewContainer
	i64 u0x6ef4975bdb7af18f, ; 536 => android/view/MotionEvent
	i64 u0x6ef7816e17e24358, ; 537 => android/graphics/Canvas
	i64 u0x6f2c25bc76a30eb3, ; 538 => mono/android/app/TimePickerDialog_OnTimeSetListenerImplementor
	i64 u0x6f613a87c77307d0, ; 539 => crc645d80431ce5f73f11/MauiCarouselRecyclerView_CarouselViewOnGlobalLayoutListener
	i64 u0x6f7d2d169e2ce1a7, ; 540 => androidx/core/view/ActionProvider$VisibilityListener
	i64 u0x6fc88779b51adf4a, ; 541 => crc645d80431ce5f73f11/CenterSnapHelper
	i64 u0x6ff236a19c39d939, ; 542 => crc645d80431ce5f73f11/NongreedySnapHelper_InitialScrollListener
	i64 u0x700da72fda7f1d48, ; 543 => androidx/navigation/NavDirections
	i64 u0x70119df59a49b73c, ; 544 => android/text/style/SubscriptSpan
	i64 u0x703efa6e1ccb459a, ; 545 => android/window/TrustedPresentationThresholds
	i64 u0x7051eff2058593fd, ; 546 => kotlinx/coroutines/flow/StateFlow
	i64 u0x7069f7f991b35812, ; 547 => androidx/biometric/BiometricPrompt$AuthenticationCallback
	i64 u0x7099dcd62c409c90, ; 548 => androidx/recyclerview/widget/RecyclerView$SmoothScroller
	i64 u0x70a08622aaf16a57, ; 549 => android/provider/MediaStore$Images
	i64 u0x70d7b31d753f209e, ; 550 => android/view/accessibility/AccessibilityManager
	i64 u0x714152b8b4c7f7d6, ; 551 => java/security/KeyFactory
	i64 u0x715a86841a0ffdfc, ; 552 => android/graphics/drawable/DrawableWrapper
	i64 u0x71a366471b83c5b5, ; 553 => android/graphics/PorterDuff$Mode
	i64 u0x71fd27294bda99ec, ; 554 => crc64e1fb321c08285b90/ListViewRenderer_ListViewScrollDetector
	i64 u0x720cd712e1248c34, ; 555 => java/util/Iterator
	i64 u0x720de60454675dd1, ; 556 => java/lang/NoSuchFieldException
	i64 u0x72250d9fc64488cb, ; 557 => crc6452ffdc5b34af3a0f/MauiTextView
	i64 u0x7238e3d89c8143af, ; 558 => com/google/crypto/tink/shaded/protobuf/ByteOutput
	i64 u0x7263818030e7e9ae, ; 559 => android/app/Application$ActivityLifecycleCallbacks
	i64 u0x7277a93836a4600e, ; 560 => androidx/core/content/FileProvider
	i64 u0x72902a32c8eefca5, ; 561 => mono/androidx/fragment/app/FragmentManager_OnBackStackChangedListenerImplementor
	i64 u0x72a1f916524f134d, ; 562 => android/graphics/MaskFilter
	i64 u0x72eebb0413ddcb57, ; 563 => androidx/core/view/MenuProvider
	i64 u0x72f2a1098fdc8e8d, ; 564 => androidx/core/view/ScrollingView
	i64 u0x731d258e71c0cf1e, ; 565 => java/lang/Appendable
	i64 u0x733b91fe6ad98558, ; 566 => java/util/SequencedCollection
	i64 u0x734d10277a2fa3c8, ; 567 => crc6452ffdc5b34af3a0f/ContainerView
	i64 u0x7366b72149b10768, ; 568 => androidx/appcompat/app/AlertDialog_IDialogInterfaceOnClickListenerImplementor
	i64 u0x73e318a585bfc2e1, ; 569 => androidx/navigation/fragment/FragmentNavigator
	i64 u0x742016c9b209dd21, ; 570 => crc64338477404e88479c/GenericMenuClickListener
	i64 u0x74b84035b92d113a, ; 571 => crc64e53d2f592022988e/ConnectivityImplementation_EssentialsNetworkCallback
	i64 u0x74fec31fac75a39b, ; 572 => android/os/Message
	i64 u0x75106b52d2e6f9bb, ; 573 => microsoft/maui/platform/MauiNavHostFragment
	i64 u0x7522945af31b2b2c, ; 574 => crc649ff77a65592e7d55/TabbedPageManager_Listeners
	i64 u0x75591c18ddf5e52d, ; 575 => mono/android/TypeManager
	i64 u0x75a8e484d572136c, ; 576 => androidx/core/view/PointerIconCompat
	i64 u0x75c0676a362007df, ; 577 => android/view/ScaleGestureDetector$OnScaleGestureListener
	i64 u0x75c5771f2c4153c9, ; 578 => android/graphics/BlurMaskFilter$Blur
	i64 u0x76011f516f0fd1fa, ; 579 => kotlin/reflect/KType
	i64 u0x7618d20d66679b07, ; 580 => android/view/ActionMode$Callback
	i64 u0x761f7e1b6e4804f9, ; 581 => androidx/lifecycle/viewmodel/CreationExtras
	i64 u0x763b0c46a0d100da, ; 582 => crc640ec207abc449b2ca/ShellFragmentContainer
	i64 u0x763c2670ea45f55c, ; 583 => android/graphics/drawable/Drawable
	i64 u0x7672ff526305decc, ; 584 => kotlin/coroutines/CoroutineContext
	i64 u0x769858d73eac9d5a, ; 585 => android/widget/AdapterView$OnItemSelectedListener
	i64 u0x7699e204374e476e, ; 586 => crc640ec207abc449b2ca/ShellFlyoutRecyclerAdapter_ElementViewHolder
	i64 u0x76b3a4287318b9dd, ; 587 => com/google/crypto/tink/shaded/protobuf/Internal$IntList
	i64 u0x76cbd2104dd555ed, ; 588 => android/content/Context
	i64 u0x76cd544434e023e9, ; 589 => android/widget/AbsoluteLayout
	i64 u0x775f4b008c098a1a, ; 590 => androidx/core/view/WindowInsetsAnimationCompat$BoundsCompat
	i64 u0x776fac8615206e88, ; 591 => crc6468b6408a11370c2f/WebAuthenticatorIntermediateActivity
	i64 u0x778cfba384f8d504, ; 592 => androidx/viewpager2/adapter/FragmentStateAdapter
	i64 u0x77e17daf4f2798d3, ; 593 => androidx/appcompat/widget/ScrollingTabContainerView$VisibilityAnimListener
	i64 u0x77f013f4840c6e9d, ; 594 => android/widget/SeekBar$OnSeekBarChangeListener
	i64 u0x782ecc3f7b0f1702, ; 595 => crc6452ffdc5b34af3a0f/BorderDrawable
	i64 u0x786e5a40bb3c74ca, ; 596 => android/webkit/ValueCallback
	i64 u0x78a8a09e70ef45d0, ; 597 => androidx/lifecycle/LifecycleObserver
	i64 u0x78bd50b8041f8ec3, ; 598 => android/text/style/StyleSpan
	i64 u0x78f85ce39df68ca7, ; 599 => androidx/activity/OnBackPressedDispatcher
	i64 u0x790004a16b482410, ; 600 => kotlinx/coroutines/flow/SharedFlow
	i64 u0x79010cb7f8e68c03, ; 601 => androidx/core/app/SharedElementCallback
	i64 u0x7923685decfc70fb, ; 602 => mono/android/widget/CompoundButton_OnCheckedChangeListenerImplementor
	i64 u0x794945e513b3eb18, ; 603 => crc640ec207abc449b2ca/ShellFlyoutRecyclerAdapter_ShellLinearLayout
	i64 u0x7977deebacec08ab, ; 604 => androidx/activity/ComponentDialog
	i64 u0x7988fa0f526a36f4, ; 605 => mono/androidx/recyclerview/widget/RecyclerView_OnItemTouchListenerImplementor
	i64 u0x799e5cf8387079f0, ; 606 => android/text/format/DateFormat
	i64 u0x79b8e6ed4e0962cc, ; 607 => android/webkit/WebView
	i64 u0x7a5d42aa9daae09b, ; 608 => crc645d80431ce5f73f11/ItemContentView
	i64 u0x7b20a8c72b4caa3d, ; 609 => crc64338477404e88479c/ModalNavigationManager_ModalFragment
	i64 u0x7b34053dc4eca88e, ; 610 => java/security/SignatureSpi
	i64 u0x7b3aeb75b65cbd49, ; 611 => java/security/spec/PKCS8EncodedKeySpec
	i64 u0x7b56b4292dd91c4f, ; 612 => androidx/appcompat/app/ActionBar$OnMenuVisibilityListener
	i64 u0x7b7af49dc7612e19, ; 613 => com/google/android/material/bottomnavigation/BottomNavigationMenuView
	i64 u0x7b8a450ef3d3c146, ; 614 => androidx/core/view/WindowInsetsAnimationCompat
	i64 u0x7b925bdca68a0101, ; 615 => java/util/ArrayList
	i64 u0x7b9751a676037138, ; 616 => android/net/NetworkInfo
	i64 u0x7bc72d027e66ad3c, ; 617 => android/view/Display
	i64 u0x7bea88d40188eb89, ; 618 => crc64c508e0a6469c3711/MainActivity
	i64 u0x7c399b8939d0b28d, ; 619 => crc64e1fb321c08285b90/VisualElementRenderer_1
	i64 u0x7c93df30f68cf9a7, ; 620 => javax/security/auth/Subject
	i64 u0x7d1282be62fee357, ; 621 => android/text/Layout
	i64 u0x7d2c987ae4cd1b0a, ; 622 => androidx/appcompat/app/AppCompatDelegate
	i64 u0x7d8f1e430aa19c68, ; 623 => android/content/ContentProvider
	i64 u0x7d9b7a895725d4ea, ; 624 => android/renderscript/RenderScript
	i64 u0x7dff4c2d4c028447, ; 625 => androidx/appcompat/widget/SearchView$OnCloseListener
	i64 u0x7e0053f5a1f97282, ; 626 => android/util/StateSet
	i64 u0x7e201ad40955df46, ; 627 => android/os/Parcel
	i64 u0x7ea3a0bae2471b19, ; 628 => androidx/biometric/BiometricPrompt$PromptInfo$Builder
	i64 u0x7eaadfc0d327456a, ; 629 => crc6452ffdc5b34af3a0f/MauiStepper
	i64 u0x7eec405468a6a0e7, ; 630 => crc64f5844edce43316e7/PlatformRotator
	i64 u0x7ef93854923e0913, ; 631 => java/util/Locale
	i64 u0x7f0d7baf92a81e22, ; 632 => androidx/viewpager/widget/ViewPager$PageTransformer
	i64 u0x7fc6286783d5249d, ; 633 => java/security/Key
	i64 u0x7fd0c0cbdc4f6c31, ; 634 => crc645d80431ce5f73f11/StartSnapHelper
	i64 u0x7fd6b531797aa365, ; 635 => java/net/URL
	i64 u0x803c00108539f471, ; 636 => androidx/core/view/WindowInsetsControllerCompat$OnControllableInsetsChangedListener
	i64 u0x8087343f088cdd62, ; 637 => kotlinx/serialization/descriptors/SerialKind
	i64 u0x8088098b52e9f916, ; 638 => android/app/KeyguardManager
	i64 u0x80b2eff68480f860, ; 639 => androidx/core/app/ComponentActivity
	i64 u0x811a6571399defdf, ; 640 => android/view/ViewTreeObserver
	i64 u0x81329494ac82a700, ; 641 => crc640360c8a960a6805b/PlatformSignaturePad
	i64 u0x816611be5081e6a6, ; 642 => androidx/loader/content/Loader$OnLoadCanceledListener
	i64 u0x81a9b57a7455bc09, ; 643 => crc6486af4e8104107bae/LayoutViewGroupExt
	i64 u0x81b9feefc4c8a54b, ; 644 => android/graphics/drawable/AnimationDrawable
	i64 u0x81f19eb23092b621, ; 645 => android/widget/PopupWindow$OnDismissListener
	i64 u0x823c54a67f346ebd, ; 646 => android/view/ViewGroup$OnHierarchyChangeListener
	i64 u0x82437651e84d8ef1, ; 647 => mono/androidx/appcompat/widget/SearchView_OnSuggestionListenerImplementor
	i64 u0x82d156baaac6b271, ; 648 => com/google/android/material/button/MaterialButton
	i64 u0x82d4b802f5f16be5, ; 649 => androidx/core/view/ContentInfoCompat
	i64 u0x831ac2299215129e, ; 650 => android/text/style/ClickableSpan
	i64 u0x83314b5931a387fb, ; 651 => android/widget/Toast
	i64 u0x8382b117e5ce1b08, ; 652 => crc64fcf28c0e24b4cc31/ToolbarHandler_ProcessBackClick
	i64 u0x8389777d2cbf57e8, ; 653 => kotlin/jvm/internal/markers/KMappedMarker
	i64 u0x8407971d2e654189, ; 654 => androidx/core/view/contentcapture/ContentCaptureSessionCompat
	i64 u0x84847e4e3d1decde, ; 655 => android/graphics/drawable/Animatable
	i64 u0x849891cbd238b929, ; 656 => crc6452ffdc5b34af3a0f/MauiPageControl_TEditClickListener
	i64 u0x84a0e1080b630a71, ; 657 => android/util/TypedValue
	i64 u0x84de4b691bbece02, ; 658 => android/view/WindowInsetsAnimation$Bounds
	i64 u0x84f94178aab6cc34, ; 659 => java/lang/CharSequence
	i64 u0x851714794ae293d4, ; 660 => android/content/ContentValues
	i64 u0x852b5457ebdd5c87, ; 661 => android/view/ViewGroup$LayoutParams
	i64 u0x85484318643883ec, ; 662 => mono/androidx/swiperefreshlayout/widget/SwipeRefreshLayout_OnRefreshListenerImplementor
	i64 u0x857e9a08c0f1b76a, ; 663 => java/lang/Math
	i64 u0x85928bf84afcf5c1, ; 664 => android/text/style/LineHeightSpan
	i64 u0x85f0f67c9a393c74, ; 665 => mono/androidx/core/view/ActionProvider_VisibilityListenerImplementor
	i64 u0x8630444b8c4fb189, ; 666 => crc640ec207abc449b2ca/ShellSectionRenderer
	i64 u0x8757d6a5a0083426, ; 667 => mono/androidx/fragment/app/FragmentOnAttachListenerImplementor
	i64 u0x8817ebe79901b58b, ; 668 => androidx/recyclerview/widget/RecyclerView$OnChildAttachStateChangeListener
	i64 u0x888700b03d541d93, ; 669 => java/lang/RuntimeException
	i64 u0x889cf012a76d5159, ; 670 => crc6452ffdc5b34af3a0f/MauiTimePicker
	i64 u0x88f7510c649f4a97, ; 671 => java/io/InputStream
	i64 u0x89573b2343b833d9, ; 672 => crc6452ffdc5b34af3a0f/MauiBoxView
	i64 u0x895c33d930fba4ec, ; 673 => crc640ec207abc449b2ca/ShellFragmentStateAdapter
	i64 u0x896dd3f945a64fd8, ; 674 => kotlinx/serialization/descriptors/SerialDescriptor
	i64 u0x89b4e5207bc2bd03, ; 675 => crc64e1fb321c08285b90/ViewRenderer_2
	i64 u0x89bb78ecf66b1453, ; 676 => android/view/SurfaceControl
	i64 u0x89dd9f6b9a07e7dc, ; 677 => crc6452ffdc5b34af3a0f/MauiMaterialButton
	i64 u0x8a1490d8574c80bb, ; 678 => com/google/android/material/appbar/AppBarLayout$BaseBehavior
	i64 u0x8a1927818aa18084, ; 679 => javax/net/ssl/KeyManager
	i64 u0x8a3ea3c274e8ce68, ; 680 => java/lang/Character
	i64 u0x8a5349863088c262, ; 681 => androidx/appcompat/app/ActionBarDrawerToggle
	i64 u0x8a62151cb42a8262, ; 682 => java/util/RandomAccess
	i64 u0x8a6d217b35a9e388, ; 683 => android/app/TimePickerDialog$OnTimeSetListener
	i64 u0x8a827f97b9e96017, ; 684 => crc64ba438d8f48cf7e75/ActivityLifecycleContextListener
	i64 u0x8a89060c7bb2fa66, ; 685 => crc6452ffdc5b34af3a0f/MauiShapeView
	i64 u0x8abed19b023ffa85, ; 686 => androidx/core/util/Pair
	i64 u0x8bc84b37d30c7ba0, ; 687 => android/widget/ImageButton
	i64 u0x8c77114d6dcd93fe, ; 688 => java/util/function/Function
	i64 u0x8c92f6338e96a4a1, ; 689 => com/google/android/material/navigation/NavigationView
	i64 u0x8c9cbedbb1657afd, ; 690 => android/content/pm/ApplicationInfo
	i64 u0x8ce61e47a9725bab, ; 691 => androidx/recyclerview/widget/RecyclerView$Adapter
	i64 u0x8d02bdee4d42aad5, ; 692 => androidx/lifecycle/ViewModelStoreOwner
	i64 u0x8d0f522132078c72, ; 693 => com/google/crypto/tink/shaded/protobuf/Internal$DoubleList
	i64 u0x8d336818f5dae75a, ; 694 => androidx/recyclerview/widget/RecyclerView
	i64 u0x8d3ef13fbeef669c, ; 695 => androidx/appcompat/view/menu/MenuBuilder$Callback
	i64 u0x8d5b24a0831de33b, ; 696 => crc6486af4e8104107bae/CustomInputConnection
	i64 u0x8dde213f6a8ff31c, ; 697 => crc640ec207abc449b2ca/ShellFlyoutTemplatedContentRenderer_HeaderContainer
	i64 u0x8df3e8c200a502d7, ; 698 => crc64338477404e88479c/ControlsAccessibilityDelegate
	i64 u0x8e795a0bfb2fe84b, ; 699 => androidx/core/os/LocaleListCompat
	i64 u0x8e7a7278f27efaf0, ; 700 => crc6452ffdc5b34af3a0f/FragmentManagerExtensions_CallBacks
	i64 u0x8e80a8cd4be83f8c, ; 701 => android/view/ActionMode
	i64 u0x8ed1624d39198279, ; 702 => android/provider/MediaStore$Audio$Media
	i64 u0x8eedeff2522abc60, ; 703 => kotlinx/serialization/encoding/CompositeDecoder$Companion
	i64 u0x8ef620892da8a06a, ; 704 => android/view/MenuInflater
	i64 u0x8f0cb47bdce20841, ; 705 => android/text/Spanned
	i64 u0x8f43d8e91285e5d7, ; 706 => java/lang/IllegalAccessException
	i64 u0x8f51766d700c2991, ; 707 => crc645d80431ce5f73f11/GridLayoutSpanSizeLookup
	i64 u0x8f5224f15feb918a, ; 708 => crc64fcf28c0e24b4cc31/SwitchHandler_CheckedChangeListener
	i64 u0x8f597086f45114b7, ; 709 => com/google/crypto/tink/shaded/protobuf/WireFormat$FieldType
	i64 u0x8f6070b59054e406, ; 710 => androidx/core/view/OnApplyWindowInsetsListener
	i64 u0x8fc41936751c807d, ; 711 => crc645d80431ce5f73f11/CarouselViewAdapter_2
	i64 u0x9059b8948625bb9c, ; 712 => androidx/core/content/PermissionChecker
	i64 u0x90b4aeb45636cd6a, ; 713 => mono/android/runtime/OutputStreamAdapter
	i64 u0x90b7a39fee5a38a1, ; 714 => crc64fcf28c0e24b4cc31/SliderHandler_SeekBarChangeListener
	i64 u0x90c66f160d69bbf7, ; 715 => android/text/style/BulletSpan
	i64 u0x912b555aa0007288, ; 716 => android/view/ViewManager
	i64 u0x92188d393e2af2d2, ; 717 => java/lang/Throwable
	i64 u0x924fb937aac4a5a0, ; 718 => crc6488302ad6e9e4df1a/ImageLoaderCallback
	i64 u0x92a18b034310a8f6, ; 719 => com/google/crypto/tink/shaded/protobuf/GeneratedMessageLite
	i64 u0x92b59c839bc46278, ; 720 => java/lang/Thread
	i64 u0x92e0260f69f10ee8, ; 721 => androidx/browser/customtabs/CustomTabsSession
	i64 u0x935d88e2c2e5941f, ; 722 => crc6488302ad6e9e4df1a/MauiApplication
	i64 u0x93624b42fb99551b, ; 723 => android/widget/Filter
	i64 u0x9383311c4d9f82a7, ; 724 => android/renderscript/BaseObj
	i64 u0x93ac957223ce8c40, ; 725 => crc640a8d9a12ddbf2cf2/EnergySaverBroadcastReceiver
	i64 u0x93f1d66f25101f68, ; 726 => androidx/biometric/BiometricPrompt
	i64 u0x943a2b2e5130aba3, ; 727 => java/util/function/ToDoubleFunction
	i64 u0x9461b0401dbcf96c, ; 728 => android/app/Dialog
	i64 u0x94ab6271293e91f4, ; 729 => android/text/style/StrikethroughSpan
	i64 u0x951aa313de8b041c, ; 730 => crc64338477404e88479c/MauiViewPager
	i64 u0x9584fc24c466e188, ; 731 => android/graphics/Paint$Cap
	i64 u0x965bfaf1ff1da014, ; 732 => java/lang/ReflectiveOperationException
	i64 u0x96b236c6dfc74824, ; 733 => android/net/ConnectivityManager$NetworkCallback
	i64 u0x96cf68019297d3dd, ; 734 => mono/android/content/DialogInterface_OnDismissListenerImplementor
	i64 u0x9721e6ba29424ff0, ; 735 => android/view/inputmethod/PreviewableHandwritingGesture
	i64 u0x9776d2ad269f8528, ; 736 => com/google/android/material/internal/StaticLayoutBuilderConfigurer
	i64 u0x97ada2c2479a9b60, ; 737 => kotlin/reflect/KVisibility
	i64 u0x97c9d63fd14dcde7, ; 738 => android/widget/FilterQueryProvider
	i64 u0x97ec84fca1b732f0, ; 739 => mono/androidx/core/widget/NestedScrollView_OnScrollChangeListenerImplementor
	i64 u0x980b8a2662ef1cfc, ; 740 => androidx/biometric/BiometricManager$Authenticators
	i64 u0x9858654a6a15b73f, ; 741 => crc645d80431ce5f73f11/StartSingleSnapHelper
	i64 u0x988101eb35e8c40e, ; 742 => androidx/core/view/AccessibilityDelegateCompat
	i64 u0x9891a3a06e139546, ; 743 => androidx/navigation/ui/AppBarConfiguration$OnNavigateUpListener
	i64 u0x98ba110c6c57da31, ; 744 => java/lang/Float
	i64 u0x98c586f56c023bec, ; 745 => android/graphics/Bitmap$Config
	i64 u0x98ff485da7f0266f, ; 746 => com/google/android/material/imageview/ShapeableImageView
	i64 u0x9908090bdf73918a, ; 747 => androidx/lifecycle/Lifecycle
	i64 u0x990d68d24a8a5d1f, ; 748 => android/text/style/ParagraphStyle
	i64 u0x995f02becc4146fe, ; 749 => android/content/ClipData
	i64 u0x9969c631954df2e4, ; 750 => android/view/inputmethod/CorrectionInfo
	i64 u0x99b4bc4a856dc9da, ; 751 => android/content/pm/PackageManager
	i64 u0x99df91bab800c287, ; 752 => mono/android/runtime/InputStreamAdapter
	i64 u0x9a23c2d41060f81e, ; 753 => java/io/File
	i64 u0x9a3050da9641e7c4, ; 754 => crc6452ffdc5b34af3a0f/MauiDatePicker
	i64 u0x9a55c691985b1ff7, ; 755 => android/os/Parcelable$Creator
	i64 u0x9a68fa465ca8abf9, ; 756 => java/io/FileDescriptor
	i64 u0x9b91309f682756dc, ; 757 => crc6481e5b28a6b4dd87a/NativeCustomScrolLayout
	i64 u0x9baa5d4afdfeb64a, ; 758 => androidx/navigation/NavDeepLinkRequest
	i64 u0x9babc3bd2b21d8ad, ; 759 => crc6452ffdc5b34af3a0f/LocalizedDigitsKeyListener
	i64 u0x9bcea67d3cc298e1, ; 760 => androidx/core/content/res/ResourcesCompat
	i64 u0x9c437fa042ccf440, ; 761 => androidx/savedstate/SavedStateRegistry$SavedStateProvider
	i64 u0x9c9e4c72b56ff0f4, ; 762 => crc645d80431ce5f73f11/ReorderableItemsViewAdapter_2
	i64 u0x9cb6a0e63a122ff1, ; 763 => android/content/pm/ShortcutInfo
	i64 u0x9cebbb039a638f4d, ; 764 => android/graphics/BitmapFactory$Options
	i64 u0x9cfab72a71a77b1e, ; 765 => androidx/navigation/Navigator$Extras
	i64 u0x9cfb8dda71b9bbdb, ; 766 => mono/android/view/ViewGroup_OnHierarchyChangeListenerImplementor
	i64 u0x9d1f43b333e65305, ; 767 => android/text/Spannable
	i64 u0x9d5ba0f725aa462c, ; 768 => com/google/android/material/appbar/AppBarLayout$Behavior
	i64 u0x9db6accc46c9ce7f, ; 769 => java/util/function/Predicate
	i64 u0x9dbfa302c7baf9ec, ; 770 => android/text/GetChars
	i64 u0x9ddb6fe7564e2094, ; 771 => kotlin/reflect/KDeclarationContainer
	i64 u0x9de83fd8b85d70fc, ; 772 => android/widget/SectionIndexer
	i64 u0x9e10a0b3efa170dc, ; 773 => android/view/ContextThemeWrapper
	i64 u0x9e26f9c944b82e69, ; 774 => crc64338477404e88479c/GenericGlobalLayoutListener
	i64 u0x9e6dc3e8eedaf8a8, ; 775 => java/net/SocketException
	i64 u0x9e8497fc52a96d4d, ; 776 => android/graphics/PorterDuff
	i64 u0x9e91524221d7f1f3, ; 777 => com/microsoft/maui/PlatformMauiAppCompatActivity
	i64 u0x9ecc38fa7e43a0c8, ; 778 => androidx/fragment/app/FragmentContainer
	i64 u0x9f0d5fe44f9e0810, ; 779 => com/google/crypto/tink/shaded/protobuf/ByteString
	i64 u0x9f320c2c164ae334, ; 780 => java/io/FileNotFoundException
	i64 u0x9f33c13f946629e6, ; 781 => android/renderscript/Element
	i64 u0x9f4c9bf8c1f6ddb2, ; 782 => androidx/core/view/ViewPropertyAnimatorCompat
	i64 u0x9f5a6b54beec1a29, ; 783 => mono/android/view/View_OnScrollChangeListenerImplementor
	i64 u0x9f6540eddd1aefbd, ; 784 => android/net/ConnectivityManager
	i64 u0x9f950635a5c6617e, ; 785 => crc6452ffdc5b34af3a0f/MauiAppCompatEditText
	i64 u0x9fa1370a1b1093fa, ; 786 => java/lang/NullPointerException
	i64 u0x9fceb9720ff4752f, ; 787 => androidx/lifecycle/ViewModelStore
	i64 u0xa0413b32c00d8806, ; 788 => crc64354973402314325c/PlatformCarouselItem
	i64 u0xa07cbd8408019386, ; 789 => java/net/Proxy
	i64 u0xa0b3e998faac11c3, ; 790 => crc6479d6f9e48582dc67/PlatformScrollViewer
	i64 u0xa0c526ac93cdab5b, ; 791 => mono/androidx/appcompat/widget/ContentFrameLayout_OnAttachListenerImplementor
	i64 u0xa0cf83102ab6249f, ; 792 => crc640ec207abc449b2ca/ShellSearchViewAdapter_ObjectWrapper
	i64 u0xa0e8bade9ecc1b90, ; 793 => androidx/fragment/app/FragmentManager$OnBackStackChangedListener
	i64 u0xa0ef9facbe641466, ; 794 => androidx/core/view/ViewCompat
	i64 u0xa182bef0d9e54f40, ; 795 => android/graphics/PorterDuffColorFilter
	i64 u0xa1ead478a027c56c, ; 796 => android/animation/ValueAnimator
	i64 u0xa1f5df9f29ce40b8, ; 797 => androidx/navigation/Navigator
	i64 u0xa1f69eeebebd7ca5, ; 798 => android/widget/ProgressBar
	i64 u0xa24d07cd0d5c4f0f, ; 799 => android/animation/TimeInterpolator
	i64 u0xa24ee676f2aaec87, ; 800 => androidx/appcompat/widget/SearchView
	i64 u0xa2c344771af945fc, ; 801 => androidx/activity/FullyDrawnReporter
	i64 u0xa2f05a58c7d33dff, ; 802 => crc64354973402314325c/PlatformCarousel
	i64 u0xa34b4db9fa4732cc, ; 803 => android/graphics/drawable/InsetDrawable
	i64 u0xa3859b5ed9f780d4, ; 804 => androidx/appcompat/widget/LinearLayoutCompat
	i64 u0xa398e93d7065b828, ; 805 => kotlin/Function
	i64 u0xa3ad720d45785742, ; 806 => androidx/appcompat/view/menu/MenuView
	i64 u0xa3ce560621e954d3, ; 807 => crc640ec207abc449b2ca/ShellFlyoutTemplatedContentRenderer
	i64 u0xa3d005b2db469996, ; 808 => android/widget/RadioButton
	i64 u0xa3d3c9e462460eb7, ; 809 => android/graphics/Paint$Style
	i64 u0xa4414bb71bf7bc36, ; 810 => androidx/lifecycle/ViewModelProvider$Factory
	i64 u0xa44d184342676284, ; 811 => crc649ff9379e8ecbf267/ViewHolder
	i64 u0xa47433d85b440c29, ; 812 => androidx/core/util/Predicate
	i64 u0xa4cc8b3097166227, ; 813 => android/view/View$OnAttachStateChangeListener
	i64 u0xa4e745bf1607e5a9, ; 814 => android/opengl/Matrix
	i64 u0xa5080403dafe22a0, ; 815 => androidx/swiperefreshlayout/widget/SwipeRefreshLayout
	i64 u0xa5475b5d3e2dd34e, ; 816 => androidx/appcompat/widget/AppCompatAutoCompleteTextView
	i64 u0xa59db4b8b7dbe046, ; 817 => javax/net/ssl/SSLSession
	i64 u0xa66e0e0698158040, ; 818 => androidx/appcompat/app/AlertDialog$Builder
	i64 u0xa6794d1f84bf041d, ; 819 => crc64e1fb321c08285b90/TableViewRenderer
	i64 u0xa68cfba6b3bae773, ; 820 => android/provider/Settings$Global
	i64 u0xa6b282a2477038a5, ; 821 => androidx/swiperefreshlayout/widget/SwipeRefreshLayout$OnRefreshListener
	i64 u0xa71aafbfe7017e70, ; 822 => com/google/android/material/shape/MaterialShapeDrawable
	i64 u0xa757f83a95bc65d9, ; 823 => kotlin/reflect/KVariance
	i64 u0xa76f26c70ed71676, ; 824 => androidx/appcompat/app/ActionBar$TabListener
	i64 u0xa7e97a8804a923fd, ; 825 => androidx/security/crypto/MasterKey
	i64 u0xa7fa861f4f28ceae, ; 826 => crc645d80431ce5f73f11/CarouselViewOnScrollListener
	i64 u0xa824ab889bcafcd2, ; 827 => androidx/recyclerview/widget/RecyclerView$LayoutParams
	i64 u0xa865adbdd81d9951, ; 828 => java/io/OutputStream
	i64 u0xa86f66387eaee170, ; 829 => android/content/SharedPreferences
	i64 u0xa87b56b08c12f7a3, ; 830 => crc64a096dc44ad241142/PlatformTicker_DurationScaleListener
	i64 u0xa8ae8eda55fac132, ; 831 => crc64c0976fbcdb365652/CustomAccessibilityDelegate
	i64 u0xa8c8380ae261807d, ; 832 => android/widget/TextView$BufferType
	i64 u0xa8cc1540f74ab177, ; 833 => crc640a8d9a12ddbf2cf2/BatteryBroadcastReceiver
	i64 u0xa8d6159bcb046bd9, ; 834 => crc640ec207abc449b2ca/ScrollLayoutManager
	i64 u0xa94960ea73ff5ea8, ; 835 => androidx/navigation/NavGraphNavigator
	i64 u0xa95eae500754348a, ; 836 => java/net/SocketAddress
	i64 u0xa9ac09fff726bffd, ; 837 => android/graphics/Paint$Join
	i64 u0xa9acdba0129a6b21, ; 838 => crc645d80431ce5f73f11/GroupableItemsViewAdapter_2
	i64 u0xa9ce15e4e3a206da, ; 839 => android/text/TextWatcher
	i64 u0xaa1e83a09f2fc981, ; 840 => java/nio/Buffer
	i64 u0xaa3cafa21a3bea0f, ; 841 => androidx/viewpager/widget/ViewPager
	i64 u0xaa469f39e9e03bd4, ; 842 => androidx/lifecycle/ViewModelProvider$Factory$Companion
	i64 u0xaa46d09246372443, ; 843 => crc6452ffdc5b34af3a0f/ContentViewGroup
	i64 u0xaa75ead031784774, ; 844 => javax/net/ssl/SSLSocketFactory
	i64 u0xaa7b11cdd6000676, ; 845 => android/provider/Settings
	i64 u0xaa8e001a129a7284, ; 846 => com/google/android/material/navigation/NavigationBarPresenter
	i64 u0xaacdc63773b92c2d, ; 847 => androidx/coordinatorlayout/widget/CoordinatorLayout$LayoutParams
	i64 u0xab2eb899e74adc32, ; 848 => androidx/recyclerview/widget/RecyclerView$RecyclerListener
	i64 u0xabc3cd0f40f748aa, ; 849 => java/lang/String
	i64 u0xabe6d6ebc681adc2, ; 850 => android/runtime/XmlReaderPullParser
	i64 u0xac047f65cff07e9e, ; 851 => android/graphics/PorterDuffXfermode
	i64 u0xac7bbd754d805e27, ; 852 => android/graphics/BitmapFactory
	i64 u0xac7c7e1bdd46f12a, ; 853 => androidx/recyclerview/widget/RecyclerView$ItemAnimator
	i64 u0xac86da7d9cd4863e, ; 854 => androidx/appcompat/app/ActionBar
	i64 u0xac9902bb0e4c5217, ; 855 => java/lang/IllegalArgumentException
	i64 u0xacbf549cdef93bef, ; 856 => java/net/HttpURLConnection
	i64 u0xad8d10280dfccd71, ; 857 => crc6452ffdc5b34af3a0f/ViewFragment
	i64 u0xadb29d4c73f24a8c, ; 858 => com/google/android/material/button/MaterialButton$OnCheckedChangeListener
	i64 u0xae815a309f9e325f, ; 859 => android/renderscript/ScriptIntrinsicBlur
	i64 u0xae8c8ca30483ee35, ; 860 => androidx/navigation/NavBackStackEntry
	i64 u0xaf159c0e995e4702, ; 861 => com/google/android/material/shape/MaterialShapeDrawable$MaterialShapeDrawableState
	i64 u0xaf1679a039f6fbb9, ; 862 => androidx/appcompat/widget/Toolbar
	i64 u0xaf21fa4d321c1cba, ; 863 => androidx/core/text/PrecomputedTextCompat$Params
	i64 u0xafdf04e9229184a3, ; 864 => com/google/android/material/shape/ShapeAppearanceModel$Builder
	i64 u0xb00eab597b120f1c, ; 865 => android/view/KeyboardShortcutGroup
	i64 u0xb02badeb1c97535c, ; 866 => java/lang/Integer
	i64 u0xb0888408f321b943, ; 867 => androidx/appcompat/app/AppCompatDialog
	i64 u0xb0e934994bddcba7, ; 868 => android/view/inputmethod/ExtractedTextRequest
	i64 u0xb18d71343ca8e96f, ; 869 => java/lang/Exception
	i64 u0xb209d55b71ead22c, ; 870 => android/view/animation/Interpolator
	i64 u0xb254043df975968d, ; 871 => mono/androidx/core/view/ActionProvider_SubUiVisibilityListenerImplementor
	i64 u0xb2a2c4218a8e7d1d, ; 872 => kotlin/sequences/Sequence
	i64 u0xb2b2e615ea3f507a, ; 873 => crc6452ffdc5b34af3a0f/PlatformTouchGraphicsView
	i64 u0xb2bfba2c56d4b5dc, ; 874 => androidx/recyclerview/widget/RecyclerView$LayoutManager$Properties
	i64 u0xb2c38b7ada0dc021, ; 875 => androidx/appcompat/widget/TintTypedArray
	i64 u0xb2e5c87b55a56110, ; 876 => android/content/LocusId
	i64 u0xb30a9983aabe769e, ; 877 => microsoft/maui/essentials/fileProvider
	i64 u0xb329f158c70397be, ; 878 => androidx/navigation/NavigatorState
	i64 u0xb3369008f4fe1419, ; 879 => androidx/appcompat/app/AppCompatActivity
	i64 u0xb3693705985e8b13, ; 880 => androidx/core/view/accessibility/AccessibilityViewCommand
	i64 u0xb374dc7d92c34054, ; 881 => android/webkit/WebViewClient
	i64 u0xb377ef937a0bfe7d, ; 882 => androidx/navigation/NavController
	i64 u0xb378438cc777bbf0, ; 883 => android/view/WindowManager$LayoutParams
	i64 u0xb3cc0a125aff5a7d, ; 884 => java/util/concurrent/atomic/AtomicReference
	i64 u0xb3d4cbc19434ef12, ; 885 => android/util/SizeF
	i64 u0xb3ea8750328eba6b, ; 886 => android/graphics/RectF
	i64 u0xb3f543d691f25c2c, ; 887 => android/content/DialogInterface$OnShowListener
	i64 u0xb40ce654b6388f81, ; 888 => java/lang/reflect/Field
	i64 u0xb42026236b8f4f29, ; 889 => androidx/drawerlayout/widget/DrawerLayout
	i64 u0xb43bff1eb757d5fb, ; 890 => org/xmlpull/v1/XmlPullParser
	i64 u0xb449ae5af4bca8d8, ; 891 => androidx/browser/customtabs/EngagementSignalsCallback
	i64 u0xb44c711ce591a772, ; 892 => mono/android/view/View_OnTouchListenerImplementor
	i64 u0xb4792773637390c2, ; 893 => com/google/android/material/checkbox/MaterialCheckBox$OnCheckedStateChangedListener
	i64 u0xb4f47430f94297c1, ; 894 => crc6452ffdc5b34af3a0f/MauiPageControl
	i64 u0xb4fc3e21cc054bc7, ; 895 => android/graphics/Paint
	i64 u0xb54eff3a21a3eefa, ; 896 => androidx/loader/app/LoaderManager$LoaderCallbacks
	i64 u0xb56e3efa284790aa, ; 897 => android/view/WindowInsets
	i64 u0xb56e879bb5d599f3, ; 898 => android/window/OnBackInvokedCallback
	i64 u0xb570f3bf7dea9b6e, ; 899 => mono/androidx/drawerlayout/widget/DrawerLayout_DrawerListenerImplementor
	i64 u0xb5ac04c19de8aabf, ; 900 => android/widget/AbsListView
	i64 u0xb5cc78a6da81db86, ; 901 => androidx/core/view/ScaleGestureDetectorCompat
	i64 u0xb609cd2eea685fb3, ; 902 => androidx/navigation/ui/AppBarConfiguration$Builder
	i64 u0xb6425fca959ab57e, ; 903 => android/text/TextUtils$TruncateAt
	i64 u0xb6880deb4171acbc, ; 904 => com/google/android/material/shape/EdgeTreatment
	i64 u0xb69237f2a9d74c94, ; 905 => mono/android/view/View_OnKeyListenerImplementor
	i64 u0xb69317d4cbae2478, ; 906 => android/content/res/Configuration
	i64 u0xb6b11675684b5f05, ; 907 => crc6488302ad6e9e4df1a/ImageLoaderCallbackBase_1
	i64 u0xb6ea91db24be70cd, ; 908 => com/microsoft/maui/PlatformWrapperView
	i64 u0xb76b9ac76caa5270, ; 909 => crc64e1fb321c08285b90/FrameRenderer
	i64 u0xb773bd566b4f471e, ; 910 => crc64338477404e88479c/GenericAnimatorListener
	i64 u0xb77aae9e2e13bfcc, ; 911 => android/app/Service
	i64 u0xb79687aac992f83a, ; 912 => androidx/viewpager2/adapter/FragmentViewHolder
	i64 u0xb7f60ace3fa0816b, ; 913 => android/view/Window
	i64 u0xb7fc24ca8fecd2c5, ; 914 => mono/android/view/View_OnAttachStateChangeListenerImplementor
	i64 u0xb8df224d6b778ca3, ; 915 => android/view/View
	i64 u0xb8f2521e5d90246f, ; 916 => crc64338477404e88479c/ToolbarExtensions_ToolbarTitleIconImageView
	i64 u0xb952c578f3377537, ; 917 => crc64338477404e88479c/ModalNavigationManager_ModalFragment_CustomComponentDialog_CallBack
	i64 u0xb97377cead771d2e, ; 918 => com/google/android/material/appbar/AppBarLayout$OnOffsetChangedListener
	i64 u0xb9cdbe6eddac55c0, ; 919 => mono/com/google/android/material/navigation/NavigationView_OnNavigationItemSelectedListenerImplementor
	i64 u0xb9e48b25660487c5, ; 920 => javax/net/ssl/TrustManager
	i64 u0xba263234cbab6d9a, ; 921 => androidx/navigation/NavDestination$DeepLinkMatch
	i64 u0xba79fa9c8b5d21f6, ; 922 => android/provider/MediaStore$Audio
	i64 u0xbacf55cfc50d3d0b, ; 923 => kotlin/reflect/KParameter$Kind
	i64 u0xbb41c32523812652, ; 924 => android/widget/Button
	i64 u0xbb84ccbe48f6c18b, ; 925 => android/os/Looper
	i64 u0xbbaf4b15fe6e0964, ; 926 => android/text/SpannableString
	i64 u0xbc201330f4acc6fb, ; 927 => android/widget/TimePicker
	i64 u0xbc23f0c88f3b93bb, ; 928 => android/webkit/WebResourceError
	i64 u0xbc43c8801b6fe1d9, ; 929 => crc649ff9379e8ecbf267/SpaceItemDecoration
	i64 u0xbc7639d7badc3890, ; 930 => androidx/recyclerview/widget/ItemTouchHelper$Callback
	i64 u0xbc7d00ca5216ea6a, ; 931 => crc64ba438d8f48cf7e75/IntermediateActivity
	i64 u0xbc89a6074f33c9ca, ; 932 => androidx/core/view/accessibility/AccessibilityNodeInfoCompat$CollectionItemInfoCompat
	i64 u0xbd8eeb1678aa451f, ; 933 => androidx/core/app/TaskStackBuilder
	i64 u0xbdda3de944afbbe2, ; 934 => androidx/navigation/NavHostController
	i64 u0xbe127f11e4684314, ; 935 => crc649ff9379e8ecbf267/CustomImageView
	i64 u0xbe3cafe01b7bf4f6, ; 936 => com/google/crypto/tink/shaded/protobuf/CodedInputStream
	i64 u0xbf2634fa5f7ca77a, ; 937 => mono/android/widget/TextView_OnEditorActionListenerImplementor
	i64 u0xbf6d427143271cb3, ; 938 => java/lang/Object
	i64 u0xbf991567fd0a7a64, ; 939 => com/google/crypto/tink/shaded/protobuf/MessageLiteOrBuilder
	i64 u0xbf9dae2beff68075, ; 940 => android/graphics/Insets
	i64 u0xbfcccc29cac8e8a1, ; 941 => mono/androidx/activity/contextaware/OnContextAvailableListenerImplementor
	i64 u0xbfee75e113b64f18, ; 942 => android/widget/SpinnerAdapter
	i64 u0xc00f4c2f11efdcff, ; 943 => java/lang/ClassNotFoundException
	i64 u0xc012d4a9d397728a, ; 944 => com/google/android/material/shape/ShapeAppearanceModel
	i64 u0xc0252c5c6e843dc5, ; 945 => android/provider/MediaStore$Video$Media
	i64 u0xc0500a5415d61b75, ; 946 => crc6481e5b28a6b4dd87a/NativeSnapLayout_FlingGestureListener
	i64 u0xc095e5da02b35ab7, ; 947 => androidx/core/view/accessibility/AccessibilityWindowInfoCompat
	i64 u0xc0b44fbbc2895d38, ; 948 => kotlin/jvm/internal/DefaultConstructorMarker
	i64 u0xc0d2632c9e89e62f, ; 949 => crc64e1fb321c08285b90/ListViewRenderer_Container
	i64 u0xc0f8739dda93c69d, ; 950 => androidx/navigation/NavAction
	i64 u0xc18723826b70e521, ; 951 => java/util/concurrent/Executors
	i64 u0xc194cf35700f24d1, ; 952 => android/view/animation/AnimationSet
	i64 u0xc1a43ce814bd6203, ; 953 => android/content/ClipData$Item
	i64 u0xc1a807325c15cf73, ; 954 => android/graphics/Bitmap
	i64 u0xc2512364d51a7359, ; 955 => android/widget/SeekBar
	i64 u0xc2699473eca9d329, ; 956 => com/google/android/material/appbar/CollapsingToolbarLayout$StaticLayoutBuilderConfigurer
	i64 u0xc288a8550f7ef636, ; 957 => android/view/SubMenu
	i64 u0xc2a8e50a5f08afc6, ; 958 => mono/java/lang/RunnableImplementor
	i64 u0xc2d2916e08f7fcd5, ; 959 => android/view/WindowInsetsAnimationController
	i64 u0xc3448e73cf4fda29, ; 960 => com/google/android/material/bottomnavigation/BottomNavigationItemView
	i64 u0xc37016cca1d2c171, ; 961 => androidx/core/content/res/ResourcesCompat$FontCallback
	i64 u0xc3a0d1e70fc04a12, ; 962 => androidx/fragment/app/strictmode/Violation
	i64 u0xc3eb0cbb47f178b9, ; 963 => java/lang/Enum
	i64 u0xc3f264557c647077, ; 964 => java/util/Timer
	i64 u0xc410281d3f079bb9, ; 965 => kotlin/reflect/KClassifier
	i64 u0xc430119c0a46ebac, ; 966 => androidx/browser/customtabs/CustomTabsSession$PendingSession
	i64 u0xc452ee0901c19a4d, ; 967 => android/graphics/drawable/LayerDrawable
	i64 u0xc457b8ed18fcdc55, ; 968 => crc64159f3caeb1269279/MauiSemanticOrderView
	i64 u0xc4667e0e3dcb2142, ; 969 => crc6452ffdc5b34af3a0f/MauiPicker
	i64 u0xc4672e7cec372c98, ; 970 => crc64f5844edce43316e7/PlatformRotatorItem
	i64 u0xc48693ef0b040f12, ; 971 => com/google/crypto/tink/shaded/protobuf/Internal$FloatList
	i64 u0xc4998152ef9eb5a5, ; 972 => kotlin/reflect/KParameter
	i64 u0xc4e1d7e4d6990b04, ; 973 => android/database/Cursor
	i64 u0xc509661f018da630, ; 974 => androidx/appcompat/widget/AppCompatCheckBox
	i64 u0xc5369e1c8e0778b2, ; 975 => com/google/android/material/appbar/AppBarLayout$LayoutParams
	i64 u0xc606e1058d794da9, ; 976 => java/lang/AutoCloseable
	i64 u0xc60c9333403c3d74, ; 977 => crc643f2b18b2570eaa5a/PlatformGraphicsView
	i64 u0xc60ed5dc5daaa06c, ; 978 => crc64f5844edce43316e7/SfRotatorFlingGestureListener
	i64 u0xc63933355b4d467d, ; 979 => android/widget/CompoundButton
	i64 u0xc63d7737310ec2d2, ; 980 => androidx/appcompat/content/res/AppCompatResources
	i64 u0xc63d8ed5f16cff9f, ; 981 => android/widget/DatePicker
	i64 u0xc66b28b06af00e09, ; 982 => crc640ec207abc449b2ca/ShellItemRendererBase
	i64 u0xc676eb12115a0cfd, ; 983 => java/util/concurrent/Callable
	i64 u0xc68a0ac78e093ec5, ; 984 => crc64fcf28c0e24b4cc31/SearchBarHandler_FocusChangeListener
	i64 u0xc6a64908f989db1f, ; 985 => java/util/Spliterator
	i64 u0xc6dcfddd28ee4b89, ; 986 => mono/android/widget/AdapterView_OnItemClickListenerImplementor
	i64 u0xc721b83c1b0725c6, ; 987 => crc64e1fb321c08285b90/ViewCellRenderer_ViewCellContainer
	i64 u0xc7352532882255e4, ; 988 => androidx/activity/result/contract/ActivityResultContract
	i64 u0xc77241534a220e8b, ; 989 => android/view/inputmethod/TextAttribute
	i64 u0xc7e7d72888a9cbd1, ; 990 => android/view/accessibility/AccessibilityWindowInfo
	i64 u0xc7f4eb6d046454cc, ; 991 => android/net/NetworkRequest$Builder
	i64 u0xc83910308b360de2, ; 992 => androidx/appcompat/widget/SwitchCompat
	i64 u0xc83bcc1744de4118, ; 993 => crc640ec207abc449b2ca/ShellToolbarTracker
	i64 u0xc83f7693ddf5a6cb, ; 994 => crc640ec207abc449b2ca/ShellSectionRenderer_ViewPagerPageChanged
	i64 u0xc8c11b250ce4b41e, ; 995 => android/view/ScaleGestureDetector$SimpleOnScaleGestureListener
	i64 u0xc8d5c33e136ee12d, ; 996 => androidx/appcompat/widget/AppCompatImageButton
	i64 u0xc8dabb1ec9568e80, ; 997 => com/google/android/material/bottomsheet/BottomSheetBehavior
	i64 u0xc9555246542a99da, ; 998 => android/os/Binder
	i64 u0xc99e090e60d66f58, ; 999 => java/io/StringWriter
	i64 u0xca35caf567cfa745, ; 1000 => java/util/Collection
	i64 u0xca385c225e4e7cd1, ; 1001 => java/nio/charset/Charset
	i64 u0xca6532e26e36e7d3, ; 1002 => crc64396a3fe5f8138e3f/KeepAliveService
	i64 u0xcabf871ef950ad91, ; 1003 => android/view/View$OnClickListener
	i64 u0xcb502115d02cfb31, ; 1004 => androidx/activity/OnBackPressedCallback
	i64 u0xcb8d1d6001681e7e, ; 1005 => crc645d80431ce5f73f11/TemplatedItemViewHolder
	i64 u0xcbbe7354a1b9c7e3, ; 1006 => androidx/fragment/app/DialogFragment
	i64 u0xcbc34fae61c9b002, ; 1007 => androidx/recyclerview/widget/RecyclerView$ViewHolder
	i64 u0xcc306823503920e9, ; 1008 => android/app/Application
	i64 u0xcc3c26b070861b6e, ; 1009 => android/view/ViewPropertyAnimator
	i64 u0xcc94b924b6f55b54, ; 1010 => android/content/pm/ShortcutManager
	i64 u0xcdefa3530f990c69, ; 1011 => androidx/recyclerview/widget/ItemTouchUIUtil
	i64 u0xcdf4fe3b1db1eeb0, ; 1012 => android/view/MenuItem
	i64 u0xce3b78826c33a15b, ; 1013 => android/view/View$MeasureSpec
	i64 u0xce4b3c9d4e20935c, ; 1014 => androidx/navigation/ui/AppBarConfiguration
	i64 u0xce8f455b2f4af3f3, ; 1015 => crc6452ffdc5b34af3a0f/MauiWebChromeClient
	i64 u0xcee19936e5b7407d, ; 1016 => android/graphics/Xfermode
	i64 u0xcefb45e7022310ea, ; 1017 => com/microsoft/maui/HybridJavaScriptInterface
	i64 u0xcf4a3917e4797c13, ; 1018 => androidx/viewpager2/adapter/FragmentStateAdapter$FragmentTransactionCallback$OnPostEventListener
	i64 u0xcf5118f37190e6ff, ; 1019 => androidx/fragment/app/FragmentManager$FragmentLifecycleCallbacks
	i64 u0xcf9f8d71d3de4d65, ; 1020 => android/view/inputmethod/InputContentInfo
	i64 u0xcfb9636813513757, ; 1021 => mono/androidx/appcompat/widget/SearchView_OnQueryTextListenerImplementor
	i64 u0xcff439665ffdae38, ; 1022 => java/security/GeneralSecurityException
	i64 u0xd0733c320aa3ff03, ; 1023 => mono/android/view/View_OnLayoutChangeListenerImplementor
	i64 u0xd0e722c3b0bde16f, ; 1024 => android/graphics/Typeface
	i64 u0xd0fdb8dd4573f5f7, ; 1025 => android/window/BackEvent
	i64 u0xd193130f8c9d43f8, ; 1026 => crc649ff9379e8ecbf267/PlatformCarouselItem
	i64 u0xd1b288a9c7bb8f53, ; 1027 => java/lang/Double
	i64 u0xd1bb565fc45586eb, ; 1028 => android/app/PendingIntent
	i64 u0xd1c6f898302a054f, ; 1029 => crc640ec207abc449b2ca/ShellSearchViewAdapter_CustomFilter
	i64 u0xd1de5b64b400590a, ; 1030 => android/widget/OverScroller
	i64 u0xd202c8ea2a504e12, ; 1031 => android/webkit/WebSettings
	i64 u0xd22f5c0c8def47ff, ; 1032 => android/preference/PreferenceManager
	i64 u0xd23c2ba7064dd9dd, ; 1033 => mono/android/app/DatePickerDialog_OnDateSetListenerImplementor
	i64 u0xd26195c132985edf, ; 1034 => crc6452ffdc5b34af3a0f/MauiHorizontalScrollView
	i64 u0xd2812bc5135ab252, ; 1035 => java/security/KeyStoreException
	i64 u0xd294b4da088b36d0, ; 1036 => androidx/core/util/Consumer
	i64 u0xd3216151c34fd6f8, ; 1037 => androidx/navigation/ui/NavigationUI
	i64 u0xd37bd51464b51f79, ; 1038 => android/graphics/drawable/RippleDrawable
	i64 u0xd39c770b67de9183, ; 1039 => android/app/AlertDialog
	i64 u0xd3c43ee198e77de2, ; 1040 => androidx/appcompat/view/menu/MenuBuilder
	i64 u0xd3f5f95676296ca4, ; 1041 => javax/crypto/BadPaddingException
	i64 u0xd420aecb035ca006, ; 1042 => crc640360c8a960a6805b/CustomAccessibilityDelegate
	i64 u0xd432452f66ff95d4, ; 1043 => javax/crypto/Cipher
	i64 u0xd538384fb20ae66c, ; 1044 => java/text/DecimalFormat
	i64 u0xd59ecec99fd063b4, ; 1045 => androidx/navigation/NavOptions
	i64 u0xd5a28b8fa6d48e71, ; 1046 => android/os/Build
	i64 u0xd5bfeae2074a5b36, ; 1047 => android/widget/Filter$FilterResults
	i64 u0xd5c9cefa409e7395, ; 1048 => android/text/style/AbsoluteSizeSpan
	i64 u0xd6880b1e41bf57b5, ; 1049 => java/io/Reader
	i64 u0xd6ec414c6f0409db, ; 1050 => androidx/drawerlayout/widget/DrawerLayout$LayoutParams
	i64 u0xd73eadb606b3f155, ; 1051 => androidx/navigation/NavigatorProvider
	i64 u0xd758f43330d4e0ad, ; 1052 => android/graphics/drawable/Icon
	i64 u0xd7bf0ca2c70de05c, ; 1053 => android/util/DisplayMetrics
	i64 u0xd7d412ecfd847e8d, ; 1054 => android/view/WindowInsetsAnimation
	i64 u0xd7e1e4845540748c, ; 1055 => crc640ec207abc449b2ca/ShellSearchView_ClipDrawableWrapper
	i64 u0xd7f6c403483ad98d, ; 1056 => kotlinx/serialization/encoding/CompositeEncoder
	i64 u0xd86b5dab7ae26414, ; 1057 => com/google/crypto/tink/shaded/protobuf/Internal$EnumLite
	i64 u0xd88443e11b25ea33, ; 1058 => java/util/function/UnaryOperator
	i64 u0xd8aaec9071b6abf2, ; 1059 => crc645d80431ce5f73f11/CarouselSpacingItemDecoration
	i64 u0xd8ab954c8665d775, ; 1060 => androidx/core/view/accessibility/AccessibilityNodeInfoCompat$RangeInfoCompat
	i64 u0xd95d6dc3cf850ced, ; 1061 => android/view/View$AccessibilityDelegate
	i64 u0xd9894fafe0aa82b4, ; 1062 => mono/androidx/appcompat/widget/Toolbar_OnMenuItemClickListenerImplementor
	i64 u0xd9aebd86bdaf8ad1, ; 1063 => androidx/fragment/app/FragmentResultListener
	i64 u0xd9af3f71e595db52, ; 1064 => kotlin/reflect/KTypeParameter
	i64 u0xd9bf98f7765a21b1, ; 1065 => android/graphics/drawable/shapes/Shape
	i64 u0xd9f80c7ded36b670, ; 1066 => crc64e1fb321c08285b90/ViewRenderer
	i64 u0xda24dc0f1c8c18bc, ; 1067 => crc640ec207abc449b2ca/ShellItemRenderer
	i64 u0xda68913bc1c106cd, ; 1068 => com/microsoft/maui/PlatformLineHeightSpan
	i64 u0xdbb1cb3e761b7615, ; 1069 => crc645d80431ce5f73f11/PositionalSmoothScroller
	i64 u0xdbb76cb30e7b6509, ; 1070 => android/content/ContentResolver
	i64 u0xdc132bd7fe147400, ; 1071 => androidx/core/graphics/drawable/DrawableCompat
	i64 u0xdc5c62ea80134007, ; 1072 => android/view/inputmethod/TextSnapshot
	i64 u0xdcbab16d05f31663, ; 1073 => android/app/SearchableInfo
	i64 u0xdcc422345acdb12f, ; 1074 => com/google/crypto/tink/shaded/protobuf/ExtensionLite
	i64 u0xdccf355ea3232d20, ; 1075 => crc6486af4e8104107bae/AppCompatEditTextExt
	i64 u0xdce51d0c09d90fa8, ; 1076 => com/google/android/material/navigation/NavigationBarMenuView
	i64 u0xdd20fdef9c9ddad0, ; 1077 => com/microsoft/maui/MauiViewGroup
	i64 u0xdd3b9929bc462c67, ; 1078 => crc645d80431ce5f73f11/NongreedySnapHelper
	i64 u0xdd463626e67f1bf6, ; 1079 => androidx/loader/app/LoaderManager
	i64 u0xdd7919f89d55038d, ; 1080 => crc6481e5b28a6b4dd87a/NativeSnapLayout
	i64 u0xdd812f1d4afa427b, ; 1081 => java/lang/UnsupportedOperationException
	i64 u0xddbb492979f5c092, ; 1082 => com/google/android/material/bottomnavigation/BottomNavigationView$OnNavigationItemReselectedListener
	i64 u0xdde3ded0ec573476, ; 1083 => androidx/recyclerview/widget/RecyclerView$Recycler
	i64 u0xddeb5e38523313ea, ; 1084 => android/content/DialogInterface$OnKeyListener
	i64 u0xddf4f786f446ed51, ; 1085 => crc649c9364508479c7e4/NativeSnapLayout
	i64 u0xde368bd1eb112b93, ; 1086 => androidx/security/crypto/MasterKey$KeyScheme
	i64 u0xde36efb42da7cc2d, ; 1087 => javax/net/ssl/SSLSessionContext
	i64 u0xde661e8331fec958, ; 1088 => androidx/appcompat/graphics/drawable/DrawerArrowDrawable
	i64 u0xde77d411368f787e, ; 1089 => crc64338477404e88479c/InnerScaleListener
	i64 u0xde9b5e8488610564, ; 1090 => android/view/GestureDetector$SimpleOnGestureListener
	i64 u0xdf57213be15322dd, ; 1091 => android/graphics/Paint$FontMetrics
	i64 u0xdf7a8cd0384eaf2c, ; 1092 => android/view/animation/DecelerateInterpolator
	i64 u0xdfecd839d4f3e1a4, ; 1093 => androidx/appcompat/widget/AppCompatButton
	i64 u0xdfef58a3c722a78d, ; 1094 => android/view/ContextMenu
	i64 u0xdffc382828625f66, ; 1095 => crc649ff9379e8ecbf267/PlatformCarousel
	i64 u0xe024b538ad65ea66, ; 1096 => java/util/function/Consumer
	i64 u0xe0446bf91fb0c2dd, ; 1097 => java/lang/NoClassDefFoundError
	i64 u0xe092996eb02be58a, ; 1098 => android/webkit/RenderProcessGoneDetail
	i64 u0xe0b2becf1de762d8, ; 1099 => kotlinx/serialization/DeserializationStrategy
	i64 u0xe0b600ed9de21982, ; 1100 => com/google/android/material/appbar/AppBarLayout$LiftOnScrollListener
	i64 u0xe0f47e92347d97e9, ; 1101 => android/os/Parcelable
	i64 u0xe116bc26f4f89e46, ; 1102 => androidx/fragment/app/FragmentFactory
	i64 u0xe149f6bc65d447d8, ; 1103 => androidx/recyclerview/widget/RecyclerView$SmoothScroller$Action
	i64 u0xe156c210e126089c, ; 1104 => android/view/ViewStructure
	i64 u0xe1b04ab6156538aa, ; 1105 => crc64e1fb321c08285b90/CellRenderer_RendererHolder
	i64 u0xe1b3c5871398eb28, ; 1106 => java/nio/channels/FileChannel
	i64 u0xe1bb787ca7ca5fee, ; 1107 => androidx/appcompat/app/AppCompatCallback
	i64 u0xe1bf08ed09c2c547, ; 1108 => android/widget/Filterable
	i64 u0xe1c84d8d5b9434cc, ; 1109 => crc64f5844edce43316e7/TabStrip
	i64 u0xe1e9b8b006533b8c, ; 1110 => crc6452ffdc5b34af3a0f/WebViewExtensions_JavascriptResult
	i64 u0xe22bb95540a673ba, ; 1111 => android/window/OnBackInvokedDispatcher
	i64 u0xe2879b51003029a9, ; 1112 => androidx/security/crypto/EncryptedSharedPreferences
	i64 u0xe28cd0a2e6de00c1, ; 1113 => java/security/KeyStore
	i64 u0xe29a195887c68820, ; 1114 => javax/crypto/Mac
	i64 u0xe324013d7e39b88a, ; 1115 => mono/android/content/DialogInterface_OnCancelListenerImplementor
	i64 u0xe351dccbfffb7df1, ; 1116 => crc64338477404e88479c/FragmentContainer
	i64 u0xe37bab6623ca3f34, ; 1117 => androidx/lifecycle/ViewModel
	i64 u0xe3843bf91193455c, ; 1118 => android/util/SparseArray
	i64 u0xe38528954b158fff, ; 1119 => java/util/concurrent/Executor
	i64 u0xe39829b35e720e04, ; 1120 => java/util/function/IntConsumer
	i64 u0xe3b32b29aed12354, ; 1121 => mono/com/google/android/material/checkbox/MaterialCheckBox_OnErrorChangedListenerImplementor
	i64 u0xe437ac3d638a3fef, ; 1122 => android/text/method/BaseKeyListener
	i64 u0xe4ad6aa98d2cce4c, ; 1123 => crc6479d6f9e48582dc67/NativeTreeViewScrollView
	i64 u0xe4c5b0a99cb44963, ; 1124 => kotlin/reflect/KTypeProjection$Companion
	i64 u0xe4e8702fce78eb3a, ; 1125 => crc640ec207abc449b2ca/ShellSearchViewAdapter
	i64 u0xe50fb4f0adb1330f, ; 1126 => android/widget/ImageView
	i64 u0xe5198b3185c5450a, ; 1127 => android/text/NoCopySpan
	i64 u0xe57e063876d83762, ; 1128 => android/provider/MediaStore$Video
	i64 u0xe59c130e7d1e4ac3, ; 1129 => java/security/SecureRandom
	i64 u0xe635a54b0edb478c, ; 1130 => android/view/inputmethod/HandwritingGesture
	i64 u0xe663c278c572f570, ; 1131 => android/database/CharArrayBuffer
	i64 u0xe66e73e6f14e03d2, ; 1132 => android/widget/AdapterView$OnItemLongClickListener
	i64 u0xe6b76c398e304c92, ; 1133 => kotlin/coroutines/Continuation
	i64 u0xe6cd200754f8f60a, ; 1134 => android/view/Window$Callback
	i64 u0xe6d0135d38ccb41c, ; 1135 => androidx/appcompat/widget/LinearLayoutCompat$LayoutParams
	i64 u0xe72468967b13cd11, ; 1136 => androidx/appcompat/view/ActionMode
	i64 u0xe7452a6f5c925f12, ; 1137 => androidx/viewpager/widget/ViewPager$OnPageChangeListener
	i64 u0xe79198d17cd61fdd, ; 1138 => android/content/pm/PackageInfo
	i64 u0xe79ac91277736a72, ; 1139 => androidx/cursoradapter/widget/CursorAdapter
	i64 u0xe7b02a99cc948463, ; 1140 => crc64f5844edce43316e7/ProTimer
	i64 u0xe7c5168fd08808ad, ; 1141 => android/content/res/AssetFileDescriptor
	i64 u0xe7cd116bc6268309, ; 1142 => mono/com/google/android/material/tabs/TabLayout_BaseOnTabSelectedListenerImplementor
	i64 u0xe7f8d72d37eced45, ; 1143 => android/view/View$OnDragListener
	i64 u0xe80bc29eab60a114, ; 1144 => crc64f5844edce43316e7/ItemViewHolder
	i64 u0xe81ccd56d897dfbf, ; 1145 => android/content/DialogInterface$OnMultiChoiceClickListener
	i64 u0xe86c900b9d4ca193, ; 1146 => com/google/android/material/bottomsheet/BottomSheetBehavior$BottomSheetCallback
	i64 u0xe89da97b609fddcb, ; 1147 => kotlinx/coroutines/CoroutineScope
	i64 u0xe8b52a7318e34a5d, ; 1148 => androidx/core/view/WindowCompat
	i64 u0xe8c975a4b0a27974, ; 1149 => androidx/lifecycle/MutableLiveData
	i64 u0xe8cbe514aeeebda7, ; 1150 => com/google/android/material/navigation/NavigationBarItemView
	i64 u0xe8d0c30ab85673ff, ; 1151 => android/view/View$OnTouchListener
	i64 u0xe9386aaf92488cd7, ; 1152 => android/widget/EdgeEffect
	i64 u0xe94dd9d7a0bada9f, ; 1153 => android/content/res/AssetManager
	i64 u0xe94e56d31bbb02b6, ; 1154 => com/google/android/material/navigation/NavigationBarView$OnItemReselectedListener
	i64 u0xe9653944752c2a44, ; 1155 => com/google/crypto/tink/shaded/protobuf/MessageLite$Builder
	i64 u0xe9a6a557012633af, ; 1156 => crc64338477404e88479c/DragAndDropGestureHandler
	i64 u0xe9f1e6df0de3646b, ; 1157 => androidx/cardview/widget/CardView
	i64 u0xea404e10a903dbb8, ; 1158 => androidx/navigation/NavViewModelStoreProvider
	i64 u0xea429b6c352c1c1a, ; 1159 => android/view/animation/TranslateAnimation
	i64 u0xea728e0f517c558e, ; 1160 => kotlin/reflect/KClass
	i64 u0xea77581d05ee4142, ; 1161 => android/view/ViewTreeObserver$OnGlobalLayoutListener
	i64 u0xeaeb4c8036a90f29, ; 1162 => crc640a8d9a12ddbf2cf2/DeviceDisplayImplementation_Listener
	i64 u0xeb6b392245a7f947, ; 1163 => androidx/appcompat/widget/ContentFrameLayout$OnAttachListener
	i64 u0xeb82145dcac4c559, ; 1164 => java/lang/Long
	i64 u0xeb918642e3f3d0ee, ; 1165 => com/google/android/material/appbar/MaterialToolbar
	i64 u0xebe39d8298b84309, ; 1166 => androidx/lifecycle/Lifecycle$State
	i64 u0xebedf98b069c8347, ; 1167 => crc6450d00504b1424cab/MainApplication
	i64 u0xec22bd1eec0c8ed7, ; 1168 => android/renderscript/Type
	i64 u0xec423b5666e4a47b, ; 1169 => androidx/appcompat/app/AlertDialog_IDialogInterfaceOnMultiChoiceClickListenerImplementor
	i64 u0xec8b276c12c354ff, ; 1170 => android/widget/HorizontalScrollView
	i64 u0xec949171e33dfda8, ; 1171 => kotlinx/serialization/encoding/Decoder
	i64 u0xeca1a1cbdf01eb65, ; 1172 => androidx/swiperefreshlayout/widget/SwipeRefreshLayout$OnChildScrollUpCallback
	i64 u0xecf577a3b59693fa, ; 1173 => androidx/fragment/app/FragmentActivity
	i64 u0xed3bf28f37177c87, ; 1174 => android/content/SharedPreferences$OnSharedPreferenceChangeListener
	i64 u0xed49ed70aa9be1b3, ; 1175 => java/nio/channels/spi/AbstractInterruptibleChannel
	i64 u0xee030dac625532e9, ; 1176 => crc64f5844edce43316e7/ThumbnailStrip
	i64 u0xee2024431f48d30e, ; 1177 => crc6445ad3511b80f6fdf/GestureDetector_ScrollListener
	i64 u0xee58348f4c4ad939, ; 1178 => javax/net/ssl/HostnameVerifier
	i64 u0xee6f3d1e7507d907, ; 1179 => java/util/Enumeration
	i64 u0xee9b0e55b4e9242b, ; 1180 => crc6479d6f9e48582dc67/NativeCustomScrolLayout
	i64 u0xeeb466b1609c8ddb, ; 1181 => androidx/viewpager/widget/ViewPager$OnAdapterChangeListener
	i64 u0xeec4bbde96108858, ; 1182 => com/google/android/material/shape/ShapeAppearanceModel$CornerSizeUnaryOperator
	i64 u0xeed6692b305e945a, ; 1183 => crc64e1fb321c08285b90/SwitchCellView
	i64 u0xeef328d1f5b0ffd5, ; 1184 => crc645d80431ce5f73f11/SelectableViewHolder
	i64 u0xef2f2996a1d369cc, ; 1185 => java/io/FileInputStream
	i64 u0xef7212ef395f64aa, ; 1186 => mono/android/view/View_OnFocusChangeListenerImplementor
	i64 u0xef7b5b1ae365a0df, ; 1187 => androidx/navigation/fragment/NavHostFragment
	i64 u0xef953c41325a3428, ; 1188 => java/io/PrintWriter
	i64 u0xefd8c7aa4b48418e, ; 1189 => android/widget/LinearLayout
	i64 u0xefe20f47f9dcda2e, ; 1190 => com/microsoft/maui/ImageLoaderCallback
	i64 u0xf00499aebbbf1859, ; 1191 => androidx/core/app/ActivityCompat
	i64 u0xf025927f8e99b866, ; 1192 => androidx/recyclerview/widget/RecyclerView$OnFlingListener
	i64 u0xf057ebbf53f9d353, ; 1193 => android/renderscript/Script
	i64 u0xf0654f9be531078e, ; 1194 => java/io/Closeable
	i64 u0xf06b3faff90d301b, ; 1195 => androidx/appcompat/widget/Toolbar$LayoutParams
	i64 u0xf07d122f85756305, ; 1196 => com/google/crypto/tink/shaded/protobuf/WireFormat$JavaType
	i64 u0xf0b145cb4b481b64, ; 1197 => mono/com/google/android/material/appbar/AppBarLayout_OnOffsetChangedListenerImplementor
	i64 u0xf0cf138d551e7388, ; 1198 => crc645d80431ce5f73f11/SizedItemContentView
	i64 u0xf11f22a6441fcfbc, ; 1199 => java/lang/IndexOutOfBoundsException
	i64 u0xf12df5ed5a30f88d, ; 1200 => com/google/crypto/tink/shaded/protobuf/MessageLite
	i64 u0xf15bb28304fee21c, ; 1201 => android/provider/Settings$NameValueTable
	i64 u0xf16e73c8be28bf16, ; 1202 => java/lang/annotation/Annotation
	i64 u0xf1923c91feb2cec5, ; 1203 => androidx/browser/customtabs/CustomTabColorSchemeParams
	i64 u0xf1eae814fc93ec98, ; 1204 => android/graphics/Shader$TileMode
	i64 u0xf21aa8d1473bceba, ; 1205 => androidx/coordinatorlayout/widget/CoordinatorLayout$Behavior
	i64 u0xf236b279159cd6de, ; 1206 => crc645d80431ce5f73f11/StructuredItemsViewAdapter_2
	i64 u0xf2952bad3c8f0233, ; 1207 => android/text/Editable
	i64 u0xf295fd61c06a6738, ; 1208 => android/view/View$OnHoverListener
	i64 u0xf2a0b652533c6f79, ; 1209 => crc645d80431ce5f73f11/EndSnapHelper
	i64 u0xf2cdc8dcdb853243, ; 1210 => androidx/recyclerview/widget/RecyclerView$EdgeEffectFactory
	i64 u0xf2e19065f0e73e4d, ; 1211 => java/text/DecimalFormatSymbols
	i64 u0xf2e3de579e508658, ; 1212 => android/provider/MediaStore
	i64 u0xf31bb9d5cde5cec7, ; 1213 => android/renderscript/ScriptIntrinsicConvolve3x3
	i64 u0xf323c9ddabd70266, ; 1214 => kotlin/jvm/functions/Function1
	i64 u0xf336fb6a1f86aa13, ; 1215 => androidx/core/app/ActivityCompat$PermissionCompatDelegate
	i64 u0xf38608385d689955, ; 1216 => mono/android/runtime/JavaArray
	i64 u0xf3d4ab08aaf25ccb, ; 1217 => java/net/UnknownServiceException
	i64 u0xf3d9da552fe9a5a7, ; 1218 => mono/android/text/TextWatcherImplementor
	i64 u0xf3deb63e2d596087, ; 1219 => androidx/appcompat/widget/AppCompatEditText
	i64 u0xf43224eb7d757fa7, ; 1220 => java/util/concurrent/ExecutorService
	i64 u0xf44314212064bd78, ; 1221 => android/view/ViewConfiguration
	i64 u0xf5085ea57b8d83a4, ; 1222 => android/view/accessibility/AccessibilityEvent
	i64 u0xf52c07920492a796, ; 1223 => androidx/fragment/app/strictmode/FragmentStrictMode
	i64 u0xf53d4c1a6dbf311b, ; 1224 => android/text/Html
	i64 u0xf53ee7be68a59d41, ; 1225 => com/google/android/material/appbar/CollapsingToolbarLayout
	i64 u0xf55223b6e3eecb56, ; 1226 => androidx/core/view/MenuItemCompat
	i64 u0xf55d9ff0318ff888, ; 1227 => androidx/core/view/WindowInsetsAnimationCompat$Callback
	i64 u0xf57171fdf29f5557, ; 1228 => androidx/appcompat/widget/Toolbar_NavigationOnClickEventDispatcher
	i64 u0xf57a883b87fe9056, ; 1229 => crc6488302ad6e9e4df1a/MauiAppCompatActivity
	i64 u0xf589cc0bcdc773a9, ; 1230 => mono/com/google/android/material/navigation/NavigationBarView_OnItemReselectedListenerImplementor
	i64 u0xf5bc8b9a77351ffc, ; 1231 => android/graphics/drawable/ShapeDrawable
	i64 u0xf61f943f0206ffef, ; 1232 => androidx/viewpager2/adapter/FragmentStateAdapter$FragmentTransactionCallback
	i64 u0xf62a876be707d0b8, ; 1233 => crc645d80431ce5f73f11/RecyclerViewScrollListener_2
	i64 u0xf6a84ab2352c2e84, ; 1234 => java/util/function/ToLongFunction
	i64 u0xf7595172a9a58b85, ; 1235 => mono/androidx/appcompat/app/ActionBar_OnMenuVisibilityListenerImplementor
	i64 u0xf75d8dd75143511a, ; 1236 => androidx/core/view/accessibility/AccessibilityViewCommand$CommandArguments
	i64 u0xf7df86f1c9d8e4a3, ; 1237 => com/google/android/material/tabs/TabLayout$OnTabSelectedListener
	i64 u0xf8058f3d708eaf64, ; 1238 => android/text/style/SuperscriptSpan
	i64 u0xf85cbededb432844, ; 1239 => java/security/spec/EncodedKeySpec
	i64 u0xf86d1ada6f6d214a, ; 1240 => mono/com/google/android/material/appbar/AppBarLayout_LiftOnScrollListenerImplementor
	i64 u0xf8ca4a570d78d8fe, ; 1241 => crc645d80431ce5f73f11/DataChangeObserver
	i64 u0xf8ce0ad191cefbc4, ; 1242 => androidx/core/view/ActionProvider
	i64 u0xf9665f0bb989fc04, ; 1243 => androidx/core/view/accessibility/AccessibilityNodeInfoCompat$AccessibilityActionCompat
	i64 u0xf9df3849f259e110, ; 1244 => android/view/inputmethod/SurroundingText
	i64 u0xf9e936b25401d5d4, ; 1245 => androidx/recyclerview/widget/RecyclerViewAccessibilityDelegate
	i64 u0xfa1baa381b3f9cde, ; 1246 => mono/java/lang/Runnable
	i64 u0xfa1d5ed2f58367c8, ; 1247 => androidx/core/view/ViewPropertyAnimatorUpdateListener
	i64 u0xfaa2c879d63dad6e, ; 1248 => android/widget/Switch
	i64 u0xfac7e280adbe4149, ; 1249 => android/view/inputmethod/BaseInputConnection
	i64 u0xfac92c73e59de3a9, ; 1250 => crc6488302ad6e9e4df1a/MauiApplication_ActivityLifecycleCallbacks
	i64 u0xfaee1f89c751c767, ; 1251 => android/view/autofill/AutofillId
	i64 u0xfb0541dba11b69d9, ; 1252 => android/graphics/Color
	i64 u0xfb7acb9a6ab88dfc, ; 1253 => android/view/GestureDetector$OnDoubleTapListener
	i64 u0xfb9909be06ff7396, ; 1254 => androidx/core/view/OnReceiveContentListener
	i64 u0xfb9a51a22eb2843f, ; 1255 => javax/security/cert/Certificate
	i64 u0xfbde04d5b5157c93, ; 1256 => androidx/lifecycle/Lifecycle$Event
	i64 u0xfbe9bfa5cc50fed6, ; 1257 => java/util/HashSet
	i64 u0xfbf339bcc735c980, ; 1258 => crc64354973402314325c/SpaceItemDecoration
	i64 u0xfc16c38c998d430c, ; 1259 => kotlin/enums/EnumEntries
	i64 u0xfc406a5c9ae396f0, ; 1260 => crc64338477404e88479c/InnerGestureListener
	i64 u0xfc40c16a360aac93, ; 1261 => com/microsoft/maui/PlatformInterop
	i64 u0xfc64f6dc9166eaf2, ; 1262 => crc6452ffdc5b34af3a0f/MauiWebViewClient
	i64 u0xfcb3254d3921ac28, ; 1263 => androidx/appcompat/widget/DecorToolbar
	i64 u0xfcb507ff775c1269, ; 1264 => com/google/android/material/badge/BadgeDrawable
	i64 u0xfd2b1a3de667eb51, ; 1265 => java/lang/Runnable
	i64 u0xfd45cc49d3236300, ; 1266 => android/os/IBinder$DeathRecipient
	i64 u0xfd4ff765c5f32a77, ; 1267 => crc640ec207abc449b2ca/ShellToolbarTracker_FlyoutIconDrawerDrawable
	i64 u0xfd582859e64f83db, ; 1268 => crc64e1fb321c08285b90/GroupedListViewAdapter
	i64 u0xfd6f34ffcf88aced, ; 1269 => androidx/core/widget/NestedScrollView
	i64 u0xfd830ff8e6ccffed, ; 1270 => android/widget/AdapterView$OnItemClickListener
	i64 u0xfd853b4373fcc7f1, ; 1271 => android/view/WindowMetrics
	i64 u0xfdcaff9cf0f28f33, ; 1272 => crc640ec207abc449b2ca/ShellPageContainer
	i64 u0xfdf56d1e55549adf, ; 1273 => mono/androidx/recyclerview/widget/RecyclerView_RecyclerListenerImplementor
	i64 u0xfe07df0b35277433, ; 1274 => android/widget/LinearLayout$LayoutParams
	i64 u0xfe6b0b2cfdd593b8, ; 1275 => android/text/style/ForegroundColorSpan
	i64 u0xfe82461141d5a47e, ; 1276 => crc6452ffdc5b34af3a0f/MauiSearchView
	i64 u0xfebcdabf0ccfc548, ; 1277 => android/content/pm/ShortcutInfo$Builder
	i64 u0xfebf2b77f1940e7e, ; 1278 => java/security/PrivateKey
	i64 u0xfedc22e568a65326, ; 1279 => android/widget/TextView$OnEditorActionListener
	i64 u0xff079db13d3076a9, ; 1280 => androidx/core/content/ContextCompat
	i64 u0xffd092c889d0e828, ; 1281 => com/google/android/material/bottomsheet/BottomSheetDialog
	i64 u0xfff33782bdf2bde2 ; 1282 => android/widget/CompoundButton$OnCheckedChangeListener
], align 8

@module0_managed_to_java = internal dso_local constant [1 x %struct.TypeMapModuleEntry] [
	%struct.TypeMapModuleEntry {
		i32 u0x02000002, ; uint32_t type_token_id
		i32 385; uint32_t java_map_index
	} ; 0
], align 4

@module1_managed_to_java = internal dso_local constant [14 x %struct.TypeMapModuleEntry] [
	%struct.TypeMapModuleEntry {
		i32 u0x020000c9, ; uint32_t type_token_id
		i32 140; uint32_t java_map_index
	}, ; 0
	%struct.TypeMapModuleEntry {
		i32 u0x020000ca, ; uint32_t type_token_id
		i32 1177; uint32_t java_map_index
	}, ; 1
	%struct.TypeMapModuleEntry {
		i32 u0x020000e9, ; uint32_t type_token_id
		i32 831; uint32_t java_map_index
	}, ; 2
	%struct.TypeMapModuleEntry {
		i32 u0x020000ea, ; uint32_t type_token_id
		i32 331; uint32_t java_map_index
	}, ; 3
	%struct.TypeMapModuleEntry {
		i32 u0x020000f6, ; uint32_t type_token_id
		i32 203; uint32_t java_map_index
	}, ; 4
	%struct.TypeMapModuleEntry {
		i32 u0x02000100, ; uint32_t type_token_id
		i32 287; uint32_t java_map_index
	}, ; 5
	%struct.TypeMapModuleEntry {
		i32 u0x02000259, ; uint32_t type_token_id
		i32 1095; uint32_t java_map_index
	}, ; 6
	%struct.TypeMapModuleEntry {
		i32 u0x0200025b, ; uint32_t type_token_id
		i32 929; uint32_t java_map_index
	}, ; 7
	%struct.TypeMapModuleEntry {
		i32 u0x0200025c, ; uint32_t type_token_id
		i32 1026; uint32_t java_map_index
	}, ; 8
	%struct.TypeMapModuleEntry {
		i32 u0x0200025e, ; uint32_t type_token_id
		i32 935; uint32_t java_map_index
	}, ; 9
	%struct.TypeMapModuleEntry {
		i32 u0x0200025f, ; uint32_t type_token_id
		i32 442; uint32_t java_map_index
	}, ; 10
	%struct.TypeMapModuleEntry {
		i32 u0x02000260, ; uint32_t type_token_id
		i32 811; uint32_t java_map_index
	}, ; 11
	%struct.TypeMapModuleEntry {
		i32 u0x020002aa, ; uint32_t type_token_id
		i32 1085; uint32_t java_map_index
	}, ; 12
	%struct.TypeMapModuleEntry {
		i32 u0x020002ab, ; uint32_t type_token_id
		i32 123; uint32_t java_map_index
	} ; 13
], align 4

@module2_managed_to_java = internal dso_local constant [3 x %struct.TypeMapModuleEntry] [
	%struct.TypeMapModuleEntry {
		i32 u0x02000007, ; uint32_t type_token_id
		i32 141; uint32_t java_map_index
	}, ; 0
	%struct.TypeMapModuleEntry {
		i32 u0x02000009, ; uint32_t type_token_id
		i32 24; uint32_t java_map_index
	}, ; 1
	%struct.TypeMapModuleEntry {
		i32 u0x0200000b, ; uint32_t type_token_id
		i32 1149; uint32_t java_map_index
	} ; 2
], align 4

@module2_managed_to_java_duplicates = internal dso_local constant [2 x %struct.TypeMapModuleEntry] [
	%struct.TypeMapModuleEntry {
		i32 u0x02000008, ; uint32_t type_token_id
		i32 141; uint32_t java_map_index
	}, ; 0
	%struct.TypeMapModuleEntry {
		i32 u0x0200000a, ; uint32_t type_token_id
		i32 24; uint32_t java_map_index
	} ; 1
], align 4

@module3_managed_to_java = internal dso_local constant [6 x %struct.TypeMapModuleEntry] [
	%struct.TypeMapModuleEntry {
		i32 u0x02000002, ; uint32_t type_token_id
		i32 1112; uint32_t java_map_index
	}, ; 0
	%struct.TypeMapModuleEntry {
		i32 u0x02000003, ; uint32_t type_token_id
		i32 185; uint32_t java_map_index
	}, ; 1
	%struct.TypeMapModuleEntry {
		i32 u0x02000004, ; uint32_t type_token_id
		i32 417; uint32_t java_map_index
	}, ; 2
	%struct.TypeMapModuleEntry {
		i32 u0x02000005, ; uint32_t type_token_id
		i32 825; uint32_t java_map_index
	}, ; 3
	%struct.TypeMapModuleEntry {
		i32 u0x02000006, ; uint32_t type_token_id
		i32 64; uint32_t java_map_index
	}, ; 4
	%struct.TypeMapModuleEntry {
		i32 u0x02000007, ; uint32_t type_token_id
		i32 1086; uint32_t java_map_index
	} ; 5
], align 4

@module4_managed_to_java = internal dso_local constant [7 x %struct.TypeMapModuleEntry] [
	%struct.TypeMapModuleEntry {
		i32 u0x0200001b, ; uint32_t type_token_id
		i32 323; uint32_t java_map_index
	}, ; 0
	%struct.TypeMapModuleEntry {
		i32 u0x0200001d, ; uint32_t type_token_id
		i32 841; uint32_t java_map_index
	}, ; 1
	%struct.TypeMapModuleEntry {
		i32 u0x0200001e, ; uint32_t type_token_id
		i32 1181; uint32_t java_map_index
	}, ; 2
	%struct.TypeMapModuleEntry {
		i32 u0x02000021, ; uint32_t type_token_id
		i32 455; uint32_t java_map_index
	}, ; 3
	%struct.TypeMapModuleEntry {
		i32 u0x02000022, ; uint32_t type_token_id
		i32 1137; uint32_t java_map_index
	}, ; 4
	%struct.TypeMapModuleEntry {
		i32 u0x02000027, ; uint32_t type_token_id
		i32 103; uint32_t java_map_index
	}, ; 5
	%struct.TypeMapModuleEntry {
		i32 u0x02000028, ; uint32_t type_token_id
		i32 632; uint32_t java_map_index
	} ; 6
], align 4

@module4_managed_to_java_duplicates = internal dso_local constant [4 x %struct.TypeMapModuleEntry] [
	%struct.TypeMapModuleEntry {
		i32 u0x0200001c, ; uint32_t type_token_id
		i32 323; uint32_t java_map_index
	}, ; 0
	%struct.TypeMapModuleEntry {
		i32 u0x0200001f, ; uint32_t type_token_id
		i32 1181; uint32_t java_map_index
	}, ; 1
	%struct.TypeMapModuleEntry {
		i32 u0x02000023, ; uint32_t type_token_id
		i32 1137; uint32_t java_map_index
	}, ; 2
	%struct.TypeMapModuleEntry {
		i32 u0x02000029, ; uint32_t type_token_id
		i32 632; uint32_t java_map_index
	} ; 3
], align 4

@module5_managed_to_java = internal dso_local constant [4 x %struct.TypeMapModuleEntry] [
	%struct.TypeMapModuleEntry {
		i32 u0x02000016, ; uint32_t type_token_id
		i32 889; uint32_t java_map_index
	}, ; 0
	%struct.TypeMapModuleEntry {
		i32 u0x02000017, ; uint32_t type_token_id
		i32 446; uint32_t java_map_index
	}, ; 1
	%struct.TypeMapModuleEntry {
		i32 u0x0200001d, ; uint32_t type_token_id
		i32 899; uint32_t java_map_index
	}, ; 2
	%struct.TypeMapModuleEntry {
		i32 u0x0200001e, ; uint32_t type_token_id
		i32 1050; uint32_t java_map_index
	} ; 3
], align 4

@module5_managed_to_java_duplicates = internal dso_local constant [1 x %struct.TypeMapModuleEntry] [
	%struct.TypeMapModuleEntry {
		i32 u0x02000018, ; uint32_t type_token_id
		i32 446; uint32_t java_map_index
	} ; 0
], align 4

@module6_managed_to_java = internal dso_local constant [25 x %struct.TypeMapModuleEntry] [
	%struct.TypeMapModuleEntry {
		i32 u0x02000010, ; uint32_t type_token_id
		i32 805; uint32_t java_map_index
	}, ; 0
	%struct.TypeMapModuleEntry {
		i32 u0x02000012, ; uint32_t type_token_id
		i32 872; uint32_t java_map_index
	}, ; 1
	%struct.TypeMapModuleEntry {
		i32 u0x02000014, ; uint32_t type_token_id
		i32 230; uint32_t java_map_index
	}, ; 2
	%struct.TypeMapModuleEntry {
		i32 u0x02000016, ; uint32_t type_token_id
		i32 105; uint32_t java_map_index
	}, ; 3
	%struct.TypeMapModuleEntry {
		i32 u0x02000018, ; uint32_t type_token_id
		i32 1160; uint32_t java_map_index
	}, ; 4
	%struct.TypeMapModuleEntry {
		i32 u0x0200001a, ; uint32_t type_token_id
		i32 965; uint32_t java_map_index
	}, ; 5
	%struct.TypeMapModuleEntry {
		i32 u0x0200001c, ; uint32_t type_token_id
		i32 771; uint32_t java_map_index
	}, ; 6
	%struct.TypeMapModuleEntry {
		i32 u0x0200001e, ; uint32_t type_token_id
		i32 109; uint32_t java_map_index
	}, ; 7
	%struct.TypeMapModuleEntry {
		i32 u0x02000020, ; uint32_t type_token_id
		i32 923; uint32_t java_map_index
	}, ; 8
	%struct.TypeMapModuleEntry {
		i32 u0x02000021, ; uint32_t type_token_id
		i32 972; uint32_t java_map_index
	}, ; 9
	%struct.TypeMapModuleEntry {
		i32 u0x02000023, ; uint32_t type_token_id
		i32 579; uint32_t java_map_index
	}, ; 10
	%struct.TypeMapModuleEntry {
		i32 u0x02000025, ; uint32_t type_token_id
		i32 1064; uint32_t java_map_index
	}, ; 11
	%struct.TypeMapModuleEntry {
		i32 u0x02000027, ; uint32_t type_token_id
		i32 357; uint32_t java_map_index
	}, ; 12
	%struct.TypeMapModuleEntry {
		i32 u0x02000028, ; uint32_t type_token_id
		i32 1124; uint32_t java_map_index
	}, ; 13
	%struct.TypeMapModuleEntry {
		i32 u0x02000029, ; uint32_t type_token_id
		i32 823; uint32_t java_map_index
	}, ; 14
	%struct.TypeMapModuleEntry {
		i32 u0x0200002a, ; uint32_t type_token_id
		i32 737; uint32_t java_map_index
	}, ; 15
	%struct.TypeMapModuleEntry {
		i32 u0x0200002b, ; uint32_t type_token_id
		i32 948; uint32_t java_map_index
	}, ; 16
	%struct.TypeMapModuleEntry {
		i32 u0x0200002c, ; uint32_t type_token_id
		i32 653; uint32_t java_map_index
	}, ; 17
	%struct.TypeMapModuleEntry {
		i32 u0x0200002e, ; uint32_t type_token_id
		i32 444; uint32_t java_map_index
	}, ; 18
	%struct.TypeMapModuleEntry {
		i32 u0x02000030, ; uint32_t type_token_id
		i32 1214; uint32_t java_map_index
	}, ; 19
	%struct.TypeMapModuleEntry {
		i32 u0x02000032, ; uint32_t type_token_id
		i32 320; uint32_t java_map_index
	}, ; 20
	%struct.TypeMapModuleEntry {
		i32 u0x02000034, ; uint32_t type_token_id
		i32 1259; uint32_t java_map_index
	}, ; 21
	%struct.TypeMapModuleEntry {
		i32 u0x02000036, ; uint32_t type_token_id
		i32 1133; uint32_t java_map_index
	}, ; 22
	%struct.TypeMapModuleEntry {
		i32 u0x02000038, ; uint32_t type_token_id
		i32 161; uint32_t java_map_index
	}, ; 23
	%struct.TypeMapModuleEntry {
		i32 u0x0200003a, ; uint32_t type_token_id
		i32 584; uint32_t java_map_index
	} ; 24
], align 4

@module6_managed_to_java_duplicates = internal dso_local constant [19 x %struct.TypeMapModuleEntry] [
	%struct.TypeMapModuleEntry {
		i32 u0x02000011, ; uint32_t type_token_id
		i32 805; uint32_t java_map_index
	}, ; 0
	%struct.TypeMapModuleEntry {
		i32 u0x02000013, ; uint32_t type_token_id
		i32 872; uint32_t java_map_index
	}, ; 1
	%struct.TypeMapModuleEntry {
		i32 u0x02000015, ; uint32_t type_token_id
		i32 230; uint32_t java_map_index
	}, ; 2
	%struct.TypeMapModuleEntry {
		i32 u0x02000017, ; uint32_t type_token_id
		i32 105; uint32_t java_map_index
	}, ; 3
	%struct.TypeMapModuleEntry {
		i32 u0x02000019, ; uint32_t type_token_id
		i32 1160; uint32_t java_map_index
	}, ; 4
	%struct.TypeMapModuleEntry {
		i32 u0x0200001b, ; uint32_t type_token_id
		i32 965; uint32_t java_map_index
	}, ; 5
	%struct.TypeMapModuleEntry {
		i32 u0x0200001d, ; uint32_t type_token_id
		i32 771; uint32_t java_map_index
	}, ; 6
	%struct.TypeMapModuleEntry {
		i32 u0x0200001f, ; uint32_t type_token_id
		i32 109; uint32_t java_map_index
	}, ; 7
	%struct.TypeMapModuleEntry {
		i32 u0x02000022, ; uint32_t type_token_id
		i32 972; uint32_t java_map_index
	}, ; 8
	%struct.TypeMapModuleEntry {
		i32 u0x02000024, ; uint32_t type_token_id
		i32 579; uint32_t java_map_index
	}, ; 9
	%struct.TypeMapModuleEntry {
		i32 u0x02000026, ; uint32_t type_token_id
		i32 1064; uint32_t java_map_index
	}, ; 10
	%struct.TypeMapModuleEntry {
		i32 u0x0200002d, ; uint32_t type_token_id
		i32 653; uint32_t java_map_index
	}, ; 11
	%struct.TypeMapModuleEntry {
		i32 u0x0200002f, ; uint32_t type_token_id
		i32 444; uint32_t java_map_index
	}, ; 12
	%struct.TypeMapModuleEntry {
		i32 u0x02000031, ; uint32_t type_token_id
		i32 1214; uint32_t java_map_index
	}, ; 13
	%struct.TypeMapModuleEntry {
		i32 u0x02000033, ; uint32_t type_token_id
		i32 320; uint32_t java_map_index
	}, ; 14
	%struct.TypeMapModuleEntry {
		i32 u0x02000035, ; uint32_t type_token_id
		i32 1259; uint32_t java_map_index
	}, ; 15
	%struct.TypeMapModuleEntry {
		i32 u0x02000037, ; uint32_t type_token_id
		i32 1133; uint32_t java_map_index
	}, ; 16
	%struct.TypeMapModuleEntry {
		i32 u0x02000039, ; uint32_t type_token_id
		i32 161; uint32_t java_map_index
	}, ; 17
	%struct.TypeMapModuleEntry {
		i32 u0x0200003b, ; uint32_t type_token_id
		i32 584; uint32_t java_map_index
	} ; 18
], align 4

@module7_managed_to_java = internal dso_local constant [3 x %struct.TypeMapModuleEntry] [
	%struct.TypeMapModuleEntry {
		i32 u0x02000027, ; uint32_t type_token_id
		i32 432; uint32_t java_map_index
	}, ; 0
	%struct.TypeMapModuleEntry {
		i32 u0x02000028, ; uint32_t type_token_id
		i32 1205; uint32_t java_map_index
	}, ; 1
	%struct.TypeMapModuleEntry {
		i32 u0x0200002a, ; uint32_t type_token_id
		i32 847; uint32_t java_map_index
	} ; 2
], align 4

@module7_managed_to_java_duplicates = internal dso_local constant [1 x %struct.TypeMapModuleEntry] [
	%struct.TypeMapModuleEntry {
		i32 u0x02000029, ; uint32_t type_token_id
		i32 1205; uint32_t java_map_index
	} ; 0
], align 4

@module8_managed_to_java = internal dso_local constant [72 x %struct.TypeMapModuleEntry] [
	%struct.TypeMapModuleEntry {
		i32 u0x0200009a, ; uint32_t type_token_id
		i32 409; uint32_t java_map_index
	}, ; 0
	%struct.TypeMapModuleEntry {
		i32 u0x0200009b, ; uint32_t type_token_id
		i32 718; uint32_t java_map_index
	}, ; 1
	%struct.TypeMapModuleEntry {
		i32 u0x0200009c, ; uint32_t type_token_id
		i32 907; uint32_t java_map_index
	}, ; 2
	%struct.TypeMapModuleEntry {
		i32 u0x020000b6, ; uint32_t type_token_id
		i32 1229; uint32_t java_map_index
	}, ; 3
	%struct.TypeMapModuleEntry {
		i32 u0x020000b7, ; uint32_t type_token_id
		i32 722; uint32_t java_map_index
	}, ; 4
	%struct.TypeMapModuleEntry {
		i32 u0x02000117, ; uint32_t type_token_id
		i32 133; uint32_t java_map_index
	}, ; 5
	%struct.TypeMapModuleEntry {
		i32 u0x02000118, ; uint32_t type_token_id
		i32 1017; uint32_t java_map_index
	}, ; 6
	%struct.TypeMapModuleEntry {
		i32 u0x0200011a, ; uint32_t type_token_id
		i32 1190; uint32_t java_map_index
	}, ; 7
	%struct.TypeMapModuleEntry {
		i32 u0x0200011c, ; uint32_t type_token_id
		i32 1077; uint32_t java_map_index
	}, ; 8
	%struct.TypeMapModuleEntry {
		i32 u0x0200011d, ; uint32_t type_token_id
		i32 457; uint32_t java_map_index
	}, ; 9
	%struct.TypeMapModuleEntry {
		i32 u0x0200011e, ; uint32_t type_token_id
		i32 342; uint32_t java_map_index
	}, ; 10
	%struct.TypeMapModuleEntry {
		i32 u0x02000120, ; uint32_t type_token_id
		i32 402; uint32_t java_map_index
	}, ; 11
	%struct.TypeMapModuleEntry {
		i32 u0x02000121, ; uint32_t type_token_id
		i32 1261; uint32_t java_map_index
	}, ; 12
	%struct.TypeMapModuleEntry {
		i32 u0x02000122, ; uint32_t type_token_id
		i32 1068; uint32_t java_map_index
	}, ; 13
	%struct.TypeMapModuleEntry {
		i32 u0x02000123, ; uint32_t type_token_id
		i32 777; uint32_t java_map_index
	}, ; 14
	%struct.TypeMapModuleEntry {
		i32 u0x02000124, ; uint32_t type_token_id
		i32 908; uint32_t java_map_index
	}, ; 15
	%struct.TypeMapModuleEntry {
		i32 u0x0200012a, ; uint32_t type_token_id
		i32 183; uint32_t java_map_index
	}, ; 16
	%struct.TypeMapModuleEntry {
		i32 u0x02000131, ; uint32_t type_token_id
		i32 595; uint32_t java_map_index
	}, ; 17
	%struct.TypeMapModuleEntry {
		i32 u0x02000136, ; uint32_t type_token_id
		i32 567; uint32_t java_map_index
	}, ; 18
	%struct.TypeMapModuleEntry {
		i32 u0x02000137, ; uint32_t type_token_id
		i32 843; uint32_t java_map_index
	}, ; 19
	%struct.TypeMapModuleEntry {
		i32 u0x02000148, ; uint32_t type_token_id
		i32 144; uint32_t java_map_index
	}, ; 20
	%struct.TypeMapModuleEntry {
		i32 u0x0200014a, ; uint32_t type_token_id
		i32 759; uint32_t java_map_index
	}, ; 21
	%struct.TypeMapModuleEntry {
		i32 u0x0200014b, ; uint32_t type_token_id
		i32 180; uint32_t java_map_index
	}, ; 22
	%struct.TypeMapModuleEntry {
		i32 u0x0200014c, ; uint32_t type_token_id
		i32 785; uint32_t java_map_index
	}, ; 23
	%struct.TypeMapModuleEntry {
		i32 u0x0200014d, ; uint32_t type_token_id
		i32 672; uint32_t java_map_index
	}, ; 24
	%struct.TypeMapModuleEntry {
		i32 u0x0200014f, ; uint32_t type_token_id
		i32 754; uint32_t java_map_index
	}, ; 25
	%struct.TypeMapModuleEntry {
		i32 u0x02000150, ; uint32_t type_token_id
		i32 195; uint32_t java_map_index
	}, ; 26
	%struct.TypeMapModuleEntry {
		i32 u0x02000151, ; uint32_t type_token_id
		i32 495; uint32_t java_map_index
	}, ; 27
	%struct.TypeMapModuleEntry {
		i32 u0x02000152, ; uint32_t type_token_id
		i32 345; uint32_t java_map_index
	}, ; 28
	%struct.TypeMapModuleEntry {
		i32 u0x02000153, ; uint32_t type_token_id
		i32 677; uint32_t java_map_index
	}, ; 29
	%struct.TypeMapModuleEntry {
		i32 u0x02000154, ; uint32_t type_token_id
		i32 894; uint32_t java_map_index
	}, ; 30
	%struct.TypeMapModuleEntry {
		i32 u0x02000155, ; uint32_t type_token_id
		i32 969; uint32_t java_map_index
	}, ; 31
	%struct.TypeMapModuleEntry {
		i32 u0x02000156, ; uint32_t type_token_id
		i32 279; uint32_t java_map_index
	}, ; 32
	%struct.TypeMapModuleEntry {
		i32 u0x02000158, ; uint32_t type_token_id
		i32 45; uint32_t java_map_index
	}, ; 33
	%struct.TypeMapModuleEntry {
		i32 u0x02000159, ; uint32_t type_token_id
		i32 1034; uint32_t java_map_index
	}, ; 34
	%struct.TypeMapModuleEntry {
		i32 u0x0200015b, ; uint32_t type_token_id
		i32 1276; uint32_t java_map_index
	}, ; 35
	%struct.TypeMapModuleEntry {
		i32 u0x0200015c, ; uint32_t type_token_id
		i32 685; uint32_t java_map_index
	}, ; 36
	%struct.TypeMapModuleEntry {
		i32 u0x0200015d, ; uint32_t type_token_id
		i32 629; uint32_t java_map_index
	}, ; 37
	%struct.TypeMapModuleEntry {
		i32 u0x0200015e, ; uint32_t type_token_id
		i32 406; uint32_t java_map_index
	}, ; 38
	%struct.TypeMapModuleEntry {
		i32 u0x0200015f, ; uint32_t type_token_id
		i32 81; uint32_t java_map_index
	}, ; 39
	%struct.TypeMapModuleEntry {
		i32 u0x02000160, ; uint32_t type_token_id
		i32 557; uint32_t java_map_index
	}, ; 40
	%struct.TypeMapModuleEntry {
		i32 u0x02000162, ; uint32_t type_token_id
		i32 670; uint32_t java_map_index
	}, ; 41
	%struct.TypeMapModuleEntry {
		i32 u0x02000163, ; uint32_t type_token_id
		i32 1015; uint32_t java_map_index
	}, ; 42
	%struct.TypeMapModuleEntry {
		i32 u0x02000164, ; uint32_t type_token_id
		i32 508; uint32_t java_map_index
	}, ; 43
	%struct.TypeMapModuleEntry {
		i32 u0x02000165, ; uint32_t type_token_id
		i32 1262; uint32_t java_map_index
	}, ; 44
	%struct.TypeMapModuleEntry {
		i32 u0x02000168, ; uint32_t type_token_id
		i32 573; uint32_t java_map_index
	}, ; 45
	%struct.TypeMapModuleEntry {
		i32 u0x0200016a, ; uint32_t type_token_id
		i32 532; uint32_t java_map_index
	}, ; 46
	%struct.TypeMapModuleEntry {
		i32 u0x0200016b, ; uint32_t type_token_id
		i32 482; uint32_t java_map_index
	}, ; 47
	%struct.TypeMapModuleEntry {
		i32 u0x0200016d, ; uint32_t type_token_id
		i32 857; uint32_t java_map_index
	}, ; 48
	%struct.TypeMapModuleEntry {
		i32 u0x02000170, ; uint32_t type_token_id
		i32 873; uint32_t java_map_index
	}, ; 49
	%struct.TypeMapModuleEntry {
		i32 u0x0200017c, ; uint32_t type_token_id
		i32 505; uint32_t java_map_index
	}, ; 50
	%struct.TypeMapModuleEntry {
		i32 u0x0200017f, ; uint32_t type_token_id
		i32 259; uint32_t java_map_index
	}, ; 51
	%struct.TypeMapModuleEntry {
		i32 u0x0200018b, ; uint32_t type_token_id
		i32 527; uint32_t java_map_index
	}, ; 52
	%struct.TypeMapModuleEntry {
		i32 u0x02000242, ; uint32_t type_token_id
		i32 426; uint32_t java_map_index
	}, ; 53
	%struct.TypeMapModuleEntry {
		i32 u0x02000243, ; uint32_t type_token_id
		i32 498; uint32_t java_map_index
	}, ; 54
	%struct.TypeMapModuleEntry {
		i32 u0x02000249, ; uint32_t type_token_id
		i32 85; uint32_t java_map_index
	}, ; 55
	%struct.TypeMapModuleEntry {
		i32 u0x02000291, ; uint32_t type_token_id
		i32 1250; uint32_t java_map_index
	}, ; 56
	%struct.TypeMapModuleEntry {
		i32 u0x020002bd, ; uint32_t type_token_id
		i32 700; uint32_t java_map_index
	}, ; 57
	%struct.TypeMapModuleEntry {
		i32 u0x020002c3, ; uint32_t type_token_id
		i32 84; uint32_t java_map_index
	}, ; 58
	%struct.TypeMapModuleEntry {
		i32 u0x020002c4, ; uint32_t type_token_id
		i32 656; uint32_t java_map_index
	}, ; 59
	%struct.TypeMapModuleEntry {
		i32 u0x020002ca, ; uint32_t type_token_id
		i32 462; uint32_t java_map_index
	}, ; 60
	%struct.TypeMapModuleEntry {
		i32 u0x020002cc, ; uint32_t type_token_id
		i32 50; uint32_t java_map_index
	}, ; 61
	%struct.TypeMapModuleEntry {
		i32 u0x020002d1, ; uint32_t type_token_id
		i32 178; uint32_t java_map_index
	}, ; 62
	%struct.TypeMapModuleEntry {
		i32 u0x020002dc, ; uint32_t type_token_id
		i32 1110; uint32_t java_map_index
	}, ; 63
	%struct.TypeMapModuleEntry {
		i32 u0x02000323, ; uint32_t type_token_id
		i32 25; uint32_t java_map_index
	}, ; 64
	%struct.TypeMapModuleEntry {
		i32 u0x02000324, ; uint32_t type_token_id
		i32 77; uint32_t java_map_index
	}, ; 65
	%struct.TypeMapModuleEntry {
		i32 u0x02000327, ; uint32_t type_token_id
		i32 90; uint32_t java_map_index
	}, ; 66
	%struct.TypeMapModuleEntry {
		i32 u0x02000337, ; uint32_t type_token_id
		i32 984; uint32_t java_map_index
	}, ; 67
	%struct.TypeMapModuleEntry {
		i32 u0x02000338, ; uint32_t type_token_id
		i32 714; uint32_t java_map_index
	}, ; 68
	%struct.TypeMapModuleEntry {
		i32 u0x0200033a, ; uint32_t type_token_id
		i32 708; uint32_t java_map_index
	}, ; 69
	%struct.TypeMapModuleEntry {
		i32 u0x0200033b, ; uint32_t type_token_id
		i32 652; uint32_t java_map_index
	}, ; 70
	%struct.TypeMapModuleEntry {
		i32 u0x0200034d, ; uint32_t type_token_id
		i32 830; uint32_t java_map_index
	} ; 71
], align 4

@module8_managed_to_java_duplicates = internal dso_local constant [4 x %struct.TypeMapModuleEntry] [
	%struct.TypeMapModuleEntry {
		i32 u0x02000119, ; uint32_t type_token_id
		i32 1017; uint32_t java_map_index
	}, ; 0
	%struct.TypeMapModuleEntry {
		i32 u0x0200011b, ; uint32_t type_token_id
		i32 1190; uint32_t java_map_index
	}, ; 1
	%struct.TypeMapModuleEntry {
		i32 u0x0200011f, ; uint32_t type_token_id
		i32 342; uint32_t java_map_index
	}, ; 2
	%struct.TypeMapModuleEntry {
		i32 u0x02000125, ; uint32_t type_token_id
		i32 908; uint32_t java_map_index
	} ; 3
], align 4

@module9_managed_to_java = internal dso_local constant [1 x %struct.TypeMapModuleEntry] [
	%struct.TypeMapModuleEntry {
		i32 u0x02000078, ; uint32_t type_token_id
		i32 977; uint32_t java_map_index
	} ; 0
], align 4

@module10_managed_to_java = internal dso_local constant [7 x %struct.TypeMapModuleEntry] [
	%struct.TypeMapModuleEntry {
		i32 u0x02000004, ; uint32_t type_token_id
		i32 1002; uint32_t java_map_index
	}, ; 0
	%struct.TypeMapModuleEntry {
		i32 u0x02000005, ; uint32_t type_token_id
		i32 1203; uint32_t java_map_index
	}, ; 1
	%struct.TypeMapModuleEntry {
		i32 u0x02000006, ; uint32_t type_token_id
		i32 475; uint32_t java_map_index
	}, ; 2
	%struct.TypeMapModuleEntry {
		i32 u0x02000007, ; uint32_t type_token_id
		i32 337; uint32_t java_map_index
	}, ; 3
	%struct.TypeMapModuleEntry {
		i32 u0x02000008, ; uint32_t type_token_id
		i32 721; uint32_t java_map_index
	}, ; 4
	%struct.TypeMapModuleEntry {
		i32 u0x02000009, ; uint32_t type_token_id
		i32 966; uint32_t java_map_index
	}, ; 5
	%struct.TypeMapModuleEntry {
		i32 u0x0200000a, ; uint32_t type_token_id
		i32 891; uint32_t java_map_index
	} ; 6
], align 4

@module10_managed_to_java_duplicates = internal dso_local constant [1 x %struct.TypeMapModuleEntry] [
	%struct.TypeMapModuleEntry {
		i32 u0x0200000b, ; uint32_t type_token_id
		i32 891; uint32_t java_map_index
	} ; 0
], align 4

@module11_managed_to_java = internal dso_local constant [6 x %struct.TypeMapModuleEntry] [
	%struct.TypeMapModuleEntry {
		i32 u0x02000010, ; uint32_t type_token_id
		i32 882; uint32_t java_map_index
	}, ; 0
	%struct.TypeMapModuleEntry {
		i32 u0x02000011, ; uint32_t type_token_id
		i32 136; uint32_t java_map_index
	}, ; 1
	%struct.TypeMapModuleEntry {
		i32 u0x02000014, ; uint32_t type_token_id
		i32 354; uint32_t java_map_index
	}, ; 2
	%struct.TypeMapModuleEntry {
		i32 u0x02000018, ; uint32_t type_token_id
		i32 15; uint32_t java_map_index
	}, ; 3
	%struct.TypeMapModuleEntry {
		i32 u0x02000019, ; uint32_t type_token_id
		i32 934; uint32_t java_map_index
	}, ; 4
	%struct.TypeMapModuleEntry {
		i32 u0x0200001a, ; uint32_t type_token_id
		i32 511; uint32_t java_map_index
	} ; 5
], align 4

@module11_managed_to_java_duplicates = internal dso_local constant [1 x %struct.TypeMapModuleEntry] [
	%struct.TypeMapModuleEntry {
		i32 u0x02000012, ; uint32_t type_token_id
		i32 136; uint32_t java_map_index
	} ; 0
], align 4

@module12_managed_to_java = internal dso_local constant [5 x %struct.TypeMapModuleEntry] [
	%struct.TypeMapModuleEntry {
		i32 u0x02000004, ; uint32_t type_token_id
		i32 747; uint32_t java_map_index
	}, ; 0
	%struct.TypeMapModuleEntry {
		i32 u0x02000005, ; uint32_t type_token_id
		i32 1256; uint32_t java_map_index
	}, ; 1
	%struct.TypeMapModuleEntry {
		i32 u0x02000006, ; uint32_t type_token_id
		i32 1166; uint32_t java_map_index
	}, ; 2
	%struct.TypeMapModuleEntry {
		i32 u0x02000007, ; uint32_t type_token_id
		i32 597; uint32_t java_map_index
	}, ; 3
	%struct.TypeMapModuleEntry {
		i32 u0x02000009, ; uint32_t type_token_id
		i32 126; uint32_t java_map_index
	} ; 4
], align 4

@module12_managed_to_java_duplicates = internal dso_local constant [3 x %struct.TypeMapModuleEntry] [
	%struct.TypeMapModuleEntry {
		i32 u0x02000008, ; uint32_t type_token_id
		i32 597; uint32_t java_map_index
	}, ; 0
	%struct.TypeMapModuleEntry {
		i32 u0x0200000a, ; uint32_t type_token_id
		i32 126; uint32_t java_map_index
	}, ; 1
	%struct.TypeMapModuleEntry {
		i32 u0x0200000b, ; uint32_t type_token_id
		i32 747; uint32_t java_map_index
	} ; 2
], align 4

@module13_managed_to_java = internal dso_local constant [9 x %struct.TypeMapModuleEntry] [
	%struct.TypeMapModuleEntry {
		i32 u0x02000007, ; uint32_t type_token_id
		i32 692; uint32_t java_map_index
	}, ; 0
	%struct.TypeMapModuleEntry {
		i32 u0x02000009, ; uint32_t type_token_id
		i32 1117; uint32_t java_map_index
	}, ; 1
	%struct.TypeMapModuleEntry {
		i32 u0x0200000b, ; uint32_t type_token_id
		i32 127; uint32_t java_map_index
	}, ; 2
	%struct.TypeMapModuleEntry {
		i32 u0x0200000c, ; uint32_t type_token_id
		i32 842; uint32_t java_map_index
	}, ; 3
	%struct.TypeMapModuleEntry {
		i32 u0x0200000d, ; uint32_t type_token_id
		i32 810; uint32_t java_map_index
	}, ; 4
	%struct.TypeMapModuleEntry {
		i32 u0x0200000f, ; uint32_t type_token_id
		i32 787; uint32_t java_map_index
	}, ; 5
	%struct.TypeMapModuleEntry {
		i32 u0x02000010, ; uint32_t type_token_id
		i32 581; uint32_t java_map_index
	}, ; 6
	%struct.TypeMapModuleEntry {
		i32 u0x02000011, ; uint32_t type_token_id
		i32 210; uint32_t java_map_index
	}, ; 7
	%struct.TypeMapModuleEntry {
		i32 u0x02000014, ; uint32_t type_token_id
		i32 53; uint32_t java_map_index
	} ; 8
], align 4

@module13_managed_to_java_duplicates = internal dso_local constant [5 x %struct.TypeMapModuleEntry] [
	%struct.TypeMapModuleEntry {
		i32 u0x02000008, ; uint32_t type_token_id
		i32 692; uint32_t java_map_index
	}, ; 0
	%struct.TypeMapModuleEntry {
		i32 u0x0200000a, ; uint32_t type_token_id
		i32 1117; uint32_t java_map_index
	}, ; 1
	%struct.TypeMapModuleEntry {
		i32 u0x0200000e, ; uint32_t type_token_id
		i32 810; uint32_t java_map_index
	}, ; 2
	%struct.TypeMapModuleEntry {
		i32 u0x02000012, ; uint32_t type_token_id
		i32 210; uint32_t java_map_index
	}, ; 3
	%struct.TypeMapModuleEntry {
		i32 u0x02000013, ; uint32_t type_token_id
		i32 581; uint32_t java_map_index
	} ; 4
], align 4

@module14_managed_to_java = internal dso_local constant [67 x %struct.TypeMapModuleEntry] [
	%struct.TypeMapModuleEntry {
		i32 u0x02000041, ; uint32_t type_token_id
		i32 469; uint32_t java_map_index
	}, ; 0
	%struct.TypeMapModuleEntry {
		i32 u0x02000042, ; uint32_t type_token_id
		i32 904; uint32_t java_map_index
	}, ; 1
	%struct.TypeMapModuleEntry {
		i32 u0x02000043, ; uint32_t type_token_id
		i32 143; uint32_t java_map_index
	}, ; 2
	%struct.TypeMapModuleEntry {
		i32 u0x02000045, ; uint32_t type_token_id
		i32 822; uint32_t java_map_index
	}, ; 3
	%struct.TypeMapModuleEntry {
		i32 u0x02000046, ; uint32_t type_token_id
		i32 861; uint32_t java_map_index
	}, ; 4
	%struct.TypeMapModuleEntry {
		i32 u0x02000047, ; uint32_t type_token_id
		i32 944; uint32_t java_map_index
	}, ; 5
	%struct.TypeMapModuleEntry {
		i32 u0x02000048, ; uint32_t type_token_id
		i32 864; uint32_t java_map_index
	}, ; 6
	%struct.TypeMapModuleEntry {
		i32 u0x02000049, ; uint32_t type_token_id
		i32 1182; uint32_t java_map_index
	}, ; 7
	%struct.TypeMapModuleEntry {
		i32 u0x0200004b, ; uint32_t type_token_id
		i32 241; uint32_t java_map_index
	}, ; 8
	%struct.TypeMapModuleEntry {
		i32 u0x0200004c, ; uint32_t type_token_id
		i32 236; uint32_t java_map_index
	}, ; 9
	%struct.TypeMapModuleEntry {
		i32 u0x0200004d, ; uint32_t type_token_id
		i32 746; uint32_t java_map_index
	}, ; 10
	%struct.TypeMapModuleEntry {
		i32 u0x0200004e, ; uint32_t type_token_id
		i32 500; uint32_t java_map_index
	}, ; 11
	%struct.TypeMapModuleEntry {
		i32 u0x0200004f, ; uint32_t type_token_id
		i32 399; uint32_t java_map_index
	}, ; 12
	%struct.TypeMapModuleEntry {
		i32 u0x02000050, ; uint32_t type_token_id
		i32 893; uint32_t java_map_index
	}, ; 13
	%struct.TypeMapModuleEntry {
		i32 u0x02000053, ; uint32_t type_token_id
		i32 368; uint32_t java_map_index
	}, ; 14
	%struct.TypeMapModuleEntry {
		i32 u0x02000054, ; uint32_t type_token_id
		i32 430; uint32_t java_map_index
	}, ; 15
	%struct.TypeMapModuleEntry {
		i32 u0x02000057, ; uint32_t type_token_id
		i32 1121; uint32_t java_map_index
	}, ; 16
	%struct.TypeMapModuleEntry {
		i32 u0x0200005d, ; uint32_t type_token_id
		i32 648; uint32_t java_map_index
	}, ; 17
	%struct.TypeMapModuleEntry {
		i32 u0x0200005e, ; uint32_t type_token_id
		i32 858; uint32_t java_map_index
	}, ; 18
	%struct.TypeMapModuleEntry {
		i32 u0x02000061, ; uint32_t type_token_id
		i32 384; uint32_t java_map_index
	}, ; 19
	%struct.TypeMapModuleEntry {
		i32 u0x02000065, ; uint32_t type_token_id
		i32 997; uint32_t java_map_index
	}, ; 20
	%struct.TypeMapModuleEntry {
		i32 u0x02000066, ; uint32_t type_token_id
		i32 1146; uint32_t java_map_index
	}, ; 21
	%struct.TypeMapModuleEntry {
		i32 u0x02000068, ; uint32_t type_token_id
		i32 1281; uint32_t java_map_index
	}, ; 22
	%struct.TypeMapModuleEntry {
		i32 u0x02000069, ; uint32_t type_token_id
		i32 1264; uint32_t java_map_index
	}, ; 23
	%struct.TypeMapModuleEntry {
		i32 u0x0200006a, ; uint32_t type_token_id
		i32 396; uint32_t java_map_index
	}, ; 24
	%struct.TypeMapModuleEntry {
		i32 u0x0200006d, ; uint32_t type_token_id
		i32 1154; uint32_t java_map_index
	}, ; 25
	%struct.TypeMapModuleEntry {
		i32 u0x0200006f, ; uint32_t type_token_id
		i32 1230; uint32_t java_map_index
	}, ; 26
	%struct.TypeMapModuleEntry {
		i32 u0x02000070, ; uint32_t type_token_id
		i32 369; uint32_t java_map_index
	}, ; 27
	%struct.TypeMapModuleEntry {
		i32 u0x02000072, ; uint32_t type_token_id
		i32 7; uint32_t java_map_index
	}, ; 28
	%struct.TypeMapModuleEntry {
		i32 u0x02000078, ; uint32_t type_token_id
		i32 1150; uint32_t java_map_index
	}, ; 29
	%struct.TypeMapModuleEntry {
		i32 u0x0200007a, ; uint32_t type_token_id
		i32 1076; uint32_t java_map_index
	}, ; 30
	%struct.TypeMapModuleEntry {
		i32 u0x0200007c, ; uint32_t type_token_id
		i32 846; uint32_t java_map_index
	}, ; 31
	%struct.TypeMapModuleEntry {
		i32 u0x0200007e, ; uint32_t type_token_id
		i32 689; uint32_t java_map_index
	}, ; 32
	%struct.TypeMapModuleEntry {
		i32 u0x0200007f, ; uint32_t type_token_id
		i32 1; uint32_t java_map_index
	}, ; 33
	%struct.TypeMapModuleEntry {
		i32 u0x02000082, ; uint32_t type_token_id
		i32 919; uint32_t java_map_index
	}, ; 34
	%struct.TypeMapModuleEntry {
		i32 u0x02000086, ; uint32_t type_token_id
		i32 219; uint32_t java_map_index
	}, ; 35
	%struct.TypeMapModuleEntry {
		i32 u0x02000087, ; uint32_t type_token_id
		i32 69; uint32_t java_map_index
	}, ; 36
	%struct.TypeMapModuleEntry {
		i32 u0x02000088, ; uint32_t type_token_id
		i32 471; uint32_t java_map_index
	}, ; 37
	%struct.TypeMapModuleEntry {
		i32 u0x0200008d, ; uint32_t type_token_id
		i32 1142; uint32_t java_map_index
	}, ; 38
	%struct.TypeMapModuleEntry {
		i32 u0x0200008e, ; uint32_t type_token_id
		i32 1237; uint32_t java_map_index
	}, ; 39
	%struct.TypeMapModuleEntry {
		i32 u0x02000090, ; uint32_t type_token_id
		i32 476; uint32_t java_map_index
	}, ; 40
	%struct.TypeMapModuleEntry {
		i32 u0x02000098, ; uint32_t type_token_id
		i32 176; uint32_t java_map_index
	}, ; 41
	%struct.TypeMapModuleEntry {
		i32 u0x02000099, ; uint32_t type_token_id
		i32 8; uint32_t java_map_index
	}, ; 42
	%struct.TypeMapModuleEntry {
		i32 u0x0200009b, ; uint32_t type_token_id
		i32 736; uint32_t java_map_index
	}, ; 43
	%struct.TypeMapModuleEntry {
		i32 u0x0200009d, ; uint32_t type_token_id
		i32 330; uint32_t java_map_index
	}, ; 44
	%struct.TypeMapModuleEntry {
		i32 u0x0200009e, ; uint32_t type_token_id
		i32 960; uint32_t java_map_index
	}, ; 45
	%struct.TypeMapModuleEntry {
		i32 u0x0200009f, ; uint32_t type_token_id
		i32 613; uint32_t java_map_index
	}, ; 46
	%struct.TypeMapModuleEntry {
		i32 u0x020000a0, ; uint32_t type_token_id
		i32 2; uint32_t java_map_index
	}, ; 47
	%struct.TypeMapModuleEntry {
		i32 u0x020000a1, ; uint32_t type_token_id
		i32 1082; uint32_t java_map_index
	}, ; 48
	%struct.TypeMapModuleEntry {
		i32 u0x020000a3, ; uint32_t type_token_id
		i32 61; uint32_t java_map_index
	}, ; 49
	%struct.TypeMapModuleEntry {
		i32 u0x020000a5, ; uint32_t type_token_id
		i32 1225; uint32_t java_map_index
	}, ; 50
	%struct.TypeMapModuleEntry {
		i32 u0x020000a6, ; uint32_t type_token_id
		i32 956; uint32_t java_map_index
	}, ; 51
	%struct.TypeMapModuleEntry {
		i32 u0x020000a8, ; uint32_t type_token_id
		i32 514; uint32_t java_map_index
	}, ; 52
	%struct.TypeMapModuleEntry {
		i32 u0x020000a9, ; uint32_t type_token_id
		i32 678; uint32_t java_map_index
	}, ; 53
	%struct.TypeMapModuleEntry {
		i32 u0x020000aa, ; uint32_t type_token_id
		i32 37; uint32_t java_map_index
	}, ; 54
	%struct.TypeMapModuleEntry {
		i32 u0x020000ac, ; uint32_t type_token_id
		i32 768; uint32_t java_map_index
	}, ; 55
	%struct.TypeMapModuleEntry {
		i32 u0x020000ad, ; uint32_t type_token_id
		i32 137; uint32_t java_map_index
	}, ; 56
	%struct.TypeMapModuleEntry {
		i32 u0x020000af, ; uint32_t type_token_id
		i32 975; uint32_t java_map_index
	}, ; 57
	%struct.TypeMapModuleEntry {
		i32 u0x020000b0, ; uint32_t type_token_id
		i32 1100; uint32_t java_map_index
	}, ; 58
	%struct.TypeMapModuleEntry {
		i32 u0x020000b3, ; uint32_t type_token_id
		i32 1240; uint32_t java_map_index
	}, ; 59
	%struct.TypeMapModuleEntry {
		i32 u0x020000b4, ; uint32_t type_token_id
		i32 918; uint32_t java_map_index
	}, ; 60
	%struct.TypeMapModuleEntry {
		i32 u0x020000b7, ; uint32_t type_token_id
		i32 1197; uint32_t java_map_index
	}, ; 61
	%struct.TypeMapModuleEntry {
		i32 u0x020000b8, ; uint32_t type_token_id
		i32 19; uint32_t java_map_index
	}, ; 62
	%struct.TypeMapModuleEntry {
		i32 u0x020000be, ; uint32_t type_token_id
		i32 58; uint32_t java_map_index
	}, ; 63
	%struct.TypeMapModuleEntry {
		i32 u0x020000c0, ; uint32_t type_token_id
		i32 510; uint32_t java_map_index
	}, ; 64
	%struct.TypeMapModuleEntry {
		i32 u0x020000c2, ; uint32_t type_token_id
		i32 1165; uint32_t java_map_index
	}, ; 65
	%struct.TypeMapModuleEntry {
		i32 u0x020000c3, ; uint32_t type_token_id
		i32 70; uint32_t java_map_index
	} ; 66
], align 4

@module14_managed_to_java_duplicates = internal dso_local constant [25 x %struct.TypeMapModuleEntry] [
	%struct.TypeMapModuleEntry {
		i32 u0x02000044, ; uint32_t type_token_id
		i32 143; uint32_t java_map_index
	}, ; 0
	%struct.TypeMapModuleEntry {
		i32 u0x0200004a, ; uint32_t type_token_id
		i32 1182; uint32_t java_map_index
	}, ; 1
	%struct.TypeMapModuleEntry {
		i32 u0x02000051, ; uint32_t type_token_id
		i32 893; uint32_t java_map_index
	}, ; 2
	%struct.TypeMapModuleEntry {
		i32 u0x02000055, ; uint32_t type_token_id
		i32 430; uint32_t java_map_index
	}, ; 3
	%struct.TypeMapModuleEntry {
		i32 u0x0200005f, ; uint32_t type_token_id
		i32 858; uint32_t java_map_index
	}, ; 4
	%struct.TypeMapModuleEntry {
		i32 u0x02000067, ; uint32_t type_token_id
		i32 1146; uint32_t java_map_index
	}, ; 5
	%struct.TypeMapModuleEntry {
		i32 u0x0200006e, ; uint32_t type_token_id
		i32 1154; uint32_t java_map_index
	}, ; 6
	%struct.TypeMapModuleEntry {
		i32 u0x02000071, ; uint32_t type_token_id
		i32 369; uint32_t java_map_index
	}, ; 7
	%struct.TypeMapModuleEntry {
		i32 u0x02000079, ; uint32_t type_token_id
		i32 1150; uint32_t java_map_index
	}, ; 8
	%struct.TypeMapModuleEntry {
		i32 u0x0200007b, ; uint32_t type_token_id
		i32 1076; uint32_t java_map_index
	}, ; 9
	%struct.TypeMapModuleEntry {
		i32 u0x0200007d, ; uint32_t type_token_id
		i32 396; uint32_t java_map_index
	}, ; 10
	%struct.TypeMapModuleEntry {
		i32 u0x02000080, ; uint32_t type_token_id
		i32 1; uint32_t java_map_index
	}, ; 11
	%struct.TypeMapModuleEntry {
		i32 u0x02000089, ; uint32_t type_token_id
		i32 471; uint32_t java_map_index
	}, ; 12
	%struct.TypeMapModuleEntry {
		i32 u0x0200008f, ; uint32_t type_token_id
		i32 1237; uint32_t java_map_index
	}, ; 13
	%struct.TypeMapModuleEntry {
		i32 u0x0200009a, ; uint32_t type_token_id
		i32 8; uint32_t java_map_index
	}, ; 14
	%struct.TypeMapModuleEntry {
		i32 u0x0200009c, ; uint32_t type_token_id
		i32 736; uint32_t java_map_index
	}, ; 15
	%struct.TypeMapModuleEntry {
		i32 u0x020000a2, ; uint32_t type_token_id
		i32 1082; uint32_t java_map_index
	}, ; 16
	%struct.TypeMapModuleEntry {
		i32 u0x020000a4, ; uint32_t type_token_id
		i32 61; uint32_t java_map_index
	}, ; 17
	%struct.TypeMapModuleEntry {
		i32 u0x020000a7, ; uint32_t type_token_id
		i32 956; uint32_t java_map_index
	}, ; 18
	%struct.TypeMapModuleEntry {
		i32 u0x020000ab, ; uint32_t type_token_id
		i32 37; uint32_t java_map_index
	}, ; 19
	%struct.TypeMapModuleEntry {
		i32 u0x020000ae, ; uint32_t type_token_id
		i32 137; uint32_t java_map_index
	}, ; 20
	%struct.TypeMapModuleEntry {
		i32 u0x020000b1, ; uint32_t type_token_id
		i32 1100; uint32_t java_map_index
	}, ; 21
	%struct.TypeMapModuleEntry {
		i32 u0x020000b5, ; uint32_t type_token_id
		i32 918; uint32_t java_map_index
	}, ; 22
	%struct.TypeMapModuleEntry {
		i32 u0x020000bf, ; uint32_t type_token_id
		i32 58; uint32_t java_map_index
	}, ; 23
	%struct.TypeMapModuleEntry {
		i32 u0x020000c1, ; uint32_t type_token_id
		i32 510; uint32_t java_map_index
	} ; 24
], align 4

@module15_managed_to_java = internal dso_local constant [2 x %struct.TypeMapModuleEntry] [
	%struct.TypeMapModuleEntry {
		i32 u0x020000a8, ; uint32_t type_token_id
		i32 618; uint32_t java_map_index
	}, ; 0
	%struct.TypeMapModuleEntry {
		i32 u0x020000b4, ; uint32_t type_token_id
		i32 1167; uint32_t java_map_index
	} ; 1
], align 4

@module16_managed_to_java = internal dso_local constant [7 x %struct.TypeMapModuleEntry] [
	%struct.TypeMapModuleEntry {
		i32 u0x0200000c, ; uint32_t type_token_id
		i32 519; uint32_t java_map_index
	}, ; 0
	%struct.TypeMapModuleEntry {
		i32 u0x0200000d, ; uint32_t type_token_id
		i32 507; uint32_t java_map_index
	}, ; 1
	%struct.TypeMapModuleEntry {
		i32 u0x0200000f, ; uint32_t type_token_id
		i32 326; uint32_t java_map_index
	}, ; 2
	%struct.TypeMapModuleEntry {
		i32 u0x02000011, ; uint32_t type_token_id
		i32 592; uint32_t java_map_index
	}, ; 3
	%struct.TypeMapModuleEntry {
		i32 u0x02000012, ; uint32_t type_token_id
		i32 1232; uint32_t java_map_index
	}, ; 4
	%struct.TypeMapModuleEntry {
		i32 u0x02000013, ; uint32_t type_token_id
		i32 1018; uint32_t java_map_index
	}, ; 5
	%struct.TypeMapModuleEntry {
		i32 u0x02000017, ; uint32_t type_token_id
		i32 912; uint32_t java_map_index
	} ; 6
], align 4

@module16_managed_to_java_duplicates = internal dso_local constant [5 x %struct.TypeMapModuleEntry] [
	%struct.TypeMapModuleEntry {
		i32 u0x0200000e, ; uint32_t type_token_id
		i32 507; uint32_t java_map_index
	}, ; 0
	%struct.TypeMapModuleEntry {
		i32 u0x02000010, ; uint32_t type_token_id
		i32 326; uint32_t java_map_index
	}, ; 1
	%struct.TypeMapModuleEntry {
		i32 u0x02000014, ; uint32_t type_token_id
		i32 1018; uint32_t java_map_index
	}, ; 2
	%struct.TypeMapModuleEntry {
		i32 u0x02000015, ; uint32_t type_token_id
		i32 1232; uint32_t java_map_index
	}, ; 3
	%struct.TypeMapModuleEntry {
		i32 u0x02000016, ; uint32_t type_token_id
		i32 592; uint32_t java_map_index
	} ; 4
], align 4

@module17_managed_to_java = internal dso_local constant [39 x %struct.TypeMapModuleEntry] [
	%struct.TypeMapModuleEntry {
		i32 u0x02000016, ; uint32_t type_token_id
		i32 1042; uint32_t java_map_index
	}, ; 0
	%struct.TypeMapModuleEntry {
		i32 u0x02000017, ; uint32_t type_token_id
		i32 231; uint32_t java_map_index
	}, ; 1
	%struct.TypeMapModuleEntry {
		i32 u0x02000023, ; uint32_t type_token_id
		i32 452; uint32_t java_map_index
	}, ; 2
	%struct.TypeMapModuleEntry {
		i32 u0x0200002d, ; uint32_t type_token_id
		i32 641; uint32_t java_map_index
	}, ; 3
	%struct.TypeMapModuleEntry {
		i32 u0x02000080, ; uint32_t type_token_id
		i32 757; uint32_t java_map_index
	}, ; 4
	%struct.TypeMapModuleEntry {
		i32 u0x0200008c, ; uint32_t type_token_id
		i32 1080; uint32_t java_map_index
	}, ; 5
	%struct.TypeMapModuleEntry {
		i32 u0x0200008d, ; uint32_t type_token_id
		i32 946; uint32_t java_map_index
	}, ; 6
	%struct.TypeMapModuleEntry {
		i32 u0x020000be, ; uint32_t type_token_id
		i32 267; uint32_t java_map_index
	}, ; 7
	%struct.TypeMapModuleEntry {
		i32 u0x020000bf, ; uint32_t type_token_id
		i32 153; uint32_t java_map_index
	}, ; 8
	%struct.TypeMapModuleEntry {
		i32 u0x020000c1, ; uint32_t type_token_id
		i32 1144; uint32_t java_map_index
	}, ; 9
	%struct.TypeMapModuleEntry {
		i32 u0x020000c6, ; uint32_t type_token_id
		i32 978; uint32_t java_map_index
	}, ; 10
	%struct.TypeMapModuleEntry {
		i32 u0x020000c7, ; uint32_t type_token_id
		i32 113; uint32_t java_map_index
	}, ; 11
	%struct.TypeMapModuleEntry {
		i32 u0x020000c8, ; uint32_t type_token_id
		i32 1109; uint32_t java_map_index
	}, ; 12
	%struct.TypeMapModuleEntry {
		i32 u0x020000c9, ; uint32_t type_token_id
		i32 1176; uint32_t java_map_index
	}, ; 13
	%struct.TypeMapModuleEntry {
		i32 u0x020000ca, ; uint32_t type_token_id
		i32 630; uint32_t java_map_index
	}, ; 14
	%struct.TypeMapModuleEntry {
		i32 u0x020000cd, ; uint32_t type_token_id
		i32 1140; uint32_t java_map_index
	}, ; 15
	%struct.TypeMapModuleEntry {
		i32 u0x020000cf, ; uint32_t type_token_id
		i32 428; uint32_t java_map_index
	}, ; 16
	%struct.TypeMapModuleEntry {
		i32 u0x020000d3, ; uint32_t type_token_id
		i32 970; uint32_t java_map_index
	}, ; 17
	%struct.TypeMapModuleEntry {
		i32 u0x020000e3, ; uint32_t type_token_id
		i32 316; uint32_t java_map_index
	}, ; 18
	%struct.TypeMapModuleEntry {
		i32 u0x020000e4, ; uint32_t type_token_id
		i32 134; uint32_t java_map_index
	}, ; 19
	%struct.TypeMapModuleEntry {
		i32 u0x0200010f, ; uint32_t type_token_id
		i32 263; uint32_t java_map_index
	}, ; 20
	%struct.TypeMapModuleEntry {
		i32 u0x02000110, ; uint32_t type_token_id
		i32 790; uint32_t java_map_index
	}, ; 21
	%struct.TypeMapModuleEntry {
		i32 u0x0200011e, ; uint32_t type_token_id
		i32 292; uint32_t java_map_index
	}, ; 22
	%struct.TypeMapModuleEntry {
		i32 u0x02000122, ; uint32_t type_token_id
		i32 1180; uint32_t java_map_index
	}, ; 23
	%struct.TypeMapModuleEntry {
		i32 u0x02000142, ; uint32_t type_token_id
		i32 1123; uint32_t java_map_index
	}, ; 24
	%struct.TypeMapModuleEntry {
		i32 u0x0200014d, ; uint32_t type_token_id
		i32 138; uint32_t java_map_index
	}, ; 25
	%struct.TypeMapModuleEntry {
		i32 u0x02000178, ; uint32_t type_token_id
		i32 788; uint32_t java_map_index
	}, ; 26
	%struct.TypeMapModuleEntry {
		i32 u0x02000182, ; uint32_t type_token_id
		i32 107; uint32_t java_map_index
	}, ; 27
	%struct.TypeMapModuleEntry {
		i32 u0x02000183, ; uint32_t type_token_id
		i32 437; uint32_t java_map_index
	}, ; 28
	%struct.TypeMapModuleEntry {
		i32 u0x02000184, ; uint32_t type_token_id
		i32 340; uint32_t java_map_index
	}, ; 29
	%struct.TypeMapModuleEntry {
		i32 u0x02000185, ; uint32_t type_token_id
		i32 802; uint32_t java_map_index
	}, ; 30
	%struct.TypeMapModuleEntry {
		i32 u0x02000187, ; uint32_t type_token_id
		i32 1258; uint32_t java_map_index
	}, ; 31
	%struct.TypeMapModuleEntry {
		i32 u0x0200018e, ; uint32_t type_token_id
		i32 643; uint32_t java_map_index
	}, ; 32
	%struct.TypeMapModuleEntry {
		i32 u0x0200018f, ; uint32_t type_token_id
		i32 1075; uint32_t java_map_index
	}, ; 33
	%struct.TypeMapModuleEntry {
		i32 u0x02000190, ; uint32_t type_token_id
		i32 696; uint32_t java_map_index
	}, ; 34
	%struct.TypeMapModuleEntry {
		i32 u0x02000191, ; uint32_t type_token_id
		i32 205; uint32_t java_map_index
	}, ; 35
	%struct.TypeMapModuleEntry {
		i32 u0x02000195, ; uint32_t type_token_id
		i32 378; uint32_t java_map_index
	}, ; 36
	%struct.TypeMapModuleEntry {
		i32 u0x02000199, ; uint32_t type_token_id
		i32 533; uint32_t java_map_index
	}, ; 37
	%struct.TypeMapModuleEntry {
		i32 u0x0200019a, ; uint32_t type_token_id
		i32 181; uint32_t java_map_index
	} ; 38
], align 4

@module18_managed_to_java = internal dso_local constant [41 x %struct.TypeMapModuleEntry] [
	%struct.TypeMapModuleEntry {
		i32 u0x0200004b, ; uint32_t type_token_id
		i32 269; uint32_t java_map_index
	}, ; 0
	%struct.TypeMapModuleEntry {
		i32 u0x0200004c, ; uint32_t type_token_id
		i32 335; uint32_t java_map_index
	}, ; 1
	%struct.TypeMapModuleEntry {
		i32 u0x0200004e, ; uint32_t type_token_id
		i32 1011; uint32_t java_map_index
	}, ; 2
	%struct.TypeMapModuleEntry {
		i32 u0x02000050, ; uint32_t type_token_id
		i32 73; uint32_t java_map_index
	}, ; 3
	%struct.TypeMapModuleEntry {
		i32 u0x02000051, ; uint32_t type_token_id
		i32 930; uint32_t java_map_index
	}, ; 4
	%struct.TypeMapModuleEntry {
		i32 u0x02000053, ; uint32_t type_token_id
		i32 356; uint32_t java_map_index
	}, ; 5
	%struct.TypeMapModuleEntry {
		i32 u0x02000054, ; uint32_t type_token_id
		i32 383; uint32_t java_map_index
	}, ; 6
	%struct.TypeMapModuleEntry {
		i32 u0x02000055, ; uint32_t type_token_id
		i32 75; uint32_t java_map_index
	}, ; 7
	%struct.TypeMapModuleEntry {
		i32 u0x02000056, ; uint32_t type_token_id
		i32 512; uint32_t java_map_index
	}, ; 8
	%struct.TypeMapModuleEntry {
		i32 u0x02000058, ; uint32_t type_token_id
		i32 456; uint32_t java_map_index
	}, ; 9
	%struct.TypeMapModuleEntry {
		i32 u0x02000059, ; uint32_t type_token_id
		i32 694; uint32_t java_map_index
	}, ; 10
	%struct.TypeMapModuleEntry {
		i32 u0x0200005a, ; uint32_t type_token_id
		i32 691; uint32_t java_map_index
	}, ; 11
	%struct.TypeMapModuleEntry {
		i32 u0x0200005b, ; uint32_t type_token_id
		i32 515; uint32_t java_map_index
	}, ; 12
	%struct.TypeMapModuleEntry {
		i32 u0x0200005d, ; uint32_t type_token_id
		i32 431; uint32_t java_map_index
	}, ; 13
	%struct.TypeMapModuleEntry {
		i32 u0x0200005f, ; uint32_t type_token_id
		i32 327; uint32_t java_map_index
	}, ; 14
	%struct.TypeMapModuleEntry {
		i32 u0x02000061, ; uint32_t type_token_id
		i32 1210; uint32_t java_map_index
	}, ; 15
	%struct.TypeMapModuleEntry {
		i32 u0x02000062, ; uint32_t type_token_id
		i32 853; uint32_t java_map_index
	}, ; 16
	%struct.TypeMapModuleEntry {
		i32 u0x02000063, ; uint32_t type_token_id
		i32 352; uint32_t java_map_index
	}, ; 17
	%struct.TypeMapModuleEntry {
		i32 u0x02000065, ; uint32_t type_token_id
		i32 29; uint32_t java_map_index
	}, ; 18
	%struct.TypeMapModuleEntry {
		i32 u0x02000067, ; uint32_t type_token_id
		i32 493; uint32_t java_map_index
	}, ; 19
	%struct.TypeMapModuleEntry {
		i32 u0x02000069, ; uint32_t type_token_id
		i32 477; uint32_t java_map_index
	}, ; 20
	%struct.TypeMapModuleEntry {
		i32 u0x0200006a, ; uint32_t type_token_id
		i32 387; uint32_t java_map_index
	}, ; 21
	%struct.TypeMapModuleEntry {
		i32 u0x0200006c, ; uint32_t type_token_id
		i32 874; uint32_t java_map_index
	}, ; 22
	%struct.TypeMapModuleEntry {
		i32 u0x0200006e, ; uint32_t type_token_id
		i32 827; uint32_t java_map_index
	}, ; 23
	%struct.TypeMapModuleEntry {
		i32 u0x0200006f, ; uint32_t type_token_id
		i32 668; uint32_t java_map_index
	}, ; 24
	%struct.TypeMapModuleEntry {
		i32 u0x02000073, ; uint32_t type_token_id
		i32 170; uint32_t java_map_index
	}, ; 25
	%struct.TypeMapModuleEntry {
		i32 u0x02000074, ; uint32_t type_token_id
		i32 1192; uint32_t java_map_index
	}, ; 26
	%struct.TypeMapModuleEntry {
		i32 u0x02000076, ; uint32_t type_token_id
		i32 270; uint32_t java_map_index
	}, ; 27
	%struct.TypeMapModuleEntry {
		i32 u0x0200007b, ; uint32_t type_token_id
		i32 605; uint32_t java_map_index
	}, ; 28
	%struct.TypeMapModuleEntry {
		i32 u0x0200007c, ; uint32_t type_token_id
		i32 106; uint32_t java_map_index
	}, ; 29
	%struct.TypeMapModuleEntry {
		i32 u0x0200007e, ; uint32_t type_token_id
		i32 521; uint32_t java_map_index
	}, ; 30
	%struct.TypeMapModuleEntry {
		i32 u0x0200007f, ; uint32_t type_token_id
		i32 1083; uint32_t java_map_index
	}, ; 31
	%struct.TypeMapModuleEntry {
		i32 u0x02000080, ; uint32_t type_token_id
		i32 848; uint32_t java_map_index
	}, ; 32
	%struct.TypeMapModuleEntry {
		i32 u0x02000083, ; uint32_t type_token_id
		i32 1273; uint32_t java_map_index
	}, ; 33
	%struct.TypeMapModuleEntry {
		i32 u0x02000084, ; uint32_t type_token_id
		i32 548; uint32_t java_map_index
	}, ; 34
	%struct.TypeMapModuleEntry {
		i32 u0x02000085, ; uint32_t type_token_id
		i32 1103; uint32_t java_map_index
	}, ; 35
	%struct.TypeMapModuleEntry {
		i32 u0x02000087, ; uint32_t type_token_id
		i32 516; uint32_t java_map_index
	}, ; 36
	%struct.TypeMapModuleEntry {
		i32 u0x02000088, ; uint32_t type_token_id
		i32 49; uint32_t java_map_index
	}, ; 37
	%struct.TypeMapModuleEntry {
		i32 u0x0200008a, ; uint32_t type_token_id
		i32 1007; uint32_t java_map_index
	}, ; 38
	%struct.TypeMapModuleEntry {
		i32 u0x02000099, ; uint32_t type_token_id
		i32 1245; uint32_t java_map_index
	}, ; 39
	%struct.TypeMapModuleEntry {
		i32 u0x0200009a, ; uint32_t type_token_id
		i32 99; uint32_t java_map_index
	} ; 40
], align 4

@module18_managed_to_java_duplicates = internal dso_local constant [21 x %struct.TypeMapModuleEntry] [
	%struct.TypeMapModuleEntry {
		i32 u0x0200004d, ; uint32_t type_token_id
		i32 335; uint32_t java_map_index
	}, ; 0
	%struct.TypeMapModuleEntry {
		i32 u0x0200004f, ; uint32_t type_token_id
		i32 1011; uint32_t java_map_index
	}, ; 1
	%struct.TypeMapModuleEntry {
		i32 u0x02000052, ; uint32_t type_token_id
		i32 930; uint32_t java_map_index
	}, ; 2
	%struct.TypeMapModuleEntry {
		i32 u0x02000057, ; uint32_t type_token_id
		i32 512; uint32_t java_map_index
	}, ; 3
	%struct.TypeMapModuleEntry {
		i32 u0x0200005c, ; uint32_t type_token_id
		i32 691; uint32_t java_map_index
	}, ; 4
	%struct.TypeMapModuleEntry {
		i32 u0x0200005e, ; uint32_t type_token_id
		i32 431; uint32_t java_map_index
	}, ; 5
	%struct.TypeMapModuleEntry {
		i32 u0x02000060, ; uint32_t type_token_id
		i32 327; uint32_t java_map_index
	}, ; 6
	%struct.TypeMapModuleEntry {
		i32 u0x02000064, ; uint32_t type_token_id
		i32 352; uint32_t java_map_index
	}, ; 7
	%struct.TypeMapModuleEntry {
		i32 u0x02000066, ; uint32_t type_token_id
		i32 853; uint32_t java_map_index
	}, ; 8
	%struct.TypeMapModuleEntry {
		i32 u0x02000068, ; uint32_t type_token_id
		i32 493; uint32_t java_map_index
	}, ; 9
	%struct.TypeMapModuleEntry {
		i32 u0x0200006b, ; uint32_t type_token_id
		i32 387; uint32_t java_map_index
	}, ; 10
	%struct.TypeMapModuleEntry {
		i32 u0x0200006d, ; uint32_t type_token_id
		i32 477; uint32_t java_map_index
	}, ; 11
	%struct.TypeMapModuleEntry {
		i32 u0x02000070, ; uint32_t type_token_id
		i32 668; uint32_t java_map_index
	}, ; 12
	%struct.TypeMapModuleEntry {
		i32 u0x02000075, ; uint32_t type_token_id
		i32 1192; uint32_t java_map_index
	}, ; 13
	%struct.TypeMapModuleEntry {
		i32 u0x02000077, ; uint32_t type_token_id
		i32 270; uint32_t java_map_index
	}, ; 14
	%struct.TypeMapModuleEntry {
		i32 u0x0200007d, ; uint32_t type_token_id
		i32 106; uint32_t java_map_index
	}, ; 15
	%struct.TypeMapModuleEntry {
		i32 u0x02000081, ; uint32_t type_token_id
		i32 848; uint32_t java_map_index
	}, ; 16
	%struct.TypeMapModuleEntry {
		i32 u0x02000086, ; uint32_t type_token_id
		i32 548; uint32_t java_map_index
	}, ; 17
	%struct.TypeMapModuleEntry {
		i32 u0x02000089, ; uint32_t type_token_id
		i32 49; uint32_t java_map_index
	}, ; 18
	%struct.TypeMapModuleEntry {
		i32 u0x0200008b, ; uint32_t type_token_id
		i32 1007; uint32_t java_map_index
	}, ; 19
	%struct.TypeMapModuleEntry {
		i32 u0x0200009b, ; uint32_t type_token_id
		i32 99; uint32_t java_map_index
	} ; 20
], align 4

@module19_managed_to_java = internal dso_local constant [13 x %struct.TypeMapModuleEntry] [
	%struct.TypeMapModuleEntry {
		i32 u0x02000009, ; uint32_t type_token_id
		i32 262; uint32_t java_map_index
	}, ; 0
	%struct.TypeMapModuleEntry {
		i32 u0x0200000a, ; uint32_t type_token_id
		i32 424; uint32_t java_map_index
	}, ; 1
	%struct.TypeMapModuleEntry {
		i32 u0x0200000e, ; uint32_t type_token_id
		i32 604; uint32_t java_map_index
	}, ; 2
	%struct.TypeMapModuleEntry {
		i32 u0x0200000f, ; uint32_t type_token_id
		i32 801; uint32_t java_map_index
	}, ; 3
	%struct.TypeMapModuleEntry {
		i32 u0x02000010, ; uint32_t type_token_id
		i32 1004; uint32_t java_map_index
	}, ; 4
	%struct.TypeMapModuleEntry {
		i32 u0x02000012, ; uint32_t type_token_id
		i32 599; uint32_t java_map_index
	}, ; 5
	%struct.TypeMapModuleEntry {
		i32 u0x02000013, ; uint32_t type_token_id
		i32 339; uint32_t java_map_index
	}, ; 6
	%struct.TypeMapModuleEntry {
		i32 u0x02000016, ; uint32_t type_token_id
		i32 941; uint32_t java_map_index
	}, ; 7
	%struct.TypeMapModuleEntry {
		i32 u0x02000017, ; uint32_t type_token_id
		i32 248; uint32_t java_map_index
	}, ; 8
	%struct.TypeMapModuleEntry {
		i32 u0x02000019, ; uint32_t type_token_id
		i32 289; uint32_t java_map_index
	}, ; 9
	%struct.TypeMapModuleEntry {
		i32 u0x0200001b, ; uint32_t type_token_id
		i32 188; uint32_t java_map_index
	}, ; 10
	%struct.TypeMapModuleEntry {
		i32 u0x0200001e, ; uint32_t type_token_id
		i32 988; uint32_t java_map_index
	}, ; 11
	%struct.TypeMapModuleEntry {
		i32 u0x0200001f, ; uint32_t type_token_id
		i32 16; uint32_t java_map_index
	} ; 12
], align 4

@module19_managed_to_java_duplicates = internal dso_local constant [6 x %struct.TypeMapModuleEntry] [
	%struct.TypeMapModuleEntry {
		i32 u0x02000011, ; uint32_t type_token_id
		i32 1004; uint32_t java_map_index
	}, ; 0
	%struct.TypeMapModuleEntry {
		i32 u0x02000014, ; uint32_t type_token_id
		i32 339; uint32_t java_map_index
	}, ; 1
	%struct.TypeMapModuleEntry {
		i32 u0x02000018, ; uint32_t type_token_id
		i32 248; uint32_t java_map_index
	}, ; 2
	%struct.TypeMapModuleEntry {
		i32 u0x0200001a, ; uint32_t type_token_id
		i32 289; uint32_t java_map_index
	}, ; 3
	%struct.TypeMapModuleEntry {
		i32 u0x0200001c, ; uint32_t type_token_id
		i32 188; uint32_t java_map_index
	}, ; 4
	%struct.TypeMapModuleEntry {
		i32 u0x02000020, ; uint32_t type_token_id
		i32 988; uint32_t java_map_index
	} ; 5
], align 4

@module20_managed_to_java = internal dso_local constant [1 x %struct.TypeMapModuleEntry] [
	%struct.TypeMapModuleEntry {
		i32 u0x0200000d, ; uint32_t type_token_id
		i32 1139; uint32_t java_map_index
	} ; 0
], align 4

@module20_managed_to_java_duplicates = internal dso_local constant [1 x %struct.TypeMapModuleEntry] [
	%struct.TypeMapModuleEntry {
		i32 u0x0200000e, ; uint32_t type_token_id
		i32 1139; uint32_t java_map_index
	} ; 0
], align 4

@module21_managed_to_java = internal dso_local constant [75 x %struct.TypeMapModuleEntry] [
	%struct.TypeMapModuleEntry {
		i32 u0x0200003f, ; uint32_t type_token_id
		i32 1036; uint32_t java_map_index
	}, ; 0
	%struct.TypeMapModuleEntry {
		i32 u0x02000041, ; uint32_t type_token_id
		i32 812; uint32_t java_map_index
	}, ; 1
	%struct.TypeMapModuleEntry {
		i32 u0x02000043, ; uint32_t type_token_id
		i32 686; uint32_t java_map_index
	}, ; 2
	%struct.TypeMapModuleEntry {
		i32 u0x02000044, ; uint32_t type_token_id
		i32 699; uint32_t java_map_index
	}, ; 3
	%struct.TypeMapModuleEntry {
		i32 u0x02000045, ; uint32_t type_token_id
		i32 244; uint32_t java_map_index
	}, ; 4
	%struct.TypeMapModuleEntry {
		i32 u0x02000047, ; uint32_t type_token_id
		i32 95; uint32_t java_map_index
	}, ; 5
	%struct.TypeMapModuleEntry {
		i32 u0x02000048, ; uint32_t type_token_id
		i32 1071; uint32_t java_map_index
	}, ; 6
	%struct.TypeMapModuleEntry {
		i32 u0x02000049, ; uint32_t type_token_id
		i32 1280; uint32_t java_map_index
	}, ; 7
	%struct.TypeMapModuleEntry {
		i32 u0x0200004a, ; uint32_t type_token_id
		i32 560; uint32_t java_map_index
	}, ; 8
	%struct.TypeMapModuleEntry {
		i32 u0x0200004b, ; uint32_t type_token_id
		i32 314; uint32_t java_map_index
	}, ; 9
	%struct.TypeMapModuleEntry {
		i32 u0x0200004c, ; uint32_t type_token_id
		i32 712; uint32_t java_map_index
	}, ; 10
	%struct.TypeMapModuleEntry {
		i32 u0x0200004d, ; uint32_t type_token_id
		i32 760; uint32_t java_map_index
	}, ; 11
	%struct.TypeMapModuleEntry {
		i32 u0x0200004e, ; uint32_t type_token_id
		i32 961; uint32_t java_map_index
	}, ; 12
	%struct.TypeMapModuleEntry {
		i32 u0x02000050, ; uint32_t type_token_id
		i32 166; uint32_t java_map_index
	}, ; 13
	%struct.TypeMapModuleEntry {
		i32 u0x02000051, ; uint32_t type_token_id
		i32 1191; uint32_t java_map_index
	}, ; 14
	%struct.TypeMapModuleEntry {
		i32 u0x02000052, ; uint32_t type_token_id
		i32 1215; uint32_t java_map_index
	}, ; 15
	%struct.TypeMapModuleEntry {
		i32 u0x02000054, ; uint32_t type_token_id
		i32 117; uint32_t java_map_index
	}, ; 16
	%struct.TypeMapModuleEntry {
		i32 u0x02000055, ; uint32_t type_token_id
		i32 639; uint32_t java_map_index
	}, ; 17
	%struct.TypeMapModuleEntry {
		i32 u0x02000056, ; uint32_t type_token_id
		i32 344; uint32_t java_map_index
	}, ; 18
	%struct.TypeMapModuleEntry {
		i32 u0x02000057, ; uint32_t type_token_id
		i32 601; uint32_t java_map_index
	}, ; 19
	%struct.TypeMapModuleEntry {
		i32 u0x02000058, ; uint32_t type_token_id
		i32 394; uint32_t java_map_index
	}, ; 20
	%struct.TypeMapModuleEntry {
		i32 u0x0200005b, ; uint32_t type_token_id
		i32 933; uint32_t java_map_index
	}, ; 21
	%struct.TypeMapModuleEntry {
		i32 u0x0200005c, ; uint32_t type_token_id
		i32 1269; uint32_t java_map_index
	}, ; 22
	%struct.TypeMapModuleEntry {
		i32 u0x0200005d, ; uint32_t type_token_id
		i32 245; uint32_t java_map_index
	}, ; 23
	%struct.TypeMapModuleEntry {
		i32 u0x02000060, ; uint32_t type_token_id
		i32 739; uint32_t java_map_index
	}, ; 24
	%struct.TypeMapModuleEntry {
		i32 u0x02000064, ; uint32_t type_token_id
		i32 272; uint32_t java_map_index
	}, ; 25
	%struct.TypeMapModuleEntry {
		i32 u0x02000065, ; uint32_t type_token_id
		i32 372; uint32_t java_map_index
	}, ; 26
	%struct.TypeMapModuleEntry {
		i32 u0x02000066, ; uint32_t type_token_id
		i32 742; uint32_t java_map_index
	}, ; 27
	%struct.TypeMapModuleEntry {
		i32 u0x02000067, ; uint32_t type_token_id
		i32 1242; uint32_t java_map_index
	}, ; 28
	%struct.TypeMapModuleEntry {
		i32 u0x02000068, ; uint32_t type_token_id
		i32 478; uint32_t java_map_index
	}, ; 29
	%struct.TypeMapModuleEntry {
		i32 u0x0200006b, ; uint32_t type_token_id
		i32 871; uint32_t java_map_index
	}, ; 30
	%struct.TypeMapModuleEntry {
		i32 u0x0200006c, ; uint32_t type_token_id
		i32 540; uint32_t java_map_index
	}, ; 31
	%struct.TypeMapModuleEntry {
		i32 u0x0200006f, ; uint32_t type_token_id
		i32 665; uint32_t java_map_index
	}, ; 32
	%struct.TypeMapModuleEntry {
		i32 u0x02000076, ; uint32_t type_token_id
		i32 649; uint32_t java_map_index
	}, ; 33
	%struct.TypeMapModuleEntry {
		i32 u0x02000077, ; uint32_t type_token_id
		i32 80; uint32_t java_map_index
	}, ; 34
	%struct.TypeMapModuleEntry {
		i32 u0x02000078, ; uint32_t type_token_id
		i32 484; uint32_t java_map_index
	}, ; 35
	%struct.TypeMapModuleEntry {
		i32 u0x02000079, ; uint32_t type_token_id
		i32 563; uint32_t java_map_index
	}, ; 36
	%struct.TypeMapModuleEntry {
		i32 u0x0200007b, ; uint32_t type_token_id
		i32 710; uint32_t java_map_index
	}, ; 37
	%struct.TypeMapModuleEntry {
		i32 u0x0200007d, ; uint32_t type_token_id
		i32 1254; uint32_t java_map_index
	}, ; 38
	%struct.TypeMapModuleEntry {
		i32 u0x0200007f, ; uint32_t type_token_id
		i32 564; uint32_t java_map_index
	}, ; 39
	%struct.TypeMapModuleEntry {
		i32 u0x02000081, ; uint32_t type_token_id
		i32 351; uint32_t java_map_index
	}, ; 40
	%struct.TypeMapModuleEntry {
		i32 u0x02000083, ; uint32_t type_token_id
		i32 1247; uint32_t java_map_index
	}, ; 41
	%struct.TypeMapModuleEntry {
		i32 u0x02000085, ; uint32_t type_token_id
		i32 34; uint32_t java_map_index
	}, ; 42
	%struct.TypeMapModuleEntry {
		i32 u0x02000087, ; uint32_t type_token_id
		i32 1226; uint32_t java_map_index
	}, ; 43
	%struct.TypeMapModuleEntry {
		i32 u0x02000088, ; uint32_t type_token_id
		i32 413; uint32_t java_map_index
	}, ; 44
	%struct.TypeMapModuleEntry {
		i32 u0x0200008a, ; uint32_t type_token_id
		i32 576; uint32_t java_map_index
	}, ; 45
	%struct.TypeMapModuleEntry {
		i32 u0x0200008b, ; uint32_t type_token_id
		i32 901; uint32_t java_map_index
	}, ; 46
	%struct.TypeMapModuleEntry {
		i32 u0x0200008c, ; uint32_t type_token_id
		i32 794; uint32_t java_map_index
	}, ; 47
	%struct.TypeMapModuleEntry {
		i32 u0x0200008d, ; uint32_t type_token_id
		i32 441; uint32_t java_map_index
	}, ; 48
	%struct.TypeMapModuleEntry {
		i32 u0x0200008f, ; uint32_t type_token_id
		i32 782; uint32_t java_map_index
	}, ; 49
	%struct.TypeMapModuleEntry {
		i32 u0x02000090, ; uint32_t type_token_id
		i32 470; uint32_t java_map_index
	}, ; 50
	%struct.TypeMapModuleEntry {
		i32 u0x02000091, ; uint32_t type_token_id
		i32 1148; uint32_t java_map_index
	}, ; 51
	%struct.TypeMapModuleEntry {
		i32 u0x02000092, ; uint32_t type_token_id
		i32 614; uint32_t java_map_index
	}, ; 52
	%struct.TypeMapModuleEntry {
		i32 u0x02000093, ; uint32_t type_token_id
		i32 590; uint32_t java_map_index
	}, ; 53
	%struct.TypeMapModuleEntry {
		i32 u0x02000094, ; uint32_t type_token_id
		i32 1227; uint32_t java_map_index
	}, ; 54
	%struct.TypeMapModuleEntry {
		i32 u0x02000096, ; uint32_t type_token_id
		i32 525; uint32_t java_map_index
	}, ; 55
	%struct.TypeMapModuleEntry {
		i32 u0x02000097, ; uint32_t type_token_id
		i32 156; uint32_t java_map_index
	}, ; 56
	%struct.TypeMapModuleEntry {
		i32 u0x02000098, ; uint32_t type_token_id
		i32 174; uint32_t java_map_index
	}, ; 57
	%struct.TypeMapModuleEntry {
		i32 u0x02000099, ; uint32_t type_token_id
		i32 250; uint32_t java_map_index
	}, ; 58
	%struct.TypeMapModuleEntry {
		i32 u0x0200009a, ; uint32_t type_token_id
		i32 636; uint32_t java_map_index
	}, ; 59
	%struct.TypeMapModuleEntry {
		i32 u0x0200009d, ; uint32_t type_token_id
		i32 150; uint32_t java_map_index
	}, ; 60
	%struct.TypeMapModuleEntry {
		i32 u0x020000a1, ; uint32_t type_token_id
		i32 654; uint32_t java_map_index
	}, ; 61
	%struct.TypeMapModuleEntry {
		i32 u0x020000a2, ; uint32_t type_token_id
		i32 4; uint32_t java_map_index
	}, ; 62
	%struct.TypeMapModuleEntry {
		i32 u0x020000a3, ; uint32_t type_token_id
		i32 66; uint32_t java_map_index
	}, ; 63
	%struct.TypeMapModuleEntry {
		i32 u0x020000a4, ; uint32_t type_token_id
		i32 1243; uint32_t java_map_index
	}, ; 64
	%struct.TypeMapModuleEntry {
		i32 u0x020000a5, ; uint32_t type_token_id
		i32 343; uint32_t java_map_index
	}, ; 65
	%struct.TypeMapModuleEntry {
		i32 u0x020000a6, ; uint32_t type_token_id
		i32 932; uint32_t java_map_index
	}, ; 66
	%struct.TypeMapModuleEntry {
		i32 u0x020000a7, ; uint32_t type_token_id
		i32 1060; uint32_t java_map_index
	}, ; 67
	%struct.TypeMapModuleEntry {
		i32 u0x020000a8, ; uint32_t type_token_id
		i32 247; uint32_t java_map_index
	}, ; 68
	%struct.TypeMapModuleEntry {
		i32 u0x020000a9, ; uint32_t type_token_id
		i32 490; uint32_t java_map_index
	}, ; 69
	%struct.TypeMapModuleEntry {
		i32 u0x020000aa, ; uint32_t type_token_id
		i32 947; uint32_t java_map_index
	}, ; 70
	%struct.TypeMapModuleEntry {
		i32 u0x020000ab, ; uint32_t type_token_id
		i32 1236; uint32_t java_map_index
	}, ; 71
	%struct.TypeMapModuleEntry {
		i32 u0x020000ad, ; uint32_t type_token_id
		i32 880; uint32_t java_map_index
	}, ; 72
	%struct.TypeMapModuleEntry {
		i32 u0x020000af, ; uint32_t type_token_id
		i32 502; uint32_t java_map_index
	}, ; 73
	%struct.TypeMapModuleEntry {
		i32 u0x020000b0, ; uint32_t type_token_id
		i32 863; uint32_t java_map_index
	} ; 74
], align 4

@module21_managed_to_java_duplicates = internal dso_local constant [24 x %struct.TypeMapModuleEntry] [
	%struct.TypeMapModuleEntry {
		i32 u0x02000040, ; uint32_t type_token_id
		i32 1036; uint32_t java_map_index
	}, ; 0
	%struct.TypeMapModuleEntry {
		i32 u0x02000042, ; uint32_t type_token_id
		i32 812; uint32_t java_map_index
	}, ; 1
	%struct.TypeMapModuleEntry {
		i32 u0x02000046, ; uint32_t type_token_id
		i32 244; uint32_t java_map_index
	}, ; 2
	%struct.TypeMapModuleEntry {
		i32 u0x0200004f, ; uint32_t type_token_id
		i32 961; uint32_t java_map_index
	}, ; 3
	%struct.TypeMapModuleEntry {
		i32 u0x02000053, ; uint32_t type_token_id
		i32 1215; uint32_t java_map_index
	}, ; 4
	%struct.TypeMapModuleEntry {
		i32 u0x02000059, ; uint32_t type_token_id
		i32 394; uint32_t java_map_index
	}, ; 5
	%struct.TypeMapModuleEntry {
		i32 u0x0200005a, ; uint32_t type_token_id
		i32 601; uint32_t java_map_index
	}, ; 6
	%struct.TypeMapModuleEntry {
		i32 u0x0200005e, ; uint32_t type_token_id
		i32 245; uint32_t java_map_index
	}, ; 7
	%struct.TypeMapModuleEntry {
		i32 u0x02000069, ; uint32_t type_token_id
		i32 478; uint32_t java_map_index
	}, ; 8
	%struct.TypeMapModuleEntry {
		i32 u0x0200006d, ; uint32_t type_token_id
		i32 540; uint32_t java_map_index
	}, ; 9
	%struct.TypeMapModuleEntry {
		i32 u0x02000075, ; uint32_t type_token_id
		i32 1242; uint32_t java_map_index
	}, ; 10
	%struct.TypeMapModuleEntry {
		i32 u0x0200007a, ; uint32_t type_token_id
		i32 563; uint32_t java_map_index
	}, ; 11
	%struct.TypeMapModuleEntry {
		i32 u0x0200007c, ; uint32_t type_token_id
		i32 710; uint32_t java_map_index
	}, ; 12
	%struct.TypeMapModuleEntry {
		i32 u0x0200007e, ; uint32_t type_token_id
		i32 1254; uint32_t java_map_index
	}, ; 13
	%struct.TypeMapModuleEntry {
		i32 u0x02000080, ; uint32_t type_token_id
		i32 564; uint32_t java_map_index
	}, ; 14
	%struct.TypeMapModuleEntry {
		i32 u0x02000082, ; uint32_t type_token_id
		i32 351; uint32_t java_map_index
	}, ; 15
	%struct.TypeMapModuleEntry {
		i32 u0x02000084, ; uint32_t type_token_id
		i32 1247; uint32_t java_map_index
	}, ; 16
	%struct.TypeMapModuleEntry {
		i32 u0x02000086, ; uint32_t type_token_id
		i32 34; uint32_t java_map_index
	}, ; 17
	%struct.TypeMapModuleEntry {
		i32 u0x02000089, ; uint32_t type_token_id
		i32 413; uint32_t java_map_index
	}, ; 18
	%struct.TypeMapModuleEntry {
		i32 u0x0200008e, ; uint32_t type_token_id
		i32 441; uint32_t java_map_index
	}, ; 19
	%struct.TypeMapModuleEntry {
		i32 u0x02000095, ; uint32_t type_token_id
		i32 1227; uint32_t java_map_index
	}, ; 20
	%struct.TypeMapModuleEntry {
		i32 u0x0200009b, ; uint32_t type_token_id
		i32 636; uint32_t java_map_index
	}, ; 21
	%struct.TypeMapModuleEntry {
		i32 u0x020000ac, ; uint32_t type_token_id
		i32 1236; uint32_t java_map_index
	}, ; 22
	%struct.TypeMapModuleEntry {
		i32 u0x020000ae, ; uint32_t type_token_id
		i32 880; uint32_t java_map_index
	} ; 23
], align 4

@module22_managed_to_java = internal dso_local constant [5 x %struct.TypeMapModuleEntry] [
	%struct.TypeMapModuleEntry {
		i32 u0x02000004, ; uint32_t type_token_id
		i32 1147; uint32_t java_map_index
	}, ; 0
	%struct.TypeMapModuleEntry {
		i32 u0x02000006, ; uint32_t type_token_id
		i32 202; uint32_t java_map_index
	}, ; 1
	%struct.TypeMapModuleEntry {
		i32 u0x02000008, ; uint32_t type_token_id
		i32 72; uint32_t java_map_index
	}, ; 2
	%struct.TypeMapModuleEntry {
		i32 u0x0200000a, ; uint32_t type_token_id
		i32 600; uint32_t java_map_index
	}, ; 3
	%struct.TypeMapModuleEntry {
		i32 u0x0200000c, ; uint32_t type_token_id
		i32 546; uint32_t java_map_index
	} ; 4
], align 4

@module22_managed_to_java_duplicates = internal dso_local constant [5 x %struct.TypeMapModuleEntry] [
	%struct.TypeMapModuleEntry {
		i32 u0x02000005, ; uint32_t type_token_id
		i32 1147; uint32_t java_map_index
	}, ; 0
	%struct.TypeMapModuleEntry {
		i32 u0x02000007, ; uint32_t type_token_id
		i32 202; uint32_t java_map_index
	}, ; 1
	%struct.TypeMapModuleEntry {
		i32 u0x02000009, ; uint32_t type_token_id
		i32 72; uint32_t java_map_index
	}, ; 2
	%struct.TypeMapModuleEntry {
		i32 u0x0200000b, ; uint32_t type_token_id
		i32 600; uint32_t java_map_index
	}, ; 3
	%struct.TypeMapModuleEntry {
		i32 u0x0200000d, ; uint32_t type_token_id
		i32 546; uint32_t java_map_index
	} ; 4
], align 4

@module23_managed_to_java = internal dso_local constant [9 x %struct.TypeMapModuleEntry] [
	%struct.TypeMapModuleEntry {
		i32 u0x0200000a, ; uint32_t type_token_id
		i32 591; uint32_t java_map_index
	}, ; 0
	%struct.TypeMapModuleEntry {
		i32 u0x02000031, ; uint32_t type_token_id
		i32 877; uint32_t java_map_index
	}, ; 1
	%struct.TypeMapModuleEntry {
		i32 u0x02000036, ; uint32_t type_token_id
		i32 571; uint32_t java_map_index
	}, ; 2
	%struct.TypeMapModuleEntry {
		i32 u0x0200003d, ; uint32_t type_token_id
		i32 333; uint32_t java_map_index
	}, ; 3
	%struct.TypeMapModuleEntry {
		i32 u0x0200007a, ; uint32_t type_token_id
		i32 684; uint32_t java_map_index
	}, ; 4
	%struct.TypeMapModuleEntry {
		i32 u0x0200007b, ; uint32_t type_token_id
		i32 931; uint32_t java_map_index
	}, ; 5
	%struct.TypeMapModuleEntry {
		i32 u0x0200008f, ; uint32_t type_token_id
		i32 1162; uint32_t java_map_index
	}, ; 6
	%struct.TypeMapModuleEntry {
		i32 u0x02000099, ; uint32_t type_token_id
		i32 833; uint32_t java_map_index
	}, ; 7
	%struct.TypeMapModuleEntry {
		i32 u0x0200009a, ; uint32_t type_token_id
		i32 725; uint32_t java_map_index
	} ; 8
], align 4

@module24_managed_to_java = internal dso_local constant [1 x %struct.TypeMapModuleEntry] [
	%struct.TypeMapModuleEntry {
		i32 u0x02000004, ; uint32_t type_token_id
		i32 520; uint32_t java_map_index
	} ; 0
], align 4

@module25_managed_to_java = internal dso_local constant [59 x %struct.TypeMapModuleEntry] [
	%struct.TypeMapModuleEntry {
		i32 u0x0200003a, ; uint32_t type_token_id
		i32 1088; uint32_t java_map_index
	}, ; 0
	%struct.TypeMapModuleEntry {
		i32 u0x0200003b, ; uint32_t type_token_id
		i32 449; uint32_t java_map_index
	}, ; 1
	%struct.TypeMapModuleEntry {
		i32 u0x0200003c, ; uint32_t type_token_id
		i32 818; uint32_t java_map_index
	}, ; 2
	%struct.TypeMapModuleEntry {
		i32 u0x0200003d, ; uint32_t type_token_id
		i32 568; uint32_t java_map_index
	}, ; 3
	%struct.TypeMapModuleEntry {
		i32 u0x0200003e, ; uint32_t type_token_id
		i32 407; uint32_t java_map_index
	}, ; 4
	%struct.TypeMapModuleEntry {
		i32 u0x0200003f, ; uint32_t type_token_id
		i32 1169; uint32_t java_map_index
	}, ; 5
	%struct.TypeMapModuleEntry {
		i32 u0x02000040, ; uint32_t type_token_id
		i32 854; uint32_t java_map_index
	}, ; 6
	%struct.TypeMapModuleEntry {
		i32 u0x02000041, ; uint32_t type_token_id
		i32 528; uint32_t java_map_index
	}, ; 7
	%struct.TypeMapModuleEntry {
		i32 u0x02000042, ; uint32_t type_token_id
		i32 612; uint32_t java_map_index
	}, ; 8
	%struct.TypeMapModuleEntry {
		i32 u0x02000045, ; uint32_t type_token_id
		i32 1235; uint32_t java_map_index
	}, ; 9
	%struct.TypeMapModuleEntry {
		i32 u0x02000046, ; uint32_t type_token_id
		i32 94; uint32_t java_map_index
	}, ; 10
	%struct.TypeMapModuleEntry {
		i32 u0x02000048, ; uint32_t type_token_id
		i32 412; uint32_t java_map_index
	}, ; 11
	%struct.TypeMapModuleEntry {
		i32 u0x0200004a, ; uint32_t type_token_id
		i32 824; uint32_t java_map_index
	}, ; 12
	%struct.TypeMapModuleEntry {
		i32 u0x02000050, ; uint32_t type_token_id
		i32 681; uint32_t java_map_index
	}, ; 13
	%struct.TypeMapModuleEntry {
		i32 u0x02000051, ; uint32_t type_token_id
		i32 171; uint32_t java_map_index
	}, ; 14
	%struct.TypeMapModuleEntry {
		i32 u0x02000053, ; uint32_t type_token_id
		i32 879; uint32_t java_map_index
	}, ; 15
	%struct.TypeMapModuleEntry {
		i32 u0x02000054, ; uint32_t type_token_id
		i32 622; uint32_t java_map_index
	}, ; 16
	%struct.TypeMapModuleEntry {
		i32 u0x02000056, ; uint32_t type_token_id
		i32 867; uint32_t java_map_index
	}, ; 17
	%struct.TypeMapModuleEntry {
		i32 u0x02000057, ; uint32_t type_token_id
		i32 1107; uint32_t java_map_index
	}, ; 18
	%struct.TypeMapModuleEntry {
		i32 u0x02000059, ; uint32_t type_token_id
		i32 862; uint32_t java_map_index
	}, ; 19
	%struct.TypeMapModuleEntry {
		i32 u0x0200005a, ; uint32_t type_token_id
		i32 1228; uint32_t java_map_index
	}, ; 20
	%struct.TypeMapModuleEntry {
		i32 u0x0200005c, ; uint32_t type_token_id
		i32 1195; uint32_t java_map_index
	}, ; 21
	%struct.TypeMapModuleEntry {
		i32 u0x0200005d, ; uint32_t type_token_id
		i32 243; uint32_t java_map_index
	}, ; 22
	%struct.TypeMapModuleEntry {
		i32 u0x02000060, ; uint32_t type_token_id
		i32 1062; uint32_t java_map_index
	}, ; 23
	%struct.TypeMapModuleEntry {
		i32 u0x02000064, ; uint32_t type_token_id
		i32 816; uint32_t java_map_index
	}, ; 24
	%struct.TypeMapModuleEntry {
		i32 u0x02000065, ; uint32_t type_token_id
		i32 1093; uint32_t java_map_index
	}, ; 25
	%struct.TypeMapModuleEntry {
		i32 u0x02000066, ; uint32_t type_token_id
		i32 974; uint32_t java_map_index
	}, ; 26
	%struct.TypeMapModuleEntry {
		i32 u0x02000067, ; uint32_t type_token_id
		i32 1219; uint32_t java_map_index
	}, ; 27
	%struct.TypeMapModuleEntry {
		i32 u0x02000068, ; uint32_t type_token_id
		i32 996; uint32_t java_map_index
	}, ; 28
	%struct.TypeMapModuleEntry {
		i32 u0x02000069, ; uint32_t type_token_id
		i32 28; uint32_t java_map_index
	}, ; 29
	%struct.TypeMapModuleEntry {
		i32 u0x0200006a, ; uint32_t type_token_id
		i32 421; uint32_t java_map_index
	}, ; 30
	%struct.TypeMapModuleEntry {
		i32 u0x0200006b, ; uint32_t type_token_id
		i32 228; uint32_t java_map_index
	}, ; 31
	%struct.TypeMapModuleEntry {
		i32 u0x0200006c, ; uint32_t type_token_id
		i32 364; uint32_t java_map_index
	}, ; 32
	%struct.TypeMapModuleEntry {
		i32 u0x0200006d, ; uint32_t type_token_id
		i32 1163; uint32_t java_map_index
	}, ; 33
	%struct.TypeMapModuleEntry {
		i32 u0x0200006f, ; uint32_t type_token_id
		i32 791; uint32_t java_map_index
	}, ; 34
	%struct.TypeMapModuleEntry {
		i32 u0x02000075, ; uint32_t type_token_id
		i32 1263; uint32_t java_map_index
	}, ; 35
	%struct.TypeMapModuleEntry {
		i32 u0x02000077, ; uint32_t type_token_id
		i32 804; uint32_t java_map_index
	}, ; 36
	%struct.TypeMapModuleEntry {
		i32 u0x02000078, ; uint32_t type_token_id
		i32 1135; uint32_t java_map_index
	}, ; 37
	%struct.TypeMapModuleEntry {
		i32 u0x02000079, ; uint32_t type_token_id
		i32 418; uint32_t java_map_index
	}, ; 38
	%struct.TypeMapModuleEntry {
		i32 u0x0200007a, ; uint32_t type_token_id
		i32 593; uint32_t java_map_index
	}, ; 39
	%struct.TypeMapModuleEntry {
		i32 u0x0200007b, ; uint32_t type_token_id
		i32 800; uint32_t java_map_index
	}, ; 40
	%struct.TypeMapModuleEntry {
		i32 u0x0200007c, ; uint32_t type_token_id
		i32 625; uint32_t java_map_index
	}, ; 41
	%struct.TypeMapModuleEntry {
		i32 u0x0200007f, ; uint32_t type_token_id
		i32 22; uint32_t java_map_index
	}, ; 42
	%struct.TypeMapModuleEntry {
		i32 u0x02000080, ; uint32_t type_token_id
		i32 481; uint32_t java_map_index
	}, ; 43
	%struct.TypeMapModuleEntry {
		i32 u0x02000084, ; uint32_t type_token_id
		i32 1021; uint32_t java_map_index
	}, ; 44
	%struct.TypeMapModuleEntry {
		i32 u0x02000085, ; uint32_t type_token_id
		i32 102; uint32_t java_map_index
	}, ; 45
	%struct.TypeMapModuleEntry {
		i32 u0x02000089, ; uint32_t type_token_id
		i32 647; uint32_t java_map_index
	}, ; 46
	%struct.TypeMapModuleEntry {
		i32 u0x02000095, ; uint32_t type_token_id
		i32 992; uint32_t java_map_index
	}, ; 47
	%struct.TypeMapModuleEntry {
		i32 u0x02000096, ; uint32_t type_token_id
		i32 875; uint32_t java_map_index
	}, ; 48
	%struct.TypeMapModuleEntry {
		i32 u0x02000097, ; uint32_t type_token_id
		i32 529; uint32_t java_map_index
	}, ; 49
	%struct.TypeMapModuleEntry {
		i32 u0x02000098, ; uint32_t type_token_id
		i32 1136; uint32_t java_map_index
	}, ; 50
	%struct.TypeMapModuleEntry {
		i32 u0x02000099, ; uint32_t type_token_id
		i32 322; uint32_t java_map_index
	}, ; 51
	%struct.TypeMapModuleEntry {
		i32 u0x0200009c, ; uint32_t type_token_id
		i32 1040; uint32_t java_map_index
	}, ; 52
	%struct.TypeMapModuleEntry {
		i32 u0x0200009d, ; uint32_t type_token_id
		i32 695; uint32_t java_map_index
	}, ; 53
	%struct.TypeMapModuleEntry {
		i32 u0x0200009f, ; uint32_t type_token_id
		i32 349; uint32_t java_map_index
	}, ; 54
	%struct.TypeMapModuleEntry {
		i32 u0x020000a1, ; uint32_t type_token_id
		i32 131; uint32_t java_map_index
	}, ; 55
	%struct.TypeMapModuleEntry {
		i32 u0x020000a3, ; uint32_t type_token_id
		i32 806; uint32_t java_map_index
	}, ; 56
	%struct.TypeMapModuleEntry {
		i32 u0x020000a5, ; uint32_t type_token_id
		i32 336; uint32_t java_map_index
	}, ; 57
	%struct.TypeMapModuleEntry {
		i32 u0x020000a6, ; uint32_t type_token_id
		i32 30; uint32_t java_map_index
	} ; 58
], align 4

@module25_managed_to_java_duplicates = internal dso_local constant [20 x %struct.TypeMapModuleEntry] [
	%struct.TypeMapModuleEntry {
		i32 u0x02000043, ; uint32_t type_token_id
		i32 612; uint32_t java_map_index
	}, ; 0
	%struct.TypeMapModuleEntry {
		i32 u0x02000047, ; uint32_t type_token_id
		i32 94; uint32_t java_map_index
	}, ; 1
	%struct.TypeMapModuleEntry {
		i32 u0x02000049, ; uint32_t type_token_id
		i32 412; uint32_t java_map_index
	}, ; 2
	%struct.TypeMapModuleEntry {
		i32 u0x0200004b, ; uint32_t type_token_id
		i32 824; uint32_t java_map_index
	}, ; 3
	%struct.TypeMapModuleEntry {
		i32 u0x0200004f, ; uint32_t type_token_id
		i32 854; uint32_t java_map_index
	}, ; 4
	%struct.TypeMapModuleEntry {
		i32 u0x02000052, ; uint32_t type_token_id
		i32 171; uint32_t java_map_index
	}, ; 5
	%struct.TypeMapModuleEntry {
		i32 u0x02000055, ; uint32_t type_token_id
		i32 622; uint32_t java_map_index
	}, ; 6
	%struct.TypeMapModuleEntry {
		i32 u0x02000058, ; uint32_t type_token_id
		i32 1107; uint32_t java_map_index
	}, ; 7
	%struct.TypeMapModuleEntry {
		i32 u0x0200005e, ; uint32_t type_token_id
		i32 243; uint32_t java_map_index
	}, ; 8
	%struct.TypeMapModuleEntry {
		i32 u0x0200006e, ; uint32_t type_token_id
		i32 1163; uint32_t java_map_index
	}, ; 9
	%struct.TypeMapModuleEntry {
		i32 u0x02000076, ; uint32_t type_token_id
		i32 1263; uint32_t java_map_index
	}, ; 10
	%struct.TypeMapModuleEntry {
		i32 u0x0200007d, ; uint32_t type_token_id
		i32 625; uint32_t java_map_index
	}, ; 11
	%struct.TypeMapModuleEntry {
		i32 u0x02000081, ; uint32_t type_token_id
		i32 481; uint32_t java_map_index
	}, ; 12
	%struct.TypeMapModuleEntry {
		i32 u0x02000086, ; uint32_t type_token_id
		i32 102; uint32_t java_map_index
	}, ; 13
	%struct.TypeMapModuleEntry {
		i32 u0x0200009a, ; uint32_t type_token_id
		i32 322; uint32_t java_map_index
	}, ; 14
	%struct.TypeMapModuleEntry {
		i32 u0x0200009b, ; uint32_t type_token_id
		i32 1136; uint32_t java_map_index
	}, ; 15
	%struct.TypeMapModuleEntry {
		i32 u0x0200009e, ; uint32_t type_token_id
		i32 695; uint32_t java_map_index
	}, ; 16
	%struct.TypeMapModuleEntry {
		i32 u0x020000a0, ; uint32_t type_token_id
		i32 349; uint32_t java_map_index
	}, ; 17
	%struct.TypeMapModuleEntry {
		i32 u0x020000a2, ; uint32_t type_token_id
		i32 131; uint32_t java_map_index
	}, ; 18
	%struct.TypeMapModuleEntry {
		i32 u0x020000a4, ; uint32_t type_token_id
		i32 806; uint32_t java_map_index
	} ; 19
], align 4

@module26_managed_to_java = internal dso_local constant [10 x %struct.TypeMapModuleEntry] [
	%struct.TypeMapModuleEntry {
		i32 u0x0200002f, ; uint32_t type_token_id
		i32 1099; uint32_t java_map_index
	}, ; 0
	%struct.TypeMapModuleEntry {
		i32 u0x02000031, ; uint32_t type_token_id
		i32 125; uint32_t java_map_index
	}, ; 1
	%struct.TypeMapModuleEntry {
		i32 u0x02000033, ; uint32_t type_token_id
		i32 530; uint32_t java_map_index
	}, ; 2
	%struct.TypeMapModuleEntry {
		i32 u0x02000035, ; uint32_t type_token_id
		i32 703; uint32_t java_map_index
	}, ; 3
	%struct.TypeMapModuleEntry {
		i32 u0x02000036, ; uint32_t type_token_id
		i32 232; uint32_t java_map_index
	}, ; 4
	%struct.TypeMapModuleEntry {
		i32 u0x02000038, ; uint32_t type_token_id
		i32 1056; uint32_t java_map_index
	}, ; 5
	%struct.TypeMapModuleEntry {
		i32 u0x0200003a, ; uint32_t type_token_id
		i32 1171; uint32_t java_map_index
	}, ; 6
	%struct.TypeMapModuleEntry {
		i32 u0x0200003c, ; uint32_t type_token_id
		i32 217; uint32_t java_map_index
	}, ; 7
	%struct.TypeMapModuleEntry {
		i32 u0x0200003e, ; uint32_t type_token_id
		i32 674; uint32_t java_map_index
	}, ; 8
	%struct.TypeMapModuleEntry {
		i32 u0x02000040, ; uint32_t type_token_id
		i32 637; uint32_t java_map_index
	} ; 9
], align 4

@module26_managed_to_java_duplicates = internal dso_local constant [9 x %struct.TypeMapModuleEntry] [
	%struct.TypeMapModuleEntry {
		i32 u0x02000030, ; uint32_t type_token_id
		i32 1099; uint32_t java_map_index
	}, ; 0
	%struct.TypeMapModuleEntry {
		i32 u0x02000032, ; uint32_t type_token_id
		i32 125; uint32_t java_map_index
	}, ; 1
	%struct.TypeMapModuleEntry {
		i32 u0x02000034, ; uint32_t type_token_id
		i32 530; uint32_t java_map_index
	}, ; 2
	%struct.TypeMapModuleEntry {
		i32 u0x02000037, ; uint32_t type_token_id
		i32 232; uint32_t java_map_index
	}, ; 3
	%struct.TypeMapModuleEntry {
		i32 u0x02000039, ; uint32_t type_token_id
		i32 1056; uint32_t java_map_index
	}, ; 4
	%struct.TypeMapModuleEntry {
		i32 u0x0200003b, ; uint32_t type_token_id
		i32 1171; uint32_t java_map_index
	}, ; 5
	%struct.TypeMapModuleEntry {
		i32 u0x0200003d, ; uint32_t type_token_id
		i32 217; uint32_t java_map_index
	}, ; 6
	%struct.TypeMapModuleEntry {
		i32 u0x0200003f, ; uint32_t type_token_id
		i32 674; uint32_t java_map_index
	}, ; 7
	%struct.TypeMapModuleEntry {
		i32 u0x02000041, ; uint32_t type_token_id
		i32 637; uint32_t java_map_index
	} ; 8
], align 4

@module27_managed_to_java = internal dso_local constant [5 x %struct.TypeMapModuleEntry] [
	%struct.TypeMapModuleEntry {
		i32 u0x0200000f, ; uint32_t type_token_id
		i32 324; uint32_t java_map_index
	}, ; 0
	%struct.TypeMapModuleEntry {
		i32 u0x02000010, ; uint32_t type_token_id
		i32 642; uint32_t java_map_index
	}, ; 1
	%struct.TypeMapModuleEntry {
		i32 u0x02000012, ; uint32_t type_token_id
		i32 416; uint32_t java_map_index
	}, ; 2
	%struct.TypeMapModuleEntry {
		i32 u0x02000014, ; uint32_t type_token_id
		i32 1079; uint32_t java_map_index
	}, ; 3
	%struct.TypeMapModuleEntry {
		i32 u0x02000015, ; uint32_t type_token_id
		i32 896; uint32_t java_map_index
	} ; 4
], align 4

@module27_managed_to_java_duplicates = internal dso_local constant [4 x %struct.TypeMapModuleEntry] [
	%struct.TypeMapModuleEntry {
		i32 u0x02000011, ; uint32_t type_token_id
		i32 642; uint32_t java_map_index
	}, ; 0
	%struct.TypeMapModuleEntry {
		i32 u0x02000013, ; uint32_t type_token_id
		i32 416; uint32_t java_map_index
	}, ; 1
	%struct.TypeMapModuleEntry {
		i32 u0x02000016, ; uint32_t type_token_id
		i32 896; uint32_t java_map_index
	}, ; 2
	%struct.TypeMapModuleEntry {
		i32 u0x02000017, ; uint32_t type_token_id
		i32 1079; uint32_t java_map_index
	} ; 3
], align 4

@module28_managed_to_java = internal dso_local constant [4 x %struct.TypeMapModuleEntry] [
	%struct.TypeMapModuleEntry {
		i32 u0x02000003, ; uint32_t type_token_id
		i32 1014; uint32_t java_map_index
	}, ; 0
	%struct.TypeMapModuleEntry {
		i32 u0x02000004, ; uint32_t type_token_id
		i32 902; uint32_t java_map_index
	}, ; 1
	%struct.TypeMapModuleEntry {
		i32 u0x02000005, ; uint32_t type_token_id
		i32 743; uint32_t java_map_index
	}, ; 2
	%struct.TypeMapModuleEntry {
		i32 u0x02000007, ; uint32_t type_token_id
		i32 1037; uint32_t java_map_index
	} ; 3
], align 4

@module28_managed_to_java_duplicates = internal dso_local constant [1 x %struct.TypeMapModuleEntry] [
	%struct.TypeMapModuleEntry {
		i32 u0x02000006, ; uint32_t type_token_id
		i32 743; uint32_t java_map_index
	} ; 0
], align 4

@module29_managed_to_java = internal dso_local constant [1 x %struct.TypeMapModuleEntry] [
	%struct.TypeMapModuleEntry {
		i32 u0x02000004, ; uint32_t type_token_id
		i32 467; uint32_t java_map_index
	} ; 0
], align 4

@module29_managed_to_java_duplicates = internal dso_local constant [1 x %struct.TypeMapModuleEntry] [
	%struct.TypeMapModuleEntry {
		i32 u0x02000005, ; uint32_t type_token_id
		i32 467; uint32_t java_map_index
	} ; 0
], align 4

@module30_managed_to_java = internal dso_local constant [3 x %struct.TypeMapModuleEntry] [
	%struct.TypeMapModuleEntry {
		i32 u0x02000006, ; uint32_t type_token_id
		i32 569; uint32_t java_map_index
	}, ; 0
	%struct.TypeMapModuleEntry {
		i32 u0x02000007, ; uint32_t type_token_id
		i32 32; uint32_t java_map_index
	}, ; 1
	%struct.TypeMapModuleEntry {
		i32 u0x02000008, ; uint32_t type_token_id
		i32 1187; uint32_t java_map_index
	} ; 2
], align 4

@module31_managed_to_java = internal dso_local constant [3 x %struct.TypeMapModuleEntry] [
	%struct.TypeMapModuleEntry {
		i32 u0x0200001a, ; uint32_t type_token_id
		i32 104; uint32_t java_map_index
	}, ; 0
	%struct.TypeMapModuleEntry {
		i32 u0x0200001e, ; uint32_t type_token_id
		i32 251; uint32_t java_map_index
	}, ; 1
	%struct.TypeMapModuleEntry {
		i32 u0x02000020, ; uint32_t type_token_id
		i32 968; uint32_t java_map_index
	} ; 2
], align 4

@module32_managed_to_java = internal dso_local constant [11 x %struct.TypeMapModuleEntry] [
	%struct.TypeMapModuleEntry {
		i32 u0x0200000e, ; uint32_t type_token_id
		i32 473; uint32_t java_map_index
	}, ; 0
	%struct.TypeMapModuleEntry {
		i32 u0x0200000f, ; uint32_t type_token_id
		i32 47; uint32_t java_map_index
	}, ; 1
	%struct.TypeMapModuleEntry {
		i32 u0x02000010, ; uint32_t type_token_id
		i32 726; uint32_t java_map_index
	}, ; 2
	%struct.TypeMapModuleEntry {
		i32 u0x02000011, ; uint32_t type_token_id
		i32 3; uint32_t java_map_index
	}, ; 3
	%struct.TypeMapModuleEntry {
		i32 u0x02000012, ; uint32_t type_token_id
		i32 158; uint32_t java_map_index
	}, ; 4
	%struct.TypeMapModuleEntry {
		i32 u0x02000013, ; uint32_t type_token_id
		i32 740; uint32_t java_map_index
	}, ; 5
	%struct.TypeMapModuleEntry {
		i32 u0x02000015, ; uint32_t type_token_id
		i32 547; uint32_t java_map_index
	}, ; 6
	%struct.TypeMapModuleEntry {
		i32 u0x02000017, ; uint32_t type_token_id
		i32 52; uint32_t java_map_index
	}, ; 7
	%struct.TypeMapModuleEntry {
		i32 u0x02000018, ; uint32_t type_token_id
		i32 190; uint32_t java_map_index
	}, ; 8
	%struct.TypeMapModuleEntry {
		i32 u0x02000019, ; uint32_t type_token_id
		i32 518; uint32_t java_map_index
	}, ; 9
	%struct.TypeMapModuleEntry {
		i32 u0x0200001a, ; uint32_t type_token_id
		i32 628; uint32_t java_map_index
	} ; 10
], align 4

@module32_managed_to_java_duplicates = internal dso_local constant [2 x %struct.TypeMapModuleEntry] [
	%struct.TypeMapModuleEntry {
		i32 u0x02000014, ; uint32_t type_token_id
		i32 740; uint32_t java_map_index
	}, ; 0
	%struct.TypeMapModuleEntry {
		i32 u0x02000016, ; uint32_t type_token_id
		i32 547; uint32_t java_map_index
	} ; 1
], align 4

@module33_managed_to_java = internal dso_local constant [2 x %struct.TypeMapModuleEntry] [
	%struct.TypeMapModuleEntry {
		i32 u0x02000003, ; uint32_t type_token_id
		i32 208; uint32_t java_map_index
	}, ; 0
	%struct.TypeMapModuleEntry {
		i32 u0x02000004, ; uint32_t type_token_id
		i32 761; uint32_t java_map_index
	} ; 1
], align 4

@module33_managed_to_java_duplicates = internal dso_local constant [1 x %struct.TypeMapModuleEntry] [
	%struct.TypeMapModuleEntry {
		i32 u0x02000005, ; uint32_t type_token_id
		i32 761; uint32_t java_map_index
	} ; 0
], align 4

@module34_managed_to_java = internal dso_local constant [107 x %struct.TypeMapModuleEntry] [
	%struct.TypeMapModuleEntry {
		i32 u0x0200034e, ; uint32_t type_token_id
		i32 184; uint32_t java_map_index
	}, ; 0
	%struct.TypeMapModuleEntry {
		i32 u0x0200034f, ; uint32_t type_token_id
		i32 698; uint32_t java_map_index
	}, ; 1
	%struct.TypeMapModuleEntry {
		i32 u0x02000350, ; uint32_t type_token_id
		i32 1156; uint32_t java_map_index
	}, ; 2
	%struct.TypeMapModuleEntry {
		i32 u0x02000361, ; uint32_t type_token_id
		i32 1116; uint32_t java_map_index
	}, ; 3
	%struct.TypeMapModuleEntry {
		i32 u0x02000362, ; uint32_t type_token_id
		i32 910; uint32_t java_map_index
	}, ; 4
	%struct.TypeMapModuleEntry {
		i32 u0x02000363, ; uint32_t type_token_id
		i32 774; uint32_t java_map_index
	}, ; 5
	%struct.TypeMapModuleEntry {
		i32 u0x02000364, ; uint32_t type_token_id
		i32 570; uint32_t java_map_index
	}, ; 6
	%struct.TypeMapModuleEntry {
		i32 u0x02000365, ; uint32_t type_token_id
		i32 358; uint32_t java_map_index
	}, ; 7
	%struct.TypeMapModuleEntry {
		i32 u0x02000368, ; uint32_t type_token_id
		i32 1260; uint32_t java_map_index
	}, ; 8
	%struct.TypeMapModuleEntry {
		i32 u0x02000369, ; uint32_t type_token_id
		i32 1089; uint32_t java_map_index
	}, ; 9
	%struct.TypeMapModuleEntry {
		i32 u0x0200036b, ; uint32_t type_token_id
		i32 730; uint32_t java_map_index
	}, ; 10
	%struct.TypeMapModuleEntry {
		i32 u0x0200036c, ; uint32_t type_token_id
		i32 293; uint32_t java_map_index
	}, ; 11
	%struct.TypeMapModuleEntry {
		i32 u0x0200036f, ; uint32_t type_token_id
		i32 282; uint32_t java_map_index
	}, ; 12
	%struct.TypeMapModuleEntry {
		i32 u0x02000372, ; uint32_t type_token_id
		i32 423; uint32_t java_map_index
	}, ; 13
	%struct.TypeMapModuleEntry {
		i32 u0x02000380, ; uint32_t type_token_id
		i32 39; uint32_t java_map_index
	}, ; 14
	%struct.TypeMapModuleEntry {
		i32 u0x02000381, ; uint32_t type_token_id
		i32 271; uint32_t java_map_index
	}, ; 15
	%struct.TypeMapModuleEntry {
		i32 u0x0200038f, ; uint32_t type_token_id
		i32 291; uint32_t java_map_index
	}, ; 16
	%struct.TypeMapModuleEntry {
		i32 u0x02000391, ; uint32_t type_token_id
		i32 209; uint32_t java_map_index
	}, ; 17
	%struct.TypeMapModuleEntry {
		i32 u0x02000392, ; uint32_t type_token_id
		i32 461; uint32_t java_map_index
	}, ; 18
	%struct.TypeMapModuleEntry {
		i32 u0x02000393, ; uint32_t type_token_id
		i32 142; uint32_t java_map_index
	}, ; 19
	%struct.TypeMapModuleEntry {
		i32 u0x02000394, ; uint32_t type_token_id
		i32 807; uint32_t java_map_index
	}, ; 20
	%struct.TypeMapModuleEntry {
		i32 u0x02000395, ; uint32_t type_token_id
		i32 535; uint32_t java_map_index
	}, ; 21
	%struct.TypeMapModuleEntry {
		i32 u0x02000396, ; uint32_t type_token_id
		i32 834; uint32_t java_map_index
	}, ; 22
	%struct.TypeMapModuleEntry {
		i32 u0x02000397, ; uint32_t type_token_id
		i32 582; uint32_t java_map_index
	}, ; 23
	%struct.TypeMapModuleEntry {
		i32 u0x02000398, ; uint32_t type_token_id
		i32 673; uint32_t java_map_index
	}, ; 24
	%struct.TypeMapModuleEntry {
		i32 u0x02000399, ; uint32_t type_token_id
		i32 1067; uint32_t java_map_index
	}, ; 25
	%struct.TypeMapModuleEntry {
		i32 u0x0200039a, ; uint32_t type_token_id
		i32 982; uint32_t java_map_index
	}, ; 26
	%struct.TypeMapModuleEntry {
		i32 u0x0200039b, ; uint32_t type_token_id
		i32 1272; uint32_t java_map_index
	}, ; 27
	%struct.TypeMapModuleEntry {
		i32 u0x0200039c, ; uint32_t type_token_id
		i32 12; uint32_t java_map_index
	}, ; 28
	%struct.TypeMapModuleEntry {
		i32 u0x0200039d, ; uint32_t type_token_id
		i32 1125; uint32_t java_map_index
	}, ; 29
	%struct.TypeMapModuleEntry {
		i32 u0x0200039e, ; uint32_t type_token_id
		i32 666; uint32_t java_map_index
	}, ; 30
	%struct.TypeMapModuleEntry {
		i32 u0x020003a1, ; uint32_t type_token_id
		i32 993; uint32_t java_map_index
	}, ; 31
	%struct.TypeMapModuleEntry {
		i32 u0x020003ab, ; uint32_t type_token_id
		i32 711; uint32_t java_map_index
	}, ; 32
	%struct.TypeMapModuleEntry {
		i32 u0x020003ac, ; uint32_t type_token_id
		i32 198; uint32_t java_map_index
	}, ; 33
	%struct.TypeMapModuleEntry {
		i32 u0x020003ad, ; uint32_t type_token_id
		i32 838; uint32_t java_map_index
	}, ; 34
	%struct.TypeMapModuleEntry {
		i32 u0x020003ae, ; uint32_t type_token_id
		i32 168; uint32_t java_map_index
	}, ; 35
	%struct.TypeMapModuleEntry {
		i32 u0x020003af, ; uint32_t type_token_id
		i32 762; uint32_t java_map_index
	}, ; 36
	%struct.TypeMapModuleEntry {
		i32 u0x020003b0, ; uint32_t type_token_id
		i32 92; uint32_t java_map_index
	}, ; 37
	%struct.TypeMapModuleEntry {
		i32 u0x020003b1, ; uint32_t type_token_id
		i32 1206; uint32_t java_map_index
	}, ; 38
	%struct.TypeMapModuleEntry {
		i32 u0x020003b2, ; uint32_t type_token_id
		i32 1059; uint32_t java_map_index
	}, ; 39
	%struct.TypeMapModuleEntry {
		i32 u0x020003b4, ; uint32_t type_token_id
		i32 826; uint32_t java_map_index
	}, ; 40
	%struct.TypeMapModuleEntry {
		i32 u0x020003b5, ; uint32_t type_token_id
		i32 1241; uint32_t java_map_index
	}, ; 41
	%struct.TypeMapModuleEntry {
		i32 u0x020003b6, ; uint32_t type_token_id
		i32 707; uint32_t java_map_index
	}, ; 42
	%struct.TypeMapModuleEntry {
		i32 u0x020003ba, ; uint32_t type_token_id
		i32 608; uint32_t java_map_index
	}, ; 43
	%struct.TypeMapModuleEntry {
		i32 u0x020003c6, ; uint32_t type_token_id
		i32 169; uint32_t java_map_index
	}, ; 44
	%struct.TypeMapModuleEntry {
		i32 u0x020003c7, ; uint32_t type_token_id
		i32 422; uint32_t java_map_index
	}, ; 45
	%struct.TypeMapModuleEntry {
		i32 u0x020003c8, ; uint32_t type_token_id
		i32 1069; uint32_t java_map_index
	}, ; 46
	%struct.TypeMapModuleEntry {
		i32 u0x020003ca, ; uint32_t type_token_id
		i32 1233; uint32_t java_map_index
	}, ; 47
	%struct.TypeMapModuleEntry {
		i32 u0x020003cb, ; uint32_t type_token_id
		i32 367; uint32_t java_map_index
	}, ; 48
	%struct.TypeMapModuleEntry {
		i32 u0x020003cc, ; uint32_t type_token_id
		i32 1184; uint32_t java_map_index
	}, ; 49
	%struct.TypeMapModuleEntry {
		i32 u0x020003cd, ; uint32_t type_token_id
		i32 60; uint32_t java_map_index
	}, ; 50
	%struct.TypeMapModuleEntry {
		i32 u0x020003ce, ; uint32_t type_token_id
		i32 11; uint32_t java_map_index
	}, ; 51
	%struct.TypeMapModuleEntry {
		i32 u0x020003cf, ; uint32_t type_token_id
		i32 1198; uint32_t java_map_index
	}, ; 52
	%struct.TypeMapModuleEntry {
		i32 u0x020003d0, ; uint32_t type_token_id
		i32 541; uint32_t java_map_index
	}, ; 53
	%struct.TypeMapModuleEntry {
		i32 u0x020003d1, ; uint32_t type_token_id
		i32 116; uint32_t java_map_index
	}, ; 54
	%struct.TypeMapModuleEntry {
		i32 u0x020003d2, ; uint32_t type_token_id
		i32 175; uint32_t java_map_index
	}, ; 55
	%struct.TypeMapModuleEntry {
		i32 u0x020003d3, ; uint32_t type_token_id
		i32 1209; uint32_t java_map_index
	}, ; 56
	%struct.TypeMapModuleEntry {
		i32 u0x020003d4, ; uint32_t type_token_id
		i32 1078; uint32_t java_map_index
	}, ; 57
	%struct.TypeMapModuleEntry {
		i32 u0x020003d5, ; uint32_t type_token_id
		i32 227; uint32_t java_map_index
	}, ; 58
	%struct.TypeMapModuleEntry {
		i32 u0x020003d7, ; uint32_t type_token_id
		i32 741; uint32_t java_map_index
	}, ; 59
	%struct.TypeMapModuleEntry {
		i32 u0x020003d8, ; uint32_t type_token_id
		i32 634; uint32_t java_map_index
	}, ; 60
	%struct.TypeMapModuleEntry {
		i32 u0x020003d9, ; uint32_t type_token_id
		i32 224; uint32_t java_map_index
	}, ; 61
	%struct.TypeMapModuleEntry {
		i32 u0x020003da, ; uint32_t type_token_id
		i32 1005; uint32_t java_map_index
	}, ; 62
	%struct.TypeMapModuleEntry {
		i32 u0x020003dc, ; uint32_t type_token_id
		i32 253; uint32_t java_map_index
	}, ; 63
	%struct.TypeMapModuleEntry {
		i32 u0x020003e4, ; uint32_t type_token_id
		i32 909; uint32_t java_map_index
	}, ; 64
	%struct.TypeMapModuleEntry {
		i32 u0x020003e5, ; uint32_t type_token_id
		i32 1066; uint32_t java_map_index
	}, ; 65
	%struct.TypeMapModuleEntry {
		i32 u0x020003e6, ; uint32_t type_token_id
		i32 675; uint32_t java_map_index
	}, ; 66
	%struct.TypeMapModuleEntry {
		i32 u0x020003e7, ; uint32_t type_token_id
		i32 619; uint32_t java_map_index
	}, ; 67
	%struct.TypeMapModuleEntry {
		i32 u0x020003e8, ; uint32_t type_token_id
		i32 182; uint32_t java_map_index
	}, ; 68
	%struct.TypeMapModuleEntry {
		i32 u0x020003e9, ; uint32_t type_token_id
		i32 294; uint32_t java_map_index
	}, ; 69
	%struct.TypeMapModuleEntry {
		i32 u0x020003ec, ; uint32_t type_token_id
		i32 504; uint32_t java_map_index
	}, ; 70
	%struct.TypeMapModuleEntry {
		i32 u0x020003ed, ; uint32_t type_token_id
		i32 213; uint32_t java_map_index
	}, ; 71
	%struct.TypeMapModuleEntry {
		i32 u0x020003ef, ; uint32_t type_token_id
		i32 101; uint32_t java_map_index
	}, ; 72
	%struct.TypeMapModuleEntry {
		i32 u0x020003f0, ; uint32_t type_token_id
		i32 1268; uint32_t java_map_index
	}, ; 73
	%struct.TypeMapModuleEntry {
		i32 u0x020003f2, ; uint32_t type_token_id
		i32 44; uint32_t java_map_index
	}, ; 74
	%struct.TypeMapModuleEntry {
		i32 u0x020003f3, ; uint32_t type_token_id
		i32 503; uint32_t java_map_index
	}, ; 75
	%struct.TypeMapModuleEntry {
		i32 u0x020003f5, ; uint32_t type_token_id
		i32 1183; uint32_t java_map_index
	}, ; 76
	%struct.TypeMapModuleEntry {
		i32 u0x020003f9, ; uint32_t type_token_id
		i32 129; uint32_t java_map_index
	}, ; 77
	%struct.TypeMapModuleEntry {
		i32 u0x020003fa, ; uint32_t type_token_id
		i32 819; uint32_t java_map_index
	}, ; 78
	%struct.TypeMapModuleEntry {
		i32 u0x02000496, ; uint32_t type_token_id
		i32 215; uint32_t java_map_index
	}, ; 79
	%struct.TypeMapModuleEntry {
		i32 u0x0200055a, ; uint32_t type_token_id
		i32 124; uint32_t java_map_index
	}, ; 80
	%struct.TypeMapModuleEntry {
		i32 u0x020005e8, ; uint32_t type_token_id
		i32 445; uint32_t java_map_index
	}, ; 81
	%struct.TypeMapModuleEntry {
		i32 u0x020005ee, ; uint32_t type_token_id
		i32 916; uint32_t java_map_index
	}, ; 82
	%struct.TypeMapModuleEntry {
		i32 u0x020005f9, ; uint32_t type_token_id
		i32 609; uint32_t java_map_index
	}, ; 83
	%struct.TypeMapModuleEntry {
		i32 u0x02000604, ; uint32_t type_token_id
		i32 603; uint32_t java_map_index
	}, ; 84
	%struct.TypeMapModuleEntry {
		i32 u0x02000606, ; uint32_t type_token_id
		i32 586; uint32_t java_map_index
	}, ; 85
	%struct.TypeMapModuleEntry {
		i32 u0x02000607, ; uint32_t type_token_id
		i32 697; uint32_t java_map_index
	}, ; 86
	%struct.TypeMapModuleEntry {
		i32 u0x0200060e, ; uint32_t type_token_id
		i32 1055; uint32_t java_map_index
	}, ; 87
	%struct.TypeMapModuleEntry {
		i32 u0x02000611, ; uint32_t type_token_id
		i32 1029; uint32_t java_map_index
	}, ; 88
	%struct.TypeMapModuleEntry {
		i32 u0x02000612, ; uint32_t type_token_id
		i32 792; uint32_t java_map_index
	}, ; 89
	%struct.TypeMapModuleEntry {
		i32 u0x02000613, ; uint32_t type_token_id
		i32 994; uint32_t java_map_index
	}, ; 90
	%struct.TypeMapModuleEntry {
		i32 u0x02000616, ; uint32_t type_token_id
		i32 1267; uint32_t java_map_index
	}, ; 91
	%struct.TypeMapModuleEntry {
		i32 u0x0200061a, ; uint32_t type_token_id
		i32 288; uint32_t java_map_index
	}, ; 92
	%struct.TypeMapModuleEntry {
		i32 u0x0200061b, ; uint32_t type_token_id
		i32 574; uint32_t java_map_index
	}, ; 93
	%struct.TypeMapModuleEntry {
		i32 u0x02000624, ; uint32_t type_token_id
		i32 539; uint32_t java_map_index
	}, ; 94
	%struct.TypeMapModuleEntry {
		i32 u0x02000627, ; uint32_t type_token_id
		i32 542; uint32_t java_map_index
	}, ; 95
	%struct.TypeMapModuleEntry {
		i32 u0x0200062a, ; uint32_t type_token_id
		i32 1105; uint32_t java_map_index
	}, ; 96
	%struct.TypeMapModuleEntry {
		i32 u0x02000630, ; uint32_t type_token_id
		i32 949; uint32_t java_map_index
	}, ; 97
	%struct.TypeMapModuleEntry {
		i32 u0x02000631, ; uint32_t type_token_id
		i32 78; uint32_t java_map_index
	}, ; 98
	%struct.TypeMapModuleEntry {
		i32 u0x02000632, ; uint32_t type_token_id
		i32 130; uint32_t java_map_index
	}, ; 99
	%struct.TypeMapModuleEntry {
		i32 u0x02000633, ; uint32_t type_token_id
		i32 554; uint32_t java_map_index
	}, ; 100
	%struct.TypeMapModuleEntry {
		i32 u0x02000635, ; uint32_t type_token_id
		i32 307; uint32_t java_map_index
	}, ; 101
	%struct.TypeMapModuleEntry {
		i32 u0x02000636, ; uint32_t type_token_id
		i32 987; uint32_t java_map_index
	}, ; 102
	%struct.TypeMapModuleEntry {
		i32 u0x02000699, ; uint32_t type_token_id
		i32 454; uint32_t java_map_index
	}, ; 103
	%struct.TypeMapModuleEntry {
		i32 u0x0200069b, ; uint32_t type_token_id
		i32 308; uint32_t java_map_index
	}, ; 104
	%struct.TypeMapModuleEntry {
		i32 u0x0200069c, ; uint32_t type_token_id
		i32 172; uint32_t java_map_index
	}, ; 105
	%struct.TypeMapModuleEntry {
		i32 u0x020006a4, ; uint32_t type_token_id
		i32 917; uint32_t java_map_index
	} ; 106
], align 4

@module35_managed_to_java = internal dso_local constant [30 x %struct.TypeMapModuleEntry] [
	%struct.TypeMapModuleEntry {
		i32 u0x02000035, ; uint32_t type_token_id
		i32 223; uint32_t java_map_index
	}, ; 0
	%struct.TypeMapModuleEntry {
		i32 u0x02000036, ; uint32_t type_token_id
		i32 400; uint32_t java_map_index
	}, ; 1
	%struct.TypeMapModuleEntry {
		i32 u0x02000038, ; uint32_t type_token_id
		i32 693; uint32_t java_map_index
	}, ; 2
	%struct.TypeMapModuleEntry {
		i32 u0x0200003a, ; uint32_t type_token_id
		i32 1057; uint32_t java_map_index
	}, ; 3
	%struct.TypeMapModuleEntry {
		i32 u0x0200003c, ; uint32_t type_token_id
		i32 328; uint32_t java_map_index
	}, ; 4
	%struct.TypeMapModuleEntry {
		i32 u0x0200003e, ; uint32_t type_token_id
		i32 971; uint32_t java_map_index
	}, ; 5
	%struct.TypeMapModuleEntry {
		i32 u0x02000040, ; uint32_t type_token_id
		i32 587; uint32_t java_map_index
	}, ; 6
	%struct.TypeMapModuleEntry {
		i32 u0x02000042, ; uint32_t type_token_id
		i32 438; uint32_t java_map_index
	}, ; 7
	%struct.TypeMapModuleEntry {
		i32 u0x02000044, ; uint32_t type_token_id
		i32 458; uint32_t java_map_index
	}, ; 8
	%struct.TypeMapModuleEntry {
		i32 u0x02000046, ; uint32_t type_token_id
		i32 329; uint32_t java_map_index
	}, ; 9
	%struct.TypeMapModuleEntry {
		i32 u0x02000048, ; uint32_t type_token_id
		i32 558; uint32_t java_map_index
	}, ; 10
	%struct.TypeMapModuleEntry {
		i32 u0x0200004a, ; uint32_t type_token_id
		i32 779; uint32_t java_map_index
	}, ; 11
	%struct.TypeMapModuleEntry {
		i32 u0x0200004b, ; uint32_t type_token_id
		i32 509; uint32_t java_map_index
	}, ; 12
	%struct.TypeMapModuleEntry {
		i32 u0x0200004d, ; uint32_t type_token_id
		i32 936; uint32_t java_map_index
	}, ; 13
	%struct.TypeMapModuleEntry {
		i32 u0x0200004f, ; uint32_t type_token_id
		i32 225; uint32_t java_map_index
	}, ; 14
	%struct.TypeMapModuleEntry {
		i32 u0x02000051, ; uint32_t type_token_id
		i32 1074; uint32_t java_map_index
	}, ; 15
	%struct.TypeMapModuleEntry {
		i32 u0x02000053, ; uint32_t type_token_id
		i32 429; uint32_t java_map_index
	}, ; 16
	%struct.TypeMapModuleEntry {
		i32 u0x02000054, ; uint32_t type_token_id
		i32 719; uint32_t java_map_index
	}, ; 17
	%struct.TypeMapModuleEntry {
		i32 u0x02000055, ; uint32_t type_token_id
		i32 334; uint32_t java_map_index
	}, ; 18
	%struct.TypeMapModuleEntry {
		i32 u0x02000056, ; uint32_t type_token_id
		i32 517; uint32_t java_map_index
	}, ; 19
	%struct.TypeMapModuleEntry {
		i32 u0x02000058, ; uint32_t type_token_id
		i32 1155; uint32_t java_map_index
	}, ; 20
	%struct.TypeMapModuleEntry {
		i32 u0x0200005a, ; uint32_t type_token_id
		i32 1200; uint32_t java_map_index
	}, ; 21
	%struct.TypeMapModuleEntry {
		i32 u0x0200005c, ; uint32_t type_token_id
		i32 939; uint32_t java_map_index
	}, ; 22
	%struct.TypeMapModuleEntry {
		i32 u0x0200005e, ; uint32_t type_token_id
		i32 186; uint32_t java_map_index
	}, ; 23
	%struct.TypeMapModuleEntry {
		i32 u0x0200005f, ; uint32_t type_token_id
		i32 274; uint32_t java_map_index
	}, ; 24
	%struct.TypeMapModuleEntry {
		i32 u0x02000061, ; uint32_t type_token_id
		i32 465; uint32_t java_map_index
	}, ; 25
	%struct.TypeMapModuleEntry {
		i32 u0x02000062, ; uint32_t type_token_id
		i32 522; uint32_t java_map_index
	}, ; 26
	%struct.TypeMapModuleEntry {
		i32 u0x02000063, ; uint32_t type_token_id
		i32 480; uint32_t java_map_index
	}, ; 27
	%struct.TypeMapModuleEntry {
		i32 u0x02000064, ; uint32_t type_token_id
		i32 709; uint32_t java_map_index
	}, ; 28
	%struct.TypeMapModuleEntry {
		i32 u0x02000065, ; uint32_t type_token_id
		i32 1196; uint32_t java_map_index
	} ; 29
], align 4

@module35_managed_to_java_duplicates = internal dso_local constant [19 x %struct.TypeMapModuleEntry] [
	%struct.TypeMapModuleEntry {
		i32 u0x02000037, ; uint32_t type_token_id
		i32 400; uint32_t java_map_index
	}, ; 0
	%struct.TypeMapModuleEntry {
		i32 u0x02000039, ; uint32_t type_token_id
		i32 693; uint32_t java_map_index
	}, ; 1
	%struct.TypeMapModuleEntry {
		i32 u0x0200003b, ; uint32_t type_token_id
		i32 1057; uint32_t java_map_index
	}, ; 2
	%struct.TypeMapModuleEntry {
		i32 u0x0200003d, ; uint32_t type_token_id
		i32 328; uint32_t java_map_index
	}, ; 3
	%struct.TypeMapModuleEntry {
		i32 u0x0200003f, ; uint32_t type_token_id
		i32 971; uint32_t java_map_index
	}, ; 4
	%struct.TypeMapModuleEntry {
		i32 u0x02000041, ; uint32_t type_token_id
		i32 587; uint32_t java_map_index
	}, ; 5
	%struct.TypeMapModuleEntry {
		i32 u0x02000043, ; uint32_t type_token_id
		i32 438; uint32_t java_map_index
	}, ; 6
	%struct.TypeMapModuleEntry {
		i32 u0x02000045, ; uint32_t type_token_id
		i32 458; uint32_t java_map_index
	}, ; 7
	%struct.TypeMapModuleEntry {
		i32 u0x02000047, ; uint32_t type_token_id
		i32 329; uint32_t java_map_index
	}, ; 8
	%struct.TypeMapModuleEntry {
		i32 u0x02000049, ; uint32_t type_token_id
		i32 558; uint32_t java_map_index
	}, ; 9
	%struct.TypeMapModuleEntry {
		i32 u0x0200004c, ; uint32_t type_token_id
		i32 779; uint32_t java_map_index
	}, ; 10
	%struct.TypeMapModuleEntry {
		i32 u0x0200004e, ; uint32_t type_token_id
		i32 936; uint32_t java_map_index
	}, ; 11
	%struct.TypeMapModuleEntry {
		i32 u0x02000050, ; uint32_t type_token_id
		i32 225; uint32_t java_map_index
	}, ; 12
	%struct.TypeMapModuleEntry {
		i32 u0x02000052, ; uint32_t type_token_id
		i32 1074; uint32_t java_map_index
	}, ; 13
	%struct.TypeMapModuleEntry {
		i32 u0x02000057, ; uint32_t type_token_id
		i32 719; uint32_t java_map_index
	}, ; 14
	%struct.TypeMapModuleEntry {
		i32 u0x02000059, ; uint32_t type_token_id
		i32 1155; uint32_t java_map_index
	}, ; 15
	%struct.TypeMapModuleEntry {
		i32 u0x0200005b, ; uint32_t type_token_id
		i32 1200; uint32_t java_map_index
	}, ; 16
	%struct.TypeMapModuleEntry {
		i32 u0x0200005d, ; uint32_t type_token_id
		i32 939; uint32_t java_map_index
	}, ; 17
	%struct.TypeMapModuleEntry {
		i32 u0x02000060, ; uint32_t type_token_id
		i32 274; uint32_t java_map_index
	} ; 18
], align 4

@module36_managed_to_java = internal dso_local constant [580 x %struct.TypeMapModuleEntry] [
	%struct.TypeMapModuleEntry {
		i32 u0x020000b3, ; uint32_t type_token_id
		i32 890; uint32_t java_map_index
	}, ; 0
	%struct.TypeMapModuleEntry {
		i32 u0x020000b5, ; uint32_t type_token_id
		i32 488; uint32_t java_map_index
	}, ; 1
	%struct.TypeMapModuleEntry {
		i32 u0x020000b7, ; uint32_t type_token_id
		i32 1255; uint32_t java_map_index
	}, ; 2
	%struct.TypeMapModuleEntry {
		i32 u0x020000b9, ; uint32_t type_token_id
		i32 206; uint32_t java_map_index
	}, ; 3
	%struct.TypeMapModuleEntry {
		i32 u0x020000bb, ; uint32_t type_token_id
		i32 620; uint32_t java_map_index
	}, ; 4
	%struct.TypeMapModuleEntry {
		i32 u0x020000bc, ; uint32_t type_token_id
		i32 162; uint32_t java_map_index
	}, ; 5
	%struct.TypeMapModuleEntry {
		i32 u0x020000be, ; uint32_t type_token_id
		i32 381; uint32_t java_map_index
	}, ; 6
	%struct.TypeMapModuleEntry {
		i32 u0x020000c0, ; uint32_t type_token_id
		i32 1178; uint32_t java_map_index
	}, ; 7
	%struct.TypeMapModuleEntry {
		i32 u0x020000c2, ; uint32_t type_token_id
		i32 679; uint32_t java_map_index
	}, ; 8
	%struct.TypeMapModuleEntry {
		i32 u0x020000c4, ; uint32_t type_token_id
		i32 817; uint32_t java_map_index
	}, ; 9
	%struct.TypeMapModuleEntry {
		i32 u0x020000c6, ; uint32_t type_token_id
		i32 1087; uint32_t java_map_index
	}, ; 10
	%struct.TypeMapModuleEntry {
		i32 u0x020000c8, ; uint32_t type_token_id
		i32 920; uint32_t java_map_index
	}, ; 11
	%struct.TypeMapModuleEntry {
		i32 u0x020000ca, ; uint32_t type_token_id
		i32 5; uint32_t java_map_index
	}, ; 12
	%struct.TypeMapModuleEntry {
		i32 u0x020000cb, ; uint32_t type_token_id
		i32 18; uint32_t java_map_index
	}, ; 13
	%struct.TypeMapModuleEntry {
		i32 u0x020000cc, ; uint32_t type_token_id
		i32 844; uint32_t java_map_index
	}, ; 14
	%struct.TypeMapModuleEntry {
		i32 u0x020000ce, ; uint32_t type_token_id
		i32 108; uint32_t java_map_index
	}, ; 15
	%struct.TypeMapModuleEntry {
		i32 u0x020000cf, ; uint32_t type_token_id
		i32 1041; uint32_t java_map_index
	}, ; 16
	%struct.TypeMapModuleEntry {
		i32 u0x020000d0, ; uint32_t type_token_id
		i32 1043; uint32_t java_map_index
	}, ; 17
	%struct.TypeMapModuleEntry {
		i32 u0x020000d1, ; uint32_t type_token_id
		i32 1114; uint32_t java_map_index
	}, ; 18
	%struct.TypeMapModuleEntry {
		i32 u0x020000d3, ; uint32_t type_token_id
		i32 1025; uint32_t java_map_index
	}, ; 19
	%struct.TypeMapModuleEntry {
		i32 u0x020000d4, ; uint32_t type_token_id
		i32 173; uint32_t java_map_index
	}, ; 20
	%struct.TypeMapModuleEntry {
		i32 u0x020000d5, ; uint32_t type_token_id
		i32 898; uint32_t java_map_index
	}, ; 21
	%struct.TypeMapModuleEntry {
		i32 u0x020000d7, ; uint32_t type_token_id
		i32 1111; uint32_t java_map_index
	}, ; 22
	%struct.TypeMapModuleEntry {
		i32 u0x020000d9, ; uint32_t type_token_id
		i32 545; uint32_t java_map_index
	}, ; 23
	%struct.TypeMapModuleEntry {
		i32 u0x020000db, ; uint32_t type_token_id
		i32 189; uint32_t java_map_index
	}, ; 24
	%struct.TypeMapModuleEntry {
		i32 u0x020000dd, ; uint32_t type_token_id
		i32 596; uint32_t java_map_index
	}, ; 25
	%struct.TypeMapModuleEntry {
		i32 u0x020000df, ; uint32_t type_token_id
		i32 397; uint32_t java_map_index
	}, ; 26
	%struct.TypeMapModuleEntry {
		i32 u0x020000e2, ; uint32_t type_token_id
		i32 135; uint32_t java_map_index
	}, ; 27
	%struct.TypeMapModuleEntry {
		i32 u0x020000e4, ; uint32_t type_token_id
		i32 1098; uint32_t java_map_index
	}, ; 28
	%struct.TypeMapModuleEntry {
		i32 u0x020000e6, ; uint32_t type_token_id
		i32 177; uint32_t java_map_index
	}, ; 29
	%struct.TypeMapModuleEntry {
		i32 u0x020000e7, ; uint32_t type_token_id
		i32 373; uint32_t java_map_index
	}, ; 30
	%struct.TypeMapModuleEntry {
		i32 u0x020000e9, ; uint32_t type_token_id
		i32 187; uint32_t java_map_index
	}, ; 31
	%struct.TypeMapModuleEntry {
		i32 u0x020000ea, ; uint32_t type_token_id
		i32 928; uint32_t java_map_index
	}, ; 32
	%struct.TypeMapModuleEntry {
		i32 u0x020000ec, ; uint32_t type_token_id
		i32 299; uint32_t java_map_index
	}, ; 33
	%struct.TypeMapModuleEntry {
		i32 u0x020000ed, ; uint32_t type_token_id
		i32 1031; uint32_t java_map_index
	}, ; 34
	%struct.TypeMapModuleEntry {
		i32 u0x020000ef, ; uint32_t type_token_id
		i32 607; uint32_t java_map_index
	}, ; 35
	%struct.TypeMapModuleEntry {
		i32 u0x020000f0, ; uint32_t type_token_id
		i32 881; uint32_t java_map_index
	}, ; 36
	%struct.TypeMapModuleEntry {
		i32 u0x020000f1, ; uint32_t type_token_id
		i32 414; uint32_t java_map_index
	}, ; 37
	%struct.TypeMapModuleEntry {
		i32 u0x020000f2, ; uint32_t type_token_id
		i32 48; uint32_t java_map_index
	}, ; 38
	%struct.TypeMapModuleEntry {
		i32 u0x020000f4, ; uint32_t type_token_id
		i32 724; uint32_t java_map_index
	}, ; 39
	%struct.TypeMapModuleEntry {
		i32 u0x020000f5, ; uint32_t type_token_id
		i32 781; uint32_t java_map_index
	}, ; 40
	%struct.TypeMapModuleEntry {
		i32 u0x020000f6, ; uint32_t type_token_id
		i32 624; uint32_t java_map_index
	}, ; 41
	%struct.TypeMapModuleEntry {
		i32 u0x020000f7, ; uint32_t type_token_id
		i32 1193; uint32_t java_map_index
	}, ; 42
	%struct.TypeMapModuleEntry {
		i32 u0x020000f8, ; uint32_t type_token_id
		i32 464; uint32_t java_map_index
	}, ; 43
	%struct.TypeMapModuleEntry {
		i32 u0x020000fa, ; uint32_t type_token_id
		i32 859; uint32_t java_map_index
	}, ; 44
	%struct.TypeMapModuleEntry {
		i32 u0x020000fb, ; uint32_t type_token_id
		i32 1213; uint32_t java_map_index
	}, ; 45
	%struct.TypeMapModuleEntry {
		i32 u0x020000fc, ; uint32_t type_token_id
		i32 1168; uint32_t java_map_index
	}, ; 46
	%struct.TypeMapModuleEntry {
		i32 u0x020000fe, ; uint32_t type_token_id
		i32 201; uint32_t java_map_index
	}, ; 47
	%struct.TypeMapModuleEntry {
		i32 u0x020000ff, ; uint32_t type_token_id
		i32 1212; uint32_t java_map_index
	}, ; 48
	%struct.TypeMapModuleEntry {
		i32 u0x02000100, ; uint32_t type_token_id
		i32 922; uint32_t java_map_index
	}, ; 49
	%struct.TypeMapModuleEntry {
		i32 u0x02000101, ; uint32_t type_token_id
		i32 702; uint32_t java_map_index
	}, ; 50
	%struct.TypeMapModuleEntry {
		i32 u0x02000102, ; uint32_t type_token_id
		i32 549; uint32_t java_map_index
	}, ; 51
	%struct.TypeMapModuleEntry {
		i32 u0x02000103, ; uint32_t type_token_id
		i32 13; uint32_t java_map_index
	}, ; 52
	%struct.TypeMapModuleEntry {
		i32 u0x02000104, ; uint32_t type_token_id
		i32 1128; uint32_t java_map_index
	}, ; 53
	%struct.TypeMapModuleEntry {
		i32 u0x02000105, ; uint32_t type_token_id
		i32 945; uint32_t java_map_index
	}, ; 54
	%struct.TypeMapModuleEntry {
		i32 u0x02000106, ; uint32_t type_token_id
		i32 845; uint32_t java_map_index
	}, ; 55
	%struct.TypeMapModuleEntry {
		i32 u0x02000107, ; uint32_t type_token_id
		i32 820; uint32_t java_map_index
	}, ; 56
	%struct.TypeMapModuleEntry {
		i32 u0x02000108, ; uint32_t type_token_id
		i32 1201; uint32_t java_map_index
	}, ; 57
	%struct.TypeMapModuleEntry {
		i32 u0x02000109, ; uint32_t type_token_id
		i32 1131; uint32_t java_map_index
	}, ; 58
	%struct.TypeMapModuleEntry {
		i32 u0x0200010a, ; uint32_t type_token_id
		i32 222; uint32_t java_map_index
	}, ; 59
	%struct.TypeMapModuleEntry {
		i32 u0x0200010c, ; uint32_t type_token_id
		i32 319; uint32_t java_map_index
	}, ; 60
	%struct.TypeMapModuleEntry {
		i32 u0x0200010f, ; uint32_t type_token_id
		i32 973; uint32_t java_map_index
	}, ; 61
	%struct.TypeMapModuleEntry {
		i32 u0x02000111, ; uint32_t type_token_id
		i32 900; uint32_t java_map_index
	}, ; 62
	%struct.TypeMapModuleEntry {
		i32 u0x02000112, ; uint32_t type_token_id
		i32 0; uint32_t java_map_index
	}, ; 63
	%struct.TypeMapModuleEntry {
		i32 u0x02000116, ; uint32_t type_token_id
		i32 211; uint32_t java_map_index
	}, ; 64
	%struct.TypeMapModuleEntry {
		i32 u0x02000117, ; uint32_t type_token_id
		i32 1270; uint32_t java_map_index
	}, ; 65
	%struct.TypeMapModuleEntry {
		i32 u0x0200011a, ; uint32_t type_token_id
		i32 986; uint32_t java_map_index
	}, ; 66
	%struct.TypeMapModuleEntry {
		i32 u0x0200011b, ; uint32_t type_token_id
		i32 1132; uint32_t java_map_index
	}, ; 67
	%struct.TypeMapModuleEntry {
		i32 u0x0200011d, ; uint32_t type_token_id
		i32 585; uint32_t java_map_index
	}, ; 68
	%struct.TypeMapModuleEntry {
		i32 u0x02000120, ; uint32_t type_token_id
		i32 6; uint32_t java_map_index
	}, ; 69
	%struct.TypeMapModuleEntry {
		i32 u0x02000124, ; uint32_t type_token_id
		i32 485; uint32_t java_map_index
	}, ; 70
	%struct.TypeMapModuleEntry {
		i32 u0x02000125, ; uint32_t type_token_id
		i32 981; uint32_t java_map_index
	}, ; 71
	%struct.TypeMapModuleEntry {
		i32 u0x02000126, ; uint32_t type_token_id
		i32 434; uint32_t java_map_index
	}, ; 72
	%struct.TypeMapModuleEntry {
		i32 u0x02000127, ; uint32_t type_token_id
		i32 832; uint32_t java_map_index
	}, ; 73
	%struct.TypeMapModuleEntry {
		i32 u0x02000128, ; uint32_t type_token_id
		i32 1279; uint32_t java_map_index
	}, ; 74
	%struct.TypeMapModuleEntry {
		i32 u0x0200012b, ; uint32_t type_token_id
		i32 937; uint32_t java_map_index
	}, ; 75
	%struct.TypeMapModuleEntry {
		i32 u0x0200012f, ; uint32_t type_token_id
		i32 589; uint32_t java_map_index
	}, ; 76
	%struct.TypeMapModuleEntry {
		i32 u0x02000130, ; uint32_t type_token_id
		i32 218; uint32_t java_map_index
	}, ; 77
	%struct.TypeMapModuleEntry {
		i32 u0x02000135, ; uint32_t type_token_id
		i32 924; uint32_t java_map_index
	}, ; 78
	%struct.TypeMapModuleEntry {
		i32 u0x02000136, ; uint32_t type_token_id
		i32 388; uint32_t java_map_index
	}, ; 79
	%struct.TypeMapModuleEntry {
		i32 u0x02000138, ; uint32_t type_token_id
		i32 979; uint32_t java_map_index
	}, ; 80
	%struct.TypeMapModuleEntry {
		i32 u0x02000139, ; uint32_t type_token_id
		i32 1282; uint32_t java_map_index
	}, ; 81
	%struct.TypeMapModuleEntry {
		i32 u0x0200013c, ; uint32_t type_token_id
		i32 602; uint32_t java_map_index
	}, ; 82
	%struct.TypeMapModuleEntry {
		i32 u0x02000141, ; uint32_t type_token_id
		i32 1152; uint32_t java_map_index
	}, ; 83
	%struct.TypeMapModuleEntry {
		i32 u0x02000142, ; uint32_t type_token_id
		i32 200; uint32_t java_map_index
	}, ; 84
	%struct.TypeMapModuleEntry {
		i32 u0x02000143, ; uint32_t type_token_id
		i32 723; uint32_t java_map_index
	}, ; 85
	%struct.TypeMapModuleEntry {
		i32 u0x02000144, ; uint32_t type_token_id
		i32 1047; uint32_t java_map_index
	}, ; 86
	%struct.TypeMapModuleEntry {
		i32 u0x02000146, ; uint32_t type_token_id
		i32 55; uint32_t java_map_index
	}, ; 87
	%struct.TypeMapModuleEntry {
		i32 u0x02000147, ; uint32_t type_token_id
		i32 474; uint32_t java_map_index
	}, ; 88
	%struct.TypeMapModuleEntry {
		i32 u0x02000148, ; uint32_t type_token_id
		i32 1170; uint32_t java_map_index
	}, ; 89
	%struct.TypeMapModuleEntry {
		i32 u0x02000149, ; uint32_t type_token_id
		i32 46; uint32_t java_map_index
	}, ; 90
	%struct.TypeMapModuleEntry {
		i32 u0x0200014b, ; uint32_t type_token_id
		i32 1108; uint32_t java_map_index
	}, ; 91
	%struct.TypeMapModuleEntry {
		i32 u0x0200014d, ; uint32_t type_token_id
		i32 738; uint32_t java_map_index
	}, ; 92
	%struct.TypeMapModuleEntry {
		i32 u0x0200014f, ; uint32_t type_token_id
		i32 74; uint32_t java_map_index
	}, ; 93
	%struct.TypeMapModuleEntry {
		i32 u0x02000151, ; uint32_t type_token_id
		i32 687; uint32_t java_map_index
	}, ; 94
	%struct.TypeMapModuleEntry {
		i32 u0x02000152, ; uint32_t type_token_id
		i32 1126; uint32_t java_map_index
	}, ; 95
	%struct.TypeMapModuleEntry {
		i32 u0x02000153, ; uint32_t type_token_id
		i32 380; uint32_t java_map_index
	}, ; 96
	%struct.TypeMapModuleEntry {
		i32 u0x02000155, ; uint32_t type_token_id
		i32 772; uint32_t java_map_index
	}, ; 97
	%struct.TypeMapModuleEntry {
		i32 u0x02000157, ; uint32_t type_token_id
		i32 942; uint32_t java_map_index
	}, ; 98
	%struct.TypeMapModuleEntry {
		i32 u0x02000159, ; uint32_t type_token_id
		i32 1189; uint32_t java_map_index
	}, ; 99
	%struct.TypeMapModuleEntry {
		i32 u0x0200015a, ; uint32_t type_token_id
		i32 1274; uint32_t java_map_index
	}, ; 100
	%struct.TypeMapModuleEntry {
		i32 u0x0200015b, ; uint32_t type_token_id
		i32 191; uint32_t java_map_index
	}, ; 101
	%struct.TypeMapModuleEntry {
		i32 u0x0200015d, ; uint32_t type_token_id
		i32 1030; uint32_t java_map_index
	}, ; 102
	%struct.TypeMapModuleEntry {
		i32 u0x0200015e, ; uint32_t type_token_id
		i32 304; uint32_t java_map_index
	}, ; 103
	%struct.TypeMapModuleEntry {
		i32 u0x0200015f, ; uint32_t type_token_id
		i32 645; uint32_t java_map_index
	}, ; 104
	%struct.TypeMapModuleEntry {
		i32 u0x02000161, ; uint32_t type_token_id
		i32 296; uint32_t java_map_index
	}, ; 105
	%struct.TypeMapModuleEntry {
		i32 u0x02000167, ; uint32_t type_token_id
		i32 798; uint32_t java_map_index
	}, ; 106
	%struct.TypeMapModuleEntry {
		i32 u0x02000168, ; uint32_t type_token_id
		i32 808; uint32_t java_map_index
	}, ; 107
	%struct.TypeMapModuleEntry {
		i32 u0x02000169, ; uint32_t type_token_id
		i32 114; uint32_t java_map_index
	}, ; 108
	%struct.TypeMapModuleEntry {
		i32 u0x0200016b, ; uint32_t type_token_id
		i32 366; uint32_t java_map_index
	}, ; 109
	%struct.TypeMapModuleEntry {
		i32 u0x0200016c, ; uint32_t type_token_id
		i32 199; uint32_t java_map_index
	}, ; 110
	%struct.TypeMapModuleEntry {
		i32 u0x0200016d, ; uint32_t type_token_id
		i32 955; uint32_t java_map_index
	}, ; 111
	%struct.TypeMapModuleEntry {
		i32 u0x0200016e, ; uint32_t type_token_id
		i32 594; uint32_t java_map_index
	}, ; 112
	%struct.TypeMapModuleEntry {
		i32 u0x02000170, ; uint32_t type_token_id
		i32 1248; uint32_t java_map_index
	}, ; 113
	%struct.TypeMapModuleEntry {
		i32 u0x02000171, ; uint32_t type_token_id
		i32 927; uint32_t java_map_index
	}, ; 114
	%struct.TypeMapModuleEntry {
		i32 u0x02000172, ; uint32_t type_token_id
		i32 651; uint32_t java_map_index
	}, ; 115
	%struct.TypeMapModuleEntry {
		i32 u0x02000176, ; uint32_t type_token_id
		i32 1053; uint32_t java_map_index
	}, ; 116
	%struct.TypeMapModuleEntry {
		i32 u0x02000177, ; uint32_t type_token_id
		i32 146; uint32_t java_map_index
	}, ; 117
	%struct.TypeMapModuleEntry {
		i32 u0x02000179, ; uint32_t type_token_id
		i32 258; uint32_t java_map_index
	}, ; 118
	%struct.TypeMapModuleEntry {
		i32 u0x0200017a, ; uint32_t type_token_id
		i32 885; uint32_t java_map_index
	}, ; 119
	%struct.TypeMapModuleEntry {
		i32 u0x0200017b, ; uint32_t type_token_id
		i32 1118; uint32_t java_map_index
	}, ; 120
	%struct.TypeMapModuleEntry {
		i32 u0x0200017c, ; uint32_t type_token_id
		i32 626; uint32_t java_map_index
	}, ; 121
	%struct.TypeMapModuleEntry {
		i32 u0x0200017d, ; uint32_t type_token_id
		i32 657; uint32_t java_map_index
	}, ; 122
	%struct.TypeMapModuleEntry {
		i32 u0x02000180, ; uint32_t type_token_id
		i32 1218; uint32_t java_map_index
	}, ; 123
	%struct.TypeMapModuleEntry {
		i32 u0x02000183, ; uint32_t type_token_id
		i32 1224; uint32_t java_map_index
	}, ; 124
	%struct.TypeMapModuleEntry {
		i32 u0x02000184, ; uint32_t type_token_id
		i32 1207; uint32_t java_map_index
	}, ; 125
	%struct.TypeMapModuleEntry {
		i32 u0x02000187, ; uint32_t type_token_id
		i32 770; uint32_t java_map_index
	}, ; 126
	%struct.TypeMapModuleEntry {
		i32 u0x0200018a, ; uint32_t type_token_id
		i32 252; uint32_t java_map_index
	}, ; 127
	%struct.TypeMapModuleEntry {
		i32 u0x0200018b, ; uint32_t type_token_id
		i32 57; uint32_t java_map_index
	}, ; 128
	%struct.TypeMapModuleEntry {
		i32 u0x0200018d, ; uint32_t type_token_id
		i32 1127; uint32_t java_map_index
	}, ; 129
	%struct.TypeMapModuleEntry {
		i32 u0x02000190, ; uint32_t type_token_id
		i32 767; uint32_t java_map_index
	}, ; 130
	%struct.TypeMapModuleEntry {
		i32 u0x02000193, ; uint32_t type_token_id
		i32 705; uint32_t java_map_index
	}, ; 131
	%struct.TypeMapModuleEntry {
		i32 u0x02000196, ; uint32_t type_token_id
		i32 377; uint32_t java_map_index
	}, ; 132
	%struct.TypeMapModuleEntry {
		i32 u0x02000198, ; uint32_t type_token_id
		i32 839; uint32_t java_map_index
	}, ; 133
	%struct.TypeMapModuleEntry {
		i32 u0x0200019b, ; uint32_t type_token_id
		i32 621; uint32_t java_map_index
	}, ; 134
	%struct.TypeMapModuleEntry {
		i32 u0x0200019c, ; uint32_t type_token_id
		i32 494; uint32_t java_map_index
	}, ; 135
	%struct.TypeMapModuleEntry {
		i32 u0x0200019e, ; uint32_t type_token_id
		i32 926; uint32_t java_map_index
	}, ; 136
	%struct.TypeMapModuleEntry {
		i32 u0x020001a0, ; uint32_t type_token_id
		i32 350; uint32_t java_map_index
	}, ; 137
	%struct.TypeMapModuleEntry {
		i32 u0x020001a2, ; uint32_t type_token_id
		i32 71; uint32_t java_map_index
	}, ; 138
	%struct.TypeMapModuleEntry {
		i32 u0x020001a5, ; uint32_t type_token_id
		i32 317; uint32_t java_map_index
	}, ; 139
	%struct.TypeMapModuleEntry {
		i32 u0x020001a6, ; uint32_t type_token_id
		i32 286; uint32_t java_map_index
	}, ; 140
	%struct.TypeMapModuleEntry {
		i32 u0x020001a7, ; uint32_t type_token_id
		i32 216; uint32_t java_map_index
	}, ; 141
	%struct.TypeMapModuleEntry {
		i32 u0x020001a8, ; uint32_t type_token_id
		i32 523; uint32_t java_map_index
	}, ; 142
	%struct.TypeMapModuleEntry {
		i32 u0x020001a9, ; uint32_t type_token_id
		i32 903; uint32_t java_map_index
	}, ; 143
	%struct.TypeMapModuleEntry {
		i32 u0x020001aa, ; uint32_t type_token_id
		i32 1048; uint32_t java_map_index
	}, ; 144
	%struct.TypeMapModuleEntry {
		i32 u0x020001ab, ; uint32_t type_token_id
		i32 220; uint32_t java_map_index
	}, ; 145
	%struct.TypeMapModuleEntry {
		i32 u0x020001ac, ; uint32_t type_token_id
		i32 715; uint32_t java_map_index
	}, ; 146
	%struct.TypeMapModuleEntry {
		i32 u0x020001ad, ; uint32_t type_token_id
		i32 20; uint32_t java_map_index
	}, ; 147
	%struct.TypeMapModuleEntry {
		i32 u0x020001af, ; uint32_t type_token_id
		i32 650; uint32_t java_map_index
	}, ; 148
	%struct.TypeMapModuleEntry {
		i32 u0x020001b1, ; uint32_t type_token_id
		i32 1275; uint32_t java_map_index
	}, ; 149
	%struct.TypeMapModuleEntry {
		i32 u0x020001b2, ; uint32_t type_token_id
		i32 664; uint32_t java_map_index
	}, ; 150
	%struct.TypeMapModuleEntry {
		i32 u0x020001b4, ; uint32_t type_token_id
		i32 748; uint32_t java_map_index
	}, ; 151
	%struct.TypeMapModuleEntry {
		i32 u0x020001b6, ; uint32_t type_token_id
		i32 221; uint32_t java_map_index
	}, ; 152
	%struct.TypeMapModuleEntry {
		i32 u0x020001b8, ; uint32_t type_token_id
		i32 98; uint32_t java_map_index
	}, ; 153
	%struct.TypeMapModuleEntry {
		i32 u0x020001ba, ; uint32_t type_token_id
		i32 729; uint32_t java_map_index
	}, ; 154
	%struct.TypeMapModuleEntry {
		i32 u0x020001bb, ; uint32_t type_token_id
		i32 598; uint32_t java_map_index
	}, ; 155
	%struct.TypeMapModuleEntry {
		i32 u0x020001bc, ; uint32_t type_token_id
		i32 544; uint32_t java_map_index
	}, ; 156
	%struct.TypeMapModuleEntry {
		i32 u0x020001bd, ; uint32_t type_token_id
		i32 1238; uint32_t java_map_index
	}, ; 157
	%struct.TypeMapModuleEntry {
		i32 u0x020001be, ; uint32_t type_token_id
		i32 360; uint32_t java_map_index
	}, ; 158
	%struct.TypeMapModuleEntry {
		i32 u0x020001bf, ; uint32_t type_token_id
		i32 390; uint32_t java_map_index
	}, ; 159
	%struct.TypeMapModuleEntry {
		i32 u0x020001c0, ; uint32_t type_token_id
		i32 1122; uint32_t java_map_index
	}, ; 160
	%struct.TypeMapModuleEntry {
		i32 u0x020001c2, ; uint32_t type_token_id
		i32 281; uint32_t java_map_index
	}, ; 161
	%struct.TypeMapModuleEntry {
		i32 u0x020001c3, ; uint32_t type_token_id
		i32 266; uint32_t java_map_index
	}, ; 162
	%struct.TypeMapModuleEntry {
		i32 u0x020001c5, ; uint32_t type_token_id
		i32 139; uint32_t java_map_index
	}, ; 163
	%struct.TypeMapModuleEntry {
		i32 u0x020001c7, ; uint32_t type_token_id
		i32 302; uint32_t java_map_index
	}, ; 164
	%struct.TypeMapModuleEntry {
		i32 u0x020001c9, ; uint32_t type_token_id
		i32 606; uint32_t java_map_index
	}, ; 165
	%struct.TypeMapModuleEntry {
		i32 u0x020001ca, ; uint32_t type_token_id
		i32 36; uint32_t java_map_index
	}, ; 166
	%struct.TypeMapModuleEntry {
		i32 u0x020001cb, ; uint32_t type_token_id
		i32 526; uint32_t java_map_index
	}, ; 167
	%struct.TypeMapModuleEntry {
		i32 u0x020001cc, ; uint32_t type_token_id
		i32 1032; uint32_t java_map_index
	}, ; 168
	%struct.TypeMapModuleEntry {
		i32 u0x020001cd, ; uint32_t type_token_id
		i32 814; uint32_t java_map_index
	}, ; 169
	%struct.TypeMapModuleEntry {
		i32 u0x020001ce, ; uint32_t type_token_id
		i32 149; uint32_t java_map_index
	}, ; 170
	%struct.TypeMapModuleEntry {
		i32 u0x020001cf, ; uint32_t type_token_id
		i32 572; uint32_t java_map_index
	}, ; 171
	%struct.TypeMapModuleEntry {
		i32 u0x020001d0, ; uint32_t type_token_id
		i32 119; uint32_t java_map_index
	}, ; 172
	%struct.TypeMapModuleEntry {
		i32 u0x020001d1, ; uint32_t type_token_id
		i32 51; uint32_t java_map_index
	}, ; 173
	%struct.TypeMapModuleEntry {
		i32 u0x020001d2, ; uint32_t type_token_id
		i32 998; uint32_t java_map_index
	}, ; 174
	%struct.TypeMapModuleEntry {
		i32 u0x020001d3, ; uint32_t type_token_id
		i32 1046; uint32_t java_map_index
	}, ; 175
	%struct.TypeMapModuleEntry {
		i32 u0x020001d4, ; uint32_t type_token_id
		i32 411; uint32_t java_map_index
	}, ; 176
	%struct.TypeMapModuleEntry {
		i32 u0x020001d6, ; uint32_t type_token_id
		i32 425; uint32_t java_map_index
	}, ; 177
	%struct.TypeMapModuleEntry {
		i32 u0x020001d7, ; uint32_t type_token_id
		i32 42; uint32_t java_map_index
	}, ; 178
	%struct.TypeMapModuleEntry {
		i32 u0x020001d8, ; uint32_t type_token_id
		i32 433; uint32_t java_map_index
	}, ; 179
	%struct.TypeMapModuleEntry {
		i32 u0x020001d9, ; uint32_t type_token_id
		i32 1266; uint32_t java_map_index
	}, ; 180
	%struct.TypeMapModuleEntry {
		i32 u0x020001db, ; uint32_t type_token_id
		i32 365; uint32_t java_map_index
	}, ; 181
	%struct.TypeMapModuleEntry {
		i32 u0x020001dd, ; uint32_t type_token_id
		i32 154; uint32_t java_map_index
	}, ; 182
	%struct.TypeMapModuleEntry {
		i32 u0x020001df, ; uint32_t type_token_id
		i32 755; uint32_t java_map_index
	}, ; 183
	%struct.TypeMapModuleEntry {
		i32 u0x020001e1, ; uint32_t type_token_id
		i32 1101; uint32_t java_map_index
	}, ; 184
	%struct.TypeMapModuleEntry {
		i32 u0x020001e3, ; uint32_t type_token_id
		i32 145; uint32_t java_map_index
	}, ; 185
	%struct.TypeMapModuleEntry {
		i32 u0x020001e4, ; uint32_t type_token_id
		i32 925; uint32_t java_map_index
	}, ; 186
	%struct.TypeMapModuleEntry {
		i32 u0x020001e5, ; uint32_t type_token_id
		i32 627; uint32_t java_map_index
	}, ; 187
	%struct.TypeMapModuleEntry {
		i32 u0x020001e7, ; uint32_t type_token_id
		i32 83; uint32_t java_map_index
	}, ; 188
	%struct.TypeMapModuleEntry {
		i32 u0x020001e9, ; uint32_t type_token_id
		i32 362; uint32_t java_map_index
	}, ; 189
	%struct.TypeMapModuleEntry {
		i32 u0x020001ea, ; uint32_t type_token_id
		i32 110; uint32_t java_map_index
	}, ; 190
	%struct.TypeMapModuleEntry {
		i32 u0x020001ec, ; uint32_t type_token_id
		i32 192; uint32_t java_map_index
	}, ; 191
	%struct.TypeMapModuleEntry {
		i32 u0x020001ed, ; uint32_t type_token_id
		i32 796; uint32_t java_map_index
	}, ; 192
	%struct.TypeMapModuleEntry {
		i32 u0x020001ee, ; uint32_t type_token_id
		i32 318; uint32_t java_map_index
	}, ; 193
	%struct.TypeMapModuleEntry {
		i32 u0x020001f1, ; uint32_t type_token_id
		i32 41; uint32_t java_map_index
	}, ; 194
	%struct.TypeMapModuleEntry {
		i32 u0x020001f2, ; uint32_t type_token_id
		i32 147; uint32_t java_map_index
	}, ; 195
	%struct.TypeMapModuleEntry {
		i32 u0x020001f8, ; uint32_t type_token_id
		i32 265; uint32_t java_map_index
	}, ; 196
	%struct.TypeMapModuleEntry {
		i32 u0x020001fa, ; uint32_t type_token_id
		i32 799; uint32_t java_map_index
	}, ; 197
	%struct.TypeMapModuleEntry {
		i32 u0x020001fc, ; uint32_t type_token_id
		i32 883; uint32_t java_map_index
	}, ; 198
	%struct.TypeMapModuleEntry {
		i32 u0x020001fd, ; uint32_t type_token_id
		i32 915; uint32_t java_map_index
	}, ; 199
	%struct.TypeMapModuleEntry {
		i32 u0x020001fe, ; uint32_t type_token_id
		i32 1061; uint32_t java_map_index
	}, ; 200
	%struct.TypeMapModuleEntry {
		i32 u0x020001ff, ; uint32_t type_token_id
		i32 276; uint32_t java_map_index
	}, ; 201
	%struct.TypeMapModuleEntry {
		i32 u0x02000200, ; uint32_t type_token_id
		i32 1013; uint32_t java_map_index
	}, ; 202
	%struct.TypeMapModuleEntry {
		i32 u0x02000201, ; uint32_t type_token_id
		i32 813; uint32_t java_map_index
	}, ; 203
	%struct.TypeMapModuleEntry {
		i32 u0x02000205, ; uint32_t type_token_id
		i32 914; uint32_t java_map_index
	}, ; 204
	%struct.TypeMapModuleEntry {
		i32 u0x02000206, ; uint32_t type_token_id
		i32 1003; uint32_t java_map_index
	}, ; 205
	%struct.TypeMapModuleEntry {
		i32 u0x02000208, ; uint32_t type_token_id
		i32 391; uint32_t java_map_index
	}, ; 206
	%struct.TypeMapModuleEntry {
		i32 u0x02000209, ; uint32_t type_token_id
		i32 1143; uint32_t java_map_index
	}, ; 207
	%struct.TypeMapModuleEntry {
		i32 u0x0200020b, ; uint32_t type_token_id
		i32 23; uint32_t java_map_index
	}, ; 208
	%struct.TypeMapModuleEntry {
		i32 u0x0200020e, ; uint32_t type_token_id
		i32 1186; uint32_t java_map_index
	}, ; 209
	%struct.TypeMapModuleEntry {
		i32 u0x0200020f, ; uint32_t type_token_id
		i32 1208; uint32_t java_map_index
	}, ; 210
	%struct.TypeMapModuleEntry {
		i32 u0x02000211, ; uint32_t type_token_id
		i32 347; uint32_t java_map_index
	}, ; 211
	%struct.TypeMapModuleEntry {
		i32 u0x02000214, ; uint32_t type_token_id
		i32 905; uint32_t java_map_index
	}, ; 212
	%struct.TypeMapModuleEntry {
		i32 u0x02000215, ; uint32_t type_token_id
		i32 97; uint32_t java_map_index
	}, ; 213
	%struct.TypeMapModuleEntry {
		i32 u0x02000218, ; uint32_t type_token_id
		i32 1023; uint32_t java_map_index
	}, ; 214
	%struct.TypeMapModuleEntry {
		i32 u0x02000219, ; uint32_t type_token_id
		i32 309; uint32_t java_map_index
	}, ; 215
	%struct.TypeMapModuleEntry {
		i32 u0x0200021c, ; uint32_t type_token_id
		i32 783; uint32_t java_map_index
	}, ; 216
	%struct.TypeMapModuleEntry {
		i32 u0x0200021d, ; uint32_t type_token_id
		i32 1151; uint32_t java_map_index
	}, ; 217
	%struct.TypeMapModuleEntry {
		i32 u0x02000220, ; uint32_t type_token_id
		i32 892; uint32_t java_map_index
	}, ; 218
	%struct.TypeMapModuleEntry {
		i32 u0x02000232, ; uint32_t type_token_id
		i32 447; uint32_t java_map_index
	}, ; 219
	%struct.TypeMapModuleEntry {
		i32 u0x02000233, ; uint32_t type_token_id
		i32 261; uint32_t java_map_index
	}, ; 220
	%struct.TypeMapModuleEntry {
		i32 u0x02000234, ; uint32_t type_token_id
		i32 536; uint32_t java_map_index
	}, ; 221
	%struct.TypeMapModuleEntry {
		i32 u0x02000235, ; uint32_t type_token_id
		i32 640; uint32_t java_map_index
	}, ; 222
	%struct.TypeMapModuleEntry {
		i32 u0x02000236, ; uint32_t type_token_id
		i32 1161; uint32_t java_map_index
	}, ; 223
	%struct.TypeMapModuleEntry {
		i32 u0x02000238, ; uint32_t type_token_id
		i32 913; uint32_t java_map_index
	}, ; 224
	%struct.TypeMapModuleEntry {
		i32 u0x02000239, ; uint32_t type_token_id
		i32 1134; uint32_t java_map_index
	}, ; 225
	%struct.TypeMapModuleEntry {
		i32 u0x0200023b, ; uint32_t type_token_id
		i32 701; uint32_t java_map_index
	}, ; 226
	%struct.TypeMapModuleEntry {
		i32 u0x0200023c, ; uint32_t type_token_id
		i32 580; uint32_t java_map_index
	}, ; 227
	%struct.TypeMapModuleEntry {
		i32 u0x02000240, ; uint32_t type_token_id
		i32 443; uint32_t java_map_index
	}, ; 228
	%struct.TypeMapModuleEntry {
		i32 u0x02000243, ; uint32_t type_token_id
		i32 439; uint32_t java_map_index
	}, ; 229
	%struct.TypeMapModuleEntry {
		i32 u0x02000244, ; uint32_t type_token_id
		i32 96; uint32_t java_map_index
	}, ; 230
	%struct.TypeMapModuleEntry {
		i32 u0x02000245, ; uint32_t type_token_id
		i32 773; uint32_t java_map_index
	}, ; 231
	%struct.TypeMapModuleEntry {
		i32 u0x02000247, ; uint32_t type_token_id
		i32 617; uint32_t java_map_index
	}, ; 232
	%struct.TypeMapModuleEntry {
		i32 u0x02000249, ; uint32_t type_token_id
		i32 100; uint32_t java_map_index
	}, ; 233
	%struct.TypeMapModuleEntry {
		i32 u0x0200024d, ; uint32_t type_token_id
		i32 419; uint32_t java_map_index
	}, ; 234
	%struct.TypeMapModuleEntry {
		i32 u0x0200024e, ; uint32_t type_token_id
		i32 1253; uint32_t java_map_index
	}, ; 235
	%struct.TypeMapModuleEntry {
		i32 u0x02000250, ; uint32_t type_token_id
		i32 305; uint32_t java_map_index
	}, ; 236
	%struct.TypeMapModuleEntry {
		i32 u0x02000252, ; uint32_t type_token_id
		i32 1090; uint32_t java_map_index
	}, ; 237
	%struct.TypeMapModuleEntry {
		i32 u0x02000254, ; uint32_t type_token_id
		i32 229; uint32_t java_map_index
	}, ; 238
	%struct.TypeMapModuleEntry {
		i32 u0x02000256, ; uint32_t type_token_id
		i32 1094; uint32_t java_map_index
	}, ; 239
	%struct.TypeMapModuleEntry {
		i32 u0x02000258, ; uint32_t type_token_id
		i32 242; uint32_t java_map_index
	}, ; 240
	%struct.TypeMapModuleEntry {
		i32 u0x0200025b, ; uint32_t type_token_id
		i32 311; uint32_t java_map_index
	}, ; 241
	%struct.TypeMapModuleEntry {
		i32 u0x0200025d, ; uint32_t type_token_id
		i32 497; uint32_t java_map_index
	}, ; 242
	%struct.TypeMapModuleEntry {
		i32 u0x0200025f, ; uint32_t type_token_id
		i32 1012; uint32_t java_map_index
	}, ; 243
	%struct.TypeMapModuleEntry {
		i32 u0x02000263, ; uint32_t type_token_id
		i32 165; uint32_t java_map_index
	}, ; 244
	%struct.TypeMapModuleEntry {
		i32 u0x02000265, ; uint32_t type_token_id
		i32 957; uint32_t java_map_index
	}, ; 245
	%struct.TypeMapModuleEntry {
		i32 u0x02000267, ; uint32_t type_token_id
		i32 463; uint32_t java_map_index
	}, ; 246
	%struct.TypeMapModuleEntry {
		i32 u0x02000269, ; uint32_t type_token_id
		i32 716; uint32_t java_map_index
	}, ; 247
	%struct.TypeMapModuleEntry {
		i32 u0x0200026b, ; uint32_t type_token_id
		i32 301; uint32_t java_map_index
	}, ; 248
	%struct.TypeMapModuleEntry {
		i32 u0x0200026d, ; uint32_t type_token_id
		i32 959; uint32_t java_map_index
	}, ; 249
	%struct.TypeMapModuleEntry {
		i32 u0x0200026f, ; uint32_t type_token_id
		i32 132; uint32_t java_map_index
	}, ; 250
	%struct.TypeMapModuleEntry {
		i32 u0x02000271, ; uint32_t type_token_id
		i32 89; uint32_t java_map_index
	}, ; 251
	%struct.TypeMapModuleEntry {
		i32 u0x02000272, ; uint32_t type_token_id
		i32 118; uint32_t java_map_index
	}, ; 252
	%struct.TypeMapModuleEntry {
		i32 u0x02000275, ; uint32_t type_token_id
		i32 420; uint32_t java_map_index
	}, ; 253
	%struct.TypeMapModuleEntry {
		i32 u0x02000277, ; uint32_t type_token_id
		i32 865; uint32_t java_map_index
	}, ; 254
	%struct.TypeMapModuleEntry {
		i32 u0x02000278, ; uint32_t type_token_id
		i32 513; uint32_t java_map_index
	}, ; 255
	%struct.TypeMapModuleEntry {
		i32 u0x02000280, ; uint32_t type_token_id
		i32 704; uint32_t java_map_index
	}, ; 256
	%struct.TypeMapModuleEntry {
		i32 u0x02000286, ; uint32_t type_token_id
		i32 33; uint32_t java_map_index
	}, ; 257
	%struct.TypeMapModuleEntry {
		i32 u0x02000289, ; uint32_t type_token_id
		i32 427; uint32_t java_map_index
	}, ; 258
	%struct.TypeMapModuleEntry {
		i32 u0x0200028a, ; uint32_t type_token_id
		i32 577; uint32_t java_map_index
	}, ; 259
	%struct.TypeMapModuleEntry {
		i32 u0x0200028c, ; uint32_t type_token_id
		i32 995; uint32_t java_map_index
	}, ; 260
	%struct.TypeMapModuleEntry {
		i32 u0x0200028e, ; uint32_t type_token_id
		i32 194; uint32_t java_map_index
	}, ; 261
	%struct.TypeMapModuleEntry {
		i32 u0x02000291, ; uint32_t type_token_id
		i32 676; uint32_t java_map_index
	}, ; 262
	%struct.TypeMapModuleEntry {
		i32 u0x02000295, ; uint32_t type_token_id
		i32 1221; uint32_t java_map_index
	}, ; 263
	%struct.TypeMapModuleEntry {
		i32 u0x02000296, ; uint32_t type_token_id
		i32 306; uint32_t java_map_index
	}, ; 264
	%struct.TypeMapModuleEntry {
		i32 u0x02000297, ; uint32_t type_token_id
		i32 661; uint32_t java_map_index
	}, ; 265
	%struct.TypeMapModuleEntry {
		i32 u0x02000298, ; uint32_t type_token_id
		i32 14; uint32_t java_map_index
	}, ; 266
	%struct.TypeMapModuleEntry {
		i32 u0x02000299, ; uint32_t type_token_id
		i32 646; uint32_t java_map_index
	}, ; 267
	%struct.TypeMapModuleEntry {
		i32 u0x0200029d, ; uint32_t type_token_id
		i32 766; uint32_t java_map_index
	}, ; 268
	%struct.TypeMapModuleEntry {
		i32 u0x020002a4, ; uint32_t type_token_id
		i32 1009; uint32_t java_map_index
	}, ; 269
	%struct.TypeMapModuleEntry {
		i32 u0x020002a6, ; uint32_t type_token_id
		i32 1104; uint32_t java_map_index
	}, ; 270
	%struct.TypeMapModuleEntry {
		i32 u0x020002a9, ; uint32_t type_token_id
		i32 897; uint32_t java_map_index
	}, ; 271
	%struct.TypeMapModuleEntry {
		i32 u0x020002aa, ; uint32_t type_token_id
		i32 338; uint32_t java_map_index
	}, ; 272
	%struct.TypeMapModuleEntry {
		i32 u0x020002ab, ; uint32_t type_token_id
		i32 1054; uint32_t java_map_index
	}, ; 273
	%struct.TypeMapModuleEntry {
		i32 u0x020002ac, ; uint32_t type_token_id
		i32 658; uint32_t java_map_index
	}, ; 274
	%struct.TypeMapModuleEntry {
		i32 u0x020002ae, ; uint32_t type_token_id
		i32 1271; uint32_t java_map_index
	}, ; 275
	%struct.TypeMapModuleEntry {
		i32 u0x020002af, ; uint32_t type_token_id
		i32 295; uint32_t java_map_index
	}, ; 276
	%struct.TypeMapModuleEntry {
		i32 u0x020002b1, ; uint32_t type_token_id
		i32 1251; uint32_t java_map_index
	}, ; 277
	%struct.TypeMapModuleEntry {
		i32 u0x020002b2, ; uint32_t type_token_id
		i32 121; uint32_t java_map_index
	}, ; 278
	%struct.TypeMapModuleEntry {
		i32 u0x020002b3, ; uint32_t type_token_id
		i32 268; uint32_t java_map_index
	}, ; 279
	%struct.TypeMapModuleEntry {
		i32 u0x020002b8, ; uint32_t type_token_id
		i32 38; uint32_t java_map_index
	}, ; 280
	%struct.TypeMapModuleEntry {
		i32 u0x020002bd, ; uint32_t type_token_id
		i32 952; uint32_t java_map_index
	}, ; 281
	%struct.TypeMapModuleEntry {
		i32 u0x020002be, ; uint32_t type_token_id
		i32 273; uint32_t java_map_index
	}, ; 282
	%struct.TypeMapModuleEntry {
		i32 u0x020002bf, ; uint32_t type_token_id
		i32 332; uint32_t java_map_index
	}, ; 283
	%struct.TypeMapModuleEntry {
		i32 u0x020002c1, ; uint32_t type_token_id
		i32 1092; uint32_t java_map_index
	}, ; 284
	%struct.TypeMapModuleEntry {
		i32 u0x020002c2, ; uint32_t type_token_id
		i32 870; uint32_t java_map_index
	}, ; 285
	%struct.TypeMapModuleEntry {
		i32 u0x020002c4, ; uint32_t type_token_id
		i32 249; uint32_t java_map_index
	}, ; 286
	%struct.TypeMapModuleEntry {
		i32 u0x020002c5, ; uint32_t type_token_id
		i32 1159; uint32_t java_map_index
	}, ; 287
	%struct.TypeMapModuleEntry {
		i32 u0x020002c6, ; uint32_t type_token_id
		i32 120; uint32_t java_map_index
	}, ; 288
	%struct.TypeMapModuleEntry {
		i32 u0x020002c7, ; uint32_t type_token_id
		i32 1249; uint32_t java_map_index
	}, ; 289
	%struct.TypeMapModuleEntry {
		i32 u0x020002c8, ; uint32_t type_token_id
		i32 401; uint32_t java_map_index
	}, ; 290
	%struct.TypeMapModuleEntry {
		i32 u0x020002c9, ; uint32_t type_token_id
		i32 750; uint32_t java_map_index
	}, ; 291
	%struct.TypeMapModuleEntry {
		i32 u0x020002ca, ; uint32_t type_token_id
		i32 389; uint32_t java_map_index
	}, ; 292
	%struct.TypeMapModuleEntry {
		i32 u0x020002cb, ; uint32_t type_token_id
		i32 204; uint32_t java_map_index
	}, ; 293
	%struct.TypeMapModuleEntry {
		i32 u0x020002cc, ; uint32_t type_token_id
		i32 868; uint32_t java_map_index
	}, ; 294
	%struct.TypeMapModuleEntry {
		i32 u0x020002ce, ; uint32_t type_token_id
		i32 1130; uint32_t java_map_index
	}, ; 295
	%struct.TypeMapModuleEntry {
		i32 u0x020002d1, ; uint32_t type_token_id
		i32 284; uint32_t java_map_index
	}, ; 296
	%struct.TypeMapModuleEntry {
		i32 u0x020002d6, ; uint32_t type_token_id
		i32 1020; uint32_t java_map_index
	}, ; 297
	%struct.TypeMapModuleEntry {
		i32 u0x020002d7, ; uint32_t type_token_id
		i32 735; uint32_t java_map_index
	}, ; 298
	%struct.TypeMapModuleEntry {
		i32 u0x020002da, ; uint32_t type_token_id
		i32 1244; uint32_t java_map_index
	}, ; 299
	%struct.TypeMapModuleEntry {
		i32 u0x020002db, ; uint32_t type_token_id
		i32 989; uint32_t java_map_index
	}, ; 300
	%struct.TypeMapModuleEntry {
		i32 u0x020002dc, ; uint32_t type_token_id
		i32 1072; uint32_t java_map_index
	}, ; 301
	%struct.TypeMapModuleEntry {
		i32 u0x020002dd, ; uint32_t type_token_id
		i32 1222; uint32_t java_map_index
	}, ; 302
	%struct.TypeMapModuleEntry {
		i32 u0x020002de, ; uint32_t type_token_id
		i32 550; uint32_t java_map_index
	}, ; 303
	%struct.TypeMapModuleEntry {
		i32 u0x020002df, ; uint32_t type_token_id
		i32 277; uint32_t java_map_index
	}, ; 304
	%struct.TypeMapModuleEntry {
		i32 u0x020002e1, ; uint32_t type_token_id
		i32 285; uint32_t java_map_index
	}, ; 305
	%struct.TypeMapModuleEntry {
		i32 u0x020002e2, ; uint32_t type_token_id
		i32 128; uint32_t java_map_index
	}, ; 306
	%struct.TypeMapModuleEntry {
		i32 u0x020002e3, ; uint32_t type_token_id
		i32 408; uint32_t java_map_index
	}, ; 307
	%struct.TypeMapModuleEntry {
		i32 u0x020002e4, ; uint32_t type_token_id
		i32 990; uint32_t java_map_index
	}, ; 308
	%struct.TypeMapModuleEntry {
		i32 u0x020002fd, ; uint32_t type_token_id
		i32 752; uint32_t java_map_index
	}, ; 309
	%struct.TypeMapModuleEntry {
		i32 u0x02000300, ; uint32_t type_token_id
		i32 1216; uint32_t java_map_index
	}, ; 310
	%struct.TypeMapModuleEntry {
		i32 u0x02000302, ; uint32_t type_token_id
		i32 1000; uint32_t java_map_index
	}, ; 311
	%struct.TypeMapModuleEntry {
		i32 u0x02000304, ; uint32_t type_token_id
		i32 59; uint32_t java_map_index
	}, ; 312
	%struct.TypeMapModuleEntry {
		i32 u0x0200030d, ; uint32_t type_token_id
		i32 615; uint32_t java_map_index
	}, ; 313
	%struct.TypeMapModuleEntry {
		i32 u0x0200030f, ; uint32_t type_token_id
		i32 56; uint32_t java_map_index
	}, ; 314
	%struct.TypeMapModuleEntry {
		i32 u0x02000310, ; uint32_t type_token_id
		i32 303; uint32_t java_map_index
	}, ; 315
	%struct.TypeMapModuleEntry {
		i32 u0x02000311, ; uint32_t type_token_id
		i32 1257; uint32_t java_map_index
	}, ; 316
	%struct.TypeMapModuleEntry {
		i32 u0x0200031d, ; uint32_t type_token_id
		i32 713; uint32_t java_map_index
	}, ; 317
	%struct.TypeMapModuleEntry {
		i32 u0x02000328, ; uint32_t type_token_id
		i32 850; uint32_t java_map_index
	}, ; 318
	%struct.TypeMapModuleEntry {
		i32 u0x02000329, ; uint32_t type_token_id
		i32 784; uint32_t java_map_index
	}, ; 319
	%struct.TypeMapModuleEntry {
		i32 u0x0200032a, ; uint32_t type_token_id
		i32 733; uint32_t java_map_index
	}, ; 320
	%struct.TypeMapModuleEntry {
		i32 u0x0200032c, ; uint32_t type_token_id
		i32 179; uint32_t java_map_index
	}, ; 321
	%struct.TypeMapModuleEntry {
		i32 u0x0200032e, ; uint32_t type_token_id
		i32 278; uint32_t java_map_index
	}, ; 322
	%struct.TypeMapModuleEntry {
		i32 u0x0200032f, ; uint32_t type_token_id
		i32 157; uint32_t java_map_index
	}, ; 323
	%struct.TypeMapModuleEntry {
		i32 u0x02000330, ; uint32_t type_token_id
		i32 616; uint32_t java_map_index
	}, ; 324
	%struct.TypeMapModuleEntry {
		i32 u0x02000331, ; uint32_t type_token_id
		i32 238; uint32_t java_map_index
	}, ; 325
	%struct.TypeMapModuleEntry {
		i32 u0x02000332, ; uint32_t type_token_id
		i32 991; uint32_t java_map_index
	}, ; 326
	%struct.TypeMapModuleEntry {
		i32 u0x02000333, ; uint32_t type_token_id
		i32 375; uint32_t java_map_index
	}, ; 327
	%struct.TypeMapModuleEntry {
		i32 u0x02000335, ; uint32_t type_token_id
		i32 954; uint32_t java_map_index
	}, ; 328
	%struct.TypeMapModuleEntry {
		i32 u0x02000336, ; uint32_t type_token_id
		i32 499; uint32_t java_map_index
	}, ; 329
	%struct.TypeMapModuleEntry {
		i32 u0x02000337, ; uint32_t type_token_id
		i32 745; uint32_t java_map_index
	}, ; 330
	%struct.TypeMapModuleEntry {
		i32 u0x02000339, ; uint32_t type_token_id
		i32 537; uint32_t java_map_index
	}, ; 331
	%struct.TypeMapModuleEntry {
		i32 u0x0200033c, ; uint32_t type_token_id
		i32 852; uint32_t java_map_index
	}, ; 332
	%struct.TypeMapModuleEntry {
		i32 u0x0200033d, ; uint32_t type_token_id
		i32 764; uint32_t java_map_index
	}, ; 333
	%struct.TypeMapModuleEntry {
		i32 u0x0200033e, ; uint32_t type_token_id
		i32 111; uint32_t java_map_index
	}, ; 334
	%struct.TypeMapModuleEntry {
		i32 u0x0200033f, ; uint32_t type_token_id
		i32 207; uint32_t java_map_index
	}, ; 335
	%struct.TypeMapModuleEntry {
		i32 u0x02000340, ; uint32_t type_token_id
		i32 233; uint32_t java_map_index
	}, ; 336
	%struct.TypeMapModuleEntry {
		i32 u0x02000341, ; uint32_t type_token_id
		i32 578; uint32_t java_map_index
	}, ; 337
	%struct.TypeMapModuleEntry {
		i32 u0x02000342, ; uint32_t type_token_id
		i32 410; uint32_t java_map_index
	}, ; 338
	%struct.TypeMapModuleEntry {
		i32 u0x02000343, ; uint32_t type_token_id
		i32 63; uint32_t java_map_index
	}, ; 339
	%struct.TypeMapModuleEntry {
		i32 u0x02000344, ; uint32_t type_token_id
		i32 321; uint32_t java_map_index
	}, ; 340
	%struct.TypeMapModuleEntry {
		i32 u0x02000345, ; uint32_t type_token_id
		i32 1252; uint32_t java_map_index
	}, ; 341
	%struct.TypeMapModuleEntry {
		i32 u0x02000346, ; uint32_t type_token_id
		i32 298; uint32_t java_map_index
	}, ; 342
	%struct.TypeMapModuleEntry {
		i32 u0x02000348, ; uint32_t type_token_id
		i32 940; uint32_t java_map_index
	}, ; 343
	%struct.TypeMapModuleEntry {
		i32 u0x02000349, ; uint32_t type_token_id
		i32 459; uint32_t java_map_index
	}, ; 344
	%struct.TypeMapModuleEntry {
		i32 u0x0200034a, ; uint32_t type_token_id
		i32 562; uint32_t java_map_index
	}, ; 345
	%struct.TypeMapModuleEntry {
		i32 u0x0200034b, ; uint32_t type_token_id
		i32 280; uint32_t java_map_index
	}, ; 346
	%struct.TypeMapModuleEntry {
		i32 u0x0200034c, ; uint32_t type_token_id
		i32 895; uint32_t java_map_index
	}, ; 347
	%struct.TypeMapModuleEntry {
		i32 u0x0200034d, ; uint32_t type_token_id
		i32 731; uint32_t java_map_index
	}, ; 348
	%struct.TypeMapModuleEntry {
		i32 u0x0200034e, ; uint32_t type_token_id
		i32 1091; uint32_t java_map_index
	}, ; 349
	%struct.TypeMapModuleEntry {
		i32 u0x0200034f, ; uint32_t type_token_id
		i32 486; uint32_t java_map_index
	}, ; 350
	%struct.TypeMapModuleEntry {
		i32 u0x02000350, ; uint32_t type_token_id
		i32 837; uint32_t java_map_index
	}, ; 351
	%struct.TypeMapModuleEntry {
		i32 u0x02000351, ; uint32_t type_token_id
		i32 809; uint32_t java_map_index
	}, ; 352
	%struct.TypeMapModuleEntry {
		i32 u0x02000353, ; uint32_t type_token_id
		i32 79; uint32_t java_map_index
	}, ; 353
	%struct.TypeMapModuleEntry {
		i32 u0x02000354, ; uint32_t type_token_id
		i32 355; uint32_t java_map_index
	}, ; 354
	%struct.TypeMapModuleEntry {
		i32 u0x02000355, ; uint32_t type_token_id
		i32 68; uint32_t java_map_index
	}, ; 355
	%struct.TypeMapModuleEntry {
		i32 u0x02000356, ; uint32_t type_token_id
		i32 196; uint32_t java_map_index
	}, ; 356
	%struct.TypeMapModuleEntry {
		i32 u0x02000357, ; uint32_t type_token_id
		i32 404; uint32_t java_map_index
	}, ; 357
	%struct.TypeMapModuleEntry {
		i32 u0x02000358, ; uint32_t type_token_id
		i32 363; uint32_t java_map_index
	}, ; 358
	%struct.TypeMapModuleEntry {
		i32 u0x02000359, ; uint32_t type_token_id
		i32 776; uint32_t java_map_index
	}, ; 359
	%struct.TypeMapModuleEntry {
		i32 u0x0200035a, ; uint32_t type_token_id
		i32 553; uint32_t java_map_index
	}, ; 360
	%struct.TypeMapModuleEntry {
		i32 u0x0200035b, ; uint32_t type_token_id
		i32 795; uint32_t java_map_index
	}, ; 361
	%struct.TypeMapModuleEntry {
		i32 u0x0200035c, ; uint32_t type_token_id
		i32 851; uint32_t java_map_index
	}, ; 362
	%struct.TypeMapModuleEntry {
		i32 u0x0200035d, ; uint32_t type_token_id
		i32 348; uint32_t java_map_index
	}, ; 363
	%struct.TypeMapModuleEntry {
		i32 u0x0200035e, ; uint32_t type_token_id
		i32 448; uint32_t java_map_index
	}, ; 364
	%struct.TypeMapModuleEntry {
		i32 u0x0200035f, ; uint32_t type_token_id
		i32 886; uint32_t java_map_index
	}, ; 365
	%struct.TypeMapModuleEntry {
		i32 u0x02000360, ; uint32_t type_token_id
		i32 155; uint32_t java_map_index
	}, ; 366
	%struct.TypeMapModuleEntry {
		i32 u0x02000361, ; uint32_t type_token_id
		i32 67; uint32_t java_map_index
	}, ; 367
	%struct.TypeMapModuleEntry {
		i32 u0x02000362, ; uint32_t type_token_id
		i32 491; uint32_t java_map_index
	}, ; 368
	%struct.TypeMapModuleEntry {
		i32 u0x02000363, ; uint32_t type_token_id
		i32 1204; uint32_t java_map_index
	}, ; 369
	%struct.TypeMapModuleEntry {
		i32 u0x02000364, ; uint32_t type_token_id
		i32 1024; uint32_t java_map_index
	}, ; 370
	%struct.TypeMapModuleEntry {
		i32 u0x02000366, ; uint32_t type_token_id
		i32 1016; uint32_t java_map_index
	}, ; 371
	%struct.TypeMapModuleEntry {
		i32 u0x02000367, ; uint32_t type_token_id
		i32 583; uint32_t java_map_index
	}, ; 372
	%struct.TypeMapModuleEntry {
		i32 u0x02000368, ; uint32_t type_token_id
		i32 76; uint32_t java_map_index
	}, ; 373
	%struct.TypeMapModuleEntry {
		i32 u0x0200036a, ; uint32_t type_token_id
		i32 88; uint32_t java_map_index
	}, ; 374
	%struct.TypeMapModuleEntry {
		i32 u0x0200036b, ; uint32_t type_token_id
		i32 803; uint32_t java_map_index
	}, ; 375
	%struct.TypeMapModuleEntry {
		i32 u0x0200036c, ; uint32_t type_token_id
		i32 967; uint32_t java_map_index
	}, ; 376
	%struct.TypeMapModuleEntry {
		i32 u0x0200036d, ; uint32_t type_token_id
		i32 644; uint32_t java_map_index
	}, ; 377
	%struct.TypeMapModuleEntry {
		i32 u0x0200036e, ; uint32_t type_token_id
		i32 167; uint32_t java_map_index
	}, ; 378
	%struct.TypeMapModuleEntry {
		i32 u0x0200036f, ; uint32_t type_token_id
		i32 436; uint32_t java_map_index
	}, ; 379
	%struct.TypeMapModuleEntry {
		i32 u0x02000371, ; uint32_t type_token_id
		i32 552; uint32_t java_map_index
	}, ; 380
	%struct.TypeMapModuleEntry {
		i32 u0x02000373, ; uint32_t type_token_id
		i32 93; uint32_t java_map_index
	}, ; 381
	%struct.TypeMapModuleEntry {
		i32 u0x02000374, ; uint32_t type_token_id
		i32 65; uint32_t java_map_index
	}, ; 382
	%struct.TypeMapModuleEntry {
		i32 u0x02000376, ; uint32_t type_token_id
		i32 655; uint32_t java_map_index
	}, ; 383
	%struct.TypeMapModuleEntry {
		i32 u0x02000378, ; uint32_t type_token_id
		i32 1052; uint32_t java_map_index
	}, ; 384
	%struct.TypeMapModuleEntry {
		i32 u0x02000379, ; uint32_t type_token_id
		i32 382; uint32_t java_map_index
	}, ; 385
	%struct.TypeMapModuleEntry {
		i32 u0x0200037a, ; uint32_t type_token_id
		i32 1038; uint32_t java_map_index
	}, ; 386
	%struct.TypeMapModuleEntry {
		i32 u0x0200037b, ; uint32_t type_token_id
		i32 1231; uint32_t java_map_index
	}, ; 387
	%struct.TypeMapModuleEntry {
		i32 u0x0200037c, ; uint32_t type_token_id
		i32 492; uint32_t java_map_index
	}, ; 388
	%struct.TypeMapModuleEntry {
		i32 u0x0200037f, ; uint32_t type_token_id
		i32 160; uint32_t java_map_index
	}, ; 389
	%struct.TypeMapModuleEntry {
		i32 u0x02000380, ; uint32_t type_token_id
		i32 374; uint32_t java_map_index
	}, ; 390
	%struct.TypeMapModuleEntry {
		i32 u0x02000381, ; uint32_t type_token_id
		i32 297; uint32_t java_map_index
	}, ; 391
	%struct.TypeMapModuleEntry {
		i32 u0x02000382, ; uint32_t type_token_id
		i32 1065; uint32_t java_map_index
	}, ; 392
	%struct.TypeMapModuleEntry {
		i32 u0x02000386, ; uint32_t type_token_id
		i32 623; uint32_t java_map_index
	}, ; 393
	%struct.TypeMapModuleEntry {
		i32 u0x02000387, ; uint32_t type_token_id
		i32 660; uint32_t java_map_index
	}, ; 394
	%struct.TypeMapModuleEntry {
		i32 u0x02000388, ; uint32_t type_token_id
		i32 588; uint32_t java_map_index
	}, ; 395
	%struct.TypeMapModuleEntry {
		i32 u0x02000389, ; uint32_t type_token_id
		i32 237; uint32_t java_map_index
	}, ; 396
	%struct.TypeMapModuleEntry {
		i32 u0x0200038b, ; uint32_t type_token_id
		i32 472; uint32_t java_map_index
	}, ; 397
	%struct.TypeMapModuleEntry {
		i32 u0x0200038d, ; uint32_t type_token_id
		i32 749; uint32_t java_map_index
	}, ; 398
	%struct.TypeMapModuleEntry {
		i32 u0x0200038e, ; uint32_t type_token_id
		i32 953; uint32_t java_map_index
	}, ; 399
	%struct.TypeMapModuleEntry {
		i32 u0x0200038f, ; uint32_t type_token_id
		i32 239; uint32_t java_map_index
	}, ; 400
	%struct.TypeMapModuleEntry {
		i32 u0x02000390, ; uint32_t type_token_id
		i32 86; uint32_t java_map_index
	}, ; 401
	%struct.TypeMapModuleEntry {
		i32 u0x02000392, ; uint32_t type_token_id
		i32 1070; uint32_t java_map_index
	}, ; 402
	%struct.TypeMapModuleEntry {
		i32 u0x02000395, ; uint32_t type_token_id
		i32 450; uint32_t java_map_index
	}, ; 403
	%struct.TypeMapModuleEntry {
		i32 u0x02000397, ; uint32_t type_token_id
		i32 54; uint32_t java_map_index
	}, ; 404
	%struct.TypeMapModuleEntry {
		i32 u0x02000399, ; uint32_t type_token_id
		i32 1115; uint32_t java_map_index
	}, ; 405
	%struct.TypeMapModuleEntry {
		i32 u0x0200039a, ; uint32_t type_token_id
		i32 254; uint32_t java_map_index
	}, ; 406
	%struct.TypeMapModuleEntry {
		i32 u0x0200039d, ; uint32_t type_token_id
		i32 371; uint32_t java_map_index
	}, ; 407
	%struct.TypeMapModuleEntry {
		i32 u0x0200039e, ; uint32_t type_token_id
		i32 62; uint32_t java_map_index
	}, ; 408
	%struct.TypeMapModuleEntry {
		i32 u0x020003a0, ; uint32_t type_token_id
		i32 734; uint32_t java_map_index
	}, ; 409
	%struct.TypeMapModuleEntry {
		i32 u0x020003a1, ; uint32_t type_token_id
		i32 1084; uint32_t java_map_index
	}, ; 410
	%struct.TypeMapModuleEntry {
		i32 u0x020003a3, ; uint32_t type_token_id
		i32 1145; uint32_t java_map_index
	}, ; 411
	%struct.TypeMapModuleEntry {
		i32 u0x020003a6, ; uint32_t type_token_id
		i32 887; uint32_t java_map_index
	}, ; 412
	%struct.TypeMapModuleEntry {
		i32 u0x020003a8, ; uint32_t type_token_id
		i32 35; uint32_t java_map_index
	}, ; 413
	%struct.TypeMapModuleEntry {
		i32 u0x020003a9, ; uint32_t type_token_id
		i32 359; uint32_t java_map_index
	}, ; 414
	%struct.TypeMapModuleEntry {
		i32 u0x020003ab, ; uint32_t type_token_id
		i32 163; uint32_t java_map_index
	}, ; 415
	%struct.TypeMapModuleEntry {
		i32 u0x020003ac, ; uint32_t type_token_id
		i32 234; uint32_t java_map_index
	}, ; 416
	%struct.TypeMapModuleEntry {
		i32 u0x020003ad, ; uint32_t type_token_id
		i32 256; uint32_t java_map_index
	}, ; 417
	%struct.TypeMapModuleEntry {
		i32 u0x020003af, ; uint32_t type_token_id
		i32 1174; uint32_t java_map_index
	}, ; 418
	%struct.TypeMapModuleEntry {
		i32 u0x020003b1, ; uint32_t type_token_id
		i32 829; uint32_t java_map_index
	}, ; 419
	%struct.TypeMapModuleEntry {
		i32 u0x020003b3, ; uint32_t type_token_id
		i32 876; uint32_t java_map_index
	}, ; 420
	%struct.TypeMapModuleEntry {
		i32 u0x020003b6, ; uint32_t type_token_id
		i32 1141; uint32_t java_map_index
	}, ; 421
	%struct.TypeMapModuleEntry {
		i32 u0x020003b7, ; uint32_t type_token_id
		i32 1153; uint32_t java_map_index
	}, ; 422
	%struct.TypeMapModuleEntry {
		i32 u0x020003b8, ; uint32_t type_token_id
		i32 151; uint32_t java_map_index
	}, ; 423
	%struct.TypeMapModuleEntry {
		i32 u0x020003b9, ; uint32_t type_token_id
		i32 906; uint32_t java_map_index
	}, ; 424
	%struct.TypeMapModuleEntry {
		i32 u0x020003bb, ; uint32_t type_token_id
		i32 235; uint32_t java_map_index
	}, ; 425
	%struct.TypeMapModuleEntry {
		i32 u0x020003bc, ; uint32_t type_token_id
		i32 386; uint32_t java_map_index
	}, ; 426
	%struct.TypeMapModuleEntry {
		i32 u0x020003bd, ; uint32_t type_token_id
		i32 26; uint32_t java_map_index
	}, ; 427
	%struct.TypeMapModuleEntry {
		i32 u0x020003bf, ; uint32_t type_token_id
		i32 751; uint32_t java_map_index
	}, ; 428
	%struct.TypeMapModuleEntry {
		i32 u0x020003c0, ; uint32_t type_token_id
		i32 690; uint32_t java_map_index
	}, ; 429
	%struct.TypeMapModuleEntry {
		i32 u0x020003c3, ; uint32_t type_token_id
		i32 1138; uint32_t java_map_index
	}, ; 430
	%struct.TypeMapModuleEntry {
		i32 u0x020003c5, ; uint32_t type_token_id
		i32 122; uint32_t java_map_index
	}, ; 431
	%struct.TypeMapModuleEntry {
		i32 u0x020003c8, ; uint32_t type_token_id
		i32 763; uint32_t java_map_index
	}, ; 432
	%struct.TypeMapModuleEntry {
		i32 u0x020003c9, ; uint32_t type_token_id
		i32 1277; uint32_t java_map_index
	}, ; 433
	%struct.TypeMapModuleEntry {
		i32 u0x020003ca, ; uint32_t type_token_id
		i32 1010; uint32_t java_map_index
	}, ; 434
	%struct.TypeMapModuleEntry {
		i32 u0x020003cb, ; uint32_t type_token_id
		i32 415; uint32_t java_map_index
	}, ; 435
	%struct.TypeMapModuleEntry {
		i32 u0x020003d1, ; uint32_t type_token_id
		i32 43; uint32_t java_map_index
	}, ; 436
	%struct.TypeMapModuleEntry {
		i32 u0x020003d2, ; uint32_t type_token_id
		i32 300; uint32_t java_map_index
	}, ; 437
	%struct.TypeMapModuleEntry {
		i32 u0x020003d3, ; uint32_t type_token_id
		i32 435; uint32_t java_map_index
	}, ; 438
	%struct.TypeMapModuleEntry {
		i32 u0x020003d4, ; uint32_t type_token_id
		i32 1039; uint32_t java_map_index
	}, ; 439
	%struct.TypeMapModuleEntry {
		i32 u0x020003d5, ; uint32_t type_token_id
		i32 483; uint32_t java_map_index
	}, ; 440
	%struct.TypeMapModuleEntry {
		i32 u0x020003d6, ; uint32_t type_token_id
		i32 1008; uint32_t java_map_index
	}, ; 441
	%struct.TypeMapModuleEntry {
		i32 u0x020003d7, ; uint32_t type_token_id
		i32 559; uint32_t java_map_index
	}, ; 442
	%struct.TypeMapModuleEntry {
		i32 u0x020003d9, ; uint32_t type_token_id
		i32 501; uint32_t java_map_index
	}, ; 443
	%struct.TypeMapModuleEntry {
		i32 u0x020003db, ; uint32_t type_token_id
		i32 257; uint32_t java_map_index
	}, ; 444
	%struct.TypeMapModuleEntry {
		i32 u0x020003dd, ; uint32_t type_token_id
		i32 1033; uint32_t java_map_index
	}, ; 445
	%struct.TypeMapModuleEntry {
		i32 u0x020003de, ; uint32_t type_token_id
		i32 728; uint32_t java_map_index
	}, ; 446
	%struct.TypeMapModuleEntry {
		i32 u0x020003e9, ; uint32_t type_token_id
		i32 197; uint32_t java_map_index
	}, ; 447
	%struct.TypeMapModuleEntry {
		i32 u0x020003ea, ; uint32_t type_token_id
		i32 683; uint32_t java_map_index
	}, ; 448
	%struct.TypeMapModuleEntry {
		i32 u0x020003ed, ; uint32_t type_token_id
		i32 538; uint32_t java_map_index
	}, ; 449
	%struct.TypeMapModuleEntry {
		i32 u0x020003ee, ; uint32_t type_token_id
		i32 460; uint32_t java_map_index
	}, ; 450
	%struct.TypeMapModuleEntry {
		i32 u0x020003f0, ; uint32_t type_token_id
		i32 638; uint32_t java_map_index
	}, ; 451
	%struct.TypeMapModuleEntry {
		i32 u0x020003f1, ; uint32_t type_token_id
		i32 1028; uint32_t java_map_index
	}, ; 452
	%struct.TypeMapModuleEntry {
		i32 u0x020003f3, ; uint32_t type_token_id
		i32 1073; uint32_t java_map_index
	}, ; 453
	%struct.TypeMapModuleEntry {
		i32 u0x020003f4, ; uint32_t type_token_id
		i32 911; uint32_t java_map_index
	}, ; 454
	%struct.TypeMapModuleEntry {
		i32 u0x020003f6, ; uint32_t type_token_id
		i32 1044; uint32_t java_map_index
	}, ; 455
	%struct.TypeMapModuleEntry {
		i32 u0x020003f7, ; uint32_t type_token_id
		i32 1211; uint32_t java_map_index
	}, ; 456
	%struct.TypeMapModuleEntry {
		i32 u0x020003f8, ; uint32_t type_token_id
		i32 152; uint32_t java_map_index
	}, ; 457
	%struct.TypeMapModuleEntry {
		i32 u0x020003fa, ; uint32_t type_token_id
		i32 212; uint32_t java_map_index
	}, ; 458
	%struct.TypeMapModuleEntry {
		i32 u0x020003fc, ; uint32_t type_token_id
		i32 346; uint32_t java_map_index
	}, ; 459
	%struct.TypeMapModuleEntry {
		i32 u0x020003fe, ; uint32_t type_token_id
		i32 856; uint32_t java_map_index
	}, ; 460
	%struct.TypeMapModuleEntry {
		i32 u0x02000400, ; uint32_t type_token_id
		i32 27; uint32_t java_map_index
	}, ; 461
	%struct.TypeMapModuleEntry {
		i32 u0x02000401, ; uint32_t type_token_id
		i32 315; uint32_t java_map_index
	}, ; 462
	%struct.TypeMapModuleEntry {
		i32 u0x02000402, ; uint32_t type_token_id
		i32 789; uint32_t java_map_index
	}, ; 463
	%struct.TypeMapModuleEntry {
		i32 u0x02000403, ; uint32_t type_token_id
		i32 82; uint32_t java_map_index
	}, ; 464
	%struct.TypeMapModuleEntry {
		i32 u0x02000404, ; uint32_t type_token_id
		i32 836; uint32_t java_map_index
	}, ; 465
	%struct.TypeMapModuleEntry {
		i32 u0x02000406, ; uint32_t type_token_id
		i32 775; uint32_t java_map_index
	}, ; 466
	%struct.TypeMapModuleEntry {
		i32 u0x02000407, ; uint32_t type_token_id
		i32 506; uint32_t java_map_index
	}, ; 467
	%struct.TypeMapModuleEntry {
		i32 u0x02000408, ; uint32_t type_token_id
		i32 1217; uint32_t java_map_index
	}, ; 468
	%struct.TypeMapModuleEntry {
		i32 u0x02000409, ; uint32_t type_token_id
		i32 635; uint32_t java_map_index
	}, ; 469
	%struct.TypeMapModuleEntry {
		i32 u0x0200040a, ; uint32_t type_token_id
		i32 313; uint32_t java_map_index
	}, ; 470
	%struct.TypeMapModuleEntry {
		i32 u0x0200040c, ; uint32_t type_token_id
		i32 1022; uint32_t java_map_index
	}, ; 471
	%struct.TypeMapModuleEntry {
		i32 u0x0200040d, ; uint32_t type_token_id
		i32 633; uint32_t java_map_index
	}, ; 472
	%struct.TypeMapModuleEntry {
		i32 u0x0200040f, ; uint32_t type_token_id
		i32 246; uint32_t java_map_index
	}, ; 473
	%struct.TypeMapModuleEntry {
		i32 u0x02000411, ; uint32_t type_token_id
		i32 1278; uint32_t java_map_index
	}, ; 474
	%struct.TypeMapModuleEntry {
		i32 u0x02000413, ; uint32_t type_token_id
		i32 551; uint32_t java_map_index
	}, ; 475
	%struct.TypeMapModuleEntry {
		i32 u0x02000414, ; uint32_t type_token_id
		i32 1113; uint32_t java_map_index
	}, ; 476
	%struct.TypeMapModuleEntry {
		i32 u0x02000415, ; uint32_t type_token_id
		i32 1035; uint32_t java_map_index
	}, ; 477
	%struct.TypeMapModuleEntry {
		i32 u0x02000416, ; uint32_t type_token_id
		i32 1129; uint32_t java_map_index
	}, ; 478
	%struct.TypeMapModuleEntry {
		i32 u0x02000417, ; uint32_t type_token_id
		i32 283; uint32_t java_map_index
	}, ; 479
	%struct.TypeMapModuleEntry {
		i32 u0x02000419, ; uint32_t type_token_id
		i32 610; uint32_t java_map_index
	}, ; 480
	%struct.TypeMapModuleEntry {
		i32 u0x0200041b, ; uint32_t type_token_id
		i32 1239; uint32_t java_map_index
	}, ; 481
	%struct.TypeMapModuleEntry {
		i32 u0x0200041d, ; uint32_t type_token_id
		i32 91; uint32_t java_map_index
	}, ; 482
	%struct.TypeMapModuleEntry {
		i32 u0x0200041f, ; uint32_t type_token_id
		i32 611; uint32_t java_map_index
	}, ; 483
	%struct.TypeMapModuleEntry {
		i32 u0x02000420, ; uint32_t type_token_id
		i32 87; uint32_t java_map_index
	}, ; 484
	%struct.TypeMapModuleEntry {
		i32 u0x02000422, ; uint32_t type_token_id
		i32 840; uint32_t java_map_index
	}, ; 485
	%struct.TypeMapModuleEntry {
		i32 u0x02000424, ; uint32_t type_token_id
		i32 393; uint32_t java_map_index
	}, ; 486
	%struct.TypeMapModuleEntry {
		i32 u0x02000426, ; uint32_t type_token_id
		i32 1001; uint32_t java_map_index
	}, ; 487
	%struct.TypeMapModuleEntry {
		i32 u0x02000428, ; uint32_t type_token_id
		i32 1106; uint32_t java_map_index
	}, ; 488
	%struct.TypeMapModuleEntry {
		i32 u0x0200042a, ; uint32_t type_token_id
		i32 1175; uint32_t java_map_index
	}, ; 489
	%struct.TypeMapModuleEntry {
		i32 u0x0200042c, ; uint32_t type_token_id
		i32 753; uint32_t java_map_index
	}, ; 490
	%struct.TypeMapModuleEntry {
		i32 u0x0200042d, ; uint32_t type_token_id
		i32 756; uint32_t java_map_index
	}, ; 491
	%struct.TypeMapModuleEntry {
		i32 u0x0200042e, ; uint32_t type_token_id
		i32 1185; uint32_t java_map_index
	}, ; 492
	%struct.TypeMapModuleEntry {
		i32 u0x0200042f, ; uint32_t type_token_id
		i32 780; uint32_t java_map_index
	}, ; 493
	%struct.TypeMapModuleEntry {
		i32 u0x02000430, ; uint32_t type_token_id
		i32 1194; uint32_t java_map_index
	}, ; 494
	%struct.TypeMapModuleEntry {
		i32 u0x02000432, ; uint32_t type_token_id
		i32 671; uint32_t java_map_index
	}, ; 495
	%struct.TypeMapModuleEntry {
		i32 u0x02000434, ; uint32_t type_token_id
		i32 148; uint32_t java_map_index
	}, ; 496
	%struct.TypeMapModuleEntry {
		i32 u0x02000435, ; uint32_t type_token_id
		i32 489; uint32_t java_map_index
	}, ; 497
	%struct.TypeMapModuleEntry {
		i32 u0x02000436, ; uint32_t type_token_id
		i32 468; uint32_t java_map_index
	}, ; 498
	%struct.TypeMapModuleEntry {
		i32 u0x02000438, ; uint32_t type_token_id
		i32 828; uint32_t java_map_index
	}, ; 499
	%struct.TypeMapModuleEntry {
		i32 u0x0200043a, ; uint32_t type_token_id
		i32 1188; uint32_t java_map_index
	}, ; 500
	%struct.TypeMapModuleEntry {
		i32 u0x0200043b, ; uint32_t type_token_id
		i32 112; uint32_t java_map_index
	}, ; 501
	%struct.TypeMapModuleEntry {
		i32 u0x0200043c, ; uint32_t type_token_id
		i32 1049; uint32_t java_map_index
	}, ; 502
	%struct.TypeMapModuleEntry {
		i32 u0x0200043e, ; uint32_t type_token_id
		i32 999; uint32_t java_map_index
	}, ; 503
	%struct.TypeMapModuleEntry {
		i32 u0x0200043f, ; uint32_t type_token_id
		i32 341; uint32_t java_map_index
	}, ; 504
	%struct.TypeMapModuleEntry {
		i32 u0x02000441, ; uint32_t type_token_id
		i32 115; uint32_t java_map_index
	}, ; 505
	%struct.TypeMapModuleEntry {
		i32 u0x02000444, ; uint32_t type_token_id
		i32 466; uint32_t java_map_index
	}, ; 506
	%struct.TypeMapModuleEntry {
		i32 u0x02000446, ; uint32_t type_token_id
		i32 1179; uint32_t java_map_index
	}, ; 507
	%struct.TypeMapModuleEntry {
		i32 u0x02000448, ; uint32_t type_token_id
		i32 555; uint32_t java_map_index
	}, ; 508
	%struct.TypeMapModuleEntry {
		i32 u0x0200044b, ; uint32_t type_token_id
		i32 9; uint32_t java_map_index
	}, ; 509
	%struct.TypeMapModuleEntry {
		i32 u0x0200044d, ; uint32_t type_token_id
		i32 682; uint32_t java_map_index
	}, ; 510
	%struct.TypeMapModuleEntry {
		i32 u0x0200044f, ; uint32_t type_token_id
		i32 566; uint32_t java_map_index
	}, ; 511
	%struct.TypeMapModuleEntry {
		i32 u0x02000451, ; uint32_t type_token_id
		i32 985; uint32_t java_map_index
	}, ; 512
	%struct.TypeMapModuleEntry {
		i32 u0x02000453, ; uint32_t type_token_id
		i32 631; uint32_t java_map_index
	}, ; 513
	%struct.TypeMapModuleEntry {
		i32 u0x02000454, ; uint32_t type_token_id
		i32 31; uint32_t java_map_index
	}, ; 514
	%struct.TypeMapModuleEntry {
		i32 u0x02000456, ; uint32_t type_token_id
		i32 964; uint32_t java_map_index
	}, ; 515
	%struct.TypeMapModuleEntry {
		i32 u0x02000457, ; uint32_t type_token_id
		i32 17; uint32_t java_map_index
	}, ; 516
	%struct.TypeMapModuleEntry {
		i32 u0x02000459, ; uint32_t type_token_id
		i32 1096; uint32_t java_map_index
	}, ; 517
	%struct.TypeMapModuleEntry {
		i32 u0x0200045b, ; uint32_t type_token_id
		i32 688; uint32_t java_map_index
	}, ; 518
	%struct.TypeMapModuleEntry {
		i32 u0x0200045d, ; uint32_t type_token_id
		i32 1120; uint32_t java_map_index
	}, ; 519
	%struct.TypeMapModuleEntry {
		i32 u0x0200045f, ; uint32_t type_token_id
		i32 40; uint32_t java_map_index
	}, ; 520
	%struct.TypeMapModuleEntry {
		i32 u0x02000461, ; uint32_t type_token_id
		i32 769; uint32_t java_map_index
	}, ; 521
	%struct.TypeMapModuleEntry {
		i32 u0x02000463, ; uint32_t type_token_id
		i32 727; uint32_t java_map_index
	}, ; 522
	%struct.TypeMapModuleEntry {
		i32 u0x02000465, ; uint32_t type_token_id
		i32 159; uint32_t java_map_index
	}, ; 523
	%struct.TypeMapModuleEntry {
		i32 u0x02000467, ; uint32_t type_token_id
		i32 1234; uint32_t java_map_index
	}, ; 524
	%struct.TypeMapModuleEntry {
		i32 u0x02000469, ; uint32_t type_token_id
		i32 1058; uint32_t java_map_index
	}, ; 525
	%struct.TypeMapModuleEntry {
		i32 u0x0200046b, ; uint32_t type_token_id
		i32 951; uint32_t java_map_index
	}, ; 526
	%struct.TypeMapModuleEntry {
		i32 u0x0200046c, ; uint32_t type_token_id
		i32 983; uint32_t java_map_index
	}, ; 527
	%struct.TypeMapModuleEntry {
		i32 u0x0200046e, ; uint32_t type_token_id
		i32 1119; uint32_t java_map_index
	}, ; 528
	%struct.TypeMapModuleEntry {
		i32 u0x02000470, ; uint32_t type_token_id
		i32 1220; uint32_t java_map_index
	}, ; 529
	%struct.TypeMapModuleEntry {
		i32 u0x02000472, ; uint32_t type_token_id
		i32 312; uint32_t java_map_index
	}, ; 530
	%struct.TypeMapModuleEntry {
		i32 u0x02000474, ; uint32_t type_token_id
		i32 496; uint32_t java_map_index
	}, ; 531
	%struct.TypeMapModuleEntry {
		i32 u0x02000475, ; uint32_t type_token_id
		i32 884; uint32_t java_map_index
	}, ; 532
	%struct.TypeMapModuleEntry {
		i32 u0x02000476, ; uint32_t type_token_id
		i32 240; uint32_t java_map_index
	}, ; 533
	%struct.TypeMapModuleEntry {
		i32 u0x02000477, ; uint32_t type_token_id
		i32 10; uint32_t java_map_index
	}, ; 534
	%struct.TypeMapModuleEntry {
		i32 u0x02000478, ; uint32_t type_token_id
		i32 680; uint32_t java_map_index
	}, ; 535
	%struct.TypeMapModuleEntry {
		i32 u0x02000479, ; uint32_t type_token_id
		i32 376; uint32_t java_map_index
	}, ; 536
	%struct.TypeMapModuleEntry {
		i32 u0x0200047a, ; uint32_t type_token_id
		i32 943; uint32_t java_map_index
	}, ; 537
	%struct.TypeMapModuleEntry {
		i32 u0x0200047b, ; uint32_t type_token_id
		i32 1027; uint32_t java_map_index
	}, ; 538
	%struct.TypeMapModuleEntry {
		i32 u0x0200047c, ; uint32_t type_token_id
		i32 869; uint32_t java_map_index
	}, ; 539
	%struct.TypeMapModuleEntry {
		i32 u0x0200047d, ; uint32_t type_token_id
		i32 744; uint32_t java_map_index
	}, ; 540
	%struct.TypeMapModuleEntry {
		i32 u0x0200047e, ; uint32_t type_token_id
		i32 659; uint32_t java_map_index
	}, ; 541
	%struct.TypeMapModuleEntry {
		i32 u0x0200047f, ; uint32_t type_token_id
		i32 706; uint32_t java_map_index
	}, ; 542
	%struct.TypeMapModuleEntry {
		i32 u0x02000480, ; uint32_t type_token_id
		i32 866; uint32_t java_map_index
	}, ; 543
	%struct.TypeMapModuleEntry {
		i32 u0x02000481, ; uint32_t type_token_id
		i32 1164; uint32_t java_map_index
	}, ; 544
	%struct.TypeMapModuleEntry {
		i32 u0x02000482, ; uint32_t type_token_id
		i32 556; uint32_t java_map_index
	}, ; 545
	%struct.TypeMapModuleEntry {
		i32 u0x02000483, ; uint32_t type_token_id
		i32 938; uint32_t java_map_index
	}, ; 546
	%struct.TypeMapModuleEntry {
		i32 u0x02000484, ; uint32_t type_token_id
		i32 1246; uint32_t java_map_index
	}, ; 547
	%struct.TypeMapModuleEntry {
		i32 u0x02000485, ; uint32_t type_token_id
		i32 669; uint32_t java_map_index
	}, ; 548
	%struct.TypeMapModuleEntry {
		i32 u0x02000486, ; uint32_t type_token_id
		i32 451; uint32_t java_map_index
	}, ; 549
	%struct.TypeMapModuleEntry {
		i32 u0x02000487, ; uint32_t type_token_id
		i32 849; uint32_t java_map_index
	}, ; 550
	%struct.TypeMapModuleEntry {
		i32 u0x02000489, ; uint32_t type_token_id
		i32 720; uint32_t java_map_index
	}, ; 551
	%struct.TypeMapModuleEntry {
		i32 u0x0200048a, ; uint32_t type_token_id
		i32 958; uint32_t java_map_index
	}, ; 552
	%struct.TypeMapModuleEntry {
		i32 u0x0200048b, ; uint32_t type_token_id
		i32 717; uint32_t java_map_index
	}, ; 553
	%struct.TypeMapModuleEntry {
		i32 u0x0200048c, ; uint32_t type_token_id
		i32 379; uint32_t java_map_index
	}, ; 554
	%struct.TypeMapModuleEntry {
		i32 u0x0200048d, ; uint32_t type_token_id
		i32 260; uint32_t java_map_index
	}, ; 555
	%struct.TypeMapModuleEntry {
		i32 u0x0200048f, ; uint32_t type_token_id
		i32 963; uint32_t java_map_index
	}, ; 556
	%struct.TypeMapModuleEntry {
		i32 u0x02000491, ; uint32_t type_token_id
		i32 164; uint32_t java_map_index
	}, ; 557
	%struct.TypeMapModuleEntry {
		i32 u0x02000492, ; uint32_t type_token_id
		i32 565; uint32_t java_map_index
	}, ; 558
	%struct.TypeMapModuleEntry {
		i32 u0x02000494, ; uint32_t type_token_id
		i32 976; uint32_t java_map_index
	}, ; 559
	%struct.TypeMapModuleEntry {
		i32 u0x02000498, ; uint32_t type_token_id
		i32 440; uint32_t java_map_index
	}, ; 560
	%struct.TypeMapModuleEntry {
		i32 u0x0200049a, ; uint32_t type_token_id
		i32 487; uint32_t java_map_index
	}, ; 561
	%struct.TypeMapModuleEntry {
		i32 u0x0200049c, ; uint32_t type_token_id
		i32 855; uint32_t java_map_index
	}, ; 562
	%struct.TypeMapModuleEntry {
		i32 u0x0200049d, ; uint32_t type_token_id
		i32 255; uint32_t java_map_index
	}, ; 563
	%struct.TypeMapModuleEntry {
		i32 u0x0200049e, ; uint32_t type_token_id
		i32 1199; uint32_t java_map_index
	}, ; 564
	%struct.TypeMapModuleEntry {
		i32 u0x0200049f, ; uint32_t type_token_id
		i32 1265; uint32_t java_map_index
	}, ; 565
	%struct.TypeMapModuleEntry {
		i32 u0x020004a1, ; uint32_t type_token_id
		i32 398; uint32_t java_map_index
	}, ; 566
	%struct.TypeMapModuleEntry {
		i32 u0x020004a2, ; uint32_t type_token_id
		i32 663; uint32_t java_map_index
	}, ; 567
	%struct.TypeMapModuleEntry {
		i32 u0x020004a3, ; uint32_t type_token_id
		i32 1097; uint32_t java_map_index
	}, ; 568
	%struct.TypeMapModuleEntry {
		i32 u0x020004a4, ; uint32_t type_token_id
		i32 786; uint32_t java_map_index
	}, ; 569
	%struct.TypeMapModuleEntry {
		i32 u0x020004a5, ; uint32_t type_token_id
		i32 395; uint32_t java_map_index
	}, ; 570
	%struct.TypeMapModuleEntry {
		i32 u0x020004a7, ; uint32_t type_token_id
		i32 732; uint32_t java_map_index
	}, ; 571
	%struct.TypeMapModuleEntry {
		i32 u0x020004a8, ; uint32_t type_token_id
		i32 226; uint32_t java_map_index
	}, ; 572
	%struct.TypeMapModuleEntry {
		i32 u0x020004a9, ; uint32_t type_token_id
		i32 531; uint32_t java_map_index
	}, ; 573
	%struct.TypeMapModuleEntry {
		i32 u0x020004aa, ; uint32_t type_token_id
		i32 1081; uint32_t java_map_index
	}, ; 574
	%struct.TypeMapModuleEntry {
		i32 u0x020004ab, ; uint32_t type_token_id
		i32 479; uint32_t java_map_index
	}, ; 575
	%struct.TypeMapModuleEntry {
		i32 u0x020004ac, ; uint32_t type_token_id
		i32 1202; uint32_t java_map_index
	}, ; 576
	%struct.TypeMapModuleEntry {
		i32 u0x020004ae, ; uint32_t type_token_id
		i32 21; uint32_t java_map_index
	}, ; 577
	%struct.TypeMapModuleEntry {
		i32 u0x020004af, ; uint32_t type_token_id
		i32 888; uint32_t java_map_index
	}, ; 578
	%struct.TypeMapModuleEntry {
		i32 u0x020004be, ; uint32_t type_token_id
		i32 575; uint32_t java_map_index
	} ; 579
], align 4

@module36_managed_to_java_duplicates = internal dso_local constant [215 x %struct.TypeMapModuleEntry] [
	%struct.TypeMapModuleEntry {
		i32 u0x020000b4, ; uint32_t type_token_id
		i32 890; uint32_t java_map_index
	}, ; 0
	%struct.TypeMapModuleEntry {
		i32 u0x020000b8, ; uint32_t type_token_id
		i32 1255; uint32_t java_map_index
	}, ; 1
	%struct.TypeMapModuleEntry {
		i32 u0x020000ba, ; uint32_t type_token_id
		i32 206; uint32_t java_map_index
	}, ; 2
	%struct.TypeMapModuleEntry {
		i32 u0x020000bd, ; uint32_t type_token_id
		i32 162; uint32_t java_map_index
	}, ; 3
	%struct.TypeMapModuleEntry {
		i32 u0x020000bf, ; uint32_t type_token_id
		i32 381; uint32_t java_map_index
	}, ; 4
	%struct.TypeMapModuleEntry {
		i32 u0x020000c1, ; uint32_t type_token_id
		i32 1178; uint32_t java_map_index
	}, ; 5
	%struct.TypeMapModuleEntry {
		i32 u0x020000c3, ; uint32_t type_token_id
		i32 679; uint32_t java_map_index
	}, ; 6
	%struct.TypeMapModuleEntry {
		i32 u0x020000c5, ; uint32_t type_token_id
		i32 817; uint32_t java_map_index
	}, ; 7
	%struct.TypeMapModuleEntry {
		i32 u0x020000c7, ; uint32_t type_token_id
		i32 1087; uint32_t java_map_index
	}, ; 8
	%struct.TypeMapModuleEntry {
		i32 u0x020000c9, ; uint32_t type_token_id
		i32 920; uint32_t java_map_index
	}, ; 9
	%struct.TypeMapModuleEntry {
		i32 u0x020000cd, ; uint32_t type_token_id
		i32 844; uint32_t java_map_index
	}, ; 10
	%struct.TypeMapModuleEntry {
		i32 u0x020000d6, ; uint32_t type_token_id
		i32 898; uint32_t java_map_index
	}, ; 11
	%struct.TypeMapModuleEntry {
		i32 u0x020000d8, ; uint32_t type_token_id
		i32 1111; uint32_t java_map_index
	}, ; 12
	%struct.TypeMapModuleEntry {
		i32 u0x020000dc, ; uint32_t type_token_id
		i32 189; uint32_t java_map_index
	}, ; 13
	%struct.TypeMapModuleEntry {
		i32 u0x020000de, ; uint32_t type_token_id
		i32 596; uint32_t java_map_index
	}, ; 14
	%struct.TypeMapModuleEntry {
		i32 u0x020000e0, ; uint32_t type_token_id
		i32 397; uint32_t java_map_index
	}, ; 15
	%struct.TypeMapModuleEntry {
		i32 u0x020000e5, ; uint32_t type_token_id
		i32 1098; uint32_t java_map_index
	}, ; 16
	%struct.TypeMapModuleEntry {
		i32 u0x020000e8, ; uint32_t type_token_id
		i32 373; uint32_t java_map_index
	}, ; 17
	%struct.TypeMapModuleEntry {
		i32 u0x020000eb, ; uint32_t type_token_id
		i32 928; uint32_t java_map_index
	}, ; 18
	%struct.TypeMapModuleEntry {
		i32 u0x020000ee, ; uint32_t type_token_id
		i32 1031; uint32_t java_map_index
	}, ; 19
	%struct.TypeMapModuleEntry {
		i32 u0x020000f9, ; uint32_t type_token_id
		i32 464; uint32_t java_map_index
	}, ; 20
	%struct.TypeMapModuleEntry {
		i32 u0x0200010b, ; uint32_t type_token_id
		i32 222; uint32_t java_map_index
	}, ; 21
	%struct.TypeMapModuleEntry {
		i32 u0x0200010d, ; uint32_t type_token_id
		i32 319; uint32_t java_map_index
	}, ; 22
	%struct.TypeMapModuleEntry {
		i32 u0x02000110, ; uint32_t type_token_id
		i32 973; uint32_t java_map_index
	}, ; 23
	%struct.TypeMapModuleEntry {
		i32 u0x02000113, ; uint32_t type_token_id
		i32 0; uint32_t java_map_index
	}, ; 24
	%struct.TypeMapModuleEntry {
		i32 u0x02000115, ; uint32_t type_token_id
		i32 900; uint32_t java_map_index
	}, ; 25
	%struct.TypeMapModuleEntry {
		i32 u0x02000118, ; uint32_t type_token_id
		i32 1270; uint32_t java_map_index
	}, ; 26
	%struct.TypeMapModuleEntry {
		i32 u0x0200011c, ; uint32_t type_token_id
		i32 1132; uint32_t java_map_index
	}, ; 27
	%struct.TypeMapModuleEntry {
		i32 u0x0200011e, ; uint32_t type_token_id
		i32 585; uint32_t java_map_index
	}, ; 28
	%struct.TypeMapModuleEntry {
		i32 u0x0200011f, ; uint32_t type_token_id
		i32 211; uint32_t java_map_index
	}, ; 29
	%struct.TypeMapModuleEntry {
		i32 u0x02000129, ; uint32_t type_token_id
		i32 1279; uint32_t java_map_index
	}, ; 30
	%struct.TypeMapModuleEntry {
		i32 u0x02000131, ; uint32_t type_token_id
		i32 218; uint32_t java_map_index
	}, ; 31
	%struct.TypeMapModuleEntry {
		i32 u0x02000132, ; uint32_t type_token_id
		i32 211; uint32_t java_map_index
	}, ; 32
	%struct.TypeMapModuleEntry {
		i32 u0x02000133, ; uint32_t type_token_id
		i32 485; uint32_t java_map_index
	}, ; 33
	%struct.TypeMapModuleEntry {
		i32 u0x02000134, ; uint32_t type_token_id
		i32 485; uint32_t java_map_index
	}, ; 34
	%struct.TypeMapModuleEntry {
		i32 u0x0200013a, ; uint32_t type_token_id
		i32 1282; uint32_t java_map_index
	}, ; 35
	%struct.TypeMapModuleEntry {
		i32 u0x02000140, ; uint32_t type_token_id
		i32 979; uint32_t java_map_index
	}, ; 36
	%struct.TypeMapModuleEntry {
		i32 u0x02000145, ; uint32_t type_token_id
		i32 723; uint32_t java_map_index
	}, ; 37
	%struct.TypeMapModuleEntry {
		i32 u0x0200014a, ; uint32_t type_token_id
		i32 46; uint32_t java_map_index
	}, ; 38
	%struct.TypeMapModuleEntry {
		i32 u0x0200014c, ; uint32_t type_token_id
		i32 1108; uint32_t java_map_index
	}, ; 39
	%struct.TypeMapModuleEntry {
		i32 u0x0200014e, ; uint32_t type_token_id
		i32 738; uint32_t java_map_index
	}, ; 40
	%struct.TypeMapModuleEntry {
		i32 u0x02000150, ; uint32_t type_token_id
		i32 74; uint32_t java_map_index
	}, ; 41
	%struct.TypeMapModuleEntry {
		i32 u0x02000156, ; uint32_t type_token_id
		i32 772; uint32_t java_map_index
	}, ; 42
	%struct.TypeMapModuleEntry {
		i32 u0x02000158, ; uint32_t type_token_id
		i32 942; uint32_t java_map_index
	}, ; 43
	%struct.TypeMapModuleEntry {
		i32 u0x02000160, ; uint32_t type_token_id
		i32 645; uint32_t java_map_index
	}, ; 44
	%struct.TypeMapModuleEntry {
		i32 u0x0200016f, ; uint32_t type_token_id
		i32 594; uint32_t java_map_index
	}, ; 45
	%struct.TypeMapModuleEntry {
		i32 u0x02000178, ; uint32_t type_token_id
		i32 146; uint32_t java_map_index
	}, ; 46
	%struct.TypeMapModuleEntry {
		i32 u0x02000185, ; uint32_t type_token_id
		i32 1207; uint32_t java_map_index
	}, ; 47
	%struct.TypeMapModuleEntry {
		i32 u0x02000188, ; uint32_t type_token_id
		i32 770; uint32_t java_map_index
	}, ; 48
	%struct.TypeMapModuleEntry {
		i32 u0x0200018c, ; uint32_t type_token_id
		i32 57; uint32_t java_map_index
	}, ; 49
	%struct.TypeMapModuleEntry {
		i32 u0x0200018e, ; uint32_t type_token_id
		i32 1127; uint32_t java_map_index
	}, ; 50
	%struct.TypeMapModuleEntry {
		i32 u0x02000191, ; uint32_t type_token_id
		i32 767; uint32_t java_map_index
	}, ; 51
	%struct.TypeMapModuleEntry {
		i32 u0x02000194, ; uint32_t type_token_id
		i32 705; uint32_t java_map_index
	}, ; 52
	%struct.TypeMapModuleEntry {
		i32 u0x02000197, ; uint32_t type_token_id
		i32 377; uint32_t java_map_index
	}, ; 53
	%struct.TypeMapModuleEntry {
		i32 u0x02000199, ; uint32_t type_token_id
		i32 839; uint32_t java_map_index
	}, ; 54
	%struct.TypeMapModuleEntry {
		i32 u0x0200019d, ; uint32_t type_token_id
		i32 621; uint32_t java_map_index
	}, ; 55
	%struct.TypeMapModuleEntry {
		i32 u0x020001a3, ; uint32_t type_token_id
		i32 71; uint32_t java_map_index
	}, ; 56
	%struct.TypeMapModuleEntry {
		i32 u0x020001ae, ; uint32_t type_token_id
		i32 20; uint32_t java_map_index
	}, ; 57
	%struct.TypeMapModuleEntry {
		i32 u0x020001b0, ; uint32_t type_token_id
		i32 650; uint32_t java_map_index
	}, ; 58
	%struct.TypeMapModuleEntry {
		i32 u0x020001b3, ; uint32_t type_token_id
		i32 664; uint32_t java_map_index
	}, ; 59
	%struct.TypeMapModuleEntry {
		i32 u0x020001b5, ; uint32_t type_token_id
		i32 748; uint32_t java_map_index
	}, ; 60
	%struct.TypeMapModuleEntry {
		i32 u0x020001b7, ; uint32_t type_token_id
		i32 221; uint32_t java_map_index
	}, ; 61
	%struct.TypeMapModuleEntry {
		i32 u0x020001b9, ; uint32_t type_token_id
		i32 98; uint32_t java_map_index
	}, ; 62
	%struct.TypeMapModuleEntry {
		i32 u0x020001c1, ; uint32_t type_token_id
		i32 1122; uint32_t java_map_index
	}, ; 63
	%struct.TypeMapModuleEntry {
		i32 u0x020001c4, ; uint32_t type_token_id
		i32 266; uint32_t java_map_index
	}, ; 64
	%struct.TypeMapModuleEntry {
		i32 u0x020001c6, ; uint32_t type_token_id
		i32 139; uint32_t java_map_index
	}, ; 65
	%struct.TypeMapModuleEntry {
		i32 u0x020001c8, ; uint32_t type_token_id
		i32 302; uint32_t java_map_index
	}, ; 66
	%struct.TypeMapModuleEntry {
		i32 u0x020001da, ; uint32_t type_token_id
		i32 1266; uint32_t java_map_index
	}, ; 67
	%struct.TypeMapModuleEntry {
		i32 u0x020001dc, ; uint32_t type_token_id
		i32 365; uint32_t java_map_index
	}, ; 68
	%struct.TypeMapModuleEntry {
		i32 u0x020001de, ; uint32_t type_token_id
		i32 154; uint32_t java_map_index
	}, ; 69
	%struct.TypeMapModuleEntry {
		i32 u0x020001e0, ; uint32_t type_token_id
		i32 755; uint32_t java_map_index
	}, ; 70
	%struct.TypeMapModuleEntry {
		i32 u0x020001e2, ; uint32_t type_token_id
		i32 1101; uint32_t java_map_index
	}, ; 71
	%struct.TypeMapModuleEntry {
		i32 u0x020001eb, ; uint32_t type_token_id
		i32 110; uint32_t java_map_index
	}, ; 72
	%struct.TypeMapModuleEntry {
		i32 u0x020001ef, ; uint32_t type_token_id
		i32 318; uint32_t java_map_index
	}, ; 73
	%struct.TypeMapModuleEntry {
		i32 u0x020001f3, ; uint32_t type_token_id
		i32 147; uint32_t java_map_index
	}, ; 74
	%struct.TypeMapModuleEntry {
		i32 u0x020001f7, ; uint32_t type_token_id
		i32 362; uint32_t java_map_index
	}, ; 75
	%struct.TypeMapModuleEntry {
		i32 u0x020001f9, ; uint32_t type_token_id
		i32 265; uint32_t java_map_index
	}, ; 76
	%struct.TypeMapModuleEntry {
		i32 u0x020001fb, ; uint32_t type_token_id
		i32 799; uint32_t java_map_index
	}, ; 77
	%struct.TypeMapModuleEntry {
		i32 u0x02000202, ; uint32_t type_token_id
		i32 813; uint32_t java_map_index
	}, ; 78
	%struct.TypeMapModuleEntry {
		i32 u0x02000207, ; uint32_t type_token_id
		i32 1003; uint32_t java_map_index
	}, ; 79
	%struct.TypeMapModuleEntry {
		i32 u0x0200020a, ; uint32_t type_token_id
		i32 1143; uint32_t java_map_index
	}, ; 80
	%struct.TypeMapModuleEntry {
		i32 u0x0200020c, ; uint32_t type_token_id
		i32 23; uint32_t java_map_index
	}, ; 81
	%struct.TypeMapModuleEntry {
		i32 u0x02000210, ; uint32_t type_token_id
		i32 1208; uint32_t java_map_index
	}, ; 82
	%struct.TypeMapModuleEntry {
		i32 u0x02000212, ; uint32_t type_token_id
		i32 347; uint32_t java_map_index
	}, ; 83
	%struct.TypeMapModuleEntry {
		i32 u0x02000216, ; uint32_t type_token_id
		i32 97; uint32_t java_map_index
	}, ; 84
	%struct.TypeMapModuleEntry {
		i32 u0x0200021a, ; uint32_t type_token_id
		i32 309; uint32_t java_map_index
	}, ; 85
	%struct.TypeMapModuleEntry {
		i32 u0x0200021e, ; uint32_t type_token_id
		i32 1151; uint32_t java_map_index
	}, ; 86
	%struct.TypeMapModuleEntry {
		i32 u0x02000237, ; uint32_t type_token_id
		i32 1161; uint32_t java_map_index
	}, ; 87
	%struct.TypeMapModuleEntry {
		i32 u0x0200023a, ; uint32_t type_token_id
		i32 1134; uint32_t java_map_index
	}, ; 88
	%struct.TypeMapModuleEntry {
		i32 u0x0200023d, ; uint32_t type_token_id
		i32 580; uint32_t java_map_index
	}, ; 89
	%struct.TypeMapModuleEntry {
		i32 u0x0200023e, ; uint32_t type_token_id
		i32 701; uint32_t java_map_index
	}, ; 90
	%struct.TypeMapModuleEntry {
		i32 u0x02000241, ; uint32_t type_token_id
		i32 443; uint32_t java_map_index
	}, ; 91
	%struct.TypeMapModuleEntry {
		i32 u0x0200024f, ; uint32_t type_token_id
		i32 1253; uint32_t java_map_index
	}, ; 92
	%struct.TypeMapModuleEntry {
		i32 u0x02000251, ; uint32_t type_token_id
		i32 305; uint32_t java_map_index
	}, ; 93
	%struct.TypeMapModuleEntry {
		i32 u0x02000255, ; uint32_t type_token_id
		i32 229; uint32_t java_map_index
	}, ; 94
	%struct.TypeMapModuleEntry {
		i32 u0x02000257, ; uint32_t type_token_id
		i32 1094; uint32_t java_map_index
	}, ; 95
	%struct.TypeMapModuleEntry {
		i32 u0x0200025a, ; uint32_t type_token_id
		i32 242; uint32_t java_map_index
	}, ; 96
	%struct.TypeMapModuleEntry {
		i32 u0x0200025c, ; uint32_t type_token_id
		i32 311; uint32_t java_map_index
	}, ; 97
	%struct.TypeMapModuleEntry {
		i32 u0x0200025e, ; uint32_t type_token_id
		i32 497; uint32_t java_map_index
	}, ; 98
	%struct.TypeMapModuleEntry {
		i32 u0x02000261, ; uint32_t type_token_id
		i32 1012; uint32_t java_map_index
	}, ; 99
	%struct.TypeMapModuleEntry {
		i32 u0x02000264, ; uint32_t type_token_id
		i32 165; uint32_t java_map_index
	}, ; 100
	%struct.TypeMapModuleEntry {
		i32 u0x02000266, ; uint32_t type_token_id
		i32 957; uint32_t java_map_index
	}, ; 101
	%struct.TypeMapModuleEntry {
		i32 u0x02000268, ; uint32_t type_token_id
		i32 463; uint32_t java_map_index
	}, ; 102
	%struct.TypeMapModuleEntry {
		i32 u0x0200026a, ; uint32_t type_token_id
		i32 716; uint32_t java_map_index
	}, ; 103
	%struct.TypeMapModuleEntry {
		i32 u0x0200026c, ; uint32_t type_token_id
		i32 301; uint32_t java_map_index
	}, ; 104
	%struct.TypeMapModuleEntry {
		i32 u0x0200026e, ; uint32_t type_token_id
		i32 959; uint32_t java_map_index
	}, ; 105
	%struct.TypeMapModuleEntry {
		i32 u0x02000270, ; uint32_t type_token_id
		i32 132; uint32_t java_map_index
	}, ; 106
	%struct.TypeMapModuleEntry {
		i32 u0x02000273, ; uint32_t type_token_id
		i32 118; uint32_t java_map_index
	}, ; 107
	%struct.TypeMapModuleEntry {
		i32 u0x02000274, ; uint32_t type_token_id
		i32 89; uint32_t java_map_index
	}, ; 108
	%struct.TypeMapModuleEntry {
		i32 u0x02000276, ; uint32_t type_token_id
		i32 420; uint32_t java_map_index
	}, ; 109
	%struct.TypeMapModuleEntry {
		i32 u0x0200027d, ; uint32_t type_token_id
		i32 261; uint32_t java_map_index
	}, ; 110
	%struct.TypeMapModuleEntry {
		i32 u0x02000287, ; uint32_t type_token_id
		i32 33; uint32_t java_map_index
	}, ; 111
	%struct.TypeMapModuleEntry {
		i32 u0x0200028b, ; uint32_t type_token_id
		i32 577; uint32_t java_map_index
	}, ; 112
	%struct.TypeMapModuleEntry {
		i32 u0x0200029a, ; uint32_t type_token_id
		i32 646; uint32_t java_map_index
	}, ; 113
	%struct.TypeMapModuleEntry {
		i32 u0x020002a3, ; uint32_t type_token_id
		i32 306; uint32_t java_map_index
	}, ; 114
	%struct.TypeMapModuleEntry {
		i32 u0x020002a7, ; uint32_t type_token_id
		i32 1104; uint32_t java_map_index
	}, ; 115
	%struct.TypeMapModuleEntry {
		i32 u0x020002a8, ; uint32_t type_token_id
		i32 913; uint32_t java_map_index
	}, ; 116
	%struct.TypeMapModuleEntry {
		i32 u0x020002b0, ; uint32_t type_token_id
		i32 295; uint32_t java_map_index
	}, ; 117
	%struct.TypeMapModuleEntry {
		i32 u0x020002b4, ; uint32_t type_token_id
		i32 268; uint32_t java_map_index
	}, ; 118
	%struct.TypeMapModuleEntry {
		i32 u0x020002bc, ; uint32_t type_token_id
		i32 121; uint32_t java_map_index
	}, ; 119
	%struct.TypeMapModuleEntry {
		i32 u0x020002c0, ; uint32_t type_token_id
		i32 332; uint32_t java_map_index
	}, ; 120
	%struct.TypeMapModuleEntry {
		i32 u0x020002c3, ; uint32_t type_token_id
		i32 870; uint32_t java_map_index
	}, ; 121
	%struct.TypeMapModuleEntry {
		i32 u0x020002cf, ; uint32_t type_token_id
		i32 1130; uint32_t java_map_index
	}, ; 122
	%struct.TypeMapModuleEntry {
		i32 u0x020002d2, ; uint32_t type_token_id
		i32 284; uint32_t java_map_index
	}, ; 123
	%struct.TypeMapModuleEntry {
		i32 u0x020002d8, ; uint32_t type_token_id
		i32 735; uint32_t java_map_index
	}, ; 124
	%struct.TypeMapModuleEntry {
		i32 u0x020002e0, ; uint32_t type_token_id
		i32 277; uint32_t java_map_index
	}, ; 125
	%struct.TypeMapModuleEntry {
		i32 u0x02000303, ; uint32_t type_token_id
		i32 1000; uint32_t java_map_index
	}, ; 126
	%struct.TypeMapModuleEntry {
		i32 u0x02000309, ; uint32_t type_token_id
		i32 59; uint32_t java_map_index
	}, ; 127
	%struct.TypeMapModuleEntry {
		i32 u0x0200030e, ; uint32_t type_token_id
		i32 615; uint32_t java_map_index
	}, ; 128
	%struct.TypeMapModuleEntry {
		i32 u0x02000312, ; uint32_t type_token_id
		i32 1257; uint32_t java_map_index
	}, ; 129
	%struct.TypeMapModuleEntry {
		i32 u0x02000334, ; uint32_t type_token_id
		i32 375; uint32_t java_map_index
	}, ; 130
	%struct.TypeMapModuleEntry {
		i32 u0x02000369, ; uint32_t type_token_id
		i32 76; uint32_t java_map_index
	}, ; 131
	%struct.TypeMapModuleEntry {
		i32 u0x02000370, ; uint32_t type_token_id
		i32 583; uint32_t java_map_index
	}, ; 132
	%struct.TypeMapModuleEntry {
		i32 u0x02000372, ; uint32_t type_token_id
		i32 552; uint32_t java_map_index
	}, ; 133
	%struct.TypeMapModuleEntry {
		i32 u0x02000377, ; uint32_t type_token_id
		i32 655; uint32_t java_map_index
	}, ; 134
	%struct.TypeMapModuleEntry {
		i32 u0x0200037d, ; uint32_t type_token_id
		i32 492; uint32_t java_map_index
	}, ; 135
	%struct.TypeMapModuleEntry {
		i32 u0x02000383, ; uint32_t type_token_id
		i32 1065; uint32_t java_map_index
	}, ; 136
	%struct.TypeMapModuleEntry {
		i32 u0x0200038c, ; uint32_t type_token_id
		i32 472; uint32_t java_map_index
	}, ; 137
	%struct.TypeMapModuleEntry {
		i32 u0x02000391, ; uint32_t type_token_id
		i32 623; uint32_t java_map_index
	}, ; 138
	%struct.TypeMapModuleEntry {
		i32 u0x02000393, ; uint32_t type_token_id
		i32 1070; uint32_t java_map_index
	}, ; 139
	%struct.TypeMapModuleEntry {
		i32 u0x02000394, ; uint32_t type_token_id
		i32 588; uint32_t java_map_index
	}, ; 140
	%struct.TypeMapModuleEntry {
		i32 u0x02000398, ; uint32_t type_token_id
		i32 54; uint32_t java_map_index
	}, ; 141
	%struct.TypeMapModuleEntry {
		i32 u0x0200039b, ; uint32_t type_token_id
		i32 254; uint32_t java_map_index
	}, ; 142
	%struct.TypeMapModuleEntry {
		i32 u0x0200039f, ; uint32_t type_token_id
		i32 62; uint32_t java_map_index
	}, ; 143
	%struct.TypeMapModuleEntry {
		i32 u0x020003a2, ; uint32_t type_token_id
		i32 1084; uint32_t java_map_index
	}, ; 144
	%struct.TypeMapModuleEntry {
		i32 u0x020003a4, ; uint32_t type_token_id
		i32 1145; uint32_t java_map_index
	}, ; 145
	%struct.TypeMapModuleEntry {
		i32 u0x020003a7, ; uint32_t type_token_id
		i32 887; uint32_t java_map_index
	}, ; 146
	%struct.TypeMapModuleEntry {
		i32 u0x020003aa, ; uint32_t type_token_id
		i32 359; uint32_t java_map_index
	}, ; 147
	%struct.TypeMapModuleEntry {
		i32 u0x020003ae, ; uint32_t type_token_id
		i32 256; uint32_t java_map_index
	}, ; 148
	%struct.TypeMapModuleEntry {
		i32 u0x020003b0, ; uint32_t type_token_id
		i32 1174; uint32_t java_map_index
	}, ; 149
	%struct.TypeMapModuleEntry {
		i32 u0x020003b2, ; uint32_t type_token_id
		i32 829; uint32_t java_map_index
	}, ; 150
	%struct.TypeMapModuleEntry {
		i32 u0x020003c6, ; uint32_t type_token_id
		i32 751; uint32_t java_map_index
	}, ; 151
	%struct.TypeMapModuleEntry {
		i32 u0x020003d8, ; uint32_t type_token_id
		i32 559; uint32_t java_map_index
	}, ; 152
	%struct.TypeMapModuleEntry {
		i32 u0x020003dc, ; uint32_t type_token_id
		i32 257; uint32_t java_map_index
	}, ; 153
	%struct.TypeMapModuleEntry {
		i32 u0x020003eb, ; uint32_t type_token_id
		i32 683; uint32_t java_map_index
	}, ; 154
	%struct.TypeMapModuleEntry {
		i32 u0x020003ef, ; uint32_t type_token_id
		i32 43; uint32_t java_map_index
	}, ; 155
	%struct.TypeMapModuleEntry {
		i32 u0x020003f5, ; uint32_t type_token_id
		i32 911; uint32_t java_map_index
	}, ; 156
	%struct.TypeMapModuleEntry {
		i32 u0x020003f9, ; uint32_t type_token_id
		i32 152; uint32_t java_map_index
	}, ; 157
	%struct.TypeMapModuleEntry {
		i32 u0x020003fb, ; uint32_t type_token_id
		i32 212; uint32_t java_map_index
	}, ; 158
	%struct.TypeMapModuleEntry {
		i32 u0x020003ff, ; uint32_t type_token_id
		i32 856; uint32_t java_map_index
	}, ; 159
	%struct.TypeMapModuleEntry {
		i32 u0x02000405, ; uint32_t type_token_id
		i32 836; uint32_t java_map_index
	}, ; 160
	%struct.TypeMapModuleEntry {
		i32 u0x0200040b, ; uint32_t type_token_id
		i32 313; uint32_t java_map_index
	}, ; 161
	%struct.TypeMapModuleEntry {
		i32 u0x0200040e, ; uint32_t type_token_id
		i32 633; uint32_t java_map_index
	}, ; 162
	%struct.TypeMapModuleEntry {
		i32 u0x02000410, ; uint32_t type_token_id
		i32 246; uint32_t java_map_index
	}, ; 163
	%struct.TypeMapModuleEntry {
		i32 u0x02000412, ; uint32_t type_token_id
		i32 1278; uint32_t java_map_index
	}, ; 164
	%struct.TypeMapModuleEntry {
		i32 u0x02000418, ; uint32_t type_token_id
		i32 283; uint32_t java_map_index
	}, ; 165
	%struct.TypeMapModuleEntry {
		i32 u0x0200041a, ; uint32_t type_token_id
		i32 610; uint32_t java_map_index
	}, ; 166
	%struct.TypeMapModuleEntry {
		i32 u0x0200041c, ; uint32_t type_token_id
		i32 1239; uint32_t java_map_index
	}, ; 167
	%struct.TypeMapModuleEntry {
		i32 u0x0200041e, ; uint32_t type_token_id
		i32 91; uint32_t java_map_index
	}, ; 168
	%struct.TypeMapModuleEntry {
		i32 u0x02000421, ; uint32_t type_token_id
		i32 87; uint32_t java_map_index
	}, ; 169
	%struct.TypeMapModuleEntry {
		i32 u0x02000423, ; uint32_t type_token_id
		i32 840; uint32_t java_map_index
	}, ; 170
	%struct.TypeMapModuleEntry {
		i32 u0x02000425, ; uint32_t type_token_id
		i32 393; uint32_t java_map_index
	}, ; 171
	%struct.TypeMapModuleEntry {
		i32 u0x02000427, ; uint32_t type_token_id
		i32 1001; uint32_t java_map_index
	}, ; 172
	%struct.TypeMapModuleEntry {
		i32 u0x02000429, ; uint32_t type_token_id
		i32 1106; uint32_t java_map_index
	}, ; 173
	%struct.TypeMapModuleEntry {
		i32 u0x0200042b, ; uint32_t type_token_id
		i32 1175; uint32_t java_map_index
	}, ; 174
	%struct.TypeMapModuleEntry {
		i32 u0x02000431, ; uint32_t type_token_id
		i32 1194; uint32_t java_map_index
	}, ; 175
	%struct.TypeMapModuleEntry {
		i32 u0x02000433, ; uint32_t type_token_id
		i32 671; uint32_t java_map_index
	}, ; 176
	%struct.TypeMapModuleEntry {
		i32 u0x02000437, ; uint32_t type_token_id
		i32 468; uint32_t java_map_index
	}, ; 177
	%struct.TypeMapModuleEntry {
		i32 u0x02000439, ; uint32_t type_token_id
		i32 828; uint32_t java_map_index
	}, ; 178
	%struct.TypeMapModuleEntry {
		i32 u0x0200043d, ; uint32_t type_token_id
		i32 1049; uint32_t java_map_index
	}, ; 179
	%struct.TypeMapModuleEntry {
		i32 u0x02000440, ; uint32_t type_token_id
		i32 341; uint32_t java_map_index
	}, ; 180
	%struct.TypeMapModuleEntry {
		i32 u0x02000442, ; uint32_t type_token_id
		i32 1000; uint32_t java_map_index
	}, ; 181
	%struct.TypeMapModuleEntry {
		i32 u0x02000443, ; uint32_t type_token_id
		i32 1000; uint32_t java_map_index
	}, ; 182
	%struct.TypeMapModuleEntry {
		i32 u0x02000445, ; uint32_t type_token_id
		i32 466; uint32_t java_map_index
	}, ; 183
	%struct.TypeMapModuleEntry {
		i32 u0x02000447, ; uint32_t type_token_id
		i32 1179; uint32_t java_map_index
	}, ; 184
	%struct.TypeMapModuleEntry {
		i32 u0x02000449, ; uint32_t type_token_id
		i32 555; uint32_t java_map_index
	}, ; 185
	%struct.TypeMapModuleEntry {
		i32 u0x0200044a, ; uint32_t type_token_id
		i32 115; uint32_t java_map_index
	}, ; 186
	%struct.TypeMapModuleEntry {
		i32 u0x0200044c, ; uint32_t type_token_id
		i32 9; uint32_t java_map_index
	}, ; 187
	%struct.TypeMapModuleEntry {
		i32 u0x0200044e, ; uint32_t type_token_id
		i32 682; uint32_t java_map_index
	}, ; 188
	%struct.TypeMapModuleEntry {
		i32 u0x02000450, ; uint32_t type_token_id
		i32 566; uint32_t java_map_index
	}, ; 189
	%struct.TypeMapModuleEntry {
		i32 u0x02000452, ; uint32_t type_token_id
		i32 985; uint32_t java_map_index
	}, ; 190
	%struct.TypeMapModuleEntry {
		i32 u0x02000458, ; uint32_t type_token_id
		i32 17; uint32_t java_map_index
	}, ; 191
	%struct.TypeMapModuleEntry {
		i32 u0x0200045a, ; uint32_t type_token_id
		i32 1096; uint32_t java_map_index
	}, ; 192
	%struct.TypeMapModuleEntry {
		i32 u0x0200045c, ; uint32_t type_token_id
		i32 688; uint32_t java_map_index
	}, ; 193
	%struct.TypeMapModuleEntry {
		i32 u0x0200045e, ; uint32_t type_token_id
		i32 1120; uint32_t java_map_index
	}, ; 194
	%struct.TypeMapModuleEntry {
		i32 u0x02000460, ; uint32_t type_token_id
		i32 40; uint32_t java_map_index
	}, ; 195
	%struct.TypeMapModuleEntry {
		i32 u0x02000462, ; uint32_t type_token_id
		i32 769; uint32_t java_map_index
	}, ; 196
	%struct.TypeMapModuleEntry {
		i32 u0x02000464, ; uint32_t type_token_id
		i32 727; uint32_t java_map_index
	}, ; 197
	%struct.TypeMapModuleEntry {
		i32 u0x02000466, ; uint32_t type_token_id
		i32 159; uint32_t java_map_index
	}, ; 198
	%struct.TypeMapModuleEntry {
		i32 u0x02000468, ; uint32_t type_token_id
		i32 1234; uint32_t java_map_index
	}, ; 199
	%struct.TypeMapModuleEntry {
		i32 u0x0200046a, ; uint32_t type_token_id
		i32 1058; uint32_t java_map_index
	}, ; 200
	%struct.TypeMapModuleEntry {
		i32 u0x0200046d, ; uint32_t type_token_id
		i32 983; uint32_t java_map_index
	}, ; 201
	%struct.TypeMapModuleEntry {
		i32 u0x0200046f, ; uint32_t type_token_id
		i32 1119; uint32_t java_map_index
	}, ; 202
	%struct.TypeMapModuleEntry {
		i32 u0x02000471, ; uint32_t type_token_id
		i32 1220; uint32_t java_map_index
	}, ; 203
	%struct.TypeMapModuleEntry {
		i32 u0x02000473, ; uint32_t type_token_id
		i32 312; uint32_t java_map_index
	}, ; 204
	%struct.TypeMapModuleEntry {
		i32 u0x0200048e, ; uint32_t type_token_id
		i32 260; uint32_t java_map_index
	}, ; 205
	%struct.TypeMapModuleEntry {
		i32 u0x02000490, ; uint32_t type_token_id
		i32 963; uint32_t java_map_index
	}, ; 206
	%struct.TypeMapModuleEntry {
		i32 u0x02000493, ; uint32_t type_token_id
		i32 565; uint32_t java_map_index
	}, ; 207
	%struct.TypeMapModuleEntry {
		i32 u0x02000495, ; uint32_t type_token_id
		i32 976; uint32_t java_map_index
	}, ; 208
	%struct.TypeMapModuleEntry {
		i32 u0x02000496, ; uint32_t type_token_id
		i32 659; uint32_t java_map_index
	}, ; 209
	%struct.TypeMapModuleEntry {
		i32 u0x02000499, ; uint32_t type_token_id
		i32 440; uint32_t java_map_index
	}, ; 210
	%struct.TypeMapModuleEntry {
		i32 u0x0200049b, ; uint32_t type_token_id
		i32 487; uint32_t java_map_index
	}, ; 211
	%struct.TypeMapModuleEntry {
		i32 u0x020004a0, ; uint32_t type_token_id
		i32 1265; uint32_t java_map_index
	}, ; 212
	%struct.TypeMapModuleEntry {
		i32 u0x020004a6, ; uint32_t type_token_id
		i32 395; uint32_t java_map_index
	}, ; 213
	%struct.TypeMapModuleEntry {
		i32 u0x020004ad, ; uint32_t type_token_id
		i32 1202; uint32_t java_map_index
	} ; 214
], align 4

@module37_managed_to_java = internal dso_local constant [17 x %struct.TypeMapModuleEntry] [
	%struct.TypeMapModuleEntry {
		i32 u0x0200000e, ; uint32_t type_token_id
		i32 543; uint32_t java_map_index
	}, ; 0
	%struct.TypeMapModuleEntry {
		i32 u0x02000010, ; uint32_t type_token_id
		i32 1158; uint32_t java_map_index
	}, ; 1
	%struct.TypeMapModuleEntry {
		i32 u0x02000012, ; uint32_t type_token_id
		i32 950; uint32_t java_map_index
	}, ; 2
	%struct.TypeMapModuleEntry {
		i32 u0x02000013, ; uint32_t type_token_id
		i32 290; uint32_t java_map_index
	}, ; 3
	%struct.TypeMapModuleEntry {
		i32 u0x02000014, ; uint32_t type_token_id
		i32 860; uint32_t java_map_index
	}, ; 4
	%struct.TypeMapModuleEntry {
		i32 u0x02000015, ; uint32_t type_token_id
		i32 193; uint32_t java_map_index
	}, ; 5
	%struct.TypeMapModuleEntry {
		i32 u0x02000016, ; uint32_t type_token_id
		i32 758; uint32_t java_map_index
	}, ; 6
	%struct.TypeMapModuleEntry {
		i32 u0x02000017, ; uint32_t type_token_id
		i32 403; uint32_t java_map_index
	}, ; 7
	%struct.TypeMapModuleEntry {
		i32 u0x02000018, ; uint32_t type_token_id
		i32 921; uint32_t java_map_index
	}, ; 8
	%struct.TypeMapModuleEntry {
		i32 u0x02000019, ; uint32_t type_token_id
		i32 534; uint32_t java_map_index
	}, ; 9
	%struct.TypeMapModuleEntry {
		i32 u0x0200001a, ; uint32_t type_token_id
		i32 835; uint32_t java_map_index
	}, ; 10
	%struct.TypeMapModuleEntry {
		i32 u0x0200001b, ; uint32_t type_token_id
		i32 797; uint32_t java_map_index
	}, ; 11
	%struct.TypeMapModuleEntry {
		i32 u0x0200001c, ; uint32_t type_token_id
		i32 765; uint32_t java_map_index
	}, ; 12
	%struct.TypeMapModuleEntry {
		i32 u0x0200001f, ; uint32_t type_token_id
		i32 1051; uint32_t java_map_index
	}, ; 13
	%struct.TypeMapModuleEntry {
		i32 u0x02000020, ; uint32_t type_token_id
		i32 878; uint32_t java_map_index
	}, ; 14
	%struct.TypeMapModuleEntry {
		i32 u0x02000022, ; uint32_t type_token_id
		i32 1045; uint32_t java_map_index
	}, ; 15
	%struct.TypeMapModuleEntry {
		i32 u0x02000023, ; uint32_t type_token_id
		i32 214; uint32_t java_map_index
	} ; 16
], align 4

@module37_managed_to_java_duplicates = internal dso_local constant [6 x %struct.TypeMapModuleEntry] [
	%struct.TypeMapModuleEntry {
		i32 u0x0200000f, ; uint32_t type_token_id
		i32 543; uint32_t java_map_index
	}, ; 0
	%struct.TypeMapModuleEntry {
		i32 u0x02000011, ; uint32_t type_token_id
		i32 1158; uint32_t java_map_index
	}, ; 1
	%struct.TypeMapModuleEntry {
		i32 u0x0200001d, ; uint32_t type_token_id
		i32 765; uint32_t java_map_index
	}, ; 2
	%struct.TypeMapModuleEntry {
		i32 u0x0200001e, ; uint32_t type_token_id
		i32 797; uint32_t java_map_index
	}, ; 3
	%struct.TypeMapModuleEntry {
		i32 u0x02000021, ; uint32_t type_token_id
		i32 878; uint32_t java_map_index
	}, ; 4
	%struct.TypeMapModuleEntry {
		i32 u0x02000024, ; uint32_t type_token_id
		i32 214; uint32_t java_map_index
	} ; 5
], align 4

@module38_managed_to_java = internal dso_local constant [20 x %struct.TypeMapModuleEntry] [
	%struct.TypeMapModuleEntry {
		i32 u0x02000023, ; uint32_t type_token_id
		i32 1173; uint32_t java_map_index
	}, ; 0
	%struct.TypeMapModuleEntry {
		i32 u0x02000024, ; uint32_t type_token_id
		i32 1006; uint32_t java_map_index
	}, ; 1
	%struct.TypeMapModuleEntry {
		i32 u0x02000025, ; uint32_t type_token_id
		i32 353; uint32_t java_map_index
	}, ; 2
	%struct.TypeMapModuleEntry {
		i32 u0x02000026, ; uint32_t type_token_id
		i32 453; uint32_t java_map_index
	}, ; 3
	%struct.TypeMapModuleEntry {
		i32 u0x02000027, ; uint32_t type_token_id
		i32 778; uint32_t java_map_index
	}, ; 4
	%struct.TypeMapModuleEntry {
		i32 u0x02000029, ; uint32_t type_token_id
		i32 524; uint32_t java_map_index
	}, ; 5
	%struct.TypeMapModuleEntry {
		i32 u0x0200002a, ; uint32_t type_token_id
		i32 1102; uint32_t java_map_index
	}, ; 6
	%struct.TypeMapModuleEntry {
		i32 u0x0200002b, ; uint32_t type_token_id
		i32 275; uint32_t java_map_index
	}, ; 7
	%struct.TypeMapModuleEntry {
		i32 u0x0200002d, ; uint32_t type_token_id
		i32 325; uint32_t java_map_index
	}, ; 8
	%struct.TypeMapModuleEntry {
		i32 u0x0200002e, ; uint32_t type_token_id
		i32 392; uint32_t java_map_index
	}, ; 9
	%struct.TypeMapModuleEntry {
		i32 u0x02000030, ; uint32_t type_token_id
		i32 1019; uint32_t java_map_index
	}, ; 10
	%struct.TypeMapModuleEntry {
		i32 u0x02000032, ; uint32_t type_token_id
		i32 793; uint32_t java_map_index
	}, ; 11
	%struct.TypeMapModuleEntry {
		i32 u0x02000037, ; uint32_t type_token_id
		i32 561; uint32_t java_map_index
	}, ; 12
	%struct.TypeMapModuleEntry {
		i32 u0x02000046, ; uint32_t type_token_id
		i32 310; uint32_t java_map_index
	}, ; 13
	%struct.TypeMapModuleEntry {
		i32 u0x02000048, ; uint32_t type_token_id
		i32 361; uint32_t java_map_index
	}, ; 14
	%struct.TypeMapModuleEntry {
		i32 u0x0200004b, ; uint32_t type_token_id
		i32 667; uint32_t java_map_index
	}, ; 15
	%struct.TypeMapModuleEntry {
		i32 u0x0200004c, ; uint32_t type_token_id
		i32 1063; uint32_t java_map_index
	}, ; 16
	%struct.TypeMapModuleEntry {
		i32 u0x0200004e, ; uint32_t type_token_id
		i32 1223; uint32_t java_map_index
	}, ; 17
	%struct.TypeMapModuleEntry {
		i32 u0x0200004f, ; uint32_t type_token_id
		i32 405; uint32_t java_map_index
	}, ; 18
	%struct.TypeMapModuleEntry {
		i32 u0x02000050, ; uint32_t type_token_id
		i32 962; uint32_t java_map_index
	} ; 19
], align 4

@module38_managed_to_java_duplicates = internal dso_local constant [10 x %struct.TypeMapModuleEntry] [
	%struct.TypeMapModuleEntry {
		i32 u0x02000028, ; uint32_t type_token_id
		i32 778; uint32_t java_map_index
	}, ; 0
	%struct.TypeMapModuleEntry {
		i32 u0x0200002c, ; uint32_t type_token_id
		i32 275; uint32_t java_map_index
	}, ; 1
	%struct.TypeMapModuleEntry {
		i32 u0x0200002f, ; uint32_t type_token_id
		i32 392; uint32_t java_map_index
	}, ; 2
	%struct.TypeMapModuleEntry {
		i32 u0x02000031, ; uint32_t type_token_id
		i32 1019; uint32_t java_map_index
	}, ; 3
	%struct.TypeMapModuleEntry {
		i32 u0x02000033, ; uint32_t type_token_id
		i32 793; uint32_t java_map_index
	}, ; 4
	%struct.TypeMapModuleEntry {
		i32 u0x02000045, ; uint32_t type_token_id
		i32 325; uint32_t java_map_index
	}, ; 5
	%struct.TypeMapModuleEntry {
		i32 u0x02000047, ; uint32_t type_token_id
		i32 310; uint32_t java_map_index
	}, ; 6
	%struct.TypeMapModuleEntry {
		i32 u0x02000049, ; uint32_t type_token_id
		i32 361; uint32_t java_map_index
	}, ; 7
	%struct.TypeMapModuleEntry {
		i32 u0x0200004d, ; uint32_t type_token_id
		i32 1063; uint32_t java_map_index
	}, ; 8
	%struct.TypeMapModuleEntry {
		i32 u0x02000051, ; uint32_t type_token_id
		i32 962; uint32_t java_map_index
	} ; 9
], align 4

@module39_managed_to_java = internal dso_local constant [2 x %struct.TypeMapModuleEntry] [
	%struct.TypeMapModuleEntry {
		i32 u0x02000008, ; uint32_t type_token_id
		i32 980; uint32_t java_map_index
	}, ; 0
	%struct.TypeMapModuleEntry {
		i32 u0x02000009, ; uint32_t type_token_id
		i32 370; uint32_t java_map_index
	} ; 1
], align 4

@module40_managed_to_java = internal dso_local constant [1 x %struct.TypeMapModuleEntry] [
	%struct.TypeMapModuleEntry {
		i32 u0x02000012, ; uint32_t type_token_id
		i32 264; uint32_t java_map_index
	} ; 0
], align 4

@module41_managed_to_java = internal dso_local constant [4 x %struct.TypeMapModuleEntry] [
	%struct.TypeMapModuleEntry {
		i32 u0x02000018, ; uint32_t type_token_id
		i32 815; uint32_t java_map_index
	}, ; 0
	%struct.TypeMapModuleEntry {
		i32 u0x02000019, ; uint32_t type_token_id
		i32 1172; uint32_t java_map_index
	}, ; 1
	%struct.TypeMapModuleEntry {
		i32 u0x0200001b, ; uint32_t type_token_id
		i32 821; uint32_t java_map_index
	}, ; 2
	%struct.TypeMapModuleEntry {
		i32 u0x0200001d, ; uint32_t type_token_id
		i32 662; uint32_t java_map_index
	} ; 3
], align 4

@module41_managed_to_java_duplicates = internal dso_local constant [2 x %struct.TypeMapModuleEntry] [
	%struct.TypeMapModuleEntry {
		i32 u0x0200001a, ; uint32_t type_token_id
		i32 1172; uint32_t java_map_index
	}, ; 0
	%struct.TypeMapModuleEntry {
		i32 u0x0200001c, ; uint32_t type_token_id
		i32 821; uint32_t java_map_index
	} ; 1
], align 4

@module42_managed_to_java = internal dso_local constant [1 x %struct.TypeMapModuleEntry] [
	%struct.TypeMapModuleEntry {
		i32 u0x0200000b, ; uint32_t type_token_id
		i32 1157; uint32_t java_map_index
	} ; 0
], align 4

; Java to managed map
@map_java = dso_local local_unnamed_addr constant [1283 x %struct.TypeMapJava] [
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 63; uint32_t java_name_index
	}, ; 0
	%struct.TypeMapJava {
		i32 14, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 776; uint32_t java_name_index
	}, ; 1
	%struct.TypeMapJava {
		i32 14, ; uint32_t module_index
		i32 u0x020000a0, ; uint32_t type_token_id
		i32 790; uint32_t java_name_index
	}, ; 2
	%struct.TypeMapJava {
		i32 32, ; uint32_t module_index
		i32 u0x02000011, ; uint32_t type_token_id
		i32 1097; uint32_t java_name_index
	}, ; 3
	%struct.TypeMapJava {
		i32 21, ; uint32_t module_index
		i32 u0x020000a2, ; uint32_t type_token_id
		i32 975; uint32_t java_name_index
	}, ; 4
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020000ca, ; uint32_t type_token_id
		i32 12; uint32_t java_name_index
	}, ; 5
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000120, ; uint32_t type_token_id
		i32 69; uint32_t java_name_index
	}, ; 6
	%struct.TypeMapJava {
		i32 14, ; uint32_t module_index
		i32 u0x02000072, ; uint32_t type_token_id
		i32 771; uint32_t java_name_index
	}, ; 7
	%struct.TypeMapJava {
		i32 14, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 785; uint32_t java_name_index
	}, ; 8
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 509; uint32_t java_name_index
	}, ; 9
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000477, ; uint32_t type_token_id
		i32 534; uint32_t java_name_index
	}, ; 10
	%struct.TypeMapJava {
		i32 34, ; uint32_t module_index
		i32 u0x020003ce, ; uint32_t type_token_id
		i32 1170; uint32_t java_name_index
	}, ; 11
	%struct.TypeMapJava {
		i32 34, ; uint32_t module_index
		i32 u0x0200039c, ; uint32_t type_token_id
		i32 1139; uint32_t java_name_index
	}, ; 12
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000103, ; uint32_t type_token_id
		i32 52; uint32_t java_name_index
	}, ; 13
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000298, ; uint32_t type_token_id
		i32 266; uint32_t java_name_index
	}, ; 14
	%struct.TypeMapJava {
		i32 11, ; uint32_t module_index
		i32 u0x02000018, ; uint32_t type_token_id
		i32 726; uint32_t java_name_index
	}, ; 15
	%struct.TypeMapJava {
		i32 19, ; uint32_t module_index
		i32 u0x0200001f, ; uint32_t type_token_id
		i32 911; uint32_t java_name_index
	}, ; 16
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000457, ; uint32_t type_token_id
		i32 516; uint32_t java_name_index
	}, ; 17
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020000cb, ; uint32_t type_token_id
		i32 13; uint32_t java_name_index
	}, ; 18
	%struct.TypeMapJava {
		i32 14, ; uint32_t module_index
		i32 u0x020000b8, ; uint32_t type_token_id
		i32 805; uint32_t java_name_index
	}, ; 19
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020001ad, ; uint32_t type_token_id
		i32 147; uint32_t java_name_index
	}, ; 20
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020004ae, ; uint32_t type_token_id
		i32 577; uint32_t java_name_index
	}, ; 21
	%struct.TypeMapJava {
		i32 25, ; uint32_t module_index
		i32 u0x0200007f, ; uint32_t type_token_id
		i32 1045; uint32_t java_name_index
	}, ; 22
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 208; uint32_t java_name_index
	}, ; 23
	%struct.TypeMapJava {
		i32 2, ; uint32_t module_index
		i32 u0x02000009, ; uint32_t type_token_id
		i32 596; uint32_t java_name_index
	}, ; 24
	%struct.TypeMapJava {
		i32 8, ; uint32_t module_index
		i32 u0x02000323, ; uint32_t type_token_id
		i32 704; uint32_t java_name_index
	}, ; 25
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020003bd, ; uint32_t type_token_id
		i32 427; uint32_t java_name_index
	}, ; 26
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000400, ; uint32_t type_token_id
		i32 461; uint32_t java_name_index
	}, ; 27
	%struct.TypeMapJava {
		i32 25, ; uint32_t module_index
		i32 u0x02000069, ; uint32_t type_token_id
		i32 1032; uint32_t java_name_index
	}, ; 28
	%struct.TypeMapJava {
		i32 18, ; uint32_t module_index
		i32 u0x02000065, ; uint32_t type_token_id
		i32 876; uint32_t java_name_index
	}, ; 29
	%struct.TypeMapJava {
		i32 25, ; uint32_t module_index
		i32 u0x020000a6, ; uint32_t type_token_id
		i32 1061; uint32_t java_name_index
	}, ; 30
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000454, ; uint32_t type_token_id
		i32 514; uint32_t java_name_index
	}, ; 31
	%struct.TypeMapJava {
		i32 30, ; uint32_t module_index
		i32 u0x02000007, ; uint32_t type_token_id
		i32 1083; uint32_t java_name_index
	}, ; 32
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000286, ; uint32_t type_token_id
		i32 257; uint32_t java_name_index
	}, ; 33
	%struct.TypeMapJava {
		i32 21, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 955; uint32_t java_name_index
	}, ; 34
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020003a8, ; uint32_t type_token_id
		i32 413; uint32_t java_name_index
	}, ; 35
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020001ca, ; uint32_t type_token_id
		i32 166; uint32_t java_name_index
	}, ; 36
	%struct.TypeMapJava {
		i32 14, ; uint32_t module_index
		i32 u0x020000aa, ; uint32_t type_token_id
		i32 797; uint32_t java_name_index
	}, ; 37
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020002b8, ; uint32_t type_token_id
		i32 280; uint32_t java_name_index
	}, ; 38
	%struct.TypeMapJava {
		i32 34, ; uint32_t module_index
		i32 u0x02000380, ; uint32_t type_token_id
		i32 1122; uint32_t java_name_index
	}, ; 39
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 520; uint32_t java_name_index
	}, ; 40
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020001f1, ; uint32_t type_token_id
		i32 194; uint32_t java_name_index
	}, ; 41
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020001d7, ; uint32_t type_token_id
		i32 178; uint32_t java_name_index
	}, ; 42
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020003d1, ; uint32_t type_token_id
		i32 436; uint32_t java_name_index
	}, ; 43
	%struct.TypeMapJava {
		i32 34, ; uint32_t module_index
		i32 u0x020003f2, ; uint32_t type_token_id
		i32 1195; uint32_t java_name_index
	}, ; 44
	%struct.TypeMapJava {
		i32 8, ; uint32_t module_index
		i32 u0x02000158, ; uint32_t type_token_id
		i32 680; uint32_t java_name_index
	}, ; 45
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 90; uint32_t java_name_index
	}, ; 46
	%struct.TypeMapJava {
		i32 32, ; uint32_t module_index
		i32 u0x0200000f, ; uint32_t type_token_id
		i32 1089; uint32_t java_name_index
	}, ; 47
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020000f2, ; uint32_t type_token_id
		i32 38; uint32_t java_name_index
	}, ; 48
	%struct.TypeMapJava {
		i32 18, ; uint32_t module_index
		i32 u0x02000088, ; uint32_t type_token_id
		i32 895; uint32_t java_name_index
	}, ; 49
	%struct.TypeMapJava {
		i32 8, ; uint32_t module_index
		i32 u0x020002cc, ; uint32_t type_token_id
		i32 696; uint32_t java_name_index
	}, ; 50
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020001d1, ; uint32_t type_token_id
		i32 173; uint32_t java_name_index
	}, ; 51
	%struct.TypeMapJava {
		i32 32, ; uint32_t module_index
		i32 u0x02000017, ; uint32_t type_token_id
		i32 1093; uint32_t java_name_index
	}, ; 52
	%struct.TypeMapJava {
		i32 13, ; uint32_t module_index
		i32 u0x02000014, ; uint32_t type_token_id
		i32 742; uint32_t java_name_index
	}, ; 53
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 404; uint32_t java_name_index
	}, ; 54
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000146, ; uint32_t type_token_id
		i32 87; uint32_t java_name_index
	}, ; 55
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x0200030f, ; uint32_t type_token_id
		i32 314; uint32_t java_name_index
	}, ; 56
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 128; uint32_t java_name_index
	}, ; 57
	%struct.TypeMapJava {
		i32 14, ; uint32_t module_index
		i32 u0x020000be, ; uint32_t type_token_id
		i32 806; uint32_t java_name_index
	}, ; 58
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000304, ; uint32_t type_token_id
		i32 312; uint32_t java_name_index
	}, ; 59
	%struct.TypeMapJava {
		i32 34, ; uint32_t module_index
		i32 u0x020003cd, ; uint32_t type_token_id
		i32 1169; uint32_t java_name_index
	}, ; 60
	%struct.TypeMapJava {
		i32 14, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 792; uint32_t java_name_index
	}, ; 61
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 408; uint32_t java_name_index
	}, ; 62
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000343, ; uint32_t type_token_id
		i32 339; uint32_t java_name_index
	}, ; 63
	%struct.TypeMapJava {
		i32 3, ; uint32_t module_index
		i32 u0x02000006, ; uint32_t type_token_id
		i32 602; uint32_t java_name_index
	}, ; 64
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000374, ; uint32_t type_token_id
		i32 382; uint32_t java_name_index
	}, ; 65
	%struct.TypeMapJava {
		i32 21, ; uint32_t module_index
		i32 u0x020000a3, ; uint32_t type_token_id
		i32 976; uint32_t java_name_index
	}, ; 66
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000361, ; uint32_t type_token_id
		i32 367; uint32_t java_name_index
	}, ; 67
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000355, ; uint32_t type_token_id
		i32 355; uint32_t java_name_index
	}, ; 68
	%struct.TypeMapJava {
		i32 14, ; uint32_t module_index
		i32 u0x02000087, ; uint32_t type_token_id
		i32 779; uint32_t java_name_index
	}, ; 69
	%struct.TypeMapJava {
		i32 14, ; uint32_t module_index
		i32 u0x020000c3, ; uint32_t type_token_id
		i32 809; uint32_t java_name_index
	}, ; 70
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020001a2, ; uint32_t type_token_id
		i32 138; uint32_t java_name_index
	}, ; 71
	%struct.TypeMapJava {
		i32 22, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 990; uint32_t java_name_index
	}, ; 72
	%struct.TypeMapJava {
		i32 18, ; uint32_t module_index
		i32 u0x02000050, ; uint32_t type_token_id
		i32 861; uint32_t java_name_index
	}, ; 73
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 93; uint32_t java_name_index
	}, ; 74
	%struct.TypeMapJava {
		i32 18, ; uint32_t module_index
		i32 u0x02000055, ; uint32_t type_token_id
		i32 865; uint32_t java_name_index
	}, ; 75
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000368, ; uint32_t type_token_id
		i32 373; uint32_t java_name_index
	}, ; 76
	%struct.TypeMapJava {
		i32 8, ; uint32_t module_index
		i32 u0x02000324, ; uint32_t type_token_id
		i32 705; uint32_t java_name_index
	}, ; 77
	%struct.TypeMapJava {
		i32 34, ; uint32_t module_index
		i32 u0x02000631, ; uint32_t type_token_id
		i32 1198; uint32_t java_name_index
	}, ; 78
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000353, ; uint32_t type_token_id
		i32 353; uint32_t java_name_index
	}, ; 79
	%struct.TypeMapJava {
		i32 21, ; uint32_t module_index
		i32 u0x02000077, ; uint32_t type_token_id
		i32 947; uint32_t java_name_index
	}, ; 80
	%struct.TypeMapJava {
		i32 8, ; uint32_t module_index
		i32 u0x0200015f, ; uint32_t type_token_id
		i32 686; uint32_t java_name_index
	}, ; 81
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000403, ; uint32_t type_token_id
		i32 464; uint32_t java_name_index
	}, ; 82
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020001e7, ; uint32_t type_token_id
		i32 188; uint32_t java_name_index
	}, ; 83
	%struct.TypeMapJava {
		i32 8, ; uint32_t module_index
		i32 u0x020002c3, ; uint32_t type_token_id
		i32 675; uint32_t java_name_index
	}, ; 84
	%struct.TypeMapJava {
		i32 8, ; uint32_t module_index
		i32 u0x02000249, ; uint32_t type_token_id
		i32 713; uint32_t java_name_index
	}, ; 85
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000390, ; uint32_t type_token_id
		i32 401; uint32_t java_name_index
	}, ; 86
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000420, ; uint32_t type_token_id
		i32 484; uint32_t java_name_index
	}, ; 87
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x0200036a, ; uint32_t type_token_id
		i32 374; uint32_t java_name_index
	}, ; 88
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 251; uint32_t java_name_index
	}, ; 89
	%struct.TypeMapJava {
		i32 8, ; uint32_t module_index
		i32 u0x02000327, ; uint32_t type_token_id
		i32 706; uint32_t java_name_index
	}, ; 90
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 482; uint32_t java_name_index
	}, ; 91
	%struct.TypeMapJava {
		i32 34, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 1155; uint32_t java_name_index
	}, ; 92
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000373, ; uint32_t type_token_id
		i32 381; uint32_t java_name_index
	}, ; 93
	%struct.TypeMapJava {
		i32 25, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 1013; uint32_t java_name_index
	}, ; 94
	%struct.TypeMapJava {
		i32 21, ; uint32_t module_index
		i32 u0x02000047, ; uint32_t type_token_id
		i32 918; uint32_t java_name_index
	}, ; 95
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000244, ; uint32_t type_token_id
		i32 230; uint32_t java_name_index
	}, ; 96
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 213; uint32_t java_name_index
	}, ; 97
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020001b8, ; uint32_t type_token_id
		i32 153; uint32_t java_name_index
	}, ; 98
	%struct.TypeMapJava {
		i32 18, ; uint32_t module_index
		i32 u0x0200009a, ; uint32_t type_token_id
		i32 898; uint32_t java_name_index
	}, ; 99
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000249, ; uint32_t type_token_id
		i32 233; uint32_t java_name_index
	}, ; 100
	%struct.TypeMapJava {
		i32 34, ; uint32_t module_index
		i32 u0x020003ef, ; uint32_t type_token_id
		i32 1193; uint32_t java_name_index
	}, ; 101
	%struct.TypeMapJava {
		i32 25, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 1048; uint32_t java_name_index
	}, ; 102
	%struct.TypeMapJava {
		i32 4, ; uint32_t module_index
		i32 u0x02000027, ; uint32_t type_token_id
		i32 609; uint32_t java_name_index
	}, ; 103
	%struct.TypeMapJava {
		i32 31, ; uint32_t module_index
		i32 u0x0200001a, ; uint32_t type_token_id
		i32 1085; uint32_t java_name_index
	}, ; 104
	%struct.TypeMapJava {
		i32 6, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 618; uint32_t java_name_index
	}, ; 105
	%struct.TypeMapJava {
		i32 18, ; uint32_t module_index
		i32 u0x0200007c, ; uint32_t type_token_id
		i32 887; uint32_t java_name_index
	}, ; 106
	%struct.TypeMapJava {
		i32 17, ; uint32_t module_index
		i32 u0x02000182, ; uint32_t type_token_id
		i32 846; uint32_t java_name_index
	}, ; 107
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020000ce, ; uint32_t type_token_id
		i32 15; uint32_t java_name_index
	}, ; 108
	%struct.TypeMapJava {
		i32 6, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 622; uint32_t java_name_index
	}, ; 109
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 190; uint32_t java_name_index
	}, ; 110
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x0200033e, ; uint32_t type_token_id
		i32 334; uint32_t java_name_index
	}, ; 111
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x0200043b, ; uint32_t type_token_id
		i32 501; uint32_t java_name_index
	}, ; 112
	%struct.TypeMapJava {
		i32 17, ; uint32_t module_index
		i32 u0x020000c7, ; uint32_t type_token_id
		i32 830; uint32_t java_name_index
	}, ; 113
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000169, ; uint32_t type_token_id
		i32 108; uint32_t java_name_index
	}, ; 114
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 505; uint32_t java_name_index
	}, ; 115
	%struct.TypeMapJava {
		i32 34, ; uint32_t module_index
		i32 u0x020003d1, ; uint32_t type_token_id
		i32 1173; uint32_t java_name_index
	}, ; 116
	%struct.TypeMapJava {
		i32 21, ; uint32_t module_index
		i32 u0x02000054, ; uint32_t type_token_id
		i32 929; uint32_t java_name_index
	}, ; 117
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 252; uint32_t java_name_index
	}, ; 118
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020001d0, ; uint32_t type_token_id
		i32 172; uint32_t java_name_index
	}, ; 119
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020002c6, ; uint32_t type_token_id
		i32 288; uint32_t java_name_index
	}, ; 120
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020002b2, ; uint32_t type_token_id
		i32 278; uint32_t java_name_index
	}, ; 121
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020003c5, ; uint32_t type_token_id
		i32 431; uint32_t java_name_index
	}, ; 122
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x020002ab, ; uint32_t type_token_id
		i32 594; uint32_t java_name_index
	}, ; 123
	%struct.TypeMapJava {
		i32 34, ; uint32_t module_index
		i32 u0x0200055a, ; uint32_t type_token_id
		i32 1102; uint32_t java_name_index
	}, ; 124
	%struct.TypeMapJava {
		i32 26, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 1063; uint32_t java_name_index
	}, ; 125
	%struct.TypeMapJava {
		i32 12, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 733; uint32_t java_name_index
	}, ; 126
	%struct.TypeMapJava {
		i32 13, ; uint32_t module_index
		i32 u0x0200000b, ; uint32_t type_token_id
		i32 736; uint32_t java_name_index
	}, ; 127
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020002e2, ; uint32_t type_token_id
		i32 306; uint32_t java_name_index
	}, ; 128
	%struct.TypeMapJava {
		i32 34, ; uint32_t module_index
		i32 u0x020003f9, ; uint32_t type_token_id
		i32 1206; uint32_t java_name_index
	}, ; 129
	%struct.TypeMapJava {
		i32 34, ; uint32_t module_index
		i32 u0x02000632, ; uint32_t type_token_id
		i32 1199; uint32_t java_name_index
	}, ; 130
	%struct.TypeMapJava {
		i32 25, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 1058; uint32_t java_name_index
	}, ; 131
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 250; uint32_t java_name_index
	}, ; 132
	%struct.TypeMapJava {
		i32 8, ; uint32_t module_index
		i32 u0x02000117, ; uint32_t type_token_id
		i32 649; uint32_t java_name_index
	}, ; 133
	%struct.TypeMapJava {
		i32 17, ; uint32_t module_index
		i32 u0x020000e4, ; uint32_t type_token_id
		i32 838; uint32_t java_name_index
	}, ; 134
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020000e2, ; uint32_t type_token_id
		i32 27; uint32_t java_name_index
	}, ; 135
	%struct.TypeMapJava {
		i32 11, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 724; uint32_t java_name_index
	}, ; 136
	%struct.TypeMapJava {
		i32 14, ; uint32_t module_index
		i32 u0x020000ad, ; uint32_t type_token_id
		i32 799; uint32_t java_name_index
	}, ; 137
	%struct.TypeMapJava {
		i32 17, ; uint32_t module_index
		i32 u0x0200014d, ; uint32_t type_token_id
		i32 844; uint32_t java_name_index
	}, ; 138
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020001c5, ; uint32_t type_token_id
		i32 163; uint32_t java_name_index
	}, ; 139
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x020000c9, ; uint32_t type_token_id
		i32 581; uint32_t java_name_index
	}, ; 140
	%struct.TypeMapJava {
		i32 2, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 595; uint32_t java_name_index
	}, ; 141
	%struct.TypeMapJava {
		i32 34, ; uint32_t module_index
		i32 u0x02000393, ; uint32_t type_token_id
		i32 1129; uint32_t java_name_index
	}, ; 142
	%struct.TypeMapJava {
		i32 14, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 745; uint32_t java_name_index
	}, ; 143
	%struct.TypeMapJava {
		i32 8, ; uint32_t module_index
		i32 u0x02000148, ; uint32_t type_token_id
		i32 665; uint32_t java_name_index
	}, ; 144
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020001e3, ; uint32_t type_token_id
		i32 185; uint32_t java_name_index
	}, ; 145
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 117; uint32_t java_name_index
	}, ; 146
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 195; uint32_t java_name_index
	}, ; 147
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000434, ; uint32_t type_token_id
		i32 496; uint32_t java_name_index
	}, ; 148
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020001ce, ; uint32_t type_token_id
		i32 170; uint32_t java_name_index
	}, ; 149
	%struct.TypeMapJava {
		i32 21, ; uint32_t module_index
		i32 u0x0200009d, ; uint32_t type_token_id
		i32 973; uint32_t java_name_index
	}, ; 150
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020003b8, ; uint32_t type_token_id
		i32 423; uint32_t java_name_index
	}, ; 151
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020003f8, ; uint32_t type_token_id
		i32 457; uint32_t java_name_index
	}, ; 152
	%struct.TypeMapJava {
		i32 17, ; uint32_t module_index
		i32 u0x020000bf, ; uint32_t type_token_id
		i32 827; uint32_t java_name_index
	}, ; 153
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 182; uint32_t java_name_index
	}, ; 154
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000360, ; uint32_t type_token_id
		i32 366; uint32_t java_name_index
	}, ; 155
	%struct.TypeMapJava {
		i32 21, ; uint32_t module_index
		i32 u0x02000097, ; uint32_t type_token_id
		i32 969; uint32_t java_name_index
	}, ; 156
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x0200032f, ; uint32_t type_token_id
		i32 323; uint32_t java_name_index
	}, ; 157
	%struct.TypeMapJava {
		i32 32, ; uint32_t module_index
		i32 u0x02000012, ; uint32_t type_token_id
		i32 1098; uint32_t java_name_index
	}, ; 158
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 523; uint32_t java_name_index
	}, ; 159
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x0200037f, ; uint32_t type_token_id
		i32 389; uint32_t java_name_index
	}, ; 160
	%struct.TypeMapJava {
		i32 6, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 638; uint32_t java_name_index
	}, ; 161
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020000bc, ; uint32_t type_token_id
		i32 5; uint32_t java_name_index
	}, ; 162
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020003ab, ; uint32_t type_token_id
		i32 415; uint32_t java_name_index
	}, ; 163
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000491, ; uint32_t type_token_id
		i32 557; uint32_t java_name_index
	}, ; 164
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000263, ; uint32_t type_token_id
		i32 244; uint32_t java_name_index
	}, ; 165
	%struct.TypeMapJava {
		i32 21, ; uint32_t module_index
		i32 u0x02000050, ; uint32_t type_token_id
		i32 926; uint32_t java_name_index
	}, ; 166
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x0200036e, ; uint32_t type_token_id
		i32 378; uint32_t java_name_index
	}, ; 167
	%struct.TypeMapJava {
		i32 34, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 1153; uint32_t java_name_index
	}, ; 168
	%struct.TypeMapJava {
		i32 34, ; uint32_t module_index
		i32 u0x020003c6, ; uint32_t type_token_id
		i32 1162; uint32_t java_name_index
	}, ; 169
	%struct.TypeMapJava {
		i32 18, ; uint32_t module_index
		i32 u0x02000073, ; uint32_t type_token_id
		i32 883; uint32_t java_name_index
	}, ; 170
	%struct.TypeMapJava {
		i32 25, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 1017; uint32_t java_name_index
	}, ; 171
	%struct.TypeMapJava {
		i32 34, ; uint32_t module_index
		i32 u0x0200069c, ; uint32_t type_token_id
		i32 1205; uint32_t java_name_index
	}, ; 172
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020000d4, ; uint32_t type_token_id
		i32 20; uint32_t java_name_index
	}, ; 173
	%struct.TypeMapJava {
		i32 21, ; uint32_t module_index
		i32 u0x02000098, ; uint32_t type_token_id
		i32 970; uint32_t java_name_index
	}, ; 174
	%struct.TypeMapJava {
		i32 34, ; uint32_t module_index
		i32 u0x020003d2, ; uint32_t type_token_id
		i32 1174; uint32_t java_name_index
	}, ; 175
	%struct.TypeMapJava {
		i32 14, ; uint32_t module_index
		i32 u0x02000098, ; uint32_t type_token_id
		i32 784; uint32_t java_name_index
	}, ; 176
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020000e6, ; uint32_t type_token_id
		i32 29; uint32_t java_name_index
	}, ; 177
	%struct.TypeMapJava {
		i32 8, ; uint32_t module_index
		i32 u0x020002d1, ; uint32_t type_token_id
		i32 700; uint32_t java_name_index
	}, ; 178
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x0200032c, ; uint32_t type_token_id
		i32 321; uint32_t java_name_index
	}, ; 179
	%struct.TypeMapJava {
		i32 8, ; uint32_t module_index
		i32 u0x0200014b, ; uint32_t type_token_id
		i32 667; uint32_t java_name_index
	}, ; 180
	%struct.TypeMapJava {
		i32 17, ; uint32_t module_index
		i32 u0x0200019a, ; uint32_t type_token_id
		i32 857; uint32_t java_name_index
	}, ; 181
	%struct.TypeMapJava {
		i32 34, ; uint32_t module_index
		i32 u0x020003e8, ; uint32_t type_token_id
		i32 1188; uint32_t java_name_index
	}, ; 182
	%struct.TypeMapJava {
		i32 8, ; uint32_t module_index
		i32 u0x0200012a, ; uint32_t type_token_id
		i32 660; uint32_t java_name_index
	}, ; 183
	%struct.TypeMapJava {
		i32 34, ; uint32_t module_index
		i32 u0x0200034e, ; uint32_t type_token_id
		i32 1103; uint32_t java_name_index
	}, ; 184
	%struct.TypeMapJava {
		i32 3, ; uint32_t module_index
		i32 u0x02000003, ; uint32_t type_token_id
		i32 599; uint32_t java_name_index
	}, ; 185
	%struct.TypeMapJava {
		i32 35, ; uint32_t module_index
		i32 u0x0200005e, ; uint32_t type_token_id
		i32 1231; uint32_t java_name_index
	}, ; 186
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020000e9, ; uint32_t type_token_id
		i32 31; uint32_t java_name_index
	}, ; 187
	%struct.TypeMapJava {
		i32 19, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 909; uint32_t java_name_index
	}, ; 188
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020000db, ; uint32_t type_token_id
		i32 24; uint32_t java_name_index
	}, ; 189
	%struct.TypeMapJava {
		i32 32, ; uint32_t module_index
		i32 u0x02000018, ; uint32_t type_token_id
		i32 1094; uint32_t java_name_index
	}, ; 190
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x0200015b, ; uint32_t type_token_id
		i32 101; uint32_t java_name_index
	}, ; 191
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020001ec, ; uint32_t type_token_id
		i32 191; uint32_t java_name_index
	}, ; 192
	%struct.TypeMapJava {
		i32 37, ; uint32_t module_index
		i32 u0x02000015, ; uint32_t type_token_id
		i32 1243; uint32_t java_name_index
	}, ; 193
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x0200028e, ; uint32_t type_token_id
		i32 261; uint32_t java_name_index
	}, ; 194
	%struct.TypeMapJava {
		i32 8, ; uint32_t module_index
		i32 u0x02000150, ; uint32_t type_token_id
		i32 671; uint32_t java_name_index
	}, ; 195
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000356, ; uint32_t type_token_id
		i32 356; uint32_t java_name_index
	}, ; 196
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020003e9, ; uint32_t type_token_id
		i32 447; uint32_t java_name_index
	}, ; 197
	%struct.TypeMapJava {
		i32 34, ; uint32_t module_index
		i32 u0x020003ac, ; uint32_t type_token_id
		i32 1151; uint32_t java_name_index
	}, ; 198
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x0200016c, ; uint32_t type_token_id
		i32 110; uint32_t java_name_index
	}, ; 199
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000142, ; uint32_t type_token_id
		i32 84; uint32_t java_name_index
	}, ; 200
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020000fe, ; uint32_t type_token_id
		i32 47; uint32_t java_name_index
	}, ; 201
	%struct.TypeMapJava {
		i32 22, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 989; uint32_t java_name_index
	}, ; 202
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x020000f6, ; uint32_t type_token_id
		i32 585; uint32_t java_name_index
	}, ; 203
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020002cb, ; uint32_t type_token_id
		i32 293; uint32_t java_name_index
	}, ; 204
	%struct.TypeMapJava {
		i32 17, ; uint32_t module_index
		i32 u0x02000191, ; uint32_t type_token_id
		i32 854; uint32_t java_name_index
	}, ; 205
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020000b9, ; uint32_t type_token_id
		i32 3; uint32_t java_name_index
	}, ; 206
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x0200033f, ; uint32_t type_token_id
		i32 335; uint32_t java_name_index
	}, ; 207
	%struct.TypeMapJava {
		i32 33, ; uint32_t module_index
		i32 u0x02000003, ; uint32_t type_token_id
		i32 1099; uint32_t java_name_index
	}, ; 208
	%struct.TypeMapJava {
		i32 34, ; uint32_t module_index
		i32 u0x02000391, ; uint32_t type_token_id
		i32 1125; uint32_t java_name_index
	}, ; 209
	%struct.TypeMapJava {
		i32 13, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 741; uint32_t java_name_index
	}, ; 210
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000116, ; uint32_t type_token_id
		i32 64; uint32_t java_name_index
	}, ; 211
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020003fa, ; uint32_t type_token_id
		i32 458; uint32_t java_name_index
	}, ; 212
	%struct.TypeMapJava {
		i32 34, ; uint32_t module_index
		i32 u0x020003ed, ; uint32_t type_token_id
		i32 1192; uint32_t java_name_index
	}, ; 213
	%struct.TypeMapJava {
		i32 37, ; uint32_t module_index
		i32 u0x02000023, ; uint32_t type_token_id
		i32 1254; uint32_t java_name_index
	}, ; 214
	%struct.TypeMapJava {
		i32 34, ; uint32_t module_index
		i32 u0x02000496, ; uint32_t type_token_id
		i32 1101; uint32_t java_name_index
	}, ; 215
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020001a7, ; uint32_t type_token_id
		i32 141; uint32_t java_name_index
	}, ; 216
	%struct.TypeMapJava {
		i32 26, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 1069; uint32_t java_name_index
	}, ; 217
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000130, ; uint32_t type_token_id
		i32 77; uint32_t java_name_index
	}, ; 218
	%struct.TypeMapJava {
		i32 14, ; uint32_t module_index
		i32 u0x02000086, ; uint32_t type_token_id
		i32 778; uint32_t java_name_index
	}, ; 219
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020001ab, ; uint32_t type_token_id
		i32 145; uint32_t java_name_index
	}, ; 220
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 152; uint32_t java_name_index
	}, ; 221
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x0200010a, ; uint32_t type_token_id
		i32 59; uint32_t java_name_index
	}, ; 222
	%struct.TypeMapJava {
		i32 35, ; uint32_t module_index
		i32 u0x02000035, ; uint32_t type_token_id
		i32 1208; uint32_t java_name_index
	}, ; 223
	%struct.TypeMapJava {
		i32 34, ; uint32_t module_index
		i32 u0x020003d9, ; uint32_t type_token_id
		i32 1181; uint32_t java_name_index
	}, ; 224
	%struct.TypeMapJava {
		i32 35, ; uint32_t module_index
		i32 u0x0200004f, ; uint32_t type_token_id
		i32 1222; uint32_t java_name_index
	}, ; 225
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020004a8, ; uint32_t type_token_id
		i32 572; uint32_t java_name_index
	}, ; 226
	%struct.TypeMapJava {
		i32 34, ; uint32_t module_index
		i32 u0x020003d5, ; uint32_t type_token_id
		i32 1178; uint32_t java_name_index
	}, ; 227
	%struct.TypeMapJava {
		i32 25, ; uint32_t module_index
		i32 u0x0200006b, ; uint32_t type_token_id
		i32 1034; uint32_t java_name_index
	}, ; 228
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 238; uint32_t java_name_index
	}, ; 229
	%struct.TypeMapJava {
		i32 6, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 617; uint32_t java_name_index
	}, ; 230
	%struct.TypeMapJava {
		i32 17, ; uint32_t module_index
		i32 u0x02000017, ; uint32_t type_token_id
		i32 820; uint32_t java_name_index
	}, ; 231
	%struct.TypeMapJava {
		i32 26, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 1066; uint32_t java_name_index
	}, ; 232
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000340, ; uint32_t type_token_id
		i32 336; uint32_t java_name_index
	}, ; 233
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020003ac, ; uint32_t type_token_id
		i32 416; uint32_t java_name_index
	}, ; 234
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020003bb, ; uint32_t type_token_id
		i32 425; uint32_t java_name_index
	}, ; 235
	%struct.TypeMapJava {
		i32 14, ; uint32_t module_index
		i32 u0x0200004c, ; uint32_t type_token_id
		i32 752; uint32_t java_name_index
	}, ; 236
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000389, ; uint32_t type_token_id
		i32 396; uint32_t java_name_index
	}, ; 237
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000331, ; uint32_t type_token_id
		i32 325; uint32_t java_name_index
	}, ; 238
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x0200038f, ; uint32_t type_token_id
		i32 400; uint32_t java_name_index
	}, ; 239
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000476, ; uint32_t type_token_id
		i32 533; uint32_t java_name_index
	}, ; 240
	%struct.TypeMapJava {
		i32 14, ; uint32_t module_index
		i32 u0x0200004b, ; uint32_t type_token_id
		i32 751; uint32_t java_name_index
	}, ; 241
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 240; uint32_t java_name_index
	}, ; 242
	%struct.TypeMapJava {
		i32 25, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 1025; uint32_t java_name_index
	}, ; 243
	%struct.TypeMapJava {
		i32 21, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 917; uint32_t java_name_index
	}, ; 244
	%struct.TypeMapJava {
		i32 21, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 936; uint32_t java_name_index
	}, ; 245
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 473; uint32_t java_name_index
	}, ; 246
	%struct.TypeMapJava {
		i32 21, ; uint32_t module_index
		i32 u0x020000a8, ; uint32_t type_token_id
		i32 981; uint32_t java_name_index
	}, ; 247
	%struct.TypeMapJava {
		i32 19, ; uint32_t module_index
		i32 u0x02000017, ; uint32_t type_token_id
		i32 907; uint32_t java_name_index
	}, ; 248
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020002c4, ; uint32_t type_token_id
		i32 286; uint32_t java_name_index
	}, ; 249
	%struct.TypeMapJava {
		i32 21, ; uint32_t module_index
		i32 u0x02000099, ; uint32_t type_token_id
		i32 971; uint32_t java_name_index
	}, ; 250
	%struct.TypeMapJava {
		i32 31, ; uint32_t module_index
		i32 u0x0200001e, ; uint32_t type_token_id
		i32 1086; uint32_t java_name_index
	}, ; 251
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x0200018a, ; uint32_t type_token_id
		i32 127; uint32_t java_name_index
	}, ; 252
	%struct.TypeMapJava {
		i32 34, ; uint32_t module_index
		i32 u0x020003dc, ; uint32_t type_token_id
		i32 1183; uint32_t java_name_index
	}, ; 253
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 406; uint32_t java_name_index
	}, ; 254
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x0200049d, ; uint32_t type_token_id
		i32 563; uint32_t java_name_index
	}, ; 255
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 417; uint32_t java_name_index
	}, ; 256
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 444; uint32_t java_name_index
	}, ; 257
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000179, ; uint32_t type_token_id
		i32 118; uint32_t java_name_index
	}, ; 258
	%struct.TypeMapJava {
		i32 8, ; uint32_t module_index
		i32 u0x0200017f, ; uint32_t type_token_id
		i32 701; uint32_t java_name_index
	}, ; 259
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x0200048d, ; uint32_t type_token_id
		i32 555; uint32_t java_name_index
	}, ; 260
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000233, ; uint32_t type_token_id
		i32 220; uint32_t java_name_index
	}, ; 261
	%struct.TypeMapJava {
		i32 19, ; uint32_t module_index
		i32 u0x02000009, ; uint32_t type_token_id
		i32 899; uint32_t java_name_index
	}, ; 262
	%struct.TypeMapJava {
		i32 17, ; uint32_t module_index
		i32 u0x0200010f, ; uint32_t type_token_id
		i32 839; uint32_t java_name_index
	}, ; 263
	%struct.TypeMapJava {
		i32 40, ; uint32_t module_index
		i32 u0x02000012, ; uint32_t type_token_id
		i32 1277; uint32_t java_name_index
	}, ; 264
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020001f8, ; uint32_t type_token_id
		i32 196; uint32_t java_name_index
	}, ; 265
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 162; uint32_t java_name_index
	}, ; 266
	%struct.TypeMapJava {
		i32 17, ; uint32_t module_index
		i32 u0x020000be, ; uint32_t type_token_id
		i32 826; uint32_t java_name_index
	}, ; 267
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 279; uint32_t java_name_index
	}, ; 268
	%struct.TypeMapJava {
		i32 18, ; uint32_t module_index
		i32 u0x0200004b, ; uint32_t type_token_id
		i32 858; uint32_t java_name_index
	}, ; 269
	%struct.TypeMapJava {
		i32 18, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 885; uint32_t java_name_index
	}, ; 270
	%struct.TypeMapJava {
		i32 34, ; uint32_t module_index
		i32 u0x02000381, ; uint32_t type_token_id
		i32 1123; uint32_t java_name_index
	}, ; 271
	%struct.TypeMapJava {
		i32 21, ; uint32_t module_index
		i32 u0x02000064, ; uint32_t type_token_id
		i32 938; uint32_t java_name_index
	}, ; 272
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020002be, ; uint32_t type_token_id
		i32 282; uint32_t java_name_index
	}, ; 273
	%struct.TypeMapJava {
		i32 35, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 1232; uint32_t java_name_index
	}, ; 274
	%struct.TypeMapJava {
		i32 38, ; uint32_t module_index
		i32 u0x0200002b, ; uint32_t type_token_id
		i32 1262; uint32_t java_name_index
	}, ; 275
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020001ff, ; uint32_t type_token_id
		i32 201; uint32_t java_name_index
	}, ; 276
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 304; uint32_t java_name_index
	}, ; 277
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x0200032e, ; uint32_t type_token_id
		i32 322; uint32_t java_name_index
	}, ; 278
	%struct.TypeMapJava {
		i32 8, ; uint32_t module_index
		i32 u0x02000156, ; uint32_t type_token_id
		i32 679; uint32_t java_name_index
	}, ; 279
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x0200034b, ; uint32_t type_token_id
		i32 346; uint32_t java_name_index
	}, ; 280
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020001c2, ; uint32_t type_token_id
		i32 161; uint32_t java_name_index
	}, ; 281
	%struct.TypeMapJava {
		i32 34, ; uint32_t module_index
		i32 u0x0200036f, ; uint32_t type_token_id
		i32 1117; uint32_t java_name_index
	}, ; 282
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000417, ; uint32_t type_token_id
		i32 479; uint32_t java_name_index
	}, ; 283
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 296; uint32_t java_name_index
	}, ; 284
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020002e1, ; uint32_t type_token_id
		i32 305; uint32_t java_name_index
	}, ; 285
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020001a6, ; uint32_t type_token_id
		i32 140; uint32_t java_name_index
	}, ; 286
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x02000100, ; uint32_t type_token_id
		i32 586; uint32_t java_name_index
	}, ; 287
	%struct.TypeMapJava {
		i32 34, ; uint32_t module_index
		i32 u0x0200061a, ; uint32_t type_token_id
		i32 1148; uint32_t java_name_index
	}, ; 288
	%struct.TypeMapJava {
		i32 19, ; uint32_t module_index
		i32 u0x02000019, ; uint32_t type_token_id
		i32 908; uint32_t java_name_index
	}, ; 289
	%struct.TypeMapJava {
		i32 37, ; uint32_t module_index
		i32 u0x02000013, ; uint32_t type_token_id
		i32 1241; uint32_t java_name_index
	}, ; 290
	%struct.TypeMapJava {
		i32 34, ; uint32_t module_index
		i32 u0x0200038f, ; uint32_t type_token_id
		i32 1124; uint32_t java_name_index
	}, ; 291
	%struct.TypeMapJava {
		i32 17, ; uint32_t module_index
		i32 u0x0200011e, ; uint32_t type_token_id
		i32 841; uint32_t java_name_index
	}, ; 292
	%struct.TypeMapJava {
		i32 34, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 1116; uint32_t java_name_index
	}, ; 293
	%struct.TypeMapJava {
		i32 34, ; uint32_t module_index
		i32 u0x020003e9, ; uint32_t type_token_id
		i32 1189; uint32_t java_name_index
	}, ; 294
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020002af, ; uint32_t type_token_id
		i32 276; uint32_t java_name_index
	}, ; 295
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000161, ; uint32_t type_token_id
		i32 105; uint32_t java_name_index
	}, ; 296
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000381, ; uint32_t type_token_id
		i32 391; uint32_t java_name_index
	}, ; 297
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000346, ; uint32_t type_token_id
		i32 342; uint32_t java_name_index
	}, ; 298
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020000ec, ; uint32_t type_token_id
		i32 33; uint32_t java_name_index
	}, ; 299
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020003d2, ; uint32_t type_token_id
		i32 437; uint32_t java_name_index
	}, ; 300
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 248; uint32_t java_name_index
	}, ; 301
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020001c7, ; uint32_t type_token_id
		i32 164; uint32_t java_name_index
	}, ; 302
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000310, ; uint32_t type_token_id
		i32 315; uint32_t java_name_index
	}, ; 303
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x0200015e, ; uint32_t type_token_id
		i32 103; uint32_t java_name_index
	}, ; 304
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 236; uint32_t java_name_index
	}, ; 305
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000296, ; uint32_t type_token_id
		i32 264; uint32_t java_name_index
	}, ; 306
	%struct.TypeMapJava {
		i32 34, ; uint32_t module_index
		i32 u0x02000635, ; uint32_t type_token_id
		i32 1202; uint32_t java_name_index
	}, ; 307
	%struct.TypeMapJava {
		i32 34, ; uint32_t module_index
		i32 u0x0200069b, ; uint32_t type_token_id
		i32 1204; uint32_t java_name_index
	}, ; 308
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 215; uint32_t java_name_index
	}, ; 309
	%struct.TypeMapJava {
		i32 38, ; uint32_t module_index
		i32 u0x02000046, ; uint32_t type_token_id
		i32 1268; uint32_t java_name_index
	}, ; 310
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 241; uint32_t java_name_index
	}, ; 311
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 530; uint32_t java_name_index
	}, ; 312
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x0200040a, ; uint32_t type_token_id
		i32 470; uint32_t java_name_index
	}, ; 313
	%struct.TypeMapJava {
		i32 21, ; uint32_t module_index
		i32 u0x0200004b, ; uint32_t type_token_id
		i32 922; uint32_t java_name_index
	}, ; 314
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000401, ; uint32_t type_token_id
		i32 462; uint32_t java_name_index
	}, ; 315
	%struct.TypeMapJava {
		i32 17, ; uint32_t module_index
		i32 u0x020000e3, ; uint32_t type_token_id
		i32 837; uint32_t java_name_index
	}, ; 316
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020001a5, ; uint32_t type_token_id
		i32 139; uint32_t java_name_index
	}, ; 317
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 193; uint32_t java_name_index
	}, ; 318
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x0200010c, ; uint32_t type_token_id
		i32 60; uint32_t java_name_index
	}, ; 319
	%struct.TypeMapJava {
		i32 6, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 635; uint32_t java_name_index
	}, ; 320
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000344, ; uint32_t type_token_id
		i32 340; uint32_t java_name_index
	}, ; 321
	%struct.TypeMapJava {
		i32 25, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 1054; uint32_t java_name_index
	}, ; 322
	%struct.TypeMapJava {
		i32 4, ; uint32_t module_index
		i32 u0x0200001b, ; uint32_t type_token_id
		i32 604; uint32_t java_name_index
	}, ; 323
	%struct.TypeMapJava {
		i32 27, ; uint32_t module_index
		i32 u0x0200000f, ; uint32_t type_token_id
		i32 1072; uint32_t java_name_index
	}, ; 324
	%struct.TypeMapJava {
		i32 38, ; uint32_t module_index
		i32 u0x0200002d, ; uint32_t type_token_id
		i32 1263; uint32_t java_name_index
	}, ; 325
	%struct.TypeMapJava {
		i32 16, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 814; uint32_t java_name_index
	}, ; 326
	%struct.TypeMapJava {
		i32 18, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 872; uint32_t java_name_index
	}, ; 327
	%struct.TypeMapJava {
		i32 35, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 1212; uint32_t java_name_index
	}, ; 328
	%struct.TypeMapJava {
		i32 35, ; uint32_t module_index
		i32 u0x02000046, ; uint32_t type_token_id
		i32 1217; uint32_t java_name_index
	}, ; 329
	%struct.TypeMapJava {
		i32 14, ; uint32_t module_index
		i32 u0x0200009d, ; uint32_t type_token_id
		i32 787; uint32_t java_name_index
	}, ; 330
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x020000ea, ; uint32_t type_token_id
		i32 584; uint32_t java_name_index
	}, ; 331
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020002bf, ; uint32_t type_token_id
		i32 283; uint32_t java_name_index
	}, ; 332
	%struct.TypeMapJava {
		i32 23, ; uint32_t module_index
		i32 u0x0200003d, ; uint32_t type_token_id
		i32 996; uint32_t java_name_index
	}, ; 333
	%struct.TypeMapJava {
		i32 35, ; uint32_t module_index
		i32 u0x02000055, ; uint32_t type_token_id
		i32 1226; uint32_t java_name_index
	}, ; 334
	%struct.TypeMapJava {
		i32 18, ; uint32_t module_index
		i32 u0x0200004c, ; uint32_t type_token_id
		i32 859; uint32_t java_name_index
	}, ; 335
	%struct.TypeMapJava {
		i32 25, ; uint32_t module_index
		i32 u0x020000a5, ; uint32_t type_token_id
		i32 1060; uint32_t java_name_index
	}, ; 336
	%struct.TypeMapJava {
		i32 10, ; uint32_t module_index
		i32 u0x02000007, ; uint32_t type_token_id
		i32 719; uint32_t java_name_index
	}, ; 337
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020002aa, ; uint32_t type_token_id
		i32 272; uint32_t java_name_index
	}, ; 338
	%struct.TypeMapJava {
		i32 19, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 905; uint32_t java_name_index
	}, ; 339
	%struct.TypeMapJava {
		i32 17, ; uint32_t module_index
		i32 u0x02000184, ; uint32_t type_token_id
		i32 848; uint32_t java_name_index
	}, ; 340
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x0200043f, ; uint32_t type_token_id
		i32 504; uint32_t java_name_index
	}, ; 341
	%struct.TypeMapJava {
		i32 8, ; uint32_t module_index
		i32 u0x0200011e, ; uint32_t type_token_id
		i32 654; uint32_t java_name_index
	}, ; 342
	%struct.TypeMapJava {
		i32 21, ; uint32_t module_index
		i32 u0x020000a5, ; uint32_t type_token_id
		i32 978; uint32_t java_name_index
	}, ; 343
	%struct.TypeMapJava {
		i32 21, ; uint32_t module_index
		i32 u0x02000056, ; uint32_t type_token_id
		i32 931; uint32_t java_name_index
	}, ; 344
	%struct.TypeMapJava {
		i32 8, ; uint32_t module_index
		i32 u0x02000152, ; uint32_t type_token_id
		i32 673; uint32_t java_name_index
	}, ; 345
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020003fc, ; uint32_t type_token_id
		i32 459; uint32_t java_name_index
	}, ; 346
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 211; uint32_t java_name_index
	}, ; 347
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x0200035d, ; uint32_t type_token_id
		i32 363; uint32_t java_name_index
	}, ; 348
	%struct.TypeMapJava {
		i32 25, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 1057; uint32_t java_name_index
	}, ; 349
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020001a0, ; uint32_t type_token_id
		i32 137; uint32_t java_name_index
	}, ; 350
	%struct.TypeMapJava {
		i32 21, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 953; uint32_t java_name_index
	}, ; 351
	%struct.TypeMapJava {
		i32 18, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 875; uint32_t java_name_index
	}, ; 352
	%struct.TypeMapJava {
		i32 38, ; uint32_t module_index
		i32 u0x02000025, ; uint32_t type_token_id
		i32 1257; uint32_t java_name_index
	}, ; 353
	%struct.TypeMapJava {
		i32 11, ; uint32_t module_index
		i32 u0x02000014, ; uint32_t type_token_id
		i32 725; uint32_t java_name_index
	}, ; 354
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000354, ; uint32_t type_token_id
		i32 354; uint32_t java_name_index
	}, ; 355
	%struct.TypeMapJava {
		i32 18, ; uint32_t module_index
		i32 u0x02000053, ; uint32_t type_token_id
		i32 863; uint32_t java_name_index
	}, ; 356
	%struct.TypeMapJava {
		i32 6, ; uint32_t module_index
		i32 u0x02000027, ; uint32_t type_token_id
		i32 627; uint32_t java_name_index
	}, ; 357
	%struct.TypeMapJava {
		i32 34, ; uint32_t module_index
		i32 u0x02000365, ; uint32_t type_token_id
		i32 1112; uint32_t java_name_index
	}, ; 358
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 414; uint32_t java_name_index
	}, ; 359
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020001be, ; uint32_t type_token_id
		i32 158; uint32_t java_name_index
	}, ; 360
	%struct.TypeMapJava {
		i32 38, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 1269; uint32_t java_name_index
	}, ; 361
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020001e9, ; uint32_t type_token_id
		i32 189; uint32_t java_name_index
	}, ; 362
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000358, ; uint32_t type_token_id
		i32 358; uint32_t java_name_index
	}, ; 363
	%struct.TypeMapJava {
		i32 25, ; uint32_t module_index
		i32 u0x0200006c, ; uint32_t type_token_id
		i32 1035; uint32_t java_name_index
	}, ; 364
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 181; uint32_t java_name_index
	}, ; 365
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x0200016b, ; uint32_t type_token_id
		i32 109; uint32_t java_name_index
	}, ; 366
	%struct.TypeMapJava {
		i32 34, ; uint32_t module_index
		i32 u0x020003cb, ; uint32_t type_token_id
		i32 1167; uint32_t java_name_index
	}, ; 367
	%struct.TypeMapJava {
		i32 14, ; uint32_t module_index
		i32 u0x02000053, ; uint32_t type_token_id
		i32 757; uint32_t java_name_index
	}, ; 368
	%struct.TypeMapJava {
		i32 14, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 770; uint32_t java_name_index
	}, ; 369
	%struct.TypeMapJava {
		i32 39, ; uint32_t module_index
		i32 u0x02000009, ; uint32_t type_token_id
		i32 1276; uint32_t java_name_index
	}, ; 370
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x0200039d, ; uint32_t type_token_id
		i32 407; uint32_t java_name_index
	}, ; 371
	%struct.TypeMapJava {
		i32 21, ; uint32_t module_index
		i32 u0x02000065, ; uint32_t type_token_id
		i32 939; uint32_t java_name_index
	}, ; 372
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020000e7, ; uint32_t type_token_id
		i32 30; uint32_t java_name_index
	}, ; 373
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000380, ; uint32_t type_token_id
		i32 390; uint32_t java_name_index
	}, ; 374
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000333, ; uint32_t type_token_id
		i32 327; uint32_t java_name_index
	}, ; 375
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000479, ; uint32_t type_token_id
		i32 536; uint32_t java_name_index
	}, ; 376
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 132; uint32_t java_name_index
	}, ; 377
	%struct.TypeMapJava {
		i32 17, ; uint32_t module_index
		i32 u0x02000195, ; uint32_t type_token_id
		i32 855; uint32_t java_name_index
	}, ; 378
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x0200048c, ; uint32_t type_token_id
		i32 554; uint32_t java_name_index
	}, ; 379
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000153, ; uint32_t type_token_id
		i32 96; uint32_t java_name_index
	}, ; 380
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020000be, ; uint32_t type_token_id
		i32 6; uint32_t java_name_index
	}, ; 381
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000379, ; uint32_t type_token_id
		i32 385; uint32_t java_name_index
	}, ; 382
	%struct.TypeMapJava {
		i32 18, ; uint32_t module_index
		i32 u0x02000054, ; uint32_t type_token_id
		i32 864; uint32_t java_name_index
	}, ; 383
	%struct.TypeMapJava {
		i32 14, ; uint32_t module_index
		i32 u0x02000061, ; uint32_t type_token_id
		i32 762; uint32_t java_name_index
	}, ; 384
	%struct.TypeMapJava {
		i32 0, ; uint32_t module_index
		i32 u0x02000002, ; uint32_t type_token_id
		i32 580; uint32_t java_name_index
	}, ; 385
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020003bc, ; uint32_t type_token_id
		i32 426; uint32_t java_name_index
	}, ; 386
	%struct.TypeMapJava {
		i32 18, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 879; uint32_t java_name_index
	}, ; 387
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000136, ; uint32_t type_token_id
		i32 79; uint32_t java_name_index
	}, ; 388
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020002ca, ; uint32_t type_token_id
		i32 292; uint32_t java_name_index
	}, ; 389
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020001bf, ; uint32_t type_token_id
		i32 159; uint32_t java_name_index
	}, ; 390
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000208, ; uint32_t type_token_id
		i32 206; uint32_t java_name_index
	}, ; 391
	%struct.TypeMapJava {
		i32 38, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 1264; uint32_t java_name_index
	}, ; 392
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000424, ; uint32_t type_token_id
		i32 486; uint32_t java_name_index
	}, ; 393
	%struct.TypeMapJava {
		i32 21, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 933; uint32_t java_name_index
	}, ; 394
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020004a5, ; uint32_t type_token_id
		i32 570; uint32_t java_name_index
	}, ; 395
	%struct.TypeMapJava {
		i32 14, ; uint32_t module_index
		i32 u0x0200006a, ; uint32_t type_token_id
		i32 767; uint32_t java_name_index
	}, ; 396
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 26; uint32_t java_name_index
	}, ; 397
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020004a1, ; uint32_t type_token_id
		i32 566; uint32_t java_name_index
	}, ; 398
	%struct.TypeMapJava {
		i32 14, ; uint32_t module_index
		i32 u0x0200004f, ; uint32_t type_token_id
		i32 755; uint32_t java_name_index
	}, ; 399
	%struct.TypeMapJava {
		i32 35, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 1209; uint32_t java_name_index
	}, ; 400
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020002c8, ; uint32_t type_token_id
		i32 290; uint32_t java_name_index
	}, ; 401
	%struct.TypeMapJava {
		i32 8, ; uint32_t module_index
		i32 u0x02000120, ; uint32_t type_token_id
		i32 655; uint32_t java_name_index
	}, ; 402
	%struct.TypeMapJava {
		i32 37, ; uint32_t module_index
		i32 u0x02000017, ; uint32_t type_token_id
		i32 1245; uint32_t java_name_index
	}, ; 403
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000357, ; uint32_t type_token_id
		i32 357; uint32_t java_name_index
	}, ; 404
	%struct.TypeMapJava {
		i32 38, ; uint32_t module_index
		i32 u0x0200004f, ; uint32_t type_token_id
		i32 1273; uint32_t java_name_index
	}, ; 405
	%struct.TypeMapJava {
		i32 8, ; uint32_t module_index
		i32 u0x0200015e, ; uint32_t type_token_id
		i32 685; uint32_t java_name_index
	}, ; 406
	%struct.TypeMapJava {
		i32 25, ; uint32_t module_index
		i32 u0x0200003e, ; uint32_t type_token_id
		i32 1007; uint32_t java_name_index
	}, ; 407
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020002e3, ; uint32_t type_token_id
		i32 307; uint32_t java_name_index
	}, ; 408
	%struct.TypeMapJava {
		i32 8, ; uint32_t module_index
		i32 u0x0200009a, ; uint32_t type_token_id
		i32 643; uint32_t java_name_index
	}, ; 409
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000342, ; uint32_t type_token_id
		i32 338; uint32_t java_name_index
	}, ; 410
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020001d4, ; uint32_t type_token_id
		i32 176; uint32_t java_name_index
	}, ; 411
	%struct.TypeMapJava {
		i32 25, ; uint32_t module_index
		i32 u0x02000048, ; uint32_t type_token_id
		i32 1014; uint32_t java_name_index
	}, ; 412
	%struct.TypeMapJava {
		i32 21, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 957; uint32_t java_name_index
	}, ; 413
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020000f1, ; uint32_t type_token_id
		i32 37; uint32_t java_name_index
	}, ; 414
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020003cb, ; uint32_t type_token_id
		i32 435; uint32_t java_name_index
	}, ; 415
	%struct.TypeMapJava {
		i32 27, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 1074; uint32_t java_name_index
	}, ; 416
	%struct.TypeMapJava {
		i32 3, ; uint32_t module_index
		i32 u0x02000004, ; uint32_t type_token_id
		i32 600; uint32_t java_name_index
	}, ; 417
	%struct.TypeMapJava {
		i32 25, ; uint32_t module_index
		i32 u0x02000079, ; uint32_t type_token_id
		i32 1041; uint32_t java_name_index
	}, ; 418
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x0200024d, ; uint32_t type_token_id
		i32 234; uint32_t java_name_index
	}, ; 419
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 253; uint32_t java_name_index
	}, ; 420
	%struct.TypeMapJava {
		i32 25, ; uint32_t module_index
		i32 u0x0200006a, ; uint32_t type_token_id
		i32 1033; uint32_t java_name_index
	}, ; 421
	%struct.TypeMapJava {
		i32 34, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 1164; uint32_t java_name_index
	}, ; 422
	%struct.TypeMapJava {
		i32 34, ; uint32_t module_index
		i32 u0x02000372, ; uint32_t type_token_id
		i32 1118; uint32_t java_name_index
	}, ; 423
	%struct.TypeMapJava {
		i32 19, ; uint32_t module_index
		i32 u0x0200000a, ; uint32_t type_token_id
		i32 900; uint32_t java_name_index
	}, ; 424
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020001d6, ; uint32_t type_token_id
		i32 177; uint32_t java_name_index
	}, ; 425
	%struct.TypeMapJava {
		i32 8, ; uint32_t module_index
		i32 u0x02000242, ; uint32_t type_token_id
		i32 711; uint32_t java_name_index
	}, ; 426
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000289, ; uint32_t type_token_id
		i32 258; uint32_t java_name_index
	}, ; 427
	%struct.TypeMapJava {
		i32 17, ; uint32_t module_index
		i32 u0x020000cf, ; uint32_t type_token_id
		i32 835; uint32_t java_name_index
	}, ; 428
	%struct.TypeMapJava {
		i32 35, ; uint32_t module_index
		i32 u0x02000053, ; uint32_t type_token_id
		i32 1224; uint32_t java_name_index
	}, ; 429
	%struct.TypeMapJava {
		i32 14, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 758; uint32_t java_name_index
	}, ; 430
	%struct.TypeMapJava {
		i32 18, ; uint32_t module_index
		i32 u0x0200005d, ; uint32_t type_token_id
		i32 871; uint32_t java_name_index
	}, ; 431
	%struct.TypeMapJava {
		i32 7, ; uint32_t module_index
		i32 u0x02000027, ; uint32_t type_token_id
		i32 640; uint32_t java_name_index
	}, ; 432
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020001d8, ; uint32_t type_token_id
		i32 179; uint32_t java_name_index
	}, ; 433
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000126, ; uint32_t type_token_id
		i32 72; uint32_t java_name_index
	}, ; 434
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020003d3, ; uint32_t type_token_id
		i32 438; uint32_t java_name_index
	}, ; 435
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x0200036f, ; uint32_t type_token_id
		i32 379; uint32_t java_name_index
	}, ; 436
	%struct.TypeMapJava {
		i32 17, ; uint32_t module_index
		i32 u0x02000183, ; uint32_t type_token_id
		i32 847; uint32_t java_name_index
	}, ; 437
	%struct.TypeMapJava {
		i32 35, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 1215; uint32_t java_name_index
	}, ; 438
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000243, ; uint32_t type_token_id
		i32 229; uint32_t java_name_index
	}, ; 439
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 560; uint32_t java_name_index
	}, ; 440
	%struct.TypeMapJava {
		i32 21, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 961; uint32_t java_name_index
	}, ; 441
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x0200025f, ; uint32_t type_token_id
		i32 591; uint32_t java_name_index
	}, ; 442
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000240, ; uint32_t type_token_id
		i32 228; uint32_t java_name_index
	}, ; 443
	%struct.TypeMapJava {
		i32 6, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 633; uint32_t java_name_index
	}, ; 444
	%struct.TypeMapJava {
		i32 34, ; uint32_t module_index
		i32 u0x020005e8, ; uint32_t type_token_id
		i32 1106; uint32_t java_name_index
	}, ; 445
	%struct.TypeMapJava {
		i32 5, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 612; uint32_t java_name_index
	}, ; 446
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000232, ; uint32_t type_token_id
		i32 219; uint32_t java_name_index
	}, ; 447
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x0200035e, ; uint32_t type_token_id
		i32 364; uint32_t java_name_index
	}, ; 448
	%struct.TypeMapJava {
		i32 25, ; uint32_t module_index
		i32 u0x0200003b, ; uint32_t type_token_id
		i32 1004; uint32_t java_name_index
	}, ; 449
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000395, ; uint32_t type_token_id
		i32 403; uint32_t java_name_index
	}, ; 450
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000486, ; uint32_t type_token_id
		i32 549; uint32_t java_name_index
	}, ; 451
	%struct.TypeMapJava {
		i32 17, ; uint32_t module_index
		i32 u0x02000023, ; uint32_t type_token_id
		i32 821; uint32_t java_name_index
	}, ; 452
	%struct.TypeMapJava {
		i32 38, ; uint32_t module_index
		i32 u0x02000026, ; uint32_t type_token_id
		i32 1258; uint32_t java_name_index
	}, ; 453
	%struct.TypeMapJava {
		i32 34, ; uint32_t module_index
		i32 u0x02000699, ; uint32_t type_token_id
		i32 1120; uint32_t java_name_index
	}, ; 454
	%struct.TypeMapJava {
		i32 4, ; uint32_t module_index
		i32 u0x02000021, ; uint32_t type_token_id
		i32 607; uint32_t java_name_index
	}, ; 455
	%struct.TypeMapJava {
		i32 18, ; uint32_t module_index
		i32 u0x02000058, ; uint32_t type_token_id
		i32 867; uint32_t java_name_index
	}, ; 456
	%struct.TypeMapJava {
		i32 8, ; uint32_t module_index
		i32 u0x0200011d, ; uint32_t type_token_id
		i32 653; uint32_t java_name_index
	}, ; 457
	%struct.TypeMapJava {
		i32 35, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 1216; uint32_t java_name_index
	}, ; 458
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000349, ; uint32_t type_token_id
		i32 344; uint32_t java_name_index
	}, ; 459
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020003ee, ; uint32_t type_token_id
		i32 450; uint32_t java_name_index
	}, ; 460
	%struct.TypeMapJava {
		i32 34, ; uint32_t module_index
		i32 u0x02000392, ; uint32_t type_token_id
		i32 1126; uint32_t java_name_index
	}, ; 461
	%struct.TypeMapJava {
		i32 8, ; uint32_t module_index
		i32 u0x020002ca, ; uint32_t type_token_id
		i32 693; uint32_t java_name_index
	}, ; 462
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 246; uint32_t java_name_index
	}, ; 463
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020000f8, ; uint32_t type_token_id
		i32 43; uint32_t java_name_index
	}, ; 464
	%struct.TypeMapJava {
		i32 35, ; uint32_t module_index
		i32 u0x02000061, ; uint32_t type_token_id
		i32 1233; uint32_t java_name_index
	}, ; 465
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 506; uint32_t java_name_index
	}, ; 466
	%struct.TypeMapJava {
		i32 29, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 1081; uint32_t java_name_index
	}, ; 467
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 498; uint32_t java_name_index
	}, ; 468
	%struct.TypeMapJava {
		i32 14, ; uint32_t module_index
		i32 u0x02000041, ; uint32_t type_token_id
		i32 743; uint32_t java_name_index
	}, ; 469
	%struct.TypeMapJava {
		i32 21, ; uint32_t module_index
		i32 u0x02000090, ; uint32_t type_token_id
		i32 963; uint32_t java_name_index
	}, ; 470
	%struct.TypeMapJava {
		i32 14, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 780; uint32_t java_name_index
	}, ; 471
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x0200038b, ; uint32_t type_token_id
		i32 397; uint32_t java_name_index
	}, ; 472
	%struct.TypeMapJava {
		i32 32, ; uint32_t module_index
		i32 u0x0200000e, ; uint32_t type_token_id
		i32 1088; uint32_t java_name_index
	}, ; 473
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000147, ; uint32_t type_token_id
		i32 88; uint32_t java_name_index
	}, ; 474
	%struct.TypeMapJava {
		i32 10, ; uint32_t module_index
		i32 u0x02000006, ; uint32_t type_token_id
		i32 718; uint32_t java_name_index
	}, ; 475
	%struct.TypeMapJava {
		i32 14, ; uint32_t module_index
		i32 u0x02000090, ; uint32_t type_token_id
		i32 783; uint32_t java_name_index
	}, ; 476
	%struct.TypeMapJava {
		i32 18, ; uint32_t module_index
		i32 u0x02000069, ; uint32_t type_token_id
		i32 878; uint32_t java_name_index
	}, ; 477
	%struct.TypeMapJava {
		i32 21, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 942; uint32_t java_name_index
	}, ; 478
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020004ab, ; uint32_t type_token_id
		i32 575; uint32_t java_name_index
	}, ; 479
	%struct.TypeMapJava {
		i32 35, ; uint32_t module_index
		i32 u0x02000063, ; uint32_t type_token_id
		i32 1235; uint32_t java_name_index
	}, ; 480
	%struct.TypeMapJava {
		i32 25, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 1046; uint32_t java_name_index
	}, ; 481
	%struct.TypeMapJava {
		i32 8, ; uint32_t module_index
		i32 u0x0200016b, ; uint32_t type_token_id
		i32 695; uint32_t java_name_index
	}, ; 482
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020003d5, ; uint32_t type_token_id
		i32 440; uint32_t java_name_index
	}, ; 483
	%struct.TypeMapJava {
		i32 21, ; uint32_t module_index
		i32 u0x02000078, ; uint32_t type_token_id
		i32 948; uint32_t java_name_index
	}, ; 484
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 70; uint32_t java_name_index
	}, ; 485
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x0200034f, ; uint32_t type_token_id
		i32 350; uint32_t java_name_index
	}, ; 486
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 561; uint32_t java_name_index
	}, ; 487
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020000b5, ; uint32_t type_token_id
		i32 1; uint32_t java_name_index
	}, ; 488
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000435, ; uint32_t type_token_id
		i32 497; uint32_t java_name_index
	}, ; 489
	%struct.TypeMapJava {
		i32 21, ; uint32_t module_index
		i32 u0x020000a9, ; uint32_t type_token_id
		i32 982; uint32_t java_name_index
	}, ; 490
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000362, ; uint32_t type_token_id
		i32 368; uint32_t java_name_index
	}, ; 491
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x0200037c, ; uint32_t type_token_id
		i32 388; uint32_t java_name_index
	}, ; 492
	%struct.TypeMapJava {
		i32 18, ; uint32_t module_index
		i32 u0x02000067, ; uint32_t type_token_id
		i32 877; uint32_t java_name_index
	}, ; 493
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x0200019c, ; uint32_t type_token_id
		i32 135; uint32_t java_name_index
	}, ; 494
	%struct.TypeMapJava {
		i32 8, ; uint32_t module_index
		i32 u0x02000151, ; uint32_t type_token_id
		i32 672; uint32_t java_name_index
	}, ; 495
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000474, ; uint32_t type_token_id
		i32 531; uint32_t java_name_index
	}, ; 496
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 242; uint32_t java_name_index
	}, ; 497
	%struct.TypeMapJava {
		i32 8, ; uint32_t module_index
		i32 u0x02000243, ; uint32_t type_token_id
		i32 712; uint32_t java_name_index
	}, ; 498
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000336, ; uint32_t type_token_id
		i32 329; uint32_t java_name_index
	}, ; 499
	%struct.TypeMapJava {
		i32 14, ; uint32_t module_index
		i32 u0x0200004e, ; uint32_t type_token_id
		i32 754; uint32_t java_name_index
	}, ; 500
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020003d9, ; uint32_t type_token_id
		i32 443; uint32_t java_name_index
	}, ; 501
	%struct.TypeMapJava {
		i32 21, ; uint32_t module_index
		i32 u0x020000af, ; uint32_t type_token_id
		i32 986; uint32_t java_name_index
	}, ; 502
	%struct.TypeMapJava {
		i32 34, ; uint32_t module_index
		i32 u0x020003f3, ; uint32_t type_token_id
		i32 1196; uint32_t java_name_index
	}, ; 503
	%struct.TypeMapJava {
		i32 34, ; uint32_t module_index
		i32 u0x020003ec, ; uint32_t type_token_id
		i32 1191; uint32_t java_name_index
	}, ; 504
	%struct.TypeMapJava {
		i32 8, ; uint32_t module_index
		i32 u0x0200017c, ; uint32_t type_token_id
		i32 699; uint32_t java_name_index
	}, ; 505
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000407, ; uint32_t type_token_id
		i32 467; uint32_t java_name_index
	}, ; 506
	%struct.TypeMapJava {
		i32 16, ; uint32_t module_index
		i32 u0x0200000d, ; uint32_t type_token_id
		i32 813; uint32_t java_name_index
	}, ; 507
	%struct.TypeMapJava {
		i32 8, ; uint32_t module_index
		i32 u0x02000164, ; uint32_t type_token_id
		i32 690; uint32_t java_name_index
	}, ; 508
	%struct.TypeMapJava {
		i32 35, ; uint32_t module_index
		i32 u0x0200004b, ; uint32_t type_token_id
		i32 1220; uint32_t java_name_index
	}, ; 509
	%struct.TypeMapJava {
		i32 14, ; uint32_t module_index
		i32 u0x020000c0, ; uint32_t type_token_id
		i32 807; uint32_t java_name_index
	}, ; 510
	%struct.TypeMapJava {
		i32 11, ; uint32_t module_index
		i32 u0x0200001a, ; uint32_t type_token_id
		i32 728; uint32_t java_name_index
	}, ; 511
	%struct.TypeMapJava {
		i32 18, ; uint32_t module_index
		i32 u0x02000056, ; uint32_t type_token_id
		i32 866; uint32_t java_name_index
	}, ; 512
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000278, ; uint32_t type_token_id
		i32 255; uint32_t java_name_index
	}, ; 513
	%struct.TypeMapJava {
		i32 14, ; uint32_t module_index
		i32 u0x020000a8, ; uint32_t type_token_id
		i32 795; uint32_t java_name_index
	}, ; 514
	%struct.TypeMapJava {
		i32 18, ; uint32_t module_index
		i32 u0x0200005b, ; uint32_t type_token_id
		i32 870; uint32_t java_name_index
	}, ; 515
	%struct.TypeMapJava {
		i32 18, ; uint32_t module_index
		i32 u0x02000087, ; uint32_t type_token_id
		i32 894; uint32_t java_name_index
	}, ; 516
	%struct.TypeMapJava {
		i32 35, ; uint32_t module_index
		i32 u0x02000056, ; uint32_t type_token_id
		i32 1227; uint32_t java_name_index
	}, ; 517
	%struct.TypeMapJava {
		i32 32, ; uint32_t module_index
		i32 u0x02000019, ; uint32_t type_token_id
		i32 1095; uint32_t java_name_index
	}, ; 518
	%struct.TypeMapJava {
		i32 16, ; uint32_t module_index
		i32 u0x0200000c, ; uint32_t type_token_id
		i32 812; uint32_t java_name_index
	}, ; 519
	%struct.TypeMapJava {
		i32 24, ; uint32_t module_index
		i32 u0x02000004, ; uint32_t type_token_id
		i32 1002; uint32_t java_name_index
	}, ; 520
	%struct.TypeMapJava {
		i32 18, ; uint32_t module_index
		i32 u0x0200007e, ; uint32_t type_token_id
		i32 888; uint32_t java_name_index
	}, ; 521
	%struct.TypeMapJava {
		i32 35, ; uint32_t module_index
		i32 u0x02000062, ; uint32_t type_token_id
		i32 1234; uint32_t java_name_index
	}, ; 522
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020001a8, ; uint32_t type_token_id
		i32 142; uint32_t java_name_index
	}, ; 523
	%struct.TypeMapJava {
		i32 38, ; uint32_t module_index
		i32 u0x02000029, ; uint32_t type_token_id
		i32 1260; uint32_t java_name_index
	}, ; 524
	%struct.TypeMapJava {
		i32 21, ; uint32_t module_index
		i32 u0x02000096, ; uint32_t type_token_id
		i32 968; uint32_t java_name_index
	}, ; 525
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020001cb, ; uint32_t type_token_id
		i32 167; uint32_t java_name_index
	}, ; 526
	%struct.TypeMapJava {
		i32 8, ; uint32_t module_index
		i32 u0x0200018b, ; uint32_t type_token_id
		i32 703; uint32_t java_name_index
	}, ; 527
	%struct.TypeMapJava {
		i32 25, ; uint32_t module_index
		i32 u0x02000041, ; uint32_t type_token_id
		i32 1010; uint32_t java_name_index
	}, ; 528
	%struct.TypeMapJava {
		i32 25, ; uint32_t module_index
		i32 u0x02000097, ; uint32_t type_token_id
		i32 1052; uint32_t java_name_index
	}, ; 529
	%struct.TypeMapJava {
		i32 26, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 1064; uint32_t java_name_index
	}, ; 530
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020004a9, ; uint32_t type_token_id
		i32 573; uint32_t java_name_index
	}, ; 531
	%struct.TypeMapJava {
		i32 8, ; uint32_t module_index
		i32 u0x0200016a, ; uint32_t type_token_id
		i32 694; uint32_t java_name_index
	}, ; 532
	%struct.TypeMapJava {
		i32 17, ; uint32_t module_index
		i32 u0x02000199, ; uint32_t type_token_id
		i32 856; uint32_t java_name_index
	}, ; 533
	%struct.TypeMapJava {
		i32 37, ; uint32_t module_index
		i32 u0x02000019, ; uint32_t type_token_id
		i32 1247; uint32_t java_name_index
	}, ; 534
	%struct.TypeMapJava {
		i32 34, ; uint32_t module_index
		i32 u0x02000395, ; uint32_t type_token_id
		i32 1132; uint32_t java_name_index
	}, ; 535
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000234, ; uint32_t type_token_id
		i32 221; uint32_t java_name_index
	}, ; 536
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000339, ; uint32_t type_token_id
		i32 331; uint32_t java_name_index
	}, ; 537
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020003ed, ; uint32_t type_token_id
		i32 449; uint32_t java_name_index
	}, ; 538
	%struct.TypeMapJava {
		i32 34, ; uint32_t module_index
		i32 u0x02000624, ; uint32_t type_token_id
		i32 1163; uint32_t java_name_index
	}, ; 539
	%struct.TypeMapJava {
		i32 21, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 944; uint32_t java_name_index
	}, ; 540
	%struct.TypeMapJava {
		i32 34, ; uint32_t module_index
		i32 u0x020003d0, ; uint32_t type_token_id
		i32 1172; uint32_t java_name_index
	}, ; 541
	%struct.TypeMapJava {
		i32 34, ; uint32_t module_index
		i32 u0x02000627, ; uint32_t type_token_id
		i32 1177; uint32_t java_name_index
	}, ; 542
	%struct.TypeMapJava {
		i32 37, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 1238; uint32_t java_name_index
	}, ; 543
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020001bc, ; uint32_t type_token_id
		i32 156; uint32_t java_name_index
	}, ; 544
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020000d9, ; uint32_t type_token_id
		i32 23; uint32_t java_name_index
	}, ; 545
	%struct.TypeMapJava {
		i32 22, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 992; uint32_t java_name_index
	}, ; 546
	%struct.TypeMapJava {
		i32 32, ; uint32_t module_index
		i32 u0x02000015, ; uint32_t type_token_id
		i32 1092; uint32_t java_name_index
	}, ; 547
	%struct.TypeMapJava {
		i32 18, ; uint32_t module_index
		i32 u0x02000084, ; uint32_t type_token_id
		i32 892; uint32_t java_name_index
	}, ; 548
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000102, ; uint32_t type_token_id
		i32 51; uint32_t java_name_index
	}, ; 549
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020002de, ; uint32_t type_token_id
		i32 303; uint32_t java_name_index
	}, ; 550
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000413, ; uint32_t type_token_id
		i32 475; uint32_t java_name_index
	}, ; 551
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000371, ; uint32_t type_token_id
		i32 380; uint32_t java_name_index
	}, ; 552
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x0200035a, ; uint32_t type_token_id
		i32 360; uint32_t java_name_index
	}, ; 553
	%struct.TypeMapJava {
		i32 34, ; uint32_t module_index
		i32 u0x02000633, ; uint32_t type_token_id
		i32 1200; uint32_t java_name_index
	}, ; 554
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 508; uint32_t java_name_index
	}, ; 555
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000482, ; uint32_t type_token_id
		i32 545; uint32_t java_name_index
	}, ; 556
	%struct.TypeMapJava {
		i32 8, ; uint32_t module_index
		i32 u0x02000160, ; uint32_t type_token_id
		i32 687; uint32_t java_name_index
	}, ; 557
	%struct.TypeMapJava {
		i32 35, ; uint32_t module_index
		i32 u0x02000048, ; uint32_t type_token_id
		i32 1218; uint32_t java_name_index
	}, ; 558
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 442; uint32_t java_name_index
	}, ; 559
	%struct.TypeMapJava {
		i32 21, ; uint32_t module_index
		i32 u0x0200004a, ; uint32_t type_token_id
		i32 921; uint32_t java_name_index
	}, ; 560
	%struct.TypeMapJava {
		i32 38, ; uint32_t module_index
		i32 u0x02000037, ; uint32_t type_token_id
		i32 1267; uint32_t java_name_index
	}, ; 561
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x0200034a, ; uint32_t type_token_id
		i32 345; uint32_t java_name_index
	}, ; 562
	%struct.TypeMapJava {
		i32 21, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 949; uint32_t java_name_index
	}, ; 563
	%struct.TypeMapJava {
		i32 21, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 952; uint32_t java_name_index
	}, ; 564
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 558; uint32_t java_name_index
	}, ; 565
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 511; uint32_t java_name_index
	}, ; 566
	%struct.TypeMapJava {
		i32 8, ; uint32_t module_index
		i32 u0x02000136, ; uint32_t type_token_id
		i32 662; uint32_t java_name_index
	}, ; 567
	%struct.TypeMapJava {
		i32 25, ; uint32_t module_index
		i32 u0x0200003d, ; uint32_t type_token_id
		i32 1006; uint32_t java_name_index
	}, ; 568
	%struct.TypeMapJava {
		i32 30, ; uint32_t module_index
		i32 u0x02000006, ; uint32_t type_token_id
		i32 1082; uint32_t java_name_index
	}, ; 569
	%struct.TypeMapJava {
		i32 34, ; uint32_t module_index
		i32 u0x02000364, ; uint32_t type_token_id
		i32 1111; uint32_t java_name_index
	}, ; 570
	%struct.TypeMapJava {
		i32 23, ; uint32_t module_index
		i32 u0x02000036, ; uint32_t type_token_id
		i32 995; uint32_t java_name_index
	}, ; 571
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020001cf, ; uint32_t type_token_id
		i32 171; uint32_t java_name_index
	}, ; 572
	%struct.TypeMapJava {
		i32 8, ; uint32_t module_index
		i32 u0x02000168, ; uint32_t type_token_id
		i32 692; uint32_t java_name_index
	}, ; 573
	%struct.TypeMapJava {
		i32 34, ; uint32_t module_index
		i32 u0x0200061b, ; uint32_t type_token_id
		i32 1149; uint32_t java_name_index
	}, ; 574
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020004be, ; uint32_t type_token_id
		i32 579; uint32_t java_name_index
	}, ; 575
	%struct.TypeMapJava {
		i32 21, ; uint32_t module_index
		i32 u0x0200008a, ; uint32_t type_token_id
		i32 958; uint32_t java_name_index
	}, ; 576
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 259; uint32_t java_name_index
	}, ; 577
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000341, ; uint32_t type_token_id
		i32 337; uint32_t java_name_index
	}, ; 578
	%struct.TypeMapJava {
		i32 6, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 625; uint32_t java_name_index
	}, ; 579
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 227; uint32_t java_name_index
	}, ; 580
	%struct.TypeMapJava {
		i32 13, ; uint32_t module_index
		i32 u0x02000010, ; uint32_t type_token_id
		i32 740; uint32_t java_name_index
	}, ; 581
	%struct.TypeMapJava {
		i32 34, ; uint32_t module_index
		i32 u0x02000397, ; uint32_t type_token_id
		i32 1134; uint32_t java_name_index
	}, ; 582
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000367, ; uint32_t type_token_id
		i32 372; uint32_t java_name_index
	}, ; 583
	%struct.TypeMapJava {
		i32 6, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 639; uint32_t java_name_index
	}, ; 584
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 68; uint32_t java_name_index
	}, ; 585
	%struct.TypeMapJava {
		i32 34, ; uint32_t module_index
		i32 u0x02000606, ; uint32_t type_token_id
		i32 1128; uint32_t java_name_index
	}, ; 586
	%struct.TypeMapJava {
		i32 35, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 1214; uint32_t java_name_index
	}, ; 587
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000388, ; uint32_t type_token_id
		i32 395; uint32_t java_name_index
	}, ; 588
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x0200012f, ; uint32_t type_token_id
		i32 76; uint32_t java_name_index
	}, ; 589
	%struct.TypeMapJava {
		i32 21, ; uint32_t module_index
		i32 u0x02000093, ; uint32_t type_token_id
		i32 966; uint32_t java_name_index
	}, ; 590
	%struct.TypeMapJava {
		i32 23, ; uint32_t module_index
		i32 u0x0200000a, ; uint32_t type_token_id
		i32 993; uint32_t java_name_index
	}, ; 591
	%struct.TypeMapJava {
		i32 16, ; uint32_t module_index
		i32 u0x02000011, ; uint32_t type_token_id
		i32 815; uint32_t java_name_index
	}, ; 592
	%struct.TypeMapJava {
		i32 25, ; uint32_t module_index
		i32 u0x0200007a, ; uint32_t type_token_id
		i32 1042; uint32_t java_name_index
	}, ; 593
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 112; uint32_t java_name_index
	}, ; 594
	%struct.TypeMapJava {
		i32 8, ; uint32_t module_index
		i32 u0x02000131, ; uint32_t type_token_id
		i32 661; uint32_t java_name_index
	}, ; 595
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 25; uint32_t java_name_index
	}, ; 596
	%struct.TypeMapJava {
		i32 12, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 732; uint32_t java_name_index
	}, ; 597
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020001bb, ; uint32_t type_token_id
		i32 155; uint32_t java_name_index
	}, ; 598
	%struct.TypeMapJava {
		i32 19, ; uint32_t module_index
		i32 u0x02000012, ; uint32_t type_token_id
		i32 904; uint32_t java_name_index
	}, ; 599
	%struct.TypeMapJava {
		i32 22, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 991; uint32_t java_name_index
	}, ; 600
	%struct.TypeMapJava {
		i32 21, ; uint32_t module_index
		i32 u0x02000057, ; uint32_t type_token_id
		i32 932; uint32_t java_name_index
	}, ; 601
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x0200013c, ; uint32_t type_token_id
		i32 82; uint32_t java_name_index
	}, ; 602
	%struct.TypeMapJava {
		i32 34, ; uint32_t module_index
		i32 u0x02000604, ; uint32_t type_token_id
		i32 1127; uint32_t java_name_index
	}, ; 603
	%struct.TypeMapJava {
		i32 19, ; uint32_t module_index
		i32 u0x0200000e, ; uint32_t type_token_id
		i32 901; uint32_t java_name_index
	}, ; 604
	%struct.TypeMapJava {
		i32 18, ; uint32_t module_index
		i32 u0x0200007b, ; uint32_t type_token_id
		i32 886; uint32_t java_name_index
	}, ; 605
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020001c9, ; uint32_t type_token_id
		i32 165; uint32_t java_name_index
	}, ; 606
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020000ef, ; uint32_t type_token_id
		i32 35; uint32_t java_name_index
	}, ; 607
	%struct.TypeMapJava {
		i32 34, ; uint32_t module_index
		i32 u0x020003ba, ; uint32_t type_token_id
		i32 1161; uint32_t java_name_index
	}, ; 608
	%struct.TypeMapJava {
		i32 34, ; uint32_t module_index
		i32 u0x020005f9, ; uint32_t type_token_id
		i32 1119; uint32_t java_name_index
	}, ; 609
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000419, ; uint32_t type_token_id
		i32 480; uint32_t java_name_index
	}, ; 610
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x0200041f, ; uint32_t type_token_id
		i32 483; uint32_t java_name_index
	}, ; 611
	%struct.TypeMapJava {
		i32 25, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 1011; uint32_t java_name_index
	}, ; 612
	%struct.TypeMapJava {
		i32 14, ; uint32_t module_index
		i32 u0x0200009f, ; uint32_t type_token_id
		i32 789; uint32_t java_name_index
	}, ; 613
	%struct.TypeMapJava {
		i32 21, ; uint32_t module_index
		i32 u0x02000092, ; uint32_t type_token_id
		i32 965; uint32_t java_name_index
	}, ; 614
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x0200030d, ; uint32_t type_token_id
		i32 313; uint32_t java_name_index
	}, ; 615
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000330, ; uint32_t type_token_id
		i32 324; uint32_t java_name_index
	}, ; 616
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000247, ; uint32_t type_token_id
		i32 232; uint32_t java_name_index
	}, ; 617
	%struct.TypeMapJava {
		i32 15, ; uint32_t module_index
		i32 u0x020000a8, ; uint32_t type_token_id
		i32 810; uint32_t java_name_index
	}, ; 618
	%struct.TypeMapJava {
		i32 34, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 1187; uint32_t java_name_index
	}, ; 619
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020000bb, ; uint32_t type_token_id
		i32 4; uint32_t java_name_index
	}, ; 620
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x0200019b, ; uint32_t type_token_id
		i32 134; uint32_t java_name_index
	}, ; 621
	%struct.TypeMapJava {
		i32 25, ; uint32_t module_index
		i32 u0x02000054, ; uint32_t type_token_id
		i32 1019; uint32_t java_name_index
	}, ; 622
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000386, ; uint32_t type_token_id
		i32 393; uint32_t java_name_index
	}, ; 623
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020000f6, ; uint32_t type_token_id
		i32 41; uint32_t java_name_index
	}, ; 624
	%struct.TypeMapJava {
		i32 25, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 1044; uint32_t java_name_index
	}, ; 625
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x0200017c, ; uint32_t type_token_id
		i32 121; uint32_t java_name_index
	}, ; 626
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020001e5, ; uint32_t type_token_id
		i32 187; uint32_t java_name_index
	}, ; 627
	%struct.TypeMapJava {
		i32 32, ; uint32_t module_index
		i32 u0x0200001a, ; uint32_t type_token_id
		i32 1096; uint32_t java_name_index
	}, ; 628
	%struct.TypeMapJava {
		i32 8, ; uint32_t module_index
		i32 u0x0200015d, ; uint32_t type_token_id
		i32 684; uint32_t java_name_index
	}, ; 629
	%struct.TypeMapJava {
		i32 17, ; uint32_t module_index
		i32 u0x020000ca, ; uint32_t type_token_id
		i32 833; uint32_t java_name_index
	}, ; 630
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000453, ; uint32_t type_token_id
		i32 513; uint32_t java_name_index
	}, ; 631
	%struct.TypeMapJava {
		i32 4, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 610; uint32_t java_name_index
	}, ; 632
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 472; uint32_t java_name_index
	}, ; 633
	%struct.TypeMapJava {
		i32 34, ; uint32_t module_index
		i32 u0x020003d8, ; uint32_t type_token_id
		i32 1180; uint32_t java_name_index
	}, ; 634
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000409, ; uint32_t type_token_id
		i32 469; uint32_t java_name_index
	}, ; 635
	%struct.TypeMapJava {
		i32 21, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 972; uint32_t java_name_index
	}, ; 636
	%struct.TypeMapJava {
		i32 26, ; uint32_t module_index
		i32 u0x02000040, ; uint32_t type_token_id
		i32 1071; uint32_t java_name_index
	}, ; 637
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020003f0, ; uint32_t type_token_id
		i32 451; uint32_t java_name_index
	}, ; 638
	%struct.TypeMapJava {
		i32 21, ; uint32_t module_index
		i32 u0x02000055, ; uint32_t type_token_id
		i32 930; uint32_t java_name_index
	}, ; 639
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000235, ; uint32_t type_token_id
		i32 222; uint32_t java_name_index
	}, ; 640
	%struct.TypeMapJava {
		i32 17, ; uint32_t module_index
		i32 u0x0200002d, ; uint32_t type_token_id
		i32 822; uint32_t java_name_index
	}, ; 641
	%struct.TypeMapJava {
		i32 27, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 1073; uint32_t java_name_index
	}, ; 642
	%struct.TypeMapJava {
		i32 17, ; uint32_t module_index
		i32 u0x0200018e, ; uint32_t type_token_id
		i32 851; uint32_t java_name_index
	}, ; 643
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x0200036d, ; uint32_t type_token_id
		i32 377; uint32_t java_name_index
	}, ; 644
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 104; uint32_t java_name_index
	}, ; 645
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 267; uint32_t java_name_index
	}, ; 646
	%struct.TypeMapJava {
		i32 25, ; uint32_t module_index
		i32 u0x02000089, ; uint32_t type_token_id
		i32 1049; uint32_t java_name_index
	}, ; 647
	%struct.TypeMapJava {
		i32 14, ; uint32_t module_index
		i32 u0x0200005d, ; uint32_t type_token_id
		i32 760; uint32_t java_name_index
	}, ; 648
	%struct.TypeMapJava {
		i32 21, ; uint32_t module_index
		i32 u0x02000076, ; uint32_t type_token_id
		i32 946; uint32_t java_name_index
	}, ; 649
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020001af, ; uint32_t type_token_id
		i32 148; uint32_t java_name_index
	}, ; 650
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000172, ; uint32_t type_token_id
		i32 115; uint32_t java_name_index
	}, ; 651
	%struct.TypeMapJava {
		i32 8, ; uint32_t module_index
		i32 u0x0200033b, ; uint32_t type_token_id
		i32 710; uint32_t java_name_index
	}, ; 652
	%struct.TypeMapJava {
		i32 6, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 632; uint32_t java_name_index
	}, ; 653
	%struct.TypeMapJava {
		i32 21, ; uint32_t module_index
		i32 u0x020000a1, ; uint32_t type_token_id
		i32 974; uint32_t java_name_index
	}, ; 654
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 383; uint32_t java_name_index
	}, ; 655
	%struct.TypeMapJava {
		i32 8, ; uint32_t module_index
		i32 u0x020002c4, ; uint32_t type_token_id
		i32 677; uint32_t java_name_index
	}, ; 656
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x0200017d, ; uint32_t type_token_id
		i32 122; uint32_t java_name_index
	}, ; 657
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020002ac, ; uint32_t type_token_id
		i32 274; uint32_t java_name_index
	}, ; 658
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 541; uint32_t java_name_index
	}, ; 659
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000387, ; uint32_t type_token_id
		i32 394; uint32_t java_name_index
	}, ; 660
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000297, ; uint32_t type_token_id
		i32 265; uint32_t java_name_index
	}, ; 661
	%struct.TypeMapJava {
		i32 41, ; uint32_t module_index
		i32 u0x0200001d, ; uint32_t type_token_id
		i32 1281; uint32_t java_name_index
	}, ; 662
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020004a2, ; uint32_t type_token_id
		i32 567; uint32_t java_name_index
	}, ; 663
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 150; uint32_t java_name_index
	}, ; 664
	%struct.TypeMapJava {
		i32 21, ; uint32_t module_index
		i32 u0x0200006f, ; uint32_t type_token_id
		i32 945; uint32_t java_name_index
	}, ; 665
	%struct.TypeMapJava {
		i32 34, ; uint32_t module_index
		i32 u0x0200039e, ; uint32_t type_token_id
		i32 1144; uint32_t java_name_index
	}, ; 666
	%struct.TypeMapJava {
		i32 38, ; uint32_t module_index
		i32 u0x0200004b, ; uint32_t type_token_id
		i32 1270; uint32_t java_name_index
	}, ; 667
	%struct.TypeMapJava {
		i32 18, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 882; uint32_t java_name_index
	}, ; 668
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000485, ; uint32_t type_token_id
		i32 548; uint32_t java_name_index
	}, ; 669
	%struct.TypeMapJava {
		i32 8, ; uint32_t module_index
		i32 u0x02000162, ; uint32_t type_token_id
		i32 688; uint32_t java_name_index
	}, ; 670
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000432, ; uint32_t type_token_id
		i32 495; uint32_t java_name_index
	}, ; 671
	%struct.TypeMapJava {
		i32 8, ; uint32_t module_index
		i32 u0x0200014d, ; uint32_t type_token_id
		i32 669; uint32_t java_name_index
	}, ; 672
	%struct.TypeMapJava {
		i32 34, ; uint32_t module_index
		i32 u0x02000398, ; uint32_t type_token_id
		i32 1135; uint32_t java_name_index
	}, ; 673
	%struct.TypeMapJava {
		i32 26, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 1070; uint32_t java_name_index
	}, ; 674
	%struct.TypeMapJava {
		i32 34, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 1186; uint32_t java_name_index
	}, ; 675
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000291, ; uint32_t type_token_id
		i32 262; uint32_t java_name_index
	}, ; 676
	%struct.TypeMapJava {
		i32 8, ; uint32_t module_index
		i32 u0x02000153, ; uint32_t type_token_id
		i32 674; uint32_t java_name_index
	}, ; 677
	%struct.TypeMapJava {
		i32 14, ; uint32_t module_index
		i32 u0x020000a9, ; uint32_t type_token_id
		i32 796; uint32_t java_name_index
	}, ; 678
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 8; uint32_t java_name_index
	}, ; 679
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000478, ; uint32_t type_token_id
		i32 535; uint32_t java_name_index
	}, ; 680
	%struct.TypeMapJava {
		i32 25, ; uint32_t module_index
		i32 u0x02000050, ; uint32_t type_token_id
		i32 1016; uint32_t java_name_index
	}, ; 681
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 510; uint32_t java_name_index
	}, ; 682
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 448; uint32_t java_name_index
	}, ; 683
	%struct.TypeMapJava {
		i32 23, ; uint32_t module_index
		i32 u0x0200007a, ; uint32_t type_token_id
		i32 997; uint32_t java_name_index
	}, ; 684
	%struct.TypeMapJava {
		i32 8, ; uint32_t module_index
		i32 u0x0200015c, ; uint32_t type_token_id
		i32 683; uint32_t java_name_index
	}, ; 685
	%struct.TypeMapJava {
		i32 21, ; uint32_t module_index
		i32 u0x02000043, ; uint32_t type_token_id
		i32 915; uint32_t java_name_index
	}, ; 686
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000151, ; uint32_t type_token_id
		i32 94; uint32_t java_name_index
	}, ; 687
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 518; uint32_t java_name_index
	}, ; 688
	%struct.TypeMapJava {
		i32 14, ; uint32_t module_index
		i32 u0x0200007e, ; uint32_t type_token_id
		i32 775; uint32_t java_name_index
	}, ; 689
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020003c0, ; uint32_t type_token_id
		i32 429; uint32_t java_name_index
	}, ; 690
	%struct.TypeMapJava {
		i32 18, ; uint32_t module_index
		i32 u0x0200005a, ; uint32_t type_token_id
		i32 869; uint32_t java_name_index
	}, ; 691
	%struct.TypeMapJava {
		i32 13, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 734; uint32_t java_name_index
	}, ; 692
	%struct.TypeMapJava {
		i32 35, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 1210; uint32_t java_name_index
	}, ; 693
	%struct.TypeMapJava {
		i32 18, ; uint32_t module_index
		i32 u0x02000059, ; uint32_t type_token_id
		i32 868; uint32_t java_name_index
	}, ; 694
	%struct.TypeMapJava {
		i32 25, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 1056; uint32_t java_name_index
	}, ; 695
	%struct.TypeMapJava {
		i32 17, ; uint32_t module_index
		i32 u0x02000190, ; uint32_t type_token_id
		i32 853; uint32_t java_name_index
	}, ; 696
	%struct.TypeMapJava {
		i32 34, ; uint32_t module_index
		i32 u0x02000607, ; uint32_t type_token_id
		i32 1131; uint32_t java_name_index
	}, ; 697
	%struct.TypeMapJava {
		i32 34, ; uint32_t module_index
		i32 u0x0200034f, ; uint32_t type_token_id
		i32 1104; uint32_t java_name_index
	}, ; 698
	%struct.TypeMapJava {
		i32 21, ; uint32_t module_index
		i32 u0x02000044, ; uint32_t type_token_id
		i32 916; uint32_t java_name_index
	}, ; 699
	%struct.TypeMapJava {
		i32 8, ; uint32_t module_index
		i32 u0x020002bd, ; uint32_t type_token_id
		i32 664; uint32_t java_name_index
	}, ; 700
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x0200023b, ; uint32_t type_token_id
		i32 226; uint32_t java_name_index
	}, ; 701
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000101, ; uint32_t type_token_id
		i32 50; uint32_t java_name_index
	}, ; 702
	%struct.TypeMapJava {
		i32 26, ; uint32_t module_index
		i32 u0x02000035, ; uint32_t type_token_id
		i32 1065; uint32_t java_name_index
	}, ; 703
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000280, ; uint32_t type_token_id
		i32 256; uint32_t java_name_index
	}, ; 704
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 131; uint32_t java_name_index
	}, ; 705
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x0200047f, ; uint32_t type_token_id
		i32 542; uint32_t java_name_index
	}, ; 706
	%struct.TypeMapJava {
		i32 34, ; uint32_t module_index
		i32 u0x020003b6, ; uint32_t type_token_id
		i32 1160; uint32_t java_name_index
	}, ; 707
	%struct.TypeMapJava {
		i32 8, ; uint32_t module_index
		i32 u0x0200033a, ; uint32_t type_token_id
		i32 709; uint32_t java_name_index
	}, ; 708
	%struct.TypeMapJava {
		i32 35, ; uint32_t module_index
		i32 u0x02000064, ; uint32_t type_token_id
		i32 1236; uint32_t java_name_index
	}, ; 709
	%struct.TypeMapJava {
		i32 21, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 950; uint32_t java_name_index
	}, ; 710
	%struct.TypeMapJava {
		i32 34, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 1150; uint32_t java_name_index
	}, ; 711
	%struct.TypeMapJava {
		i32 21, ; uint32_t module_index
		i32 u0x0200004c, ; uint32_t type_token_id
		i32 923; uint32_t java_name_index
	}, ; 712
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x0200031d, ; uint32_t type_token_id
		i32 317; uint32_t java_name_index
	}, ; 713
	%struct.TypeMapJava {
		i32 8, ; uint32_t module_index
		i32 u0x02000338, ; uint32_t type_token_id
		i32 708; uint32_t java_name_index
	}, ; 714
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020001ac, ; uint32_t type_token_id
		i32 146; uint32_t java_name_index
	}, ; 715
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 247; uint32_t java_name_index
	}, ; 716
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x0200048b, ; uint32_t type_token_id
		i32 553; uint32_t java_name_index
	}, ; 717
	%struct.TypeMapJava {
		i32 8, ; uint32_t module_index
		i32 u0x0200009b, ; uint32_t type_token_id
		i32 644; uint32_t java_name_index
	}, ; 718
	%struct.TypeMapJava {
		i32 35, ; uint32_t module_index
		i32 u0x02000054, ; uint32_t type_token_id
		i32 1225; uint32_t java_name_index
	}, ; 719
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000489, ; uint32_t type_token_id
		i32 551; uint32_t java_name_index
	}, ; 720
	%struct.TypeMapJava {
		i32 10, ; uint32_t module_index
		i32 u0x02000008, ; uint32_t type_token_id
		i32 720; uint32_t java_name_index
	}, ; 721
	%struct.TypeMapJava {
		i32 8, ; uint32_t module_index
		i32 u0x020000b7, ; uint32_t type_token_id
		i32 647; uint32_t java_name_index
	}, ; 722
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000143, ; uint32_t type_token_id
		i32 85; uint32_t java_name_index
	}, ; 723
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020000f4, ; uint32_t type_token_id
		i32 39; uint32_t java_name_index
	}, ; 724
	%struct.TypeMapJava {
		i32 23, ; uint32_t module_index
		i32 u0x0200009a, ; uint32_t type_token_id
		i32 1001; uint32_t java_name_index
	}, ; 725
	%struct.TypeMapJava {
		i32 32, ; uint32_t module_index
		i32 u0x02000010, ; uint32_t type_token_id
		i32 1091; uint32_t java_name_index
	}, ; 726
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 522; uint32_t java_name_index
	}, ; 727
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020003de, ; uint32_t type_token_id
		i32 446; uint32_t java_name_index
	}, ; 728
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020001ba, ; uint32_t type_token_id
		i32 154; uint32_t java_name_index
	}, ; 729
	%struct.TypeMapJava {
		i32 34, ; uint32_t module_index
		i32 u0x0200036b, ; uint32_t type_token_id
		i32 1115; uint32_t java_name_index
	}, ; 730
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x0200034d, ; uint32_t type_token_id
		i32 348; uint32_t java_name_index
	}, ; 731
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020004a7, ; uint32_t type_token_id
		i32 571; uint32_t java_name_index
	}, ; 732
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x0200032a, ; uint32_t type_token_id
		i32 320; uint32_t java_name_index
	}, ; 733
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020003a0, ; uint32_t type_token_id
		i32 409; uint32_t java_name_index
	}, ; 734
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020002d7, ; uint32_t type_token_id
		i32 298; uint32_t java_name_index
	}, ; 735
	%struct.TypeMapJava {
		i32 14, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 786; uint32_t java_name_index
	}, ; 736
	%struct.TypeMapJava {
		i32 6, ; uint32_t module_index
		i32 u0x0200002a, ; uint32_t type_token_id
		i32 630; uint32_t java_name_index
	}, ; 737
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 92; uint32_t java_name_index
	}, ; 738
	%struct.TypeMapJava {
		i32 21, ; uint32_t module_index
		i32 u0x02000060, ; uint32_t type_token_id
		i32 937; uint32_t java_name_index
	}, ; 739
	%struct.TypeMapJava {
		i32 32, ; uint32_t module_index
		i32 u0x02000013, ; uint32_t type_token_id
		i32 1090; uint32_t java_name_index
	}, ; 740
	%struct.TypeMapJava {
		i32 34, ; uint32_t module_index
		i32 u0x020003d7, ; uint32_t type_token_id
		i32 1179; uint32_t java_name_index
	}, ; 741
	%struct.TypeMapJava {
		i32 21, ; uint32_t module_index
		i32 u0x02000066, ; uint32_t type_token_id
		i32 940; uint32_t java_name_index
	}, ; 742
	%struct.TypeMapJava {
		i32 28, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 1079; uint32_t java_name_index
	}, ; 743
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x0200047d, ; uint32_t type_token_id
		i32 540; uint32_t java_name_index
	}, ; 744
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000337, ; uint32_t type_token_id
		i32 330; uint32_t java_name_index
	}, ; 745
	%struct.TypeMapJava {
		i32 14, ; uint32_t module_index
		i32 u0x0200004d, ; uint32_t type_token_id
		i32 753; uint32_t java_name_index
	}, ; 746
	%struct.TypeMapJava {
		i32 12, ; uint32_t module_index
		i32 u0x02000004, ; uint32_t type_token_id
		i32 729; uint32_t java_name_index
	}, ; 747
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 151; uint32_t java_name_index
	}, ; 748
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x0200038d, ; uint32_t type_token_id
		i32 398; uint32_t java_name_index
	}, ; 749
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020002c9, ; uint32_t type_token_id
		i32 291; uint32_t java_name_index
	}, ; 750
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020003bf, ; uint32_t type_token_id
		i32 428; uint32_t java_name_index
	}, ; 751
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020002fd, ; uint32_t type_token_id
		i32 309; uint32_t java_name_index
	}, ; 752
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x0200042c, ; uint32_t type_token_id
		i32 490; uint32_t java_name_index
	}, ; 753
	%struct.TypeMapJava {
		i32 8, ; uint32_t module_index
		i32 u0x0200014f, ; uint32_t type_token_id
		i32 670; uint32_t java_name_index
	}, ; 754
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 183; uint32_t java_name_index
	}, ; 755
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x0200042d, ; uint32_t type_token_id
		i32 491; uint32_t java_name_index
	}, ; 756
	%struct.TypeMapJava {
		i32 17, ; uint32_t module_index
		i32 u0x02000080, ; uint32_t type_token_id
		i32 823; uint32_t java_name_index
	}, ; 757
	%struct.TypeMapJava {
		i32 37, ; uint32_t module_index
		i32 u0x02000016, ; uint32_t type_token_id
		i32 1244; uint32_t java_name_index
	}, ; 758
	%struct.TypeMapJava {
		i32 8, ; uint32_t module_index
		i32 u0x0200014a, ; uint32_t type_token_id
		i32 666; uint32_t java_name_index
	}, ; 759
	%struct.TypeMapJava {
		i32 21, ; uint32_t module_index
		i32 u0x0200004d, ; uint32_t type_token_id
		i32 924; uint32_t java_name_index
	}, ; 760
	%struct.TypeMapJava {
		i32 33, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 1100; uint32_t java_name_index
	}, ; 761
	%struct.TypeMapJava {
		i32 34, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 1154; uint32_t java_name_index
	}, ; 762
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020003c8, ; uint32_t type_token_id
		i32 432; uint32_t java_name_index
	}, ; 763
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x0200033d, ; uint32_t type_token_id
		i32 333; uint32_t java_name_index
	}, ; 764
	%struct.TypeMapJava {
		i32 37, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 1250; uint32_t java_name_index
	}, ; 765
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x0200029d, ; uint32_t type_token_id
		i32 268; uint32_t java_name_index
	}, ; 766
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 130; uint32_t java_name_index
	}, ; 767
	%struct.TypeMapJava {
		i32 14, ; uint32_t module_index
		i32 u0x020000ac, ; uint32_t type_token_id
		i32 798; uint32_t java_name_index
	}, ; 768
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 521; uint32_t java_name_index
	}, ; 769
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 126; uint32_t java_name_index
	}, ; 770
	%struct.TypeMapJava {
		i32 6, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 621; uint32_t java_name_index
	}, ; 771
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 97; uint32_t java_name_index
	}, ; 772
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000245, ; uint32_t type_token_id
		i32 231; uint32_t java_name_index
	}, ; 773
	%struct.TypeMapJava {
		i32 34, ; uint32_t module_index
		i32 u0x02000363, ; uint32_t type_token_id
		i32 1110; uint32_t java_name_index
	}, ; 774
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000406, ; uint32_t type_token_id
		i32 466; uint32_t java_name_index
	}, ; 775
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000359, ; uint32_t type_token_id
		i32 359; uint32_t java_name_index
	}, ; 776
	%struct.TypeMapJava {
		i32 8, ; uint32_t module_index
		i32 u0x02000123, ; uint32_t type_token_id
		i32 658; uint32_t java_name_index
	}, ; 777
	%struct.TypeMapJava {
		i32 38, ; uint32_t module_index
		i32 u0x02000027, ; uint32_t type_token_id
		i32 1259; uint32_t java_name_index
	}, ; 778
	%struct.TypeMapJava {
		i32 35, ; uint32_t module_index
		i32 u0x0200004a, ; uint32_t type_token_id
		i32 1219; uint32_t java_name_index
	}, ; 779
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x0200042f, ; uint32_t type_token_id
		i32 493; uint32_t java_name_index
	}, ; 780
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020000f5, ; uint32_t type_token_id
		i32 40; uint32_t java_name_index
	}, ; 781
	%struct.TypeMapJava {
		i32 21, ; uint32_t module_index
		i32 u0x0200008f, ; uint32_t type_token_id
		i32 962; uint32_t java_name_index
	}, ; 782
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x0200021c, ; uint32_t type_token_id
		i32 216; uint32_t java_name_index
	}, ; 783
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000329, ; uint32_t type_token_id
		i32 319; uint32_t java_name_index
	}, ; 784
	%struct.TypeMapJava {
		i32 8, ; uint32_t module_index
		i32 u0x0200014c, ; uint32_t type_token_id
		i32 668; uint32_t java_name_index
	}, ; 785
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020004a4, ; uint32_t type_token_id
		i32 569; uint32_t java_name_index
	}, ; 786
	%struct.TypeMapJava {
		i32 13, ; uint32_t module_index
		i32 u0x0200000f, ; uint32_t type_token_id
		i32 739; uint32_t java_name_index
	}, ; 787
	%struct.TypeMapJava {
		i32 17, ; uint32_t module_index
		i32 u0x02000178, ; uint32_t type_token_id
		i32 845; uint32_t java_name_index
	}, ; 788
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000402, ; uint32_t type_token_id
		i32 463; uint32_t java_name_index
	}, ; 789
	%struct.TypeMapJava {
		i32 17, ; uint32_t module_index
		i32 u0x02000110, ; uint32_t type_token_id
		i32 840; uint32_t java_name_index
	}, ; 790
	%struct.TypeMapJava {
		i32 25, ; uint32_t module_index
		i32 u0x0200006f, ; uint32_t type_token_id
		i32 1037; uint32_t java_name_index
	}, ; 791
	%struct.TypeMapJava {
		i32 34, ; uint32_t module_index
		i32 u0x02000612, ; uint32_t type_token_id
		i32 1143; uint32_t java_name_index
	}, ; 792
	%struct.TypeMapJava {
		i32 38, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 1266; uint32_t java_name_index
	}, ; 793
	%struct.TypeMapJava {
		i32 21, ; uint32_t module_index
		i32 u0x0200008c, ; uint32_t type_token_id
		i32 960; uint32_t java_name_index
	}, ; 794
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x0200035b, ; uint32_t type_token_id
		i32 361; uint32_t java_name_index
	}, ; 795
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020001ed, ; uint32_t type_token_id
		i32 192; uint32_t java_name_index
	}, ; 796
	%struct.TypeMapJava {
		i32 37, ; uint32_t module_index
		i32 u0x0200001b, ; uint32_t type_token_id
		i32 1249; uint32_t java_name_index
	}, ; 797
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000167, ; uint32_t type_token_id
		i32 106; uint32_t java_name_index
	}, ; 798
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 197; uint32_t java_name_index
	}, ; 799
	%struct.TypeMapJava {
		i32 25, ; uint32_t module_index
		i32 u0x0200007b, ; uint32_t type_token_id
		i32 1043; uint32_t java_name_index
	}, ; 800
	%struct.TypeMapJava {
		i32 19, ; uint32_t module_index
		i32 u0x0200000f, ; uint32_t type_token_id
		i32 902; uint32_t java_name_index
	}, ; 801
	%struct.TypeMapJava {
		i32 17, ; uint32_t module_index
		i32 u0x02000185, ; uint32_t type_token_id
		i32 849; uint32_t java_name_index
	}, ; 802
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x0200036b, ; uint32_t type_token_id
		i32 375; uint32_t java_name_index
	}, ; 803
	%struct.TypeMapJava {
		i32 25, ; uint32_t module_index
		i32 u0x02000077, ; uint32_t type_token_id
		i32 1039; uint32_t java_name_index
	}, ; 804
	%struct.TypeMapJava {
		i32 6, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 615; uint32_t java_name_index
	}, ; 805
	%struct.TypeMapJava {
		i32 25, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 1059; uint32_t java_name_index
	}, ; 806
	%struct.TypeMapJava {
		i32 34, ; uint32_t module_index
		i32 u0x02000394, ; uint32_t type_token_id
		i32 1130; uint32_t java_name_index
	}, ; 807
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000168, ; uint32_t type_token_id
		i32 107; uint32_t java_name_index
	}, ; 808
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000351, ; uint32_t type_token_id
		i32 352; uint32_t java_name_index
	}, ; 809
	%struct.TypeMapJava {
		i32 13, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 738; uint32_t java_name_index
	}, ; 810
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x02000260, ; uint32_t type_token_id
		i32 592; uint32_t java_name_index
	}, ; 811
	%struct.TypeMapJava {
		i32 21, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 914; uint32_t java_name_index
	}, ; 812
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 203; uint32_t java_name_index
	}, ; 813
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020001cd, ; uint32_t type_token_id
		i32 169; uint32_t java_name_index
	}, ; 814
	%struct.TypeMapJava {
		i32 41, ; uint32_t module_index
		i32 u0x02000018, ; uint32_t type_token_id
		i32 1278; uint32_t java_name_index
	}, ; 815
	%struct.TypeMapJava {
		i32 25, ; uint32_t module_index
		i32 u0x02000064, ; uint32_t type_token_id
		i32 1027; uint32_t java_name_index
	}, ; 816
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 9; uint32_t java_name_index
	}, ; 817
	%struct.TypeMapJava {
		i32 25, ; uint32_t module_index
		i32 u0x0200003c, ; uint32_t type_token_id
		i32 1005; uint32_t java_name_index
	}, ; 818
	%struct.TypeMapJava {
		i32 34, ; uint32_t module_index
		i32 u0x020003fa, ; uint32_t type_token_id
		i32 1207; uint32_t java_name_index
	}, ; 819
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000107, ; uint32_t type_token_id
		i32 56; uint32_t java_name_index
	}, ; 820
	%struct.TypeMapJava {
		i32 41, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 1280; uint32_t java_name_index
	}, ; 821
	%struct.TypeMapJava {
		i32 14, ; uint32_t module_index
		i32 u0x02000045, ; uint32_t type_token_id
		i32 746; uint32_t java_name_index
	}, ; 822
	%struct.TypeMapJava {
		i32 6, ; uint32_t module_index
		i32 u0x02000029, ; uint32_t type_token_id
		i32 629; uint32_t java_name_index
	}, ; 823
	%struct.TypeMapJava {
		i32 25, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 1015; uint32_t java_name_index
	}, ; 824
	%struct.TypeMapJava {
		i32 3, ; uint32_t module_index
		i32 u0x02000005, ; uint32_t type_token_id
		i32 601; uint32_t java_name_index
	}, ; 825
	%struct.TypeMapJava {
		i32 34, ; uint32_t module_index
		i32 u0x020003b4, ; uint32_t type_token_id
		i32 1158; uint32_t java_name_index
	}, ; 826
	%struct.TypeMapJava {
		i32 18, ; uint32_t module_index
		i32 u0x0200006e, ; uint32_t type_token_id
		i32 881; uint32_t java_name_index
	}, ; 827
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000438, ; uint32_t type_token_id
		i32 499; uint32_t java_name_index
	}, ; 828
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 419; uint32_t java_name_index
	}, ; 829
	%struct.TypeMapJava {
		i32 8, ; uint32_t module_index
		i32 u0x0200034d, ; uint32_t type_token_id
		i32 714; uint32_t java_name_index
	}, ; 830
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x020000e9, ; uint32_t type_token_id
		i32 583; uint32_t java_name_index
	}, ; 831
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000127, ; uint32_t type_token_id
		i32 73; uint32_t java_name_index
	}, ; 832
	%struct.TypeMapJava {
		i32 23, ; uint32_t module_index
		i32 u0x02000099, ; uint32_t type_token_id
		i32 1000; uint32_t java_name_index
	}, ; 833
	%struct.TypeMapJava {
		i32 34, ; uint32_t module_index
		i32 u0x02000396, ; uint32_t type_token_id
		i32 1133; uint32_t java_name_index
	}, ; 834
	%struct.TypeMapJava {
		i32 37, ; uint32_t module_index
		i32 u0x0200001a, ; uint32_t type_token_id
		i32 1248; uint32_t java_name_index
	}, ; 835
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000404, ; uint32_t type_token_id
		i32 465; uint32_t java_name_index
	}, ; 836
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000350, ; uint32_t type_token_id
		i32 351; uint32_t java_name_index
	}, ; 837
	%struct.TypeMapJava {
		i32 34, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 1152; uint32_t java_name_index
	}, ; 838
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 133; uint32_t java_name_index
	}, ; 839
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000422, ; uint32_t type_token_id
		i32 485; uint32_t java_name_index
	}, ; 840
	%struct.TypeMapJava {
		i32 4, ; uint32_t module_index
		i32 u0x0200001d, ; uint32_t type_token_id
		i32 605; uint32_t java_name_index
	}, ; 841
	%struct.TypeMapJava {
		i32 13, ; uint32_t module_index
		i32 u0x0200000c, ; uint32_t type_token_id
		i32 737; uint32_t java_name_index
	}, ; 842
	%struct.TypeMapJava {
		i32 8, ; uint32_t module_index
		i32 u0x02000137, ; uint32_t type_token_id
		i32 663; uint32_t java_name_index
	}, ; 843
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020000cc, ; uint32_t type_token_id
		i32 14; uint32_t java_name_index
	}, ; 844
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000106, ; uint32_t type_token_id
		i32 55; uint32_t java_name_index
	}, ; 845
	%struct.TypeMapJava {
		i32 14, ; uint32_t module_index
		i32 u0x0200007c, ; uint32_t type_token_id
		i32 774; uint32_t java_name_index
	}, ; 846
	%struct.TypeMapJava {
		i32 7, ; uint32_t module_index
		i32 u0x0200002a, ; uint32_t type_token_id
		i32 642; uint32_t java_name_index
	}, ; 847
	%struct.TypeMapJava {
		i32 18, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 890; uint32_t java_name_index
	}, ; 848
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000487, ; uint32_t type_token_id
		i32 550; uint32_t java_name_index
	}, ; 849
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000328, ; uint32_t type_token_id
		i32 318; uint32_t java_name_index
	}, ; 850
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x0200035c, ; uint32_t type_token_id
		i32 362; uint32_t java_name_index
	}, ; 851
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x0200033c, ; uint32_t type_token_id
		i32 332; uint32_t java_name_index
	}, ; 852
	%struct.TypeMapJava {
		i32 18, ; uint32_t module_index
		i32 u0x02000062, ; uint32_t type_token_id
		i32 874; uint32_t java_name_index
	}, ; 853
	%struct.TypeMapJava {
		i32 25, ; uint32_t module_index
		i32 u0x02000040, ; uint32_t type_token_id
		i32 1009; uint32_t java_name_index
	}, ; 854
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x0200049c, ; uint32_t type_token_id
		i32 562; uint32_t java_name_index
	}, ; 855
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020003fe, ; uint32_t type_token_id
		i32 460; uint32_t java_name_index
	}, ; 856
	%struct.TypeMapJava {
		i32 8, ; uint32_t module_index
		i32 u0x0200016d, ; uint32_t type_token_id
		i32 697; uint32_t java_name_index
	}, ; 857
	%struct.TypeMapJava {
		i32 14, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 761; uint32_t java_name_index
	}, ; 858
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020000fa, ; uint32_t type_token_id
		i32 44; uint32_t java_name_index
	}, ; 859
	%struct.TypeMapJava {
		i32 37, ; uint32_t module_index
		i32 u0x02000014, ; uint32_t type_token_id
		i32 1242; uint32_t java_name_index
	}, ; 860
	%struct.TypeMapJava {
		i32 14, ; uint32_t module_index
		i32 u0x02000046, ; uint32_t type_token_id
		i32 747; uint32_t java_name_index
	}, ; 861
	%struct.TypeMapJava {
		i32 25, ; uint32_t module_index
		i32 u0x02000059, ; uint32_t type_token_id
		i32 1022; uint32_t java_name_index
	}, ; 862
	%struct.TypeMapJava {
		i32 21, ; uint32_t module_index
		i32 u0x020000b0, ; uint32_t type_token_id
		i32 987; uint32_t java_name_index
	}, ; 863
	%struct.TypeMapJava {
		i32 14, ; uint32_t module_index
		i32 u0x02000048, ; uint32_t type_token_id
		i32 749; uint32_t java_name_index
	}, ; 864
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000277, ; uint32_t type_token_id
		i32 254; uint32_t java_name_index
	}, ; 865
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000480, ; uint32_t type_token_id
		i32 543; uint32_t java_name_index
	}, ; 866
	%struct.TypeMapJava {
		i32 25, ; uint32_t module_index
		i32 u0x02000056, ; uint32_t type_token_id
		i32 1020; uint32_t java_name_index
	}, ; 867
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020002cc, ; uint32_t type_token_id
		i32 294; uint32_t java_name_index
	}, ; 868
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x0200047c, ; uint32_t type_token_id
		i32 539; uint32_t java_name_index
	}, ; 869
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 285; uint32_t java_name_index
	}, ; 870
	%struct.TypeMapJava {
		i32 21, ; uint32_t module_index
		i32 u0x0200006b, ; uint32_t type_token_id
		i32 943; uint32_t java_name_index
	}, ; 871
	%struct.TypeMapJava {
		i32 6, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 616; uint32_t java_name_index
	}, ; 872
	%struct.TypeMapJava {
		i32 8, ; uint32_t module_index
		i32 u0x02000170, ; uint32_t type_token_id
		i32 698; uint32_t java_name_index
	}, ; 873
	%struct.TypeMapJava {
		i32 18, ; uint32_t module_index
		i32 u0x0200006c, ; uint32_t type_token_id
		i32 880; uint32_t java_name_index
	}, ; 874
	%struct.TypeMapJava {
		i32 25, ; uint32_t module_index
		i32 u0x02000096, ; uint32_t type_token_id
		i32 1051; uint32_t java_name_index
	}, ; 875
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020003b3, ; uint32_t type_token_id
		i32 420; uint32_t java_name_index
	}, ; 876
	%struct.TypeMapJava {
		i32 23, ; uint32_t module_index
		i32 u0x02000031, ; uint32_t type_token_id
		i32 994; uint32_t java_name_index
	}, ; 877
	%struct.TypeMapJava {
		i32 37, ; uint32_t module_index
		i32 u0x02000020, ; uint32_t type_token_id
		i32 1252; uint32_t java_name_index
	}, ; 878
	%struct.TypeMapJava {
		i32 25, ; uint32_t module_index
		i32 u0x02000053, ; uint32_t type_token_id
		i32 1018; uint32_t java_name_index
	}, ; 879
	%struct.TypeMapJava {
		i32 21, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 985; uint32_t java_name_index
	}, ; 880
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020000f0, ; uint32_t type_token_id
		i32 36; uint32_t java_name_index
	}, ; 881
	%struct.TypeMapJava {
		i32 11, ; uint32_t module_index
		i32 u0x02000010, ; uint32_t type_token_id
		i32 723; uint32_t java_name_index
	}, ; 882
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020001fc, ; uint32_t type_token_id
		i32 198; uint32_t java_name_index
	}, ; 883
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000475, ; uint32_t type_token_id
		i32 532; uint32_t java_name_index
	}, ; 884
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x0200017a, ; uint32_t type_token_id
		i32 119; uint32_t java_name_index
	}, ; 885
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x0200035f, ; uint32_t type_token_id
		i32 365; uint32_t java_name_index
	}, ; 886
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 412; uint32_t java_name_index
	}, ; 887
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020004af, ; uint32_t type_token_id
		i32 578; uint32_t java_name_index
	}, ; 888
	%struct.TypeMapJava {
		i32 5, ; uint32_t module_index
		i32 u0x02000016, ; uint32_t type_token_id
		i32 611; uint32_t java_name_index
	}, ; 889
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 0; uint32_t java_name_index
	}, ; 890
	%struct.TypeMapJava {
		i32 10, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 722; uint32_t java_name_index
	}, ; 891
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000220, ; uint32_t type_token_id
		i32 218; uint32_t java_name_index
	}, ; 892
	%struct.TypeMapJava {
		i32 14, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 756; uint32_t java_name_index
	}, ; 893
	%struct.TypeMapJava {
		i32 8, ; uint32_t module_index
		i32 u0x02000154, ; uint32_t type_token_id
		i32 676; uint32_t java_name_index
	}, ; 894
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x0200034c, ; uint32_t type_token_id
		i32 347; uint32_t java_name_index
	}, ; 895
	%struct.TypeMapJava {
		i32 27, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 1076; uint32_t java_name_index
	}, ; 896
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020002a9, ; uint32_t type_token_id
		i32 271; uint32_t java_name_index
	}, ; 897
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 21; uint32_t java_name_index
	}, ; 898
	%struct.TypeMapJava {
		i32 5, ; uint32_t module_index
		i32 u0x0200001d, ; uint32_t type_token_id
		i32 613; uint32_t java_name_index
	}, ; 899
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000111, ; uint32_t type_token_id
		i32 62; uint32_t java_name_index
	}, ; 900
	%struct.TypeMapJava {
		i32 21, ; uint32_t module_index
		i32 u0x0200008b, ; uint32_t type_token_id
		i32 959; uint32_t java_name_index
	}, ; 901
	%struct.TypeMapJava {
		i32 28, ; uint32_t module_index
		i32 u0x02000004, ; uint32_t type_token_id
		i32 1078; uint32_t java_name_index
	}, ; 902
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020001a9, ; uint32_t type_token_id
		i32 143; uint32_t java_name_index
	}, ; 903
	%struct.TypeMapJava {
		i32 14, ; uint32_t module_index
		i32 u0x02000042, ; uint32_t type_token_id
		i32 744; uint32_t java_name_index
	}, ; 904
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000214, ; uint32_t type_token_id
		i32 212; uint32_t java_name_index
	}, ; 905
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020003b9, ; uint32_t type_token_id
		i32 424; uint32_t java_name_index
	}, ; 906
	%struct.TypeMapJava {
		i32 8, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 645; uint32_t java_name_index
	}, ; 907
	%struct.TypeMapJava {
		i32 8, ; uint32_t module_index
		i32 u0x02000124, ; uint32_t type_token_id
		i32 659; uint32_t java_name_index
	}, ; 908
	%struct.TypeMapJava {
		i32 34, ; uint32_t module_index
		i32 u0x020003e4, ; uint32_t type_token_id
		i32 1184; uint32_t java_name_index
	}, ; 909
	%struct.TypeMapJava {
		i32 34, ; uint32_t module_index
		i32 u0x02000362, ; uint32_t type_token_id
		i32 1109; uint32_t java_name_index
	}, ; 910
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020003f4, ; uint32_t type_token_id
		i32 454; uint32_t java_name_index
	}, ; 911
	%struct.TypeMapJava {
		i32 16, ; uint32_t module_index
		i32 u0x02000017, ; uint32_t type_token_id
		i32 818; uint32_t java_name_index
	}, ; 912
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000238, ; uint32_t type_token_id
		i32 224; uint32_t java_name_index
	}, ; 913
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000205, ; uint32_t type_token_id
		i32 204; uint32_t java_name_index
	}, ; 914
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020001fd, ; uint32_t type_token_id
		i32 199; uint32_t java_name_index
	}, ; 915
	%struct.TypeMapJava {
		i32 34, ; uint32_t module_index
		i32 u0x020005ee, ; uint32_t type_token_id
		i32 1107; uint32_t java_name_index
	}, ; 916
	%struct.TypeMapJava {
		i32 34, ; uint32_t module_index
		i32 u0x020006a4, ; uint32_t type_token_id
		i32 1121; uint32_t java_name_index
	}, ; 917
	%struct.TypeMapJava {
		i32 14, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 803; uint32_t java_name_index
	}, ; 918
	%struct.TypeMapJava {
		i32 14, ; uint32_t module_index
		i32 u0x02000082, ; uint32_t type_token_id
		i32 777; uint32_t java_name_index
	}, ; 919
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 11; uint32_t java_name_index
	}, ; 920
	%struct.TypeMapJava {
		i32 37, ; uint32_t module_index
		i32 u0x02000018, ; uint32_t type_token_id
		i32 1246; uint32_t java_name_index
	}, ; 921
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000100, ; uint32_t type_token_id
		i32 49; uint32_t java_name_index
	}, ; 922
	%struct.TypeMapJava {
		i32 6, ; uint32_t module_index
		i32 u0x02000020, ; uint32_t type_token_id
		i32 623; uint32_t java_name_index
	}, ; 923
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000135, ; uint32_t type_token_id
		i32 78; uint32_t java_name_index
	}, ; 924
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020001e4, ; uint32_t type_token_id
		i32 186; uint32_t java_name_index
	}, ; 925
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x0200019e, ; uint32_t type_token_id
		i32 136; uint32_t java_name_index
	}, ; 926
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000171, ; uint32_t type_token_id
		i32 114; uint32_t java_name_index
	}, ; 927
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020000ea, ; uint32_t type_token_id
		i32 32; uint32_t java_name_index
	}, ; 928
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x0200025b, ; uint32_t type_token_id
		i32 588; uint32_t java_name_index
	}, ; 929
	%struct.TypeMapJava {
		i32 18, ; uint32_t module_index
		i32 u0x02000051, ; uint32_t type_token_id
		i32 862; uint32_t java_name_index
	}, ; 930
	%struct.TypeMapJava {
		i32 23, ; uint32_t module_index
		i32 u0x0200007b, ; uint32_t type_token_id
		i32 998; uint32_t java_name_index
	}, ; 931
	%struct.TypeMapJava {
		i32 21, ; uint32_t module_index
		i32 u0x020000a6, ; uint32_t type_token_id
		i32 979; uint32_t java_name_index
	}, ; 932
	%struct.TypeMapJava {
		i32 21, ; uint32_t module_index
		i32 u0x0200005b, ; uint32_t type_token_id
		i32 934; uint32_t java_name_index
	}, ; 933
	%struct.TypeMapJava {
		i32 11, ; uint32_t module_index
		i32 u0x02000019, ; uint32_t type_token_id
		i32 727; uint32_t java_name_index
	}, ; 934
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x0200025e, ; uint32_t type_token_id
		i32 590; uint32_t java_name_index
	}, ; 935
	%struct.TypeMapJava {
		i32 35, ; uint32_t module_index
		i32 u0x0200004d, ; uint32_t type_token_id
		i32 1221; uint32_t java_name_index
	}, ; 936
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x0200012b, ; uint32_t type_token_id
		i32 75; uint32_t java_name_index
	}, ; 937
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000483, ; uint32_t type_token_id
		i32 546; uint32_t java_name_index
	}, ; 938
	%struct.TypeMapJava {
		i32 35, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 1230; uint32_t java_name_index
	}, ; 939
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000348, ; uint32_t type_token_id
		i32 343; uint32_t java_name_index
	}, ; 940
	%struct.TypeMapJava {
		i32 19, ; uint32_t module_index
		i32 u0x02000016, ; uint32_t type_token_id
		i32 906; uint32_t java_name_index
	}, ; 941
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 98; uint32_t java_name_index
	}, ; 942
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x0200047a, ; uint32_t type_token_id
		i32 537; uint32_t java_name_index
	}, ; 943
	%struct.TypeMapJava {
		i32 14, ; uint32_t module_index
		i32 u0x02000047, ; uint32_t type_token_id
		i32 748; uint32_t java_name_index
	}, ; 944
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000105, ; uint32_t type_token_id
		i32 54; uint32_t java_name_index
	}, ; 945
	%struct.TypeMapJava {
		i32 17, ; uint32_t module_index
		i32 u0x0200008d, ; uint32_t type_token_id
		i32 825; uint32_t java_name_index
	}, ; 946
	%struct.TypeMapJava {
		i32 21, ; uint32_t module_index
		i32 u0x020000aa, ; uint32_t type_token_id
		i32 983; uint32_t java_name_index
	}, ; 947
	%struct.TypeMapJava {
		i32 6, ; uint32_t module_index
		i32 u0x0200002b, ; uint32_t type_token_id
		i32 631; uint32_t java_name_index
	}, ; 948
	%struct.TypeMapJava {
		i32 34, ; uint32_t module_index
		i32 u0x02000630, ; uint32_t type_token_id
		i32 1197; uint32_t java_name_index
	}, ; 949
	%struct.TypeMapJava {
		i32 37, ; uint32_t module_index
		i32 u0x02000012, ; uint32_t type_token_id
		i32 1240; uint32_t java_name_index
	}, ; 950
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x0200046b, ; uint32_t type_token_id
		i32 526; uint32_t java_name_index
	}, ; 951
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020002bd, ; uint32_t type_token_id
		i32 281; uint32_t java_name_index
	}, ; 952
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x0200038e, ; uint32_t type_token_id
		i32 399; uint32_t java_name_index
	}, ; 953
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000335, ; uint32_t type_token_id
		i32 328; uint32_t java_name_index
	}, ; 954
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x0200016d, ; uint32_t type_token_id
		i32 111; uint32_t java_name_index
	}, ; 955
	%struct.TypeMapJava {
		i32 14, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 794; uint32_t java_name_index
	}, ; 956
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 245; uint32_t java_name_index
	}, ; 957
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x0200048a, ; uint32_t type_token_id
		i32 552; uint32_t java_name_index
	}, ; 958
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 249; uint32_t java_name_index
	}, ; 959
	%struct.TypeMapJava {
		i32 14, ; uint32_t module_index
		i32 u0x0200009e, ; uint32_t type_token_id
		i32 788; uint32_t java_name_index
	}, ; 960
	%struct.TypeMapJava {
		i32 21, ; uint32_t module_index
		i32 u0x0200004e, ; uint32_t type_token_id
		i32 925; uint32_t java_name_index
	}, ; 961
	%struct.TypeMapJava {
		i32 38, ; uint32_t module_index
		i32 u0x02000050, ; uint32_t type_token_id
		i32 1274; uint32_t java_name_index
	}, ; 962
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x0200048f, ; uint32_t type_token_id
		i32 556; uint32_t java_name_index
	}, ; 963
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000456, ; uint32_t type_token_id
		i32 515; uint32_t java_name_index
	}, ; 964
	%struct.TypeMapJava {
		i32 6, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 620; uint32_t java_name_index
	}, ; 965
	%struct.TypeMapJava {
		i32 10, ; uint32_t module_index
		i32 u0x02000009, ; uint32_t type_token_id
		i32 721; uint32_t java_name_index
	}, ; 966
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x0200036c, ; uint32_t type_token_id
		i32 376; uint32_t java_name_index
	}, ; 967
	%struct.TypeMapJava {
		i32 31, ; uint32_t module_index
		i32 u0x02000020, ; uint32_t type_token_id
		i32 1087; uint32_t java_name_index
	}, ; 968
	%struct.TypeMapJava {
		i32 8, ; uint32_t module_index
		i32 u0x02000155, ; uint32_t type_token_id
		i32 678; uint32_t java_name_index
	}, ; 969
	%struct.TypeMapJava {
		i32 17, ; uint32_t module_index
		i32 u0x020000d3, ; uint32_t type_token_id
		i32 836; uint32_t java_name_index
	}, ; 970
	%struct.TypeMapJava {
		i32 35, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 1213; uint32_t java_name_index
	}, ; 971
	%struct.TypeMapJava {
		i32 6, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 624; uint32_t java_name_index
	}, ; 972
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 61; uint32_t java_name_index
	}, ; 973
	%struct.TypeMapJava {
		i32 25, ; uint32_t module_index
		i32 u0x02000066, ; uint32_t type_token_id
		i32 1029; uint32_t java_name_index
	}, ; 974
	%struct.TypeMapJava {
		i32 14, ; uint32_t module_index
		i32 u0x020000af, ; uint32_t type_token_id
		i32 800; uint32_t java_name_index
	}, ; 975
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 559; uint32_t java_name_index
	}, ; 976
	%struct.TypeMapJava {
		i32 9, ; uint32_t module_index
		i32 u0x02000078, ; uint32_t type_token_id
		i32 715; uint32_t java_name_index
	}, ; 977
	%struct.TypeMapJava {
		i32 17, ; uint32_t module_index
		i32 u0x020000c6, ; uint32_t type_token_id
		i32 829; uint32_t java_name_index
	}, ; 978
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000138, ; uint32_t type_token_id
		i32 80; uint32_t java_name_index
	}, ; 979
	%struct.TypeMapJava {
		i32 39, ; uint32_t module_index
		i32 u0x02000008, ; uint32_t type_token_id
		i32 1275; uint32_t java_name_index
	}, ; 980
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000125, ; uint32_t type_token_id
		i32 71; uint32_t java_name_index
	}, ; 981
	%struct.TypeMapJava {
		i32 34, ; uint32_t module_index
		i32 u0x0200039a, ; uint32_t type_token_id
		i32 1137; uint32_t java_name_index
	}, ; 982
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 527; uint32_t java_name_index
	}, ; 983
	%struct.TypeMapJava {
		i32 8, ; uint32_t module_index
		i32 u0x02000337, ; uint32_t type_token_id
		i32 707; uint32_t java_name_index
	}, ; 984
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 512; uint32_t java_name_index
	}, ; 985
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x0200011a, ; uint32_t type_token_id
		i32 66; uint32_t java_name_index
	}, ; 986
	%struct.TypeMapJava {
		i32 34, ; uint32_t module_index
		i32 u0x02000636, ; uint32_t type_token_id
		i32 1203; uint32_t java_name_index
	}, ; 987
	%struct.TypeMapJava {
		i32 19, ; uint32_t module_index
		i32 u0x0200001e, ; uint32_t type_token_id
		i32 910; uint32_t java_name_index
	}, ; 988
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020002db, ; uint32_t type_token_id
		i32 300; uint32_t java_name_index
	}, ; 989
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020002e4, ; uint32_t type_token_id
		i32 308; uint32_t java_name_index
	}, ; 990
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000332, ; uint32_t type_token_id
		i32 326; uint32_t java_name_index
	}, ; 991
	%struct.TypeMapJava {
		i32 25, ; uint32_t module_index
		i32 u0x02000095, ; uint32_t type_token_id
		i32 1050; uint32_t java_name_index
	}, ; 992
	%struct.TypeMapJava {
		i32 34, ; uint32_t module_index
		i32 u0x020003a1, ; uint32_t type_token_id
		i32 1146; uint32_t java_name_index
	}, ; 993
	%struct.TypeMapJava {
		i32 34, ; uint32_t module_index
		i32 u0x02000613, ; uint32_t type_token_id
		i32 1145; uint32_t java_name_index
	}, ; 994
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x0200028c, ; uint32_t type_token_id
		i32 260; uint32_t java_name_index
	}, ; 995
	%struct.TypeMapJava {
		i32 25, ; uint32_t module_index
		i32 u0x02000068, ; uint32_t type_token_id
		i32 1031; uint32_t java_name_index
	}, ; 996
	%struct.TypeMapJava {
		i32 14, ; uint32_t module_index
		i32 u0x02000065, ; uint32_t type_token_id
		i32 763; uint32_t java_name_index
	}, ; 997
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020001d2, ; uint32_t type_token_id
		i32 174; uint32_t java_name_index
	}, ; 998
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x0200043e, ; uint32_t type_token_id
		i32 503; uint32_t java_name_index
	}, ; 999
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000302, ; uint32_t type_token_id
		i32 311; uint32_t java_name_index
	}, ; 1000
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000426, ; uint32_t type_token_id
		i32 487; uint32_t java_name_index
	}, ; 1001
	%struct.TypeMapJava {
		i32 10, ; uint32_t module_index
		i32 u0x02000004, ; uint32_t type_token_id
		i32 716; uint32_t java_name_index
	}, ; 1002
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 205; uint32_t java_name_index
	}, ; 1003
	%struct.TypeMapJava {
		i32 19, ; uint32_t module_index
		i32 u0x02000010, ; uint32_t type_token_id
		i32 903; uint32_t java_name_index
	}, ; 1004
	%struct.TypeMapJava {
		i32 34, ; uint32_t module_index
		i32 u0x020003da, ; uint32_t type_token_id
		i32 1182; uint32_t java_name_index
	}, ; 1005
	%struct.TypeMapJava {
		i32 38, ; uint32_t module_index
		i32 u0x02000024, ; uint32_t type_token_id
		i32 1256; uint32_t java_name_index
	}, ; 1006
	%struct.TypeMapJava {
		i32 18, ; uint32_t module_index
		i32 u0x0200008a, ; uint32_t type_token_id
		i32 896; uint32_t java_name_index
	}, ; 1007
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020003d6, ; uint32_t type_token_id
		i32 441; uint32_t java_name_index
	}, ; 1008
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020002a4, ; uint32_t type_token_id
		i32 269; uint32_t java_name_index
	}, ; 1009
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020003ca, ; uint32_t type_token_id
		i32 434; uint32_t java_name_index
	}, ; 1010
	%struct.TypeMapJava {
		i32 18, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 860; uint32_t java_name_index
	}, ; 1011
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 243; uint32_t java_name_index
	}, ; 1012
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000200, ; uint32_t type_token_id
		i32 202; uint32_t java_name_index
	}, ; 1013
	%struct.TypeMapJava {
		i32 28, ; uint32_t module_index
		i32 u0x02000003, ; uint32_t type_token_id
		i32 1077; uint32_t java_name_index
	}, ; 1014
	%struct.TypeMapJava {
		i32 8, ; uint32_t module_index
		i32 u0x02000163, ; uint32_t type_token_id
		i32 689; uint32_t java_name_index
	}, ; 1015
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000366, ; uint32_t type_token_id
		i32 371; uint32_t java_name_index
	}, ; 1016
	%struct.TypeMapJava {
		i32 8, ; uint32_t module_index
		i32 u0x02000118, ; uint32_t type_token_id
		i32 650; uint32_t java_name_index
	}, ; 1017
	%struct.TypeMapJava {
		i32 16, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 817; uint32_t java_name_index
	}, ; 1018
	%struct.TypeMapJava {
		i32 38, ; uint32_t module_index
		i32 u0x02000030, ; uint32_t type_token_id
		i32 1265; uint32_t java_name_index
	}, ; 1019
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020002d6, ; uint32_t type_token_id
		i32 297; uint32_t java_name_index
	}, ; 1020
	%struct.TypeMapJava {
		i32 25, ; uint32_t module_index
		i32 u0x02000084, ; uint32_t type_token_id
		i32 1047; uint32_t java_name_index
	}, ; 1021
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x0200040c, ; uint32_t type_token_id
		i32 471; uint32_t java_name_index
	}, ; 1022
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000218, ; uint32_t type_token_id
		i32 214; uint32_t java_name_index
	}, ; 1023
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000364, ; uint32_t type_token_id
		i32 370; uint32_t java_name_index
	}, ; 1024
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020000d3, ; uint32_t type_token_id
		i32 19; uint32_t java_name_index
	}, ; 1025
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x0200025c, ; uint32_t type_token_id
		i32 589; uint32_t java_name_index
	}, ; 1026
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x0200047b, ; uint32_t type_token_id
		i32 538; uint32_t java_name_index
	}, ; 1027
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020003f1, ; uint32_t type_token_id
		i32 452; uint32_t java_name_index
	}, ; 1028
	%struct.TypeMapJava {
		i32 34, ; uint32_t module_index
		i32 u0x02000611, ; uint32_t type_token_id
		i32 1142; uint32_t java_name_index
	}, ; 1029
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x0200015d, ; uint32_t type_token_id
		i32 102; uint32_t java_name_index
	}, ; 1030
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020000ed, ; uint32_t type_token_id
		i32 34; uint32_t java_name_index
	}, ; 1031
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020001cc, ; uint32_t type_token_id
		i32 168; uint32_t java_name_index
	}, ; 1032
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020003dd, ; uint32_t type_token_id
		i32 445; uint32_t java_name_index
	}, ; 1033
	%struct.TypeMapJava {
		i32 8, ; uint32_t module_index
		i32 u0x02000159, ; uint32_t type_token_id
		i32 681; uint32_t java_name_index
	}, ; 1034
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000415, ; uint32_t type_token_id
		i32 477; uint32_t java_name_index
	}, ; 1035
	%struct.TypeMapJava {
		i32 21, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 913; uint32_t java_name_index
	}, ; 1036
	%struct.TypeMapJava {
		i32 28, ; uint32_t module_index
		i32 u0x02000007, ; uint32_t type_token_id
		i32 1080; uint32_t java_name_index
	}, ; 1037
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x0200037a, ; uint32_t type_token_id
		i32 386; uint32_t java_name_index
	}, ; 1038
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020003d4, ; uint32_t type_token_id
		i32 439; uint32_t java_name_index
	}, ; 1039
	%struct.TypeMapJava {
		i32 25, ; uint32_t module_index
		i32 u0x0200009c, ; uint32_t type_token_id
		i32 1055; uint32_t java_name_index
	}, ; 1040
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020000cf, ; uint32_t type_token_id
		i32 16; uint32_t java_name_index
	}, ; 1041
	%struct.TypeMapJava {
		i32 17, ; uint32_t module_index
		i32 u0x02000016, ; uint32_t type_token_id
		i32 819; uint32_t java_name_index
	}, ; 1042
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020000d0, ; uint32_t type_token_id
		i32 17; uint32_t java_name_index
	}, ; 1043
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020003f6, ; uint32_t type_token_id
		i32 455; uint32_t java_name_index
	}, ; 1044
	%struct.TypeMapJava {
		i32 37, ; uint32_t module_index
		i32 u0x02000022, ; uint32_t type_token_id
		i32 1253; uint32_t java_name_index
	}, ; 1045
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020001d3, ; uint32_t type_token_id
		i32 175; uint32_t java_name_index
	}, ; 1046
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000144, ; uint32_t type_token_id
		i32 86; uint32_t java_name_index
	}, ; 1047
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020001aa, ; uint32_t type_token_id
		i32 144; uint32_t java_name_index
	}, ; 1048
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x0200043c, ; uint32_t type_token_id
		i32 502; uint32_t java_name_index
	}, ; 1049
	%struct.TypeMapJava {
		i32 5, ; uint32_t module_index
		i32 u0x0200001e, ; uint32_t type_token_id
		i32 614; uint32_t java_name_index
	}, ; 1050
	%struct.TypeMapJava {
		i32 37, ; uint32_t module_index
		i32 u0x0200001f, ; uint32_t type_token_id
		i32 1251; uint32_t java_name_index
	}, ; 1051
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000378, ; uint32_t type_token_id
		i32 384; uint32_t java_name_index
	}, ; 1052
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000176, ; uint32_t type_token_id
		i32 116; uint32_t java_name_index
	}, ; 1053
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020002ab, ; uint32_t type_token_id
		i32 273; uint32_t java_name_index
	}, ; 1054
	%struct.TypeMapJava {
		i32 34, ; uint32_t module_index
		i32 u0x0200060e, ; uint32_t type_token_id
		i32 1140; uint32_t java_name_index
	}, ; 1055
	%struct.TypeMapJava {
		i32 26, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 1067; uint32_t java_name_index
	}, ; 1056
	%struct.TypeMapJava {
		i32 35, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 1211; uint32_t java_name_index
	}, ; 1057
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 525; uint32_t java_name_index
	}, ; 1058
	%struct.TypeMapJava {
		i32 34, ; uint32_t module_index
		i32 u0x020003b2, ; uint32_t type_token_id
		i32 1157; uint32_t java_name_index
	}, ; 1059
	%struct.TypeMapJava {
		i32 21, ; uint32_t module_index
		i32 u0x020000a7, ; uint32_t type_token_id
		i32 980; uint32_t java_name_index
	}, ; 1060
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020001fe, ; uint32_t type_token_id
		i32 200; uint32_t java_name_index
	}, ; 1061
	%struct.TypeMapJava {
		i32 25, ; uint32_t module_index
		i32 u0x02000060, ; uint32_t type_token_id
		i32 1026; uint32_t java_name_index
	}, ; 1062
	%struct.TypeMapJava {
		i32 38, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 1271; uint32_t java_name_index
	}, ; 1063
	%struct.TypeMapJava {
		i32 6, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 626; uint32_t java_name_index
	}, ; 1064
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000382, ; uint32_t type_token_id
		i32 392; uint32_t java_name_index
	}, ; 1065
	%struct.TypeMapJava {
		i32 34, ; uint32_t module_index
		i32 u0x020003e5, ; uint32_t type_token_id
		i32 1185; uint32_t java_name_index
	}, ; 1066
	%struct.TypeMapJava {
		i32 34, ; uint32_t module_index
		i32 u0x02000399, ; uint32_t type_token_id
		i32 1136; uint32_t java_name_index
	}, ; 1067
	%struct.TypeMapJava {
		i32 8, ; uint32_t module_index
		i32 u0x02000122, ; uint32_t type_token_id
		i32 657; uint32_t java_name_index
	}, ; 1068
	%struct.TypeMapJava {
		i32 34, ; uint32_t module_index
		i32 u0x020003c8, ; uint32_t type_token_id
		i32 1165; uint32_t java_name_index
	}, ; 1069
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000392, ; uint32_t type_token_id
		i32 402; uint32_t java_name_index
	}, ; 1070
	%struct.TypeMapJava {
		i32 21, ; uint32_t module_index
		i32 u0x02000048, ; uint32_t type_token_id
		i32 919; uint32_t java_name_index
	}, ; 1071
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020002dc, ; uint32_t type_token_id
		i32 301; uint32_t java_name_index
	}, ; 1072
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020003f3, ; uint32_t type_token_id
		i32 453; uint32_t java_name_index
	}, ; 1073
	%struct.TypeMapJava {
		i32 35, ; uint32_t module_index
		i32 u0x02000051, ; uint32_t type_token_id
		i32 1223; uint32_t java_name_index
	}, ; 1074
	%struct.TypeMapJava {
		i32 17, ; uint32_t module_index
		i32 u0x0200018f, ; uint32_t type_token_id
		i32 852; uint32_t java_name_index
	}, ; 1075
	%struct.TypeMapJava {
		i32 14, ; uint32_t module_index
		i32 u0x0200007a, ; uint32_t type_token_id
		i32 773; uint32_t java_name_index
	}, ; 1076
	%struct.TypeMapJava {
		i32 8, ; uint32_t module_index
		i32 u0x0200011c, ; uint32_t type_token_id
		i32 652; uint32_t java_name_index
	}, ; 1077
	%struct.TypeMapJava {
		i32 34, ; uint32_t module_index
		i32 u0x020003d4, ; uint32_t type_token_id
		i32 1176; uint32_t java_name_index
	}, ; 1078
	%struct.TypeMapJava {
		i32 27, ; uint32_t module_index
		i32 u0x02000014, ; uint32_t type_token_id
		i32 1075; uint32_t java_name_index
	}, ; 1079
	%struct.TypeMapJava {
		i32 17, ; uint32_t module_index
		i32 u0x0200008c, ; uint32_t type_token_id
		i32 824; uint32_t java_name_index
	}, ; 1080
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020004aa, ; uint32_t type_token_id
		i32 574; uint32_t java_name_index
	}, ; 1081
	%struct.TypeMapJava {
		i32 14, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 791; uint32_t java_name_index
	}, ; 1082
	%struct.TypeMapJava {
		i32 18, ; uint32_t module_index
		i32 u0x0200007f, ; uint32_t type_token_id
		i32 889; uint32_t java_name_index
	}, ; 1083
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 410; uint32_t java_name_index
	}, ; 1084
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x020002aa, ; uint32_t type_token_id
		i32 593; uint32_t java_name_index
	}, ; 1085
	%struct.TypeMapJava {
		i32 3, ; uint32_t module_index
		i32 u0x02000007, ; uint32_t type_token_id
		i32 603; uint32_t java_name_index
	}, ; 1086
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 10; uint32_t java_name_index
	}, ; 1087
	%struct.TypeMapJava {
		i32 25, ; uint32_t module_index
		i32 u0x0200003a, ; uint32_t type_token_id
		i32 1003; uint32_t java_name_index
	}, ; 1088
	%struct.TypeMapJava {
		i32 34, ; uint32_t module_index
		i32 u0x02000369, ; uint32_t type_token_id
		i32 1114; uint32_t java_name_index
	}, ; 1089
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000252, ; uint32_t type_token_id
		i32 237; uint32_t java_name_index
	}, ; 1090
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x0200034e, ; uint32_t type_token_id
		i32 349; uint32_t java_name_index
	}, ; 1091
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020002c1, ; uint32_t type_token_id
		i32 284; uint32_t java_name_index
	}, ; 1092
	%struct.TypeMapJava {
		i32 25, ; uint32_t module_index
		i32 u0x02000065, ; uint32_t type_token_id
		i32 1028; uint32_t java_name_index
	}, ; 1093
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 239; uint32_t java_name_index
	}, ; 1094
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x02000259, ; uint32_t type_token_id
		i32 587; uint32_t java_name_index
	}, ; 1095
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 517; uint32_t java_name_index
	}, ; 1096
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020004a3, ; uint32_t type_token_id
		i32 568; uint32_t java_name_index
	}, ; 1097
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020000e4, ; uint32_t type_token_id
		i32 28; uint32_t java_name_index
	}, ; 1098
	%struct.TypeMapJava {
		i32 26, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 1062; uint32_t java_name_index
	}, ; 1099
	%struct.TypeMapJava {
		i32 14, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 801; uint32_t java_name_index
	}, ; 1100
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 184; uint32_t java_name_index
	}, ; 1101
	%struct.TypeMapJava {
		i32 38, ; uint32_t module_index
		i32 u0x0200002a, ; uint32_t type_token_id
		i32 1261; uint32_t java_name_index
	}, ; 1102
	%struct.TypeMapJava {
		i32 18, ; uint32_t module_index
		i32 u0x02000085, ; uint32_t type_token_id
		i32 893; uint32_t java_name_index
	}, ; 1103
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020002a6, ; uint32_t type_token_id
		i32 270; uint32_t java_name_index
	}, ; 1104
	%struct.TypeMapJava {
		i32 34, ; uint32_t module_index
		i32 u0x0200062a, ; uint32_t type_token_id
		i32 1190; uint32_t java_name_index
	}, ; 1105
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000428, ; uint32_t type_token_id
		i32 488; uint32_t java_name_index
	}, ; 1106
	%struct.TypeMapJava {
		i32 25, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 1021; uint32_t java_name_index
	}, ; 1107
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 91; uint32_t java_name_index
	}, ; 1108
	%struct.TypeMapJava {
		i32 17, ; uint32_t module_index
		i32 u0x020000c8, ; uint32_t type_token_id
		i32 831; uint32_t java_name_index
	}, ; 1109
	%struct.TypeMapJava {
		i32 8, ; uint32_t module_index
		i32 u0x020002dc, ; uint32_t type_token_id
		i32 702; uint32_t java_name_index
	}, ; 1110
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 22; uint32_t java_name_index
	}, ; 1111
	%struct.TypeMapJava {
		i32 3, ; uint32_t module_index
		i32 u0x02000002, ; uint32_t type_token_id
		i32 598; uint32_t java_name_index
	}, ; 1112
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000414, ; uint32_t type_token_id
		i32 476; uint32_t java_name_index
	}, ; 1113
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020000d1, ; uint32_t type_token_id
		i32 18; uint32_t java_name_index
	}, ; 1114
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000399, ; uint32_t type_token_id
		i32 405; uint32_t java_name_index
	}, ; 1115
	%struct.TypeMapJava {
		i32 34, ; uint32_t module_index
		i32 u0x02000361, ; uint32_t type_token_id
		i32 1108; uint32_t java_name_index
	}, ; 1116
	%struct.TypeMapJava {
		i32 13, ; uint32_t module_index
		i32 u0x02000009, ; uint32_t type_token_id
		i32 735; uint32_t java_name_index
	}, ; 1117
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x0200017b, ; uint32_t type_token_id
		i32 120; uint32_t java_name_index
	}, ; 1118
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 528; uint32_t java_name_index
	}, ; 1119
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 519; uint32_t java_name_index
	}, ; 1120
	%struct.TypeMapJava {
		i32 14, ; uint32_t module_index
		i32 u0x02000057, ; uint32_t type_token_id
		i32 759; uint32_t java_name_index
	}, ; 1121
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020001c0, ; uint32_t type_token_id
		i32 160; uint32_t java_name_index
	}, ; 1122
	%struct.TypeMapJava {
		i32 17, ; uint32_t module_index
		i32 u0x02000142, ; uint32_t type_token_id
		i32 843; uint32_t java_name_index
	}, ; 1123
	%struct.TypeMapJava {
		i32 6, ; uint32_t module_index
		i32 u0x02000028, ; uint32_t type_token_id
		i32 628; uint32_t java_name_index
	}, ; 1124
	%struct.TypeMapJava {
		i32 34, ; uint32_t module_index
		i32 u0x0200039d, ; uint32_t type_token_id
		i32 1141; uint32_t java_name_index
	}, ; 1125
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000152, ; uint32_t type_token_id
		i32 95; uint32_t java_name_index
	}, ; 1126
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 129; uint32_t java_name_index
	}, ; 1127
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000104, ; uint32_t type_token_id
		i32 53; uint32_t java_name_index
	}, ; 1128
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000416, ; uint32_t type_token_id
		i32 478; uint32_t java_name_index
	}, ; 1129
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020002ce, ; uint32_t type_token_id
		i32 295; uint32_t java_name_index
	}, ; 1130
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000109, ; uint32_t type_token_id
		i32 58; uint32_t java_name_index
	}, ; 1131
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 67; uint32_t java_name_index
	}, ; 1132
	%struct.TypeMapJava {
		i32 6, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 637; uint32_t java_name_index
	}, ; 1133
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 225; uint32_t java_name_index
	}, ; 1134
	%struct.TypeMapJava {
		i32 25, ; uint32_t module_index
		i32 u0x02000078, ; uint32_t type_token_id
		i32 1040; uint32_t java_name_index
	}, ; 1135
	%struct.TypeMapJava {
		i32 25, ; uint32_t module_index
		i32 u0x02000098, ; uint32_t type_token_id
		i32 1053; uint32_t java_name_index
	}, ; 1136
	%struct.TypeMapJava {
		i32 4, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 608; uint32_t java_name_index
	}, ; 1137
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020003c3, ; uint32_t type_token_id
		i32 430; uint32_t java_name_index
	}, ; 1138
	%struct.TypeMapJava {
		i32 20, ; uint32_t module_index
		i32 u0x0200000d, ; uint32_t type_token_id
		i32 912; uint32_t java_name_index
	}, ; 1139
	%struct.TypeMapJava {
		i32 17, ; uint32_t module_index
		i32 u0x020000cd, ; uint32_t type_token_id
		i32 834; uint32_t java_name_index
	}, ; 1140
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020003b6, ; uint32_t type_token_id
		i32 421; uint32_t java_name_index
	}, ; 1141
	%struct.TypeMapJava {
		i32 14, ; uint32_t module_index
		i32 u0x0200008d, ; uint32_t type_token_id
		i32 781; uint32_t java_name_index
	}, ; 1142
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 207; uint32_t java_name_index
	}, ; 1143
	%struct.TypeMapJava {
		i32 17, ; uint32_t module_index
		i32 u0x020000c1, ; uint32_t type_token_id
		i32 828; uint32_t java_name_index
	}, ; 1144
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 411; uint32_t java_name_index
	}, ; 1145
	%struct.TypeMapJava {
		i32 14, ; uint32_t module_index
		i32 u0x02000066, ; uint32_t type_token_id
		i32 764; uint32_t java_name_index
	}, ; 1146
	%struct.TypeMapJava {
		i32 22, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 988; uint32_t java_name_index
	}, ; 1147
	%struct.TypeMapJava {
		i32 21, ; uint32_t module_index
		i32 u0x02000091, ; uint32_t type_token_id
		i32 964; uint32_t java_name_index
	}, ; 1148
	%struct.TypeMapJava {
		i32 2, ; uint32_t module_index
		i32 u0x0200000b, ; uint32_t type_token_id
		i32 597; uint32_t java_name_index
	}, ; 1149
	%struct.TypeMapJava {
		i32 14, ; uint32_t module_index
		i32 u0x02000078, ; uint32_t type_token_id
		i32 772; uint32_t java_name_index
	}, ; 1150
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 217; uint32_t java_name_index
	}, ; 1151
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000141, ; uint32_t type_token_id
		i32 83; uint32_t java_name_index
	}, ; 1152
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020003b7, ; uint32_t type_token_id
		i32 422; uint32_t java_name_index
	}, ; 1153
	%struct.TypeMapJava {
		i32 14, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 768; uint32_t java_name_index
	}, ; 1154
	%struct.TypeMapJava {
		i32 35, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 1228; uint32_t java_name_index
	}, ; 1155
	%struct.TypeMapJava {
		i32 34, ; uint32_t module_index
		i32 u0x02000350, ; uint32_t type_token_id
		i32 1105; uint32_t java_name_index
	}, ; 1156
	%struct.TypeMapJava {
		i32 42, ; uint32_t module_index
		i32 u0x0200000b, ; uint32_t type_token_id
		i32 1282; uint32_t java_name_index
	}, ; 1157
	%struct.TypeMapJava {
		i32 37, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 1239; uint32_t java_name_index
	}, ; 1158
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020002c5, ; uint32_t type_token_id
		i32 287; uint32_t java_name_index
	}, ; 1159
	%struct.TypeMapJava {
		i32 6, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 619; uint32_t java_name_index
	}, ; 1160
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 223; uint32_t java_name_index
	}, ; 1161
	%struct.TypeMapJava {
		i32 23, ; uint32_t module_index
		i32 u0x0200008f, ; uint32_t type_token_id
		i32 999; uint32_t java_name_index
	}, ; 1162
	%struct.TypeMapJava {
		i32 25, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 1036; uint32_t java_name_index
	}, ; 1163
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000481, ; uint32_t type_token_id
		i32 544; uint32_t java_name_index
	}, ; 1164
	%struct.TypeMapJava {
		i32 14, ; uint32_t module_index
		i32 u0x020000c2, ; uint32_t type_token_id
		i32 808; uint32_t java_name_index
	}, ; 1165
	%struct.TypeMapJava {
		i32 12, ; uint32_t module_index
		i32 u0x02000006, ; uint32_t type_token_id
		i32 731; uint32_t java_name_index
	}, ; 1166
	%struct.TypeMapJava {
		i32 15, ; uint32_t module_index
		i32 u0x020000b4, ; uint32_t type_token_id
		i32 811; uint32_t java_name_index
	}, ; 1167
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020000fc, ; uint32_t type_token_id
		i32 46; uint32_t java_name_index
	}, ; 1168
	%struct.TypeMapJava {
		i32 25, ; uint32_t module_index
		i32 u0x0200003f, ; uint32_t type_token_id
		i32 1008; uint32_t java_name_index
	}, ; 1169
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000148, ; uint32_t type_token_id
		i32 89; uint32_t java_name_index
	}, ; 1170
	%struct.TypeMapJava {
		i32 26, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 1068; uint32_t java_name_index
	}, ; 1171
	%struct.TypeMapJava {
		i32 41, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 1279; uint32_t java_name_index
	}, ; 1172
	%struct.TypeMapJava {
		i32 38, ; uint32_t module_index
		i32 u0x02000023, ; uint32_t type_token_id
		i32 1255; uint32_t java_name_index
	}, ; 1173
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 418; uint32_t java_name_index
	}, ; 1174
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x0200042a, ; uint32_t type_token_id
		i32 489; uint32_t java_name_index
	}, ; 1175
	%struct.TypeMapJava {
		i32 17, ; uint32_t module_index
		i32 u0x020000c9, ; uint32_t type_token_id
		i32 832; uint32_t java_name_index
	}, ; 1176
	%struct.TypeMapJava {
		i32 1, ; uint32_t module_index
		i32 u0x020000ca, ; uint32_t type_token_id
		i32 582; uint32_t java_name_index
	}, ; 1177
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 7; uint32_t java_name_index
	}, ; 1178
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 507; uint32_t java_name_index
	}, ; 1179
	%struct.TypeMapJava {
		i32 17, ; uint32_t module_index
		i32 u0x02000122, ; uint32_t type_token_id
		i32 842; uint32_t java_name_index
	}, ; 1180
	%struct.TypeMapJava {
		i32 4, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 606; uint32_t java_name_index
	}, ; 1181
	%struct.TypeMapJava {
		i32 14, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 750; uint32_t java_name_index
	}, ; 1182
	%struct.TypeMapJava {
		i32 34, ; uint32_t module_index
		i32 u0x020003f5, ; uint32_t type_token_id
		i32 1201; uint32_t java_name_index
	}, ; 1183
	%struct.TypeMapJava {
		i32 34, ; uint32_t module_index
		i32 u0x020003cc, ; uint32_t type_token_id
		i32 1168; uint32_t java_name_index
	}, ; 1184
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x0200042e, ; uint32_t type_token_id
		i32 492; uint32_t java_name_index
	}, ; 1185
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x0200020e, ; uint32_t type_token_id
		i32 209; uint32_t java_name_index
	}, ; 1186
	%struct.TypeMapJava {
		i32 30, ; uint32_t module_index
		i32 u0x02000008, ; uint32_t type_token_id
		i32 1084; uint32_t java_name_index
	}, ; 1187
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x0200043a, ; uint32_t type_token_id
		i32 500; uint32_t java_name_index
	}, ; 1188
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000159, ; uint32_t type_token_id
		i32 99; uint32_t java_name_index
	}, ; 1189
	%struct.TypeMapJava {
		i32 8, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 651; uint32_t java_name_index
	}, ; 1190
	%struct.TypeMapJava {
		i32 21, ; uint32_t module_index
		i32 u0x02000051, ; uint32_t type_token_id
		i32 927; uint32_t java_name_index
	}, ; 1191
	%struct.TypeMapJava {
		i32 18, ; uint32_t module_index
		i32 u0x02000074, ; uint32_t type_token_id
		i32 884; uint32_t java_name_index
	}, ; 1192
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020000f7, ; uint32_t type_token_id
		i32 42; uint32_t java_name_index
	}, ; 1193
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 494; uint32_t java_name_index
	}, ; 1194
	%struct.TypeMapJava {
		i32 25, ; uint32_t module_index
		i32 u0x0200005c, ; uint32_t type_token_id
		i32 1024; uint32_t java_name_index
	}, ; 1195
	%struct.TypeMapJava {
		i32 35, ; uint32_t module_index
		i32 u0x02000065, ; uint32_t type_token_id
		i32 1237; uint32_t java_name_index
	}, ; 1196
	%struct.TypeMapJava {
		i32 14, ; uint32_t module_index
		i32 u0x020000b7, ; uint32_t type_token_id
		i32 804; uint32_t java_name_index
	}, ; 1197
	%struct.TypeMapJava {
		i32 34, ; uint32_t module_index
		i32 u0x020003cf, ; uint32_t type_token_id
		i32 1171; uint32_t java_name_index
	}, ; 1198
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x0200049e, ; uint32_t type_token_id
		i32 564; uint32_t java_name_index
	}, ; 1199
	%struct.TypeMapJava {
		i32 35, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 1229; uint32_t java_name_index
	}, ; 1200
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000108, ; uint32_t type_token_id
		i32 57; uint32_t java_name_index
	}, ; 1201
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 576; uint32_t java_name_index
	}, ; 1202
	%struct.TypeMapJava {
		i32 10, ; uint32_t module_index
		i32 u0x02000005, ; uint32_t type_token_id
		i32 717; uint32_t java_name_index
	}, ; 1203
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000363, ; uint32_t type_token_id
		i32 369; uint32_t java_name_index
	}, ; 1204
	%struct.TypeMapJava {
		i32 7, ; uint32_t module_index
		i32 u0x02000028, ; uint32_t type_token_id
		i32 641; uint32_t java_name_index
	}, ; 1205
	%struct.TypeMapJava {
		i32 34, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 1156; uint32_t java_name_index
	}, ; 1206
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 125; uint32_t java_name_index
	}, ; 1207
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 210; uint32_t java_name_index
	}, ; 1208
	%struct.TypeMapJava {
		i32 34, ; uint32_t module_index
		i32 u0x020003d3, ; uint32_t type_token_id
		i32 1175; uint32_t java_name_index
	}, ; 1209
	%struct.TypeMapJava {
		i32 18, ; uint32_t module_index
		i32 u0x02000061, ; uint32_t type_token_id
		i32 873; uint32_t java_name_index
	}, ; 1210
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020003f7, ; uint32_t type_token_id
		i32 456; uint32_t java_name_index
	}, ; 1211
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020000ff, ; uint32_t type_token_id
		i32 48; uint32_t java_name_index
	}, ; 1212
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020000fb, ; uint32_t type_token_id
		i32 45; uint32_t java_name_index
	}, ; 1213
	%struct.TypeMapJava {
		i32 6, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 634; uint32_t java_name_index
	}, ; 1214
	%struct.TypeMapJava {
		i32 21, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 928; uint32_t java_name_index
	}, ; 1215
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 310; uint32_t java_name_index
	}, ; 1216
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000408, ; uint32_t type_token_id
		i32 468; uint32_t java_name_index
	}, ; 1217
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000180, ; uint32_t type_token_id
		i32 123; uint32_t java_name_index
	}, ; 1218
	%struct.TypeMapJava {
		i32 25, ; uint32_t module_index
		i32 u0x02000067, ; uint32_t type_token_id
		i32 1030; uint32_t java_name_index
	}, ; 1219
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 529; uint32_t java_name_index
	}, ; 1220
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000295, ; uint32_t type_token_id
		i32 263; uint32_t java_name_index
	}, ; 1221
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020002dd, ; uint32_t type_token_id
		i32 302; uint32_t java_name_index
	}, ; 1222
	%struct.TypeMapJava {
		i32 38, ; uint32_t module_index
		i32 u0x0200004e, ; uint32_t type_token_id
		i32 1272; uint32_t java_name_index
	}, ; 1223
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000183, ; uint32_t type_token_id
		i32 124; uint32_t java_name_index
	}, ; 1224
	%struct.TypeMapJava {
		i32 14, ; uint32_t module_index
		i32 u0x020000a5, ; uint32_t type_token_id
		i32 793; uint32_t java_name_index
	}, ; 1225
	%struct.TypeMapJava {
		i32 21, ; uint32_t module_index
		i32 u0x02000087, ; uint32_t type_token_id
		i32 956; uint32_t java_name_index
	}, ; 1226
	%struct.TypeMapJava {
		i32 21, ; uint32_t module_index
		i32 u0x02000094, ; uint32_t type_token_id
		i32 967; uint32_t java_name_index
	}, ; 1227
	%struct.TypeMapJava {
		i32 25, ; uint32_t module_index
		i32 u0x0200005a, ; uint32_t type_token_id
		i32 1023; uint32_t java_name_index
	}, ; 1228
	%struct.TypeMapJava {
		i32 8, ; uint32_t module_index
		i32 u0x020000b6, ; uint32_t type_token_id
		i32 646; uint32_t java_name_index
	}, ; 1229
	%struct.TypeMapJava {
		i32 14, ; uint32_t module_index
		i32 u0x0200006f, ; uint32_t type_token_id
		i32 769; uint32_t java_name_index
	}, ; 1230
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x0200037b, ; uint32_t type_token_id
		i32 387; uint32_t java_name_index
	}, ; 1231
	%struct.TypeMapJava {
		i32 16, ; uint32_t module_index
		i32 u0x02000012, ; uint32_t type_token_id
		i32 816; uint32_t java_name_index
	}, ; 1232
	%struct.TypeMapJava {
		i32 34, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 1166; uint32_t java_name_index
	}, ; 1233
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 524; uint32_t java_name_index
	}, ; 1234
	%struct.TypeMapJava {
		i32 25, ; uint32_t module_index
		i32 u0x02000045, ; uint32_t type_token_id
		i32 1012; uint32_t java_name_index
	}, ; 1235
	%struct.TypeMapJava {
		i32 21, ; uint32_t module_index
		i32 u0x020000ab, ; uint32_t type_token_id
		i32 984; uint32_t java_name_index
	}, ; 1236
	%struct.TypeMapJava {
		i32 14, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 782; uint32_t java_name_index
	}, ; 1237
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020001bd, ; uint32_t type_token_id
		i32 157; uint32_t java_name_index
	}, ; 1238
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x0200041b, ; uint32_t type_token_id
		i32 481; uint32_t java_name_index
	}, ; 1239
	%struct.TypeMapJava {
		i32 14, ; uint32_t module_index
		i32 u0x020000b3, ; uint32_t type_token_id
		i32 802; uint32_t java_name_index
	}, ; 1240
	%struct.TypeMapJava {
		i32 34, ; uint32_t module_index
		i32 u0x020003b5, ; uint32_t type_token_id
		i32 1159; uint32_t java_name_index
	}, ; 1241
	%struct.TypeMapJava {
		i32 21, ; uint32_t module_index
		i32 u0x02000067, ; uint32_t type_token_id
		i32 941; uint32_t java_name_index
	}, ; 1242
	%struct.TypeMapJava {
		i32 21, ; uint32_t module_index
		i32 u0x020000a4, ; uint32_t type_token_id
		i32 977; uint32_t java_name_index
	}, ; 1243
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020002da, ; uint32_t type_token_id
		i32 299; uint32_t java_name_index
	}, ; 1244
	%struct.TypeMapJava {
		i32 18, ; uint32_t module_index
		i32 u0x02000099, ; uint32_t type_token_id
		i32 897; uint32_t java_name_index
	}, ; 1245
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000484, ; uint32_t type_token_id
		i32 547; uint32_t java_name_index
	}, ; 1246
	%struct.TypeMapJava {
		i32 21, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 954; uint32_t java_name_index
	}, ; 1247
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000170, ; uint32_t type_token_id
		i32 113; uint32_t java_name_index
	}, ; 1248
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020002c7, ; uint32_t type_token_id
		i32 289; uint32_t java_name_index
	}, ; 1249
	%struct.TypeMapJava {
		i32 8, ; uint32_t module_index
		i32 u0x02000291, ; uint32_t type_token_id
		i32 648; uint32_t java_name_index
	}, ; 1250
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020002b1, ; uint32_t type_token_id
		i32 277; uint32_t java_name_index
	}, ; 1251
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000345, ; uint32_t type_token_id
		i32 341; uint32_t java_name_index
	}, ; 1252
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 235; uint32_t java_name_index
	}, ; 1253
	%struct.TypeMapJava {
		i32 21, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 951; uint32_t java_name_index
	}, ; 1254
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020000b7, ; uint32_t type_token_id
		i32 2; uint32_t java_name_index
	}, ; 1255
	%struct.TypeMapJava {
		i32 12, ; uint32_t module_index
		i32 u0x02000005, ; uint32_t type_token_id
		i32 730; uint32_t java_name_index
	}, ; 1256
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x02000311, ; uint32_t type_token_id
		i32 316; uint32_t java_name_index
	}, ; 1257
	%struct.TypeMapJava {
		i32 17, ; uint32_t module_index
		i32 u0x02000187, ; uint32_t type_token_id
		i32 850; uint32_t java_name_index
	}, ; 1258
	%struct.TypeMapJava {
		i32 6, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 636; uint32_t java_name_index
	}, ; 1259
	%struct.TypeMapJava {
		i32 34, ; uint32_t module_index
		i32 u0x02000368, ; uint32_t type_token_id
		i32 1113; uint32_t java_name_index
	}, ; 1260
	%struct.TypeMapJava {
		i32 8, ; uint32_t module_index
		i32 u0x02000121, ; uint32_t type_token_id
		i32 656; uint32_t java_name_index
	}, ; 1261
	%struct.TypeMapJava {
		i32 8, ; uint32_t module_index
		i32 u0x02000165, ; uint32_t type_token_id
		i32 691; uint32_t java_name_index
	}, ; 1262
	%struct.TypeMapJava {
		i32 25, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 1038; uint32_t java_name_index
	}, ; 1263
	%struct.TypeMapJava {
		i32 14, ; uint32_t module_index
		i32 u0x02000069, ; uint32_t type_token_id
		i32 766; uint32_t java_name_index
	}, ; 1264
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 565; uint32_t java_name_index
	}, ; 1265
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 180; uint32_t java_name_index
	}, ; 1266
	%struct.TypeMapJava {
		i32 34, ; uint32_t module_index
		i32 u0x02000616, ; uint32_t type_token_id
		i32 1147; uint32_t java_name_index
	}, ; 1267
	%struct.TypeMapJava {
		i32 34, ; uint32_t module_index
		i32 u0x020003f0, ; uint32_t type_token_id
		i32 1194; uint32_t java_name_index
	}, ; 1268
	%struct.TypeMapJava {
		i32 21, ; uint32_t module_index
		i32 u0x0200005c, ; uint32_t type_token_id
		i32 935; uint32_t java_name_index
	}, ; 1269
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 65; uint32_t java_name_index
	}, ; 1270
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020002ae, ; uint32_t type_token_id
		i32 275; uint32_t java_name_index
	}, ; 1271
	%struct.TypeMapJava {
		i32 34, ; uint32_t module_index
		i32 u0x0200039b, ; uint32_t type_token_id
		i32 1138; uint32_t java_name_index
	}, ; 1272
	%struct.TypeMapJava {
		i32 18, ; uint32_t module_index
		i32 u0x02000083, ; uint32_t type_token_id
		i32 891; uint32_t java_name_index
	}, ; 1273
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x0200015a, ; uint32_t type_token_id
		i32 100; uint32_t java_name_index
	}, ; 1274
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020001b1, ; uint32_t type_token_id
		i32 149; uint32_t java_name_index
	}, ; 1275
	%struct.TypeMapJava {
		i32 8, ; uint32_t module_index
		i32 u0x0200015b, ; uint32_t type_token_id
		i32 682; uint32_t java_name_index
	}, ; 1276
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x020003c9, ; uint32_t type_token_id
		i32 433; uint32_t java_name_index
	}, ; 1277
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 474; uint32_t java_name_index
	}, ; 1278
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 74; uint32_t java_name_index
	}, ; 1279
	%struct.TypeMapJava {
		i32 21, ; uint32_t module_index
		i32 u0x02000049, ; uint32_t type_token_id
		i32 920; uint32_t java_name_index
	}, ; 1280
	%struct.TypeMapJava {
		i32 14, ; uint32_t module_index
		i32 u0x02000068, ; uint32_t type_token_id
		i32 765; uint32_t java_name_index
	}, ; 1281
	%struct.TypeMapJava {
		i32 36, ; uint32_t module_index
		i32 u0x00000000, ; uint32_t type_token_id
		i32 81; uint32_t java_name_index
	} ; 1282
], align 4

; Java type names
@java_type_names = dso_local local_unnamed_addr constant [1283 x ptr] [
	ptr @.str.0, ; 0
	ptr @.str.1, ; 1
	ptr @.str.2, ; 2
	ptr @.str.3, ; 3
	ptr @.str.4, ; 4
	ptr @.str.5, ; 5
	ptr @.str.6, ; 6
	ptr @.str.7, ; 7
	ptr @.str.8, ; 8
	ptr @.str.9, ; 9
	ptr @.str.10, ; 10
	ptr @.str.11, ; 11
	ptr @.str.12, ; 12
	ptr @.str.13, ; 13
	ptr @.str.14, ; 14
	ptr @.str.15, ; 15
	ptr @.str.16, ; 16
	ptr @.str.17, ; 17
	ptr @.str.18, ; 18
	ptr @.str.19, ; 19
	ptr @.str.20, ; 20
	ptr @.str.21, ; 21
	ptr @.str.22, ; 22
	ptr @.str.23, ; 23
	ptr @.str.24, ; 24
	ptr @.str.25, ; 25
	ptr @.str.26, ; 26
	ptr @.str.27, ; 27
	ptr @.str.28, ; 28
	ptr @.str.29, ; 29
	ptr @.str.30, ; 30
	ptr @.str.31, ; 31
	ptr @.str.32, ; 32
	ptr @.str.33, ; 33
	ptr @.str.34, ; 34
	ptr @.str.35, ; 35
	ptr @.str.36, ; 36
	ptr @.str.37, ; 37
	ptr @.str.38, ; 38
	ptr @.str.39, ; 39
	ptr @.str.40, ; 40
	ptr @.str.41, ; 41
	ptr @.str.42, ; 42
	ptr @.str.43, ; 43
	ptr @.str.44, ; 44
	ptr @.str.45, ; 45
	ptr @.str.46, ; 46
	ptr @.str.47, ; 47
	ptr @.str.48, ; 48
	ptr @.str.49, ; 49
	ptr @.str.50, ; 50
	ptr @.str.51, ; 51
	ptr @.str.52, ; 52
	ptr @.str.53, ; 53
	ptr @.str.54, ; 54
	ptr @.str.55, ; 55
	ptr @.str.56, ; 56
	ptr @.str.57, ; 57
	ptr @.str.58, ; 58
	ptr @.str.59, ; 59
	ptr @.str.60, ; 60
	ptr @.str.61, ; 61
	ptr @.str.62, ; 62
	ptr @.str.63, ; 63
	ptr @.str.64, ; 64
	ptr @.str.65, ; 65
	ptr @.str.66, ; 66
	ptr @.str.67, ; 67
	ptr @.str.68, ; 68
	ptr @.str.69, ; 69
	ptr @.str.70, ; 70
	ptr @.str.71, ; 71
	ptr @.str.72, ; 72
	ptr @.str.73, ; 73
	ptr @.str.74, ; 74
	ptr @.str.75, ; 75
	ptr @.str.76, ; 76
	ptr @.str.77, ; 77
	ptr @.str.78, ; 78
	ptr @.str.79, ; 79
	ptr @.str.80, ; 80
	ptr @.str.81, ; 81
	ptr @.str.82, ; 82
	ptr @.str.83, ; 83
	ptr @.str.84, ; 84
	ptr @.str.85, ; 85
	ptr @.str.86, ; 86
	ptr @.str.87, ; 87
	ptr @.str.88, ; 88
	ptr @.str.89, ; 89
	ptr @.str.90, ; 90
	ptr @.str.91, ; 91
	ptr @.str.92, ; 92
	ptr @.str.93, ; 93
	ptr @.str.94, ; 94
	ptr @.str.95, ; 95
	ptr @.str.96, ; 96
	ptr @.str.97, ; 97
	ptr @.str.98, ; 98
	ptr @.str.99, ; 99
	ptr @.str.100, ; 100
	ptr @.str.101, ; 101
	ptr @.str.102, ; 102
	ptr @.str.103, ; 103
	ptr @.str.104, ; 104
	ptr @.str.105, ; 105
	ptr @.str.106, ; 106
	ptr @.str.107, ; 107
	ptr @.str.108, ; 108
	ptr @.str.109, ; 109
	ptr @.str.110, ; 110
	ptr @.str.111, ; 111
	ptr @.str.112, ; 112
	ptr @.str.113, ; 113
	ptr @.str.114, ; 114
	ptr @.str.115, ; 115
	ptr @.str.116, ; 116
	ptr @.str.117, ; 117
	ptr @.str.118, ; 118
	ptr @.str.119, ; 119
	ptr @.str.120, ; 120
	ptr @.str.121, ; 121
	ptr @.str.122, ; 122
	ptr @.str.123, ; 123
	ptr @.str.124, ; 124
	ptr @.str.125, ; 125
	ptr @.str.126, ; 126
	ptr @.str.127, ; 127
	ptr @.str.128, ; 128
	ptr @.str.129, ; 129
	ptr @.str.130, ; 130
	ptr @.str.131, ; 131
	ptr @.str.132, ; 132
	ptr @.str.133, ; 133
	ptr @.str.134, ; 134
	ptr @.str.135, ; 135
	ptr @.str.136, ; 136
	ptr @.str.137, ; 137
	ptr @.str.138, ; 138
	ptr @.str.139, ; 139
	ptr @.str.140, ; 140
	ptr @.str.141, ; 141
	ptr @.str.142, ; 142
	ptr @.str.143, ; 143
	ptr @.str.144, ; 144
	ptr @.str.145, ; 145
	ptr @.str.146, ; 146
	ptr @.str.147, ; 147
	ptr @.str.148, ; 148
	ptr @.str.149, ; 149
	ptr @.str.150, ; 150
	ptr @.str.151, ; 151
	ptr @.str.152, ; 152
	ptr @.str.153, ; 153
	ptr @.str.154, ; 154
	ptr @.str.155, ; 155
	ptr @.str.156, ; 156
	ptr @.str.157, ; 157
	ptr @.str.158, ; 158
	ptr @.str.159, ; 159
	ptr @.str.160, ; 160
	ptr @.str.161, ; 161
	ptr @.str.162, ; 162
	ptr @.str.163, ; 163
	ptr @.str.164, ; 164
	ptr @.str.165, ; 165
	ptr @.str.166, ; 166
	ptr @.str.167, ; 167
	ptr @.str.168, ; 168
	ptr @.str.169, ; 169
	ptr @.str.170, ; 170
	ptr @.str.171, ; 171
	ptr @.str.172, ; 172
	ptr @.str.173, ; 173
	ptr @.str.174, ; 174
	ptr @.str.175, ; 175
	ptr @.str.176, ; 176
	ptr @.str.177, ; 177
	ptr @.str.178, ; 178
	ptr @.str.179, ; 179
	ptr @.str.180, ; 180
	ptr @.str.181, ; 181
	ptr @.str.182, ; 182
	ptr @.str.183, ; 183
	ptr @.str.184, ; 184
	ptr @.str.185, ; 185
	ptr @.str.186, ; 186
	ptr @.str.187, ; 187
	ptr @.str.188, ; 188
	ptr @.str.189, ; 189
	ptr @.str.190, ; 190
	ptr @.str.191, ; 191
	ptr @.str.192, ; 192
	ptr @.str.193, ; 193
	ptr @.str.194, ; 194
	ptr @.str.195, ; 195
	ptr @.str.196, ; 196
	ptr @.str.197, ; 197
	ptr @.str.198, ; 198
	ptr @.str.199, ; 199
	ptr @.str.200, ; 200
	ptr @.str.201, ; 201
	ptr @.str.202, ; 202
	ptr @.str.203, ; 203
	ptr @.str.204, ; 204
	ptr @.str.205, ; 205
	ptr @.str.206, ; 206
	ptr @.str.207, ; 207
	ptr @.str.208, ; 208
	ptr @.str.209, ; 209
	ptr @.str.210, ; 210
	ptr @.str.211, ; 211
	ptr @.str.212, ; 212
	ptr @.str.213, ; 213
	ptr @.str.214, ; 214
	ptr @.str.215, ; 215
	ptr @.str.216, ; 216
	ptr @.str.217, ; 217
	ptr @.str.218, ; 218
	ptr @.str.219, ; 219
	ptr @.str.220, ; 220
	ptr @.str.221, ; 221
	ptr @.str.222, ; 222
	ptr @.str.223, ; 223
	ptr @.str.224, ; 224
	ptr @.str.225, ; 225
	ptr @.str.226, ; 226
	ptr @.str.227, ; 227
	ptr @.str.228, ; 228
	ptr @.str.229, ; 229
	ptr @.str.230, ; 230
	ptr @.str.231, ; 231
	ptr @.str.232, ; 232
	ptr @.str.233, ; 233
	ptr @.str.234, ; 234
	ptr @.str.235, ; 235
	ptr @.str.236, ; 236
	ptr @.str.237, ; 237
	ptr @.str.238, ; 238
	ptr @.str.239, ; 239
	ptr @.str.240, ; 240
	ptr @.str.241, ; 241
	ptr @.str.242, ; 242
	ptr @.str.243, ; 243
	ptr @.str.244, ; 244
	ptr @.str.245, ; 245
	ptr @.str.246, ; 246
	ptr @.str.247, ; 247
	ptr @.str.248, ; 248
	ptr @.str.249, ; 249
	ptr @.str.250, ; 250
	ptr @.str.251, ; 251
	ptr @.str.252, ; 252
	ptr @.str.253, ; 253
	ptr @.str.254, ; 254
	ptr @.str.255, ; 255
	ptr @.str.256, ; 256
	ptr @.str.257, ; 257
	ptr @.str.258, ; 258
	ptr @.str.259, ; 259
	ptr @.str.260, ; 260
	ptr @.str.261, ; 261
	ptr @.str.262, ; 262
	ptr @.str.263, ; 263
	ptr @.str.264, ; 264
	ptr @.str.265, ; 265
	ptr @.str.266, ; 266
	ptr @.str.267, ; 267
	ptr @.str.268, ; 268
	ptr @.str.269, ; 269
	ptr @.str.270, ; 270
	ptr @.str.271, ; 271
	ptr @.str.272, ; 272
	ptr @.str.273, ; 273
	ptr @.str.274, ; 274
	ptr @.str.275, ; 275
	ptr @.str.276, ; 276
	ptr @.str.277, ; 277
	ptr @.str.278, ; 278
	ptr @.str.279, ; 279
	ptr @.str.280, ; 280
	ptr @.str.281, ; 281
	ptr @.str.282, ; 282
	ptr @.str.283, ; 283
	ptr @.str.284, ; 284
	ptr @.str.285, ; 285
	ptr @.str.286, ; 286
	ptr @.str.287, ; 287
	ptr @.str.288, ; 288
	ptr @.str.289, ; 289
	ptr @.str.290, ; 290
	ptr @.str.291, ; 291
	ptr @.str.292, ; 292
	ptr @.str.293, ; 293
	ptr @.str.294, ; 294
	ptr @.str.295, ; 295
	ptr @.str.296, ; 296
	ptr @.str.297, ; 297
	ptr @.str.298, ; 298
	ptr @.str.299, ; 299
	ptr @.str.300, ; 300
	ptr @.str.301, ; 301
	ptr @.str.302, ; 302
	ptr @.str.303, ; 303
	ptr @.str.304, ; 304
	ptr @.str.305, ; 305
	ptr @.str.306, ; 306
	ptr @.str.307, ; 307
	ptr @.str.308, ; 308
	ptr @.str.309, ; 309
	ptr @.str.310, ; 310
	ptr @.str.311, ; 311
	ptr @.str.312, ; 312
	ptr @.str.313, ; 313
	ptr @.str.314, ; 314
	ptr @.str.315, ; 315
	ptr @.str.316, ; 316
	ptr @.str.317, ; 317
	ptr @.str.318, ; 318
	ptr @.str.319, ; 319
	ptr @.str.320, ; 320
	ptr @.str.321, ; 321
	ptr @.str.322, ; 322
	ptr @.str.323, ; 323
	ptr @.str.324, ; 324
	ptr @.str.325, ; 325
	ptr @.str.326, ; 326
	ptr @.str.327, ; 327
	ptr @.str.328, ; 328
	ptr @.str.329, ; 329
	ptr @.str.330, ; 330
	ptr @.str.331, ; 331
	ptr @.str.332, ; 332
	ptr @.str.333, ; 333
	ptr @.str.334, ; 334
	ptr @.str.335, ; 335
	ptr @.str.336, ; 336
	ptr @.str.337, ; 337
	ptr @.str.338, ; 338
	ptr @.str.339, ; 339
	ptr @.str.340, ; 340
	ptr @.str.341, ; 341
	ptr @.str.342, ; 342
	ptr @.str.343, ; 343
	ptr @.str.344, ; 344
	ptr @.str.345, ; 345
	ptr @.str.346, ; 346
	ptr @.str.347, ; 347
	ptr @.str.348, ; 348
	ptr @.str.349, ; 349
	ptr @.str.350, ; 350
	ptr @.str.351, ; 351
	ptr @.str.352, ; 352
	ptr @.str.353, ; 353
	ptr @.str.354, ; 354
	ptr @.str.355, ; 355
	ptr @.str.356, ; 356
	ptr @.str.357, ; 357
	ptr @.str.358, ; 358
	ptr @.str.359, ; 359
	ptr @.str.360, ; 360
	ptr @.str.361, ; 361
	ptr @.str.362, ; 362
	ptr @.str.363, ; 363
	ptr @.str.364, ; 364
	ptr @.str.365, ; 365
	ptr @.str.366, ; 366
	ptr @.str.367, ; 367
	ptr @.str.368, ; 368
	ptr @.str.369, ; 369
	ptr @.str.370, ; 370
	ptr @.str.371, ; 371
	ptr @.str.372, ; 372
	ptr @.str.373, ; 373
	ptr @.str.374, ; 374
	ptr @.str.375, ; 375
	ptr @.str.376, ; 376
	ptr @.str.377, ; 377
	ptr @.str.378, ; 378
	ptr @.str.379, ; 379
	ptr @.str.380, ; 380
	ptr @.str.381, ; 381
	ptr @.str.382, ; 382
	ptr @.str.383, ; 383
	ptr @.str.384, ; 384
	ptr @.str.385, ; 385
	ptr @.str.386, ; 386
	ptr @.str.387, ; 387
	ptr @.str.388, ; 388
	ptr @.str.389, ; 389
	ptr @.str.390, ; 390
	ptr @.str.391, ; 391
	ptr @.str.392, ; 392
	ptr @.str.393, ; 393
	ptr @.str.394, ; 394
	ptr @.str.395, ; 395
	ptr @.str.396, ; 396
	ptr @.str.397, ; 397
	ptr @.str.398, ; 398
	ptr @.str.399, ; 399
	ptr @.str.400, ; 400
	ptr @.str.401, ; 401
	ptr @.str.402, ; 402
	ptr @.str.403, ; 403
	ptr @.str.404, ; 404
	ptr @.str.405, ; 405
	ptr @.str.406, ; 406
	ptr @.str.407, ; 407
	ptr @.str.408, ; 408
	ptr @.str.409, ; 409
	ptr @.str.410, ; 410
	ptr @.str.411, ; 411
	ptr @.str.412, ; 412
	ptr @.str.413, ; 413
	ptr @.str.414, ; 414
	ptr @.str.415, ; 415
	ptr @.str.416, ; 416
	ptr @.str.417, ; 417
	ptr @.str.418, ; 418
	ptr @.str.419, ; 419
	ptr @.str.420, ; 420
	ptr @.str.421, ; 421
	ptr @.str.422, ; 422
	ptr @.str.423, ; 423
	ptr @.str.424, ; 424
	ptr @.str.425, ; 425
	ptr @.str.426, ; 426
	ptr @.str.427, ; 427
	ptr @.str.428, ; 428
	ptr @.str.429, ; 429
	ptr @.str.430, ; 430
	ptr @.str.431, ; 431
	ptr @.str.432, ; 432
	ptr @.str.433, ; 433
	ptr @.str.434, ; 434
	ptr @.str.435, ; 435
	ptr @.str.436, ; 436
	ptr @.str.437, ; 437
	ptr @.str.438, ; 438
	ptr @.str.439, ; 439
	ptr @.str.440, ; 440
	ptr @.str.441, ; 441
	ptr @.str.442, ; 442
	ptr @.str.443, ; 443
	ptr @.str.444, ; 444
	ptr @.str.445, ; 445
	ptr @.str.446, ; 446
	ptr @.str.447, ; 447
	ptr @.str.448, ; 448
	ptr @.str.449, ; 449
	ptr @.str.450, ; 450
	ptr @.str.451, ; 451
	ptr @.str.452, ; 452
	ptr @.str.453, ; 453
	ptr @.str.454, ; 454
	ptr @.str.455, ; 455
	ptr @.str.456, ; 456
	ptr @.str.457, ; 457
	ptr @.str.458, ; 458
	ptr @.str.459, ; 459
	ptr @.str.460, ; 460
	ptr @.str.461, ; 461
	ptr @.str.462, ; 462
	ptr @.str.463, ; 463
	ptr @.str.464, ; 464
	ptr @.str.465, ; 465
	ptr @.str.466, ; 466
	ptr @.str.467, ; 467
	ptr @.str.468, ; 468
	ptr @.str.469, ; 469
	ptr @.str.470, ; 470
	ptr @.str.471, ; 471
	ptr @.str.472, ; 472
	ptr @.str.473, ; 473
	ptr @.str.474, ; 474
	ptr @.str.475, ; 475
	ptr @.str.476, ; 476
	ptr @.str.477, ; 477
	ptr @.str.478, ; 478
	ptr @.str.479, ; 479
	ptr @.str.480, ; 480
	ptr @.str.481, ; 481
	ptr @.str.482, ; 482
	ptr @.str.483, ; 483
	ptr @.str.484, ; 484
	ptr @.str.485, ; 485
	ptr @.str.486, ; 486
	ptr @.str.487, ; 487
	ptr @.str.488, ; 488
	ptr @.str.489, ; 489
	ptr @.str.490, ; 490
	ptr @.str.491, ; 491
	ptr @.str.492, ; 492
	ptr @.str.493, ; 493
	ptr @.str.494, ; 494
	ptr @.str.495, ; 495
	ptr @.str.496, ; 496
	ptr @.str.497, ; 497
	ptr @.str.498, ; 498
	ptr @.str.499, ; 499
	ptr @.str.500, ; 500
	ptr @.str.501, ; 501
	ptr @.str.502, ; 502
	ptr @.str.503, ; 503
	ptr @.str.504, ; 504
	ptr @.str.505, ; 505
	ptr @.str.506, ; 506
	ptr @.str.507, ; 507
	ptr @.str.508, ; 508
	ptr @.str.509, ; 509
	ptr @.str.510, ; 510
	ptr @.str.511, ; 511
	ptr @.str.512, ; 512
	ptr @.str.513, ; 513
	ptr @.str.514, ; 514
	ptr @.str.515, ; 515
	ptr @.str.516, ; 516
	ptr @.str.517, ; 517
	ptr @.str.518, ; 518
	ptr @.str.519, ; 519
	ptr @.str.520, ; 520
	ptr @.str.521, ; 521
	ptr @.str.522, ; 522
	ptr @.str.523, ; 523
	ptr @.str.524, ; 524
	ptr @.str.525, ; 525
	ptr @.str.526, ; 526
	ptr @.str.527, ; 527
	ptr @.str.528, ; 528
	ptr @.str.529, ; 529
	ptr @.str.530, ; 530
	ptr @.str.531, ; 531
	ptr @.str.532, ; 532
	ptr @.str.533, ; 533
	ptr @.str.534, ; 534
	ptr @.str.535, ; 535
	ptr @.str.536, ; 536
	ptr @.str.537, ; 537
	ptr @.str.538, ; 538
	ptr @.str.539, ; 539
	ptr @.str.540, ; 540
	ptr @.str.541, ; 541
	ptr @.str.542, ; 542
	ptr @.str.543, ; 543
	ptr @.str.544, ; 544
	ptr @.str.545, ; 545
	ptr @.str.546, ; 546
	ptr @.str.547, ; 547
	ptr @.str.548, ; 548
	ptr @.str.549, ; 549
	ptr @.str.550, ; 550
	ptr @.str.551, ; 551
	ptr @.str.552, ; 552
	ptr @.str.553, ; 553
	ptr @.str.554, ; 554
	ptr @.str.555, ; 555
	ptr @.str.556, ; 556
	ptr @.str.557, ; 557
	ptr @.str.558, ; 558
	ptr @.str.559, ; 559
	ptr @.str.560, ; 560
	ptr @.str.561, ; 561
	ptr @.str.562, ; 562
	ptr @.str.563, ; 563
	ptr @.str.564, ; 564
	ptr @.str.565, ; 565
	ptr @.str.566, ; 566
	ptr @.str.567, ; 567
	ptr @.str.568, ; 568
	ptr @.str.569, ; 569
	ptr @.str.570, ; 570
	ptr @.str.571, ; 571
	ptr @.str.572, ; 572
	ptr @.str.573, ; 573
	ptr @.str.574, ; 574
	ptr @.str.575, ; 575
	ptr @.str.576, ; 576
	ptr @.str.577, ; 577
	ptr @.str.578, ; 578
	ptr @.str.579, ; 579
	ptr @.str.580, ; 580
	ptr @.str.581, ; 581
	ptr @.str.582, ; 582
	ptr @.str.583, ; 583
	ptr @.str.584, ; 584
	ptr @.str.585, ; 585
	ptr @.str.586, ; 586
	ptr @.str.587, ; 587
	ptr @.str.588, ; 588
	ptr @.str.589, ; 589
	ptr @.str.590, ; 590
	ptr @.str.591, ; 591
	ptr @.str.592, ; 592
	ptr @.str.593, ; 593
	ptr @.str.594, ; 594
	ptr @.str.595, ; 595
	ptr @.str.596, ; 596
	ptr @.str.597, ; 597
	ptr @.str.598, ; 598
	ptr @.str.599, ; 599
	ptr @.str.600, ; 600
	ptr @.str.601, ; 601
	ptr @.str.602, ; 602
	ptr @.str.603, ; 603
	ptr @.str.604, ; 604
	ptr @.str.605, ; 605
	ptr @.str.606, ; 606
	ptr @.str.607, ; 607
	ptr @.str.608, ; 608
	ptr @.str.609, ; 609
	ptr @.str.610, ; 610
	ptr @.str.611, ; 611
	ptr @.str.612, ; 612
	ptr @.str.613, ; 613
	ptr @.str.614, ; 614
	ptr @.str.615, ; 615
	ptr @.str.616, ; 616
	ptr @.str.617, ; 617
	ptr @.str.618, ; 618
	ptr @.str.619, ; 619
	ptr @.str.620, ; 620
	ptr @.str.621, ; 621
	ptr @.str.622, ; 622
	ptr @.str.623, ; 623
	ptr @.str.624, ; 624
	ptr @.str.625, ; 625
	ptr @.str.626, ; 626
	ptr @.str.627, ; 627
	ptr @.str.628, ; 628
	ptr @.str.629, ; 629
	ptr @.str.630, ; 630
	ptr @.str.631, ; 631
	ptr @.str.632, ; 632
	ptr @.str.633, ; 633
	ptr @.str.634, ; 634
	ptr @.str.635, ; 635
	ptr @.str.636, ; 636
	ptr @.str.637, ; 637
	ptr @.str.638, ; 638
	ptr @.str.639, ; 639
	ptr @.str.640, ; 640
	ptr @.str.641, ; 641
	ptr @.str.642, ; 642
	ptr @.str.643, ; 643
	ptr @.str.644, ; 644
	ptr @.str.645, ; 645
	ptr @.str.646, ; 646
	ptr @.str.647, ; 647
	ptr @.str.648, ; 648
	ptr @.str.649, ; 649
	ptr @.str.650, ; 650
	ptr @.str.651, ; 651
	ptr @.str.652, ; 652
	ptr @.str.653, ; 653
	ptr @.str.654, ; 654
	ptr @.str.655, ; 655
	ptr @.str.656, ; 656
	ptr @.str.657, ; 657
	ptr @.str.658, ; 658
	ptr @.str.659, ; 659
	ptr @.str.660, ; 660
	ptr @.str.661, ; 661
	ptr @.str.662, ; 662
	ptr @.str.663, ; 663
	ptr @.str.664, ; 664
	ptr @.str.665, ; 665
	ptr @.str.666, ; 666
	ptr @.str.667, ; 667
	ptr @.str.668, ; 668
	ptr @.str.669, ; 669
	ptr @.str.670, ; 670
	ptr @.str.671, ; 671
	ptr @.str.672, ; 672
	ptr @.str.673, ; 673
	ptr @.str.674, ; 674
	ptr @.str.675, ; 675
	ptr @.str.676, ; 676
	ptr @.str.677, ; 677
	ptr @.str.678, ; 678
	ptr @.str.679, ; 679
	ptr @.str.680, ; 680
	ptr @.str.681, ; 681
	ptr @.str.682, ; 682
	ptr @.str.683, ; 683
	ptr @.str.684, ; 684
	ptr @.str.685, ; 685
	ptr @.str.686, ; 686
	ptr @.str.687, ; 687
	ptr @.str.688, ; 688
	ptr @.str.689, ; 689
	ptr @.str.690, ; 690
	ptr @.str.691, ; 691
	ptr @.str.692, ; 692
	ptr @.str.693, ; 693
	ptr @.str.694, ; 694
	ptr @.str.695, ; 695
	ptr @.str.696, ; 696
	ptr @.str.697, ; 697
	ptr @.str.698, ; 698
	ptr @.str.699, ; 699
	ptr @.str.700, ; 700
	ptr @.str.701, ; 701
	ptr @.str.702, ; 702
	ptr @.str.703, ; 703
	ptr @.str.704, ; 704
	ptr @.str.705, ; 705
	ptr @.str.706, ; 706
	ptr @.str.707, ; 707
	ptr @.str.708, ; 708
	ptr @.str.709, ; 709
	ptr @.str.710, ; 710
	ptr @.str.711, ; 711
	ptr @.str.712, ; 712
	ptr @.str.713, ; 713
	ptr @.str.714, ; 714
	ptr @.str.715, ; 715
	ptr @.str.716, ; 716
	ptr @.str.717, ; 717
	ptr @.str.718, ; 718
	ptr @.str.719, ; 719
	ptr @.str.720, ; 720
	ptr @.str.721, ; 721
	ptr @.str.722, ; 722
	ptr @.str.723, ; 723
	ptr @.str.724, ; 724
	ptr @.str.725, ; 725
	ptr @.str.726, ; 726
	ptr @.str.727, ; 727
	ptr @.str.728, ; 728
	ptr @.str.729, ; 729
	ptr @.str.730, ; 730
	ptr @.str.731, ; 731
	ptr @.str.732, ; 732
	ptr @.str.733, ; 733
	ptr @.str.734, ; 734
	ptr @.str.735, ; 735
	ptr @.str.736, ; 736
	ptr @.str.737, ; 737
	ptr @.str.738, ; 738
	ptr @.str.739, ; 739
	ptr @.str.740, ; 740
	ptr @.str.741, ; 741
	ptr @.str.742, ; 742
	ptr @.str.743, ; 743
	ptr @.str.744, ; 744
	ptr @.str.745, ; 745
	ptr @.str.746, ; 746
	ptr @.str.747, ; 747
	ptr @.str.748, ; 748
	ptr @.str.749, ; 749
	ptr @.str.750, ; 750
	ptr @.str.751, ; 751
	ptr @.str.752, ; 752
	ptr @.str.753, ; 753
	ptr @.str.754, ; 754
	ptr @.str.755, ; 755
	ptr @.str.756, ; 756
	ptr @.str.757, ; 757
	ptr @.str.758, ; 758
	ptr @.str.759, ; 759
	ptr @.str.760, ; 760
	ptr @.str.761, ; 761
	ptr @.str.762, ; 762
	ptr @.str.763, ; 763
	ptr @.str.764, ; 764
	ptr @.str.765, ; 765
	ptr @.str.766, ; 766
	ptr @.str.767, ; 767
	ptr @.str.768, ; 768
	ptr @.str.769, ; 769
	ptr @.str.770, ; 770
	ptr @.str.771, ; 771
	ptr @.str.772, ; 772
	ptr @.str.773, ; 773
	ptr @.str.774, ; 774
	ptr @.str.775, ; 775
	ptr @.str.776, ; 776
	ptr @.str.777, ; 777
	ptr @.str.778, ; 778
	ptr @.str.779, ; 779
	ptr @.str.780, ; 780
	ptr @.str.781, ; 781
	ptr @.str.782, ; 782
	ptr @.str.783, ; 783
	ptr @.str.784, ; 784
	ptr @.str.785, ; 785
	ptr @.str.786, ; 786
	ptr @.str.787, ; 787
	ptr @.str.788, ; 788
	ptr @.str.789, ; 789
	ptr @.str.790, ; 790
	ptr @.str.791, ; 791
	ptr @.str.792, ; 792
	ptr @.str.793, ; 793
	ptr @.str.794, ; 794
	ptr @.str.795, ; 795
	ptr @.str.796, ; 796
	ptr @.str.797, ; 797
	ptr @.str.798, ; 798
	ptr @.str.799, ; 799
	ptr @.str.800, ; 800
	ptr @.str.801, ; 801
	ptr @.str.802, ; 802
	ptr @.str.803, ; 803
	ptr @.str.804, ; 804
	ptr @.str.805, ; 805
	ptr @.str.806, ; 806
	ptr @.str.807, ; 807
	ptr @.str.808, ; 808
	ptr @.str.809, ; 809
	ptr @.str.810, ; 810
	ptr @.str.811, ; 811
	ptr @.str.812, ; 812
	ptr @.str.813, ; 813
	ptr @.str.814, ; 814
	ptr @.str.815, ; 815
	ptr @.str.816, ; 816
	ptr @.str.817, ; 817
	ptr @.str.818, ; 818
	ptr @.str.819, ; 819
	ptr @.str.820, ; 820
	ptr @.str.821, ; 821
	ptr @.str.822, ; 822
	ptr @.str.823, ; 823
	ptr @.str.824, ; 824
	ptr @.str.825, ; 825
	ptr @.str.826, ; 826
	ptr @.str.827, ; 827
	ptr @.str.828, ; 828
	ptr @.str.829, ; 829
	ptr @.str.830, ; 830
	ptr @.str.831, ; 831
	ptr @.str.832, ; 832
	ptr @.str.833, ; 833
	ptr @.str.834, ; 834
	ptr @.str.835, ; 835
	ptr @.str.836, ; 836
	ptr @.str.837, ; 837
	ptr @.str.838, ; 838
	ptr @.str.839, ; 839
	ptr @.str.840, ; 840
	ptr @.str.841, ; 841
	ptr @.str.842, ; 842
	ptr @.str.843, ; 843
	ptr @.str.844, ; 844
	ptr @.str.845, ; 845
	ptr @.str.846, ; 846
	ptr @.str.847, ; 847
	ptr @.str.848, ; 848
	ptr @.str.849, ; 849
	ptr @.str.850, ; 850
	ptr @.str.851, ; 851
	ptr @.str.852, ; 852
	ptr @.str.853, ; 853
	ptr @.str.854, ; 854
	ptr @.str.855, ; 855
	ptr @.str.856, ; 856
	ptr @.str.857, ; 857
	ptr @.str.858, ; 858
	ptr @.str.859, ; 859
	ptr @.str.860, ; 860
	ptr @.str.861, ; 861
	ptr @.str.862, ; 862
	ptr @.str.863, ; 863
	ptr @.str.864, ; 864
	ptr @.str.865, ; 865
	ptr @.str.866, ; 866
	ptr @.str.867, ; 867
	ptr @.str.868, ; 868
	ptr @.str.869, ; 869
	ptr @.str.870, ; 870
	ptr @.str.871, ; 871
	ptr @.str.872, ; 872
	ptr @.str.873, ; 873
	ptr @.str.874, ; 874
	ptr @.str.875, ; 875
	ptr @.str.876, ; 876
	ptr @.str.877, ; 877
	ptr @.str.878, ; 878
	ptr @.str.879, ; 879
	ptr @.str.880, ; 880
	ptr @.str.881, ; 881
	ptr @.str.882, ; 882
	ptr @.str.883, ; 883
	ptr @.str.884, ; 884
	ptr @.str.885, ; 885
	ptr @.str.886, ; 886
	ptr @.str.887, ; 887
	ptr @.str.888, ; 888
	ptr @.str.889, ; 889
	ptr @.str.890, ; 890
	ptr @.str.891, ; 891
	ptr @.str.892, ; 892
	ptr @.str.893, ; 893
	ptr @.str.894, ; 894
	ptr @.str.895, ; 895
	ptr @.str.896, ; 896
	ptr @.str.897, ; 897
	ptr @.str.898, ; 898
	ptr @.str.899, ; 899
	ptr @.str.900, ; 900
	ptr @.str.901, ; 901
	ptr @.str.902, ; 902
	ptr @.str.903, ; 903
	ptr @.str.904, ; 904
	ptr @.str.905, ; 905
	ptr @.str.906, ; 906
	ptr @.str.907, ; 907
	ptr @.str.908, ; 908
	ptr @.str.909, ; 909
	ptr @.str.910, ; 910
	ptr @.str.911, ; 911
	ptr @.str.912, ; 912
	ptr @.str.913, ; 913
	ptr @.str.914, ; 914
	ptr @.str.915, ; 915
	ptr @.str.916, ; 916
	ptr @.str.917, ; 917
	ptr @.str.918, ; 918
	ptr @.str.919, ; 919
	ptr @.str.920, ; 920
	ptr @.str.921, ; 921
	ptr @.str.922, ; 922
	ptr @.str.923, ; 923
	ptr @.str.924, ; 924
	ptr @.str.925, ; 925
	ptr @.str.926, ; 926
	ptr @.str.927, ; 927
	ptr @.str.928, ; 928
	ptr @.str.929, ; 929
	ptr @.str.930, ; 930
	ptr @.str.931, ; 931
	ptr @.str.932, ; 932
	ptr @.str.933, ; 933
	ptr @.str.934, ; 934
	ptr @.str.935, ; 935
	ptr @.str.936, ; 936
	ptr @.str.937, ; 937
	ptr @.str.938, ; 938
	ptr @.str.939, ; 939
	ptr @.str.940, ; 940
	ptr @.str.941, ; 941
	ptr @.str.942, ; 942
	ptr @.str.943, ; 943
	ptr @.str.944, ; 944
	ptr @.str.945, ; 945
	ptr @.str.946, ; 946
	ptr @.str.947, ; 947
	ptr @.str.948, ; 948
	ptr @.str.949, ; 949
	ptr @.str.950, ; 950
	ptr @.str.951, ; 951
	ptr @.str.952, ; 952
	ptr @.str.953, ; 953
	ptr @.str.954, ; 954
	ptr @.str.955, ; 955
	ptr @.str.956, ; 956
	ptr @.str.957, ; 957
	ptr @.str.958, ; 958
	ptr @.str.959, ; 959
	ptr @.str.960, ; 960
	ptr @.str.961, ; 961
	ptr @.str.962, ; 962
	ptr @.str.963, ; 963
	ptr @.str.964, ; 964
	ptr @.str.965, ; 965
	ptr @.str.966, ; 966
	ptr @.str.967, ; 967
	ptr @.str.968, ; 968
	ptr @.str.969, ; 969
	ptr @.str.970, ; 970
	ptr @.str.971, ; 971
	ptr @.str.972, ; 972
	ptr @.str.973, ; 973
	ptr @.str.974, ; 974
	ptr @.str.975, ; 975
	ptr @.str.976, ; 976
	ptr @.str.977, ; 977
	ptr @.str.978, ; 978
	ptr @.str.979, ; 979
	ptr @.str.980, ; 980
	ptr @.str.981, ; 981
	ptr @.str.982, ; 982
	ptr @.str.983, ; 983
	ptr @.str.984, ; 984
	ptr @.str.985, ; 985
	ptr @.str.986, ; 986
	ptr @.str.987, ; 987
	ptr @.str.988, ; 988
	ptr @.str.989, ; 989
	ptr @.str.990, ; 990
	ptr @.str.991, ; 991
	ptr @.str.992, ; 992
	ptr @.str.993, ; 993
	ptr @.str.994, ; 994
	ptr @.str.995, ; 995
	ptr @.str.996, ; 996
	ptr @.str.997, ; 997
	ptr @.str.998, ; 998
	ptr @.str.999, ; 999
	ptr @.str.1000, ; 1000
	ptr @.str.1001, ; 1001
	ptr @.str.1002, ; 1002
	ptr @.str.1003, ; 1003
	ptr @.str.1004, ; 1004
	ptr @.str.1005, ; 1005
	ptr @.str.1006, ; 1006
	ptr @.str.1007, ; 1007
	ptr @.str.1008, ; 1008
	ptr @.str.1009, ; 1009
	ptr @.str.1010, ; 1010
	ptr @.str.1011, ; 1011
	ptr @.str.1012, ; 1012
	ptr @.str.1013, ; 1013
	ptr @.str.1014, ; 1014
	ptr @.str.1015, ; 1015
	ptr @.str.1016, ; 1016
	ptr @.str.1017, ; 1017
	ptr @.str.1018, ; 1018
	ptr @.str.1019, ; 1019
	ptr @.str.1020, ; 1020
	ptr @.str.1021, ; 1021
	ptr @.str.1022, ; 1022
	ptr @.str.1023, ; 1023
	ptr @.str.1024, ; 1024
	ptr @.str.1025, ; 1025
	ptr @.str.1026, ; 1026
	ptr @.str.1027, ; 1027
	ptr @.str.1028, ; 1028
	ptr @.str.1029, ; 1029
	ptr @.str.1030, ; 1030
	ptr @.str.1031, ; 1031
	ptr @.str.1032, ; 1032
	ptr @.str.1033, ; 1033
	ptr @.str.1034, ; 1034
	ptr @.str.1035, ; 1035
	ptr @.str.1036, ; 1036
	ptr @.str.1037, ; 1037
	ptr @.str.1038, ; 1038
	ptr @.str.1039, ; 1039
	ptr @.str.1040, ; 1040
	ptr @.str.1041, ; 1041
	ptr @.str.1042, ; 1042
	ptr @.str.1043, ; 1043
	ptr @.str.1044, ; 1044
	ptr @.str.1045, ; 1045
	ptr @.str.1046, ; 1046
	ptr @.str.1047, ; 1047
	ptr @.str.1048, ; 1048
	ptr @.str.1049, ; 1049
	ptr @.str.1050, ; 1050
	ptr @.str.1051, ; 1051
	ptr @.str.1052, ; 1052
	ptr @.str.1053, ; 1053
	ptr @.str.1054, ; 1054
	ptr @.str.1055, ; 1055
	ptr @.str.1056, ; 1056
	ptr @.str.1057, ; 1057
	ptr @.str.1058, ; 1058
	ptr @.str.1059, ; 1059
	ptr @.str.1060, ; 1060
	ptr @.str.1061, ; 1061
	ptr @.str.1062, ; 1062
	ptr @.str.1063, ; 1063
	ptr @.str.1064, ; 1064
	ptr @.str.1065, ; 1065
	ptr @.str.1066, ; 1066
	ptr @.str.1067, ; 1067
	ptr @.str.1068, ; 1068
	ptr @.str.1069, ; 1069
	ptr @.str.1070, ; 1070
	ptr @.str.1071, ; 1071
	ptr @.str.1072, ; 1072
	ptr @.str.1073, ; 1073
	ptr @.str.1074, ; 1074
	ptr @.str.1075, ; 1075
	ptr @.str.1076, ; 1076
	ptr @.str.1077, ; 1077
	ptr @.str.1078, ; 1078
	ptr @.str.1079, ; 1079
	ptr @.str.1080, ; 1080
	ptr @.str.1081, ; 1081
	ptr @.str.1082, ; 1082
	ptr @.str.1083, ; 1083
	ptr @.str.1084, ; 1084
	ptr @.str.1085, ; 1085
	ptr @.str.1086, ; 1086
	ptr @.str.1087, ; 1087
	ptr @.str.1088, ; 1088
	ptr @.str.1089, ; 1089
	ptr @.str.1090, ; 1090
	ptr @.str.1091, ; 1091
	ptr @.str.1092, ; 1092
	ptr @.str.1093, ; 1093
	ptr @.str.1094, ; 1094
	ptr @.str.1095, ; 1095
	ptr @.str.1096, ; 1096
	ptr @.str.1097, ; 1097
	ptr @.str.1098, ; 1098
	ptr @.str.1099, ; 1099
	ptr @.str.1100, ; 1100
	ptr @.str.1101, ; 1101
	ptr @.str.1102, ; 1102
	ptr @.str.1103, ; 1103
	ptr @.str.1104, ; 1104
	ptr @.str.1105, ; 1105
	ptr @.str.1106, ; 1106
	ptr @.str.1107, ; 1107
	ptr @.str.1108, ; 1108
	ptr @.str.1109, ; 1109
	ptr @.str.1110, ; 1110
	ptr @.str.1111, ; 1111
	ptr @.str.1112, ; 1112
	ptr @.str.1113, ; 1113
	ptr @.str.1114, ; 1114
	ptr @.str.1115, ; 1115
	ptr @.str.1116, ; 1116
	ptr @.str.1117, ; 1117
	ptr @.str.1118, ; 1118
	ptr @.str.1119, ; 1119
	ptr @.str.1120, ; 1120
	ptr @.str.1121, ; 1121
	ptr @.str.1122, ; 1122
	ptr @.str.1123, ; 1123
	ptr @.str.1124, ; 1124
	ptr @.str.1125, ; 1125
	ptr @.str.1126, ; 1126
	ptr @.str.1127, ; 1127
	ptr @.str.1128, ; 1128
	ptr @.str.1129, ; 1129
	ptr @.str.1130, ; 1130
	ptr @.str.1131, ; 1131
	ptr @.str.1132, ; 1132
	ptr @.str.1133, ; 1133
	ptr @.str.1134, ; 1134
	ptr @.str.1135, ; 1135
	ptr @.str.1136, ; 1136
	ptr @.str.1137, ; 1137
	ptr @.str.1138, ; 1138
	ptr @.str.1139, ; 1139
	ptr @.str.1140, ; 1140
	ptr @.str.1141, ; 1141
	ptr @.str.1142, ; 1142
	ptr @.str.1143, ; 1143
	ptr @.str.1144, ; 1144
	ptr @.str.1145, ; 1145
	ptr @.str.1146, ; 1146
	ptr @.str.1147, ; 1147
	ptr @.str.1148, ; 1148
	ptr @.str.1149, ; 1149
	ptr @.str.1150, ; 1150
	ptr @.str.1151, ; 1151
	ptr @.str.1152, ; 1152
	ptr @.str.1153, ; 1153
	ptr @.str.1154, ; 1154
	ptr @.str.1155, ; 1155
	ptr @.str.1156, ; 1156
	ptr @.str.1157, ; 1157
	ptr @.str.1158, ; 1158
	ptr @.str.1159, ; 1159
	ptr @.str.1160, ; 1160
	ptr @.str.1161, ; 1161
	ptr @.str.1162, ; 1162
	ptr @.str.1163, ; 1163
	ptr @.str.1164, ; 1164
	ptr @.str.1165, ; 1165
	ptr @.str.1166, ; 1166
	ptr @.str.1167, ; 1167
	ptr @.str.1168, ; 1168
	ptr @.str.1169, ; 1169
	ptr @.str.1170, ; 1170
	ptr @.str.1171, ; 1171
	ptr @.str.1172, ; 1172
	ptr @.str.1173, ; 1173
	ptr @.str.1174, ; 1174
	ptr @.str.1175, ; 1175
	ptr @.str.1176, ; 1176
	ptr @.str.1177, ; 1177
	ptr @.str.1178, ; 1178
	ptr @.str.1179, ; 1179
	ptr @.str.1180, ; 1180
	ptr @.str.1181, ; 1181
	ptr @.str.1182, ; 1182
	ptr @.str.1183, ; 1183
	ptr @.str.1184, ; 1184
	ptr @.str.1185, ; 1185
	ptr @.str.1186, ; 1186
	ptr @.str.1187, ; 1187
	ptr @.str.1188, ; 1188
	ptr @.str.1189, ; 1189
	ptr @.str.1190, ; 1190
	ptr @.str.1191, ; 1191
	ptr @.str.1192, ; 1192
	ptr @.str.1193, ; 1193
	ptr @.str.1194, ; 1194
	ptr @.str.1195, ; 1195
	ptr @.str.1196, ; 1196
	ptr @.str.1197, ; 1197
	ptr @.str.1198, ; 1198
	ptr @.str.1199, ; 1199
	ptr @.str.1200, ; 1200
	ptr @.str.1201, ; 1201
	ptr @.str.1202, ; 1202
	ptr @.str.1203, ; 1203
	ptr @.str.1204, ; 1204
	ptr @.str.1205, ; 1205
	ptr @.str.1206, ; 1206
	ptr @.str.1207, ; 1207
	ptr @.str.1208, ; 1208
	ptr @.str.1209, ; 1209
	ptr @.str.1210, ; 1210
	ptr @.str.1211, ; 1211
	ptr @.str.1212, ; 1212
	ptr @.str.1213, ; 1213
	ptr @.str.1214, ; 1214
	ptr @.str.1215, ; 1215
	ptr @.str.1216, ; 1216
	ptr @.str.1217, ; 1217
	ptr @.str.1218, ; 1218
	ptr @.str.1219, ; 1219
	ptr @.str.1220, ; 1220
	ptr @.str.1221, ; 1221
	ptr @.str.1222, ; 1222
	ptr @.str.1223, ; 1223
	ptr @.str.1224, ; 1224
	ptr @.str.1225, ; 1225
	ptr @.str.1226, ; 1226
	ptr @.str.1227, ; 1227
	ptr @.str.1228, ; 1228
	ptr @.str.1229, ; 1229
	ptr @.str.1230, ; 1230
	ptr @.str.1231, ; 1231
	ptr @.str.1232, ; 1232
	ptr @.str.1233, ; 1233
	ptr @.str.1234, ; 1234
	ptr @.str.1235, ; 1235
	ptr @.str.1236, ; 1236
	ptr @.str.1237, ; 1237
	ptr @.str.1238, ; 1238
	ptr @.str.1239, ; 1239
	ptr @.str.1240, ; 1240
	ptr @.str.1241, ; 1241
	ptr @.str.1242, ; 1242
	ptr @.str.1243, ; 1243
	ptr @.str.1244, ; 1244
	ptr @.str.1245, ; 1245
	ptr @.str.1246, ; 1246
	ptr @.str.1247, ; 1247
	ptr @.str.1248, ; 1248
	ptr @.str.1249, ; 1249
	ptr @.str.1250, ; 1250
	ptr @.str.1251, ; 1251
	ptr @.str.1252, ; 1252
	ptr @.str.1253, ; 1253
	ptr @.str.1254, ; 1254
	ptr @.str.1255, ; 1255
	ptr @.str.1256, ; 1256
	ptr @.str.1257, ; 1257
	ptr @.str.1258, ; 1258
	ptr @.str.1259, ; 1259
	ptr @.str.1260, ; 1260
	ptr @.str.1261, ; 1261
	ptr @.str.1262, ; 1262
	ptr @.str.1263, ; 1263
	ptr @.str.1264, ; 1264
	ptr @.str.1265, ; 1265
	ptr @.str.1266, ; 1266
	ptr @.str.1267, ; 1267
	ptr @.str.1268, ; 1268
	ptr @.str.1269, ; 1269
	ptr @.str.1270, ; 1270
	ptr @.str.1271, ; 1271
	ptr @.str.1272, ; 1272
	ptr @.str.1273, ; 1273
	ptr @.str.1274, ; 1274
	ptr @.str.1275, ; 1275
	ptr @.str.1276, ; 1276
	ptr @.str.1277, ; 1277
	ptr @.str.1278, ; 1278
	ptr @.str.1279, ; 1279
	ptr @.str.1280, ; 1280
	ptr @.str.1281, ; 1281
	ptr @.str.1282 ; 1282
], align 8

; Strings
@.str.0 = private unnamed_addr constant [29 x i8] c"org/xmlpull/v1/XmlPullParser\00", align 1
@.str.1 = private unnamed_addr constant [38 x i8] c"org/xmlpull/v1/XmlPullParserException\00", align 1
@.str.2 = private unnamed_addr constant [32 x i8] c"javax/security/cert/Certificate\00", align 1
@.str.3 = private unnamed_addr constant [36 x i8] c"javax/security/cert/X509Certificate\00", align 1
@.str.4 = private unnamed_addr constant [28 x i8] c"javax/security/auth/Subject\00", align 1
@.str.5 = private unnamed_addr constant [24 x i8] c"javax/net/SocketFactory\00", align 1
@.str.6 = private unnamed_addr constant [33 x i8] c"javax/net/ssl/HttpsURLConnection\00", align 1
@.str.7 = private unnamed_addr constant [31 x i8] c"javax/net/ssl/HostnameVerifier\00", align 1
@.str.8 = private unnamed_addr constant [25 x i8] c"javax/net/ssl/KeyManager\00", align 1
@.str.9 = private unnamed_addr constant [25 x i8] c"javax/net/ssl/SSLSession\00", align 1
@.str.10 = private unnamed_addr constant [32 x i8] c"javax/net/ssl/SSLSessionContext\00", align 1
@.str.11 = private unnamed_addr constant [27 x i8] c"javax/net/ssl/TrustManager\00", align 1
@.str.12 = private unnamed_addr constant [32 x i8] c"javax/net/ssl/KeyManagerFactory\00", align 1
@.str.13 = private unnamed_addr constant [25 x i8] c"javax/net/ssl/SSLContext\00", align 1
@.str.14 = private unnamed_addr constant [31 x i8] c"javax/net/ssl/SSLSocketFactory\00", align 1
@.str.15 = private unnamed_addr constant [34 x i8] c"javax/net/ssl/TrustManagerFactory\00", align 1
@.str.16 = private unnamed_addr constant [33 x i8] c"javax/crypto/BadPaddingException\00", align 1
@.str.17 = private unnamed_addr constant [20 x i8] c"javax/crypto/Cipher\00", align 1
@.str.18 = private unnamed_addr constant [17 x i8] c"javax/crypto/Mac\00", align 1
@.str.19 = private unnamed_addr constant [25 x i8] c"android/window/BackEvent\00", align 1
@.str.20 = private unnamed_addr constant [34 x i8] c"android/window/InputTransferToken\00", align 1
@.str.21 = private unnamed_addr constant [37 x i8] c"android/window/OnBackInvokedCallback\00", align 1
@.str.22 = private unnamed_addr constant [39 x i8] c"android/window/OnBackInvokedDispatcher\00", align 1
@.str.23 = private unnamed_addr constant [45 x i8] c"android/window/TrustedPresentationThresholds\00", align 1
@.str.24 = private unnamed_addr constant [29 x i8] c"android/webkit/CookieManager\00", align 1
@.str.25 = private unnamed_addr constant [29 x i8] c"android/webkit/ValueCallback\00", align 1
@.str.26 = private unnamed_addr constant [34 x i8] c"android/webkit/WebResourceRequest\00", align 1
@.str.27 = private unnamed_addr constant [27 x i8] c"android/webkit/MimeTypeMap\00", align 1
@.str.28 = private unnamed_addr constant [39 x i8] c"android/webkit/RenderProcessGoneDetail\00", align 1
@.str.29 = private unnamed_addr constant [31 x i8] c"android/webkit/WebChromeClient\00", align 1
@.str.30 = private unnamed_addr constant [49 x i8] c"android/webkit/WebChromeClient$FileChooserParams\00", align 1
@.str.31 = private unnamed_addr constant [26 x i8] c"android/webkit/WebMessage\00", align 1
@.str.32 = private unnamed_addr constant [32 x i8] c"android/webkit/WebResourceError\00", align 1
@.str.33 = private unnamed_addr constant [35 x i8] c"android/webkit/WebResourceResponse\00", align 1
@.str.34 = private unnamed_addr constant [27 x i8] c"android/webkit/WebSettings\00", align 1
@.str.35 = private unnamed_addr constant [23 x i8] c"android/webkit/WebView\00", align 1
@.str.36 = private unnamed_addr constant [29 x i8] c"android/webkit/WebViewClient\00", align 1
@.str.37 = private unnamed_addr constant [32 x i8] c"android/renderscript/Allocation\00", align 1
@.str.38 = private unnamed_addr constant [46 x i8] c"android/renderscript/Allocation$MipmapControl\00", align 1
@.str.39 = private unnamed_addr constant [29 x i8] c"android/renderscript/BaseObj\00", align 1
@.str.40 = private unnamed_addr constant [29 x i8] c"android/renderscript/Element\00", align 1
@.str.41 = private unnamed_addr constant [34 x i8] c"android/renderscript/RenderScript\00", align 1
@.str.42 = private unnamed_addr constant [28 x i8] c"android/renderscript/Script\00", align 1
@.str.43 = private unnamed_addr constant [37 x i8] c"android/renderscript/ScriptIntrinsic\00", align 1
@.str.44 = private unnamed_addr constant [41 x i8] c"android/renderscript/ScriptIntrinsicBlur\00", align 1
@.str.45 = private unnamed_addr constant [48 x i8] c"android/renderscript/ScriptIntrinsicConvolve3x3\00", align 1
@.str.46 = private unnamed_addr constant [26 x i8] c"android/renderscript/Type\00", align 1
@.str.47 = private unnamed_addr constant [35 x i8] c"android/provider/DocumentsContract\00", align 1
@.str.48 = private unnamed_addr constant [28 x i8] c"android/provider/MediaStore\00", align 1
@.str.49 = private unnamed_addr constant [34 x i8] c"android/provider/MediaStore$Audio\00", align 1
@.str.50 = private unnamed_addr constant [40 x i8] c"android/provider/MediaStore$Audio$Media\00", align 1
@.str.51 = private unnamed_addr constant [35 x i8] c"android/provider/MediaStore$Images\00", align 1
@.str.52 = private unnamed_addr constant [41 x i8] c"android/provider/MediaStore$Images$Media\00", align 1
@.str.53 = private unnamed_addr constant [34 x i8] c"android/provider/MediaStore$Video\00", align 1
@.str.54 = private unnamed_addr constant [40 x i8] c"android/provider/MediaStore$Video$Media\00", align 1
@.str.55 = private unnamed_addr constant [26 x i8] c"android/provider/Settings\00", align 1
@.str.56 = private unnamed_addr constant [33 x i8] c"android/provider/Settings$Global\00", align 1
@.str.57 = private unnamed_addr constant [41 x i8] c"android/provider/Settings$NameValueTable\00", align 1
@.str.58 = private unnamed_addr constant [33 x i8] c"android/database/CharArrayBuffer\00", align 1
@.str.59 = private unnamed_addr constant [33 x i8] c"android/database/ContentObserver\00", align 1
@.str.60 = private unnamed_addr constant [33 x i8] c"android/database/DataSetObserver\00", align 1
@.str.61 = private unnamed_addr constant [24 x i8] c"android/database/Cursor\00", align 1
@.str.62 = private unnamed_addr constant [27 x i8] c"android/widget/AbsListView\00", align 1
@.str.63 = private unnamed_addr constant [44 x i8] c"android/widget/AbsListView$OnScrollListener\00", align 1
@.str.64 = private unnamed_addr constant [27 x i8] c"android/widget/AdapterView\00", align 1
@.str.65 = private unnamed_addr constant [47 x i8] c"android/widget/AdapterView$OnItemClickListener\00", align 1
@.str.66 = private unnamed_addr constant [63 x i8] c"mono/android/widget/AdapterView_OnItemClickListenerImplementor\00", align 1
@.str.67 = private unnamed_addr constant [51 x i8] c"android/widget/AdapterView$OnItemLongClickListener\00", align 1
@.str.68 = private unnamed_addr constant [50 x i8] c"android/widget/AdapterView$OnItemSelectedListener\00", align 1
@.str.69 = private unnamed_addr constant [36 x i8] c"android/widget/AutoCompleteTextView\00", align 1
@.str.70 = private unnamed_addr constant [27 x i8] c"android/widget/BaseAdapter\00", align 1
@.str.71 = private unnamed_addr constant [26 x i8] c"android/widget/DatePicker\00", align 1
@.str.72 = private unnamed_addr constant [24 x i8] c"android/widget/TextView\00", align 1
@.str.73 = private unnamed_addr constant [35 x i8] c"android/widget/TextView$BufferType\00", align 1
@.str.74 = private unnamed_addr constant [47 x i8] c"android/widget/TextView$OnEditorActionListener\00", align 1
@.str.75 = private unnamed_addr constant [63 x i8] c"mono/android/widget/TextView_OnEditorActionListenerImplementor\00", align 1
@.str.76 = private unnamed_addr constant [30 x i8] c"android/widget/AbsoluteLayout\00", align 1
@.str.77 = private unnamed_addr constant [26 x i8] c"android/widget/AbsSeekBar\00", align 1
@.str.78 = private unnamed_addr constant [22 x i8] c"android/widget/Button\00", align 1
@.str.79 = private unnamed_addr constant [24 x i8] c"android/widget/CheckBox\00", align 1
@.str.80 = private unnamed_addr constant [30 x i8] c"android/widget/CompoundButton\00", align 1
@.str.81 = private unnamed_addr constant [54 x i8] c"android/widget/CompoundButton$OnCheckedChangeListener\00", align 1
@.str.82 = private unnamed_addr constant [70 x i8] c"mono/android/widget/CompoundButton_OnCheckedChangeListenerImplementor\00", align 1
@.str.83 = private unnamed_addr constant [26 x i8] c"android/widget/EdgeEffect\00", align 1
@.str.84 = private unnamed_addr constant [24 x i8] c"android/widget/EditText\00", align 1
@.str.85 = private unnamed_addr constant [22 x i8] c"android/widget/Filter\00", align 1
@.str.86 = private unnamed_addr constant [36 x i8] c"android/widget/Filter$FilterResults\00", align 1
@.str.87 = private unnamed_addr constant [27 x i8] c"android/widget/FrameLayout\00", align 1
@.str.88 = private unnamed_addr constant [40 x i8] c"android/widget/FrameLayout$LayoutParams\00", align 1
@.str.89 = private unnamed_addr constant [36 x i8] c"android/widget/HorizontalScrollView\00", align 1
@.str.90 = private unnamed_addr constant [23 x i8] c"android/widget/Adapter\00", align 1
@.str.91 = private unnamed_addr constant [26 x i8] c"android/widget/Filterable\00", align 1
@.str.92 = private unnamed_addr constant [35 x i8] c"android/widget/FilterQueryProvider\00", align 1
@.str.93 = private unnamed_addr constant [27 x i8] c"android/widget/ListAdapter\00", align 1
@.str.94 = private unnamed_addr constant [27 x i8] c"android/widget/ImageButton\00", align 1
@.str.95 = private unnamed_addr constant [25 x i8] c"android/widget/ImageView\00", align 1
@.str.96 = private unnamed_addr constant [35 x i8] c"android/widget/ImageView$ScaleType\00", align 1
@.str.97 = private unnamed_addr constant [30 x i8] c"android/widget/SectionIndexer\00", align 1
@.str.98 = private unnamed_addr constant [30 x i8] c"android/widget/SpinnerAdapter\00", align 1
@.str.99 = private unnamed_addr constant [28 x i8] c"android/widget/LinearLayout\00", align 1
@.str.100 = private unnamed_addr constant [41 x i8] c"android/widget/LinearLayout$LayoutParams\00", align 1
@.str.101 = private unnamed_addr constant [24 x i8] c"android/widget/ListView\00", align 1
@.str.102 = private unnamed_addr constant [28 x i8] c"android/widget/OverScroller\00", align 1
@.str.103 = private unnamed_addr constant [27 x i8] c"android/widget/PopupWindow\00", align 1
@.str.104 = private unnamed_addr constant [45 x i8] c"android/widget/PopupWindow$OnDismissListener\00", align 1
@.str.105 = private unnamed_addr constant [61 x i8] c"mono/android/widget/PopupWindow_OnDismissListenerImplementor\00", align 1
@.str.106 = private unnamed_addr constant [27 x i8] c"android/widget/ProgressBar\00", align 1
@.str.107 = private unnamed_addr constant [27 x i8] c"android/widget/RadioButton\00", align 1
@.str.108 = private unnamed_addr constant [27 x i8] c"android/widget/RemoteViews\00", align 1
@.str.109 = private unnamed_addr constant [26 x i8] c"android/widget/ScrollView\00", align 1
@.str.110 = private unnamed_addr constant [26 x i8] c"android/widget/SearchView\00", align 1
@.str.111 = private unnamed_addr constant [23 x i8] c"android/widget/SeekBar\00", align 1
@.str.112 = private unnamed_addr constant [47 x i8] c"android/widget/SeekBar$OnSeekBarChangeListener\00", align 1
@.str.113 = private unnamed_addr constant [22 x i8] c"android/widget/Switch\00", align 1
@.str.114 = private unnamed_addr constant [26 x i8] c"android/widget/TimePicker\00", align 1
@.str.115 = private unnamed_addr constant [21 x i8] c"android/widget/Toast\00", align 1
@.str.116 = private unnamed_addr constant [28 x i8] c"android/util/DisplayMetrics\00", align 1
@.str.117 = private unnamed_addr constant [26 x i8] c"android/util/AttributeSet\00", align 1
@.str.118 = private unnamed_addr constant [18 x i8] c"android/util/Pair\00", align 1
@.str.119 = private unnamed_addr constant [19 x i8] c"android/util/SizeF\00", align 1
@.str.120 = private unnamed_addr constant [25 x i8] c"android/util/SparseArray\00", align 1
@.str.121 = private unnamed_addr constant [22 x i8] c"android/util/StateSet\00", align 1
@.str.122 = private unnamed_addr constant [24 x i8] c"android/util/TypedValue\00", align 1
@.str.123 = private unnamed_addr constant [41 x i8] c"mono/android/text/TextWatcherImplementor\00", align 1
@.str.124 = private unnamed_addr constant [18 x i8] c"android/text/Html\00", align 1
@.str.125 = private unnamed_addr constant [22 x i8] c"android/text/Editable\00", align 1
@.str.126 = private unnamed_addr constant [22 x i8] c"android/text/GetChars\00", align 1
@.str.127 = private unnamed_addr constant [38 x i8] c"android/text/InputFilter$LengthFilter\00", align 1
@.str.128 = private unnamed_addr constant [25 x i8] c"android/text/InputFilter\00", align 1
@.str.129 = private unnamed_addr constant [24 x i8] c"android/text/NoCopySpan\00", align 1
@.str.130 = private unnamed_addr constant [23 x i8] c"android/text/Spannable\00", align 1
@.str.131 = private unnamed_addr constant [21 x i8] c"android/text/Spanned\00", align 1
@.str.132 = private unnamed_addr constant [36 x i8] c"android/text/TextDirectionHeuristic\00", align 1
@.str.133 = private unnamed_addr constant [25 x i8] c"android/text/TextWatcher\00", align 1
@.str.134 = private unnamed_addr constant [20 x i8] c"android/text/Layout\00", align 1
@.str.135 = private unnamed_addr constant [30 x i8] c"android/text/Layout$Alignment\00", align 1
@.str.136 = private unnamed_addr constant [29 x i8] c"android/text/SpannableString\00", align 1
@.str.137 = private unnamed_addr constant [36 x i8] c"android/text/SpannableStringBuilder\00", align 1
@.str.138 = private unnamed_addr constant [37 x i8] c"android/text/SpannableStringInternal\00", align 1
@.str.139 = private unnamed_addr constant [26 x i8] c"android/text/StaticLayout\00", align 1
@.str.140 = private unnamed_addr constant [34 x i8] c"android/text/StaticLayout$Builder\00", align 1
@.str.141 = private unnamed_addr constant [23 x i8] c"android/text/TextPaint\00", align 1
@.str.142 = private unnamed_addr constant [23 x i8] c"android/text/TextUtils\00", align 1
@.str.143 = private unnamed_addr constant [34 x i8] c"android/text/TextUtils$TruncateAt\00", align 1
@.str.144 = private unnamed_addr constant [36 x i8] c"android/text/style/AbsoluteSizeSpan\00", align 1
@.str.145 = private unnamed_addr constant [39 x i8] c"android/text/style/BackgroundColorSpan\00", align 1
@.str.146 = private unnamed_addr constant [30 x i8] c"android/text/style/BulletSpan\00", align 1
@.str.147 = private unnamed_addr constant [34 x i8] c"android/text/style/CharacterStyle\00", align 1
@.str.148 = private unnamed_addr constant [33 x i8] c"android/text/style/ClickableSpan\00", align 1
@.str.149 = private unnamed_addr constant [39 x i8] c"android/text/style/ForegroundColorSpan\00", align 1
@.str.150 = private unnamed_addr constant [34 x i8] c"android/text/style/LineHeightSpan\00", align 1
@.str.151 = private unnamed_addr constant [34 x i8] c"android/text/style/ParagraphStyle\00", align 1
@.str.152 = private unnamed_addr constant [36 x i8] c"android/text/style/WrapTogetherSpan\00", align 1
@.str.153 = private unnamed_addr constant [39 x i8] c"android/text/style/MetricAffectingSpan\00", align 1
@.str.154 = private unnamed_addr constant [37 x i8] c"android/text/style/StrikethroughSpan\00", align 1
@.str.155 = private unnamed_addr constant [29 x i8] c"android/text/style/StyleSpan\00", align 1
@.str.156 = private unnamed_addr constant [33 x i8] c"android/text/style/SubscriptSpan\00", align 1
@.str.157 = private unnamed_addr constant [35 x i8] c"android/text/style/SuperscriptSpan\00", align 1
@.str.158 = private unnamed_addr constant [32 x i8] c"android/text/style/TypefaceSpan\00", align 1
@.str.159 = private unnamed_addr constant [33 x i8] c"android/text/style/UnderlineSpan\00", align 1
@.str.160 = private unnamed_addr constant [36 x i8] c"android/text/method/BaseKeyListener\00", align 1
@.str.161 = private unnamed_addr constant [38 x i8] c"android/text/method/DigitsKeyListener\00", align 1
@.str.162 = private unnamed_addr constant [32 x i8] c"android/text/method/KeyListener\00", align 1
@.str.163 = private unnamed_addr constant [39 x i8] c"android/text/method/MetaKeyKeyListener\00", align 1
@.str.164 = private unnamed_addr constant [38 x i8] c"android/text/method/NumberKeyListener\00", align 1
@.str.165 = private unnamed_addr constant [31 x i8] c"android/text/format/DateFormat\00", align 1
@.str.166 = private unnamed_addr constant [35 x i8] c"android/security/KeyStoreException\00", align 1
@.str.167 = private unnamed_addr constant [46 x i8] c"android/security/keystore/KeyGenParameterSpec\00", align 1
@.str.168 = private unnamed_addr constant [37 x i8] c"android/preference/PreferenceManager\00", align 1
@.str.169 = private unnamed_addr constant [22 x i8] c"android/opengl/Matrix\00", align 1
@.str.170 = private unnamed_addr constant [19 x i8] c"android/os/Handler\00", align 1
@.str.171 = private unnamed_addr constant [19 x i8] c"android/os/Message\00", align 1
@.str.172 = private unnamed_addr constant [24 x i8] c"android/os/PowerManager\00", align 1
@.str.173 = private unnamed_addr constant [22 x i8] c"android/os/BaseBundle\00", align 1
@.str.174 = private unnamed_addr constant [18 x i8] c"android/os/Binder\00", align 1
@.str.175 = private unnamed_addr constant [17 x i8] c"android/os/Build\00", align 1
@.str.176 = private unnamed_addr constant [25 x i8] c"android/os/Build$VERSION\00", align 1
@.str.177 = private unnamed_addr constant [18 x i8] c"android/os/Bundle\00", align 1
@.str.178 = private unnamed_addr constant [30 x i8] c"android/os/CancellationSignal\00", align 1
@.str.179 = private unnamed_addr constant [23 x i8] c"android/os/Environment\00", align 1
@.str.180 = private unnamed_addr constant [34 x i8] c"android/os/IBinder$DeathRecipient\00", align 1
@.str.181 = private unnamed_addr constant [19 x i8] c"android/os/IBinder\00", align 1
@.str.182 = private unnamed_addr constant [22 x i8] c"android/os/IInterface\00", align 1
@.str.183 = private unnamed_addr constant [30 x i8] c"android/os/Parcelable$Creator\00", align 1
@.str.184 = private unnamed_addr constant [22 x i8] c"android/os/Parcelable\00", align 1
@.str.185 = private unnamed_addr constant [22 x i8] c"android/os/LocaleList\00", align 1
@.str.186 = private unnamed_addr constant [18 x i8] c"android/os/Looper\00", align 1
@.str.187 = private unnamed_addr constant [18 x i8] c"android/os/Parcel\00", align 1
@.str.188 = private unnamed_addr constant [29 x i8] c"android/os/PersistableBundle\00", align 1
@.str.189 = private unnamed_addr constant [27 x i8] c"android/animation/Animator\00", align 1
@.str.190 = private unnamed_addr constant [44 x i8] c"android/animation/Animator$AnimatorListener\00", align 1
@.str.191 = private unnamed_addr constant [47 x i8] c"mono/android/animation/AnimatorEventDispatcher\00", align 1
@.str.192 = private unnamed_addr constant [32 x i8] c"android/animation/ValueAnimator\00", align 1
@.str.193 = private unnamed_addr constant [55 x i8] c"android/animation/ValueAnimator$AnimatorUpdateListener\00", align 1
@.str.194 = private unnamed_addr constant [71 x i8] c"mono/android/animation/ValueAnimator_AnimatorUpdateListenerImplementor\00", align 1
@.str.195 = private unnamed_addr constant [60 x i8] c"android/animation/ValueAnimator$DurationScaleChangeListener\00", align 1
@.str.196 = private unnamed_addr constant [42 x i8] c"android/animation/AnimatorListenerAdapter\00", align 1
@.str.197 = private unnamed_addr constant [35 x i8] c"android/animation/TimeInterpolator\00", align 1
@.str.198 = private unnamed_addr constant [40 x i8] c"android/view/WindowManager$LayoutParams\00", align 1
@.str.199 = private unnamed_addr constant [18 x i8] c"android/view/View\00", align 1
@.str.200 = private unnamed_addr constant [40 x i8] c"android/view/View$AccessibilityDelegate\00", align 1
@.str.201 = private unnamed_addr constant [36 x i8] c"android/view/View$DragShadowBuilder\00", align 1
@.str.202 = private unnamed_addr constant [30 x i8] c"android/view/View$MeasureSpec\00", align 1
@.str.203 = private unnamed_addr constant [46 x i8] c"android/view/View$OnAttachStateChangeListener\00", align 1
@.str.204 = private unnamed_addr constant [62 x i8] c"mono/android/view/View_OnAttachStateChangeListenerImplementor\00", align 1
@.str.205 = private unnamed_addr constant [34 x i8] c"android/view/View$OnClickListener\00", align 1
@.str.206 = private unnamed_addr constant [50 x i8] c"mono/android/view/View_OnClickListenerImplementor\00", align 1
@.str.207 = private unnamed_addr constant [33 x i8] c"android/view/View$OnDragListener\00", align 1
@.str.208 = private unnamed_addr constant [40 x i8] c"android/view/View$OnFocusChangeListener\00", align 1
@.str.209 = private unnamed_addr constant [56 x i8] c"mono/android/view/View_OnFocusChangeListenerImplementor\00", align 1
@.str.210 = private unnamed_addr constant [34 x i8] c"android/view/View$OnHoverListener\00", align 1
@.str.211 = private unnamed_addr constant [32 x i8] c"android/view/View$OnKeyListener\00", align 1
@.str.212 = private unnamed_addr constant [48 x i8] c"mono/android/view/View_OnKeyListenerImplementor\00", align 1
@.str.213 = private unnamed_addr constant [41 x i8] c"android/view/View$OnLayoutChangeListener\00", align 1
@.str.214 = private unnamed_addr constant [57 x i8] c"mono/android/view/View_OnLayoutChangeListenerImplementor\00", align 1
@.str.215 = private unnamed_addr constant [41 x i8] c"android/view/View$OnScrollChangeListener\00", align 1
@.str.216 = private unnamed_addr constant [57 x i8] c"mono/android/view/View_OnScrollChangeListenerImplementor\00", align 1
@.str.217 = private unnamed_addr constant [34 x i8] c"android/view/View$OnTouchListener\00", align 1
@.str.218 = private unnamed_addr constant [50 x i8] c"mono/android/view/View_OnTouchListenerImplementor\00", align 1
@.str.219 = private unnamed_addr constant [22 x i8] c"android/view/KeyEvent\00", align 1
@.str.220 = private unnamed_addr constant [28 x i8] c"android/view/LayoutInflater\00", align 1
@.str.221 = private unnamed_addr constant [25 x i8] c"android/view/MotionEvent\00", align 1
@.str.222 = private unnamed_addr constant [30 x i8] c"android/view/ViewTreeObserver\00", align 1
@.str.223 = private unnamed_addr constant [53 x i8] c"android/view/ViewTreeObserver$OnGlobalLayoutListener\00", align 1
@.str.224 = private unnamed_addr constant [20 x i8] c"android/view/Window\00", align 1
@.str.225 = private unnamed_addr constant [29 x i8] c"android/view/Window$Callback\00", align 1
@.str.226 = private unnamed_addr constant [24 x i8] c"android/view/ActionMode\00", align 1
@.str.227 = private unnamed_addr constant [33 x i8] c"android/view/ActionMode$Callback\00", align 1
@.str.228 = private unnamed_addr constant [28 x i8] c"android/view/ActionProvider\00", align 1
@.str.229 = private unnamed_addr constant [27 x i8] c"android/view/Choreographer\00", align 1
@.str.230 = private unnamed_addr constant [25 x i8] c"android/view/ContentInfo\00", align 1
@.str.231 = private unnamed_addr constant [33 x i8] c"android/view/ContextThemeWrapper\00", align 1
@.str.232 = private unnamed_addr constant [21 x i8] c"android/view/Display\00", align 1
@.str.233 = private unnamed_addr constant [23 x i8] c"android/view/DragEvent\00", align 1
@.str.234 = private unnamed_addr constant [29 x i8] c"android/view/GestureDetector\00", align 1
@.str.235 = private unnamed_addr constant [49 x i8] c"android/view/GestureDetector$OnDoubleTapListener\00", align 1
@.str.236 = private unnamed_addr constant [47 x i8] c"android/view/GestureDetector$OnGestureListener\00", align 1
@.str.237 = private unnamed_addr constant [53 x i8] c"android/view/GestureDetector$SimpleOnGestureListener\00", align 1
@.str.238 = private unnamed_addr constant [41 x i8] c"android/view/ContextMenu$ContextMenuInfo\00", align 1
@.str.239 = private unnamed_addr constant [25 x i8] c"android/view/ContextMenu\00", align 1
@.str.240 = private unnamed_addr constant [18 x i8] c"android/view/Menu\00", align 1
@.str.241 = private unnamed_addr constant [45 x i8] c"android/view/MenuItem$OnActionExpandListener\00", align 1
@.str.242 = private unnamed_addr constant [46 x i8] c"android/view/MenuItem$OnMenuItemClickListener\00", align 1
@.str.243 = private unnamed_addr constant [22 x i8] c"android/view/MenuItem\00", align 1
@.str.244 = private unnamed_addr constant [24 x i8] c"android/view/InputEvent\00", align 1
@.str.245 = private unnamed_addr constant [21 x i8] c"android/view/SubMenu\00", align 1
@.str.246 = private unnamed_addr constant [41 x i8] c"android/view/SurfaceControlInputReceiver\00", align 1
@.str.247 = private unnamed_addr constant [25 x i8] c"android/view/ViewManager\00", align 1
@.str.248 = private unnamed_addr constant [24 x i8] c"android/view/ViewParent\00", align 1
@.str.249 = private unnamed_addr constant [45 x i8] c"android/view/WindowInsetsAnimationController\00", align 1
@.str.250 = private unnamed_addr constant [50 x i8] c"android/view/WindowInsetsAnimationControlListener\00", align 1
@.str.251 = private unnamed_addr constant [36 x i8] c"android/view/WindowInsetsController\00", align 1
@.str.252 = private unnamed_addr constant [72 x i8] c"android/view/WindowInsetsController$OnControllableInsetsChangedListener\00", align 1
@.str.253 = private unnamed_addr constant [27 x i8] c"android/view/WindowManager\00", align 1
@.str.254 = private unnamed_addr constant [35 x i8] c"android/view/KeyboardShortcutGroup\00", align 1
@.str.255 = private unnamed_addr constant [34 x i8] c"android/view/KeyboardShortcutInfo\00", align 1
@.str.256 = private unnamed_addr constant [26 x i8] c"android/view/MenuInflater\00", align 1
@.str.257 = private unnamed_addr constant [38 x i8] c"android/view/OrientationEventListener\00", align 1
@.str.258 = private unnamed_addr constant [34 x i8] c"android/view/ScaleGestureDetector\00", align 1
@.str.259 = private unnamed_addr constant [57 x i8] c"android/view/ScaleGestureDetector$OnScaleGestureListener\00", align 1
@.str.260 = private unnamed_addr constant [63 x i8] c"android/view/ScaleGestureDetector$SimpleOnScaleGestureListener\00", align 1
@.str.261 = private unnamed_addr constant [25 x i8] c"android/view/SearchEvent\00", align 1
@.str.262 = private unnamed_addr constant [28 x i8] c"android/view/SurfaceControl\00", align 1
@.str.263 = private unnamed_addr constant [31 x i8] c"android/view/ViewConfiguration\00", align 1
@.str.264 = private unnamed_addr constant [23 x i8] c"android/view/ViewGroup\00", align 1
@.str.265 = private unnamed_addr constant [36 x i8] c"android/view/ViewGroup$LayoutParams\00", align 1
@.str.266 = private unnamed_addr constant [42 x i8] c"android/view/ViewGroup$MarginLayoutParams\00", align 1
@.str.267 = private unnamed_addr constant [49 x i8] c"android/view/ViewGroup$OnHierarchyChangeListener\00", align 1
@.str.268 = private unnamed_addr constant [65 x i8] c"mono/android/view/ViewGroup_OnHierarchyChangeListenerImplementor\00", align 1
@.str.269 = private unnamed_addr constant [34 x i8] c"android/view/ViewPropertyAnimator\00", align 1
@.str.270 = private unnamed_addr constant [27 x i8] c"android/view/ViewStructure\00", align 1
@.str.271 = private unnamed_addr constant [26 x i8] c"android/view/WindowInsets\00", align 1
@.str.272 = private unnamed_addr constant [31 x i8] c"android/view/WindowInsets$Type\00", align 1
@.str.273 = private unnamed_addr constant [35 x i8] c"android/view/WindowInsetsAnimation\00", align 1
@.str.274 = private unnamed_addr constant [42 x i8] c"android/view/WindowInsetsAnimation$Bounds\00", align 1
@.str.275 = private unnamed_addr constant [27 x i8] c"android/view/WindowMetrics\00", align 1
@.str.276 = private unnamed_addr constant [50 x i8] c"android/view/contentcapture/ContentCaptureSession\00", align 1
@.str.277 = private unnamed_addr constant [33 x i8] c"android/view/autofill/AutofillId\00", align 1
@.str.278 = private unnamed_addr constant [33 x i8] c"android/view/animation/Animation\00", align 1
@.str.279 = private unnamed_addr constant [51 x i8] c"android/view/animation/Animation$AnimationListener\00", align 1
@.str.280 = private unnamed_addr constant [67 x i8] c"mono/android/view/animation/Animation_AnimationListenerImplementor\00", align 1
@.str.281 = private unnamed_addr constant [36 x i8] c"android/view/animation/AnimationSet\00", align 1
@.str.282 = private unnamed_addr constant [38 x i8] c"android/view/animation/AnimationUtils\00", align 1
@.str.283 = private unnamed_addr constant [40 x i8] c"android/view/animation/BaseInterpolator\00", align 1
@.str.284 = private unnamed_addr constant [46 x i8] c"android/view/animation/DecelerateInterpolator\00", align 1
@.str.285 = private unnamed_addr constant [36 x i8] c"android/view/animation/Interpolator\00", align 1
@.str.286 = private unnamed_addr constant [42 x i8] c"android/view/animation/LinearInterpolator\00", align 1
@.str.287 = private unnamed_addr constant [42 x i8] c"android/view/animation/TranslateAnimation\00", align 1
@.str.288 = private unnamed_addr constant [44 x i8] c"android/view/inputmethod/InputMethodManager\00", align 1
@.str.289 = private unnamed_addr constant [45 x i8] c"android/view/inputmethod/BaseInputConnection\00", align 1
@.str.290 = private unnamed_addr constant [40 x i8] c"android/view/inputmethod/CompletionInfo\00", align 1
@.str.291 = private unnamed_addr constant [40 x i8] c"android/view/inputmethod/CorrectionInfo\00", align 1
@.str.292 = private unnamed_addr constant [36 x i8] c"android/view/inputmethod/EditorInfo\00", align 1
@.str.293 = private unnamed_addr constant [39 x i8] c"android/view/inputmethod/ExtractedText\00", align 1
@.str.294 = private unnamed_addr constant [46 x i8] c"android/view/inputmethod/ExtractedTextRequest\00", align 1
@.str.295 = private unnamed_addr constant [44 x i8] c"android/view/inputmethod/HandwritingGesture\00", align 1
@.str.296 = private unnamed_addr constant [41 x i8] c"android/view/inputmethod/InputConnection\00", align 1
@.str.297 = private unnamed_addr constant [42 x i8] c"android/view/inputmethod/InputContentInfo\00", align 1
@.str.298 = private unnamed_addr constant [55 x i8] c"android/view/inputmethod/PreviewableHandwritingGesture\00", align 1
@.str.299 = private unnamed_addr constant [41 x i8] c"android/view/inputmethod/SurroundingText\00", align 1
@.str.300 = private unnamed_addr constant [39 x i8] c"android/view/inputmethod/TextAttribute\00", align 1
@.str.301 = private unnamed_addr constant [38 x i8] c"android/view/inputmethod/TextSnapshot\00", align 1
@.str.302 = private unnamed_addr constant [46 x i8] c"android/view/accessibility/AccessibilityEvent\00", align 1
@.str.303 = private unnamed_addr constant [48 x i8] c"android/view/accessibility/AccessibilityManager\00", align 1
@.str.304 = private unnamed_addr constant [81 x i8] c"android/view/accessibility/AccessibilityManager$AccessibilityStateChangeListener\00", align 1
@.str.305 = private unnamed_addr constant [49 x i8] c"android/view/accessibility/AccessibilityNodeInfo\00", align 1
@.str.306 = private unnamed_addr constant [68 x i8] c"android/view/accessibility/AccessibilityNodeInfo$ExtraRenderingInfo\00", align 1
@.str.307 = private unnamed_addr constant [47 x i8] c"android/view/accessibility/AccessibilityRecord\00", align 1
@.str.308 = private unnamed_addr constant [51 x i8] c"android/view/accessibility/AccessibilityWindowInfo\00", align 1
@.str.309 = private unnamed_addr constant [40 x i8] c"mono/android/runtime/InputStreamAdapter\00", align 1
@.str.310 = private unnamed_addr constant [31 x i8] c"mono/android/runtime/JavaArray\00", align 1
@.str.311 = private unnamed_addr constant [21 x i8] c"java/util/Collection\00", align 1
@.str.312 = private unnamed_addr constant [18 x i8] c"java/util/HashMap\00", align 1
@.str.313 = private unnamed_addr constant [20 x i8] c"java/util/ArrayList\00", align 1
@.str.314 = private unnamed_addr constant [32 x i8] c"mono/android/runtime/JavaObject\00", align 1
@.str.315 = private unnamed_addr constant [35 x i8] c"android/runtime/JavaProxyThrowable\00", align 1
@.str.316 = private unnamed_addr constant [18 x i8] c"java/util/HashSet\00", align 1
@.str.317 = private unnamed_addr constant [41 x i8] c"mono/android/runtime/OutputStreamAdapter\00", align 1
@.str.318 = private unnamed_addr constant [36 x i8] c"android/runtime/XmlReaderPullParser\00", align 1
@.str.319 = private unnamed_addr constant [32 x i8] c"android/net/ConnectivityManager\00", align 1
@.str.320 = private unnamed_addr constant [48 x i8] c"android/net/ConnectivityManager$NetworkCallback\00", align 1
@.str.321 = private unnamed_addr constant [27 x i8] c"android/net/LinkProperties\00", align 1
@.str.322 = private unnamed_addr constant [20 x i8] c"android/net/Network\00", align 1
@.str.323 = private unnamed_addr constant [32 x i8] c"android/net/NetworkCapabilities\00", align 1
@.str.324 = private unnamed_addr constant [24 x i8] c"android/net/NetworkInfo\00", align 1
@.str.325 = private unnamed_addr constant [27 x i8] c"android/net/NetworkRequest\00", align 1
@.str.326 = private unnamed_addr constant [35 x i8] c"android/net/NetworkRequest$Builder\00", align 1
@.str.327 = private unnamed_addr constant [16 x i8] c"android/net/Uri\00", align 1
@.str.328 = private unnamed_addr constant [24 x i8] c"android/graphics/Bitmap\00", align 1
@.str.329 = private unnamed_addr constant [39 x i8] c"android/graphics/Bitmap$CompressFormat\00", align 1
@.str.330 = private unnamed_addr constant [31 x i8] c"android/graphics/Bitmap$Config\00", align 1
@.str.331 = private unnamed_addr constant [24 x i8] c"android/graphics/Canvas\00", align 1
@.str.332 = private unnamed_addr constant [31 x i8] c"android/graphics/BitmapFactory\00", align 1
@.str.333 = private unnamed_addr constant [39 x i8] c"android/graphics/BitmapFactory$Options\00", align 1
@.str.334 = private unnamed_addr constant [30 x i8] c"android/graphics/BitmapShader\00", align 1
@.str.335 = private unnamed_addr constant [27 x i8] c"android/graphics/BlendMode\00", align 1
@.str.336 = private unnamed_addr constant [32 x i8] c"android/graphics/BlurMaskFilter\00", align 1
@.str.337 = private unnamed_addr constant [37 x i8] c"android/graphics/BlurMaskFilter$Blur\00", align 1
@.str.338 = private unnamed_addr constant [29 x i8] c"android/graphics/ColorFilter\00", align 1
@.str.339 = private unnamed_addr constant [29 x i8] c"android/graphics/ColorMatrix\00", align 1
@.str.340 = private unnamed_addr constant [40 x i8] c"android/graphics/ColorMatrixColorFilter\00", align 1
@.str.341 = private unnamed_addr constant [23 x i8] c"android/graphics/Color\00", align 1
@.str.342 = private unnamed_addr constant [32 x i8] c"android/graphics/DashPathEffect\00", align 1
@.str.343 = private unnamed_addr constant [24 x i8] c"android/graphics/Insets\00", align 1
@.str.344 = private unnamed_addr constant [32 x i8] c"android/graphics/LinearGradient\00", align 1
@.str.345 = private unnamed_addr constant [28 x i8] c"android/graphics/MaskFilter\00", align 1
@.str.346 = private unnamed_addr constant [24 x i8] c"android/graphics/Matrix\00", align 1
@.str.347 = private unnamed_addr constant [23 x i8] c"android/graphics/Paint\00", align 1
@.str.348 = private unnamed_addr constant [27 x i8] c"android/graphics/Paint$Cap\00", align 1
@.str.349 = private unnamed_addr constant [35 x i8] c"android/graphics/Paint$FontMetrics\00", align 1
@.str.350 = private unnamed_addr constant [38 x i8] c"android/graphics/Paint$FontMetricsInt\00", align 1
@.str.351 = private unnamed_addr constant [28 x i8] c"android/graphics/Paint$Join\00", align 1
@.str.352 = private unnamed_addr constant [29 x i8] c"android/graphics/Paint$Style\00", align 1
@.str.353 = private unnamed_addr constant [22 x i8] c"android/graphics/Path\00", align 1
@.str.354 = private unnamed_addr constant [32 x i8] c"android/graphics/Path$Direction\00", align 1
@.str.355 = private unnamed_addr constant [31 x i8] c"android/graphics/Path$FillType\00", align 1
@.str.356 = private unnamed_addr constant [28 x i8] c"android/graphics/PathEffect\00", align 1
@.str.357 = private unnamed_addr constant [23 x i8] c"android/graphics/Point\00", align 1
@.str.358 = private unnamed_addr constant [24 x i8] c"android/graphics/PointF\00", align 1
@.str.359 = private unnamed_addr constant [28 x i8] c"android/graphics/PorterDuff\00", align 1
@.str.360 = private unnamed_addr constant [33 x i8] c"android/graphics/PorterDuff$Mode\00", align 1
@.str.361 = private unnamed_addr constant [39 x i8] c"android/graphics/PorterDuffColorFilter\00", align 1
@.str.362 = private unnamed_addr constant [36 x i8] c"android/graphics/PorterDuffXfermode\00", align 1
@.str.363 = private unnamed_addr constant [32 x i8] c"android/graphics/RadialGradient\00", align 1
@.str.364 = private unnamed_addr constant [22 x i8] c"android/graphics/Rect\00", align 1
@.str.365 = private unnamed_addr constant [23 x i8] c"android/graphics/RectF\00", align 1
@.str.366 = private unnamed_addr constant [24 x i8] c"android/graphics/Region\00", align 1
@.str.367 = private unnamed_addr constant [27 x i8] c"android/graphics/Region$Op\00", align 1
@.str.368 = private unnamed_addr constant [24 x i8] c"android/graphics/Shader\00", align 1
@.str.369 = private unnamed_addr constant [33 x i8] c"android/graphics/Shader$TileMode\00", align 1
@.str.370 = private unnamed_addr constant [26 x i8] c"android/graphics/Typeface\00", align 1
@.str.371 = private unnamed_addr constant [26 x i8] c"android/graphics/Xfermode\00", align 1
@.str.372 = private unnamed_addr constant [35 x i8] c"android/graphics/drawable/Drawable\00", align 1
@.str.373 = private unnamed_addr constant [49 x i8] c"android/graphics/drawable/Drawable$ConstantState\00", align 1
@.str.374 = private unnamed_addr constant [44 x i8] c"android/graphics/drawable/DrawableContainer\00", align 1
@.str.375 = private unnamed_addr constant [40 x i8] c"android/graphics/drawable/InsetDrawable\00", align 1
@.str.376 = private unnamed_addr constant [40 x i8] c"android/graphics/drawable/LayerDrawable\00", align 1
@.str.377 = private unnamed_addr constant [44 x i8] c"android/graphics/drawable/AnimationDrawable\00", align 1
@.str.378 = private unnamed_addr constant [41 x i8] c"android/graphics/drawable/BitmapDrawable\00", align 1
@.str.379 = private unnamed_addr constant [40 x i8] c"android/graphics/drawable/ColorDrawable\00", align 1
@.str.380 = private unnamed_addr constant [42 x i8] c"android/graphics/drawable/DrawableWrapper\00", align 1
@.str.381 = private unnamed_addr constant [43 x i8] c"android/graphics/drawable/GradientDrawable\00", align 1
@.str.382 = private unnamed_addr constant [55 x i8] c"android/graphics/drawable/GradientDrawable$Orientation\00", align 1
@.str.383 = private unnamed_addr constant [37 x i8] c"android/graphics/drawable/Animatable\00", align 1
@.str.384 = private unnamed_addr constant [31 x i8] c"android/graphics/drawable/Icon\00", align 1
@.str.385 = private unnamed_addr constant [40 x i8] c"android/graphics/drawable/PaintDrawable\00", align 1
@.str.386 = private unnamed_addr constant [41 x i8] c"android/graphics/drawable/RippleDrawable\00", align 1
@.str.387 = private unnamed_addr constant [40 x i8] c"android/graphics/drawable/ShapeDrawable\00", align 1
@.str.388 = private unnamed_addr constant [54 x i8] c"android/graphics/drawable/ShapeDrawable$ShaderFactory\00", align 1
@.str.389 = private unnamed_addr constant [44 x i8] c"android/graphics/drawable/StateListDrawable\00", align 1
@.str.390 = private unnamed_addr constant [43 x i8] c"android/graphics/drawable/shapes/OvalShape\00", align 1
@.str.391 = private unnamed_addr constant [43 x i8] c"android/graphics/drawable/shapes/RectShape\00", align 1
@.str.392 = private unnamed_addr constant [39 x i8] c"android/graphics/drawable/shapes/Shape\00", align 1
@.str.393 = private unnamed_addr constant [32 x i8] c"android/content/ContentProvider\00", align 1
@.str.394 = private unnamed_addr constant [30 x i8] c"android/content/ContentValues\00", align 1
@.str.395 = private unnamed_addr constant [24 x i8] c"android/content/Context\00", align 1
@.str.396 = private unnamed_addr constant [23 x i8] c"android/content/Intent\00", align 1
@.str.397 = private unnamed_addr constant [34 x i8] c"android/content/BroadcastReceiver\00", align 1
@.str.398 = private unnamed_addr constant [25 x i8] c"android/content/ClipData\00", align 1
@.str.399 = private unnamed_addr constant [30 x i8] c"android/content/ClipData$Item\00", align 1
@.str.400 = private unnamed_addr constant [32 x i8] c"android/content/ClipDescription\00", align 1
@.str.401 = private unnamed_addr constant [30 x i8] c"android/content/ComponentName\00", align 1
@.str.402 = private unnamed_addr constant [32 x i8] c"android/content/ContentResolver\00", align 1
@.str.403 = private unnamed_addr constant [31 x i8] c"android/content/ContextWrapper\00", align 1
@.str.404 = private unnamed_addr constant [49 x i8] c"android/content/DialogInterface$OnCancelListener\00", align 1
@.str.405 = private unnamed_addr constant [65 x i8] c"mono/android/content/DialogInterface_OnCancelListenerImplementor\00", align 1
@.str.406 = private unnamed_addr constant [48 x i8] c"android/content/DialogInterface$OnClickListener\00", align 1
@.str.407 = private unnamed_addr constant [64 x i8] c"mono/android/content/DialogInterface_OnClickListenerImplementor\00", align 1
@.str.408 = private unnamed_addr constant [50 x i8] c"android/content/DialogInterface$OnDismissListener\00", align 1
@.str.409 = private unnamed_addr constant [66 x i8] c"mono/android/content/DialogInterface_OnDismissListenerImplementor\00", align 1
@.str.410 = private unnamed_addr constant [46 x i8] c"android/content/DialogInterface$OnKeyListener\00", align 1
@.str.411 = private unnamed_addr constant [59 x i8] c"android/content/DialogInterface$OnMultiChoiceClickListener\00", align 1
@.str.412 = private unnamed_addr constant [47 x i8] c"android/content/DialogInterface$OnShowListener\00", align 1
@.str.413 = private unnamed_addr constant [63 x i8] c"mono/android/content/DialogInterface_OnShowListenerImplementor\00", align 1
@.str.414 = private unnamed_addr constant [32 x i8] c"android/content/DialogInterface\00", align 1
@.str.415 = private unnamed_addr constant [29 x i8] c"android/content/IntentFilter\00", align 1
@.str.416 = private unnamed_addr constant [29 x i8] c"android/content/IntentSender\00", align 1
@.str.417 = private unnamed_addr constant [41 x i8] c"android/content/SharedPreferences$Editor\00", align 1
@.str.418 = private unnamed_addr constant [67 x i8] c"android/content/SharedPreferences$OnSharedPreferenceChangeListener\00", align 1
@.str.419 = private unnamed_addr constant [34 x i8] c"android/content/SharedPreferences\00", align 1
@.str.420 = private unnamed_addr constant [24 x i8] c"android/content/LocusId\00", align 1
@.str.421 = private unnamed_addr constant [40 x i8] c"android/content/res/AssetFileDescriptor\00", align 1
@.str.422 = private unnamed_addr constant [33 x i8] c"android/content/res/AssetManager\00", align 1
@.str.423 = private unnamed_addr constant [35 x i8] c"android/content/res/ColorStateList\00", align 1
@.str.424 = private unnamed_addr constant [34 x i8] c"android/content/res/Configuration\00", align 1
@.str.425 = private unnamed_addr constant [30 x i8] c"android/content/res/Resources\00", align 1
@.str.426 = private unnamed_addr constant [36 x i8] c"android/content/res/Resources$Theme\00", align 1
@.str.427 = private unnamed_addr constant [31 x i8] c"android/content/res/TypedArray\00", align 1
@.str.428 = private unnamed_addr constant [34 x i8] c"android/content/pm/PackageManager\00", align 1
@.str.429 = private unnamed_addr constant [35 x i8] c"android/content/pm/ApplicationInfo\00", align 1
@.str.430 = private unnamed_addr constant [31 x i8] c"android/content/pm/PackageInfo\00", align 1
@.str.431 = private unnamed_addr constant [35 x i8] c"android/content/pm/PackageItemInfo\00", align 1
@.str.432 = private unnamed_addr constant [32 x i8] c"android/content/pm/ShortcutInfo\00", align 1
@.str.433 = private unnamed_addr constant [40 x i8] c"android/content/pm/ShortcutInfo$Builder\00", align 1
@.str.434 = private unnamed_addr constant [35 x i8] c"android/content/pm/ShortcutManager\00", align 1
@.str.435 = private unnamed_addr constant [29 x i8] c"android/content/pm/Signature\00", align 1
@.str.436 = private unnamed_addr constant [22 x i8] c"android/app/ActionBar\00", align 1
@.str.437 = private unnamed_addr constant [35 x i8] c"android/app/ActionBar$LayoutParams\00", align 1
@.str.438 = private unnamed_addr constant [21 x i8] c"android/app/Activity\00", align 1
@.str.439 = private unnamed_addr constant [24 x i8] c"android/app/AlertDialog\00", align 1
@.str.440 = private unnamed_addr constant [32 x i8] c"android/app/AlertDialog$Builder\00", align 1
@.str.441 = private unnamed_addr constant [24 x i8] c"android/app/Application\00", align 1
@.str.442 = private unnamed_addr constant [51 x i8] c"android/app/Application$ActivityLifecycleCallbacks\00", align 1
@.str.443 = private unnamed_addr constant [29 x i8] c"android/app/DatePickerDialog\00", align 1
@.str.444 = private unnamed_addr constant [47 x i8] c"android/app/DatePickerDialog$OnDateSetListener\00", align 1
@.str.445 = private unnamed_addr constant [63 x i8] c"mono/android/app/DatePickerDialog_OnDateSetListenerImplementor\00", align 1
@.str.446 = private unnamed_addr constant [19 x i8] c"android/app/Dialog\00", align 1
@.str.447 = private unnamed_addr constant [29 x i8] c"android/app/TimePickerDialog\00", align 1
@.str.448 = private unnamed_addr constant [47 x i8] c"android/app/TimePickerDialog$OnTimeSetListener\00", align 1
@.str.449 = private unnamed_addr constant [63 x i8] c"mono/android/app/TimePickerDialog_OnTimeSetListenerImplementor\00", align 1
@.str.450 = private unnamed_addr constant [26 x i8] c"android/app/UiModeManager\00", align 1
@.str.451 = private unnamed_addr constant [28 x i8] c"android/app/KeyguardManager\00", align 1
@.str.452 = private unnamed_addr constant [26 x i8] c"android/app/PendingIntent\00", align 1
@.str.453 = private unnamed_addr constant [27 x i8] c"android/app/SearchableInfo\00", align 1
@.str.454 = private unnamed_addr constant [20 x i8] c"android/app/Service\00", align 1
@.str.455 = private unnamed_addr constant [24 x i8] c"java/text/DecimalFormat\00", align 1
@.str.456 = private unnamed_addr constant [31 x i8] c"java/text/DecimalFormatSymbols\00", align 1
@.str.457 = private unnamed_addr constant [23 x i8] c"java/text/NumberFormat\00", align 1
@.str.458 = private unnamed_addr constant [17 x i8] c"java/text/Format\00", align 1
@.str.459 = private unnamed_addr constant [26 x i8] c"java/net/ConnectException\00", align 1
@.str.460 = private unnamed_addr constant [27 x i8] c"java/net/HttpURLConnection\00", align 1
@.str.461 = private unnamed_addr constant [27 x i8] c"java/net/InetSocketAddress\00", align 1
@.str.462 = private unnamed_addr constant [27 x i8] c"java/net/ProtocolException\00", align 1
@.str.463 = private unnamed_addr constant [15 x i8] c"java/net/Proxy\00", align 1
@.str.464 = private unnamed_addr constant [20 x i8] c"java/net/Proxy$Type\00", align 1
@.str.465 = private unnamed_addr constant [23 x i8] c"java/net/SocketAddress\00", align 1
@.str.466 = private unnamed_addr constant [25 x i8] c"java/net/SocketException\00", align 1
@.str.467 = private unnamed_addr constant [32 x i8] c"java/net/SocketTimeoutException\00", align 1
@.str.468 = private unnamed_addr constant [33 x i8] c"java/net/UnknownServiceException\00", align 1
@.str.469 = private unnamed_addr constant [13 x i8] c"java/net/URL\00", align 1
@.str.470 = private unnamed_addr constant [23 x i8] c"java/net/URLConnection\00", align 1
@.str.471 = private unnamed_addr constant [39 x i8] c"java/security/GeneralSecurityException\00", align 1
@.str.472 = private unnamed_addr constant [18 x i8] c"java/security/Key\00", align 1
@.str.473 = private unnamed_addr constant [24 x i8] c"java/security/Principal\00", align 1
@.str.474 = private unnamed_addr constant [25 x i8] c"java/security/PrivateKey\00", align 1
@.str.475 = private unnamed_addr constant [25 x i8] c"java/security/KeyFactory\00", align 1
@.str.476 = private unnamed_addr constant [23 x i8] c"java/security/KeyStore\00", align 1
@.str.477 = private unnamed_addr constant [32 x i8] c"java/security/KeyStoreException\00", align 1
@.str.478 = private unnamed_addr constant [27 x i8] c"java/security/SecureRandom\00", align 1
@.str.479 = private unnamed_addr constant [24 x i8] c"java/security/Signature\00", align 1
@.str.480 = private unnamed_addr constant [27 x i8] c"java/security/SignatureSpi\00", align 1
@.str.481 = private unnamed_addr constant [34 x i8] c"java/security/spec/EncodedKeySpec\00", align 1
@.str.482 = private unnamed_addr constant [27 x i8] c"java/security/spec/KeySpec\00", align 1
@.str.483 = private unnamed_addr constant [39 x i8] c"java/security/spec/PKCS8EncodedKeySpec\00", align 1
@.str.484 = private unnamed_addr constant [31 x i8] c"java/security/cert/Certificate\00", align 1
@.str.485 = private unnamed_addr constant [16 x i8] c"java/nio/Buffer\00", align 1
@.str.486 = private unnamed_addr constant [20 x i8] c"java/nio/ByteBuffer\00", align 1
@.str.487 = private unnamed_addr constant [25 x i8] c"java/nio/charset/Charset\00", align 1
@.str.488 = private unnamed_addr constant [30 x i8] c"java/nio/channels/FileChannel\00", align 1
@.str.489 = private unnamed_addr constant [51 x i8] c"java/nio/channels/spi/AbstractInterruptibleChannel\00", align 1
@.str.490 = private unnamed_addr constant [13 x i8] c"java/io/File\00", align 1
@.str.491 = private unnamed_addr constant [23 x i8] c"java/io/FileDescriptor\00", align 1
@.str.492 = private unnamed_addr constant [24 x i8] c"java/io/FileInputStream\00", align 1
@.str.493 = private unnamed_addr constant [30 x i8] c"java/io/FileNotFoundException\00", align 1
@.str.494 = private unnamed_addr constant [18 x i8] c"java/io/Closeable\00", align 1
@.str.495 = private unnamed_addr constant [20 x i8] c"java/io/InputStream\00", align 1
@.str.496 = private unnamed_addr constant [31 x i8] c"java/io/InterruptedIOException\00", align 1
@.str.497 = private unnamed_addr constant [20 x i8] c"java/io/IOException\00", align 1
@.str.498 = private unnamed_addr constant [21 x i8] c"java/io/Serializable\00", align 1
@.str.499 = private unnamed_addr constant [21 x i8] c"java/io/OutputStream\00", align 1
@.str.500 = private unnamed_addr constant [20 x i8] c"java/io/PrintWriter\00", align 1
@.str.501 = private unnamed_addr constant [25 x i8] c"java/io/RandomAccessFile\00", align 1
@.str.502 = private unnamed_addr constant [15 x i8] c"java/io/Reader\00", align 1
@.str.503 = private unnamed_addr constant [21 x i8] c"java/io/StringWriter\00", align 1
@.str.504 = private unnamed_addr constant [15 x i8] c"java/io/Writer\00", align 1
@.str.505 = private unnamed_addr constant [15 x i8] c"java/util/List\00", align 1
@.str.506 = private unnamed_addr constant [21 x i8] c"java/util/Comparator\00", align 1
@.str.507 = private unnamed_addr constant [22 x i8] c"java/util/Enumeration\00", align 1
@.str.508 = private unnamed_addr constant [19 x i8] c"java/util/Iterator\00", align 1
@.str.509 = private unnamed_addr constant [23 x i8] c"java/util/ListIterator\00", align 1
@.str.510 = private unnamed_addr constant [23 x i8] c"java/util/RandomAccess\00", align 1
@.str.511 = private unnamed_addr constant [30 x i8] c"java/util/SequencedCollection\00", align 1
@.str.512 = private unnamed_addr constant [22 x i8] c"java/util/Spliterator\00", align 1
@.str.513 = private unnamed_addr constant [17 x i8] c"java/util/Locale\00", align 1
@.str.514 = private unnamed_addr constant [17 x i8] c"java/util/Random\00", align 1
@.str.515 = private unnamed_addr constant [16 x i8] c"java/util/Timer\00", align 1
@.str.516 = private unnamed_addr constant [20 x i8] c"java/util/TimerTask\00", align 1
@.str.517 = private unnamed_addr constant [28 x i8] c"java/util/function/Consumer\00", align 1
@.str.518 = private unnamed_addr constant [28 x i8] c"java/util/function/Function\00", align 1
@.str.519 = private unnamed_addr constant [31 x i8] c"java/util/function/IntConsumer\00", align 1
@.str.520 = private unnamed_addr constant [31 x i8] c"java/util/function/IntFunction\00", align 1
@.str.521 = private unnamed_addr constant [29 x i8] c"java/util/function/Predicate\00", align 1
@.str.522 = private unnamed_addr constant [36 x i8] c"java/util/function/ToDoubleFunction\00", align 1
@.str.523 = private unnamed_addr constant [33 x i8] c"java/util/function/ToIntFunction\00", align 1
@.str.524 = private unnamed_addr constant [34 x i8] c"java/util/function/ToLongFunction\00", align 1
@.str.525 = private unnamed_addr constant [33 x i8] c"java/util/function/UnaryOperator\00", align 1
@.str.526 = private unnamed_addr constant [31 x i8] c"java/util/concurrent/Executors\00", align 1
@.str.527 = private unnamed_addr constant [30 x i8] c"java/util/concurrent/Callable\00", align 1
@.str.528 = private unnamed_addr constant [30 x i8] c"java/util/concurrent/Executor\00", align 1
@.str.529 = private unnamed_addr constant [37 x i8] c"java/util/concurrent/ExecutorService\00", align 1
@.str.530 = private unnamed_addr constant [28 x i8] c"java/util/concurrent/Future\00", align 1
@.str.531 = private unnamed_addr constant [30 x i8] c"java/util/concurrent/TimeUnit\00", align 1
@.str.532 = private unnamed_addr constant [44 x i8] c"java/util/concurrent/atomic/AtomicReference\00", align 1
@.str.533 = private unnamed_addr constant [18 x i8] c"java/lang/Boolean\00", align 1
@.str.534 = private unnamed_addr constant [15 x i8] c"java/lang/Byte\00", align 1
@.str.535 = private unnamed_addr constant [20 x i8] c"java/lang/Character\00", align 1
@.str.536 = private unnamed_addr constant [16 x i8] c"java/lang/Class\00", align 1
@.str.537 = private unnamed_addr constant [33 x i8] c"java/lang/ClassNotFoundException\00", align 1
@.str.538 = private unnamed_addr constant [17 x i8] c"java/lang/Double\00", align 1
@.str.539 = private unnamed_addr constant [20 x i8] c"java/lang/Exception\00", align 1
@.str.540 = private unnamed_addr constant [16 x i8] c"java/lang/Float\00", align 1
@.str.541 = private unnamed_addr constant [23 x i8] c"java/lang/CharSequence\00", align 1
@.str.542 = private unnamed_addr constant [33 x i8] c"java/lang/IllegalAccessException\00", align 1
@.str.543 = private unnamed_addr constant [18 x i8] c"java/lang/Integer\00", align 1
@.str.544 = private unnamed_addr constant [15 x i8] c"java/lang/Long\00", align 1
@.str.545 = private unnamed_addr constant [31 x i8] c"java/lang/NoSuchFieldException\00", align 1
@.str.546 = private unnamed_addr constant [17 x i8] c"java/lang/Object\00", align 1
@.str.547 = private unnamed_addr constant [24 x i8] c"mono/java/lang/Runnable\00", align 1
@.str.548 = private unnamed_addr constant [27 x i8] c"java/lang/RuntimeException\00", align 1
@.str.549 = private unnamed_addr constant [16 x i8] c"java/lang/Short\00", align 1
@.str.550 = private unnamed_addr constant [17 x i8] c"java/lang/String\00", align 1
@.str.551 = private unnamed_addr constant [17 x i8] c"java/lang/Thread\00", align 1
@.str.552 = private unnamed_addr constant [35 x i8] c"mono/java/lang/RunnableImplementor\00", align 1
@.str.553 = private unnamed_addr constant [20 x i8] c"java/lang/Throwable\00", align 1
@.str.554 = private unnamed_addr constant [29 x i8] c"java/lang/ClassCastException\00", align 1
@.str.555 = private unnamed_addr constant [22 x i8] c"java/lang/ClassLoader\00", align 1
@.str.556 = private unnamed_addr constant [15 x i8] c"java/lang/Enum\00", align 1
@.str.557 = private unnamed_addr constant [16 x i8] c"java/lang/Error\00", align 1
@.str.558 = private unnamed_addr constant [21 x i8] c"java/lang/Appendable\00", align 1
@.str.559 = private unnamed_addr constant [24 x i8] c"java/lang/AutoCloseable\00", align 1
@.str.560 = private unnamed_addr constant [20 x i8] c"java/lang/Cloneable\00", align 1
@.str.561 = private unnamed_addr constant [19 x i8] c"java/lang/Iterable\00", align 1
@.str.562 = private unnamed_addr constant [35 x i8] c"java/lang/IllegalArgumentException\00", align 1
@.str.563 = private unnamed_addr constant [32 x i8] c"java/lang/IllegalStateException\00", align 1
@.str.564 = private unnamed_addr constant [36 x i8] c"java/lang/IndexOutOfBoundsException\00", align 1
@.str.565 = private unnamed_addr constant [19 x i8] c"java/lang/Runnable\00", align 1
@.str.566 = private unnamed_addr constant [23 x i8] c"java/lang/LinkageError\00", align 1
@.str.567 = private unnamed_addr constant [15 x i8] c"java/lang/Math\00", align 1
@.str.568 = private unnamed_addr constant [31 x i8] c"java/lang/NoClassDefFoundError\00", align 1
@.str.569 = private unnamed_addr constant [31 x i8] c"java/lang/NullPointerException\00", align 1
@.str.570 = private unnamed_addr constant [17 x i8] c"java/lang/Number\00", align 1
@.str.571 = private unnamed_addr constant [39 x i8] c"java/lang/ReflectiveOperationException\00", align 1
@.str.572 = private unnamed_addr constant [28 x i8] c"java/lang/SecurityException\00", align 1
@.str.573 = private unnamed_addr constant [28 x i8] c"java/lang/StackTraceElement\00", align 1
@.str.574 = private unnamed_addr constant [40 x i8] c"java/lang/UnsupportedOperationException\00", align 1
@.str.575 = private unnamed_addr constant [15 x i8] c"java/lang/Void\00", align 1
@.str.576 = private unnamed_addr constant [32 x i8] c"java/lang/annotation/Annotation\00", align 1
@.str.577 = private unnamed_addr constant [35 x i8] c"java/lang/reflect/AccessibleObject\00", align 1
@.str.578 = private unnamed_addr constant [24 x i8] c"java/lang/reflect/Field\00", align 1
@.str.579 = private unnamed_addr constant [25 x i8] c"mono/android/TypeManager\00", align 1
@.str.580 = private unnamed_addr constant [36 x i8] c"androidx/lifecycle/SavedStateHandle\00", align 1
@.str.581 = private unnamed_addr constant [52 x i8] c"crc6445ad3511b80f6fdf/GestureDetector_ScaleListener\00", align 1
@.str.582 = private unnamed_addr constant [53 x i8] c"crc6445ad3511b80f6fdf/GestureDetector_ScrollListener\00", align 1
@.str.583 = private unnamed_addr constant [50 x i8] c"crc64c0976fbcdb365652/CustomAccessibilityDelegate\00", align 1
@.str.584 = private unnamed_addr constant [50 x i8] c"crc64c0976fbcdb365652/CustomAccessibilityProvider\00", align 1
@.str.585 = private unnamed_addr constant [39 x i8] c"crc64c0976fbcdb365652/StaticTextLayout\00", align 1
@.str.586 = private unnamed_addr constant [41 x i8] c"crc640516eac8f2b5dac9/LayoutViewGroupExt\00", align 1
@.str.587 = private unnamed_addr constant [39 x i8] c"crc649ff9379e8ecbf267/PlatformCarousel\00", align 1
@.str.588 = private unnamed_addr constant [42 x i8] c"crc649ff9379e8ecbf267/SpaceItemDecoration\00", align 1
@.str.589 = private unnamed_addr constant [43 x i8] c"crc649ff9379e8ecbf267/PlatformCarouselItem\00", align 1
@.str.590 = private unnamed_addr constant [38 x i8] c"crc649ff9379e8ecbf267/CustomImageView\00", align 1
@.str.591 = private unnamed_addr constant [34 x i8] c"crc649ff9379e8ecbf267/ItemAdapter\00", align 1
@.str.592 = private unnamed_addr constant [33 x i8] c"crc649ff9379e8ecbf267/ViewHolder\00", align 1
@.str.593 = private unnamed_addr constant [39 x i8] c"crc649c9364508479c7e4/NativeSnapLayout\00", align 1
@.str.594 = private unnamed_addr constant [60 x i8] c"crc649c9364508479c7e4/NativeSnapLayout_FlingGestureListener\00", align 1
@.str.595 = private unnamed_addr constant [28 x i8] c"androidx/lifecycle/Observer\00", align 1
@.str.596 = private unnamed_addr constant [28 x i8] c"androidx/lifecycle/LiveData\00", align 1
@.str.597 = private unnamed_addr constant [35 x i8] c"androidx/lifecycle/MutableLiveData\00", align 1
@.str.598 = private unnamed_addr constant [52 x i8] c"androidx/security/crypto/EncryptedSharedPreferences\00", align 1
@.str.599 = private unnamed_addr constant [76 x i8] c"androidx/security/crypto/EncryptedSharedPreferences$PrefKeyEncryptionScheme\00", align 1
@.str.600 = private unnamed_addr constant [78 x i8] c"androidx/security/crypto/EncryptedSharedPreferences$PrefValueEncryptionScheme\00", align 1
@.str.601 = private unnamed_addr constant [35 x i8] c"androidx/security/crypto/MasterKey\00", align 1
@.str.602 = private unnamed_addr constant [43 x i8] c"androidx/security/crypto/MasterKey$Builder\00", align 1
@.str.603 = private unnamed_addr constant [45 x i8] c"androidx/security/crypto/MasterKey$KeyScheme\00", align 1
@.str.604 = private unnamed_addr constant [39 x i8] c"androidx/viewpager/widget/PagerAdapter\00", align 1
@.str.605 = private unnamed_addr constant [36 x i8] c"androidx/viewpager/widget/ViewPager\00", align 1
@.str.606 = private unnamed_addr constant [60 x i8] c"androidx/viewpager/widget/ViewPager$OnAdapterChangeListener\00", align 1
@.str.607 = private unnamed_addr constant [76 x i8] c"mono/androidx/viewpager/widget/ViewPager_OnAdapterChangeListenerImplementor\00", align 1
@.str.608 = private unnamed_addr constant [57 x i8] c"androidx/viewpager/widget/ViewPager$OnPageChangeListener\00", align 1
@.str.609 = private unnamed_addr constant [73 x i8] c"mono/androidx/viewpager/widget/ViewPager_OnPageChangeListenerImplementor\00", align 1
@.str.610 = private unnamed_addr constant [52 x i8] c"androidx/viewpager/widget/ViewPager$PageTransformer\00", align 1
@.str.611 = private unnamed_addr constant [42 x i8] c"androidx/drawerlayout/widget/DrawerLayout\00", align 1
@.str.612 = private unnamed_addr constant [57 x i8] c"androidx/drawerlayout/widget/DrawerLayout$DrawerListener\00", align 1
@.str.613 = private unnamed_addr constant [73 x i8] c"mono/androidx/drawerlayout/widget/DrawerLayout_DrawerListenerImplementor\00", align 1
@.str.614 = private unnamed_addr constant [55 x i8] c"androidx/drawerlayout/widget/DrawerLayout$LayoutParams\00", align 1
@.str.615 = private unnamed_addr constant [16 x i8] c"kotlin/Function\00", align 1
@.str.616 = private unnamed_addr constant [26 x i8] c"kotlin/sequences/Sequence\00", align 1
@.str.617 = private unnamed_addr constant [33 x i8] c"kotlin/reflect/KAnnotatedElement\00", align 1
@.str.618 = private unnamed_addr constant [25 x i8] c"kotlin/reflect/KCallable\00", align 1
@.str.619 = private unnamed_addr constant [22 x i8] c"kotlin/reflect/KClass\00", align 1
@.str.620 = private unnamed_addr constant [27 x i8] c"kotlin/reflect/KClassifier\00", align 1
@.str.621 = private unnamed_addr constant [37 x i8] c"kotlin/reflect/KDeclarationContainer\00", align 1
@.str.622 = private unnamed_addr constant [25 x i8] c"kotlin/reflect/KFunction\00", align 1
@.str.623 = private unnamed_addr constant [31 x i8] c"kotlin/reflect/KParameter$Kind\00", align 1
@.str.624 = private unnamed_addr constant [26 x i8] c"kotlin/reflect/KParameter\00", align 1
@.str.625 = private unnamed_addr constant [21 x i8] c"kotlin/reflect/KType\00", align 1
@.str.626 = private unnamed_addr constant [30 x i8] c"kotlin/reflect/KTypeParameter\00", align 1
@.str.627 = private unnamed_addr constant [31 x i8] c"kotlin/reflect/KTypeProjection\00", align 1
@.str.628 = private unnamed_addr constant [41 x i8] c"kotlin/reflect/KTypeProjection$Companion\00", align 1
@.str.629 = private unnamed_addr constant [25 x i8] c"kotlin/reflect/KVariance\00", align 1
@.str.630 = private unnamed_addr constant [27 x i8] c"kotlin/reflect/KVisibility\00", align 1
@.str.631 = private unnamed_addr constant [45 x i8] c"kotlin/jvm/internal/DefaultConstructorMarker\00", align 1
@.str.632 = private unnamed_addr constant [42 x i8] c"kotlin/jvm/internal/markers/KMappedMarker\00", align 1
@.str.633 = private unnamed_addr constant [31 x i8] c"kotlin/jvm/functions/Function0\00", align 1
@.str.634 = private unnamed_addr constant [31 x i8] c"kotlin/jvm/functions/Function1\00", align 1
@.str.635 = private unnamed_addr constant [31 x i8] c"kotlin/jvm/functions/Function2\00", align 1
@.str.636 = private unnamed_addr constant [25 x i8] c"kotlin/enums/EnumEntries\00", align 1
@.str.637 = private unnamed_addr constant [31 x i8] c"kotlin/coroutines/Continuation\00", align 1
@.str.638 = private unnamed_addr constant [39 x i8] c"kotlin/coroutines/CoroutineContext$Key\00", align 1
@.str.639 = private unnamed_addr constant [35 x i8] c"kotlin/coroutines/CoroutineContext\00", align 1
@.str.640 = private unnamed_addr constant [52 x i8] c"androidx/coordinatorlayout/widget/CoordinatorLayout\00", align 1
@.str.641 = private unnamed_addr constant [61 x i8] c"androidx/coordinatorlayout/widget/CoordinatorLayout$Behavior\00", align 1
@.str.642 = private unnamed_addr constant [65 x i8] c"androidx/coordinatorlayout/widget/CoordinatorLayout$LayoutParams\00", align 1
@.str.643 = private unnamed_addr constant [48 x i8] c"crc6488302ad6e9e4df1a/ImageLoaderResultCallback\00", align 1
@.str.644 = private unnamed_addr constant [42 x i8] c"crc6488302ad6e9e4df1a/ImageLoaderCallback\00", align 1
@.str.645 = private unnamed_addr constant [48 x i8] c"crc6488302ad6e9e4df1a/ImageLoaderCallbackBase_1\00", align 1
@.str.646 = private unnamed_addr constant [44 x i8] c"crc6488302ad6e9e4df1a/MauiAppCompatActivity\00", align 1
@.str.647 = private unnamed_addr constant [38 x i8] c"crc6488302ad6e9e4df1a/MauiApplication\00", align 1
@.str.648 = private unnamed_addr constant [65 x i8] c"crc6488302ad6e9e4df1a/MauiApplication_ActivityLifecycleCallbacks\00", align 1
@.str.649 = private unnamed_addr constant [31 x i8] c"com/microsoft/maui/BuildConfig\00", align 1
@.str.650 = private unnamed_addr constant [45 x i8] c"com/microsoft/maui/HybridJavaScriptInterface\00", align 1
@.str.651 = private unnamed_addr constant [39 x i8] c"com/microsoft/maui/ImageLoaderCallback\00", align 1
@.str.652 = private unnamed_addr constant [33 x i8] c"com/microsoft/maui/MauiViewGroup\00", align 1
@.str.653 = private unnamed_addr constant [45 x i8] c"com/microsoft/maui/PlatformAppCompatTextView\00", align 1
@.str.654 = private unnamed_addr constant [44 x i8] c"com/microsoft/maui/PlatformContentViewGroup\00", align 1
@.str.655 = private unnamed_addr constant [36 x i8] c"com/microsoft/maui/PlatformFontSpan\00", align 1
@.str.656 = private unnamed_addr constant [35 x i8] c"com/microsoft/maui/PlatformInterop\00", align 1
@.str.657 = private unnamed_addr constant [42 x i8] c"com/microsoft/maui/PlatformLineHeightSpan\00", align 1
@.str.658 = private unnamed_addr constant [49 x i8] c"com/microsoft/maui/PlatformMauiAppCompatActivity\00", align 1
@.str.659 = private unnamed_addr constant [39 x i8] c"com/microsoft/maui/PlatformWrapperView\00", align 1
@.str.660 = private unnamed_addr constant [57 x i8] c"crc6452ffdc5b34af3a0f/AccessibilityDelegateCompatWrapper\00", align 1
@.str.661 = private unnamed_addr constant [37 x i8] c"crc6452ffdc5b34af3a0f/BorderDrawable\00", align 1
@.str.662 = private unnamed_addr constant [36 x i8] c"crc6452ffdc5b34af3a0f/ContainerView\00", align 1
@.str.663 = private unnamed_addr constant [39 x i8] c"crc6452ffdc5b34af3a0f/ContentViewGroup\00", align 1
@.str.664 = private unnamed_addr constant [58 x i8] c"crc6452ffdc5b34af3a0f/FragmentManagerExtensions_CallBacks\00", align 1
@.str.665 = private unnamed_addr constant [38 x i8] c"crc6452ffdc5b34af3a0f/LayoutViewGroup\00", align 1
@.str.666 = private unnamed_addr constant [49 x i8] c"crc6452ffdc5b34af3a0f/LocalizedDigitsKeyListener\00", align 1
@.str.667 = private unnamed_addr constant [54 x i8] c"crc6452ffdc5b34af3a0f/MauiAccessibilityDelegateCompat\00", align 1
@.str.668 = private unnamed_addr constant [44 x i8] c"crc6452ffdc5b34af3a0f/MauiAppCompatEditText\00", align 1
@.str.669 = private unnamed_addr constant [34 x i8] c"crc6452ffdc5b34af3a0f/MauiBoxView\00", align 1
@.str.670 = private unnamed_addr constant [37 x i8] c"crc6452ffdc5b34af3a0f/MauiDatePicker\00", align 1
@.str.671 = private unnamed_addr constant [40 x i8] c"crc6452ffdc5b34af3a0f/MauiHybridWebView\00", align 1
@.str.672 = private unnamed_addr constant [46 x i8] c"crc6452ffdc5b34af3a0f/MauiHybridWebViewClient\00", align 1
@.str.673 = private unnamed_addr constant [40 x i8] c"crc6452ffdc5b34af3a0f/MauiLayerDrawable\00", align 1
@.str.674 = private unnamed_addr constant [41 x i8] c"crc6452ffdc5b34af3a0f/MauiMaterialButton\00", align 1
@.str.675 = private unnamed_addr constant [63 x i8] c"crc6452ffdc5b34af3a0f/MauiMaterialButton_MauiResizableDrawable\00", align 1
@.str.676 = private unnamed_addr constant [38 x i8] c"crc6452ffdc5b34af3a0f/MauiPageControl\00", align 1
@.str.677 = private unnamed_addr constant [57 x i8] c"crc6452ffdc5b34af3a0f/MauiPageControl_TEditClickListener\00", align 1
@.str.678 = private unnamed_addr constant [33 x i8] c"crc6452ffdc5b34af3a0f/MauiPicker\00", align 1
@.str.679 = private unnamed_addr constant [37 x i8] c"crc6452ffdc5b34af3a0f/MauiPickerBase\00", align 1
@.str.680 = private unnamed_addr constant [37 x i8] c"crc6452ffdc5b34af3a0f/MauiScrollView\00", align 1
@.str.681 = private unnamed_addr constant [47 x i8] c"crc6452ffdc5b34af3a0f/MauiHorizontalScrollView\00", align 1
@.str.682 = private unnamed_addr constant [37 x i8] c"crc6452ffdc5b34af3a0f/MauiSearchView\00", align 1
@.str.683 = private unnamed_addr constant [36 x i8] c"crc6452ffdc5b34af3a0f/MauiShapeView\00", align 1
@.str.684 = private unnamed_addr constant [34 x i8] c"crc6452ffdc5b34af3a0f/MauiStepper\00", align 1
@.str.685 = private unnamed_addr constant [45 x i8] c"crc6452ffdc5b34af3a0f/MauiSwipeRefreshLayout\00", align 1
@.str.686 = private unnamed_addr constant [36 x i8] c"crc6452ffdc5b34af3a0f/MauiSwipeView\00", align 1
@.str.687 = private unnamed_addr constant [35 x i8] c"crc6452ffdc5b34af3a0f/MauiTextView\00", align 1
@.str.688 = private unnamed_addr constant [37 x i8] c"crc6452ffdc5b34af3a0f/MauiTimePicker\00", align 1
@.str.689 = private unnamed_addr constant [42 x i8] c"crc6452ffdc5b34af3a0f/MauiWebChromeClient\00", align 1
@.str.690 = private unnamed_addr constant [34 x i8] c"crc6452ffdc5b34af3a0f/MauiWebView\00", align 1
@.str.691 = private unnamed_addr constant [40 x i8] c"crc6452ffdc5b34af3a0f/MauiWebViewClient\00", align 1
@.str.692 = private unnamed_addr constant [44 x i8] c"microsoft/maui/platform/MauiNavHostFragment\00", align 1
@.str.693 = private unnamed_addr constant [65 x i8] c"crc6452ffdc5b34af3a0f/NavigationRootManager_ElementBasedFragment\00", align 1
@.str.694 = private unnamed_addr constant [45 x i8] c"crc6452ffdc5b34af3a0f/NavigationViewFragment\00", align 1
@.str.695 = private unnamed_addr constant [37 x i8] c"crc6452ffdc5b34af3a0f/ScopedFragment\00", align 1
@.str.696 = private unnamed_addr constant [55 x i8] c"crc6452ffdc5b34af3a0f/StackNavigationManager_Callbacks\00", align 1
@.str.697 = private unnamed_addr constant [35 x i8] c"crc6452ffdc5b34af3a0f/ViewFragment\00", align 1
@.str.698 = private unnamed_addr constant [48 x i8] c"crc6452ffdc5b34af3a0f/PlatformTouchGraphicsView\00", align 1
@.str.699 = private unnamed_addr constant [43 x i8] c"crc6452ffdc5b34af3a0f/StepperHandlerHolder\00", align 1
@.str.700 = private unnamed_addr constant [60 x i8] c"crc6452ffdc5b34af3a0f/StepperHandlerManager_StepperListener\00", align 1
@.str.701 = private unnamed_addr constant [37 x i8] c"crc6452ffdc5b34af3a0f/SwipeViewPager\00", align 1
@.str.702 = private unnamed_addr constant [57 x i8] c"crc6452ffdc5b34af3a0f/WebViewExtensions_JavascriptResult\00", align 1
@.str.703 = private unnamed_addr constant [34 x i8] c"crc6452ffdc5b34af3a0f/WrapperView\00", align 1
@.str.704 = private unnamed_addr constant [56 x i8] c"crc64fcf28c0e24b4cc31/ButtonHandler_ButtonClickListener\00", align 1
@.str.705 = private unnamed_addr constant [56 x i8] c"crc64fcf28c0e24b4cc31/ButtonHandler_ButtonTouchListener\00", align 1
@.str.706 = private unnamed_addr constant [76 x i8] c"crc64fcf28c0e24b4cc31/HybridWebViewHandler_HybridWebViewJavaScriptInterface\00", align 1
@.str.707 = private unnamed_addr constant [59 x i8] c"crc64fcf28c0e24b4cc31/SearchBarHandler_FocusChangeListener\00", align 1
@.str.708 = private unnamed_addr constant [58 x i8] c"crc64fcf28c0e24b4cc31/SliderHandler_SeekBarChangeListener\00", align 1
@.str.709 = private unnamed_addr constant [58 x i8] c"crc64fcf28c0e24b4cc31/SwitchHandler_CheckedChangeListener\00", align 1
@.str.710 = private unnamed_addr constant [54 x i8] c"crc64fcf28c0e24b4cc31/ToolbarHandler_ProcessBackClick\00", align 1
@.str.711 = private unnamed_addr constant [50 x i8] c"crc64b5e713d400f589b7/LinearGradientShaderFactory\00", align 1
@.str.712 = private unnamed_addr constant [50 x i8] c"crc64b5e713d400f589b7/RadialGradientShaderFactory\00", align 1
@.str.713 = private unnamed_addr constant [35 x i8] c"crc64b5e713d400f589b7/MauiDrawable\00", align 1
@.str.714 = private unnamed_addr constant [59 x i8] c"crc64a096dc44ad241142/PlatformTicker_DurationScaleListener\00", align 1
@.str.715 = private unnamed_addr constant [43 x i8] c"crc643f2b18b2570eaa5a/PlatformGraphicsView\00", align 1
@.str.716 = private unnamed_addr constant [39 x i8] c"crc64396a3fe5f8138e3f/KeepAliveService\00", align 1
@.str.717 = private unnamed_addr constant [55 x i8] c"androidx/browser/customtabs/CustomTabColorSchemeParams\00", align 1
@.str.718 = private unnamed_addr constant [45 x i8] c"androidx/browser/customtabs/CustomTabsIntent\00", align 1
@.str.719 = private unnamed_addr constant [53 x i8] c"androidx/browser/customtabs/CustomTabsIntent$Builder\00", align 1
@.str.720 = private unnamed_addr constant [46 x i8] c"androidx/browser/customtabs/CustomTabsSession\00", align 1
@.str.721 = private unnamed_addr constant [61 x i8] c"androidx/browser/customtabs/CustomTabsSession$PendingSession\00", align 1
@.str.722 = private unnamed_addr constant [54 x i8] c"androidx/browser/customtabs/EngagementSignalsCallback\00", align 1
@.str.723 = private unnamed_addr constant [34 x i8] c"androidx/navigation/NavController\00", align 1
@.str.724 = private unnamed_addr constant [63 x i8] c"androidx/navigation/NavController$OnDestinationChangedListener\00", align 1
@.str.725 = private unnamed_addr constant [79 x i8] c"mono/androidx/navigation/NavController_OnDestinationChangedListenerImplementor\00", align 1
@.str.726 = private unnamed_addr constant [39 x i8] c"androidx/navigation/NavDeepLinkBuilder\00", align 1
@.str.727 = private unnamed_addr constant [38 x i8] c"androidx/navigation/NavHostController\00", align 1
@.str.728 = private unnamed_addr constant [32 x i8] c"androidx/navigation/NavInflater\00", align 1
@.str.729 = private unnamed_addr constant [29 x i8] c"androidx/lifecycle/Lifecycle\00", align 1
@.str.730 = private unnamed_addr constant [35 x i8] c"androidx/lifecycle/Lifecycle$Event\00", align 1
@.str.731 = private unnamed_addr constant [35 x i8] c"androidx/lifecycle/Lifecycle$State\00", align 1
@.str.732 = private unnamed_addr constant [37 x i8] c"androidx/lifecycle/LifecycleObserver\00", align 1
@.str.733 = private unnamed_addr constant [34 x i8] c"androidx/lifecycle/LifecycleOwner\00", align 1
@.str.734 = private unnamed_addr constant [39 x i8] c"androidx/lifecycle/ViewModelStoreOwner\00", align 1
@.str.735 = private unnamed_addr constant [29 x i8] c"androidx/lifecycle/ViewModel\00", align 1
@.str.736 = private unnamed_addr constant [37 x i8] c"androidx/lifecycle/ViewModelProvider\00", align 1
@.str.737 = private unnamed_addr constant [55 x i8] c"androidx/lifecycle/ViewModelProvider$Factory$Companion\00", align 1
@.str.738 = private unnamed_addr constant [45 x i8] c"androidx/lifecycle/ViewModelProvider$Factory\00", align 1
@.str.739 = private unnamed_addr constant [34 x i8] c"androidx/lifecycle/ViewModelStore\00", align 1
@.str.740 = private unnamed_addr constant [44 x i8] c"androidx/lifecycle/viewmodel/CreationExtras\00", align 1
@.str.741 = private unnamed_addr constant [48 x i8] c"androidx/lifecycle/viewmodel/CreationExtras$Key\00", align 1
@.str.742 = private unnamed_addr constant [50 x i8] c"androidx/lifecycle/viewmodel/ViewModelInitializer\00", align 1
@.str.743 = private unnamed_addr constant [50 x i8] c"com/google/android/material/shape/CornerTreatment\00", align 1
@.str.744 = private unnamed_addr constant [48 x i8] c"com/google/android/material/shape/EdgeTreatment\00", align 1
@.str.745 = private unnamed_addr constant [45 x i8] c"com/google/android/material/shape/CornerSize\00", align 1
@.str.746 = private unnamed_addr constant [56 x i8] c"com/google/android/material/shape/MaterialShapeDrawable\00", align 1
@.str.747 = private unnamed_addr constant [83 x i8] c"com/google/android/material/shape/MaterialShapeDrawable$MaterialShapeDrawableState\00", align 1
@.str.748 = private unnamed_addr constant [55 x i8] c"com/google/android/material/shape/ShapeAppearanceModel\00", align 1
@.str.749 = private unnamed_addr constant [63 x i8] c"com/google/android/material/shape/ShapeAppearanceModel$Builder\00", align 1
@.str.750 = private unnamed_addr constant [79 x i8] c"com/google/android/material/shape/ShapeAppearanceModel$CornerSizeUnaryOperator\00", align 1
@.str.751 = private unnamed_addr constant [44 x i8] c"com/google/android/material/shape/ShapePath\00", align 1
@.str.752 = private unnamed_addr constant [49 x i8] c"com/google/android/material/shape/ShapePathModel\00", align 1
@.str.753 = private unnamed_addr constant [57 x i8] c"com/google/android/material/imageview/ShapeableImageView\00", align 1
@.str.754 = private unnamed_addr constant [63 x i8] c"com/google/android/material/elevation/ElevationOverlayProvider\00", align 1
@.str.755 = private unnamed_addr constant [54 x i8] c"com/google/android/material/checkbox/MaterialCheckBox\00", align 1
@.str.756 = private unnamed_addr constant [84 x i8] c"com/google/android/material/checkbox/MaterialCheckBox$OnCheckedStateChangedListener\00", align 1
@.str.757 = private unnamed_addr constant [100 x i8] c"mono/com/google/android/material/checkbox/MaterialCheckBox_OnCheckedStateChangedListenerImplementor\00", align 1
@.str.758 = private unnamed_addr constant [77 x i8] c"com/google/android/material/checkbox/MaterialCheckBox$OnErrorChangedListener\00", align 1
@.str.759 = private unnamed_addr constant [93 x i8] c"mono/com/google/android/material/checkbox/MaterialCheckBox_OnErrorChangedListenerImplementor\00", align 1
@.str.760 = private unnamed_addr constant [50 x i8] c"com/google/android/material/button/MaterialButton\00", align 1
@.str.761 = private unnamed_addr constant [74 x i8] c"com/google/android/material/button/MaterialButton$OnCheckedChangeListener\00", align 1
@.str.762 = private unnamed_addr constant [90 x i8] c"mono/com/google/android/material/button/MaterialButton_OnCheckedChangeListenerImplementor\00", align 1
@.str.763 = private unnamed_addr constant [60 x i8] c"com/google/android/material/bottomsheet/BottomSheetBehavior\00", align 1
@.str.764 = private unnamed_addr constant [80 x i8] c"com/google/android/material/bottomsheet/BottomSheetBehavior$BottomSheetCallback\00", align 1
@.str.765 = private unnamed_addr constant [58 x i8] c"com/google/android/material/bottomsheet/BottomSheetDialog\00", align 1
@.str.766 = private unnamed_addr constant [48 x i8] c"com/google/android/material/badge/BadgeDrawable\00", align 1
@.str.767 = private unnamed_addr constant [57 x i8] c"com/google/android/material/navigation/NavigationBarView\00", align 1
@.str.768 = private unnamed_addr constant [82 x i8] c"com/google/android/material/navigation/NavigationBarView$OnItemReselectedListener\00", align 1
@.str.769 = private unnamed_addr constant [98 x i8] c"mono/com/google/android/material/navigation/NavigationBarView_OnItemReselectedListenerImplementor\00", align 1
@.str.770 = private unnamed_addr constant [80 x i8] c"com/google/android/material/navigation/NavigationBarView$OnItemSelectedListener\00", align 1
@.str.771 = private unnamed_addr constant [96 x i8] c"mono/com/google/android/material/navigation/NavigationBarView_OnItemSelectedListenerImplementor\00", align 1
@.str.772 = private unnamed_addr constant [61 x i8] c"com/google/android/material/navigation/NavigationBarItemView\00", align 1
@.str.773 = private unnamed_addr constant [61 x i8] c"com/google/android/material/navigation/NavigationBarMenuView\00", align 1
@.str.774 = private unnamed_addr constant [62 x i8] c"com/google/android/material/navigation/NavigationBarPresenter\00", align 1
@.str.775 = private unnamed_addr constant [54 x i8] c"com/google/android/material/navigation/NavigationView\00", align 1
@.str.776 = private unnamed_addr constant [87 x i8] c"com/google/android/material/navigation/NavigationView$OnNavigationItemSelectedListener\00", align 1
@.str.777 = private unnamed_addr constant [103 x i8] c"mono/com/google/android/material/navigation/NavigationView_OnNavigationItemSelectedListenerImplementor\00", align 1
@.str.778 = private unnamed_addr constant [43 x i8] c"com/google/android/material/tabs/TabLayout\00", align 1
@.str.779 = private unnamed_addr constant [51 x i8] c"com/google/android/material/tabs/TabLayout$TabView\00", align 1
@.str.780 = private unnamed_addr constant [69 x i8] c"com/google/android/material/tabs/TabLayout$BaseOnTabSelectedListener\00", align 1
@.str.781 = private unnamed_addr constant [85 x i8] c"mono/com/google/android/material/tabs/TabLayout_BaseOnTabSelectedListenerImplementor\00", align 1
@.str.782 = private unnamed_addr constant [65 x i8] c"com/google/android/material/tabs/TabLayout$OnTabSelectedListener\00", align 1
@.str.783 = private unnamed_addr constant [47 x i8] c"com/google/android/material/tabs/TabLayout$Tab\00", align 1
@.str.784 = private unnamed_addr constant [51 x i8] c"com/google/android/material/tabs/TabLayoutMediator\00", align 1
@.str.785 = private unnamed_addr constant [76 x i8] c"com/google/android/material/tabs/TabLayoutMediator$TabConfigurationStrategy\00", align 1
@.str.786 = private unnamed_addr constant [67 x i8] c"com/google/android/material/internal/StaticLayoutBuilderConfigurer\00", align 1
@.str.787 = private unnamed_addr constant [60 x i8] c"com/google/android/material/internal/ScrimInsetsFrameLayout\00", align 1
@.str.788 = private unnamed_addr constant [70 x i8] c"com/google/android/material/bottomnavigation/BottomNavigationItemView\00", align 1
@.str.789 = private unnamed_addr constant [70 x i8] c"com/google/android/material/bottomnavigation/BottomNavigationMenuView\00", align 1
@.str.790 = private unnamed_addr constant [66 x i8] c"com/google/android/material/bottomnavigation/BottomNavigationView\00", align 1
@.str.791 = private unnamed_addr constant [101 x i8] c"com/google/android/material/bottomnavigation/BottomNavigationView$OnNavigationItemReselectedListener\00", align 1
@.str.792 = private unnamed_addr constant [99 x i8] c"com/google/android/material/bottomnavigation/BottomNavigationView$OnNavigationItemSelectedListener\00", align 1
@.str.793 = private unnamed_addr constant [59 x i8] c"com/google/android/material/appbar/CollapsingToolbarLayout\00", align 1
@.str.794 = private unnamed_addr constant [89 x i8] c"com/google/android/material/appbar/CollapsingToolbarLayout$StaticLayoutBuilderConfigurer\00", align 1
@.str.795 = private unnamed_addr constant [48 x i8] c"com/google/android/material/appbar/AppBarLayout\00", align 1
@.str.796 = private unnamed_addr constant [61 x i8] c"com/google/android/material/appbar/AppBarLayout$BaseBehavior\00", align 1
@.str.797 = private unnamed_addr constant [78 x i8] c"com/google/android/material/appbar/AppBarLayout$BaseBehavior$BaseDragCallback\00", align 1
@.str.798 = private unnamed_addr constant [57 x i8] c"com/google/android/material/appbar/AppBarLayout$Behavior\00", align 1
@.str.799 = private unnamed_addr constant [66 x i8] c"com/google/android/material/appbar/AppBarLayout$ChildScrollEffect\00", align 1
@.str.800 = private unnamed_addr constant [61 x i8] c"com/google/android/material/appbar/AppBarLayout$LayoutParams\00", align 1
@.str.801 = private unnamed_addr constant [69 x i8] c"com/google/android/material/appbar/AppBarLayout$LiftOnScrollListener\00", align 1
@.str.802 = private unnamed_addr constant [85 x i8] c"mono/com/google/android/material/appbar/AppBarLayout_LiftOnScrollListenerImplementor\00", align 1
@.str.803 = private unnamed_addr constant [72 x i8] c"com/google/android/material/appbar/AppBarLayout$OnOffsetChangedListener\00", align 1
@.str.804 = private unnamed_addr constant [88 x i8] c"mono/com/google/android/material/appbar/AppBarLayout_OnOffsetChangedListenerImplementor\00", align 1
@.str.805 = private unnamed_addr constant [70 x i8] c"com/google/android/material/appbar/AppBarLayout$ScrollingViewBehavior\00", align 1
@.str.806 = private unnamed_addr constant [50 x i8] c"com/google/android/material/appbar/HeaderBehavior\00", align 1
@.str.807 = private unnamed_addr constant [63 x i8] c"com/google/android/material/appbar/HeaderScrollingViewBehavior\00", align 1
@.str.808 = private unnamed_addr constant [51 x i8] c"com/google/android/material/appbar/MaterialToolbar\00", align 1
@.str.809 = private unnamed_addr constant [54 x i8] c"com/google/android/material/appbar/ViewOffsetBehavior\00", align 1
@.str.810 = private unnamed_addr constant [35 x i8] c"crc64c508e0a6469c3711/MainActivity\00", align 1
@.str.811 = private unnamed_addr constant [38 x i8] c"crc6450d00504b1424cab/MainApplication\00", align 1
@.str.812 = private unnamed_addr constant [38 x i8] c"androidx/viewpager2/widget/ViewPager2\00", align 1
@.str.813 = private unnamed_addr constant [59 x i8] c"androidx/viewpager2/widget/ViewPager2$OnPageChangeCallback\00", align 1
@.str.814 = private unnamed_addr constant [54 x i8] c"androidx/viewpager2/widget/ViewPager2$PageTransformer\00", align 1
@.str.815 = private unnamed_addr constant [49 x i8] c"androidx/viewpager2/adapter/FragmentStateAdapter\00", align 1
@.str.816 = private unnamed_addr constant [77 x i8] c"androidx/viewpager2/adapter/FragmentStateAdapter$FragmentTransactionCallback\00", align 1
@.str.817 = private unnamed_addr constant [97 x i8] c"androidx/viewpager2/adapter/FragmentStateAdapter$FragmentTransactionCallback$OnPostEventListener\00", align 1
@.str.818 = private unnamed_addr constant [47 x i8] c"androidx/viewpager2/adapter/FragmentViewHolder\00", align 1
@.str.819 = private unnamed_addr constant [50 x i8] c"crc640360c8a960a6805b/CustomAccessibilityDelegate\00", align 1
@.str.820 = private unnamed_addr constant [50 x i8] c"crc640360c8a960a6805b/CustomAccessibilityProvider\00", align 1
@.str.821 = private unnamed_addr constant [39 x i8] c"crc640360c8a960a6805b/StaticTextLayout\00", align 1
@.str.822 = private unnamed_addr constant [43 x i8] c"crc640360c8a960a6805b/PlatformSignaturePad\00", align 1
@.str.823 = private unnamed_addr constant [46 x i8] c"crc6481e5b28a6b4dd87a/NativeCustomScrolLayout\00", align 1
@.str.824 = private unnamed_addr constant [39 x i8] c"crc6481e5b28a6b4dd87a/NativeSnapLayout\00", align 1
@.str.825 = private unnamed_addr constant [60 x i8] c"crc6481e5b28a6b4dd87a/NativeSnapLayout_FlingGestureListener\00", align 1
@.str.826 = private unnamed_addr constant [33 x i8] c"crc64f5844edce43316e7/ButtonView\00", align 1
@.str.827 = private unnamed_addr constant [38 x i8] c"crc64f5844edce43316e7/CustomImageView\00", align 1
@.str.828 = private unnamed_addr constant [37 x i8] c"crc64f5844edce43316e7/ItemViewHolder\00", align 1
@.str.829 = private unnamed_addr constant [52 x i8] c"crc64f5844edce43316e7/SfRotatorFlingGestureListener\00", align 1
@.str.830 = private unnamed_addr constant [38 x i8] c"crc64f5844edce43316e7/OnTouchListener\00", align 1
@.str.831 = private unnamed_addr constant [31 x i8] c"crc64f5844edce43316e7/TabStrip\00", align 1
@.str.832 = private unnamed_addr constant [37 x i8] c"crc64f5844edce43316e7/ThumbnailStrip\00", align 1
@.str.833 = private unnamed_addr constant [38 x i8] c"crc64f5844edce43316e7/PlatformRotator\00", align 1
@.str.834 = private unnamed_addr constant [31 x i8] c"crc64f5844edce43316e7/ProTimer\00", align 1
@.str.835 = private unnamed_addr constant [49 x i8] c"crc64f5844edce43316e7/Mapping_CustomPathDrawable\00", align 1
@.str.836 = private unnamed_addr constant [42 x i8] c"crc64f5844edce43316e7/PlatformRotatorItem\00", align 1
@.str.837 = private unnamed_addr constant [52 x i8] c"crc6479d6f9e48582dc67/GestureDetector_ScaleListener\00", align 1
@.str.838 = private unnamed_addr constant [53 x i8] c"crc6479d6f9e48582dc67/GestureDetector_ScrollListener\00", align 1
@.str.839 = private unnamed_addr constant [45 x i8] c"crc6479d6f9e48582dc67/HorizontalScrollViewer\00", align 1
@.str.840 = private unnamed_addr constant [43 x i8] c"crc6479d6f9e48582dc67/PlatformScrollViewer\00", align 1
@.str.841 = private unnamed_addr constant [47 x i8] c"crc6479d6f9e48582dc67/NativeListViewScrollView\00", align 1
@.str.842 = private unnamed_addr constant [46 x i8] c"crc6479d6f9e48582dc67/NativeCustomScrolLayout\00", align 1
@.str.843 = private unnamed_addr constant [47 x i8] c"crc6479d6f9e48582dc67/NativeTreeViewScrollView\00", align 1
@.str.844 = private unnamed_addr constant [41 x i8] c"crc6479d6f9e48582dc67/WindowOverlayStack\00", align 1
@.str.845 = private unnamed_addr constant [43 x i8] c"crc64354973402314325c/PlatformCarouselItem\00", align 1
@.str.846 = private unnamed_addr constant [38 x i8] c"crc64354973402314325c/CustomImageView\00", align 1
@.str.847 = private unnamed_addr constant [34 x i8] c"crc64354973402314325c/ItemAdapter\00", align 1
@.str.848 = private unnamed_addr constant [33 x i8] c"crc64354973402314325c/ViewHolder\00", align 1
@.str.849 = private unnamed_addr constant [39 x i8] c"crc64354973402314325c/PlatformCarousel\00", align 1
@.str.850 = private unnamed_addr constant [42 x i8] c"crc64354973402314325c/SpaceItemDecoration\00", align 1
@.str.851 = private unnamed_addr constant [41 x i8] c"crc6486af4e8104107bae/LayoutViewGroupExt\00", align 1
@.str.852 = private unnamed_addr constant [43 x i8] c"crc6486af4e8104107bae/AppCompatEditTextExt\00", align 1
@.str.853 = private unnamed_addr constant [44 x i8] c"crc6486af4e8104107bae/CustomInputConnection\00", align 1
@.str.854 = private unnamed_addr constant [38 x i8] c"crc6486af4e8104107bae/DropdownViewExt\00", align 1
@.str.855 = private unnamed_addr constant [47 x i8] c"crc648a9457dd5f66374f/LayoutViewGroupExtension\00", align 1
@.str.856 = private unnamed_addr constant [50 x i8] c"crc648a9457dd5f66374f/ExtMauiHorizontalScrollView\00", align 1
@.str.857 = private unnamed_addr constant [40 x i8] c"crc648a9457dd5f66374f/ExtMauiScrollView\00", align 1
@.str.858 = private unnamed_addr constant [47 x i8] c"androidx/recyclerview/widget/GridLayoutManager\00", align 1
@.str.859 = private unnamed_addr constant [62 x i8] c"androidx/recyclerview/widget/GridLayoutManager$SpanSizeLookup\00", align 1
@.str.860 = private unnamed_addr constant [45 x i8] c"androidx/recyclerview/widget/ItemTouchUIUtil\00", align 1
@.str.861 = private unnamed_addr constant [45 x i8] c"androidx/recyclerview/widget/ItemTouchHelper\00", align 1
@.str.862 = private unnamed_addr constant [54 x i8] c"androidx/recyclerview/widget/ItemTouchHelper$Callback\00", align 1
@.str.863 = private unnamed_addr constant [49 x i8] c"androidx/recyclerview/widget/LinearLayoutManager\00", align 1
@.str.864 = private unnamed_addr constant [50 x i8] c"androidx/recyclerview/widget/LinearSmoothScroller\00", align 1
@.str.865 = private unnamed_addr constant [46 x i8] c"androidx/recyclerview/widget/LinearSnapHelper\00", align 1
@.str.866 = private unnamed_addr constant [47 x i8] c"androidx/recyclerview/widget/OrientationHelper\00", align 1
@.str.867 = private unnamed_addr constant [45 x i8] c"androidx/recyclerview/widget/PagerSnapHelper\00", align 1
@.str.868 = private unnamed_addr constant [42 x i8] c"androidx/recyclerview/widget/RecyclerView\00", align 1
@.str.869 = private unnamed_addr constant [50 x i8] c"androidx/recyclerview/widget/RecyclerView$Adapter\00", align 1
@.str.870 = private unnamed_addr constant [73 x i8] c"androidx/recyclerview/widget/RecyclerView$Adapter$StateRestorationPolicy\00", align 1
@.str.871 = private unnamed_addr constant [62 x i8] c"androidx/recyclerview/widget/RecyclerView$AdapterDataObserver\00", align 1
@.str.872 = private unnamed_addr constant [68 x i8] c"androidx/recyclerview/widget/RecyclerView$ChildDrawingOrderCallback\00", align 1
@.str.873 = private unnamed_addr constant [60 x i8] c"androidx/recyclerview/widget/RecyclerView$EdgeEffectFactory\00", align 1
@.str.874 = private unnamed_addr constant [55 x i8] c"androidx/recyclerview/widget/RecyclerView$ItemAnimator\00", align 1
@.str.875 = private unnamed_addr constant [84 x i8] c"androidx/recyclerview/widget/RecyclerView$ItemAnimator$ItemAnimatorFinishedListener\00", align 1
@.str.876 = private unnamed_addr constant [70 x i8] c"androidx/recyclerview/widget/RecyclerView$ItemAnimator$ItemHolderInfo\00", align 1
@.str.877 = private unnamed_addr constant [57 x i8] c"androidx/recyclerview/widget/RecyclerView$ItemDecoration\00", align 1
@.str.878 = private unnamed_addr constant [56 x i8] c"androidx/recyclerview/widget/RecyclerView$LayoutManager\00", align 1
@.str.879 = private unnamed_addr constant [79 x i8] c"androidx/recyclerview/widget/RecyclerView$LayoutManager$LayoutPrefetchRegistry\00", align 1
@.str.880 = private unnamed_addr constant [67 x i8] c"androidx/recyclerview/widget/RecyclerView$LayoutManager$Properties\00", align 1
@.str.881 = private unnamed_addr constant [55 x i8] c"androidx/recyclerview/widget/RecyclerView$LayoutParams\00", align 1
@.str.882 = private unnamed_addr constant [75 x i8] c"androidx/recyclerview/widget/RecyclerView$OnChildAttachStateChangeListener\00", align 1
@.str.883 = private unnamed_addr constant [91 x i8] c"mono/androidx/recyclerview/widget/RecyclerView_OnChildAttachStateChangeListenerImplementor\00", align 1
@.str.884 = private unnamed_addr constant [58 x i8] c"androidx/recyclerview/widget/RecyclerView$OnFlingListener\00", align 1
@.str.885 = private unnamed_addr constant [62 x i8] c"androidx/recyclerview/widget/RecyclerView$OnItemTouchListener\00", align 1
@.str.886 = private unnamed_addr constant [78 x i8] c"mono/androidx/recyclerview/widget/RecyclerView_OnItemTouchListenerImplementor\00", align 1
@.str.887 = private unnamed_addr constant [59 x i8] c"androidx/recyclerview/widget/RecyclerView$OnScrollListener\00", align 1
@.str.888 = private unnamed_addr constant [59 x i8] c"androidx/recyclerview/widget/RecyclerView$RecycledViewPool\00", align 1
@.str.889 = private unnamed_addr constant [51 x i8] c"androidx/recyclerview/widget/RecyclerView$Recycler\00", align 1
@.str.890 = private unnamed_addr constant [59 x i8] c"androidx/recyclerview/widget/RecyclerView$RecyclerListener\00", align 1
@.str.891 = private unnamed_addr constant [75 x i8] c"mono/androidx/recyclerview/widget/RecyclerView_RecyclerListenerImplementor\00", align 1
@.str.892 = private unnamed_addr constant [57 x i8] c"androidx/recyclerview/widget/RecyclerView$SmoothScroller\00", align 1
@.str.893 = private unnamed_addr constant [64 x i8] c"androidx/recyclerview/widget/RecyclerView$SmoothScroller$Action\00", align 1
@.str.894 = private unnamed_addr constant [48 x i8] c"androidx/recyclerview/widget/RecyclerView$State\00", align 1
@.str.895 = private unnamed_addr constant [61 x i8] c"androidx/recyclerview/widget/RecyclerView$ViewCacheExtension\00", align 1
@.str.896 = private unnamed_addr constant [53 x i8] c"androidx/recyclerview/widget/RecyclerView$ViewHolder\00", align 1
@.str.897 = private unnamed_addr constant [63 x i8] c"androidx/recyclerview/widget/RecyclerViewAccessibilityDelegate\00", align 1
@.str.898 = private unnamed_addr constant [40 x i8] c"androidx/recyclerview/widget/SnapHelper\00", align 1
@.str.899 = private unnamed_addr constant [34 x i8] c"androidx/activity/BackEventCompat\00", align 1
@.str.900 = private unnamed_addr constant [36 x i8] c"androidx/activity/ComponentActivity\00", align 1
@.str.901 = private unnamed_addr constant [34 x i8] c"androidx/activity/ComponentDialog\00", align 1
@.str.902 = private unnamed_addr constant [37 x i8] c"androidx/activity/FullyDrawnReporter\00", align 1
@.str.903 = private unnamed_addr constant [40 x i8] c"androidx/activity/OnBackPressedCallback\00", align 1
@.str.904 = private unnamed_addr constant [42 x i8] c"androidx/activity/OnBackPressedDispatcher\00", align 1
@.str.905 = private unnamed_addr constant [58 x i8] c"androidx/activity/contextaware/OnContextAvailableListener\00", align 1
@.str.906 = private unnamed_addr constant [74 x i8] c"mono/androidx/activity/contextaware/OnContextAvailableListenerImplementor\00", align 1
@.str.907 = private unnamed_addr constant [48 x i8] c"androidx/activity/result/ActivityResultLauncher\00", align 1
@.str.908 = private unnamed_addr constant [48 x i8] c"androidx/activity/result/ActivityResultRegistry\00", align 1
@.str.909 = private unnamed_addr constant [48 x i8] c"androidx/activity/result/ActivityResultCallback\00", align 1
@.str.910 = private unnamed_addr constant [57 x i8] c"androidx/activity/result/contract/ActivityResultContract\00", align 1
@.str.911 = private unnamed_addr constant [75 x i8] c"androidx/activity/result/contract/ActivityResultContract$SynchronousResult\00", align 1
@.str.912 = private unnamed_addr constant [44 x i8] c"androidx/cursoradapter/widget/CursorAdapter\00", align 1
@.str.913 = private unnamed_addr constant [28 x i8] c"androidx/core/util/Consumer\00", align 1
@.str.914 = private unnamed_addr constant [29 x i8] c"androidx/core/util/Predicate\00", align 1
@.str.915 = private unnamed_addr constant [24 x i8] c"androidx/core/util/Pair\00", align 1
@.str.916 = private unnamed_addr constant [34 x i8] c"androidx/core/os/LocaleListCompat\00", align 1
@.str.917 = private unnamed_addr constant [44 x i8] c"androidx/core/internal/view/SupportMenuItem\00", align 1
@.str.918 = private unnamed_addr constant [30 x i8] c"androidx/core/graphics/Insets\00", align 1
@.str.919 = private unnamed_addr constant [47 x i8] c"androidx/core/graphics/drawable/DrawableCompat\00", align 1
@.str.920 = private unnamed_addr constant [36 x i8] c"androidx/core/content/ContextCompat\00", align 1
@.str.921 = private unnamed_addr constant [35 x i8] c"androidx/core/content/FileProvider\00", align 1
@.str.922 = private unnamed_addr constant [36 x i8] c"androidx/core/content/LocusIdCompat\00", align 1
@.str.923 = private unnamed_addr constant [40 x i8] c"androidx/core/content/PermissionChecker\00", align 1
@.str.924 = private unnamed_addr constant [42 x i8] c"androidx/core/content/res/ResourcesCompat\00", align 1
@.str.925 = private unnamed_addr constant [55 x i8] c"androidx/core/content/res/ResourcesCompat$FontCallback\00", align 1
@.str.926 = private unnamed_addr constant [43 x i8] c"androidx/core/content/pm/PackageInfoCompat\00", align 1
@.str.927 = private unnamed_addr constant [33 x i8] c"androidx/core/app/ActivityCompat\00", align 1
@.str.928 = private unnamed_addr constant [58 x i8] c"androidx/core/app/ActivityCompat$PermissionCompatDelegate\00", align 1
@.str.929 = private unnamed_addr constant [40 x i8] c"androidx/core/app/ActivityOptionsCompat\00", align 1
@.str.930 = private unnamed_addr constant [36 x i8] c"androidx/core/app/ComponentActivity\00", align 1
@.str.931 = private unnamed_addr constant [46 x i8] c"androidx/core/app/ComponentActivity$ExtraData\00", align 1
@.str.932 = private unnamed_addr constant [40 x i8] c"androidx/core/app/SharedElementCallback\00", align 1
@.str.933 = private unnamed_addr constant [70 x i8] c"androidx/core/app/SharedElementCallback$OnSharedElementsReadyListener\00", align 1
@.str.934 = private unnamed_addr constant [35 x i8] c"androidx/core/app/TaskStackBuilder\00", align 1
@.str.935 = private unnamed_addr constant [38 x i8] c"androidx/core/widget/NestedScrollView\00", align 1
@.str.936 = private unnamed_addr constant [61 x i8] c"androidx/core/widget/NestedScrollView$OnScrollChangeListener\00", align 1
@.str.937 = private unnamed_addr constant [77 x i8] c"mono/androidx/core/widget/NestedScrollView_OnScrollChangeListenerImplementor\00", align 1
@.str.938 = private unnamed_addr constant [42 x i8] c"androidx/core/widget/CompoundButtonCompat\00", align 1
@.str.939 = private unnamed_addr constant [36 x i8] c"androidx/core/widget/TextViewCompat\00", align 1
@.str.940 = private unnamed_addr constant [47 x i8] c"androidx/core/view/AccessibilityDelegateCompat\00", align 1
@.str.941 = private unnamed_addr constant [34 x i8] c"androidx/core/view/ActionProvider\00", align 1
@.str.942 = private unnamed_addr constant [58 x i8] c"androidx/core/view/ActionProvider$SubUiVisibilityListener\00", align 1
@.str.943 = private unnamed_addr constant [74 x i8] c"mono/androidx/core/view/ActionProvider_SubUiVisibilityListenerImplementor\00", align 1
@.str.944 = private unnamed_addr constant [53 x i8] c"androidx/core/view/ActionProvider$VisibilityListener\00", align 1
@.str.945 = private unnamed_addr constant [69 x i8] c"mono/androidx/core/view/ActionProvider_VisibilityListenerImplementor\00", align 1
@.str.946 = private unnamed_addr constant [37 x i8] c"androidx/core/view/ContentInfoCompat\00", align 1
@.str.947 = private unnamed_addr constant [39 x i8] c"androidx/core/view/DisplayCutoutCompat\00", align 1
@.str.948 = private unnamed_addr constant [48 x i8] c"androidx/core/view/DragAndDropPermissionsCompat\00", align 1
@.str.949 = private unnamed_addr constant [32 x i8] c"androidx/core/view/MenuProvider\00", align 1
@.str.950 = private unnamed_addr constant [47 x i8] c"androidx/core/view/OnApplyWindowInsetsListener\00", align 1
@.str.951 = private unnamed_addr constant [44 x i8] c"androidx/core/view/OnReceiveContentListener\00", align 1
@.str.952 = private unnamed_addr constant [33 x i8] c"androidx/core/view/ScrollingView\00", align 1
@.str.953 = private unnamed_addr constant [48 x i8] c"androidx/core/view/ViewPropertyAnimatorListener\00", align 1
@.str.954 = private unnamed_addr constant [54 x i8] c"androidx/core/view/ViewPropertyAnimatorUpdateListener\00", align 1
@.str.955 = private unnamed_addr constant [62 x i8] c"androidx/core/view/WindowInsetsAnimationControlListenerCompat\00", align 1
@.str.956 = private unnamed_addr constant [34 x i8] c"androidx/core/view/MenuItemCompat\00", align 1
@.str.957 = private unnamed_addr constant [57 x i8] c"androidx/core/view/MenuItemCompat$OnActionExpandListener\00", align 1
@.str.958 = private unnamed_addr constant [37 x i8] c"androidx/core/view/PointerIconCompat\00", align 1
@.str.959 = private unnamed_addr constant [46 x i8] c"androidx/core/view/ScaleGestureDetectorCompat\00", align 1
@.str.960 = private unnamed_addr constant [30 x i8] c"androidx/core/view/ViewCompat\00", align 1
@.str.961 = private unnamed_addr constant [64 x i8] c"androidx/core/view/ViewCompat$OnUnhandledKeyEventListenerCompat\00", align 1
@.str.962 = private unnamed_addr constant [46 x i8] c"androidx/core/view/ViewPropertyAnimatorCompat\00", align 1
@.str.963 = private unnamed_addr constant [39 x i8] c"androidx/core/view/ViewStructureCompat\00", align 1
@.str.964 = private unnamed_addr constant [32 x i8] c"androidx/core/view/WindowCompat\00", align 1
@.str.965 = private unnamed_addr constant [47 x i8] c"androidx/core/view/WindowInsetsAnimationCompat\00", align 1
@.str.966 = private unnamed_addr constant [60 x i8] c"androidx/core/view/WindowInsetsAnimationCompat$BoundsCompat\00", align 1
@.str.967 = private unnamed_addr constant [56 x i8] c"androidx/core/view/WindowInsetsAnimationCompat$Callback\00", align 1
@.str.968 = private unnamed_addr constant [57 x i8] c"androidx/core/view/WindowInsetsAnimationControllerCompat\00", align 1
@.str.969 = private unnamed_addr constant [38 x i8] c"androidx/core/view/WindowInsetsCompat\00", align 1
@.str.970 = private unnamed_addr constant [43 x i8] c"androidx/core/view/WindowInsetsCompat$Type\00", align 1
@.str.971 = private unnamed_addr constant [48 x i8] c"androidx/core/view/WindowInsetsControllerCompat\00", align 1
@.str.972 = private unnamed_addr constant [84 x i8] c"androidx/core/view/WindowInsetsControllerCompat$OnControllableInsetsChangedListener\00", align 1
@.str.973 = private unnamed_addr constant [100 x i8] c"mono/androidx/core/view/WindowInsetsControllerCompat_OnControllableInsetsChangedListenerImplementor\00", align 1
@.str.974 = private unnamed_addr constant [62 x i8] c"androidx/core/view/contentcapture/ContentCaptureSessionCompat\00", align 1
@.str.975 = private unnamed_addr constant [45 x i8] c"androidx/core/view/autofill/AutofillIdCompat\00", align 1
@.str.976 = private unnamed_addr constant [61 x i8] c"androidx/core/view/accessibility/AccessibilityNodeInfoCompat\00", align 1
@.str.977 = private unnamed_addr constant [87 x i8] c"androidx/core/view/accessibility/AccessibilityNodeInfoCompat$AccessibilityActionCompat\00", align 1
@.str.978 = private unnamed_addr constant [82 x i8] c"androidx/core/view/accessibility/AccessibilityNodeInfoCompat$CollectionInfoCompat\00", align 1
@.str.979 = private unnamed_addr constant [86 x i8] c"androidx/core/view/accessibility/AccessibilityNodeInfoCompat$CollectionItemInfoCompat\00", align 1
@.str.980 = private unnamed_addr constant [77 x i8] c"androidx/core/view/accessibility/AccessibilityNodeInfoCompat$RangeInfoCompat\00", align 1
@.str.981 = private unnamed_addr constant [85 x i8] c"androidx/core/view/accessibility/AccessibilityNodeInfoCompat$TouchDelegateInfoCompat\00", align 1
@.str.982 = private unnamed_addr constant [65 x i8] c"androidx/core/view/accessibility/AccessibilityNodeProviderCompat\00", align 1
@.str.983 = private unnamed_addr constant [63 x i8] c"androidx/core/view/accessibility/AccessibilityWindowInfoCompat\00", align 1
@.str.984 = private unnamed_addr constant [75 x i8] c"androidx/core/view/accessibility/AccessibilityViewCommand$CommandArguments\00", align 1
@.str.985 = private unnamed_addr constant [58 x i8] c"androidx/core/view/accessibility/AccessibilityViewCommand\00", align 1
@.str.986 = private unnamed_addr constant [41 x i8] c"androidx/core/text/PrecomputedTextCompat\00", align 1
@.str.987 = private unnamed_addr constant [48 x i8] c"androidx/core/text/PrecomputedTextCompat$Params\00", align 1
@.str.988 = private unnamed_addr constant [34 x i8] c"kotlinx/coroutines/CoroutineScope\00", align 1
@.str.989 = private unnamed_addr constant [29 x i8] c"kotlinx/coroutines/flow/Flow\00", align 1
@.str.990 = private unnamed_addr constant [38 x i8] c"kotlinx/coroutines/flow/FlowCollector\00", align 1
@.str.991 = private unnamed_addr constant [35 x i8] c"kotlinx/coroutines/flow/SharedFlow\00", align 1
@.str.992 = private unnamed_addr constant [34 x i8] c"kotlinx/coroutines/flow/StateFlow\00", align 1
@.str.993 = private unnamed_addr constant [59 x i8] c"crc6468b6408a11370c2f/WebAuthenticatorIntermediateActivity\00", align 1
@.str.994 = private unnamed_addr constant [39 x i8] c"microsoft/maui/essentials/fileProvider\00", align 1
@.str.995 = private unnamed_addr constant [75 x i8] c"crc64e53d2f592022988e/ConnectivityImplementation_EssentialsNetworkCallback\00", align 1
@.str.996 = private unnamed_addr constant [52 x i8] c"crc64e53d2f592022988e/ConnectivityBroadcastReceiver\00", align 1
@.str.997 = private unnamed_addr constant [55 x i8] c"crc64ba438d8f48cf7e75/ActivityLifecycleContextListener\00", align 1
@.str.998 = private unnamed_addr constant [43 x i8] c"crc64ba438d8f48cf7e75/IntermediateActivity\00", align 1
@.str.999 = private unnamed_addr constant [59 x i8] c"crc640a8d9a12ddbf2cf2/DeviceDisplayImplementation_Listener\00", align 1
@.str.1000 = private unnamed_addr constant [47 x i8] c"crc640a8d9a12ddbf2cf2/BatteryBroadcastReceiver\00", align 1
@.str.1001 = private unnamed_addr constant [51 x i8] c"crc640a8d9a12ddbf2cf2/EnergySaverBroadcastReceiver\00", align 1
@.str.1002 = private unnamed_addr constant [44 x i8] c"crc64e6d0b84c6264ccdd/AuthenticationHandler\00", align 1
@.str.1003 = private unnamed_addr constant [57 x i8] c"androidx/appcompat/graphics/drawable/DrawerArrowDrawable\00", align 1
@.str.1004 = private unnamed_addr constant [35 x i8] c"androidx/appcompat/app/AlertDialog\00", align 1
@.str.1005 = private unnamed_addr constant [43 x i8] c"androidx/appcompat/app/AlertDialog$Builder\00", align 1
@.str.1006 = private unnamed_addr constant [78 x i8] c"androidx/appcompat/app/AlertDialog_IDialogInterfaceOnClickListenerImplementor\00", align 1
@.str.1007 = private unnamed_addr constant [79 x i8] c"androidx/appcompat/app/AlertDialog_IDialogInterfaceOnCancelListenerImplementor\00", align 1
@.str.1008 = private unnamed_addr constant [89 x i8] c"androidx/appcompat/app/AlertDialog_IDialogInterfaceOnMultiChoiceClickListenerImplementor\00", align 1
@.str.1009 = private unnamed_addr constant [33 x i8] c"androidx/appcompat/app/ActionBar\00", align 1
@.str.1010 = private unnamed_addr constant [46 x i8] c"androidx/appcompat/app/ActionBar$LayoutParams\00", align 1
@.str.1011 = private unnamed_addr constant [58 x i8] c"androidx/appcompat/app/ActionBar$OnMenuVisibilityListener\00", align 1
@.str.1012 = private unnamed_addr constant [74 x i8] c"mono/androidx/appcompat/app/ActionBar_OnMenuVisibilityListenerImplementor\00", align 1
@.str.1013 = private unnamed_addr constant [54 x i8] c"androidx/appcompat/app/ActionBar$OnNavigationListener\00", align 1
@.str.1014 = private unnamed_addr constant [37 x i8] c"androidx/appcompat/app/ActionBar$Tab\00", align 1
@.str.1015 = private unnamed_addr constant [45 x i8] c"androidx/appcompat/app/ActionBar$TabListener\00", align 1
@.str.1016 = private unnamed_addr constant [45 x i8] c"androidx/appcompat/app/ActionBarDrawerToggle\00", align 1
@.str.1017 = private unnamed_addr constant [54 x i8] c"androidx/appcompat/app/ActionBarDrawerToggle$Delegate\00", align 1
@.str.1018 = private unnamed_addr constant [41 x i8] c"androidx/appcompat/app/AppCompatActivity\00", align 1
@.str.1019 = private unnamed_addr constant [41 x i8] c"androidx/appcompat/app/AppCompatDelegate\00", align 1
@.str.1020 = private unnamed_addr constant [39 x i8] c"androidx/appcompat/app/AppCompatDialog\00", align 1
@.str.1021 = private unnamed_addr constant [41 x i8] c"androidx/appcompat/app/AppCompatCallback\00", align 1
@.str.1022 = private unnamed_addr constant [34 x i8] c"androidx/appcompat/widget/Toolbar\00", align 1
@.str.1023 = private unnamed_addr constant [67 x i8] c"androidx/appcompat/widget/Toolbar_NavigationOnClickEventDispatcher\00", align 1
@.str.1024 = private unnamed_addr constant [47 x i8] c"androidx/appcompat/widget/Toolbar$LayoutParams\00", align 1
@.str.1025 = private unnamed_addr constant [58 x i8] c"androidx/appcompat/widget/Toolbar$OnMenuItemClickListener\00", align 1
@.str.1026 = private unnamed_addr constant [74 x i8] c"mono/androidx/appcompat/widget/Toolbar_OnMenuItemClickListenerImplementor\00", align 1
@.str.1027 = private unnamed_addr constant [56 x i8] c"androidx/appcompat/widget/AppCompatAutoCompleteTextView\00", align 1
@.str.1028 = private unnamed_addr constant [42 x i8] c"androidx/appcompat/widget/AppCompatButton\00", align 1
@.str.1029 = private unnamed_addr constant [44 x i8] c"androidx/appcompat/widget/AppCompatCheckBox\00", align 1
@.str.1030 = private unnamed_addr constant [44 x i8] c"androidx/appcompat/widget/AppCompatEditText\00", align 1
@.str.1031 = private unnamed_addr constant [47 x i8] c"androidx/appcompat/widget/AppCompatImageButton\00", align 1
@.str.1032 = private unnamed_addr constant [45 x i8] c"androidx/appcompat/widget/AppCompatImageView\00", align 1
@.str.1033 = private unnamed_addr constant [47 x i8] c"androidx/appcompat/widget/AppCompatRadioButton\00", align 1
@.str.1034 = private unnamed_addr constant [44 x i8] c"androidx/appcompat/widget/AppCompatTextView\00", align 1
@.str.1035 = private unnamed_addr constant [45 x i8] c"androidx/appcompat/widget/ContentFrameLayout\00", align 1
@.str.1036 = private unnamed_addr constant [62 x i8] c"androidx/appcompat/widget/ContentFrameLayout$OnAttachListener\00", align 1
@.str.1037 = private unnamed_addr constant [78 x i8] c"mono/androidx/appcompat/widget/ContentFrameLayout_OnAttachListenerImplementor\00", align 1
@.str.1038 = private unnamed_addr constant [39 x i8] c"androidx/appcompat/widget/DecorToolbar\00", align 1
@.str.1039 = private unnamed_addr constant [45 x i8] c"androidx/appcompat/widget/LinearLayoutCompat\00", align 1
@.str.1040 = private unnamed_addr constant [58 x i8] c"androidx/appcompat/widget/LinearLayoutCompat$LayoutParams\00", align 1
@.str.1041 = private unnamed_addr constant [52 x i8] c"androidx/appcompat/widget/ScrollingTabContainerView\00", align 1
@.str.1042 = private unnamed_addr constant [75 x i8] c"androidx/appcompat/widget/ScrollingTabContainerView$VisibilityAnimListener\00", align 1
@.str.1043 = private unnamed_addr constant [37 x i8] c"androidx/appcompat/widget/SearchView\00", align 1
@.str.1044 = private unnamed_addr constant [53 x i8] c"androidx/appcompat/widget/SearchView$OnCloseListener\00", align 1
@.str.1045 = private unnamed_addr constant [69 x i8] c"mono/androidx/appcompat/widget/SearchView_OnCloseListenerImplementor\00", align 1
@.str.1046 = private unnamed_addr constant [57 x i8] c"androidx/appcompat/widget/SearchView$OnQueryTextListener\00", align 1
@.str.1047 = private unnamed_addr constant [73 x i8] c"mono/androidx/appcompat/widget/SearchView_OnQueryTextListenerImplementor\00", align 1
@.str.1048 = private unnamed_addr constant [58 x i8] c"androidx/appcompat/widget/SearchView$OnSuggestionListener\00", align 1
@.str.1049 = private unnamed_addr constant [74 x i8] c"mono/androidx/appcompat/widget/SearchView_OnSuggestionListenerImplementor\00", align 1
@.str.1050 = private unnamed_addr constant [39 x i8] c"androidx/appcompat/widget/SwitchCompat\00", align 1
@.str.1051 = private unnamed_addr constant [41 x i8] c"androidx/appcompat/widget/TintTypedArray\00", align 1
@.str.1052 = private unnamed_addr constant [40 x i8] c"androidx/appcompat/widget/TooltipCompat\00", align 1
@.str.1053 = private unnamed_addr constant [35 x i8] c"androidx/appcompat/view/ActionMode\00", align 1
@.str.1054 = private unnamed_addr constant [44 x i8] c"androidx/appcompat/view/ActionMode$Callback\00", align 1
@.str.1055 = private unnamed_addr constant [41 x i8] c"androidx/appcompat/view/menu/MenuBuilder\00", align 1
@.str.1056 = private unnamed_addr constant [50 x i8] c"androidx/appcompat/view/menu/MenuBuilder$Callback\00", align 1
@.str.1057 = private unnamed_addr constant [52 x i8] c"androidx/appcompat/view/menu/MenuPresenter$Callback\00", align 1
@.str.1058 = private unnamed_addr constant [43 x i8] c"androidx/appcompat/view/menu/MenuPresenter\00", align 1
@.str.1059 = private unnamed_addr constant [38 x i8] c"androidx/appcompat/view/menu/MenuView\00", align 1
@.str.1060 = private unnamed_addr constant [42 x i8] c"androidx/appcompat/view/menu/MenuItemImpl\00", align 1
@.str.1061 = private unnamed_addr constant [44 x i8] c"androidx/appcompat/view/menu/SubMenuBuilder\00", align 1
@.str.1062 = private unnamed_addr constant [46 x i8] c"kotlinx/serialization/DeserializationStrategy\00", align 1
@.str.1063 = private unnamed_addr constant [34 x i8] c"kotlinx/serialization/KSerializer\00", align 1
@.str.1064 = private unnamed_addr constant [44 x i8] c"kotlinx/serialization/SerializationStrategy\00", align 1
@.str.1065 = private unnamed_addr constant [58 x i8] c"kotlinx/serialization/encoding/CompositeDecoder$Companion\00", align 1
@.str.1066 = private unnamed_addr constant [48 x i8] c"kotlinx/serialization/encoding/CompositeDecoder\00", align 1
@.str.1067 = private unnamed_addr constant [48 x i8] c"kotlinx/serialization/encoding/CompositeEncoder\00", align 1
@.str.1068 = private unnamed_addr constant [39 x i8] c"kotlinx/serialization/encoding/Decoder\00", align 1
@.str.1069 = private unnamed_addr constant [39 x i8] c"kotlinx/serialization/encoding/Encoder\00", align 1
@.str.1070 = private unnamed_addr constant [51 x i8] c"kotlinx/serialization/descriptors/SerialDescriptor\00", align 1
@.str.1071 = private unnamed_addr constant [45 x i8] c"kotlinx/serialization/descriptors/SerialKind\00", align 1
@.str.1072 = private unnamed_addr constant [31 x i8] c"androidx/loader/content/Loader\00", align 1
@.str.1073 = private unnamed_addr constant [54 x i8] c"androidx/loader/content/Loader$OnLoadCanceledListener\00", align 1
@.str.1074 = private unnamed_addr constant [54 x i8] c"androidx/loader/content/Loader$OnLoadCompleteListener\00", align 1
@.str.1075 = private unnamed_addr constant [34 x i8] c"androidx/loader/app/LoaderManager\00", align 1
@.str.1076 = private unnamed_addr constant [50 x i8] c"androidx/loader/app/LoaderManager$LoaderCallbacks\00", align 1
@.str.1077 = private unnamed_addr constant [43 x i8] c"androidx/navigation/ui/AppBarConfiguration\00", align 1
@.str.1078 = private unnamed_addr constant [51 x i8] c"androidx/navigation/ui/AppBarConfiguration$Builder\00", align 1
@.str.1079 = private unnamed_addr constant [64 x i8] c"androidx/navigation/ui/AppBarConfiguration$OnNavigateUpListener\00", align 1
@.str.1080 = private unnamed_addr constant [36 x i8] c"androidx/navigation/ui/NavigationUI\00", align 1
@.str.1081 = private unnamed_addr constant [36 x i8] c"androidx/customview/widget/Openable\00", align 1
@.str.1082 = private unnamed_addr constant [47 x i8] c"androidx/navigation/fragment/FragmentNavigator\00", align 1
@.str.1083 = private unnamed_addr constant [59 x i8] c"androidx/navigation/fragment/FragmentNavigator$Destination\00", align 1
@.str.1084 = private unnamed_addr constant [45 x i8] c"androidx/navigation/fragment/NavHostFragment\00", align 1
@.str.1085 = private unnamed_addr constant [38 x i8] c"crc64159f3caeb1269279/MauiDrawingView\00", align 1
@.str.1086 = private unnamed_addr constant [32 x i8] c"crc64159f3caeb1269279/MauiPopup\00", align 1
@.str.1087 = private unnamed_addr constant [44 x i8] c"crc64159f3caeb1269279/MauiSemanticOrderView\00", align 1
@.str.1088 = private unnamed_addr constant [37 x i8] c"androidx/biometric/BiometricFragment\00", align 1
@.str.1089 = private unnamed_addr constant [36 x i8] c"androidx/biometric/BiometricManager\00", align 1
@.str.1090 = private unnamed_addr constant [51 x i8] c"androidx/biometric/BiometricManager$Authenticators\00", align 1
@.str.1091 = private unnamed_addr constant [35 x i8] c"androidx/biometric/BiometricPrompt\00", align 1
@.str.1092 = private unnamed_addr constant [58 x i8] c"androidx/biometric/BiometricPrompt$AuthenticationCallback\00", align 1
@.str.1093 = private unnamed_addr constant [56 x i8] c"androidx/biometric/BiometricPrompt$AuthenticationResult\00", align 1
@.str.1094 = private unnamed_addr constant [48 x i8] c"androidx/biometric/BiometricPrompt$CryptoObject\00", align 1
@.str.1095 = private unnamed_addr constant [46 x i8] c"androidx/biometric/BiometricPrompt$PromptInfo\00", align 1
@.str.1096 = private unnamed_addr constant [54 x i8] c"androidx/biometric/BiometricPrompt$PromptInfo$Builder\00", align 1
@.str.1097 = private unnamed_addr constant [38 x i8] c"androidx/biometric/BiometricViewModel\00", align 1
@.str.1098 = private unnamed_addr constant [45 x i8] c"androidx/biometric/FingerprintDialogFragment\00", align 1
@.str.1099 = private unnamed_addr constant [39 x i8] c"androidx/savedstate/SavedStateRegistry\00", align 1
@.str.1100 = private unnamed_addr constant [58 x i8] c"androidx/savedstate/SavedStateRegistry$SavedStateProvider\00", align 1
@.str.1101 = private unnamed_addr constant [55 x i8] c"crc64f728827fec74e9c3/TapWindowTracker_GestureListener\00", align 1
@.str.1102 = private unnamed_addr constant [40 x i8] c"crc64f728827fec74e9c3/Toolbar_Container\00", align 1
@.str.1103 = private unnamed_addr constant [48 x i8] c"crc64338477404e88479c/ColorChangeRevealDrawable\00", align 1
@.str.1104 = private unnamed_addr constant [52 x i8] c"crc64338477404e88479c/ControlsAccessibilityDelegate\00", align 1
@.str.1105 = private unnamed_addr constant [48 x i8] c"crc64338477404e88479c/DragAndDropGestureHandler\00", align 1
@.str.1106 = private unnamed_addr constant [69 x i8] c"crc64338477404e88479c/DragAndDropGestureHandler_CustomLocalStateData\00", align 1
@.str.1107 = private unnamed_addr constant [66 x i8] c"crc64338477404e88479c/ToolbarExtensions_ToolbarTitleIconImageView\00", align 1
@.str.1108 = private unnamed_addr constant [40 x i8] c"crc64338477404e88479c/FragmentContainer\00", align 1
@.str.1109 = private unnamed_addr constant [46 x i8] c"crc64338477404e88479c/GenericAnimatorListener\00", align 1
@.str.1110 = private unnamed_addr constant [50 x i8] c"crc64338477404e88479c/GenericGlobalLayoutListener\00", align 1
@.str.1111 = private unnamed_addr constant [47 x i8] c"crc64338477404e88479c/GenericMenuClickListener\00", align 1
@.str.1112 = private unnamed_addr constant [45 x i8] c"crc64338477404e88479c/GradientStrokeDrawable\00", align 1
@.str.1113 = private unnamed_addr constant [43 x i8] c"crc64338477404e88479c/InnerGestureListener\00", align 1
@.str.1114 = private unnamed_addr constant [41 x i8] c"crc64338477404e88479c/InnerScaleListener\00", align 1
@.str.1115 = private unnamed_addr constant [36 x i8] c"crc64338477404e88479c/MauiViewPager\00", align 1
@.str.1116 = private unnamed_addr constant [54 x i8] c"crc64338477404e88479c/MultiPageFragmentStateAdapter_1\00", align 1
@.str.1117 = private unnamed_addr constant [44 x i8] c"crc64338477404e88479c/PointerGestureHandler\00", align 1
@.str.1118 = private unnamed_addr constant [47 x i8] c"crc64338477404e88479c/TapAndPanGestureDetector\00", align 1
@.str.1119 = private unnamed_addr constant [59 x i8] c"crc64338477404e88479c/ModalNavigationManager_ModalFragment\00", align 1
@.str.1120 = private unnamed_addr constant [81 x i8] c"crc64338477404e88479c/ModalNavigationManager_ModalFragment_CustomComponentDialog\00", align 1
@.str.1121 = private unnamed_addr constant [90 x i8] c"crc64338477404e88479c/ModalNavigationManager_ModalFragment_CustomComponentDialog_CallBack\00", align 1
@.str.1122 = private unnamed_addr constant [36 x i8] c"crc640ec207abc449b2ca/ContainerView\00", align 1
@.str.1123 = private unnamed_addr constant [40 x i8] c"crc640ec207abc449b2ca/CustomFrameLayout\00", align 1
@.str.1124 = private unnamed_addr constant [43 x i8] c"crc640ec207abc449b2ca/ShellContentFragment\00", align 1
@.str.1125 = private unnamed_addr constant [40 x i8] c"crc640ec207abc449b2ca/ShellFlyoutLayout\00", align 1
@.str.1126 = private unnamed_addr constant [49 x i8] c"crc640ec207abc449b2ca/ShellFlyoutRecyclerAdapter\00", align 1
@.str.1127 = private unnamed_addr constant [67 x i8] c"crc640ec207abc449b2ca/ShellFlyoutRecyclerAdapter_ShellLinearLayout\00", align 1
@.str.1128 = private unnamed_addr constant [67 x i8] c"crc640ec207abc449b2ca/ShellFlyoutRecyclerAdapter_ElementViewHolder\00", align 1
@.str.1129 = private unnamed_addr constant [42 x i8] c"crc640ec207abc449b2ca/ShellFlyoutRenderer\00", align 1
@.str.1130 = private unnamed_addr constant [58 x i8] c"crc640ec207abc449b2ca/ShellFlyoutTemplatedContentRenderer\00", align 1
@.str.1131 = private unnamed_addr constant [74 x i8] c"crc640ec207abc449b2ca/ShellFlyoutTemplatedContentRenderer_HeaderContainer\00", align 1
@.str.1132 = private unnamed_addr constant [44 x i8] c"crc640ec207abc449b2ca/RecyclerViewContainer\00", align 1
@.str.1133 = private unnamed_addr constant [42 x i8] c"crc640ec207abc449b2ca/ScrollLayoutManager\00", align 1
@.str.1134 = private unnamed_addr constant [45 x i8] c"crc640ec207abc449b2ca/ShellFragmentContainer\00", align 1
@.str.1135 = private unnamed_addr constant [48 x i8] c"crc640ec207abc449b2ca/ShellFragmentStateAdapter\00", align 1
@.str.1136 = private unnamed_addr constant [40 x i8] c"crc640ec207abc449b2ca/ShellItemRenderer\00", align 1
@.str.1137 = private unnamed_addr constant [44 x i8] c"crc640ec207abc449b2ca/ShellItemRendererBase\00", align 1
@.str.1138 = private unnamed_addr constant [41 x i8] c"crc640ec207abc449b2ca/ShellPageContainer\00", align 1
@.str.1139 = private unnamed_addr constant [38 x i8] c"crc640ec207abc449b2ca/ShellSearchView\00", align 1
@.str.1140 = private unnamed_addr constant [58 x i8] c"crc640ec207abc449b2ca/ShellSearchView_ClipDrawableWrapper\00", align 1
@.str.1141 = private unnamed_addr constant [45 x i8] c"crc640ec207abc449b2ca/ShellSearchViewAdapter\00", align 1
@.str.1142 = private unnamed_addr constant [58 x i8] c"crc640ec207abc449b2ca/ShellSearchViewAdapter_CustomFilter\00", align 1
@.str.1143 = private unnamed_addr constant [59 x i8] c"crc640ec207abc449b2ca/ShellSearchViewAdapter_ObjectWrapper\00", align 1
@.str.1144 = private unnamed_addr constant [43 x i8] c"crc640ec207abc449b2ca/ShellSectionRenderer\00", align 1
@.str.1145 = private unnamed_addr constant [64 x i8] c"crc640ec207abc449b2ca/ShellSectionRenderer_ViewPagerPageChanged\00", align 1
@.str.1146 = private unnamed_addr constant [42 x i8] c"crc640ec207abc449b2ca/ShellToolbarTracker\00", align 1
@.str.1147 = private unnamed_addr constant [67 x i8] c"crc640ec207abc449b2ca/ShellToolbarTracker_FlyoutIconDrawerDrawable\00", align 1
@.str.1148 = private unnamed_addr constant [49 x i8] c"crc649ff77a65592e7d55/TabbedPageManager_TempView\00", align 1
@.str.1149 = private unnamed_addr constant [50 x i8] c"crc649ff77a65592e7d55/TabbedPageManager_Listeners\00", align 1
@.str.1150 = private unnamed_addr constant [44 x i8] c"crc645d80431ce5f73f11/CarouselViewAdapter_2\00", align 1
@.str.1151 = private unnamed_addr constant [39 x i8] c"crc645d80431ce5f73f11/EmptyViewAdapter\00", align 1
@.str.1152 = private unnamed_addr constant [50 x i8] c"crc645d80431ce5f73f11/GroupableItemsViewAdapter_2\00", align 1
@.str.1153 = private unnamed_addr constant [41 x i8] c"crc645d80431ce5f73f11/ItemsViewAdapter_2\00", align 1
@.str.1154 = private unnamed_addr constant [52 x i8] c"crc645d80431ce5f73f11/ReorderableItemsViewAdapter_2\00", align 1
@.str.1155 = private unnamed_addr constant [51 x i8] c"crc645d80431ce5f73f11/SelectableItemsViewAdapter_2\00", align 1
@.str.1156 = private unnamed_addr constant [51 x i8] c"crc645d80431ce5f73f11/StructuredItemsViewAdapter_2\00", align 1
@.str.1157 = private unnamed_addr constant [52 x i8] c"crc645d80431ce5f73f11/CarouselSpacingItemDecoration\00", align 1
@.str.1158 = private unnamed_addr constant [51 x i8] c"crc645d80431ce5f73f11/CarouselViewOnScrollListener\00", align 1
@.str.1159 = private unnamed_addr constant [41 x i8] c"crc645d80431ce5f73f11/DataChangeObserver\00", align 1
@.str.1160 = private unnamed_addr constant [47 x i8] c"crc645d80431ce5f73f11/GridLayoutSpanSizeLookup\00", align 1
@.str.1161 = private unnamed_addr constant [38 x i8] c"crc645d80431ce5f73f11/ItemContentView\00", align 1
@.str.1162 = private unnamed_addr constant [47 x i8] c"crc645d80431ce5f73f11/MauiCarouselRecyclerView\00", align 1
@.str.1163 = private unnamed_addr constant [82 x i8] c"crc645d80431ce5f73f11/MauiCarouselRecyclerView_CarouselViewOnGlobalLayoutListener\00", align 1
@.str.1164 = private unnamed_addr constant [41 x i8] c"crc645d80431ce5f73f11/MauiRecyclerView_3\00", align 1
@.str.1165 = private unnamed_addr constant [47 x i8] c"crc645d80431ce5f73f11/PositionalSmoothScroller\00", align 1
@.str.1166 = private unnamed_addr constant [51 x i8] c"crc645d80431ce5f73f11/RecyclerViewScrollListener_2\00", align 1
@.str.1167 = private unnamed_addr constant [35 x i8] c"crc645d80431ce5f73f11/ScrollHelper\00", align 1
@.str.1168 = private unnamed_addr constant [43 x i8] c"crc645d80431ce5f73f11/SelectableViewHolder\00", align 1
@.str.1169 = private unnamed_addr constant [52 x i8] c"crc645d80431ce5f73f11/SimpleItemTouchHelperCallback\00", align 1
@.str.1170 = private unnamed_addr constant [39 x i8] c"crc645d80431ce5f73f11/SimpleViewHolder\00", align 1
@.str.1171 = private unnamed_addr constant [43 x i8] c"crc645d80431ce5f73f11/SizedItemContentView\00", align 1
@.str.1172 = private unnamed_addr constant [39 x i8] c"crc645d80431ce5f73f11/CenterSnapHelper\00", align 1
@.str.1173 = private unnamed_addr constant [37 x i8] c"crc645d80431ce5f73f11/EdgeSnapHelper\00", align 1
@.str.1174 = private unnamed_addr constant [42 x i8] c"crc645d80431ce5f73f11/EndSingleSnapHelper\00", align 1
@.str.1175 = private unnamed_addr constant [36 x i8] c"crc645d80431ce5f73f11/EndSnapHelper\00", align 1
@.str.1176 = private unnamed_addr constant [42 x i8] c"crc645d80431ce5f73f11/NongreedySnapHelper\00", align 1
@.str.1177 = private unnamed_addr constant [64 x i8] c"crc645d80431ce5f73f11/NongreedySnapHelper_InitialScrollListener\00", align 1
@.str.1178 = private unnamed_addr constant [39 x i8] c"crc645d80431ce5f73f11/SingleSnapHelper\00", align 1
@.str.1179 = private unnamed_addr constant [44 x i8] c"crc645d80431ce5f73f11/StartSingleSnapHelper\00", align 1
@.str.1180 = private unnamed_addr constant [38 x i8] c"crc645d80431ce5f73f11/StartSnapHelper\00", align 1
@.str.1181 = private unnamed_addr constant [44 x i8] c"crc645d80431ce5f73f11/SpacingItemDecoration\00", align 1
@.str.1182 = private unnamed_addr constant [46 x i8] c"crc645d80431ce5f73f11/TemplatedItemViewHolder\00", align 1
@.str.1183 = private unnamed_addr constant [37 x i8] c"crc645d80431ce5f73f11/TextViewHolder\00", align 1
@.str.1184 = private unnamed_addr constant [36 x i8] c"crc64e1fb321c08285b90/FrameRenderer\00", align 1
@.str.1185 = private unnamed_addr constant [35 x i8] c"crc64e1fb321c08285b90/ViewRenderer\00", align 1
@.str.1186 = private unnamed_addr constant [37 x i8] c"crc64e1fb321c08285b90/ViewRenderer_2\00", align 1
@.str.1187 = private unnamed_addr constant [46 x i8] c"crc64e1fb321c08285b90/VisualElementRenderer_1\00", align 1
@.str.1188 = private unnamed_addr constant [35 x i8] c"crc64e1fb321c08285b90/BaseCellView\00", align 1
@.str.1189 = private unnamed_addr constant [34 x i8] c"crc64e1fb321c08285b90/CellAdapter\00", align 1
@.str.1190 = private unnamed_addr constant [50 x i8] c"crc64e1fb321c08285b90/CellRenderer_RendererHolder\00", align 1
@.str.1191 = private unnamed_addr constant [45 x i8] c"crc64e1fb321c08285b90/ConditionalFocusLayout\00", align 1
@.str.1192 = private unnamed_addr constant [40 x i8] c"crc64e1fb321c08285b90/EntryCellEditText\00", align 1
@.str.1193 = private unnamed_addr constant [36 x i8] c"crc64e1fb321c08285b90/EntryCellView\00", align 1
@.str.1194 = private unnamed_addr constant [45 x i8] c"crc64e1fb321c08285b90/GroupedListViewAdapter\00", align 1
@.str.1195 = private unnamed_addr constant [38 x i8] c"crc64e1fb321c08285b90/ListViewAdapter\00", align 1
@.str.1196 = private unnamed_addr constant [39 x i8] c"crc64e1fb321c08285b90/ListViewRenderer\00", align 1
@.str.1197 = private unnamed_addr constant [49 x i8] c"crc64e1fb321c08285b90/ListViewRenderer_Container\00", align 1
@.str.1198 = private unnamed_addr constant [82 x i8] c"crc64e1fb321c08285b90/ListViewRenderer_SwipeRefreshLayoutWithFixedNestedScrolling\00", align 1
@.str.1199 = private unnamed_addr constant [74 x i8] c"crc64e1fb321c08285b90/ListViewRenderer_ListViewSwipeRefreshLayoutListener\00", align 1
@.str.1200 = private unnamed_addr constant [62 x i8] c"crc64e1fb321c08285b90/ListViewRenderer_ListViewScrollDetector\00", align 1
@.str.1201 = private unnamed_addr constant [37 x i8] c"crc64e1fb321c08285b90/SwitchCellView\00", align 1
@.str.1202 = private unnamed_addr constant [52 x i8] c"crc64e1fb321c08285b90/TextCellRenderer_TextCellView\00", align 1
@.str.1203 = private unnamed_addr constant [57 x i8] c"crc64e1fb321c08285b90/ViewCellRenderer_ViewCellContainer\00", align 1
@.str.1204 = private unnamed_addr constant [76 x i8] c"crc64e1fb321c08285b90/ViewCellRenderer_ViewCellContainer_TapGestureListener\00", align 1
@.str.1205 = private unnamed_addr constant [82 x i8] c"crc64e1fb321c08285b90/ViewCellRenderer_ViewCellContainer_LongPressGestureListener\00", align 1
@.str.1206 = private unnamed_addr constant [45 x i8] c"crc64e1fb321c08285b90/TableViewModelRenderer\00", align 1
@.str.1207 = private unnamed_addr constant [40 x i8] c"crc64e1fb321c08285b90/TableViewRenderer\00", align 1
@.str.1208 = private unnamed_addr constant [48 x i8] c"com/google/crypto/tink/shaded/protobuf/Internal\00", align 1
@.str.1209 = private unnamed_addr constant [60 x i8] c"com/google/crypto/tink/shaded/protobuf/Internal$BooleanList\00", align 1
@.str.1210 = private unnamed_addr constant [59 x i8] c"com/google/crypto/tink/shaded/protobuf/Internal$DoubleList\00", align 1
@.str.1211 = private unnamed_addr constant [57 x i8] c"com/google/crypto/tink/shaded/protobuf/Internal$EnumLite\00", align 1
@.str.1212 = private unnamed_addr constant [60 x i8] c"com/google/crypto/tink/shaded/protobuf/Internal$EnumLiteMap\00", align 1
@.str.1213 = private unnamed_addr constant [58 x i8] c"com/google/crypto/tink/shaded/protobuf/Internal$FloatList\00", align 1
@.str.1214 = private unnamed_addr constant [56 x i8] c"com/google/crypto/tink/shaded/protobuf/Internal$IntList\00", align 1
@.str.1215 = private unnamed_addr constant [57 x i8] c"com/google/crypto/tink/shaded/protobuf/Internal$LongList\00", align 1
@.str.1216 = private unnamed_addr constant [61 x i8] c"com/google/crypto/tink/shaded/protobuf/Internal$ProtobufList\00", align 1
@.str.1217 = private unnamed_addr constant [59 x i8] c"com/google/crypto/tink/shaded/protobuf/AbstractMessageLite\00", align 1
@.str.1218 = private unnamed_addr constant [50 x i8] c"com/google/crypto/tink/shaded/protobuf/ByteOutput\00", align 1
@.str.1219 = private unnamed_addr constant [50 x i8] c"com/google/crypto/tink/shaded/protobuf/ByteString\00", align 1
@.str.1220 = private unnamed_addr constant [57 x i8] c"com/google/crypto/tink/shaded/protobuf/ByteString$Output\00", align 1
@.str.1221 = private unnamed_addr constant [56 x i8] c"com/google/crypto/tink/shaded/protobuf/CodedInputStream\00", align 1
@.str.1222 = private unnamed_addr constant [57 x i8] c"com/google/crypto/tink/shaded/protobuf/CodedOutputStream\00", align 1
@.str.1223 = private unnamed_addr constant [53 x i8] c"com/google/crypto/tink/shaded/protobuf/ExtensionLite\00", align 1
@.str.1224 = private unnamed_addr constant [61 x i8] c"com/google/crypto/tink/shaded/protobuf/ExtensionRegistryLite\00", align 1
@.str.1225 = private unnamed_addr constant [60 x i8] c"com/google/crypto/tink/shaded/protobuf/GeneratedMessageLite\00", align 1
@.str.1226 = private unnamed_addr constant [79 x i8] c"com/google/crypto/tink/shaded/protobuf/GeneratedMessageLite$GeneratedExtension\00", align 1
@.str.1227 = private unnamed_addr constant [75 x i8] c"com/google/crypto/tink/shaded/protobuf/GeneratedMessageLite$MethodToInvoke\00", align 1
@.str.1228 = private unnamed_addr constant [59 x i8] c"com/google/crypto/tink/shaded/protobuf/MessageLite$Builder\00", align 1
@.str.1229 = private unnamed_addr constant [51 x i8] c"com/google/crypto/tink/shaded/protobuf/MessageLite\00", align 1
@.str.1230 = private unnamed_addr constant [60 x i8] c"com/google/crypto/tink/shaded/protobuf/MessageLiteOrBuilder\00", align 1
@.str.1231 = private unnamed_addr constant [70 x i8] c"com/google/crypto/tink/shaded/protobuf/InvalidProtocolBufferException\00", align 1
@.str.1232 = private unnamed_addr constant [46 x i8] c"com/google/crypto/tink/shaded/protobuf/Parser\00", align 1
@.str.1233 = private unnamed_addr constant [53 x i8] c"com/google/crypto/tink/shaded/protobuf/LazyFieldLite\00", align 1
@.str.1234 = private unnamed_addr constant [59 x i8] c"com/google/crypto/tink/shaded/protobuf/UnknownFieldSetLite\00", align 1
@.str.1235 = private unnamed_addr constant [50 x i8] c"com/google/crypto/tink/shaded/protobuf/WireFormat\00", align 1
@.str.1236 = private unnamed_addr constant [60 x i8] c"com/google/crypto/tink/shaded/protobuf/WireFormat$FieldType\00", align 1
@.str.1237 = private unnamed_addr constant [59 x i8] c"com/google/crypto/tink/shaded/protobuf/WireFormat$JavaType\00", align 1
@.str.1238 = private unnamed_addr constant [34 x i8] c"androidx/navigation/NavDirections\00", align 1
@.str.1239 = private unnamed_addr constant [46 x i8] c"androidx/navigation/NavViewModelStoreProvider\00", align 1
@.str.1240 = private unnamed_addr constant [30 x i8] c"androidx/navigation/NavAction\00", align 1
@.str.1241 = private unnamed_addr constant [32 x i8] c"androidx/navigation/NavArgument\00", align 1
@.str.1242 = private unnamed_addr constant [38 x i8] c"androidx/navigation/NavBackStackEntry\00", align 1
@.str.1243 = private unnamed_addr constant [32 x i8] c"androidx/navigation/NavDeepLink\00", align 1
@.str.1244 = private unnamed_addr constant [39 x i8] c"androidx/navigation/NavDeepLinkRequest\00", align 1
@.str.1245 = private unnamed_addr constant [35 x i8] c"androidx/navigation/NavDestination\00", align 1
@.str.1246 = private unnamed_addr constant [49 x i8] c"androidx/navigation/NavDestination$DeepLinkMatch\00", align 1
@.str.1247 = private unnamed_addr constant [29 x i8] c"androidx/navigation/NavGraph\00", align 1
@.str.1248 = private unnamed_addr constant [38 x i8] c"androidx/navigation/NavGraphNavigator\00", align 1
@.str.1249 = private unnamed_addr constant [30 x i8] c"androidx/navigation/Navigator\00", align 1
@.str.1250 = private unnamed_addr constant [37 x i8] c"androidx/navigation/Navigator$Extras\00", align 1
@.str.1251 = private unnamed_addr constant [38 x i8] c"androidx/navigation/NavigatorProvider\00", align 1
@.str.1252 = private unnamed_addr constant [35 x i8] c"androidx/navigation/NavigatorState\00", align 1
@.str.1253 = private unnamed_addr constant [31 x i8] c"androidx/navigation/NavOptions\00", align 1
@.str.1254 = private unnamed_addr constant [28 x i8] c"androidx/navigation/NavType\00", align 1
@.str.1255 = private unnamed_addr constant [39 x i8] c"androidx/fragment/app/FragmentActivity\00", align 1
@.str.1256 = private unnamed_addr constant [37 x i8] c"androidx/fragment/app/DialogFragment\00", align 1
@.str.1257 = private unnamed_addr constant [31 x i8] c"androidx/fragment/app/Fragment\00", align 1
@.str.1258 = private unnamed_addr constant [42 x i8] c"androidx/fragment/app/Fragment$SavedState\00", align 1
@.str.1259 = private unnamed_addr constant [40 x i8] c"androidx/fragment/app/FragmentContainer\00", align 1
@.str.1260 = private unnamed_addr constant [44 x i8] c"androidx/fragment/app/FragmentContainerView\00", align 1
@.str.1261 = private unnamed_addr constant [38 x i8] c"androidx/fragment/app/FragmentFactory\00", align 1
@.str.1262 = private unnamed_addr constant [43 x i8] c"androidx/fragment/app/FragmentHostCallback\00", align 1
@.str.1263 = private unnamed_addr constant [38 x i8] c"androidx/fragment/app/FragmentManager\00", align 1
@.str.1264 = private unnamed_addr constant [53 x i8] c"androidx/fragment/app/FragmentManager$BackStackEntry\00", align 1
@.str.1265 = private unnamed_addr constant [65 x i8] c"androidx/fragment/app/FragmentManager$FragmentLifecycleCallbacks\00", align 1
@.str.1266 = private unnamed_addr constant [65 x i8] c"androidx/fragment/app/FragmentManager$OnBackStackChangedListener\00", align 1
@.str.1267 = private unnamed_addr constant [81 x i8] c"mono/androidx/fragment/app/FragmentManager_OnBackStackChangedListenerImplementor\00", align 1
@.str.1268 = private unnamed_addr constant [42 x i8] c"androidx/fragment/app/FragmentTransaction\00", align 1
@.str.1269 = private unnamed_addr constant [47 x i8] c"androidx/fragment/app/FragmentOnAttachListener\00", align 1
@.str.1270 = private unnamed_addr constant [63 x i8] c"mono/androidx/fragment/app/FragmentOnAttachListenerImplementor\00", align 1
@.str.1271 = private unnamed_addr constant [45 x i8] c"androidx/fragment/app/FragmentResultListener\00", align 1
@.str.1272 = private unnamed_addr constant [52 x i8] c"androidx/fragment/app/strictmode/FragmentStrictMode\00", align 1
@.str.1273 = private unnamed_addr constant [59 x i8] c"androidx/fragment/app/strictmode/FragmentStrictMode$Policy\00", align 1
@.str.1274 = private unnamed_addr constant [43 x i8] c"androidx/fragment/app/strictmode/Violation\00", align 1
@.str.1275 = private unnamed_addr constant [50 x i8] c"androidx/appcompat/content/res/AppCompatResources\00", align 1
@.str.1276 = private unnamed_addr constant [59 x i8] c"androidx/appcompat/graphics/drawable/DrawableWrapperCompat\00", align 1
@.str.1277 = private unnamed_addr constant [38 x i8] c"androidx/collection/SparseArrayCompat\00", align 1
@.str.1278 = private unnamed_addr constant [54 x i8] c"androidx/swiperefreshlayout/widget/SwipeRefreshLayout\00", align 1
@.str.1279 = private unnamed_addr constant [78 x i8] c"androidx/swiperefreshlayout/widget/SwipeRefreshLayout$OnChildScrollUpCallback\00", align 1
@.str.1280 = private unnamed_addr constant [72 x i8] c"androidx/swiperefreshlayout/widget/SwipeRefreshLayout$OnRefreshListener\00", align 1
@.str.1281 = private unnamed_addr constant [88 x i8] c"mono/androidx/swiperefreshlayout/widget/SwipeRefreshLayout_OnRefreshListenerImplementor\00", align 1
@.str.1282 = private unnamed_addr constant [34 x i8] c"androidx/cardview/widget/CardView\00", align 1

;TypeMapModule
@.TypeMapModule.0_assembly_name = private unnamed_addr constant [47 x i8] c"Xamarin.AndroidX.Lifecycle.ViewModelSavedState\00", align 1
@.TypeMapModule.1_assembly_name = private unnamed_addr constant [24 x i8] c"Syncfusion.Maui.Toolkit\00", align 1
@.TypeMapModule.2_assembly_name = private unnamed_addr constant [41 x i8] c"Xamarin.AndroidX.Lifecycle.LiveData.Core\00", align 1
@.TypeMapModule.3_assembly_name = private unnamed_addr constant [41 x i8] c"Xamarin.AndroidX.Security.SecurityCrypto\00", align 1
@.TypeMapModule.4_assembly_name = private unnamed_addr constant [27 x i8] c"Xamarin.AndroidX.ViewPager\00", align 1
@.TypeMapModule.5_assembly_name = private unnamed_addr constant [30 x i8] c"Xamarin.AndroidX.DrawerLayout\00", align 1
@.TypeMapModule.6_assembly_name = private unnamed_addr constant [22 x i8] c"Xamarin.Kotlin.StdLib\00", align 1
@.TypeMapModule.7_assembly_name = private unnamed_addr constant [35 x i8] c"Xamarin.AndroidX.CoordinatorLayout\00", align 1
@.TypeMapModule.8_assembly_name = private unnamed_addr constant [15 x i8] c"Microsoft.Maui\00", align 1
@.TypeMapModule.9_assembly_name = private unnamed_addr constant [24 x i8] c"Microsoft.Maui.Graphics\00", align 1
@.TypeMapModule.10_assembly_name = private unnamed_addr constant [25 x i8] c"Xamarin.AndroidX.Browser\00", align 1
@.TypeMapModule.11_assembly_name = private unnamed_addr constant [36 x i8] c"Xamarin.AndroidX.Navigation.Runtime\00", align 1
@.TypeMapModule.12_assembly_name = private unnamed_addr constant [38 x i8] c"Xamarin.AndroidX.Lifecycle.Common.Jvm\00", align 1
@.TypeMapModule.13_assembly_name = private unnamed_addr constant [45 x i8] c"Xamarin.AndroidX.Lifecycle.ViewModel.Android\00", align 1
@.TypeMapModule.14_assembly_name = private unnamed_addr constant [32 x i8] c"Xamarin.Google.Android.Material\00", align 1
@.TypeMapModule.15_assembly_name = private unnamed_addr constant [14 x i8] c"SocialMauiApp\00", align 1
@.TypeMapModule.16_assembly_name = private unnamed_addr constant [28 x i8] c"Xamarin.AndroidX.ViewPager2\00", align 1
@.TypeMapModule.17_assembly_name = private unnamed_addr constant [21 x i8] c"Syncfusion.Maui.Core\00", align 1
@.TypeMapModule.18_assembly_name = private unnamed_addr constant [30 x i8] c"Xamarin.AndroidX.RecyclerView\00", align 1
@.TypeMapModule.19_assembly_name = private unnamed_addr constant [26 x i8] c"Xamarin.AndroidX.Activity\00", align 1
@.TypeMapModule.20_assembly_name = private unnamed_addr constant [31 x i8] c"Xamarin.AndroidX.CursorAdapter\00", align 1
@.TypeMapModule.21_assembly_name = private unnamed_addr constant [22 x i8] c"Xamarin.AndroidX.Core\00", align 1
@.TypeMapModule.22_assembly_name = private unnamed_addr constant [36 x i8] c"Xamarin.KotlinX.Coroutines.Core.Jvm\00", align 1
@.TypeMapModule.23_assembly_name = private unnamed_addr constant [26 x i8] c"Microsoft.Maui.Essentials\00", align 1
@.TypeMapModule.24_assembly_name = private unnamed_addr constant [19 x i8] c"Plugin.Fingerprint\00", align 1
@.TypeMapModule.25_assembly_name = private unnamed_addr constant [27 x i8] c"Xamarin.AndroidX.AppCompat\00", align 1
@.TypeMapModule.26_assembly_name = private unnamed_addr constant [39 x i8] c"Xamarin.KotlinX.Serialization.Core.Jvm\00", align 1
@.TypeMapModule.27_assembly_name = private unnamed_addr constant [24 x i8] c"Xamarin.AndroidX.Loader\00", align 1
@.TypeMapModule.28_assembly_name = private unnamed_addr constant [31 x i8] c"Xamarin.AndroidX.Navigation.UI\00", align 1
@.TypeMapModule.29_assembly_name = private unnamed_addr constant [28 x i8] c"Xamarin.AndroidX.CustomView\00", align 1
@.TypeMapModule.30_assembly_name = private unnamed_addr constant [37 x i8] c"Xamarin.AndroidX.Navigation.Fragment\00", align 1
@.TypeMapModule.31_assembly_name = private unnamed_addr constant [27 x i8] c"CommunityToolkit.Maui.Core\00", align 1
@.TypeMapModule.32_assembly_name = private unnamed_addr constant [27 x i8] c"Xamarin.AndroidX.Biometric\00", align 1
@.TypeMapModule.33_assembly_name = private unnamed_addr constant [28 x i8] c"Xamarin.AndroidX.SavedState\00", align 1
@.TypeMapModule.34_assembly_name = private unnamed_addr constant [24 x i8] c"Microsoft.Maui.Controls\00", align 1
@.TypeMapModule.35_assembly_name = private unnamed_addr constant [35 x i8] c"Xamarin.Google.Crypto.Tink.Android\00", align 1
@.TypeMapModule.36_assembly_name = private unnamed_addr constant [13 x i8] c"Mono.Android\00", align 1
@.TypeMapModule.37_assembly_name = private unnamed_addr constant [35 x i8] c"Xamarin.AndroidX.Navigation.Common\00", align 1
@.TypeMapModule.38_assembly_name = private unnamed_addr constant [26 x i8] c"Xamarin.AndroidX.Fragment\00", align 1
@.TypeMapModule.39_assembly_name = private unnamed_addr constant [46 x i8] c"Xamarin.AndroidX.AppCompat.AppCompatResources\00", align 1
@.TypeMapModule.40_assembly_name = private unnamed_addr constant [32 x i8] c"Xamarin.AndroidX.Collection.Jvm\00", align 1
@.TypeMapModule.41_assembly_name = private unnamed_addr constant [36 x i8] c"Xamarin.AndroidX.SwipeRefreshLayout\00", align 1
@.TypeMapModule.42_assembly_name = private unnamed_addr constant [26 x i8] c"Xamarin.AndroidX.CardView\00", align 1

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
