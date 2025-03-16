; ModuleID = 'environment.arm64-v8a.ll'
source_filename = "environment.arm64-v8a.ll"
target datalayout = "e-m:e-i8:8:32-i16:16:32-i64:64-i128:128-n32:64-S128"
target triple = "aarch64-unknown-linux-android21"

%struct.ApplicationConfig = type {
	i1, ; bool uses_mono_llvm
	i1, ; bool uses_mono_aot
	i1, ; bool aot_lazy_load
	i1, ; bool uses_assembly_preload
	i1, ; bool broken_exception_transitions
	i1, ; bool jni_add_native_method_registration_attribute_present
	i1, ; bool have_runtime_config_blob
	i1, ; bool have_assemblies_blob
	i1, ; bool marshal_methods_enabled
	i1, ; bool ignore_split_configs
	i8, ; uint8_t bound_stream_io_exception_type
	i32, ; uint32_t package_naming_policy
	i32, ; uint32_t environment_variable_count
	i32, ; uint32_t system_property_count
	i32, ; uint32_t number_of_assemblies_in_apk
	i32, ; uint32_t bundled_assembly_name_width
	i32, ; uint32_t number_of_dso_cache_entries
	i32, ; uint32_t number_of_aot_cache_entries
	i32, ; uint32_t number_of_shared_libraries
	i32, ; uint32_t android_runtime_jnienv_class_token
	i32, ; uint32_t jnienv_initialize_method_token
	i32, ; uint32_t jnienv_registerjninatives_method_token
	i32, ; uint32_t jni_remapping_replacement_type_count
	i32, ; uint32_t jni_remapping_replacement_method_index_entry_count
	i32, ; uint32_t mono_components_mask
	ptr ; char* android_package_name
}

%struct.AssemblyStoreAssemblyDescriptor = type {
	i32, ; uint32_t data_offset
	i32, ; uint32_t data_size
	i32, ; uint32_t debug_data_offset
	i32, ; uint32_t debug_data_size
	i32, ; uint32_t config_data_offset
	i32 ; uint32_t config_data_size
}

%struct.AssemblyStoreRuntimeData = type {
	ptr, ; uint8_t data_start
	i32, ; uint32_t assembly_count
	i32, ; uint32_t index_entry_count
	ptr ; AssemblyStoreAssemblyDescriptor assemblies
}

%struct.AssemblyStoreSingleAssemblyRuntimeData = type {
	ptr, ; uint8_t image_data
	ptr, ; uint8_t debug_info_data
	ptr, ; uint8_t config_data
	ptr ; AssemblyStoreAssemblyDescriptor descriptor
}

%struct.DSOApkEntry = type {
	i64, ; uint64_t name_hash
	i32, ; uint32_t offset
	i32 ; int32_t fd
}

%struct.DSOCacheEntry = type {
	i64, ; uint64_t hash
	i64, ; uint64_t real_name_hash
	i1, ; bool ignore
	ptr, ; char* name
	ptr ; void* handle
}

%struct.XamarinAndroidBundledAssembly = type {
	i32, ; int32_t file_fd
	ptr, ; char* file_name
	i32, ; uint32_t data_offset
	i32, ; uint32_t data_size
	ptr, ; uint8_t data
	i32, ; uint32_t name_length
	ptr ; char* name
}

; 0x25e6972616d58
@format_tag = dso_local local_unnamed_addr constant i64 666756936985944, align 8

@mono_aot_mode_name = dso_local local_unnamed_addr constant ptr @.str.0, align 8

; Application environment variables array, name:value
@app_environment_variables = dso_local local_unnamed_addr constant [4 x ptr] [
	ptr @.env.0, ; 0
	ptr @.env.1, ; 1
	ptr @.env.2, ; 2
	ptr @.env.3 ; 3
], align 8

; System properties defined by the application
@app_system_properties = dso_local local_unnamed_addr constant [0 x ptr] zeroinitializer, align 8

@application_config = dso_local local_unnamed_addr constant %struct.ApplicationConfig {
	i1 false, ; bool uses_mono_llvm
	i1 true, ; bool uses_mono_aot
	i1 true, ; bool aot_lazy_load
	i1 false, ; bool uses_assembly_preload
	i1 false, ; bool broken_exception_transitions
	i1 false, ; bool jni_add_native_method_registration_attribute_present
	i1 true, ; bool have_runtime_config_blob
	i1 true, ; bool have_assemblies_blob
	i1 false, ; bool marshal_methods_enabled
	i1 false, ; bool ignore_split_configs
	i8 0, ; uint8_t bound_stream_io_exception_type
	i32 3, ; uint32_t package_naming_policy
	i32 4, ; uint32_t environment_variable_count
	i32 0, ; uint32_t system_property_count
	i32 254, ; uint32_t number_of_assemblies_in_apk
	i32 0, ; uint32_t bundled_assembly_name_width
	i32 36, ; uint32_t number_of_dso_cache_entries
	i32 1971, ; uint32_t number_of_aot_cache_entries
	i32 228, ; uint32_t number_of_shared_libraries
	i32 u0x02000328, ; uint32_t android_runtime_jnienv_class_token
	i32 u0x06001f4e, ; uint32_t jnienv_initialize_method_token
	i32 u0x06001f4d, ; uint32_t jnienv_registerjninatives_method_token
	i32 0, ; uint32_t jni_remapping_replacement_type_count
	i32 0, ; uint32_t jni_remapping_replacement_method_index_entry_count
	i32 u0x00000000, ; uint32_t mono_components_mask
	ptr @.ApplicationConfig.0_android_package_name; char* android_package_name
}, align 8

; DSO cache entries
@dso_cache = dso_local local_unnamed_addr global [36 x %struct.DSOCacheEntry] [
	%struct.DSOCacheEntry {
		i64 u0x01848c0093f0afd8, ; from name: libSystem.Security.Cryptography.Native.Android
		i64 u0x4818e42ca66bbd75, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.4_name, ; name: libSystem.Security.Cryptography.Native.Android.so
		ptr null; void* handle
	}, ; 0
	%struct.DSOCacheEntry {
		i64 u0x04bb981b3c3ff40f, ; from name: System.Security.Cryptography.Native.Android.so
		i64 u0x4818e42ca66bbd75, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.4_name, ; name: libSystem.Security.Cryptography.Native.Android.so
		ptr null; void* handle
	}, ; 1
	%struct.DSOCacheEntry {
		i64 u0x0582d422de762780, ; from name: libmono-component-marshal-ilgen.so
		i64 u0x0582d422de762780, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.5_name, ; name: libmono-component-marshal-ilgen.so
		ptr null; void* handle
	}, ; 2
	%struct.DSOCacheEntry {
		i64 u0x068244e5e79072bd, ; from name: libe_sqlite3
		i64 u0x69f1737e78a3229a, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.0_name, ; name: libe_sqlite3.so
		ptr null; void* handle
	}, ; 3
	%struct.DSOCacheEntry {
		i64 u0x07e1516b937259a4, ; from name: System.Globalization.Native.so
		i64 u0x74b568291c419777, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.1_name, ; name: libSystem.Globalization.Native.so
		ptr null; void* handle
	}, ; 4
	%struct.DSOCacheEntry {
		i64 u0x12e73d483788709d, ; from name: SkiaSharp.so
		i64 u0x43db119dcc3147fa, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.8_name, ; name: libSkiaSharp.so
		ptr null; void* handle
	}, ; 5
	%struct.DSOCacheEntry {
		i64 u0x18d2ba05358f7c3a, ; from name: e_sqlite3.so
		i64 u0x69f1737e78a3229a, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.0_name, ; name: libe_sqlite3.so
		ptr null; void* handle
	}, ; 6
	%struct.DSOCacheEntry {
		i64 u0x1a1918dd01662b19, ; from name: libmonosgen-2.0.so
		i64 u0x1a1918dd01662b19, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.6_name, ; name: libmonosgen-2.0.so
		ptr null; void* handle
	}, ; 7
	%struct.DSOCacheEntry {
		i64 u0x28b5c8fca080abd5, ; from name: libSystem.Globalization.Native
		i64 u0x74b568291c419777, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.1_name, ; name: libSystem.Globalization.Native.so
		ptr null; void* handle
	}, ; 8
	%struct.DSOCacheEntry {
		i64 u0x2b87bb6ac8822015, ; from name: libmonodroid
		i64 u0x4434c7fd110c8d8b, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.7_name, ; name: libmonodroid.so
		ptr null; void* handle
	}, ; 9
	%struct.DSOCacheEntry {
		i64 u0x3807dd20062deb45, ; from name: monodroid
		i64 u0x4434c7fd110c8d8b, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.7_name, ; name: libmonodroid.so
		ptr null; void* handle
	}, ; 10
	%struct.DSOCacheEntry {
		i64 u0x40f32024ffd1c0be, ; from name: System.IO.Compression.Native.so
		i64 u0xc3cb80650fe5a0ab, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.2_name, ; name: libSystem.IO.Compression.Native.so
		ptr null; void* handle
	}, ; 11
	%struct.DSOCacheEntry {
		i64 u0x43db119dcc3147fa, ; from name: libSkiaSharp.so
		i64 u0x43db119dcc3147fa, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.8_name, ; name: libSkiaSharp.so
		ptr null; void* handle
	}, ; 12
	%struct.DSOCacheEntry {
		i64 u0x4434c7fd110c8d8b, ; from name: libmonodroid.so
		i64 u0x4434c7fd110c8d8b, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.7_name, ; name: libmonodroid.so
		ptr null; void* handle
	}, ; 13
	%struct.DSOCacheEntry {
		i64 u0x4818e42ca66bbd75, ; from name: libSystem.Security.Cryptography.Native.Android.so
		i64 u0x4818e42ca66bbd75, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.4_name, ; name: libSystem.Security.Cryptography.Native.Android.so
		ptr null; void* handle
	}, ; 14
	%struct.DSOCacheEntry {
		i64 u0x4cd7bd0032e920e1, ; from name: libSystem.Native
		i64 u0xa337ccc8aef94267, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.3_name, ; name: libSystem.Native.so
		ptr null; void* handle
	}, ; 15
	%struct.DSOCacheEntry {
		i64 u0x4ecd24baaf5a9280, ; from name: e_sqlite3
		i64 u0x69f1737e78a3229a, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.0_name, ; name: libe_sqlite3.so
		ptr null; void* handle
	}, ; 16
	%struct.DSOCacheEntry {
		i64 u0x61c4cca6c77a9014, ; from name: libmonosgen-2.0
		i64 u0x1a1918dd01662b19, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.6_name, ; name: libmonosgen-2.0.so
		ptr null; void* handle
	}, ; 17
	%struct.DSOCacheEntry {
		i64 u0x69f1737e78a3229a, ; from name: libe_sqlite3.so
		i64 u0x69f1737e78a3229a, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.0_name, ; name: libe_sqlite3.so
		ptr null; void* handle
	}, ; 18
	%struct.DSOCacheEntry {
		i64 u0x74b568291c419777, ; from name: libSystem.Globalization.Native.so
		i64 u0x74b568291c419777, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.1_name, ; name: libSystem.Globalization.Native.so
		ptr null; void* handle
	}, ; 19
	%struct.DSOCacheEntry {
		i64 u0x81bc2b0b52670f30, ; from name: System.Security.Cryptography.Native.Android
		i64 u0x4818e42ca66bbd75, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.4_name, ; name: libSystem.Security.Cryptography.Native.Android.so
		ptr null; void* handle
	}, ; 20
	%struct.DSOCacheEntry {
		i64 u0x9190f4cb761b1d3c, ; from name: libSystem.IO.Compression.Native
		i64 u0xc3cb80650fe5a0ab, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.2_name, ; name: libSystem.IO.Compression.Native.so
		ptr null; void* handle
	}, ; 21
	%struct.DSOCacheEntry {
		i64 u0x936d971cc035eac2, ; from name: mono-component-marshal-ilgen
		i64 u0x0582d422de762780, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.5_name, ; name: libmono-component-marshal-ilgen.so
		ptr null; void* handle
	}, ; 22
	%struct.DSOCacheEntry {
		i64 u0x9c62065cdbdf43a5, ; from name: monosgen-2.0
		i64 u0x1a1918dd01662b19, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.6_name, ; name: libmonosgen-2.0.so
		ptr null; void* handle
	}, ; 23
	%struct.DSOCacheEntry {
		i64 u0x9ff54ae8a9311b68, ; from name: System.Native
		i64 u0xa337ccc8aef94267, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.3_name, ; name: libSystem.Native.so
		ptr null; void* handle
	}, ; 24
	%struct.DSOCacheEntry {
		i64 u0xa337ccc8aef94267, ; from name: libSystem.Native.so
		i64 u0xa337ccc8aef94267, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.3_name, ; name: libSystem.Native.so
		ptr null; void* handle
	}, ; 25
	%struct.DSOCacheEntry {
		i64 u0xa76ab5a3894f5a01, ; from name: System.Globalization.Native
		i64 u0x74b568291c419777, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.1_name, ; name: libSystem.Globalization.Native.so
		ptr null; void* handle
	}, ; 26
	%struct.DSOCacheEntry {
		i64 u0xab177aa6a32873ac, ; from name: monodroid.so
		i64 u0x4434c7fd110c8d8b, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.7_name, ; name: libmonodroid.so
		ptr null; void* handle
	}, ; 27
	%struct.DSOCacheEntry {
		i64 u0xc3cb80650fe5a0ab, ; from name: libSystem.IO.Compression.Native.so
		i64 u0xc3cb80650fe5a0ab, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.2_name, ; name: libSystem.IO.Compression.Native.so
		ptr null; void* handle
	}, ; 28
	%struct.DSOCacheEntry {
		i64 u0xccf5ce5cbae59392, ; from name: libSkiaSharp
		i64 u0x43db119dcc3147fa, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.8_name, ; name: libSkiaSharp.so
		ptr null; void* handle
	}, ; 29
	%struct.DSOCacheEntry {
		i64 u0xd334d108d628ab4f, ; from name: System.IO.Compression.Native
		i64 u0xc3cb80650fe5a0ab, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.2_name, ; name: libSystem.IO.Compression.Native.so
		ptr null; void* handle
	}, ; 30
	%struct.DSOCacheEntry {
		i64 u0xd565cc57ed541a90, ; from name: monosgen-2.0.so
		i64 u0x1a1918dd01662b19, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.6_name, ; name: libmonosgen-2.0.so
		ptr null; void* handle
	}, ; 31
	%struct.DSOCacheEntry {
		i64 u0xde6fb4b955d66724, ; from name: libmono-component-marshal-ilgen
		i64 u0x0582d422de762780, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.5_name, ; name: libmono-component-marshal-ilgen.so
		ptr null; void* handle
	}, ; 32
	%struct.DSOCacheEntry {
		i64 u0xe0d15587b4505ecd, ; from name: mono-component-marshal-ilgen.so
		i64 u0x0582d422de762780, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.5_name, ; name: libmono-component-marshal-ilgen.so
		ptr null; void* handle
	}, ; 33
	%struct.DSOCacheEntry {
		i64 u0xecb906ed9649ed1c, ; from name: System.Native.so
		i64 u0xa337ccc8aef94267, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.3_name, ; name: libSystem.Native.so
		ptr null; void* handle
	}, ; 34
	%struct.DSOCacheEntry {
		i64 u0xf4727d423e5d26f3, ; from name: SkiaSharp
		i64 u0x43db119dcc3147fa, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.8_name, ; name: libSkiaSharp.so
		ptr null; void* handle
	} ; 35
], align 8

; AOT DSO cache entries
@aot_dso_cache = dso_local local_unnamed_addr global [1971 x %struct.DSOCacheEntry] [
	%struct.DSOCacheEntry {
		i64 u0x000d2fa2fa438dc1, ; from name: aot-Microsoft.IdentityModel.JsonWebTokens.so
		i64 u0x0323e786c13d309d, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.70_name, ; name: libaot-Microsoft.IdentityModel.JsonWebTokens.dll.so
		ptr null; void* handle
	}, ; 0
	%struct.DSOCacheEntry {
		i64 u0x003beba4753b78eb, ; from name: libaot-System.Net.NameResolution
		i64 u0x7f280e9be5453eba, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.166_name, ; name: libaot-System.Net.NameResolution.dll.so
		ptr null; void* handle
	}, ; 1
	%struct.DSOCacheEntry {
		i64 u0x00a2ced568899a5e, ; from name: libaot-Refit.dll.so
		i64 u0x00a2ced568899a5e, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.83_name, ; name: libaot-Refit.dll.so
		ptr null; void* handle
	}, ; 2
	%struct.DSOCacheEntry {
		i64 u0x00a317d210f9e383, ; from name: Xamarin.AndroidX.CoordinatorLayout.so
		i64 u0x5cc157f14ad19fc0, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.108_name, ; name: libaot-Xamarin.AndroidX.CoordinatorLayout.dll.so
		ptr null; void* handle
	}, ; 3
	%struct.DSOCacheEntry {
		i64 u0x00a68732cb8c5c57, ; from name: aot-System.Threading.Channels.dll.so
		i64 u0x59aee0bc92ee07e3, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.210_name, ; name: libaot-System.Threading.Channels.dll.so
		ptr null; void* handle
	}, ; 4
	%struct.DSOCacheEntry {
		i64 u0x00cdc5f9ca43c45e, ; from name: libaot-netstandard.so
		i64 u0xb6ab21527197f7f1, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.223_name, ; name: libaot-netstandard.dll.so
		ptr null; void* handle
	}, ; 5
	%struct.DSOCacheEntry {
		i64 u0x00d09d7ee2baa65e, ; from name: libaot-Xamarin.AndroidX.Activity
		i64 u0x8a05820e9e77c0c3, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.102_name, ; name: libaot-Xamarin.AndroidX.Activity.dll.so
		ptr null; void* handle
	}, ; 6
	%struct.DSOCacheEntry {
		i64 u0x00d652fe32c8038a, ; from name: libaot-CommunityToolkit.Maui
		i64 u0x71a72d2d998e2673, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.14_name, ; name: libaot-CommunityToolkit.Maui.dll.so
		ptr null; void* handle
	}, ; 7
	%struct.DSOCacheEntry {
		i64 u0x016a1f9753c88da4, ; from name: aot-System.Security.Cryptography.Algorithms.dll.so
		i64 u0xd9a989573240dd9c, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.197_name, ; name: libaot-System.Security.Cryptography.Algorithms.dll.so
		ptr null; void* handle
	}, ; 8
	%struct.DSOCacheEntry {
		i64 u0x019ef78eca126b3d, ; from name: aot-Mono.Android.so
		i64 u0x359895a3c1bd5685, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.226_name, ; name: libaot-Mono.Android.dll.so
		ptr null; void* handle
	}, ; 9
	%struct.DSOCacheEntry {
		i64 u0x01e2c05cc559488e, ; from name: Microsoft.EntityFrameworkCore.SqlServer.so
		i64 u0x9daa39a878308c98, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.49_name, ; name: libaot-Microsoft.EntityFrameworkCore.SqlServer.dll.so
		ptr null; void* handle
	}, ; 10
	%struct.DSOCacheEntry {
		i64 u0x01f05117c40ba779, ; from name: System.Net.Sockets.dll.so
		i64 u0x4c5401149da6445e, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.171_name, ; name: libaot-System.Net.Sockets.dll.so
		ptr null; void* handle
	}, ; 11
	%struct.DSOCacheEntry {
		i64 u0x02330280aaa43cf9, ; from name: Microsoft.AspNetCore.Mvc.Core.dll.so
		i64 u0xffcb4d21a593e637, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.34_name, ; name: libaot-Microsoft.AspNetCore.Mvc.Core.dll.so
		ptr null; void* handle
	}, ; 12
	%struct.DSOCacheEntry {
		i64 u0x027079cd6cbb2479, ; from name: libaot-System.IO.Pipelines.dll.so
		i64 u0x027079cd6cbb2479, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.158_name, ; name: libaot-System.IO.Pipelines.dll.so
		ptr null; void* handle
	}, ; 13
	%struct.DSOCacheEntry {
		i64 u0x0276f95ae24bb1ea, ; from name: libaot-Xamarin.AndroidX.SavedState
		i64 u0x039588659cdd2f6a, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.124_name, ; name: libaot-Xamarin.AndroidX.SavedState.dll.so
		ptr null; void* handle
	}, ; 14
	%struct.DSOCacheEntry {
		i64 u0x02a4c5a44384f885, ; from name: Microsoft.Extensions.Caching.Memory
		i64 u0x331a7f0d6c2c08c9, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.51_name, ; name: libaot-Microsoft.Extensions.Caching.Memory.dll.so
		ptr null; void* handle
	}, ; 15
	%struct.DSOCacheEntry {
		i64 u0x02ccd45bdd1f469a, ; from name: aot-Microsoft.Extensions.Configuration.Abstractions
		i64 u0xd6a1ce9f7ccd35cb, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.53_name, ; name: libaot-Microsoft.Extensions.Configuration.Abstractions.dll.so
		ptr null; void* handle
	}, ; 16
	%struct.DSOCacheEntry {
		i64 u0x02ce2f4778cc6016, ; from name: aot-Microsoft.Extensions.Diagnostics.Abstractions.so
		i64 u0xd10bb63f997c45a2, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.58_name, ; name: libaot-Microsoft.Extensions.Diagnostics.Abstractions.dll.so
		ptr null; void* handle
	}, ; 17
	%struct.DSOCacheEntry {
		i64 u0x02ce506e1a16ff6a, ; from name: aot-System.Collections.dll.so
		i64 u0xb3f9fc836ae7ebb5, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.139_name, ; name: libaot-System.Collections.dll.so
		ptr null; void* handle
	}, ; 18
	%struct.DSOCacheEntry {
		i64 u0x02df486d5080f7fa, ; from name: libaot-System.Text.RegularExpressions.so
		i64 u0x7c2c39dae387b52d, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.209_name, ; name: libaot-System.Text.RegularExpressions.dll.so
		ptr null; void* handle
	}, ; 19
	%struct.DSOCacheEntry {
		i64 u0x031aeea51ada0ffd, ; from name: aot-System.Threading
		i64 u0x5f435aa7f5fde870, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.214_name, ; name: libaot-System.Threading.dll.so
		ptr null; void* handle
	}, ; 20
	%struct.DSOCacheEntry {
		i64 u0x0323e786c13d309d, ; from name: libaot-Microsoft.IdentityModel.JsonWebTokens.dll.so
		i64 u0x0323e786c13d309d, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.70_name, ; name: libaot-Microsoft.IdentityModel.JsonWebTokens.dll.so
		ptr null; void* handle
	}, ; 21
	%struct.DSOCacheEntry {
		i64 u0x033cad415b298f4c, ; from name: System.Linq.Queryable.so
		i64 u0x5932dbf572fab50a, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.161_name, ; name: libaot-System.Linq.Queryable.dll.so
		ptr null; void* handle
	}, ; 22
	%struct.DSOCacheEntry {
		i64 u0x03621c804933a890, ; from name: System.Buffers
		i64 u0x5988bd4997e5d75f, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.134_name, ; name: libaot-System.Buffers.dll.so
		ptr null; void* handle
	}, ; 23
	%struct.DSOCacheEntry {
		i64 u0x036e004f47c7ead3, ; from name: Microsoft.AspNetCore.SignalR.Client.dll.so
		i64 u0xb9619c5bddc1c8f4, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.38_name, ; name: libaot-Microsoft.AspNetCore.SignalR.Client.dll.so
		ptr null; void* handle
	}, ; 24
	%struct.DSOCacheEntry {
		i64 u0x039588659cdd2f6a, ; from name: libaot-Xamarin.AndroidX.SavedState.dll.so
		i64 u0x039588659cdd2f6a, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.124_name, ; name: libaot-Xamarin.AndroidX.SavedState.dll.so
		ptr null; void* handle
	}, ; 25
	%struct.DSOCacheEntry {
		i64 u0x03afef7450efe6a5, ; from name: aot-Microsoft.Maui.Controls.Xaml.dll.so
		i64 u0x5fc3bca990f46fb4, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.76_name, ; name: libaot-Microsoft.Maui.Controls.Xaml.dll.so
		ptr null; void* handle
	}, ; 26
	%struct.DSOCacheEntry {
		i64 u0x03ea24da2517cfb9, ; from name: libaot-Microsoft.AspNetCore.Routing.Abstractions.dll.so
		i64 u0x03ea24da2517cfb9, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.37_name, ; name: libaot-Microsoft.AspNetCore.Routing.Abstractions.dll.so
		ptr null; void* handle
	}, ; 27
	%struct.DSOCacheEntry {
		i64 u0x040d75ff3a754cff, ; from name: aot-System.Net.Http.Json.dll.so
		i64 u0x36547dc653fb83c1, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.164_name, ; name: libaot-System.Net.Http.Json.dll.so
		ptr null; void* handle
	}, ; 28
	%struct.DSOCacheEntry {
		i64 u0x040f66771b9ec3f7, ; from name: System.Collections.Specialized.so
		i64 u0x355b66670e6bf2e4, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.138_name, ; name: libaot-System.Collections.Specialized.dll.so
		ptr null; void* handle
	}, ; 29
	%struct.DSOCacheEntry {
		i64 u0x045aa3ca2cfe6a40, ; from name: libaot-Xamarin.AndroidX.Collection.Jvm.so
		i64 u0x1adc5c3038254713, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.107_name, ; name: libaot-Xamarin.AndroidX.Collection.Jvm.dll.so
		ptr null; void* handle
	}, ; 30
	%struct.DSOCacheEntry {
		i64 u0x045bcadef7ecbd11, ; from name: aot-mscorlib.so
		i64 u0xd45fa2873eb303d5, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.222_name, ; name: libaot-mscorlib.dll.so
		ptr null; void* handle
	}, ; 31
	%struct.DSOCacheEntry {
		i64 u0x04f64adeccc1a476, ; from name: aot-Microsoft.AspNetCore.Mvc.Abstractions.so
		i64 u0x8be639a423b6d017, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.33_name, ; name: libaot-Microsoft.AspNetCore.Mvc.Abstractions.dll.so
		ptr null; void* handle
	}, ; 32
	%struct.DSOCacheEntry {
		i64 u0x04f70c204f1c2cec, ; from name: aot-Xamarin.AndroidX.AppCompat
		i64 u0x42c7eb0880ff24a4, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.103_name, ; name: libaot-Xamarin.AndroidX.AppCompat.dll.so
		ptr null; void* handle
	}, ; 33
	%struct.DSOCacheEntry {
		i64 u0x04fd18ca96775113, ; from name: libaot-System.Security.Cryptography.Algorithms
		i64 u0xd9a989573240dd9c, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.197_name, ; name: libaot-System.Security.Cryptography.Algorithms.dll.so
		ptr null; void* handle
	}, ; 34
	%struct.DSOCacheEntry {
		i64 u0x0517ef04e06e9f76, ; from name: System.Net.Primitives
		i64 u0xaac4801194f87f4f, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.168_name, ; name: libaot-System.Net.Primitives.dll.so
		ptr null; void* handle
	}, ; 35
	%struct.DSOCacheEntry {
		i64 u0x0533ec2f4fed3d7c, ; from name: libaot-Microsoft.AspNetCore.Authentication.Abstractions.so
		i64 u0x59903efae9d3d723, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.20_name, ; name: libaot-Microsoft.AspNetCore.Authentication.Abstractions.dll.so
		ptr null; void* handle
	}, ; 36
	%struct.DSOCacheEntry {
		i64 u0x05411110dc51e939, ; from name: libaot-System.Collections.so
		i64 u0xb3f9fc836ae7ebb5, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.139_name, ; name: libaot-System.Collections.dll.so
		ptr null; void* handle
	}, ; 37
	%struct.DSOCacheEntry {
		i64 u0x0552f6e642148846, ; from name: libaot-System.Security.Cryptography.Cng.so
		i64 u0xe4a5a519ffe8b5e9, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.198_name, ; name: libaot-System.Security.Cryptography.Cng.dll.so
		ptr null; void* handle
	}, ; 38
	%struct.DSOCacheEntry {
		i64 u0x0561ab67c5f703e2, ; from name: libaot-System.IdentityModel.Tokens.Jwt
		i64 u0xe05faae6d518aca9, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.97_name, ; name: libaot-System.IdentityModel.Tokens.Jwt.dll.so
		ptr null; void* handle
	}, ; 39
	%struct.DSOCacheEntry {
		i64 u0x0565d18c6da3de38, ; from name: Xamarin.AndroidX.RecyclerView
		i64 u0x34c6f5c746796bcc, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.123_name, ; name: libaot-Xamarin.AndroidX.RecyclerView.dll.so
		ptr null; void* handle
	}, ; 40
	%struct.DSOCacheEntry {
		i64 u0x05743bd6012efec6, ; from name: System.Web.HttpUtility.so
		i64 u0xcdab467c6caa8aba, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.216_name, ; name: libaot-System.Web.HttpUtility.dll.so
		ptr null; void* handle
	}, ; 41
	%struct.DSOCacheEntry {
		i64 u0x05d9c451c1dedc4d, ; from name: aot-System.Runtime.Serialization.Xml.dll.so
		i64 u0xeb52548b17e702c6, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.193_name, ; name: libaot-System.Runtime.Serialization.Xml.dll.so
		ptr null; void* handle
	}, ; 42
	%struct.DSOCacheEntry {
		i64 u0x06408cb9cd23bd2d, ; from name: System.Drawing.so
		i64 u0x366c3ed8a6266ffb, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.152_name, ; name: libaot-System.Drawing.dll.so
		ptr null; void* handle
	}, ; 43
	%struct.DSOCacheEntry {
		i64 u0x06759aa9340a46f9, ; from name: System.Xml.XmlSerializer.so
		i64 u0xdfef1aaab339ffdb, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.220_name, ; name: libaot-System.Xml.XmlSerializer.dll.so
		ptr null; void* handle
	}, ; 44
	%struct.DSOCacheEntry {
		i64 u0x0680a433c781bb3d, ; from name: Xamarin.AndroidX.Collection.Jvm
		i64 u0x1adc5c3038254713, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.107_name, ; name: libaot-Xamarin.AndroidX.Collection.Jvm.dll.so
		ptr null; void* handle
	}, ; 45
	%struct.DSOCacheEntry {
		i64 u0x06d677d160d55768, ; from name: libaot-System.Diagnostics.TraceSource
		i64 u0x2119cc81025daa05, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.149_name, ; name: libaot-System.Diagnostics.TraceSource.dll.so
		ptr null; void* handle
	}, ; 46
	%struct.DSOCacheEntry {
		i64 u0x06de7ebf7e865e5c, ; from name: System.Private.CoreLib.so
		i64 u0xe1af59ffe15719e2, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.227_name, ; name: libaot-System.Private.CoreLib.dll.so
		ptr null; void* handle
	}, ; 47
	%struct.DSOCacheEntry {
		i64 u0x06e3c36dade85ab8, ; from name: aot-System.Diagnostics.Tracing.dll.so
		i64 u0x28371251d401372b, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.150_name, ; name: libaot-System.Diagnostics.Tracing.dll.so
		ptr null; void* handle
	}, ; 48
	%struct.DSOCacheEntry {
		i64 u0x06f8504cf94a6898, ; from name: libaot-System.Net.Requests
		i64 u0x2a8da1e7722aaaff, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.169_name, ; name: libaot-System.Net.Requests.dll.so
		ptr null; void* handle
	}, ; 49
	%struct.DSOCacheEntry {
		i64 u0x0722e2daaafe82e6, ; from name: aot-Xamarin.AndroidX.SavedState.so
		i64 u0x039588659cdd2f6a, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.124_name, ; name: libaot-Xamarin.AndroidX.SavedState.dll.so
		ptr null; void* handle
	}, ; 50
	%struct.DSOCacheEntry {
		i64 u0x077be473fe3d3eef, ; from name: aot-Mono.Android.dll.so
		i64 u0x359895a3c1bd5685, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.226_name, ; name: libaot-Mono.Android.dll.so
		ptr null; void* handle
	}, ; 51
	%struct.DSOCacheEntry {
		i64 u0x07869dd1c492a791, ; from name: libaot-System.IO.Compression.dll.so
		i64 u0x07869dd1c492a791, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.155_name, ; name: libaot-System.IO.Compression.dll.so
		ptr null; void* handle
	}, ; 52
	%struct.DSOCacheEntry {
		i64 u0x0799af1d269ee311, ; from name: aot-System.Diagnostics.DiagnosticSource
		i64 u0x77156c94b5eff927, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.146_name, ; name: libaot-System.Diagnostics.DiagnosticSource.dll.so
		ptr null; void* handle
	}, ; 53
	%struct.DSOCacheEntry {
		i64 u0x07a37d01a9f98b89, ; from name: System.Runtime.InteropServices.RuntimeInformation.so
		i64 u0x6aae90d5594500a9, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.186_name, ; name: libaot-System.Runtime.InteropServices.RuntimeInformation.dll.so
		ptr null; void* handle
	}, ; 54
	%struct.DSOCacheEntry {
		i64 u0x07a45374fab68acc, ; from name: libaot-Microsoft.Extensions.Configuration.dll.so
		i64 u0x07a45374fab68acc, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.52_name, ; name: libaot-Microsoft.Extensions.Configuration.dll.so
		ptr null; void* handle
	}, ; 55
	%struct.DSOCacheEntry {
		i64 u0x07c517aba7be7144, ; from name: aot-Xamarin.AndroidX.Activity.dll.so
		i64 u0x8a05820e9e77c0c3, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.102_name, ; name: libaot-Xamarin.AndroidX.Activity.dll.so
		ptr null; void* handle
	}, ; 56
	%struct.DSOCacheEntry {
		i64 u0x07dcdc7460a0c5e4, ; from name: System.Collections.NonGeneric
		i64 u0x6fd15fb6a42c9afc, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.137_name, ; name: libaot-System.Collections.NonGeneric.dll.so
		ptr null; void* handle
	}, ; 57
	%struct.DSOCacheEntry {
		i64 u0x07f229dec7daf27c, ; from name: aot-System.ClientModel.so
		i64 u0xa4d336a75ab12937, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.95_name, ; name: libaot-System.ClientModel.dll.so
		ptr null; void* handle
	}, ; 58
	%struct.DSOCacheEntry {
		i64 u0x07fec237a36e8367, ; from name: System.IdentityModel.Tokens.Jwt.so
		i64 u0xe05faae6d518aca9, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.97_name, ; name: libaot-System.IdentityModel.Tokens.Jwt.dll.so
		ptr null; void* handle
	}, ; 59
	%struct.DSOCacheEntry {
		i64 u0x081299ae94d203d9, ; from name: libaot-Microsoft.Extensions.Logging.Abstractions
		i64 u0xe6757a5fac324e53, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.63_name, ; name: libaot-Microsoft.Extensions.Logging.Abstractions.dll.so
		ptr null; void* handle
	}, ; 60
	%struct.DSOCacheEntry {
		i64 u0x082263dd3f99b25d, ; from name: libaot-System.IO.Pipes
		i64 u0x370b7031653c1807, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.159_name, ; name: libaot-System.IO.Pipes.dll.so
		ptr null; void* handle
	}, ; 61
	%struct.DSOCacheEntry {
		i64 u0x0841fe30a610e563, ; from name: libaot-Microsoft.Extensions.Logging
		i64 u0x9b6f0babce2a1934, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.62_name, ; name: libaot-Microsoft.Extensions.Logging.dll.so
		ptr null; void* handle
	}, ; 62
	%struct.DSOCacheEntry {
		i64 u0x08537093f432faf8, ; from name: Microsoft.IdentityModel.Logging.dll.so
		i64 u0x1175872aaf2edbfe, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.71_name, ; name: libaot-Microsoft.IdentityModel.Logging.dll.so
		ptr null; void* handle
	}, ; 63
	%struct.DSOCacheEntry {
		i64 u0x087788e6eed39ace, ; from name: aot-Microsoft.Maui.Controls.Xaml.so
		i64 u0x5fc3bca990f46fb4, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.76_name, ; name: libaot-Microsoft.Maui.Controls.Xaml.dll.so
		ptr null; void* handle
	}, ; 64
	%struct.DSOCacheEntry {
		i64 u0x087e53f50e8fa54a, ; from name: aot-Xamarin.AndroidX.Lifecycle.LiveData.Core.dll.so
		i64 u0x38e4553d8764fa45, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.115_name, ; name: libaot-Xamarin.AndroidX.Lifecycle.LiveData.Core.dll.so
		ptr null; void* handle
	}, ; 65
	%struct.DSOCacheEntry {
		i64 u0x088cd59ae9001c3f, ; from name: aot-System.Reflection.Primitives.dll.so
		i64 u0x8c58bd1a08c146f5, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.185_name, ; name: libaot-System.Reflection.Primitives.dll.so
		ptr null; void* handle
	}, ; 66
	%struct.DSOCacheEntry {
		i64 u0x08a7c865576bbde7, ; from name: System.Reflection.Primitives
		i64 u0x8c58bd1a08c146f5, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.185_name, ; name: libaot-System.Reflection.Primitives.dll.so
		ptr null; void* handle
	}, ; 67
	%struct.DSOCacheEntry {
		i64 u0x08a99453e6af4848, ; from name: libaot-System.IdentityModel.Tokens.Jwt.so
		i64 u0xe05faae6d518aca9, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.97_name, ; name: libaot-System.IdentityModel.Tokens.Jwt.dll.so
		ptr null; void* handle
	}, ; 68
	%struct.DSOCacheEntry {
		i64 u0x08b75913564649f7, ; from name: libaot-Xamarin.AndroidX.Lifecycle.Common.Jvm
		i64 u0x2ec8d2dcf2c4a71b, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.114_name, ; name: libaot-Xamarin.AndroidX.Lifecycle.Common.Jvm.dll.so
		ptr null; void* handle
	}, ; 69
	%struct.DSOCacheEntry {
		i64 u0x08c72897f280323a, ; from name: aot-Microsoft.Maui.Controls.Xaml
		i64 u0x5fc3bca990f46fb4, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.76_name, ; name: libaot-Microsoft.Maui.Controls.Xaml.dll.so
		ptr null; void* handle
	}, ; 70
	%struct.DSOCacheEntry {
		i64 u0x08f3c9788ee2153c, ; from name: Xamarin.AndroidX.DrawerLayout
		i64 u0x4bea014989424a56, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.112_name, ; name: libaot-Xamarin.AndroidX.DrawerLayout.dll.so
		ptr null; void* handle
	}, ; 71
	%struct.DSOCacheEntry {
		i64 u0x093df601dab9a47f, ; from name: System.IO.Compression.Brotli.so
		i64 u0x7b22585c66d48a81, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.154_name, ; name: libaot-System.IO.Compression.Brotli.dll.so
		ptr null; void* handle
	}, ; 72
	%struct.DSOCacheEntry {
		i64 u0x095cacaf6b6a32e4, ; from name: System.Memory.Data
		i64 u0xe03e3baaab589d1e, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.98_name, ; name: libaot-System.Memory.Data.dll.so
		ptr null; void* handle
	}, ; 73
	%struct.DSOCacheEntry {
		i64 u0x0975c0d650fe3f81, ; from name: aot-System.Threading.Channels
		i64 u0x59aee0bc92ee07e3, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.210_name, ; name: libaot-System.Threading.Channels.dll.so
		ptr null; void* handle
	}, ; 74
	%struct.DSOCacheEntry {
		i64 u0x09d144a7e214d457, ; from name: System.Security.Cryptography
		i64 u0xd0e82017367ac826, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.203_name, ; name: libaot-System.Security.Cryptography.dll.so
		ptr null; void* handle
	}, ; 75
	%struct.DSOCacheEntry {
		i64 u0x09f305987914ae5d, ; from name: Microsoft.Maui.Essentials.so
		i64 u0xdc3ba4771239be2d, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.78_name, ; name: libaot-Microsoft.Maui.Essentials.dll.so
		ptr null; void* handle
	}, ; 76
	%struct.DSOCacheEntry {
		i64 u0x09faf143e60ec0a7, ; from name: aot-Microsoft.SqlServer.Server.dll.so
		i64 u0x7b4f94432c52afad, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.81_name, ; name: libaot-Microsoft.SqlServer.Server.dll.so
		ptr null; void* handle
	}, ; 77
	%struct.DSOCacheEntry {
		i64 u0x0a00c6d3752fd452, ; from name: libaot-Microsoft.Extensions.DependencyModel
		i64 u0x42c08831b421dece, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.56_name, ; name: libaot-Microsoft.Extensions.DependencyModel.dll.so
		ptr null; void* handle
	}, ; 78
	%struct.DSOCacheEntry {
		i64 u0x0a147b2c00acff78, ; from name: aot-System.Collections
		i64 u0xb3f9fc836ae7ebb5, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.139_name, ; name: libaot-System.Collections.dll.so
		ptr null; void* handle
	}, ; 79
	%struct.DSOCacheEntry {
		i64 u0x0a18b49bebc33444, ; from name: libaot-System.Net.WebSockets.Client.dll.so
		i64 u0x0a18b49bebc33444, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.174_name, ; name: libaot-System.Net.WebSockets.Client.dll.so
		ptr null; void* handle
	}, ; 80
	%struct.DSOCacheEntry {
		i64 u0x0a410faf43ed0ea7, ; from name: aot-System.ComponentModel.TypeConverter
		i64 u0xcb7e41356728fd07, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.142_name, ; name: libaot-System.ComponentModel.TypeConverter.dll.so
		ptr null; void* handle
	}, ; 81
	%struct.DSOCacheEntry {
		i64 u0x0a8eb53fb617b921, ; from name: System.Formats.Asn1.dll.so
		i64 u0x4a9bda0e8528b414, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.153_name, ; name: libaot-System.Formats.Asn1.dll.so
		ptr null; void* handle
	}, ; 82
	%struct.DSOCacheEntry {
		i64 u0x0aea8c30dd737ea9, ; from name: aot-Microsoft.Maui.Essentials.dll.so
		i64 u0xdc3ba4771239be2d, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.78_name, ; name: libaot-Microsoft.Maui.Essentials.dll.so
		ptr null; void* handle
	}, ; 83
	%struct.DSOCacheEntry {
		i64 u0x0b228e2b5c8cd235, ; from name: System.Net.NetworkInformation.dll.so
		i64 u0xb1bf28cdcefab46b, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.167_name, ; name: libaot-System.Net.NetworkInformation.dll.so
		ptr null; void* handle
	}, ; 84
	%struct.DSOCacheEntry {
		i64 u0x0b4a4933f4fbec38, ; from name: aot-Microsoft.Extensions.Logging
		i64 u0x9b6f0babce2a1934, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.62_name, ; name: libaot-Microsoft.Extensions.Logging.dll.so
		ptr null; void* handle
	}, ; 85
	%struct.DSOCacheEntry {
		i64 u0x0b5d91c9e03c9046, ; from name: aot-System.Runtime.Serialization.Json.dll.so
		i64 u0xe012402cc380eac2, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.191_name, ; name: libaot-System.Runtime.Serialization.Json.dll.so
		ptr null; void* handle
	}, ; 86
	%struct.DSOCacheEntry {
		i64 u0x0b64842fa4f67147, ; from name: aot-Microsoft.Extensions.Primitives
		i64 u0x9df2f15d2ed44e61, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.66_name, ; name: libaot-Microsoft.Extensions.Primitives.dll.so
		ptr null; void* handle
	}, ; 87
	%struct.DSOCacheEntry {
		i64 u0x0b6aff547b84fbe9, ; from name: Xamarin.KotlinX.Serialization.Core.Jvm
		i64 u0x757898ba637db46e, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.131_name, ; name: libaot-Xamarin.KotlinX.Serialization.Core.Jvm.dll.so
		ptr null; void* handle
	}, ; 88
	%struct.DSOCacheEntry {
		i64 u0x0b7c60fbe9d8f09b, ; from name: libaot-Microsoft.Data.SqlClient.dll.so
		i64 u0x0b7c60fbe9d8f09b, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.45_name, ; name: libaot-Microsoft.Data.SqlClient.dll.so
		ptr null; void* handle
	}, ; 89
	%struct.DSOCacheEntry {
		i64 u0x0bbe9d20bf639a6d, ; from name: Mono.Android.dll.so
		i64 u0x359895a3c1bd5685, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.226_name, ; name: libaot-Mono.Android.dll.so
		ptr null; void* handle
	}, ; 90
	%struct.DSOCacheEntry {
		i64 u0x0be2e1f8ce4064ed, ; from name: Xamarin.AndroidX.ViewPager
		i64 u0xb5351dcbaf438cb6, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.126_name, ; name: libaot-Xamarin.AndroidX.ViewPager.dll.so
		ptr null; void* handle
	}, ; 91
	%struct.DSOCacheEntry {
		i64 u0x0bf959b983e6ffd7, ; from name: libaot-Xamarin.Google.Android.Material.so
		i64 u0x937abea3fe5296af, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.128_name, ; name: libaot-Xamarin.Google.Android.Material.dll.so
		ptr null; void* handle
	}, ; 92
	%struct.DSOCacheEntry {
		i64 u0x0c3d4343ddcd5d2f, ; from name: aot-netstandard
		i64 u0xb6ab21527197f7f1, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.223_name, ; name: libaot-netstandard.dll.so
		ptr null; void* handle
	}, ; 93
	%struct.DSOCacheEntry {
		i64 u0x0c59ad9fbbd43abe, ; from name: Mono.Android
		i64 u0x359895a3c1bd5685, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.226_name, ; name: libaot-Mono.Android.dll.so
		ptr null; void* handle
	}, ; 94
	%struct.DSOCacheEntry {
		i64 u0x0c644d6a2b020c43, ; from name: libaot-Xamarin.Kotlin.StdLib.dll.so
		i64 u0x0c644d6a2b020c43, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.129_name, ; name: libaot-Xamarin.Kotlin.StdLib.dll.so
		ptr null; void* handle
	}, ; 95
	%struct.DSOCacheEntry {
		i64 u0x0c763ee75e26732f, ; from name: aot-System.IO.Compression.so
		i64 u0x07869dd1c492a791, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.155_name, ; name: libaot-System.IO.Compression.dll.so
		ptr null; void* handle
	}, ; 96
	%struct.DSOCacheEntry {
		i64 u0x0c920480fa0c2eaa, ; from name: aot-System.Threading.dll.so
		i64 u0x5f435aa7f5fde870, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.214_name, ; name: libaot-System.Threading.dll.so
		ptr null; void* handle
	}, ; 97
	%struct.DSOCacheEntry {
		i64 u0x0c95146e3fdcf631, ; from name: libaot-Mono.Android.so
		i64 u0x359895a3c1bd5685, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.226_name, ; name: libaot-Mono.Android.dll.so
		ptr null; void* handle
	}, ; 98
	%struct.DSOCacheEntry {
		i64 u0x0cea52dbe4564088, ; from name: aot-Microsoft.AspNetCore.SignalR.Core
		i64 u0x73dd04543af2c841, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.41_name, ; name: libaot-Microsoft.AspNetCore.SignalR.Core.dll.so
		ptr null; void* handle
	}, ; 99
	%struct.DSOCacheEntry {
		i64 u0x0d31fab3a7bead05, ; from name: libaot-System.IO.Pipes.so
		i64 u0x370b7031653c1807, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.159_name, ; name: libaot-System.IO.Pipes.dll.so
		ptr null; void* handle
	}, ; 100
	%struct.DSOCacheEntry {
		i64 u0x0d5196a026f33328, ; from name: aot-SocialMauiApp
		i64 u0xec957d270d230c6a, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.11_name, ; name: libaot-SocialMauiApp.dll.so
		ptr null; void* handle
	}, ; 101
	%struct.DSOCacheEntry {
		i64 u0x0dc664860733a634, ; from name: libaot-Syncfusion.Maui.Core.so
		i64 u0x4cfc586bcbdc6c97, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.90_name, ; name: libaot-Syncfusion.Maui.Core.dll.so
		ptr null; void* handle
	}, ; 102
	%struct.DSOCacheEntry {
		i64 u0x0dd6f35447704ccb, ; from name: aot-System.Private.CoreLib.dll.so
		i64 u0xe1af59ffe15719e2, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.227_name, ; name: libaot-System.Private.CoreLib.dll.so
		ptr null; void* handle
	}, ; 103
	%struct.DSOCacheEntry {
		i64 u0x0defc9d6846b9b57, ; from name: System.Runtime.Serialization.Json.dll.so
		i64 u0xe012402cc380eac2, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.191_name, ; name: libaot-System.Runtime.Serialization.Json.dll.so
		ptr null; void* handle
	}, ; 104
	%struct.DSOCacheEntry {
		i64 u0x0df6ab4b54997aa6, ; from name: Microsoft.AspNetCore.Hosting.Server.Abstractions.dll.so
		i64 u0xdb28c2f2e5cda275, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.26_name, ; name: libaot-Microsoft.AspNetCore.Hosting.Server.Abstractions.dll.so
		ptr null; void* handle
	}, ; 105
	%struct.DSOCacheEntry {
		i64 u0x0e193ea4d150b618, ; from name: libaot-Xamarin.AndroidX.Browser
		i64 u0x9865c0bf349d1465, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.105_name, ; name: libaot-Xamarin.AndroidX.Browser.dll.so
		ptr null; void* handle
	}, ; 106
	%struct.DSOCacheEntry {
		i64 u0x0e3318188d0f39b7, ; from name: aot-Microsoft.AspNetCore.SignalR.Client.so
		i64 u0xb9619c5bddc1c8f4, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.38_name, ; name: libaot-Microsoft.AspNetCore.SignalR.Client.dll.so
		ptr null; void* handle
	}, ; 107
	%struct.DSOCacheEntry {
		i64 u0x0e3aafdca0571230, ; from name: Microsoft.AspNetCore.Authentication.Abstractions.so
		i64 u0x59903efae9d3d723, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.20_name, ; name: libaot-Microsoft.AspNetCore.Authentication.Abstractions.dll.so
		ptr null; void* handle
	}, ; 108
	%struct.DSOCacheEntry {
		i64 u0x0e46bd4e008c7b33, ; from name: libaot-Microsoft.AspNetCore.SignalR.Client.Core.dll.so
		i64 u0x0e46bd4e008c7b33, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.39_name, ; name: libaot-Microsoft.AspNetCore.SignalR.Client.Core.dll.so
		ptr null; void* handle
	}, ; 109
	%struct.DSOCacheEntry {
		i64 u0x0e85db2a1cd0e11a, ; from name: System.Threading.dll.so
		i64 u0x5f435aa7f5fde870, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.214_name, ; name: libaot-System.Threading.dll.so
		ptr null; void* handle
	}, ; 110
	%struct.DSOCacheEntry {
		i64 u0x0ee139ab935710eb, ; from name: aot-Mono.Android.Runtime
		i64 u0x156ae2b2e8a39884, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.225_name, ; name: libaot-Mono.Android.Runtime.dll.so
		ptr null; void* handle
	}, ; 111
	%struct.DSOCacheEntry {
		i64 u0x0ee1c0ebd123d39e, ; from name: aot-Xamarin.AndroidX.Navigation.UI
		i64 u0x21b741f2635aa744, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.122_name, ; name: libaot-Xamarin.AndroidX.Navigation.UI.dll.so
		ptr null; void* handle
	}, ; 112
	%struct.DSOCacheEntry {
		i64 u0x0efed0511032e86a, ; from name: libaot-System.Text.Encoding.CodePages.so
		i64 u0x16262857ad9a2e54, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.205_name, ; name: libaot-System.Text.Encoding.CodePages.dll.so
		ptr null; void* handle
	}, ; 113
	%struct.DSOCacheEntry {
		i64 u0x0f6df59e4daccb1a, ; from name: libaot-Microsoft.Extensions.Http
		i64 u0x24aa3d6e3cd1bcb7, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.61_name, ; name: libaot-Microsoft.Extensions.Http.dll.so
		ptr null; void* handle
	}, ; 114
	%struct.DSOCacheEntry {
		i64 u0x0f6ec7bc00b37705, ; from name: libaot-System.Runtime
		i64 u0xbbc0e6e747d7877a, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.194_name, ; name: libaot-System.Runtime.dll.so
		ptr null; void* handle
	}, ; 115
	%struct.DSOCacheEntry {
		i64 u0x0f786032d71260d2, ; from name: aot-Syncfusion.Maui.Toolkit
		i64 u0x2d6521795fa92605, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.93_name, ; name: libaot-Syncfusion.Maui.Toolkit.dll.so
		ptr null; void* handle
	}, ; 116
	%struct.DSOCacheEntry {
		i64 u0x0f973de6fa66af12, ; from name: Xamarin.AndroidX.AppCompat.dll.so
		i64 u0x42c7eb0880ff24a4, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.103_name, ; name: libaot-Xamarin.AndroidX.AppCompat.dll.so
		ptr null; void* handle
	}, ; 117
	%struct.DSOCacheEntry {
		i64 u0x0fb520ee1629e86e, ; from name: Microsoft.Win32.Primitives.dll.so
		i64 u0x6f3638b02afc00cc, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.133_name, ; name: libaot-Microsoft.Win32.Primitives.dll.so
		ptr null; void* handle
	}, ; 118
	%struct.DSOCacheEntry {
		i64 u0x0fb94003c1ad7813, ; from name: Refit.so
		i64 u0x00a2ced568899a5e, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.83_name, ; name: libaot-Refit.dll.so
		ptr null; void* handle
	}, ; 119
	%struct.DSOCacheEntry {
		i64 u0x0fe18bfe5526f30d, ; from name: libaot-System.Collections.Concurrent
		i64 u0x65cd21401fecc3dc, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.135_name, ; name: libaot-System.Collections.Concurrent.dll.so
		ptr null; void* handle
	}, ; 120
	%struct.DSOCacheEntry {
		i64 u0x0ffbae7c9217fca1, ; from name: Xamarin.AndroidX.CursorAdapter.dll.so
		i64 u0xdf3c491694996c7e, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.110_name, ; name: libaot-Xamarin.AndroidX.CursorAdapter.dll.so
		ptr null; void* handle
	}, ; 121
	%struct.DSOCacheEntry {
		i64 u0x10280c3b01a3c4b7, ; from name: Microsoft.AspNetCore.Authorization.Policy.dll.so
		i64 u0x4d16f4a17e081b1e, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.23_name, ; name: libaot-Microsoft.AspNetCore.Authorization.Policy.dll.so
		ptr null; void* handle
	}, ; 122
	%struct.DSOCacheEntry {
		i64 u0x102a31b45304b1da, ; from name: Xamarin.AndroidX.CustomView
		i64 u0xe7b2e898b68d9670, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.111_name, ; name: libaot-Xamarin.AndroidX.CustomView.dll.so
		ptr null; void* handle
	}, ; 123
	%struct.DSOCacheEntry {
		i64 u0x107304da7e78e111, ; from name: DocumentFormat.OpenXml.dll.so
		i64 u0x456cc421e6ef3bb7, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.17_name, ; name: libaot-DocumentFormat.OpenXml.dll.so
		ptr null; void* handle
	}, ; 124
	%struct.DSOCacheEntry {
		i64 u0x107ea78ba792e22e, ; from name: CommunityToolkit.Maui.Core.so
		i64 u0x1f7f7b0e04fbedb0, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.15_name, ; name: libaot-CommunityToolkit.Maui.Core.dll.so
		ptr null; void* handle
	}, ; 125
	%struct.DSOCacheEntry {
		i64 u0x109291a72aa2c5ac, ; from name: aot-System.Runtime.Loader.so
		i64 u0x55c25b4d27ae6f23, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.188_name, ; name: libaot-System.Runtime.Loader.dll.so
		ptr null; void* handle
	}, ; 126
	%struct.DSOCacheEntry {
		i64 u0x10a58337a39bc29d, ; from name: libaot-System.Security.Cryptography.Primitives
		i64 u0x7d7dff41d9076267, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.201_name, ; name: libaot-System.Security.Cryptography.Primitives.dll.so
		ptr null; void* handle
	}, ; 127
	%struct.DSOCacheEntry {
		i64 u0x10c804abddfab325, ; from name: aot-System.IO.Compression.Brotli
		i64 u0x7b22585c66d48a81, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.154_name, ; name: libaot-System.IO.Compression.Brotli.dll.so
		ptr null; void* handle
	}, ; 128
	%struct.DSOCacheEntry {
		i64 u0x10ca46a12d1cfb88, ; from name: Syncfusion.Maui.Core
		i64 u0x4cfc586bcbdc6c97, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.90_name, ; name: libaot-Syncfusion.Maui.Core.dll.so
		ptr null; void* handle
	}, ; 129
	%struct.DSOCacheEntry {
		i64 u0x10d3df0c3bcda082, ; from name: libaot-Microsoft.Maui
		i64 u0x58cd310024b735d8, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.77_name, ; name: libaot-Microsoft.Maui.dll.so
		ptr null; void* handle
	}, ; 130
	%struct.DSOCacheEntry {
		i64 u0x10f6cfcbcf801616, ; from name: System.IO.Compression.Brotli
		i64 u0x7b22585c66d48a81, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.154_name, ; name: libaot-System.IO.Compression.Brotli.dll.so
		ptr null; void* handle
	}, ; 131
	%struct.DSOCacheEntry {
		i64 u0x110f85ed0e988dad, ; from name: libaot-SQLitePCLRaw.core.dll.so
		i64 u0x110f85ed0e988dad, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.86_name, ; name: libaot-SQLitePCLRaw.core.dll.so
		ptr null; void* handle
	}, ; 132
	%struct.DSOCacheEntry {
		i64 u0x1126bd09eab2ce09, ; from name: aot-Microsoft.Extensions.Diagnostics.dll.so
		i64 u0xd34809bcacf156ee, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.57_name, ; name: libaot-Microsoft.Extensions.Diagnostics.dll.so
		ptr null; void* handle
	}, ; 133
	%struct.DSOCacheEntry {
		i64 u0x113ec75219e665cb, ; from name: libaot-System.IO.Compression.Brotli
		i64 u0x7b22585c66d48a81, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.154_name, ; name: libaot-System.IO.Compression.Brotli.dll.so
		ptr null; void* handle
	}, ; 134
	%struct.DSOCacheEntry {
		i64 u0x114443cdcf2091f1, ; from name: System.Security.Cryptography.Primitives
		i64 u0x7d7dff41d9076267, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.201_name, ; name: libaot-System.Security.Cryptography.Primitives.dll.so
		ptr null; void* handle
	}, ; 135
	%struct.DSOCacheEntry {
		i64 u0x115b5ef6a89ce123, ; from name: aot-SQLitePCLRaw.lib.e_sqlite3.android.so
		i64 u0x6a03b775044080b2, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.87_name, ; name: libaot-SQLitePCLRaw.lib.e_sqlite3.android.dll.so
		ptr null; void* handle
	}, ; 136
	%struct.DSOCacheEntry {
		i64 u0x1175872aaf2edbfe, ; from name: libaot-Microsoft.IdentityModel.Logging.dll.so
		i64 u0x1175872aaf2edbfe, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.71_name, ; name: libaot-Microsoft.IdentityModel.Logging.dll.so
		ptr null; void* handle
	}, ; 137
	%struct.DSOCacheEntry {
		i64 u0x11a1a07d3d710e7b, ; from name: aot-System.Text.Encoding.Extensions.so
		i64 u0xf89ed8fc2f5b4b33, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.206_name, ; name: libaot-System.Text.Encoding.Extensions.dll.so
		ptr null; void* handle
	}, ; 138
	%struct.DSOCacheEntry {
		i64 u0x12448631a200ce9a, ; from name: libaot-SocialMediaMaui.Shared.dll.so
		i64 u0x12448631a200ce9a, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.10_name, ; name: libaot-SocialMediaMaui.Shared.dll.so
		ptr null; void* handle
	}, ; 139
	%struct.DSOCacheEntry {
		i64 u0x12637b6208f4c773, ; from name: System.Runtime.Serialization.Json.so
		i64 u0xe012402cc380eac2, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.191_name, ; name: libaot-System.Runtime.Serialization.Json.dll.so
		ptr null; void* handle
	}, ; 140
	%struct.DSOCacheEntry {
		i64 u0x1271045d1561acf0, ; from name: libaot-System.Net.Security.dll.so
		i64 u0x1271045d1561acf0, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.170_name, ; name: libaot-System.Net.Security.dll.so
		ptr null; void* handle
	}, ; 141
	%struct.DSOCacheEntry {
		i64 u0x12e7ebd969c66db8, ; from name: aot-Microsoft.AspNetCore.Mvc.Core.so
		i64 u0xffcb4d21a593e637, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.34_name, ; name: libaot-Microsoft.AspNetCore.Mvc.Core.dll.so
		ptr null; void* handle
	}, ; 142
	%struct.DSOCacheEntry {
		i64 u0x13072046e731d5e4, ; from name: Xamarin.AndroidX.RecyclerView.so
		i64 u0x34c6f5c746796bcc, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.123_name, ; name: libaot-Xamarin.AndroidX.RecyclerView.dll.so
		ptr null; void* handle
	}, ; 143
	%struct.DSOCacheEntry {
		i64 u0x1308ab3944158de1, ; from name: libaot-Microsoft.AspNetCore.Mvc.Abstractions.so
		i64 u0x8be639a423b6d017, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.33_name, ; name: libaot-Microsoft.AspNetCore.Mvc.Abstractions.dll.so
		ptr null; void* handle
	}, ; 144
	%struct.DSOCacheEntry {
		i64 u0x130ff21ef7188276, ; from name: aot-Syncfusion.Maui.ImageEditor.so
		i64 u0x70f8ca2f11ec3669, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.91_name, ; name: libaot-Syncfusion.Maui.ImageEditor.dll.so
		ptr null; void* handle
	}, ; 145
	%struct.DSOCacheEntry {
		i64 u0x1332d97398bcfb4d, ; from name: aot-System.IO.FileSystem.AccessControl.dll.so
		i64 u0xf8af38e7ca3d5d78, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.156_name, ; name: libaot-System.IO.FileSystem.AccessControl.dll.so
		ptr null; void* handle
	}, ; 146
	%struct.DSOCacheEntry {
		i64 u0x1370a5e5b0293ca1, ; from name: libaot-System.Net.Http
		i64 u0xd925f85604802447, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.165_name, ; name: libaot-System.Net.Http.dll.so
		ptr null; void* handle
	}, ; 147
	%struct.DSOCacheEntry {
		i64 u0x137f32c7a1cf3138, ; from name: libaot-Microsoft.Extensions.Caching.Abstractions.so
		i64 u0x988026893039cd51, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.50_name, ; name: libaot-Microsoft.Extensions.Caching.Abstractions.dll.so
		ptr null; void* handle
	}, ; 148
	%struct.DSOCacheEntry {
		i64 u0x138567fa954faa55, ; from name: Xamarin.AndroidX.Browser
		i64 u0x9865c0bf349d1465, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.105_name, ; name: libaot-Xamarin.AndroidX.Browser.dll.so
		ptr null; void* handle
	}, ; 149
	%struct.DSOCacheEntry {
		i64 u0x138a01708bcfb3b2, ; from name: aot-System.Net.Requests.dll.so
		i64 u0x2a8da1e7722aaaff, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.169_name, ; name: libaot-System.Net.Requests.dll.so
		ptr null; void* handle
	}, ; 150
	%struct.DSOCacheEntry {
		i64 u0x13ab0118a00f2ca6, ; from name: aot-System.Runtime.Caching.dll.so
		i64 u0x9a1f1aedbdf3f019, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.100_name, ; name: libaot-System.Runtime.Caching.dll.so
		ptr null; void* handle
	}, ; 151
	%struct.DSOCacheEntry {
		i64 u0x13abaa7c4149117a, ; from name: libaot-Microsoft.IdentityModel.Protocols.OpenIdConnect.so
		i64 u0xbe90bee1d67c825c, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.73_name, ; name: libaot-Microsoft.IdentityModel.Protocols.OpenIdConnect.dll.so
		ptr null; void* handle
	}, ; 152
	%struct.DSOCacheEntry {
		i64 u0x13b7fd6c25964f1e, ; from name: aot-Microsoft.IdentityModel.Protocols.so
		i64 u0x9037f9d64d16c443, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.72_name, ; name: libaot-Microsoft.IdentityModel.Protocols.dll.so
		ptr null; void* handle
	}, ; 153
	%struct.DSOCacheEntry {
		i64 u0x13e4c9b4a68b70b1, ; from name: aot-System.Linq
		i64 u0x2fb7a3952b307fae, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.162_name, ; name: libaot-System.Linq.dll.so
		ptr null; void* handle
	}, ; 154
	%struct.DSOCacheEntry {
		i64 u0x1422dc83741435ea, ; from name: libaot-System.Xml.XmlSerializer.so
		i64 u0xdfef1aaab339ffdb, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.220_name, ; name: libaot-System.Xml.XmlSerializer.dll.so
		ptr null; void* handle
	}, ; 155
	%struct.DSOCacheEntry {
		i64 u0x1424c470f81701c2, ; from name: libaot-System.IO.FileSystem.AccessControl.so
		i64 u0xf8af38e7ca3d5d78, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.156_name, ; name: libaot-System.IO.FileSystem.AccessControl.dll.so
		ptr null; void* handle
	}, ; 156
	%struct.DSOCacheEntry {
		i64 u0x14283e2d731a896b, ; from name: libaot-Microsoft.AspNetCore.Http.Connections.Client.dll.so
		i64 u0x14283e2d731a896b, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.29_name, ; name: libaot-Microsoft.AspNetCore.Http.Connections.Client.dll.so
		ptr null; void* handle
	}, ; 157
	%struct.DSOCacheEntry {
		i64 u0x1436966fd5dc44d9, ; from name: aot-System.Security.Cryptography.Csp
		i64 u0xb259133b67649ff8, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.199_name, ; name: libaot-System.Security.Cryptography.Csp.dll.so
		ptr null; void* handle
	}, ; 158
	%struct.DSOCacheEntry {
		i64 u0x143a1f6e62b82b56, ; from name: Microsoft.IdentityModel.Protocols.OpenIdConnect
		i64 u0xbe90bee1d67c825c, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.73_name, ; name: libaot-Microsoft.IdentityModel.Protocols.OpenIdConnect.dll.so
		ptr null; void* handle
	}, ; 159
	%struct.DSOCacheEntry {
		i64 u0x143d8ea60a6a4011, ; from name: Microsoft.Extensions.DependencyInjection.Abstractions
		i64 u0x4643d8f925d8e6b7, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.55_name, ; name: libaot-Microsoft.Extensions.DependencyInjection.Abstractions.dll.so
		ptr null; void* handle
	}, ; 160
	%struct.DSOCacheEntry {
		i64 u0x14509a44f2bd8f81, ; from name: System.Console.dll.so
		i64 u0xc2da5dca6ccd8b0a, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.144_name, ; name: libaot-System.Console.dll.so
		ptr null; void* handle
	}, ; 161
	%struct.DSOCacheEntry {
		i64 u0x148f647a7a5af18a, ; from name: System.Private.Xml.Linq.so
		i64 u0x99ef7518b4544507, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.180_name, ; name: libaot-System.Private.Xml.Linq.dll.so
		ptr null; void* handle
	}, ; 162
	%struct.DSOCacheEntry {
		i64 u0x14aeac7cd1d9a94d, ; from name: libaot-Microsoft.AspNetCore.Http.Connections.Client.so
		i64 u0x14283e2d731a896b, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.29_name, ; name: libaot-Microsoft.AspNetCore.Http.Connections.Client.dll.so
		ptr null; void* handle
	}, ; 163
	%struct.DSOCacheEntry {
		i64 u0x14c874ac8b04a442, ; from name: aot-System.Runtime.InteropServices.so
		i64 u0x5ae6db1ddadc230b, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.187_name, ; name: libaot-System.Runtime.InteropServices.dll.so
		ptr null; void* handle
	}, ; 164
	%struct.DSOCacheEntry {
		i64 u0x15089560460fb845, ; from name: Microsoft.AspNetCore.SignalR.Client.Core
		i64 u0x0e46bd4e008c7b33, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.39_name, ; name: libaot-Microsoft.AspNetCore.SignalR.Client.Core.dll.so
		ptr null; void* handle
	}, ; 165
	%struct.DSOCacheEntry {
		i64 u0x152499e0b6aaca80, ; from name: libaot-Xamarin.AndroidX.CursorAdapter
		i64 u0xdf3c491694996c7e, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.110_name, ; name: libaot-Xamarin.AndroidX.CursorAdapter.dll.so
		ptr null; void* handle
	}, ; 166
	%struct.DSOCacheEntry {
		i64 u0x152a448bd1e745a7, ; from name: Microsoft.Win32.Primitives
		i64 u0x6f3638b02afc00cc, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.133_name, ; name: libaot-Microsoft.Win32.Primitives.dll.so
		ptr null; void* handle
	}, ; 167
	%struct.DSOCacheEntry {
		i64 u0x156ae2b2e8a39884, ; from name: libaot-Mono.Android.Runtime.dll.so
		i64 u0x156ae2b2e8a39884, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.225_name, ; name: libaot-Mono.Android.Runtime.dll.so
		ptr null; void* handle
	}, ; 168
	%struct.DSOCacheEntry {
		i64 u0x156bae1c4fa07237, ; from name: Microsoft.Extensions.DependencyInjection.Abstractions.so
		i64 u0x4643d8f925d8e6b7, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.55_name, ; name: libaot-Microsoft.Extensions.DependencyInjection.Abstractions.dll.so
		ptr null; void* handle
	}, ; 169
	%struct.DSOCacheEntry {
		i64 u0x15b7687b1b97ecdb, ; from name: libaot-Syncfusion.Maui.Sliders.so
		i64 u0x8e1c0d0116b3ef4b, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.92_name, ; name: libaot-Syncfusion.Maui.Sliders.dll.so
		ptr null; void* handle
	}, ; 170
	%struct.DSOCacheEntry {
		i64 u0x16262857ad9a2e54, ; from name: libaot-System.Text.Encoding.CodePages.dll.so
		i64 u0x16262857ad9a2e54, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.205_name, ; name: libaot-System.Text.Encoding.CodePages.dll.so
		ptr null; void* handle
	}, ; 171
	%struct.DSOCacheEntry {
		i64 u0x166548a3bdb16da4, ; from name: aot-Microsoft.AspNetCore.Http.Connections.Client
		i64 u0x14283e2d731a896b, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.29_name, ; name: libaot-Microsoft.AspNetCore.Http.Connections.Client.dll.so
		ptr null; void* handle
	}, ; 172
	%struct.DSOCacheEntry {
		i64 u0x1684415041c33252, ; from name: libaot-Microsoft.IdentityModel.Protocols.OpenIdConnect
		i64 u0xbe90bee1d67c825c, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.73_name, ; name: libaot-Microsoft.IdentityModel.Protocols.OpenIdConnect.dll.so
		ptr null; void* handle
	}, ; 173
	%struct.DSOCacheEntry {
		i64 u0x1685aabb13d5887b, ; from name: aot-Microsoft.Extensions.Http.dll.so
		i64 u0x24aa3d6e3cd1bcb7, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.61_name, ; name: libaot-Microsoft.Extensions.Http.dll.so
		ptr null; void* handle
	}, ; 174
	%struct.DSOCacheEntry {
		i64 u0x16be0ff40bd01406, ; from name: aot-System.Security.Cryptography.Csp.so
		i64 u0xb259133b67649ff8, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.199_name, ; name: libaot-System.Security.Cryptography.Csp.dll.so
		ptr null; void* handle
	}, ; 175
	%struct.DSOCacheEntry {
		i64 u0x16be17bb8f8cc33c, ; from name: aot-Microsoft.AspNetCore.Mvc.Core
		i64 u0xffcb4d21a593e637, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.34_name, ; name: libaot-Microsoft.AspNetCore.Mvc.Core.dll.so
		ptr null; void* handle
	}, ; 176
	%struct.DSOCacheEntry {
		i64 u0x16c6b76fd2defe97, ; from name: aot-Xamarin.KotlinX.Coroutines.Core.Jvm.dll.so
		i64 u0x811e0efc0e57d069, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.130_name, ; name: libaot-Xamarin.KotlinX.Coroutines.Core.Jvm.dll.so
		ptr null; void* handle
	}, ; 177
	%struct.DSOCacheEntry {
		i64 u0x16ea2b318ad2d830, ; from name: System.Security.Cryptography.Algorithms
		i64 u0xd9a989573240dd9c, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.197_name, ; name: libaot-System.Security.Cryptography.Algorithms.dll.so
		ptr null; void* handle
	}, ; 178
	%struct.DSOCacheEntry {
		i64 u0x1734e487a59cd0d3, ; from name: CommunityToolkit.Maui.Core.dll.so
		i64 u0x1f7f7b0e04fbedb0, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.15_name, ; name: libaot-CommunityToolkit.Maui.Core.dll.so
		ptr null; void* handle
	}, ; 179
	%struct.DSOCacheEntry {
		i64 u0x17470479fc19918f, ; from name: aot-System.Security.Cryptography.Cng.dll.so
		i64 u0xe4a5a519ffe8b5e9, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.198_name, ; name: libaot-System.Security.Cryptography.Cng.dll.so
		ptr null; void* handle
	}, ; 180
	%struct.DSOCacheEntry {
		i64 u0x17e2f55baca7be29, ; from name: Microsoft.Win32.Primitives.so
		i64 u0x6f3638b02afc00cc, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.133_name, ; name: libaot-Microsoft.Win32.Primitives.dll.so
		ptr null; void* handle
	}, ; 181
	%struct.DSOCacheEntry {
		i64 u0x17ed001377a045c5, ; from name: aot-Microsoft.Extensions.Logging.Abstractions.dll.so
		i64 u0xe6757a5fac324e53, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.63_name, ; name: libaot-Microsoft.Extensions.Logging.Abstractions.dll.so
		ptr null; void* handle
	}, ; 182
	%struct.DSOCacheEntry {
		i64 u0x17ef7d0bc0907bbd, ; from name: libaot-Microsoft.AspNetCore.Routing.Abstractions.so
		i64 u0x03ea24da2517cfb9, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.37_name, ; name: libaot-Microsoft.AspNetCore.Routing.Abstractions.dll.so
		ptr null; void* handle
	}, ; 183
	%struct.DSOCacheEntry {
		i64 u0x17f9358913beb16a, ; from name: System.Text.Encodings.Web
		i64 u0x209bcec5b3b022b8, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.207_name, ; name: libaot-System.Text.Encodings.Web.dll.so
		ptr null; void* handle
	}, ; 184
	%struct.DSOCacheEntry {
		i64 u0x1804f7867242abe9, ; from name: libaot-CommunityToolkit.Maui.Core
		i64 u0x1f7f7b0e04fbedb0, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.15_name, ; name: libaot-CommunityToolkit.Maui.Core.dll.so
		ptr null; void* handle
	}, ; 185
	%struct.DSOCacheEntry {
		i64 u0x180c42cd5bb24654, ; from name: libaot-Microsoft.CSharp
		i64 u0xe38bfeec71b3b67d, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.132_name, ; name: libaot-Microsoft.CSharp.dll.so
		ptr null; void* handle
	}, ; 186
	%struct.DSOCacheEntry {
		i64 u0x1823d47dbb2ff9c2, ; from name: aot-System.Runtime.Serialization.Json.so
		i64 u0xe012402cc380eac2, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.191_name, ; name: libaot-System.Runtime.Serialization.Json.dll.so
		ptr null; void* handle
	}, ; 187
	%struct.DSOCacheEntry {
		i64 u0x18596f9bfb8c7071, ; from name: aot-System.Diagnostics.TraceSource.so
		i64 u0x2119cc81025daa05, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.149_name, ; name: libaot-System.Diagnostics.TraceSource.dll.so
		ptr null; void* handle
	}, ; 188
	%struct.DSOCacheEntry {
		i64 u0x18a9befae51bb361, ; from name: System.Net.WebClient
		i64 u0x4ce9b13ddea58a1b, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.172_name, ; name: libaot-System.Net.WebClient.dll.so
		ptr null; void* handle
	}, ; 189
	%struct.DSOCacheEntry {
		i64 u0x18cfb7dd091f7614, ; from name: libaot-Microsoft.CSharp.so
		i64 u0xe38bfeec71b3b67d, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.132_name, ; name: libaot-Microsoft.CSharp.dll.so
		ptr null; void* handle
	}, ; 190
	%struct.DSOCacheEntry {
		i64 u0x18e7051cd64db722, ; from name: libaot-System.Diagnostics.Process.so
		i64 u0x8657799bb82e0573, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.147_name, ; name: libaot-System.Diagnostics.Process.dll.so
		ptr null; void* handle
	}, ; 191
	%struct.DSOCacheEntry {
		i64 u0x18facb3695ca9224, ; from name: Refit.HttpClientFactory
		i64 u0xbf4b844c69db6ec0, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.84_name, ; name: libaot-Refit.HttpClientFactory.dll.so
		ptr null; void* handle
	}, ; 192
	%struct.DSOCacheEntry {
		i64 u0x1905f599ab0f9729, ; from name: Microsoft.IdentityModel.Protocols.OpenIdConnect.so
		i64 u0xbe90bee1d67c825c, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.73_name, ; name: libaot-Microsoft.IdentityModel.Protocols.OpenIdConnect.dll.so
		ptr null; void* handle
	}, ; 193
	%struct.DSOCacheEntry {
		i64 u0x1950e5b035ef73cf, ; from name: Microsoft.AspNetCore.Http.Connections.Client.so
		i64 u0x14283e2d731a896b, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.29_name, ; name: libaot-Microsoft.AspNetCore.Http.Connections.Client.dll.so
		ptr null; void* handle
	}, ; 194
	%struct.DSOCacheEntry {
		i64 u0x195f8312b1c63709, ; from name: libaot-netstandard
		i64 u0xb6ab21527197f7f1, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.223_name, ; name: libaot-netstandard.dll.so
		ptr null; void* handle
	}, ; 195
	%struct.DSOCacheEntry {
		i64 u0x196338a2842bd7c6, ; from name: System.Xml.XmlSerializer.dll.so
		i64 u0xdfef1aaab339ffdb, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.220_name, ; name: libaot-System.Xml.XmlSerializer.dll.so
		ptr null; void* handle
	}, ; 196
	%struct.DSOCacheEntry {
		i64 u0x19a4c090f14ebb66, ; from name: System.Security.Claims
		i64 u0xd1ca18d995b9f417, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.196_name, ; name: libaot-System.Security.Claims.dll.so
		ptr null; void* handle
	}, ; 197
	%struct.DSOCacheEntry {
		i64 u0x19b0205ccf6ae386, ; from name: aot-System.Net.NetworkInformation.so
		i64 u0xb1bf28cdcefab46b, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.167_name, ; name: libaot-System.Net.NetworkInformation.dll.so
		ptr null; void* handle
	}, ; 198
	%struct.DSOCacheEntry {
		i64 u0x19c63b4499e6a1bc, ; from name: aot-System.Security.Cryptography.X509Certificates.dll.so
		i64 u0x86ff945e422694f9, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.202_name, ; name: libaot-System.Security.Cryptography.X509Certificates.dll.so
		ptr null; void* handle
	}, ; 199
	%struct.DSOCacheEntry {
		i64 u0x19cefc660d4f7334, ; from name: libaot-System.Drawing.Primitives.so
		i64 u0x934cbfda9b40e895, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.151_name, ; name: libaot-System.Drawing.Primitives.dll.so
		ptr null; void* handle
	}, ; 200
	%struct.DSOCacheEntry {
		i64 u0x1a3a02b3bd44fd91, ; from name: aot-Microsoft.AspNetCore.WebUtilities
		i64 u0xa1fa4ded3d9c2cee, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.43_name, ; name: libaot-Microsoft.AspNetCore.WebUtilities.dll.so
		ptr null; void* handle
	}, ; 201
	%struct.DSOCacheEntry {
		i64 u0x1a6fceea64859810, ; from name: Azure.Identity
		i64 u0xf309d7d68dc0ac48, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.13_name, ; name: libaot-Azure.Identity.dll.so
		ptr null; void* handle
	}, ; 202
	%struct.DSOCacheEntry {
		i64 u0x1aca295512ed031f, ; from name: aot-System.Runtime.Numerics
		i64 u0x6619888793b3b2dd, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.189_name, ; name: libaot-System.Runtime.Numerics.dll.so
		ptr null; void* handle
	}, ; 203
	%struct.DSOCacheEntry {
		i64 u0x1adc5c3038254713, ; from name: libaot-Xamarin.AndroidX.Collection.Jvm.dll.so
		i64 u0x1adc5c3038254713, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.107_name, ; name: libaot-Xamarin.AndroidX.Collection.Jvm.dll.so
		ptr null; void* handle
	}, ; 204
	%struct.DSOCacheEntry {
		i64 u0x1b250aad159a44a9, ; from name: aot-Azure.Identity.dll.so
		i64 u0xf309d7d68dc0ac48, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.13_name, ; name: libaot-Azure.Identity.dll.so
		ptr null; void* handle
	}, ; 205
	%struct.DSOCacheEntry {
		i64 u0x1b2c9f62fc290969, ; from name: System.IO.Pipelines.dll.so
		i64 u0x027079cd6cbb2479, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.158_name, ; name: libaot-System.IO.Pipelines.dll.so
		ptr null; void* handle
	}, ; 206
	%struct.DSOCacheEntry {
		i64 u0x1b3005759978ff72, ; from name: Xamarin.AndroidX.Core.dll.so
		i64 u0x28a319e875b39488, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.109_name, ; name: libaot-Xamarin.AndroidX.Core.dll.so
		ptr null; void* handle
	}, ; 207
	%struct.DSOCacheEntry {
		i64 u0x1b377599ed9b132c, ; from name: Microsoft.EntityFrameworkCore.Relational.dll.so
		i64 u0xc114e8a396f5423b, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.48_name, ; name: libaot-Microsoft.EntityFrameworkCore.Relational.dll.so
		ptr null; void* handle
	}, ; 208
	%struct.DSOCacheEntry {
		i64 u0x1b638d6fefb16c1a, ; from name: System.Security.Cryptography.ProtectedData.so
		i64 u0x67faf2828acf47d0, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.101_name, ; name: libaot-System.Security.Cryptography.ProtectedData.dll.so
		ptr null; void* handle
	}, ; 209
	%struct.DSOCacheEntry {
		i64 u0x1b7f5711466dc823, ; from name: aot-System.Xml.ReaderWriter
		i64 u0xdfabadcf47a52f12, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.218_name, ; name: libaot-System.Xml.ReaderWriter.dll.so
		ptr null; void* handle
	}, ; 210
	%struct.DSOCacheEntry {
		i64 u0x1bb86c20cc9f1aa0, ; from name: libaot-Xamarin.AndroidX.ViewPager2.so
		i64 u0x4595d9c27242b287, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.127_name, ; name: libaot-Xamarin.AndroidX.ViewPager2.dll.so
		ptr null; void* handle
	}, ; 211
	%struct.DSOCacheEntry {
		i64 u0x1bea5a36aa1ed8de, ; from name: Microsoft.AspNetCore.Http.Extensions
		i64 u0xf01d9d74cda0b70d, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.31_name, ; name: libaot-Microsoft.AspNetCore.Http.Extensions.dll.so
		ptr null; void* handle
	}, ; 212
	%struct.DSOCacheEntry {
		i64 u0x1c00c9eacce595bd, ; from name: aot-System.IO.Pipes.so
		i64 u0x370b7031653c1807, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.159_name, ; name: libaot-System.IO.Pipes.dll.so
		ptr null; void* handle
	}, ; 213
	%struct.DSOCacheEntry {
		i64 u0x1c1ac528b88ff6de, ; from name: libaot-SQLitePCLRaw.batteries_v2.so
		i64 u0x418d89fb2901d219, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.85_name, ; name: libaot-SQLitePCLRaw.batteries_v2.dll.so
		ptr null; void* handle
	}, ; 214
	%struct.DSOCacheEntry {
		i64 u0x1c27a36138302cbd, ; from name: aot-System.Transactions.Local.dll.so
		i64 u0x5425eb433f599bc7, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.215_name, ; name: libaot-System.Transactions.Local.dll.so
		ptr null; void* handle
	}, ; 215
	%struct.DSOCacheEntry {
		i64 u0x1c30b014739791ca, ; from name: System.Runtime.InteropServices.RuntimeInformation.dll.so
		i64 u0x6aae90d5594500a9, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.186_name, ; name: libaot-System.Runtime.InteropServices.RuntimeInformation.dll.so
		ptr null; void* handle
	}, ; 216
	%struct.DSOCacheEntry {
		i64 u0x1c85d9056edd583c, ; from name: aot-Microsoft.IdentityModel.Logging.dll.so
		i64 u0x1175872aaf2edbfe, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.71_name, ; name: libaot-Microsoft.IdentityModel.Logging.dll.so
		ptr null; void* handle
	}, ; 217
	%struct.DSOCacheEntry {
		i64 u0x1c8729b8f043593a, ; from name: aot-Microsoft.Data.SqlClient.dll.so
		i64 u0x0b7c60fbe9d8f09b, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.45_name, ; name: libaot-Microsoft.Data.SqlClient.dll.so
		ptr null; void* handle
	}, ; 218
	%struct.DSOCacheEntry {
		i64 u0x1ca7c8e8bfb4aeba, ; from name: aot-Microsoft.EntityFrameworkCore.SqlServer.so
		i64 u0x9daa39a878308c98, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.49_name, ; name: libaot-Microsoft.EntityFrameworkCore.SqlServer.dll.so
		ptr null; void* handle
	}, ; 219
	%struct.DSOCacheEntry {
		i64 u0x1cb5727558458466, ; from name: aot-System.Collections.NonGeneric
		i64 u0x6fd15fb6a42c9afc, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.137_name, ; name: libaot-System.Collections.NonGeneric.dll.so
		ptr null; void* handle
	}, ; 220
	%struct.DSOCacheEntry {
		i64 u0x1cd48cd32f83ebc0, ; from name: System.Runtime.Serialization.Primitives.so
		i64 u0xbd30caec9108afc1, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.192_name, ; name: libaot-System.Runtime.Serialization.Primitives.dll.so
		ptr null; void* handle
	}, ; 221
	%struct.DSOCacheEntry {
		i64 u0x1ce63460face970b, ; from name: System.Private.DataContractSerialization.dll.so
		i64 u0x8fa52587768c02e7, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.178_name, ; name: libaot-System.Private.DataContractSerialization.dll.so
		ptr null; void* handle
	}, ; 222
	%struct.DSOCacheEntry {
		i64 u0x1ced687e60cd4c7a, ; from name: aot-System.Buffers
		i64 u0x5988bd4997e5d75f, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.134_name, ; name: libaot-System.Buffers.dll.so
		ptr null; void* handle
	}, ; 223
	%struct.DSOCacheEntry {
		i64 u0x1d0f80d47ad62918, ; from name: libaot-Microsoft.AspNetCore.Routing.so
		i64 u0x6872149aac83968a, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.36_name, ; name: libaot-Microsoft.AspNetCore.Routing.dll.so
		ptr null; void* handle
	}, ; 224
	%struct.DSOCacheEntry {
		i64 u0x1d61915f1ef4bf5f, ; from name: libaot-System.Text.Encoding.Extensions
		i64 u0xf89ed8fc2f5b4b33, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.206_name, ; name: libaot-System.Text.Encoding.Extensions.dll.so
		ptr null; void* handle
	}, ; 225
	%struct.DSOCacheEntry {
		i64 u0x1d711f330f5778d7, ; from name: libaot-Microsoft.AspNetCore.SignalR.Common.dll.so
		i64 u0x1d711f330f5778d7, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.40_name, ; name: libaot-Microsoft.AspNetCore.SignalR.Common.dll.so
		ptr null; void* handle
	}, ; 226
	%struct.DSOCacheEntry {
		i64 u0x1dbb0c2c6a999acb, ; from name: System.Diagnostics.StackTrace
		i64 u0xb21e783430e22a93, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.148_name, ; name: libaot-System.Diagnostics.StackTrace.dll.so
		ptr null; void* handle
	}, ; 227
	%struct.DSOCacheEntry {
		i64 u0x1de8b67ac7aff98b, ; from name: aot-Microsoft.Bcl.AsyncInterfaces.dll.so
		i64 u0x9b7e93363193afd3, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.44_name, ; name: libaot-Microsoft.Bcl.AsyncInterfaces.dll.so
		ptr null; void* handle
	}, ; 228
	%struct.DSOCacheEntry {
		i64 u0x1dea1468473ca97f, ; from name: libaot-Microsoft.AspNetCore.WebUtilities
		i64 u0xa1fa4ded3d9c2cee, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.43_name, ; name: libaot-Microsoft.AspNetCore.WebUtilities.dll.so
		ptr null; void* handle
	}, ; 229
	%struct.DSOCacheEntry {
		i64 u0x1e0aaefde563ebcb, ; from name: System.Net.ServerSentEvents.so
		i64 u0x95302b4a91a9ea47, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.99_name, ; name: libaot-System.Net.ServerSentEvents.dll.so
		ptr null; void* handle
	}, ; 230
	%struct.DSOCacheEntry {
		i64 u0x1e3d87657e9659bc, ; from name: Xamarin.AndroidX.Navigation.UI
		i64 u0x21b741f2635aa744, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.122_name, ; name: libaot-Xamarin.AndroidX.Navigation.UI.dll.so
		ptr null; void* handle
	}, ; 231
	%struct.DSOCacheEntry {
		i64 u0x1e821bd8427d5c24, ; from name: aot-System.Runtime.InteropServices
		i64 u0x5ae6db1ddadc230b, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.187_name, ; name: libaot-System.Runtime.InteropServices.dll.so
		ptr null; void* handle
	}, ; 232
	%struct.DSOCacheEntry {
		i64 u0x1eae2887c70ee54b, ; from name: aot-Microsoft.Extensions.DependencyInjection
		i64 u0xe8726752705c8ce9, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.54_name, ; name: libaot-Microsoft.Extensions.DependencyInjection.dll.so
		ptr null; void* handle
	}, ; 233
	%struct.DSOCacheEntry {
		i64 u0x1edaba9aef61838a, ; from name: System.Security.Cryptography.X509Certificates.dll.so
		i64 u0x86ff945e422694f9, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.202_name, ; name: libaot-System.Security.Cryptography.X509Certificates.dll.so
		ptr null; void* handle
	}, ; 234
	%struct.DSOCacheEntry {
		i64 u0x1f019f98c6ecf80a, ; from name: System.Net.WebSockets.dll.so
		i64 u0x403cd01c6fb39d89, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.175_name, ; name: libaot-System.Net.WebSockets.dll.so
		ptr null; void* handle
	}, ; 235
	%struct.DSOCacheEntry {
		i64 u0x1f055d15d807e1b2, ; from name: System.Xml.XmlSerializer
		i64 u0xdfef1aaab339ffdb, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.220_name, ; name: libaot-System.Xml.XmlSerializer.dll.so
		ptr null; void* handle
	}, ; 236
	%struct.DSOCacheEntry {
		i64 u0x1f7670688ad6fa9a, ; from name: aot-System.Configuration.ConfigurationManager.dll.so
		i64 u0x5d3a5af149aed459, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.96_name, ; name: libaot-System.Configuration.ConfigurationManager.dll.so
		ptr null; void* handle
	}, ; 237
	%struct.DSOCacheEntry {
		i64 u0x1f7f7b0e04fbedb0, ; from name: libaot-CommunityToolkit.Maui.Core.dll.so
		i64 u0x1f7f7b0e04fbedb0, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.15_name, ; name: libaot-CommunityToolkit.Maui.Core.dll.so
		ptr null; void* handle
	}, ; 238
	%struct.DSOCacheEntry {
		i64 u0x1fc7bca32ed3d697, ; from name: Xamarin.AndroidX.SavedState.so
		i64 u0x039588659cdd2f6a, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.124_name, ; name: libaot-Xamarin.AndroidX.SavedState.dll.so
		ptr null; void* handle
	}, ; 239
	%struct.DSOCacheEntry {
		i64 u0x209bcec5b3b022b8, ; from name: libaot-System.Text.Encodings.Web.dll.so
		i64 u0x209bcec5b3b022b8, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.207_name, ; name: libaot-System.Text.Encodings.Web.dll.so
		ptr null; void* handle
	}, ; 240
	%struct.DSOCacheEntry {
		i64 u0x2119cc81025daa05, ; from name: libaot-System.Diagnostics.TraceSource.dll.so
		i64 u0x2119cc81025daa05, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.149_name, ; name: libaot-System.Diagnostics.TraceSource.dll.so
		ptr null; void* handle
	}, ; 241
	%struct.DSOCacheEntry {
		i64 u0x211bdd5d55e8484b, ; from name: aot-System.Private.Uri.so
		i64 u0xe57af9ab00f5c61d, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.179_name, ; name: libaot-System.Private.Uri.dll.so
		ptr null; void* handle
	}, ; 242
	%struct.DSOCacheEntry {
		i64 u0x216cca4ddc9faa6f, ; from name: aot-System.Runtime.Numerics.dll.so
		i64 u0x6619888793b3b2dd, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.189_name, ; name: libaot-System.Runtime.Numerics.dll.so
		ptr null; void* handle
	}, ; 243
	%struct.DSOCacheEntry {
		i64 u0x217057a17941f171, ; from name: aot-Microsoft.Maui.dll.so
		i64 u0x58cd310024b735d8, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.77_name, ; name: libaot-Microsoft.Maui.dll.so
		ptr null; void* handle
	}, ; 244
	%struct.DSOCacheEntry {
		i64 u0x2174319c0d835bc9, ; from name: System.Runtime
		i64 u0xbbc0e6e747d7877a, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.194_name, ; name: libaot-System.Runtime.dll.so
		ptr null; void* handle
	}, ; 245
	%struct.DSOCacheEntry {
		i64 u0x218e9a3380a71ba1, ; from name: Microsoft.AspNetCore.Authorization.dll.so
		i64 u0x93d2678ac2e76ce0, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.22_name, ; name: libaot-Microsoft.AspNetCore.Authorization.dll.so
		ptr null; void* handle
	}, ; 246
	%struct.DSOCacheEntry {
		i64 u0x21b67f975a60e15a, ; from name: libaot-System.Text.RegularExpressions
		i64 u0x7c2c39dae387b52d, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.209_name, ; name: libaot-System.Text.RegularExpressions.dll.so
		ptr null; void* handle
	}, ; 247
	%struct.DSOCacheEntry {
		i64 u0x21b741f2635aa744, ; from name: libaot-Xamarin.AndroidX.Navigation.UI.dll.so
		i64 u0x21b741f2635aa744, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.122_name, ; name: libaot-Xamarin.AndroidX.Navigation.UI.dll.so
		ptr null; void* handle
	}, ; 248
	%struct.DSOCacheEntry {
		i64 u0x21bfe38d456b5dd0, ; from name: System.Net.NameResolution.so
		i64 u0x7f280e9be5453eba, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.166_name, ; name: libaot-System.Net.NameResolution.dll.so
		ptr null; void* handle
	}, ; 249
	%struct.DSOCacheEntry {
		i64 u0x21cc7e445dcd5469, ; from name: System.Reflection.Emit.ILGeneration
		i64 u0xbba986a49febf640, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.182_name, ; name: libaot-System.Reflection.Emit.ILGeneration.dll.so
		ptr null; void* handle
	}, ; 250
	%struct.DSOCacheEntry {
		i64 u0x21d00d18267384f6, ; from name: System.Reflection.Emit.Lightweight.so
		i64 u0x54f7fbd0a81833fe, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.183_name, ; name: libaot-System.Reflection.Emit.Lightweight.dll.so
		ptr null; void* handle
	}, ; 251
	%struct.DSOCacheEntry {
		i64 u0x21e69a2f90497736, ; from name: aot-System.Threading.Tasks.Extensions.dll.so
		i64 u0x51aad7b1eaf4d2ae, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.211_name, ; name: libaot-System.Threading.Tasks.Extensions.dll.so
		ptr null; void* handle
	}, ; 252
	%struct.DSOCacheEntry {
		i64 u0x221f6e73bbac7db8, ; from name: libaot-Syncfusion.Maui.Toolkit.resources.so
		i64 u0xa56606bb1f125004, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.94_name, ; name: libaot-Syncfusion.Maui.Toolkit.resources.dll.so
		ptr null; void* handle
	}, ; 253
	%struct.DSOCacheEntry {
		i64 u0x224538d85ed15a82, ; from name: System.IO.Pipes
		i64 u0x370b7031653c1807, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.159_name, ; name: libaot-System.IO.Pipes.dll.so
		ptr null; void* handle
	}, ; 254
	%struct.DSOCacheEntry {
		i64 u0x22626c401e88babc, ; from name: libaot-System.Threading.Thread
		i64 u0x675935a1e3b604dc, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.212_name, ; name: libaot-System.Threading.Thread.dll.so
		ptr null; void* handle
	}, ; 255
	%struct.DSOCacheEntry {
		i64 u0x226902789b31a4cc, ; from name: libaot-System.Runtime.Serialization.Formatters
		i64 u0xc52860d1d6baa3ef, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.190_name, ; name: libaot-System.Runtime.Serialization.Formatters.dll.so
		ptr null; void* handle
	}, ; 256
	%struct.DSOCacheEntry {
		i64 u0x22a3223f263130dd, ; from name: aot-Xamarin.AndroidX.CursorAdapter
		i64 u0xdf3c491694996c7e, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.110_name, ; name: libaot-Xamarin.AndroidX.CursorAdapter.dll.so
		ptr null; void* handle
	}, ; 257
	%struct.DSOCacheEntry {
		i64 u0x22b972266f0b9877, ; from name: aot-Xamarin.KotlinX.Serialization.Core.Jvm
		i64 u0x757898ba637db46e, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.131_name, ; name: libaot-Xamarin.KotlinX.Serialization.Core.Jvm.dll.so
		ptr null; void* handle
	}, ; 258
	%struct.DSOCacheEntry {
		i64 u0x22ec53f5357b2b29, ; from name: Microsoft.Maui.Graphics.so
		i64 u0x285d22da351d937a, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.79_name, ; name: libaot-Microsoft.Maui.Graphics.dll.so
		ptr null; void* handle
	}, ; 259
	%struct.DSOCacheEntry {
		i64 u0x22ff7277fc097f80, ; from name: aot-Xamarin.AndroidX.Navigation.Fragment.so
		i64 u0xaa2eca1145f3a7cc, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.120_name, ; name: libaot-Xamarin.AndroidX.Navigation.Fragment.dll.so
		ptr null; void* handle
	}, ; 260
	%struct.DSOCacheEntry {
		i64 u0x235fb4941dc174e1, ; from name: DocumentFormat.OpenXml
		i64 u0x456cc421e6ef3bb7, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.17_name, ; name: libaot-DocumentFormat.OpenXml.dll.so
		ptr null; void* handle
	}, ; 261
	%struct.DSOCacheEntry {
		i64 u0x236c564210fa9814, ; from name: aot-Microsoft.AspNetCore.SignalR.Client.Core.dll.so
		i64 u0x0e46bd4e008c7b33, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.39_name, ; name: libaot-Microsoft.AspNetCore.SignalR.Client.Core.dll.so
		ptr null; void* handle
	}, ; 262
	%struct.DSOCacheEntry {
		i64 u0x2407aef2bbe8fadf, ; from name: System.Console
		i64 u0xc2da5dca6ccd8b0a, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.144_name, ; name: libaot-System.Console.dll.so
		ptr null; void* handle
	}, ; 263
	%struct.DSOCacheEntry {
		i64 u0x24124a37643ce273, ; from name: libaot-Microsoft.Extensions.Http.so
		i64 u0x24aa3d6e3cd1bcb7, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.61_name, ; name: libaot-Microsoft.Extensions.Http.dll.so
		ptr null; void* handle
	}, ; 264
	%struct.DSOCacheEntry {
		i64 u0x2436aed1e86579d5, ; from name: aot-Xamarin.AndroidX.Fragment.so
		i64 u0x8ab6d3431da5497e, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.113_name, ; name: libaot-Xamarin.AndroidX.Fragment.dll.so
		ptr null; void* handle
	}, ; 265
	%struct.DSOCacheEntry {
		i64 u0x2455f7a96b10f6f8, ; from name: aot-Xamarin.AndroidX.Navigation.Fragment.dll.so
		i64 u0xaa2eca1145f3a7cc, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.120_name, ; name: libaot-Xamarin.AndroidX.Navigation.Fragment.dll.so
		ptr null; void* handle
	}, ; 266
	%struct.DSOCacheEntry {
		i64 u0x2457561d6ef924e4, ; from name: libaot-System.ObjectModel
		i64 u0x914167d87d2ee1b1, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.177_name, ; name: libaot-System.ObjectModel.dll.so
		ptr null; void* handle
	}, ; 267
	%struct.DSOCacheEntry {
		i64 u0x24aa3d6e3cd1bcb7, ; from name: libaot-Microsoft.Extensions.Http.dll.so
		i64 u0x24aa3d6e3cd1bcb7, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.61_name, ; name: libaot-Microsoft.Extensions.Http.dll.so
		ptr null; void* handle
	}, ; 268
	%struct.DSOCacheEntry {
		i64 u0x24b142306c30fa65, ; from name: aot-System.Xml.ReaderWriter.dll.so
		i64 u0xdfabadcf47a52f12, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.218_name, ; name: libaot-System.Xml.ReaderWriter.dll.so
		ptr null; void* handle
	}, ; 269
	%struct.DSOCacheEntry {
		i64 u0x24d0e9e79a2af3bb, ; from name: libaot-Xamarin.AndroidX.RecyclerView.so
		i64 u0x34c6f5c746796bcc, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.123_name, ; name: libaot-Xamarin.AndroidX.RecyclerView.dll.so
		ptr null; void* handle
	}, ; 270
	%struct.DSOCacheEntry {
		i64 u0x25209aad1ac22ee1, ; from name: aot-Microsoft.Maui.Graphics.dll.so
		i64 u0x285d22da351d937a, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.79_name, ; name: libaot-Microsoft.Maui.Graphics.dll.so
		ptr null; void* handle
	}, ; 271
	%struct.DSOCacheEntry {
		i64 u0x255f1c7d8104f517, ; from name: System.IO.FileSystem.Watcher.dll.so
		i64 u0xf90aa99869639df6, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.157_name, ; name: libaot-System.IO.FileSystem.Watcher.dll.so
		ptr null; void* handle
	}, ; 272
	%struct.DSOCacheEntry {
		i64 u0x2565c4c3b04e33e0, ; from name: aot-System.ComponentModel.Annotations.so
		i64 u0xbf7d944f85fcd72c, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.140_name, ; name: libaot-System.ComponentModel.Annotations.dll.so
		ptr null; void* handle
	}, ; 273
	%struct.DSOCacheEntry {
		i64 u0x25bbda833aad1ef7, ; from name: aot-Microsoft.AspNetCore.Http.Connections.Common.so
		i64 u0x726b54f946bf0d7f, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.30_name, ; name: libaot-Microsoft.AspNetCore.Http.Connections.Common.dll.so
		ptr null; void* handle
	}, ; 274
	%struct.DSOCacheEntry {
		i64 u0x2604cf15d10cf90e, ; from name: aot-System.Net.Sockets
		i64 u0x4c5401149da6445e, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.171_name, ; name: libaot-System.Net.Sockets.dll.so
		ptr null; void* handle
	}, ; 275
	%struct.DSOCacheEntry {
		i64 u0x26184d87c573ae59, ; from name: libaot-System.Text.Encoding.CodePages
		i64 u0x16262857ad9a2e54, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.205_name, ; name: libaot-System.Text.Encoding.CodePages.dll.so
		ptr null; void* handle
	}, ; 276
	%struct.DSOCacheEntry {
		i64 u0x2637d01698b88562, ; from name: System.Xml.ReaderWriter.so
		i64 u0xdfabadcf47a52f12, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.218_name, ; name: libaot-System.Xml.ReaderWriter.dll.so
		ptr null; void* handle
	}, ; 277
	%struct.DSOCacheEntry {
		i64 u0x264b762748509921, ; from name: aot-System.Reflection.Primitives.so
		i64 u0x8c58bd1a08c146f5, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.185_name, ; name: libaot-System.Reflection.Primitives.dll.so
		ptr null; void* handle
	}, ; 278
	%struct.DSOCacheEntry {
		i64 u0x26c55ff4d4f2c9d8, ; from name: Xamarin.AndroidX.Navigation.Runtime.so
		i64 u0x79a319cd6e76a263, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.121_name, ; name: libaot-Xamarin.AndroidX.Navigation.Runtime.dll.so
		ptr null; void* handle
	}, ; 279
	%struct.DSOCacheEntry {
		i64 u0x26e0e41b0cb0afb6, ; from name: aot-Microsoft.AspNetCore.SignalR.Protocols.Json.so
		i64 u0x53a8edd5eb823442, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.42_name, ; name: libaot-Microsoft.AspNetCore.SignalR.Protocols.Json.dll.so
		ptr null; void* handle
	}, ; 280
	%struct.DSOCacheEntry {
		i64 u0x270a44600c921861, ; from name: System.IdentityModel.Tokens.Jwt
		i64 u0xe05faae6d518aca9, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.97_name, ; name: libaot-System.IdentityModel.Tokens.Jwt.dll.so
		ptr null; void* handle
	}, ; 281
	%struct.DSOCacheEntry {
		i64 u0x27156e1cff2696e3, ; from name: libaot-System.Text.Encoding.Extensions.so
		i64 u0xf89ed8fc2f5b4b33, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.206_name, ; name: libaot-System.Text.Encoding.Extensions.dll.so
		ptr null; void* handle
	}, ; 282
	%struct.DSOCacheEntry {
		i64 u0x2716d09d94ee3b13, ; from name: aot-Microsoft.Extensions.DependencyInjection.dll.so
		i64 u0xe8726752705c8ce9, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.54_name, ; name: libaot-Microsoft.Extensions.DependencyInjection.dll.so
		ptr null; void* handle
	}, ; 283
	%struct.DSOCacheEntry {
		i64 u0x2738d40e9dee8687, ; from name: libaot-Xamarin.AndroidX.Lifecycle.LiveData.Core
		i64 u0x38e4553d8764fa45, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.115_name, ; name: libaot-Xamarin.AndroidX.Lifecycle.LiveData.Core.dll.so
		ptr null; void* handle
	}, ; 284
	%struct.DSOCacheEntry {
		i64 u0x2759af78ab94d39b, ; from name: System.Net.WebSockets
		i64 u0x403cd01c6fb39d89, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.175_name, ; name: libaot-System.Net.WebSockets.dll.so
		ptr null; void* handle
	}, ; 285
	%struct.DSOCacheEntry {
		i64 u0x27a6eefa9a4dc4d9, ; from name: aot-System.Private.Xml.dll.so
		i64 u0x52bbd048717682d4, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.181_name, ; name: libaot-System.Private.Xml.dll.so
		ptr null; void* handle
	}, ; 286
	%struct.DSOCacheEntry {
		i64 u0x27b138373b635a00, ; from name: libaot-Xamarin.AndroidX.Navigation.UI.so
		i64 u0x21b741f2635aa744, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.122_name, ; name: libaot-Xamarin.AndroidX.Navigation.UI.dll.so
		ptr null; void* handle
	}, ; 287
	%struct.DSOCacheEntry {
		i64 u0x27e12ed78e1aa4ef, ; from name: Microsoft.AspNetCore.Connections.Abstractions.so
		i64 u0xb92f532b40f35614, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.24_name, ; name: libaot-Microsoft.AspNetCore.Connections.Abstractions.dll.so
		ptr null; void* handle
	}, ; 288
	%struct.DSOCacheEntry {
		i64 u0x280135ef9bf302b3, ; from name: Azure.Core.dll.so
		i64 u0x821f528a92d55dea, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.12_name, ; name: libaot-Azure.Core.dll.so
		ptr null; void* handle
	}, ; 289
	%struct.DSOCacheEntry {
		i64 u0x28371251d401372b, ; from name: libaot-System.Diagnostics.Tracing.dll.so
		i64 u0x28371251d401372b, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.150_name, ; name: libaot-System.Diagnostics.Tracing.dll.so
		ptr null; void* handle
	}, ; 290
	%struct.DSOCacheEntry {
		i64 u0x2839bf1d48ba1610, ; from name: libaot-Mono.HttpUtility.so
		i64 u0x475325afa16dbfe5, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.82_name, ; name: libaot-Mono.HttpUtility.dll.so
		ptr null; void* handle
	}, ; 291
	%struct.DSOCacheEntry {
		i64 u0x2849d252e4f42821, ; from name: aot-Xamarin.AndroidX.Core.so
		i64 u0x28a319e875b39488, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.109_name, ; name: libaot-Xamarin.AndroidX.Core.dll.so
		ptr null; void* handle
	}, ; 292
	%struct.DSOCacheEntry {
		i64 u0x285d22da351d937a, ; from name: libaot-Microsoft.Maui.Graphics.dll.so
		i64 u0x285d22da351d937a, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.79_name, ; name: libaot-Microsoft.Maui.Graphics.dll.so
		ptr null; void* handle
	}, ; 293
	%struct.DSOCacheEntry {
		i64 u0x2883eaede6f88cb7, ; from name: SocialMauiApp.dll.so
		i64 u0xec957d270d230c6a, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.11_name, ; name: libaot-SocialMauiApp.dll.so
		ptr null; void* handle
	}, ; 294
	%struct.DSOCacheEntry {
		i64 u0x28a319e875b39488, ; from name: libaot-Xamarin.AndroidX.Core.dll.so
		i64 u0x28a319e875b39488, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.109_name, ; name: libaot-Xamarin.AndroidX.Core.dll.so
		ptr null; void* handle
	}, ; 295
	%struct.DSOCacheEntry {
		i64 u0x28b311fffbc0f8df, ; from name: Microsoft.AspNetCore.WebUtilities
		i64 u0xa1fa4ded3d9c2cee, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.43_name, ; name: libaot-Microsoft.AspNetCore.WebUtilities.dll.so
		ptr null; void* handle
	}, ; 296
	%struct.DSOCacheEntry {
		i64 u0x28e25efdf7b4cc36, ; from name: System.Net.Primitives.so
		i64 u0xaac4801194f87f4f, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.168_name, ; name: libaot-System.Net.Primitives.dll.so
		ptr null; void* handle
	}, ; 297
	%struct.DSOCacheEntry {
		i64 u0x29221f1b7e80e99b, ; from name: aot-Microsoft.AspNetCore.Routing.Abstractions.so
		i64 u0x03ea24da2517cfb9, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.37_name, ; name: libaot-Microsoft.AspNetCore.Routing.Abstractions.dll.so
		ptr null; void* handle
	}, ; 298
	%struct.DSOCacheEntry {
		i64 u0x292dbd3dc8a0cf3b, ; from name: libaot-Xamarin.KotlinX.Coroutines.Core.Jvm.so
		i64 u0x811e0efc0e57d069, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.130_name, ; name: libaot-Xamarin.KotlinX.Coroutines.Core.Jvm.dll.so
		ptr null; void* handle
	}, ; 299
	%struct.DSOCacheEntry {
		i64 u0x293b771228b9eda5, ; from name: System.ClientModel.so
		i64 u0xa4d336a75ab12937, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.95_name, ; name: libaot-System.ClientModel.dll.so
		ptr null; void* handle
	}, ; 300
	%struct.DSOCacheEntry {
		i64 u0x29403abfad17ce90, ; from name: aot-Microsoft.EntityFrameworkCore.Relational
		i64 u0xc114e8a396f5423b, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.48_name, ; name: libaot-Microsoft.EntityFrameworkCore.Relational.dll.so
		ptr null; void* handle
	}, ; 301
	%struct.DSOCacheEntry {
		i64 u0x29511a2f7f74dca8, ; from name: System.ClientModel.dll.so
		i64 u0xa4d336a75ab12937, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.95_name, ; name: libaot-System.ClientModel.dll.so
		ptr null; void* handle
	}, ; 302
	%struct.DSOCacheEntry {
		i64 u0x2958664a4cf05d94, ; from name: aot-CommunityToolkit.Maui.so
		i64 u0x71a72d2d998e2673, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.14_name, ; name: libaot-CommunityToolkit.Maui.dll.so
		ptr null; void* handle
	}, ; 303
	%struct.DSOCacheEntry {
		i64 u0x29629cd3c238a2b4, ; from name: libaot-System.Security.Principal.Windows.dll.so
		i64 u0x29629cd3c238a2b4, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.204_name, ; name: libaot-System.Security.Principal.Windows.dll.so
		ptr null; void* handle
	}, ; 304
	%struct.DSOCacheEntry {
		i64 u0x296b1b52dc31db32, ; from name: aot-System.ClientModel.dll.so
		i64 u0xa4d336a75ab12937, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.95_name, ; name: libaot-System.ClientModel.dll.so
		ptr null; void* handle
	}, ; 305
	%struct.DSOCacheEntry {
		i64 u0x29a1c0ab32437ef5, ; from name: Xamarin.AndroidX.ViewPager.so
		i64 u0xb5351dcbaf438cb6, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.126_name, ; name: libaot-Xamarin.AndroidX.ViewPager.dll.so
		ptr null; void* handle
	}, ; 306
	%struct.DSOCacheEntry {
		i64 u0x29bfcb8834a1667a, ; from name: aot-DocumentFormat.OpenXml.Framework
		i64 u0xf959815fea0ec361, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.18_name, ; name: libaot-DocumentFormat.OpenXml.Framework.dll.so
		ptr null; void* handle
	}, ; 307
	%struct.DSOCacheEntry {
		i64 u0x2a1991ac3933773b, ; from name: aot-Microsoft.AspNetCore.SignalR.Core.so
		i64 u0x73dd04543af2c841, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.41_name, ; name: libaot-Microsoft.AspNetCore.SignalR.Core.dll.so
		ptr null; void* handle
	}, ; 308
	%struct.DSOCacheEntry {
		i64 u0x2a31933ec9712c6e, ; from name: libaot-Microsoft.Data.SqlClient
		i64 u0x0b7c60fbe9d8f09b, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.45_name, ; name: libaot-Microsoft.Data.SqlClient.dll.so
		ptr null; void* handle
	}, ; 309
	%struct.DSOCacheEntry {
		i64 u0x2a5fa8e1bac88d7a, ; from name: Microsoft.Bcl.AsyncInterfaces.dll.so
		i64 u0x9b7e93363193afd3, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.44_name, ; name: libaot-Microsoft.Bcl.AsyncInterfaces.dll.so
		ptr null; void* handle
	}, ; 310
	%struct.DSOCacheEntry {
		i64 u0x2a601e2d6636a68a, ; from name: aot-System.Threading.Tasks.Extensions
		i64 u0x51aad7b1eaf4d2ae, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.211_name, ; name: libaot-System.Threading.Tasks.Extensions.dll.so
		ptr null; void* handle
	}, ; 311
	%struct.DSOCacheEntry {
		i64 u0x2a60975f967613b9, ; from name: aot-System.Text.RegularExpressions.so
		i64 u0x7c2c39dae387b52d, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.209_name, ; name: libaot-System.Text.RegularExpressions.dll.so
		ptr null; void* handle
	}, ; 312
	%struct.DSOCacheEntry {
		i64 u0x2a6fc9f511ce6292, ; from name: libaot-System.Private.Xml
		i64 u0x52bbd048717682d4, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.181_name, ; name: libaot-System.Private.Xml.dll.so
		ptr null; void* handle
	}, ; 313
	%struct.DSOCacheEntry {
		i64 u0x2a8da1e7722aaaff, ; from name: libaot-System.Net.Requests.dll.so
		i64 u0x2a8da1e7722aaaff, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.169_name, ; name: libaot-System.Net.Requests.dll.so
		ptr null; void* handle
	}, ; 314
	%struct.DSOCacheEntry {
		i64 u0x2abacb2cf7e43c4e, ; from name: aot-Xamarin.AndroidX.Lifecycle.ViewModelSavedState
		i64 u0x9b809dc726e0140e, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.117_name, ; name: libaot-Xamarin.AndroidX.Lifecycle.ViewModelSavedState.dll.so
		ptr null; void* handle
	}, ; 315
	%struct.DSOCacheEntry {
		i64 u0x2ad17fd43a46b2da, ; from name: Microsoft.AspNetCore.Http.Abstractions.dll.so
		i64 u0x96d2838521668c05, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.28_name, ; name: libaot-Microsoft.AspNetCore.Http.Abstractions.dll.so
		ptr null; void* handle
	}, ; 316
	%struct.DSOCacheEntry {
		i64 u0x2ada1dcd5b757bc6, ; from name: libaot-DocumentFormat.OpenXml.VariableReplacer.Core.so
		i64 u0x785bad4f0559c250, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.19_name, ; name: libaot-DocumentFormat.OpenXml.VariableReplacer.Core.dll.so
		ptr null; void* handle
	}, ; 317
	%struct.DSOCacheEntry {
		i64 u0x2af31fa705550b94, ; from name: aot-Syncfusion.Maui.Sliders
		i64 u0x8e1c0d0116b3ef4b, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.92_name, ; name: libaot-Syncfusion.Maui.Sliders.dll.so
		ptr null; void* handle
	}, ; 318
	%struct.DSOCacheEntry {
		i64 u0x2b1efe99057e7a32, ; from name: aot-Mono.HttpUtility.dll.so
		i64 u0x475325afa16dbfe5, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.82_name, ; name: libaot-Mono.HttpUtility.dll.so
		ptr null; void* handle
	}, ; 319
	%struct.DSOCacheEntry {
		i64 u0x2b20ec3e8ca14022, ; from name: aot-System.ObjectModel.so
		i64 u0x914167d87d2ee1b1, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.177_name, ; name: libaot-System.ObjectModel.dll.so
		ptr null; void* handle
	}, ; 320
	%struct.DSOCacheEntry {
		i64 u0x2b6349352f49c726, ; from name: libaot-Microsoft.AspNetCore.Http.Features.so
		i64 u0x621c21d9c3290da0, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.32_name, ; name: libaot-Microsoft.AspNetCore.Http.Features.dll.so
		ptr null; void* handle
	}, ; 321
	%struct.DSOCacheEntry {
		i64 u0x2b7aae4ebbc0110d, ; from name: libaot-Microsoft.AspNetCore.Authentication.Core.dll.so
		i64 u0x2b7aae4ebbc0110d, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.21_name, ; name: libaot-Microsoft.AspNetCore.Authentication.Core.dll.so
		ptr null; void* handle
	}, ; 322
	%struct.DSOCacheEntry {
		i64 u0x2b89b39c4e534002, ; from name: libaot-Microsoft.Extensions.Configuration.Abstractions
		i64 u0xd6a1ce9f7ccd35cb, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.53_name, ; name: libaot-Microsoft.Extensions.Configuration.Abstractions.dll.so
		ptr null; void* handle
	}, ; 323
	%struct.DSOCacheEntry {
		i64 u0x2b90b7a200637ea6, ; from name: libaot-Refit.HttpClientFactory
		i64 u0xbf4b844c69db6ec0, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.84_name, ; name: libaot-Refit.HttpClientFactory.dll.so
		ptr null; void* handle
	}, ; 324
	%struct.DSOCacheEntry {
		i64 u0x2ba3b197006b7954, ; from name: libaot-Xamarin.AndroidX.Navigation.Common.dll.so
		i64 u0x2ba3b197006b7954, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.119_name, ; name: libaot-Xamarin.AndroidX.Navigation.Common.dll.so
		ptr null; void* handle
	}, ; 325
	%struct.DSOCacheEntry {
		i64 u0x2baa34b5427fecb6, ; from name: aot-Syncfusion.Maui.Sliders.so
		i64 u0x8e1c0d0116b3ef4b, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.92_name, ; name: libaot-Syncfusion.Maui.Sliders.dll.so
		ptr null; void* handle
	}, ; 326
	%struct.DSOCacheEntry {
		i64 u0x2c0ebf78bce72faf, ; from name: aot-Microsoft.Maui.Essentials.so
		i64 u0xdc3ba4771239be2d, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.78_name, ; name: libaot-Microsoft.Maui.Essentials.dll.so
		ptr null; void* handle
	}, ; 327
	%struct.DSOCacheEntry {
		i64 u0x2c3037a6cc5d862d, ; from name: aot-Mono.Android.Runtime.so
		i64 u0x156ae2b2e8a39884, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.225_name, ; name: libaot-Mono.Android.Runtime.dll.so
		ptr null; void* handle
	}, ; 328
	%struct.DSOCacheEntry {
		i64 u0x2c5d2fccd25d8149, ; from name: libaot-Xamarin.AndroidX.AppCompat.AppCompatResources.so
		i64 u0x456e37cd491657b0, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.104_name, ; name: libaot-Xamarin.AndroidX.AppCompat.AppCompatResources.dll.so
		ptr null; void* handle
	}, ; 329
	%struct.DSOCacheEntry {
		i64 u0x2c66913e881b6fac, ; from name: Microsoft.Maui.Controls.Xaml.dll.so
		i64 u0x5fc3bca990f46fb4, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.76_name, ; name: libaot-Microsoft.Maui.Controls.Xaml.dll.so
		ptr null; void* handle
	}, ; 330
	%struct.DSOCacheEntry {
		i64 u0x2d0a1066418db235, ; from name: aot-CommunityToolkit.Maui.Core.dll.so
		i64 u0x1f7f7b0e04fbedb0, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.15_name, ; name: libaot-CommunityToolkit.Maui.Core.dll.so
		ptr null; void* handle
	}, ; 331
	%struct.DSOCacheEntry {
		i64 u0x2d1d7b08ae32f1f7, ; from name: aot-Xamarin.KotlinX.Serialization.Core.Jvm.so
		i64 u0x757898ba637db46e, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.131_name, ; name: libaot-Xamarin.KotlinX.Serialization.Core.Jvm.dll.so
		ptr null; void* handle
	}, ; 332
	%struct.DSOCacheEntry {
		i64 u0x2d4464a22a72efc3, ; from name: aot-Microsoft.AspNetCore.SignalR.Client.Core
		i64 u0x0e46bd4e008c7b33, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.39_name, ; name: libaot-Microsoft.AspNetCore.SignalR.Client.Core.dll.so
		ptr null; void* handle
	}, ; 333
	%struct.DSOCacheEntry {
		i64 u0x2d4f134f28256193, ; from name: Microsoft.AspNetCore.Authentication.Core.so
		i64 u0x2b7aae4ebbc0110d, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.21_name, ; name: libaot-Microsoft.AspNetCore.Authentication.Core.dll.so
		ptr null; void* handle
	}, ; 334
	%struct.DSOCacheEntry {
		i64 u0x2d52952f3fa0d276, ; from name: libaot-Microsoft.AspNetCore.SignalR.Protocols.Json.so
		i64 u0x53a8edd5eb823442, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.42_name, ; name: libaot-Microsoft.AspNetCore.SignalR.Protocols.Json.dll.so
		ptr null; void* handle
	}, ; 335
	%struct.DSOCacheEntry {
		i64 u0x2d6521795fa92605, ; from name: libaot-Syncfusion.Maui.Toolkit.dll.so
		i64 u0x2d6521795fa92605, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.93_name, ; name: libaot-Syncfusion.Maui.Toolkit.dll.so
		ptr null; void* handle
	}, ; 336
	%struct.DSOCacheEntry {
		i64 u0x2db4552b92926068, ; from name: Microsoft.AspNetCore.SignalR.Protocols.Json.so
		i64 u0x53a8edd5eb823442, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.42_name, ; name: libaot-Microsoft.AspNetCore.SignalR.Protocols.Json.dll.so
		ptr null; void* handle
	}, ; 337
	%struct.DSOCacheEntry {
		i64 u0x2dda29dd0a0115d9, ; from name: System.Security.Cryptography.Algorithms.so
		i64 u0xd9a989573240dd9c, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.197_name, ; name: libaot-System.Security.Cryptography.Algorithms.dll.so
		ptr null; void* handle
	}, ; 338
	%struct.DSOCacheEntry {
		i64 u0x2ddeb9b279c82c8e, ; from name: aot-System.Private.Xml
		i64 u0x52bbd048717682d4, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.181_name, ; name: libaot-System.Private.Xml.dll.so
		ptr null; void* handle
	}, ; 339
	%struct.DSOCacheEntry {
		i64 u0x2e14b9b85be73502, ; from name: aot-Syncfusion.Maui.Toolkit.resources.so
		i64 u0xa56606bb1f125004, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.94_name, ; name: libaot-Syncfusion.Maui.Toolkit.resources.dll.so
		ptr null; void* handle
	}, ; 340
	%struct.DSOCacheEntry {
		i64 u0x2e30ac564b0e1fb1, ; from name: Xamarin.AndroidX.Browser.so
		i64 u0x9865c0bf349d1465, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.105_name, ; name: libaot-Xamarin.AndroidX.Browser.dll.so
		ptr null; void* handle
	}, ; 341
	%struct.DSOCacheEntry {
		i64 u0x2e6e4fcdea939ce7, ; from name: aot-Microsoft.Extensions.Logging.Abstractions.so
		i64 u0xe6757a5fac324e53, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.63_name, ; name: libaot-Microsoft.Extensions.Logging.Abstractions.dll.so
		ptr null; void* handle
	}, ; 342
	%struct.DSOCacheEntry {
		i64 u0x2eb68ca0cc467150, ; from name: libaot-Microsoft.AspNetCore.ResponseCaching.Abstractions.dll.so
		i64 u0x2eb68ca0cc467150, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.35_name, ; name: libaot-Microsoft.AspNetCore.ResponseCaching.Abstractions.dll.so
		ptr null; void* handle
	}, ; 343
	%struct.DSOCacheEntry {
		i64 u0x2ec8d2dcf2c4a71b, ; from name: libaot-Xamarin.AndroidX.Lifecycle.Common.Jvm.dll.so
		i64 u0x2ec8d2dcf2c4a71b, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.114_name, ; name: libaot-Xamarin.AndroidX.Lifecycle.Common.Jvm.dll.so
		ptr null; void* handle
	}, ; 344
	%struct.DSOCacheEntry {
		i64 u0x2ef2ce6dde531f65, ; from name: aot-System.Threading.Thread
		i64 u0x675935a1e3b604dc, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.212_name, ; name: libaot-System.Threading.Thread.dll.so
		ptr null; void* handle
	}, ; 345
	%struct.DSOCacheEntry {
		i64 u0x2ef9790309d55e46, ; from name: aot-System.Diagnostics.DiagnosticSource.so
		i64 u0x77156c94b5eff927, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.146_name, ; name: libaot-System.Diagnostics.DiagnosticSource.dll.so
		ptr null; void* handle
	}, ; 346
	%struct.DSOCacheEntry {
		i64 u0x2f02f94df3200fe5, ; from name: System.Diagnostics.Process
		i64 u0x8657799bb82e0573, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.147_name, ; name: libaot-System.Diagnostics.Process.dll.so
		ptr null; void* handle
	}, ; 347
	%struct.DSOCacheEntry {
		i64 u0x2f1ec89e14fae803, ; from name: libaot-Xamarin.AndroidX.Loader
		i64 u0x74b0aefe8f467d50, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.118_name, ; name: libaot-Xamarin.AndroidX.Loader.dll.so
		ptr null; void* handle
	}, ; 348
	%struct.DSOCacheEntry {
		i64 u0x2f2e98e1c89b1aff, ; from name: System.Xml.ReaderWriter
		i64 u0xdfabadcf47a52f12, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.218_name, ; name: libaot-System.Xml.ReaderWriter.dll.so
		ptr null; void* handle
	}, ; 349
	%struct.DSOCacheEntry {
		i64 u0x2f4002287528534f, ; from name: Microsoft.CSharp.dll.so
		i64 u0xe38bfeec71b3b67d, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.132_name, ; name: libaot-Microsoft.CSharp.dll.so
		ptr null; void* handle
	}, ; 350
	%struct.DSOCacheEntry {
		i64 u0x2f5911d9ba814e4e, ; from name: System.Diagnostics.Tracing
		i64 u0x28371251d401372b, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.150_name, ; name: libaot-System.Diagnostics.Tracing.dll.so
		ptr null; void* handle
	}, ; 351
	%struct.DSOCacheEntry {
		i64 u0x2f61d85c51a6db93, ; from name: System.ComponentModel.TypeConverter.so
		i64 u0xcb7e41356728fd07, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.142_name, ; name: libaot-System.ComponentModel.TypeConverter.dll.so
		ptr null; void* handle
	}, ; 352
	%struct.DSOCacheEntry {
		i64 u0x2fa8fa8b3459561a, ; from name: System.Security.Cryptography.X509Certificates.so
		i64 u0x86ff945e422694f9, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.202_name, ; name: libaot-System.Security.Cryptography.X509Certificates.dll.so
		ptr null; void* handle
	}, ; 353
	%struct.DSOCacheEntry {
		i64 u0x2fb7a3952b307fae, ; from name: libaot-System.Linq.dll.so
		i64 u0x2fb7a3952b307fae, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.162_name, ; name: libaot-System.Linq.dll.so
		ptr null; void* handle
	}, ; 354
	%struct.DSOCacheEntry {
		i64 u0x2fd006d798be3fd9, ; from name: Microsoft.AspNetCore.SignalR.Protocols.Json.dll.so
		i64 u0x53a8edd5eb823442, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.42_name, ; name: libaot-Microsoft.AspNetCore.SignalR.Protocols.Json.dll.so
		ptr null; void* handle
	}, ; 355
	%struct.DSOCacheEntry {
		i64 u0x307bac3c0f14062e, ; from name: aot-Refit.HttpClientFactory
		i64 u0xbf4b844c69db6ec0, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.84_name, ; name: libaot-Refit.HttpClientFactory.dll.so
		ptr null; void* handle
	}, ; 356
	%struct.DSOCacheEntry {
		i64 u0x309a85a85af9ca1e, ; from name: libaot-System.Buffers.so
		i64 u0x5988bd4997e5d75f, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.134_name, ; name: libaot-System.Buffers.dll.so
		ptr null; void* handle
	}, ; 357
	%struct.DSOCacheEntry {
		i64 u0x309f2bedefa9a318, ; from name: Microsoft.IdentityModel.Abstractions
		i64 u0x41c972d328f102fd, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.69_name, ; name: libaot-Microsoft.IdentityModel.Abstractions.dll.so
		ptr null; void* handle
	}, ; 358
	%struct.DSOCacheEntry {
		i64 u0x30befed94a7920c1, ; from name: Microsoft.AspNetCore.Routing.Abstractions.so
		i64 u0x03ea24da2517cfb9, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.37_name, ; name: libaot-Microsoft.AspNetCore.Routing.Abstractions.dll.so
		ptr null; void* handle
	}, ; 359
	%struct.DSOCacheEntry {
		i64 u0x3112860bf14b49e5, ; from name: System.Net.Security.dll.so
		i64 u0x1271045d1561acf0, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.170_name, ; name: libaot-System.Net.Security.dll.so
		ptr null; void* handle
	}, ; 360
	%struct.DSOCacheEntry {
		i64 u0x31145bf76e7d3b7a, ; from name: libaot-System.Security.Cryptography.Encoding.dll.so
		i64 u0x31145bf76e7d3b7a, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.200_name, ; name: libaot-System.Security.Cryptography.Encoding.dll.so
		ptr null; void* handle
	}, ; 361
	%struct.DSOCacheEntry {
		i64 u0x31349c7e18bb81a8, ; from name: Syncfusion.Maui.Sliders.so
		i64 u0x8e1c0d0116b3ef4b, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.92_name, ; name: libaot-Syncfusion.Maui.Sliders.dll.so
		ptr null; void* handle
	}, ; 362
	%struct.DSOCacheEntry {
		i64 u0x314ae06b0e81e7ca, ; from name: aot-DocumentFormat.OpenXml.so
		i64 u0x456cc421e6ef3bb7, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.17_name, ; name: libaot-DocumentFormat.OpenXml.dll.so
		ptr null; void* handle
	}, ; 363
	%struct.DSOCacheEntry {
		i64 u0x3158c26945b012d9, ; from name: aot-System.Data.Common
		i64 u0x426a5e4ee84b386c, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.145_name, ; name: libaot-System.Data.Common.dll.so
		ptr null; void* handle
	}, ; 364
	%struct.DSOCacheEntry {
		i64 u0x31a9d1bc3f1d8e08, ; from name: Microsoft.Identity.Client.Extensions.Msal.dll.so
		i64 u0x9b88d00d863a5143, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.68_name, ; name: libaot-Microsoft.Identity.Client.Extensions.Msal.dll.so
		ptr null; void* handle
	}, ; 365
	%struct.DSOCacheEntry {
		i64 u0x322ac199914afc70, ; from name: aot-System.Collections.so
		i64 u0xb3f9fc836ae7ebb5, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.139_name, ; name: libaot-System.Collections.dll.so
		ptr null; void* handle
	}, ; 366
	%struct.DSOCacheEntry {
		i64 u0x322bd5e65a569103, ; from name: libaot-Mono.HttpUtility
		i64 u0x475325afa16dbfe5, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.82_name, ; name: libaot-Mono.HttpUtility.dll.so
		ptr null; void* handle
	}, ; 367
	%struct.DSOCacheEntry {
		i64 u0x324cedd7271c2c92, ; from name: libaot-CommunityToolkit.Mvvm.dll.so
		i64 u0x324cedd7271c2c92, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.16_name, ; name: libaot-CommunityToolkit.Mvvm.dll.so
		ptr null; void* handle
	}, ; 368
	%struct.DSOCacheEntry {
		i64 u0x329e475fc938b7f8, ; from name: System.Reflection.Emit.Lightweight.dll.so
		i64 u0x54f7fbd0a81833fe, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.183_name, ; name: libaot-System.Reflection.Emit.Lightweight.dll.so
		ptr null; void* handle
	}, ; 369
	%struct.DSOCacheEntry {
		i64 u0x32b0e19f7a401330, ; from name: Microsoft.AspNetCore.SignalR.Core.dll.so
		i64 u0x73dd04543af2c841, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.41_name, ; name: libaot-Microsoft.AspNetCore.SignalR.Core.dll.so
		ptr null; void* handle
	}, ; 370
	%struct.DSOCacheEntry {
		i64 u0x3304b4516332575c, ; from name: System.Collections.dll.so
		i64 u0xb3f9fc836ae7ebb5, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.139_name, ; name: libaot-System.Collections.dll.so
		ptr null; void* handle
	}, ; 371
	%struct.DSOCacheEntry {
		i64 u0x3311b17e5ed875bd, ; from name: aot-SQLitePCLRaw.lib.e_sqlite3.android.dll.so
		i64 u0x6a03b775044080b2, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.87_name, ; name: libaot-SQLitePCLRaw.lib.e_sqlite3.android.dll.so
		ptr null; void* handle
	}, ; 372
	%struct.DSOCacheEntry {
		i64 u0x331a7f0d6c2c08c9, ; from name: libaot-Microsoft.Extensions.Caching.Memory.dll.so
		i64 u0x331a7f0d6c2c08c9, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.51_name, ; name: libaot-Microsoft.Extensions.Caching.Memory.dll.so
		ptr null; void* handle
	}, ; 373
	%struct.DSOCacheEntry {
		i64 u0x332a1f71a5c4d5e9, ; from name: Microsoft.AspNetCore.Http.Extensions.dll.so
		i64 u0xf01d9d74cda0b70d, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.31_name, ; name: libaot-Microsoft.AspNetCore.Http.Extensions.dll.so
		ptr null; void* handle
	}, ; 374
	%struct.DSOCacheEntry {
		i64 u0x332e06e9aae9a08d, ; from name: System.Net.NameResolution.dll.so
		i64 u0x7f280e9be5453eba, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.166_name, ; name: libaot-System.Net.NameResolution.dll.so
		ptr null; void* handle
	}, ; 375
	%struct.DSOCacheEntry {
		i64 u0x335ee09f84038ef0, ; from name: Microsoft.Identity.Client.dll.so
		i64 u0xd20e64387a412094, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.67_name, ; name: libaot-Microsoft.Identity.Client.dll.so
		ptr null; void* handle
	}, ; 376
	%struct.DSOCacheEntry {
		i64 u0x3362be7a83904503, ; from name: Microsoft.Identity.Client.so
		i64 u0xd20e64387a412094, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.67_name, ; name: libaot-Microsoft.Identity.Client.dll.so
		ptr null; void* handle
	}, ; 377
	%struct.DSOCacheEntry {
		i64 u0x336ebe62b841371c, ; from name: aot-System.Buffers.so
		i64 u0x5988bd4997e5d75f, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.134_name, ; name: libaot-System.Buffers.dll.so
		ptr null; void* handle
	}, ; 378
	%struct.DSOCacheEntry {
		i64 u0x33829542f112d59b, ; from name: System.Collections.Immutable
		i64 u0x49e9602a3882bd40, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.136_name, ; name: libaot-System.Collections.Immutable.dll.so
		ptr null; void* handle
	}, ; 379
	%struct.DSOCacheEntry {
		i64 u0x33e65d4dcab4457b, ; from name: System.IO.FileSystem.AccessControl.so
		i64 u0xf8af38e7ca3d5d78, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.156_name, ; name: libaot-System.IO.FileSystem.AccessControl.dll.so
		ptr null; void* handle
	}, ; 380
	%struct.DSOCacheEntry {
		i64 u0x34378e97c506286e, ; from name: libaot-Microsoft.AspNetCore.Connections.Abstractions
		i64 u0xb92f532b40f35614, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.24_name, ; name: libaot-Microsoft.AspNetCore.Connections.Abstractions.dll.so
		ptr null; void* handle
	}, ; 381
	%struct.DSOCacheEntry {
		i64 u0x344444877582b162, ; from name: aot-Microsoft.IdentityModel.Protocols.dll.so
		i64 u0x9037f9d64d16c443, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.72_name, ; name: libaot-Microsoft.IdentityModel.Protocols.dll.so
		ptr null; void* handle
	}, ; 382
	%struct.DSOCacheEntry {
		i64 u0x348d598f4054415e, ; from name: Microsoft.SqlServer.Server
		i64 u0x7b4f94432c52afad, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.81_name, ; name: libaot-Microsoft.SqlServer.Server.dll.so
		ptr null; void* handle
	}, ; 383
	%struct.DSOCacheEntry {
		i64 u0x34c6f5c746796bcc, ; from name: libaot-Xamarin.AndroidX.RecyclerView.dll.so
		i64 u0x34c6f5c746796bcc, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.123_name, ; name: libaot-Xamarin.AndroidX.RecyclerView.dll.so
		ptr null; void* handle
	}, ; 384
	%struct.DSOCacheEntry {
		i64 u0x34dfd74fe2afcf37, ; from name: Microsoft.Maui
		i64 u0x58cd310024b735d8, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.77_name, ; name: libaot-Microsoft.Maui.dll.so
		ptr null; void* handle
	}, ; 385
	%struct.DSOCacheEntry {
		i64 u0x34e6c49e514ff0a5, ; from name: libaot-DocumentFormat.OpenXml.VariableReplacer.Core
		i64 u0x785bad4f0559c250, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.19_name, ; name: libaot-DocumentFormat.OpenXml.VariableReplacer.Core.dll.so
		ptr null; void* handle
	}, ; 386
	%struct.DSOCacheEntry {
		i64 u0x3508234247f48404, ; from name: Microsoft.Maui.Controls
		i64 u0x7f174db5a2c913e7, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.75_name, ; name: libaot-Microsoft.Maui.Controls.dll.so
		ptr null; void* handle
	}, ; 387
	%struct.DSOCacheEntry {
		i64 u0x350af77f6bdcd1ef, ; from name: Microsoft.Extensions.Configuration.Abstractions.dll.so
		i64 u0xd6a1ce9f7ccd35cb, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.53_name, ; name: libaot-Microsoft.Extensions.Configuration.Abstractions.dll.so
		ptr null; void* handle
	}, ; 388
	%struct.DSOCacheEntry {
		i64 u0x3525ca1f06a76b1c, ; from name: aot-Microsoft.Extensions.Logging.Abstractions
		i64 u0xe6757a5fac324e53, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.63_name, ; name: libaot-Microsoft.Extensions.Logging.Abstractions.dll.so
		ptr null; void* handle
	}, ; 389
	%struct.DSOCacheEntry {
		i64 u0x353590da528c9d22, ; from name: System.ComponentModel.Annotations
		i64 u0xbf7d944f85fcd72c, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.140_name, ; name: libaot-System.ComponentModel.Annotations.dll.so
		ptr null; void* handle
	}, ; 390
	%struct.DSOCacheEntry {
		i64 u0x355282fc1c909694, ; from name: Microsoft.Extensions.Configuration
		i64 u0x07a45374fab68acc, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.52_name, ; name: libaot-Microsoft.Extensions.Configuration.dll.so
		ptr null; void* handle
	}, ; 391
	%struct.DSOCacheEntry {
		i64 u0x355b66670e6bf2e4, ; from name: libaot-System.Collections.Specialized.dll.so
		i64 u0x355b66670e6bf2e4, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.138_name, ; name: libaot-System.Collections.Specialized.dll.so
		ptr null; void* handle
	}, ; 392
	%struct.DSOCacheEntry {
		i64 u0x359895a3c1bd5685, ; from name: libaot-Mono.Android.dll.so
		i64 u0x359895a3c1bd5685, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.226_name, ; name: libaot-Mono.Android.dll.so
		ptr null; void* handle
	}, ; 393
	%struct.DSOCacheEntry {
		i64 u0x35b53eb45b4382aa, ; from name: aot-System.ObjectModel
		i64 u0x914167d87d2ee1b1, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.177_name, ; name: libaot-System.ObjectModel.dll.so
		ptr null; void* handle
	}, ; 394
	%struct.DSOCacheEntry {
		i64 u0x361b91086beb2292, ; from name: Xamarin.AndroidX.DrawerLayout.dll.so
		i64 u0x4bea014989424a56, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.112_name, ; name: libaot-Xamarin.AndroidX.DrawerLayout.dll.so
		ptr null; void* handle
	}, ; 395
	%struct.DSOCacheEntry {
		i64 u0x36475fa5f4cfe462, ; from name: System.Diagnostics.Tracing.so
		i64 u0x28371251d401372b, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.150_name, ; name: libaot-System.Diagnostics.Tracing.dll.so
		ptr null; void* handle
	}, ; 396
	%struct.DSOCacheEntry {
		i64 u0x36523a9ee06666ec, ; from name: aot-Microsoft.AspNetCore.Http.Extensions
		i64 u0xf01d9d74cda0b70d, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.31_name, ; name: libaot-Microsoft.AspNetCore.Http.Extensions.dll.so
		ptr null; void* handle
	}, ; 397
	%struct.DSOCacheEntry {
		i64 u0x36547dc653fb83c1, ; from name: libaot-System.Net.Http.Json.dll.so
		i64 u0x36547dc653fb83c1, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.164_name, ; name: libaot-System.Net.Http.Json.dll.so
		ptr null; void* handle
	}, ; 398
	%struct.DSOCacheEntry {
		i64 u0x366c3ed8a6266ffb, ; from name: libaot-System.Drawing.dll.so
		i64 u0x366c3ed8a6266ffb, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.152_name, ; name: libaot-System.Drawing.dll.so
		ptr null; void* handle
	}, ; 399
	%struct.DSOCacheEntry {
		i64 u0x3696bf64681ea9b6, ; from name: aot-Microsoft.AspNetCore.Routing.Abstractions
		i64 u0x03ea24da2517cfb9, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.37_name, ; name: libaot-Microsoft.AspNetCore.Routing.Abstractions.dll.so
		ptr null; void* handle
	}, ; 400
	%struct.DSOCacheEntry {
		i64 u0x36acd2f34316a9a5, ; from name: libaot-System.Security.Cryptography.X509Certificates
		i64 u0x86ff945e422694f9, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.202_name, ; name: libaot-System.Security.Cryptography.X509Certificates.dll.so
		ptr null; void* handle
	}, ; 401
	%struct.DSOCacheEntry {
		i64 u0x36b2b50fdf589ae2, ; from name: System.Reflection.Emit.Lightweight
		i64 u0x54f7fbd0a81833fe, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.183_name, ; name: libaot-System.Reflection.Emit.Lightweight.dll.so
		ptr null; void* handle
	}, ; 402
	%struct.DSOCacheEntry {
		i64 u0x36d9738a6144c80a, ; from name: Microsoft.AspNetCore.Authentication.Abstractions.dll.so
		i64 u0x59903efae9d3d723, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.20_name, ; name: libaot-Microsoft.AspNetCore.Authentication.Abstractions.dll.so
		ptr null; void* handle
	}, ; 403
	%struct.DSOCacheEntry {
		i64 u0x36e538c94d6f9f7f, ; from name: aot-Microsoft.Extensions.Http
		i64 u0x24aa3d6e3cd1bcb7, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.61_name, ; name: libaot-Microsoft.Extensions.Http.dll.so
		ptr null; void* handle
	}, ; 404
	%struct.DSOCacheEntry {
		i64 u0x3701ed022db07634, ; from name: Microsoft.AspNetCore.Http.Abstractions.so
		i64 u0x96d2838521668c05, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.28_name, ; name: libaot-Microsoft.AspNetCore.Http.Abstractions.dll.so
		ptr null; void* handle
	}, ; 405
	%struct.DSOCacheEntry {
		i64 u0x370b7031653c1807, ; from name: libaot-System.IO.Pipes.dll.so
		i64 u0x370b7031653c1807, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.159_name, ; name: libaot-System.IO.Pipes.dll.so
		ptr null; void* handle
	}, ; 406
	%struct.DSOCacheEntry {
		i64 u0x371d40ce3e377b20, ; from name: libaot-Xamarin.AndroidX.Fragment
		i64 u0x8ab6d3431da5497e, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.113_name, ; name: libaot-Xamarin.AndroidX.Fragment.dll.so
		ptr null; void* handle
	}, ; 407
	%struct.DSOCacheEntry {
		i64 u0x377062317fbcad4b, ; from name: aot-SQLitePCLRaw.batteries_v2
		i64 u0x418d89fb2901d219, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.85_name, ; name: libaot-SQLitePCLRaw.batteries_v2.dll.so
		ptr null; void* handle
	}, ; 408
	%struct.DSOCacheEntry {
		i64 u0x37c0d6e8fc24e245, ; from name: Syncfusion.Maui.Toolkit.dll.so
		i64 u0x2d6521795fa92605, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.93_name, ; name: libaot-Syncfusion.Maui.Toolkit.dll.so
		ptr null; void* handle
	}, ; 409
	%struct.DSOCacheEntry {
		i64 u0x37eacf3c8b9954e9, ; from name: Microsoft.AspNetCore.SignalR.Client.Core.dll.so
		i64 u0x0e46bd4e008c7b33, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.39_name, ; name: libaot-Microsoft.AspNetCore.SignalR.Client.Core.dll.so
		ptr null; void* handle
	}, ; 410
	%struct.DSOCacheEntry {
		i64 u0x37fbbc6496fdd16c, ; from name: aot-System.Net.Http.Json.so
		i64 u0x36547dc653fb83c1, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.164_name, ; name: libaot-System.Net.Http.Json.dll.so
		ptr null; void* handle
	}, ; 411
	%struct.DSOCacheEntry {
		i64 u0x37fbdff3aa18872d, ; from name: libaot-System.Numerics.Vectors.dll.so
		i64 u0x37fbdff3aa18872d, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.176_name, ; name: libaot-System.Numerics.Vectors.dll.so
		ptr null; void* handle
	}, ; 412
	%struct.DSOCacheEntry {
		i64 u0x3888ef1b66745e12, ; from name: aot-System.so
		i64 u0x7b91ac8ddc528deb, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.221_name, ; name: libaot-System.dll.so
		ptr null; void* handle
	}, ; 413
	%struct.DSOCacheEntry {
		i64 u0x388fb7e2d89b3b18, ; from name: Microsoft.AspNetCore.Authorization.Policy.so
		i64 u0x4d16f4a17e081b1e, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.23_name, ; name: libaot-Microsoft.AspNetCore.Authorization.Policy.dll.so
		ptr null; void* handle
	}, ; 414
	%struct.DSOCacheEntry {
		i64 u0x389afcfd27184e95, ; from name: Microsoft.EntityFrameworkCore.SqlServer.dll.so
		i64 u0x9daa39a878308c98, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.49_name, ; name: libaot-Microsoft.EntityFrameworkCore.SqlServer.dll.so
		ptr null; void* handle
	}, ; 415
	%struct.DSOCacheEntry {
		i64 u0x38a82198a4cd2a73, ; from name: libaot-System.ComponentModel.dll.so
		i64 u0x38a82198a4cd2a73, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.143_name, ; name: libaot-System.ComponentModel.dll.so
		ptr null; void* handle
	}, ; 416
	%struct.DSOCacheEntry {
		i64 u0x38dcb0b974c37979, ; from name: libaot-System.Data.Common
		i64 u0x426a5e4ee84b386c, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.145_name, ; name: libaot-System.Data.Common.dll.so
		ptr null; void* handle
	}, ; 417
	%struct.DSOCacheEntry {
		i64 u0x38e4553d8764fa45, ; from name: libaot-Xamarin.AndroidX.Lifecycle.LiveData.Core.dll.so
		i64 u0x38e4553d8764fa45, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.115_name, ; name: libaot-Xamarin.AndroidX.Lifecycle.LiveData.Core.dll.so
		ptr null; void* handle
	}, ; 418
	%struct.DSOCacheEntry {
		i64 u0x38e93ec1c057cdf6, ; from name: Microsoft.IdentityModel.Protocols
		i64 u0x9037f9d64d16c443, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.72_name, ; name: libaot-Microsoft.IdentityModel.Protocols.dll.so
		ptr null; void* handle
	}, ; 419
	%struct.DSOCacheEntry {
		i64 u0x391ae023ff80d51d, ; from name: aot-System.Text.Json.so
		i64 u0x9bb35aa4bcef7b80, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.208_name, ; name: libaot-System.Text.Json.dll.so
		ptr null; void* handle
	}, ; 420
	%struct.DSOCacheEntry {
		i64 u0x3938f24b1c8303a5, ; from name: Xamarin.AndroidX.Lifecycle.ViewModelSavedState.so
		i64 u0x9b809dc726e0140e, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.117_name, ; name: libaot-Xamarin.AndroidX.Lifecycle.ViewModelSavedState.dll.so
		ptr null; void* handle
	}, ; 421
	%struct.DSOCacheEntry {
		i64 u0x394be0c9d632fe98, ; from name: Xamarin.AndroidX.ViewPager.dll.so
		i64 u0xb5351dcbaf438cb6, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.126_name, ; name: libaot-Xamarin.AndroidX.ViewPager.dll.so
		ptr null; void* handle
	}, ; 422
	%struct.DSOCacheEntry {
		i64 u0x396e952adc39215d, ; from name: libaot-SocialMediaMaui.Shared.so
		i64 u0x12448631a200ce9a, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.10_name, ; name: libaot-SocialMediaMaui.Shared.dll.so
		ptr null; void* handle
	}, ; 423
	%struct.DSOCacheEntry {
		i64 u0x39724e27f46db55d, ; from name: libaot-Mono.Android.Runtime
		i64 u0x156ae2b2e8a39884, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.225_name, ; name: libaot-Mono.Android.Runtime.dll.so
		ptr null; void* handle
	}, ; 424
	%struct.DSOCacheEntry {
		i64 u0x39a7f32993961f95, ; from name: aot-mscorlib
		i64 u0xd45fa2873eb303d5, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.222_name, ; name: libaot-mscorlib.dll.so
		ptr null; void* handle
	}, ; 425
	%struct.DSOCacheEntry {
		i64 u0x3a427a5d01338ac7, ; from name: aot-System.Net.Primitives
		i64 u0xaac4801194f87f4f, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.168_name, ; name: libaot-System.Net.Primitives.dll.so
		ptr null; void* handle
	}, ; 426
	%struct.DSOCacheEntry {
		i64 u0x3a884f7ec156a095, ; from name: libaot-System.Memory
		i64 u0xad582851e7d05243, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.163_name, ; name: libaot-System.Memory.dll.so
		ptr null; void* handle
	}, ; 427
	%struct.DSOCacheEntry {
		i64 u0x3a9fdb9dde4a5ef9, ; from name: libaot-Microsoft.AspNetCore.Authorization.so
		i64 u0x93d2678ac2e76ce0, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.22_name, ; name: libaot-Microsoft.AspNetCore.Authorization.dll.so
		ptr null; void* handle
	}, ; 428
	%struct.DSOCacheEntry {
		i64 u0x3aa0ab9a95ce0ab6, ; from name: libaot-System.IO.FileSystem.Watcher
		i64 u0xf90aa99869639df6, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.157_name, ; name: libaot-System.IO.FileSystem.Watcher.dll.so
		ptr null; void* handle
	}, ; 429
	%struct.DSOCacheEntry {
		i64 u0x3afb371341dc77db, ; from name: aot-DocumentFormat.OpenXml.Framework.so
		i64 u0xf959815fea0ec361, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.18_name, ; name: libaot-DocumentFormat.OpenXml.Framework.dll.so
		ptr null; void* handle
	}, ; 430
	%struct.DSOCacheEntry {
		i64 u0x3b0b5be9d830ec4d, ; from name: aot-Microsoft.Extensions.Http.so
		i64 u0x24aa3d6e3cd1bcb7, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.61_name, ; name: libaot-Microsoft.Extensions.Http.dll.so
		ptr null; void* handle
	}, ; 431
	%struct.DSOCacheEntry {
		i64 u0x3b573f7beeb30d88, ; from name: aot-Xamarin.AndroidX.RecyclerView.dll.so
		i64 u0x34c6f5c746796bcc, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.123_name, ; name: libaot-Xamarin.AndroidX.RecyclerView.dll.so
		ptr null; void* handle
	}, ; 432
	%struct.DSOCacheEntry {
		i64 u0x3b645f0653974f51, ; from name: libaot-System.Security.Cryptography.ProtectedData
		i64 u0x67faf2828acf47d0, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.101_name, ; name: libaot-System.Security.Cryptography.ProtectedData.dll.so
		ptr null; void* handle
	}, ; 433
	%struct.DSOCacheEntry {
		i64 u0x3b94e09502473e02, ; from name: libaot-Microsoft.AspNetCore.Mvc.Abstractions
		i64 u0x8be639a423b6d017, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.33_name, ; name: libaot-Microsoft.AspNetCore.Mvc.Abstractions.dll.so
		ptr null; void* handle
	}, ; 434
	%struct.DSOCacheEntry {
		i64 u0x3bcea6ef5586e59e, ; from name: Microsoft.AspNetCore.Http.Connections.Client.dll.so
		i64 u0x14283e2d731a896b, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.29_name, ; name: libaot-Microsoft.AspNetCore.Http.Connections.Client.dll.so
		ptr null; void* handle
	}, ; 435
	%struct.DSOCacheEntry {
		i64 u0x3bdd417e4f9f9f63, ; from name: System.IO.Pipes.dll.so
		i64 u0x370b7031653c1807, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.159_name, ; name: libaot-System.IO.Pipes.dll.so
		ptr null; void* handle
	}, ; 436
	%struct.DSOCacheEntry {
		i64 u0x3bee020a5f1a6192, ; from name: System.Configuration.ConfigurationManager.so
		i64 u0x5d3a5af149aed459, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.96_name, ; name: libaot-System.Configuration.ConfigurationManager.dll.so
		ptr null; void* handle
	}, ; 437
	%struct.DSOCacheEntry {
		i64 u0x3bff39ec83492179, ; from name: aot-System.Net.Primitives.so
		i64 u0xaac4801194f87f4f, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.168_name, ; name: libaot-System.Net.Primitives.dll.so
		ptr null; void* handle
	}, ; 438
	%struct.DSOCacheEntry {
		i64 u0x3c0321d739db65ec, ; from name: libaot-System.Formats.Asn1
		i64 u0x4a9bda0e8528b414, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.153_name, ; name: libaot-System.Formats.Asn1.dll.so
		ptr null; void* handle
	}, ; 439
	%struct.DSOCacheEntry {
		i64 u0x3c364706c991ded3, ; from name: libaot-CommunityToolkit.Mvvm.so
		i64 u0x324cedd7271c2c92, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.16_name, ; name: libaot-CommunityToolkit.Mvvm.dll.so
		ptr null; void* handle
	}, ; 440
	%struct.DSOCacheEntry {
		i64 u0x3c59ed7c0d3f08c8, ; from name: libaot-Xamarin.KotlinX.Serialization.Core.Jvm
		i64 u0x757898ba637db46e, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.131_name, ; name: libaot-Xamarin.KotlinX.Serialization.Core.Jvm.dll.so
		ptr null; void* handle
	}, ; 441
	%struct.DSOCacheEntry {
		i64 u0x3c5dca78c982737e, ; from name: aot-Xamarin.AndroidX.Collection.Jvm
		i64 u0x1adc5c3038254713, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.107_name, ; name: libaot-Xamarin.AndroidX.Collection.Jvm.dll.so
		ptr null; void* handle
	}, ; 442
	%struct.DSOCacheEntry {
		i64 u0x3c6cb3fb6ec447d2, ; from name: aot-Microsoft.AspNetCore.Authorization.Policy.dll.so
		i64 u0x4d16f4a17e081b1e, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.23_name, ; name: libaot-Microsoft.AspNetCore.Authorization.Policy.dll.so
		ptr null; void* handle
	}, ; 443
	%struct.DSOCacheEntry {
		i64 u0x3c7c495f58ac5ee9, ; from name: Xamarin.Kotlin.StdLib
		i64 u0x0c644d6a2b020c43, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.129_name, ; name: libaot-Xamarin.Kotlin.StdLib.dll.so
		ptr null; void* handle
	}, ; 444
	%struct.DSOCacheEntry {
		i64 u0x3cb860793aa5a231, ; from name: aot-System.Net.NetworkInformation.dll.so
		i64 u0xb1bf28cdcefab46b, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.167_name, ; name: libaot-System.Net.NetworkInformation.dll.so
		ptr null; void* handle
	}, ; 445
	%struct.DSOCacheEntry {
		i64 u0x3cccc8c0465b3e32, ; from name: libaot-Microsoft.Extensions.Features.so
		i64 u0xaebd3af6eeceb1eb, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.59_name, ; name: libaot-Microsoft.Extensions.Features.dll.so
		ptr null; void* handle
	}, ; 446
	%struct.DSOCacheEntry {
		i64 u0x3cd65d6e8fe4e4db, ; from name: libaot-Xamarin.AndroidX.AppCompat.AppCompatResources
		i64 u0x456e37cd491657b0, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.104_name, ; name: libaot-Xamarin.AndroidX.AppCompat.AppCompatResources.dll.so
		ptr null; void* handle
	}, ; 447
	%struct.DSOCacheEntry {
		i64 u0x3d0ba7a1c1a25704, ; from name: Microsoft.Extensions.DependencyInjection.so
		i64 u0xe8726752705c8ce9, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.54_name, ; name: libaot-Microsoft.Extensions.DependencyInjection.dll.so
		ptr null; void* handle
	}, ; 448
	%struct.DSOCacheEntry {
		i64 u0x3d109711a2d4ada8, ; from name: System.Net.Primitives.dll.so
		i64 u0xaac4801194f87f4f, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.168_name, ; name: libaot-System.Net.Primitives.dll.so
		ptr null; void* handle
	}, ; 449
	%struct.DSOCacheEntry {
		i64 u0x3d46f0b995082740, ; from name: System.Xml.Linq
		i64 u0xe89b56c5a60687e6, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.217_name, ; name: libaot-System.Xml.Linq.dll.so
		ptr null; void* handle
	}, ; 450
	%struct.DSOCacheEntry {
		i64 u0x3d5daef65f9a13bb, ; from name: libaot-Microsoft.Maui.Graphics
		i64 u0x285d22da351d937a, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.79_name, ; name: libaot-Microsoft.Maui.Graphics.dll.so
		ptr null; void* handle
	}, ; 451
	%struct.DSOCacheEntry {
		i64 u0x3d66fadb8a295983, ; from name: System.Runtime.Numerics.dll.so
		i64 u0x6619888793b3b2dd, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.189_name, ; name: libaot-System.Runtime.Numerics.dll.so
		ptr null; void* handle
	}, ; 452
	%struct.DSOCacheEntry {
		i64 u0x3da7781d6333a8fe, ; from name: SQLitePCLRaw.batteries_v2
		i64 u0x418d89fb2901d219, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.85_name, ; name: libaot-SQLitePCLRaw.batteries_v2.dll.so
		ptr null; void* handle
	}, ; 453
	%struct.DSOCacheEntry {
		i64 u0x3df709f247b759a7, ; from name: libaot-System.Runtime.Numerics
		i64 u0x6619888793b3b2dd, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.189_name, ; name: libaot-System.Runtime.Numerics.dll.so
		ptr null; void* handle
	}, ; 454
	%struct.DSOCacheEntry {
		i64 u0x3e048cfd505851ad, ; from name: System.Collections.Immutable.so
		i64 u0x49e9602a3882bd40, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.136_name, ; name: libaot-System.Collections.Immutable.dll.so
		ptr null; void* handle
	}, ; 455
	%struct.DSOCacheEntry {
		i64 u0x3e13ed2e5bfc76a1, ; from name: aot-System.Private.Xml.so
		i64 u0x52bbd048717682d4, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.181_name, ; name: libaot-System.Private.Xml.dll.so
		ptr null; void* handle
	}, ; 456
	%struct.DSOCacheEntry {
		i64 u0x3e14e5b5f4b712cb, ; from name: aot-Microsoft.IdentityModel.Tokens.so
		i64 u0x4be8f991cb00f075, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.74_name, ; name: libaot-Microsoft.IdentityModel.Tokens.dll.so
		ptr null; void* handle
	}, ; 457
	%struct.DSOCacheEntry {
		i64 u0x3e2148e1cd8f9025, ; from name: libaot-System.Threading.ThreadPool
		i64 u0x7d7a84dcff7fdb59, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.213_name, ; name: libaot-System.Threading.ThreadPool.dll.so
		ptr null; void* handle
	}, ; 458
	%struct.DSOCacheEntry {
		i64 u0x3e3a8856d166de57, ; from name: aot-System.Numerics.Vectors
		i64 u0x37fbdff3aa18872d, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.176_name, ; name: libaot-System.Numerics.Vectors.dll.so
		ptr null; void* handle
	}, ; 459
	%struct.DSOCacheEntry {
		i64 u0x3e62a4a14c9284f8, ; from name: Microsoft.IdentityModel.Protocols.OpenIdConnect.dll.so
		i64 u0xbe90bee1d67c825c, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.73_name, ; name: libaot-Microsoft.IdentityModel.Protocols.OpenIdConnect.dll.so
		ptr null; void* handle
	}, ; 460
	%struct.DSOCacheEntry {
		i64 u0x3e7ffd38b11715e9, ; from name: aot-Microsoft.AspNetCore.Authorization.Policy.so
		i64 u0x4d16f4a17e081b1e, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.23_name, ; name: libaot-Microsoft.AspNetCore.Authorization.Policy.dll.so
		ptr null; void* handle
	}, ; 461
	%struct.DSOCacheEntry {
		i64 u0x3ec44b3d152f9975, ; from name: aot-SQLitePCLRaw.provider.e_sqlite3.so
		i64 u0xa5a20228c07e96ff, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.88_name, ; name: libaot-SQLitePCLRaw.provider.e_sqlite3.dll.so
		ptr null; void* handle
	}, ; 462
	%struct.DSOCacheEntry {
		i64 u0x3ef58fb402ce7775, ; from name: aot-Microsoft.EntityFrameworkCore.SqlServer
		i64 u0x9daa39a878308c98, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.49_name, ; name: libaot-Microsoft.EntityFrameworkCore.SqlServer.dll.so
		ptr null; void* handle
	}, ; 463
	%struct.DSOCacheEntry {
		i64 u0x3f033274d88bf2f2, ; from name: aot-DocumentFormat.OpenXml.VariableReplacer.Core.dll.so
		i64 u0x785bad4f0559c250, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.19_name, ; name: libaot-DocumentFormat.OpenXml.VariableReplacer.Core.dll.so
		ptr null; void* handle
	}, ; 464
	%struct.DSOCacheEntry {
		i64 u0x3f510adf788828dd, ; from name: System.Threading.Tasks.Extensions
		i64 u0x51aad7b1eaf4d2ae, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.211_name, ; name: libaot-System.Threading.Tasks.Extensions.dll.so
		ptr null; void* handle
	}, ; 465
	%struct.DSOCacheEntry {
		i64 u0x3fccbba309b92e05, ; from name: libaot-System.Diagnostics.Tracing
		i64 u0x28371251d401372b, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.150_name, ; name: libaot-System.Diagnostics.Tracing.dll.so
		ptr null; void* handle
	}, ; 466
	%struct.DSOCacheEntry {
		i64 u0x40355ba0b2be8b09, ; from name: aot-Syncfusion.Maui.Core.dll.so
		i64 u0x4cfc586bcbdc6c97, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.90_name, ; name: libaot-Syncfusion.Maui.Core.dll.so
		ptr null; void* handle
	}, ; 467
	%struct.DSOCacheEntry {
		i64 u0x403cd01c6fb39d89, ; from name: libaot-System.Net.WebSockets.dll.so
		i64 u0x403cd01c6fb39d89, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.175_name, ; name: libaot-System.Net.WebSockets.dll.so
		ptr null; void* handle
	}, ; 468
	%struct.DSOCacheEntry {
		i64 u0x405acf770fb5495b, ; from name: libaot-Microsoft.AspNetCore.Routing.Abstractions
		i64 u0x03ea24da2517cfb9, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.37_name, ; name: libaot-Microsoft.AspNetCore.Routing.Abstractions.dll.so
		ptr null; void* handle
	}, ; 469
	%struct.DSOCacheEntry {
		i64 u0x41342781d40c38c6, ; from name: aot-System.Text.RegularExpressions
		i64 u0x7c2c39dae387b52d, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.209_name, ; name: libaot-System.Text.RegularExpressions.dll.so
		ptr null; void* handle
	}, ; 470
	%struct.DSOCacheEntry {
		i64 u0x414229d5c58ecefa, ; from name: aot-System.Configuration.ConfigurationManager
		i64 u0x5d3a5af149aed459, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.96_name, ; name: libaot-System.Configuration.ConfigurationManager.dll.so
		ptr null; void* handle
	}, ; 471
	%struct.DSOCacheEntry {
		i64 u0x41574f7b8649001a, ; from name: libaot-Xamarin.AndroidX.Lifecycle.ViewModelSavedState
		i64 u0x9b809dc726e0140e, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.117_name, ; name: libaot-Xamarin.AndroidX.Lifecycle.ViewModelSavedState.dll.so
		ptr null; void* handle
	}, ; 472
	%struct.DSOCacheEntry {
		i64 u0x41833cf766d27d96, ; from name: mscorlib
		i64 u0xd45fa2873eb303d5, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.222_name, ; name: libaot-mscorlib.dll.so
		ptr null; void* handle
	}, ; 473
	%struct.DSOCacheEntry {
		i64 u0x418397997a341528, ; from name: System.Net.WebHeaderCollection.dll.so
		i64 u0x42b58ea66e808de7, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.173_name, ; name: libaot-System.Net.WebHeaderCollection.dll.so
		ptr null; void* handle
	}, ; 474
	%struct.DSOCacheEntry {
		i64 u0x418d89fb2901d219, ; from name: libaot-SQLitePCLRaw.batteries_v2.dll.so
		i64 u0x418d89fb2901d219, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.85_name, ; name: libaot-SQLitePCLRaw.batteries_v2.dll.so
		ptr null; void* handle
	}, ; 475
	%struct.DSOCacheEntry {
		i64 u0x41c1b507cc22deb1, ; from name: aot-Xamarin.AndroidX.Collection.Jvm.so
		i64 u0x1adc5c3038254713, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.107_name, ; name: libaot-Xamarin.AndroidX.Collection.Jvm.dll.so
		ptr null; void* handle
	}, ; 476
	%struct.DSOCacheEntry {
		i64 u0x41c972d328f102fd, ; from name: libaot-Microsoft.IdentityModel.Abstractions.dll.so
		i64 u0x41c972d328f102fd, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.69_name, ; name: libaot-Microsoft.IdentityModel.Abstractions.dll.so
		ptr null; void* handle
	}, ; 477
	%struct.DSOCacheEntry {
		i64 u0x424bf054b193b8da, ; from name: aot-System.Collections.Immutable.dll.so
		i64 u0x49e9602a3882bd40, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.136_name, ; name: libaot-System.Collections.Immutable.dll.so
		ptr null; void* handle
	}, ; 478
	%struct.DSOCacheEntry {
		i64 u0x426a5e4ee84b386c, ; from name: libaot-System.Data.Common.dll.so
		i64 u0x426a5e4ee84b386c, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.145_name, ; name: libaot-System.Data.Common.dll.so
		ptr null; void* handle
	}, ; 479
	%struct.DSOCacheEntry {
		i64 u0x4280517d6270bafa, ; from name: libaot-Microsoft.Net.Http.Headers.so
		i64 u0xa81dfd6455f2dc19, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.80_name, ; name: libaot-Microsoft.Net.Http.Headers.dll.so
		ptr null; void* handle
	}, ; 480
	%struct.DSOCacheEntry {
		i64 u0x428c198084da5ebb, ; from name: libaot-System.ComponentModel.Annotations.so
		i64 u0xbf7d944f85fcd72c, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.140_name, ; name: libaot-System.ComponentModel.Annotations.dll.so
		ptr null; void* handle
	}, ; 481
	%struct.DSOCacheEntry {
		i64 u0x429fcab2ef140e8c, ; from name: aot-System.Net.Security
		i64 u0x1271045d1561acf0, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.170_name, ; name: libaot-System.Net.Security.dll.so
		ptr null; void* handle
	}, ; 482
	%struct.DSOCacheEntry {
		i64 u0x42b58ea66e808de7, ; from name: libaot-System.Net.WebHeaderCollection.dll.so
		i64 u0x42b58ea66e808de7, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.173_name, ; name: libaot-System.Net.WebHeaderCollection.dll.so
		ptr null; void* handle
	}, ; 483
	%struct.DSOCacheEntry {
		i64 u0x42c08831b421dece, ; from name: libaot-Microsoft.Extensions.DependencyModel.dll.so
		i64 u0x42c08831b421dece, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.56_name, ; name: libaot-Microsoft.Extensions.DependencyModel.dll.so
		ptr null; void* handle
	}, ; 484
	%struct.DSOCacheEntry {
		i64 u0x42c7eb0880ff24a4, ; from name: libaot-Xamarin.AndroidX.AppCompat.dll.so
		i64 u0x42c7eb0880ff24a4, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.103_name, ; name: libaot-Xamarin.AndroidX.AppCompat.dll.so
		ptr null; void* handle
	}, ; 485
	%struct.DSOCacheEntry {
		i64 u0x42eb726a7898567d, ; from name: aot-System.Xml.XmlSerializer.so
		i64 u0xdfef1aaab339ffdb, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.220_name, ; name: libaot-System.Xml.XmlSerializer.dll.so
		ptr null; void* handle
	}, ; 486
	%struct.DSOCacheEntry {
		i64 u0x43198e1a840d8a61, ; from name: aot-System.ComponentModel.Annotations.dll.so
		i64 u0xbf7d944f85fcd72c, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.140_name, ; name: libaot-System.ComponentModel.Annotations.dll.so
		ptr null; void* handle
	}, ; 487
	%struct.DSOCacheEntry {
		i64 u0x431a597922a69023, ; from name: Microsoft.AspNetCore.Routing.dll.so
		i64 u0x6872149aac83968a, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.36_name, ; name: libaot-Microsoft.AspNetCore.Routing.dll.so
		ptr null; void* handle
	}, ; 488
	%struct.DSOCacheEntry {
		i64 u0x434f95592d2838eb, ; from name: aot-Microsoft.AspNetCore.Http.dll.so
		i64 u0x6caedb1d96a79293, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.27_name, ; name: libaot-Microsoft.AspNetCore.Http.dll.so
		ptr null; void* handle
	}, ; 489
	%struct.DSOCacheEntry {
		i64 u0x4369960919e5e6e9, ; from name: libaot-System.Threading.Thread.so
		i64 u0x675935a1e3b604dc, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.212_name, ; name: libaot-System.Threading.Thread.dll.so
		ptr null; void* handle
	}, ; 490
	%struct.DSOCacheEntry {
		i64 u0x436e780850f7295e, ; from name: libaot-Microsoft.IdentityModel.JsonWebTokens.so
		i64 u0x0323e786c13d309d, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.70_name, ; name: libaot-Microsoft.IdentityModel.JsonWebTokens.dll.so
		ptr null; void* handle
	}, ; 491
	%struct.DSOCacheEntry {
		i64 u0x43878f709b5ae552, ; from name: aot-Xamarin.AndroidX.Loader
		i64 u0x74b0aefe8f467d50, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.118_name, ; name: libaot-Xamarin.AndroidX.Loader.dll.so
		ptr null; void* handle
	}, ; 492
	%struct.DSOCacheEntry {
		i64 u0x439d3178d4879626, ; from name: aot-Microsoft.Extensions.DependencyModel
		i64 u0x42c08831b421dece, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.56_name, ; name: libaot-Microsoft.Extensions.DependencyModel.dll.so
		ptr null; void* handle
	}, ; 493
	%struct.DSOCacheEntry {
		i64 u0x43b97d4b2e275e06, ; from name: aot-Xamarin.AndroidX.Browser.so
		i64 u0x9865c0bf349d1465, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.105_name, ; name: libaot-Xamarin.AndroidX.Browser.dll.so
		ptr null; void* handle
	}, ; 494
	%struct.DSOCacheEntry {
		i64 u0x442640d0e35d7104, ; from name: aot-Microsoft.IdentityModel.JsonWebTokens.dll.so
		i64 u0x0323e786c13d309d, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.70_name, ; name: libaot-Microsoft.IdentityModel.JsonWebTokens.dll.so
		ptr null; void* handle
	}, ; 495
	%struct.DSOCacheEntry {
		i64 u0x4433a7e2d345f29f, ; from name: libaot-System.Security.AccessControl
		i64 u0x69dd3c9ffb9c24cd, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.195_name, ; name: libaot-System.Security.AccessControl.dll.so
		ptr null; void* handle
	}, ; 496
	%struct.DSOCacheEntry {
		i64 u0x448bd33429269b19, ; from name: Microsoft.CSharp
		i64 u0xe38bfeec71b3b67d, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.132_name, ; name: libaot-Microsoft.CSharp.dll.so
		ptr null; void* handle
	}, ; 497
	%struct.DSOCacheEntry {
		i64 u0x449d50ae1b1691f1, ; from name: aot-Microsoft.CSharp
		i64 u0xe38bfeec71b3b67d, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.132_name, ; name: libaot-Microsoft.CSharp.dll.so
		ptr null; void* handle
	}, ; 498
	%struct.DSOCacheEntry {
		i64 u0x449e5d60672be4ae, ; from name: libaot-Microsoft.AspNetCore.Authentication.Core
		i64 u0x2b7aae4ebbc0110d, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.21_name, ; name: libaot-Microsoft.AspNetCore.Authentication.Core.dll.so
		ptr null; void* handle
	}, ; 499
	%struct.DSOCacheEntry {
		i64 u0x44b4c8e72786eb98, ; from name: libaot-System.Private.Uri.so
		i64 u0xe57af9ab00f5c61d, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.179_name, ; name: libaot-System.Private.Uri.dll.so
		ptr null; void* handle
	}, ; 500
	%struct.DSOCacheEntry {
		i64 u0x44d3515be13c385a, ; from name: aot-System.IO.Pipes.dll.so
		i64 u0x370b7031653c1807, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.159_name, ; name: libaot-System.IO.Pipes.dll.so
		ptr null; void* handle
	}, ; 501
	%struct.DSOCacheEntry {
		i64 u0x44de556bf0476715, ; from name: Mono.HttpUtility
		i64 u0x475325afa16dbfe5, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.82_name, ; name: libaot-Mono.HttpUtility.dll.so
		ptr null; void* handle
	}, ; 502
	%struct.DSOCacheEntry {
		i64 u0x44f0be8ec488ede1, ; from name: aot-System.Threading.ThreadPool.dll.so
		i64 u0x7d7a84dcff7fdb59, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.213_name, ; name: libaot-System.Threading.ThreadPool.dll.so
		ptr null; void* handle
	}, ; 503
	%struct.DSOCacheEntry {
		i64 u0x4500399bf06d18b5, ; from name: Microsoft.EntityFrameworkCore.Abstractions.so
		i64 u0x98d96e0f4341bc32, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.47_name, ; name: libaot-Microsoft.EntityFrameworkCore.Abstractions.dll.so
		ptr null; void* handle
	}, ; 504
	%struct.DSOCacheEntry {
		i64 u0x452bb1f4d299cb18, ; from name: libaot-Microsoft.Extensions.Features
		i64 u0xaebd3af6eeceb1eb, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.59_name, ; name: libaot-Microsoft.Extensions.Features.dll.so
		ptr null; void* handle
	}, ; 505
	%struct.DSOCacheEntry {
		i64 u0x45344658e8f1a46d, ; from name: Microsoft.AspNetCore.Authentication.Core
		i64 u0x2b7aae4ebbc0110d, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.21_name, ; name: libaot-Microsoft.AspNetCore.Authentication.Core.dll.so
		ptr null; void* handle
	}, ; 506
	%struct.DSOCacheEntry {
		i64 u0x453c6b085e8d7dd7, ; from name: Microsoft.IdentityModel.Protocols.so
		i64 u0x9037f9d64d16c443, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.72_name, ; name: libaot-Microsoft.IdentityModel.Protocols.dll.so
		ptr null; void* handle
	}, ; 507
	%struct.DSOCacheEntry {
		i64 u0x455d67f66d4ea400, ; from name: Microsoft.AspNetCore.Hosting.Abstractions.so
		i64 u0x8e5050b380b35b28, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.25_name, ; name: libaot-Microsoft.AspNetCore.Hosting.Abstractions.dll.so
		ptr null; void* handle
	}, ; 508
	%struct.DSOCacheEntry {
		i64 u0x456cc421e6ef3bb7, ; from name: libaot-DocumentFormat.OpenXml.dll.so
		i64 u0x456cc421e6ef3bb7, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.17_name, ; name: libaot-DocumentFormat.OpenXml.dll.so
		ptr null; void* handle
	}, ; 509
	%struct.DSOCacheEntry {
		i64 u0x456e37cd491657b0, ; from name: libaot-Xamarin.AndroidX.AppCompat.AppCompatResources.dll.so
		i64 u0x456e37cd491657b0, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.104_name, ; name: libaot-Xamarin.AndroidX.AppCompat.AppCompatResources.dll.so
		ptr null; void* handle
	}, ; 510
	%struct.DSOCacheEntry {
		i64 u0x458a25734d977509, ; from name: aot-Xamarin.AndroidX.SavedState.dll.so
		i64 u0x039588659cdd2f6a, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.124_name, ; name: libaot-Xamarin.AndroidX.SavedState.dll.so
		ptr null; void* handle
	}, ; 511
	%struct.DSOCacheEntry {
		i64 u0x4595d9c27242b287, ; from name: libaot-Xamarin.AndroidX.ViewPager2.dll.so
		i64 u0x4595d9c27242b287, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.127_name, ; name: libaot-Xamarin.AndroidX.ViewPager2.dll.so
		ptr null; void* handle
	}, ; 512
	%struct.DSOCacheEntry {
		i64 u0x45c40276a42e283e, ; from name: System.Diagnostics.TraceSource
		i64 u0x2119cc81025daa05, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.149_name, ; name: libaot-System.Diagnostics.TraceSource.dll.so
		ptr null; void* handle
	}, ; 513
	%struct.DSOCacheEntry {
		i64 u0x45dd035e939418ff, ; from name: Xamarin.AndroidX.Lifecycle.Common.Jvm.so
		i64 u0x2ec8d2dcf2c4a71b, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.114_name, ; name: libaot-Xamarin.AndroidX.Lifecycle.Common.Jvm.dll.so
		ptr null; void* handle
	}, ; 514
	%struct.DSOCacheEntry {
		i64 u0x45f5da81c2af55b6, ; from name: aot-CommunityToolkit.Mvvm.so
		i64 u0x324cedd7271c2c92, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.16_name, ; name: libaot-CommunityToolkit.Mvvm.dll.so
		ptr null; void* handle
	}, ; 515
	%struct.DSOCacheEntry {
		i64 u0x45fcc9fd66f25095, ; from name: Microsoft.Extensions.DependencyModel
		i64 u0x42c08831b421dece, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.56_name, ; name: libaot-Microsoft.Extensions.DependencyModel.dll.so
		ptr null; void* handle
	}, ; 516
	%struct.DSOCacheEntry {
		i64 u0x45fd1868d9f6c490, ; from name: Microsoft.Extensions.ObjectPool.so
		i64 u0xa951cdbe6a05ef83, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.64_name, ; name: libaot-Microsoft.Extensions.ObjectPool.dll.so
		ptr null; void* handle
	}, ; 517
	%struct.DSOCacheEntry {
		i64 u0x4610877cf9ab8b85, ; from name: aot-System.Memory.dll.so
		i64 u0xad582851e7d05243, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.163_name, ; name: libaot-System.Memory.dll.so
		ptr null; void* handle
	}, ; 518
	%struct.DSOCacheEntry {
		i64 u0x4643d8f925d8e6b7, ; from name: libaot-Microsoft.Extensions.DependencyInjection.Abstractions.dll.so
		i64 u0x4643d8f925d8e6b7, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.55_name, ; name: libaot-Microsoft.Extensions.DependencyInjection.Abstractions.dll.so
		ptr null; void* handle
	}, ; 519
	%struct.DSOCacheEntry {
		i64 u0x466077e32f0763d9, ; from name: libaot-SocialMediaMaui.Shared
		i64 u0x12448631a200ce9a, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.10_name, ; name: libaot-SocialMediaMaui.Shared.dll.so
		ptr null; void* handle
	}, ; 520
	%struct.DSOCacheEntry {
		i64 u0x46ac61309da81795, ; from name: aot-System.Security.Cryptography.Encoding.dll.so
		i64 u0x31145bf76e7d3b7a, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.200_name, ; name: libaot-System.Security.Cryptography.Encoding.dll.so
		ptr null; void* handle
	}, ; 521
	%struct.DSOCacheEntry {
		i64 u0x46fe6fb82f79008c, ; from name: libaot-Java.Interop.so
		i64 u0x6ce045494a545eab, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.224_name, ; name: libaot-Java.Interop.dll.so
		ptr null; void* handle
	}, ; 522
	%struct.DSOCacheEntry {
		i64 u0x470dccb207942fd6, ; from name: libaot-SQLitePCLRaw.batteries_v2
		i64 u0x418d89fb2901d219, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.85_name, ; name: libaot-SQLitePCLRaw.batteries_v2.dll.so
		ptr null; void* handle
	}, ; 523
	%struct.DSOCacheEntry {
		i64 u0x475325afa16dbfe5, ; from name: libaot-Mono.HttpUtility.dll.so
		i64 u0x475325afa16dbfe5, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.82_name, ; name: libaot-Mono.HttpUtility.dll.so
		ptr null; void* handle
	}, ; 524
	%struct.DSOCacheEntry {
		i64 u0x4774af8eda24d716, ; from name: aot-System.Net.ServerSentEvents
		i64 u0x95302b4a91a9ea47, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.99_name, ; name: libaot-System.Net.ServerSentEvents.dll.so
		ptr null; void* handle
	}, ; 525
	%struct.DSOCacheEntry {
		i64 u0x47770bb25728886b, ; from name: System.IdentityModel.Tokens.Jwt.dll.so
		i64 u0xe05faae6d518aca9, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.97_name, ; name: libaot-System.IdentityModel.Tokens.Jwt.dll.so
		ptr null; void* handle
	}, ; 526
	%struct.DSOCacheEntry {
		i64 u0x478727d2ab1d0632, ; from name: aot-Syncfusion.Licensing.so
		i64 u0xe0ba2b05be11dec6, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.89_name, ; name: libaot-Syncfusion.Licensing.dll.so
		ptr null; void* handle
	}, ; 527
	%struct.DSOCacheEntry {
		i64 u0x47b783475e117aa7, ; from name: aot-Microsoft.AspNetCore.SignalR.Protocols.Json.dll.so
		i64 u0x53a8edd5eb823442, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.42_name, ; name: libaot-Microsoft.AspNetCore.SignalR.Protocols.Json.dll.so
		ptr null; void* handle
	}, ; 528
	%struct.DSOCacheEntry {
		i64 u0x47d88441a8622221, ; from name: aot-Microsoft.AspNetCore.Routing.Abstractions.dll.so
		i64 u0x03ea24da2517cfb9, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.37_name, ; name: libaot-Microsoft.AspNetCore.Routing.Abstractions.dll.so
		ptr null; void* handle
	}, ; 529
	%struct.DSOCacheEntry {
		i64 u0x480a488133b8d5a9, ; from name: aot-Microsoft.Extensions.Diagnostics.Abstractions
		i64 u0xd10bb63f997c45a2, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.58_name, ; name: libaot-Microsoft.Extensions.Diagnostics.Abstractions.dll.so
		ptr null; void* handle
	}, ; 530
	%struct.DSOCacheEntry {
		i64 u0x480ae1b0fafcfa88, ; from name: aot-System.Collections.NonGeneric.so
		i64 u0x6fd15fb6a42c9afc, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.137_name, ; name: libaot-System.Collections.NonGeneric.dll.so
		ptr null; void* handle
	}, ; 531
	%struct.DSOCacheEntry {
		i64 u0x483260ba69d65787, ; from name: System.Reflection.Emit.ILGeneration.dll.so
		i64 u0xbba986a49febf640, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.182_name, ; name: libaot-System.Reflection.Emit.ILGeneration.dll.so
		ptr null; void* handle
	}, ; 532
	%struct.DSOCacheEntry {
		i64 u0x48468d64edfccee1, ; from name: netstandard.so
		i64 u0xb6ab21527197f7f1, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.223_name, ; name: libaot-netstandard.dll.so
		ptr null; void* handle
	}, ; 533
	%struct.DSOCacheEntry {
		i64 u0x484bdd686079d903, ; from name: libaot-DocumentFormat.OpenXml.Framework.so
		i64 u0xf959815fea0ec361, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.18_name, ; name: libaot-DocumentFormat.OpenXml.Framework.dll.so
		ptr null; void* handle
	}, ; 534
	%struct.DSOCacheEntry {
		i64 u0x484f66d7cb1007ac, ; from name: aot-System.Security.Cryptography.Primitives
		i64 u0x7d7dff41d9076267, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.201_name, ; name: libaot-System.Security.Cryptography.Primitives.dll.so
		ptr null; void* handle
	}, ; 535
	%struct.DSOCacheEntry {
		i64 u0x489288ef6f012616, ; from name: libaot-Microsoft.Extensions.Caching.Memory
		i64 u0x331a7f0d6c2c08c9, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.51_name, ; name: libaot-Microsoft.Extensions.Caching.Memory.dll.so
		ptr null; void* handle
	}, ; 536
	%struct.DSOCacheEntry {
		i64 u0x48a6d2fa2eb5d049, ; from name: Microsoft.AspNetCore.SignalR.Protocols.Json
		i64 u0x53a8edd5eb823442, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.42_name, ; name: libaot-Microsoft.AspNetCore.SignalR.Protocols.Json.dll.so
		ptr null; void* handle
	}, ; 537
	%struct.DSOCacheEntry {
		i64 u0x48c3022cf08df9d7, ; from name: aot-Microsoft.AspNetCore.Http.Features
		i64 u0x621c21d9c3290da0, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.32_name, ; name: libaot-Microsoft.AspNetCore.Http.Features.dll.so
		ptr null; void* handle
	}, ; 538
	%struct.DSOCacheEntry {
		i64 u0x4945fdd6851a6071, ; from name: aot-System.Security.Claims.so
		i64 u0xd1ca18d995b9f417, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.196_name, ; name: libaot-System.Security.Claims.dll.so
		ptr null; void* handle
	}, ; 539
	%struct.DSOCacheEntry {
		i64 u0x49578946fc94ae37, ; from name: Microsoft.AspNetCore.Routing.Abstractions.dll.so
		i64 u0x03ea24da2517cfb9, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.37_name, ; name: libaot-Microsoft.AspNetCore.Routing.Abstractions.dll.so
		ptr null; void* handle
	}, ; 540
	%struct.DSOCacheEntry {
		i64 u0x49d2cff4303d7d5f, ; from name: Microsoft.Extensions.Diagnostics.dll.so
		i64 u0xd34809bcacf156ee, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.57_name, ; name: libaot-Microsoft.Extensions.Diagnostics.dll.so
		ptr null; void* handle
	}, ; 541
	%struct.DSOCacheEntry {
		i64 u0x49e952f19a4e2022, ; from name: System.ObjectModel
		i64 u0x914167d87d2ee1b1, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.177_name, ; name: libaot-System.ObjectModel.dll.so
		ptr null; void* handle
	}, ; 542
	%struct.DSOCacheEntry {
		i64 u0x49e9602a3882bd40, ; from name: libaot-System.Collections.Immutable.dll.so
		i64 u0x49e9602a3882bd40, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.136_name, ; name: libaot-System.Collections.Immutable.dll.so
		ptr null; void* handle
	}, ; 543
	%struct.DSOCacheEntry {
		i64 u0x4a40ea605416f4a1, ; from name: System.Reflection.Emit.dll.so
		i64 u0x868be26aba2eea6d, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.184_name, ; name: libaot-System.Reflection.Emit.dll.so
		ptr null; void* handle
	}, ; 544
	%struct.DSOCacheEntry {
		i64 u0x4a42c40ce544bc4a, ; from name: libaot-System.Numerics.Vectors.so
		i64 u0x37fbdff3aa18872d, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.176_name, ; name: libaot-System.Numerics.Vectors.dll.so
		ptr null; void* handle
	}, ; 545
	%struct.DSOCacheEntry {
		i64 u0x4a729eca538536bc, ; from name: aot-CommunityToolkit.Maui.Core.so
		i64 u0x1f7f7b0e04fbedb0, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.15_name, ; name: libaot-CommunityToolkit.Maui.Core.dll.so
		ptr null; void* handle
	}, ; 546
	%struct.DSOCacheEntry {
		i64 u0x4a98c34e2b2d4181, ; from name: libaot-Microsoft.Extensions.Logging.so
		i64 u0x9b6f0babce2a1934, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.62_name, ; name: libaot-Microsoft.Extensions.Logging.dll.so
		ptr null; void* handle
	}, ; 547
	%struct.DSOCacheEntry {
		i64 u0x4a9bda0e8528b414, ; from name: libaot-System.Formats.Asn1.dll.so
		i64 u0x4a9bda0e8528b414, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.153_name, ; name: libaot-System.Formats.Asn1.dll.so
		ptr null; void* handle
	}, ; 548
	%struct.DSOCacheEntry {
		i64 u0x4aca9dd1f072c52c, ; from name: libaot-Azure.Core.so
		i64 u0x821f528a92d55dea, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.12_name, ; name: libaot-Azure.Core.dll.so
		ptr null; void* handle
	}, ; 549
	%struct.DSOCacheEntry {
		i64 u0x4b0a2a3cca6b8ff4, ; from name: aot-System.IO.FileSystem.Watcher.dll.so
		i64 u0xf90aa99869639df6, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.157_name, ; name: libaot-System.IO.FileSystem.Watcher.dll.so
		ptr null; void* handle
	}, ; 550
	%struct.DSOCacheEntry {
		i64 u0x4b576d47ac054f3c, ; from name: System.IO.FileSystem.AccessControl
		i64 u0xf8af38e7ca3d5d78, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.156_name, ; name: libaot-System.IO.FileSystem.AccessControl.dll.so
		ptr null; void* handle
	}, ; 551
	%struct.DSOCacheEntry {
		i64 u0x4b5cc074fafbe58e, ; from name: Microsoft.AspNetCore.ResponseCaching.Abstractions
		i64 u0x2eb68ca0cc467150, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.35_name, ; name: libaot-Microsoft.AspNetCore.ResponseCaching.Abstractions.dll.so
		ptr null; void* handle
	}, ; 552
	%struct.DSOCacheEntry {
		i64 u0x4b7b6532ded934b7, ; from name: System.Text.Json
		i64 u0x9bb35aa4bcef7b80, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.208_name, ; name: libaot-System.Text.Json.dll.so
		ptr null; void* handle
	}, ; 553
	%struct.DSOCacheEntry {
		i64 u0x4b8f8ea3c2df6bb0, ; from name: System.ClientModel
		i64 u0xa4d336a75ab12937, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.95_name, ; name: libaot-System.ClientModel.dll.so
		ptr null; void* handle
	}, ; 554
	%struct.DSOCacheEntry {
		i64 u0x4bac74944f1d2417, ; from name: aot-Microsoft.Identity.Client.so
		i64 u0xd20e64387a412094, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.67_name, ; name: libaot-Microsoft.Identity.Client.dll.so
		ptr null; void* handle
	}, ; 555
	%struct.DSOCacheEntry {
		i64 u0x4bb6a9f646249bb0, ; from name: libaot-System.Linq.Queryable.so
		i64 u0x5932dbf572fab50a, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.161_name, ; name: libaot-System.Linq.Queryable.dll.so
		ptr null; void* handle
	}, ; 556
	%struct.DSOCacheEntry {
		i64 u0x4bd5ce51eacd47d7, ; from name: libaot-Refit.so
		i64 u0x00a2ced568899a5e, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.83_name, ; name: libaot-Refit.dll.so
		ptr null; void* handle
	}, ; 557
	%struct.DSOCacheEntry {
		i64 u0x4bdd87f0dd5a3b9f, ; from name: aot-System.Private.Xml.Linq.so
		i64 u0x99ef7518b4544507, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.180_name, ; name: libaot-System.Private.Xml.Linq.dll.so
		ptr null; void* handle
	}, ; 558
	%struct.DSOCacheEntry {
		i64 u0x4be8f991cb00f075, ; from name: libaot-Microsoft.IdentityModel.Tokens.dll.so
		i64 u0x4be8f991cb00f075, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.74_name, ; name: libaot-Microsoft.IdentityModel.Tokens.dll.so
		ptr null; void* handle
	}, ; 559
	%struct.DSOCacheEntry {
		i64 u0x4bea014989424a56, ; from name: libaot-Xamarin.AndroidX.DrawerLayout.dll.so
		i64 u0x4bea014989424a56, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.112_name, ; name: libaot-Xamarin.AndroidX.DrawerLayout.dll.so
		ptr null; void* handle
	}, ; 560
	%struct.DSOCacheEntry {
		i64 u0x4beb4f32e5e8b27b, ; from name: aot-Xamarin.AndroidX.AppCompat.so
		i64 u0x42c7eb0880ff24a4, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.103_name, ; name: libaot-Xamarin.AndroidX.AppCompat.dll.so
		ptr null; void* handle
	}, ; 561
	%struct.DSOCacheEntry {
		i64 u0x4c020054a4380f1b, ; from name: aot-System.Drawing
		i64 u0x366c3ed8a6266ffb, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.152_name, ; name: libaot-System.Drawing.dll.so
		ptr null; void* handle
	}, ; 562
	%struct.DSOCacheEntry {
		i64 u0x4c0888897450e9e4, ; from name: libaot-Microsoft.AspNetCore.Hosting.Abstractions.so
		i64 u0x8e5050b380b35b28, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.25_name, ; name: libaot-Microsoft.AspNetCore.Hosting.Abstractions.dll.so
		ptr null; void* handle
	}, ; 563
	%struct.DSOCacheEntry {
		i64 u0x4c1e6df1abbaf0bd, ; from name: aot-Microsoft.Extensions.FileProviders.Abstractions.dll.so
		i64 u0x82b65efc7b0bc50f, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.60_name, ; name: libaot-Microsoft.Extensions.FileProviders.Abstractions.dll.so
		ptr null; void* handle
	}, ; 564
	%struct.DSOCacheEntry {
		i64 u0x4c5401149da6445e, ; from name: libaot-System.Net.Sockets.dll.so
		i64 u0x4c5401149da6445e, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.171_name, ; name: libaot-System.Net.Sockets.dll.so
		ptr null; void* handle
	}, ; 565
	%struct.DSOCacheEntry {
		i64 u0x4c6038523596e373, ; from name: libaot-System.Security.Cryptography.Encoding.so
		i64 u0x31145bf76e7d3b7a, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.200_name, ; name: libaot-System.Security.Cryptography.Encoding.dll.so
		ptr null; void* handle
	}, ; 566
	%struct.DSOCacheEntry {
		i64 u0x4c84dfc50c0bd80f, ; from name: aot-Xamarin.AndroidX.CustomView.dll.so
		i64 u0xe7b2e898b68d9670, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.111_name, ; name: libaot-Xamarin.AndroidX.CustomView.dll.so
		ptr null; void* handle
	}, ; 567
	%struct.DSOCacheEntry {
		i64 u0x4c99806689e74f14, ; from name: libaot-Xamarin.Kotlin.StdLib
		i64 u0x0c644d6a2b020c43, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.129_name, ; name: libaot-Xamarin.Kotlin.StdLib.dll.so
		ptr null; void* handle
	}, ; 568
	%struct.DSOCacheEntry {
		i64 u0x4ca5e42514d6675e, ; from name: aot-System.Xml.Linq.dll.so
		i64 u0xe89b56c5a60687e6, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.217_name, ; name: libaot-System.Xml.Linq.dll.so
		ptr null; void* handle
	}, ; 569
	%struct.DSOCacheEntry {
		i64 u0x4cc29a3bf5efb618, ; from name: libaot-Refit
		i64 u0x00a2ced568899a5e, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.83_name, ; name: libaot-Refit.dll.so
		ptr null; void* handle
	}, ; 570
	%struct.DSOCacheEntry {
		i64 u0x4ccc1cac518f34cc, ; from name: libaot-Microsoft.AspNetCore.Http
		i64 u0x6caedb1d96a79293, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.27_name, ; name: libaot-Microsoft.AspNetCore.Http.dll.so
		ptr null; void* handle
	}, ; 571
	%struct.DSOCacheEntry {
		i64 u0x4ce854cec214bccd, ; from name: aot-System.Security.Cryptography.Cng
		i64 u0xe4a5a519ffe8b5e9, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.198_name, ; name: libaot-System.Security.Cryptography.Cng.dll.so
		ptr null; void* handle
	}, ; 572
	%struct.DSOCacheEntry {
		i64 u0x4ce9b13ddea58a1b, ; from name: libaot-System.Net.WebClient.dll.so
		i64 u0x4ce9b13ddea58a1b, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.172_name, ; name: libaot-System.Net.WebClient.dll.so
		ptr null; void* handle
	}, ; 573
	%struct.DSOCacheEntry {
		i64 u0x4cfc35da95507261, ; from name: Xamarin.AndroidX.Fragment.so
		i64 u0x8ab6d3431da5497e, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.113_name, ; name: libaot-Xamarin.AndroidX.Fragment.dll.so
		ptr null; void* handle
	}, ; 574
	%struct.DSOCacheEntry {
		i64 u0x4cfc586bcbdc6c97, ; from name: libaot-Syncfusion.Maui.Core.dll.so
		i64 u0x4cfc586bcbdc6c97, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.90_name, ; name: libaot-Syncfusion.Maui.Core.dll.so
		ptr null; void* handle
	}, ; 575
	%struct.DSOCacheEntry {
		i64 u0x4d12310dad3f4532, ; from name: aot-System.Linq.Expressions.so
		i64 u0xda1d7acd827eb320, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.160_name, ; name: libaot-System.Linq.Expressions.dll.so
		ptr null; void* handle
	}, ; 576
	%struct.DSOCacheEntry {
		i64 u0x4d16f4a17e081b1e, ; from name: libaot-Microsoft.AspNetCore.Authorization.Policy.dll.so
		i64 u0x4d16f4a17e081b1e, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.23_name, ; name: libaot-Microsoft.AspNetCore.Authorization.Policy.dll.so
		ptr null; void* handle
	}, ; 577
	%struct.DSOCacheEntry {
		i64 u0x4d43f0725fd9f39c, ; from name: libaot-System.Collections.Immutable
		i64 u0x49e9602a3882bd40, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.136_name, ; name: libaot-System.Collections.Immutable.dll.so
		ptr null; void* handle
	}, ; 578
	%struct.DSOCacheEntry {
		i64 u0x4d55a010ffc4faff, ; from name: System.Private.Xml
		i64 u0x52bbd048717682d4, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.181_name, ; name: libaot-System.Private.Xml.dll.so
		ptr null; void* handle
	}, ; 579
	%struct.DSOCacheEntry {
		i64 u0x4e26d7418b2519b6, ; from name: aot-Syncfusion.Maui.ImageEditor.dll.so
		i64 u0x70f8ca2f11ec3669, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.91_name, ; name: libaot-Syncfusion.Maui.ImageEditor.dll.so
		ptr null; void* handle
	}, ; 580
	%struct.DSOCacheEntry {
		i64 u0x4e2b6f03e73f8827, ; from name: aot-System.Net.WebSockets.Client
		i64 u0x0a18b49bebc33444, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.174_name, ; name: libaot-System.Net.WebSockets.Client.dll.so
		ptr null; void* handle
	}, ; 581
	%struct.DSOCacheEntry {
		i64 u0x4e32f00cb0937401, ; from name: Mono.Android.Runtime
		i64 u0x156ae2b2e8a39884, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.225_name, ; name: libaot-Mono.Android.Runtime.dll.so
		ptr null; void* handle
	}, ; 582
	%struct.DSOCacheEntry {
		i64 u0x4e3903adbee9a6d2, ; from name: mscorlib.so
		i64 u0xd45fa2873eb303d5, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.222_name, ; name: libaot-mscorlib.dll.so
		ptr null; void* handle
	}, ; 583
	%struct.DSOCacheEntry {
		i64 u0x4e44502c520c07bc, ; from name: System.Web.HttpUtility.dll.so
		i64 u0xcdab467c6caa8aba, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.216_name, ; name: libaot-System.Web.HttpUtility.dll.so
		ptr null; void* handle
	}, ; 584
	%struct.DSOCacheEntry {
		i64 u0x4e5eea4668ac2b18, ; from name: System.Text.Encoding.CodePages
		i64 u0x16262857ad9a2e54, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.205_name, ; name: libaot-System.Text.Encoding.CodePages.dll.so
		ptr null; void* handle
	}, ; 585
	%struct.DSOCacheEntry {
		i64 u0x4e70b787e0cecbd6, ; from name: aot-System.Reflection.Emit.so
		i64 u0x868be26aba2eea6d, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.184_name, ; name: libaot-System.Reflection.Emit.dll.so
		ptr null; void* handle
	}, ; 586
	%struct.DSOCacheEntry {
		i64 u0x4efa6deaa6a08300, ; from name: Microsoft.AspNetCore.SignalR.Common.so
		i64 u0x1d711f330f5778d7, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.40_name, ; name: libaot-Microsoft.AspNetCore.SignalR.Common.dll.so
		ptr null; void* handle
	}, ; 587
	%struct.DSOCacheEntry {
		i64 u0x4efbdfac55f94b48, ; from name: mscorlib.dll.so
		i64 u0xd45fa2873eb303d5, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.222_name, ; name: libaot-mscorlib.dll.so
		ptr null; void* handle
	}, ; 588
	%struct.DSOCacheEntry {
		i64 u0x4fa4ed76373ed627, ; from name: aot-System.Runtime.Caching
		i64 u0x9a1f1aedbdf3f019, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.100_name, ; name: libaot-System.Runtime.Caching.dll.so
		ptr null; void* handle
	}, ; 589
	%struct.DSOCacheEntry {
		i64 u0x4faf4c0e214d2804, ; from name: aot-Microsoft.EntityFrameworkCore.Abstractions
		i64 u0x98d96e0f4341bc32, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.47_name, ; name: libaot-Microsoft.EntityFrameworkCore.Abstractions.dll.so
		ptr null; void* handle
	}, ; 590
	%struct.DSOCacheEntry {
		i64 u0x4fb15a4a8810e42f, ; from name: aot-System.Memory.so
		i64 u0xad582851e7d05243, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.163_name, ; name: libaot-System.Memory.dll.so
		ptr null; void* handle
	}, ; 591
	%struct.DSOCacheEntry {
		i64 u0x4fd5f3ee53d0a4f0, ; from name: SQLitePCLRaw.lib.e_sqlite3.android
		i64 u0x6a03b775044080b2, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.87_name, ; name: libaot-SQLitePCLRaw.lib.e_sqlite3.android.dll.so
		ptr null; void* handle
	}, ; 592
	%struct.DSOCacheEntry {
		i64 u0x4ffd65baff757598, ; from name: Microsoft.IdentityModel.Tokens
		i64 u0x4be8f991cb00f075, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.74_name, ; name: libaot-Microsoft.IdentityModel.Tokens.dll.so
		ptr null; void* handle
	}, ; 593
	%struct.DSOCacheEntry {
		i64 u0x5097f028d162118e, ; from name: libaot-Microsoft.IdentityModel.Abstractions
		i64 u0x41c972d328f102fd, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.69_name, ; name: libaot-Microsoft.IdentityModel.Abstractions.dll.so
		ptr null; void* handle
	}, ; 594
	%struct.DSOCacheEntry {
		i64 u0x50caf2eb8a6ca05f, ; from name: aot-Microsoft.Extensions.DependencyModel.dll.so
		i64 u0x42c08831b421dece, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.56_name, ; name: libaot-Microsoft.Extensions.DependencyModel.dll.so
		ptr null; void* handle
	}, ; 595
	%struct.DSOCacheEntry {
		i64 u0x50e73e630c8fbd4e, ; from name: libaot-Microsoft.Extensions.Options
		i64 u0xeef607f38ca22ffc, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.65_name, ; name: libaot-Microsoft.Extensions.Options.dll.so
		ptr null; void* handle
	}, ; 596
	%struct.DSOCacheEntry {
		i64 u0x50f8d125d8dd00cf, ; from name: libaot-System.Console
		i64 u0xc2da5dca6ccd8b0a, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.144_name, ; name: libaot-System.Console.dll.so
		ptr null; void* handle
	}, ; 597
	%struct.DSOCacheEntry {
		i64 u0x510a6e81b159c636, ; from name: aot-Xamarin.AndroidX.CursorAdapter.so
		i64 u0xdf3c491694996c7e, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.110_name, ; name: libaot-Xamarin.AndroidX.CursorAdapter.dll.so
		ptr null; void* handle
	}, ; 598
	%struct.DSOCacheEntry {
		i64 u0x5112ed116d87baf8, ; from name: CommunityToolkit.Mvvm
		i64 u0x324cedd7271c2c92, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.16_name, ; name: libaot-CommunityToolkit.Mvvm.dll.so
		ptr null; void* handle
	}, ; 599
	%struct.DSOCacheEntry {
		i64 u0x5117999ca8fa8dc9, ; from name: libaot-System.Xml.Linq.so
		i64 u0xe89b56c5a60687e6, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.217_name, ; name: libaot-System.Xml.Linq.dll.so
		ptr null; void* handle
	}, ; 600
	%struct.DSOCacheEntry {
		i64 u0x5117dc2e624a133a, ; from name: libaot-System.Configuration.ConfigurationManager
		i64 u0x5d3a5af149aed459, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.96_name, ; name: libaot-System.Configuration.ConfigurationManager.dll.so
		ptr null; void* handle
	}, ; 601
	%struct.DSOCacheEntry {
		i64 u0x513734b3305837fd, ; from name: aot-Xamarin.AndroidX.Lifecycle.ViewModelSavedState.dll.so
		i64 u0x9b809dc726e0140e, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.117_name, ; name: libaot-Xamarin.AndroidX.Lifecycle.ViewModelSavedState.dll.so
		ptr null; void* handle
	}, ; 602
	%struct.DSOCacheEntry {
		i64 u0x5174584183ce61d9, ; from name: aot-System.Collections.Immutable
		i64 u0x49e9602a3882bd40, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.136_name, ; name: libaot-System.Collections.Immutable.dll.so
		ptr null; void* handle
	}, ; 603
	%struct.DSOCacheEntry {
		i64 u0x5175c7f043f8e788, ; from name: Xamarin.AndroidX.Loader.so
		i64 u0x74b0aefe8f467d50, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.118_name, ; name: libaot-Xamarin.AndroidX.Loader.dll.so
		ptr null; void* handle
	}, ; 604
	%struct.DSOCacheEntry {
		i64 u0x5187840510074842, ; from name: Microsoft.Extensions.Caching.Abstractions.dll.so
		i64 u0x988026893039cd51, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.50_name, ; name: libaot-Microsoft.Extensions.Caching.Abstractions.dll.so
		ptr null; void* handle
	}, ; 605
	%struct.DSOCacheEntry {
		i64 u0x51aad7b1eaf4d2ae, ; from name: libaot-System.Threading.Tasks.Extensions.dll.so
		i64 u0x51aad7b1eaf4d2ae, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.211_name, ; name: libaot-System.Threading.Tasks.Extensions.dll.so
		ptr null; void* handle
	}, ; 606
	%struct.DSOCacheEntry {
		i64 u0x51bb8a2afe774e32, ; from name: System.Drawing
		i64 u0x366c3ed8a6266ffb, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.152_name, ; name: libaot-System.Drawing.dll.so
		ptr null; void* handle
	}, ; 607
	%struct.DSOCacheEntry {
		i64 u0x51c50b4f4c87593e, ; from name: System.dll.so
		i64 u0x7b91ac8ddc528deb, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.221_name, ; name: libaot-System.dll.so
		ptr null; void* handle
	}, ; 608
	%struct.DSOCacheEntry {
		i64 u0x5216f09c5c4c95c8, ; from name: Microsoft.AspNetCore.Authentication.Abstractions
		i64 u0x59903efae9d3d723, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.20_name, ; name: libaot-Microsoft.AspNetCore.Authentication.Abstractions.dll.so
		ptr null; void* handle
	}, ; 609
	%struct.DSOCacheEntry {
		i64 u0x52429a82a66c40af, ; from name: aot-System.Collections.Specialized.dll.so
		i64 u0x355b66670e6bf2e4, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.138_name, ; name: libaot-System.Collections.Specialized.dll.so
		ptr null; void* handle
	}, ; 610
	%struct.DSOCacheEntry {
		i64 u0x527497f521875686, ; from name: Microsoft.AspNetCore.Http.Abstractions
		i64 u0x96d2838521668c05, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.28_name, ; name: libaot-Microsoft.AspNetCore.Http.Abstractions.dll.so
		ptr null; void* handle
	}, ; 611
	%struct.DSOCacheEntry {
		i64 u0x5298030147080bcb, ; from name: Xamarin.AndroidX.Activity.so
		i64 u0x8a05820e9e77c0c3, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.102_name, ; name: libaot-Xamarin.AndroidX.Activity.dll.so
		ptr null; void* handle
	}, ; 612
	%struct.DSOCacheEntry {
		i64 u0x529ffe06f39ab8db, ; from name: Xamarin.AndroidX.Core
		i64 u0x28a319e875b39488, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.109_name, ; name: libaot-Xamarin.AndroidX.Core.dll.so
		ptr null; void* handle
	}, ; 613
	%struct.DSOCacheEntry {
		i64 u0x52a88ccc08a07df4, ; from name: Syncfusion.Licensing.so
		i64 u0xe0ba2b05be11dec6, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.89_name, ; name: libaot-Syncfusion.Licensing.dll.so
		ptr null; void* handle
	}, ; 614
	%struct.DSOCacheEntry {
		i64 u0x52bbd048717682d4, ; from name: libaot-System.Private.Xml.dll.so
		i64 u0x52bbd048717682d4, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.181_name, ; name: libaot-System.Private.Xml.dll.so
		ptr null; void* handle
	}, ; 615
	%struct.DSOCacheEntry {
		i64 u0x52fead1d33d2d460, ; from name: libaot-Xamarin.AndroidX.SavedState.so
		i64 u0x039588659cdd2f6a, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.124_name, ; name: libaot-Xamarin.AndroidX.SavedState.dll.so
		ptr null; void* handle
	}, ; 616
	%struct.DSOCacheEntry {
		i64 u0x52ff996554dbf352, ; from name: Microsoft.Maui.Graphics
		i64 u0x285d22da351d937a, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.79_name, ; name: libaot-Microsoft.Maui.Graphics.dll.so
		ptr null; void* handle
	}, ; 617
	%struct.DSOCacheEntry {
		i64 u0x5323848e21ac2613, ; from name: libaot-System.Runtime.Serialization.Json
		i64 u0xe012402cc380eac2, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.191_name, ; name: libaot-System.Runtime.Serialization.Json.dll.so
		ptr null; void* handle
	}, ; 618
	%struct.DSOCacheEntry {
		i64 u0x534ad24029b48b70, ; from name: libaot-Syncfusion.Licensing.so
		i64 u0xe0ba2b05be11dec6, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.89_name, ; name: libaot-Syncfusion.Licensing.dll.so
		ptr null; void* handle
	}, ; 619
	%struct.DSOCacheEntry {
		i64 u0x53a8edd5eb823442, ; from name: libaot-Microsoft.AspNetCore.SignalR.Protocols.Json.dll.so
		i64 u0x53a8edd5eb823442, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.42_name, ; name: libaot-Microsoft.AspNetCore.SignalR.Protocols.Json.dll.so
		ptr null; void* handle
	}, ; 620
	%struct.DSOCacheEntry {
		i64 u0x53a96d5c86c9e194, ; from name: System.Net.NetworkInformation
		i64 u0xb1bf28cdcefab46b, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.167_name, ; name: libaot-System.Net.NetworkInformation.dll.so
		ptr null; void* handle
	}, ; 621
	%struct.DSOCacheEntry {
		i64 u0x53ad1974881b0f08, ; from name: System.Security.Cryptography.Encoding.dll.so
		i64 u0x31145bf76e7d3b7a, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.200_name, ; name: libaot-System.Security.Cryptography.Encoding.dll.so
		ptr null; void* handle
	}, ; 622
	%struct.DSOCacheEntry {
		i64 u0x53bc65e4dbc342d6, ; from name: aot-Microsoft.AspNetCore.Http.Extensions.so
		i64 u0xf01d9d74cda0b70d, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.31_name, ; name: libaot-Microsoft.AspNetCore.Http.Extensions.dll.so
		ptr null; void* handle
	}, ; 623
	%struct.DSOCacheEntry {
		i64 u0x53bf631dee4be432, ; from name: aot-Microsoft.Extensions.Diagnostics
		i64 u0xd34809bcacf156ee, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.57_name, ; name: libaot-Microsoft.Extensions.Diagnostics.dll.so
		ptr null; void* handle
	}, ; 624
	%struct.DSOCacheEntry {
		i64 u0x53ca3e879dd44de4, ; from name: Microsoft.IdentityModel.Abstractions.so
		i64 u0x41c972d328f102fd, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.69_name, ; name: libaot-Microsoft.IdentityModel.Abstractions.dll.so
		ptr null; void* handle
	}, ; 625
	%struct.DSOCacheEntry {
		i64 u0x53f25aca65457dff, ; from name: aot-Xamarin.Google.Android.Material.so
		i64 u0x937abea3fe5296af, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.128_name, ; name: libaot-Xamarin.Google.Android.Material.dll.so
		ptr null; void* handle
	}, ; 626
	%struct.DSOCacheEntry {
		i64 u0x5424938e04124349, ; from name: aot-System.Private.CoreLib
		i64 u0xe1af59ffe15719e2, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.227_name, ; name: libaot-System.Private.CoreLib.dll.so
		ptr null; void* handle
	}, ; 627
	%struct.DSOCacheEntry {
		i64 u0x5425eb433f599bc7, ; from name: libaot-System.Transactions.Local.dll.so
		i64 u0x5425eb433f599bc7, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.215_name, ; name: libaot-System.Transactions.Local.dll.so
		ptr null; void* handle
	}, ; 628
	%struct.DSOCacheEntry {
		i64 u0x54379c3984bea3cb, ; from name: libaot-System.Net.Requests.so
		i64 u0x2a8da1e7722aaaff, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.169_name, ; name: libaot-System.Net.Requests.dll.so
		ptr null; void* handle
	}, ; 629
	%struct.DSOCacheEntry {
		i64 u0x544f028b79f27e7e, ; from name: aot-System.Security.Cryptography.Encoding.so
		i64 u0x31145bf76e7d3b7a, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.200_name, ; name: libaot-System.Security.Cryptography.Encoding.dll.so
		ptr null; void* handle
	}, ; 630
	%struct.DSOCacheEntry {
		i64 u0x54909eee5de1ce97, ; from name: libaot-Microsoft.Extensions.FileProviders.Abstractions.so
		i64 u0x82b65efc7b0bc50f, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.60_name, ; name: libaot-Microsoft.Extensions.FileProviders.Abstractions.dll.so
		ptr null; void* handle
	}, ; 631
	%struct.DSOCacheEntry {
		i64 u0x54c01f70f81df8a4, ; from name: System.Security.Cryptography.Cng.dll.so
		i64 u0xe4a5a519ffe8b5e9, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.198_name, ; name: libaot-System.Security.Cryptography.Cng.dll.so
		ptr null; void* handle
	}, ; 632
	%struct.DSOCacheEntry {
		i64 u0x54f7fbd0a81833fe, ; from name: libaot-System.Reflection.Emit.Lightweight.dll.so
		i64 u0x54f7fbd0a81833fe, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.183_name, ; name: libaot-System.Reflection.Emit.Lightweight.dll.so
		ptr null; void* handle
	}, ; 633
	%struct.DSOCacheEntry {
		i64 u0x550720df823a4a57, ; from name: Microsoft.EntityFrameworkCore.Relational.so
		i64 u0xc114e8a396f5423b, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.48_name, ; name: libaot-Microsoft.EntityFrameworkCore.Relational.dll.so
		ptr null; void* handle
	}, ; 634
	%struct.DSOCacheEntry {
		i64 u0x5525381bef4d9b6a, ; from name: aot-System.ComponentModel
		i64 u0x38a82198a4cd2a73, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.143_name, ; name: libaot-System.ComponentModel.dll.so
		ptr null; void* handle
	}, ; 635
	%struct.DSOCacheEntry {
		i64 u0x553b3f85d61de6a2, ; from name: aot-Xamarin.AndroidX.Activity
		i64 u0x8a05820e9e77c0c3, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.102_name, ; name: libaot-Xamarin.AndroidX.Activity.dll.so
		ptr null; void* handle
	}, ; 636
	%struct.DSOCacheEntry {
		i64 u0x553fd3f1268396f3, ; from name: libaot-Xamarin.AndroidX.RecyclerView
		i64 u0x34c6f5c746796bcc, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.123_name, ; name: libaot-Xamarin.AndroidX.RecyclerView.dll.so
		ptr null; void* handle
	}, ; 637
	%struct.DSOCacheEntry {
		i64 u0x5588627c9a108ec9, ; from name: System.Collections.Specialized
		i64 u0x355b66670e6bf2e4, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.138_name, ; name: libaot-System.Collections.Specialized.dll.so
		ptr null; void* handle
	}, ; 638
	%struct.DSOCacheEntry {
		i64 u0x5594b077481089e1, ; from name: aot-Xamarin.Kotlin.StdLib.dll.so
		i64 u0x0c644d6a2b020c43, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.129_name, ; name: libaot-Xamarin.Kotlin.StdLib.dll.so
		ptr null; void* handle
	}, ; 639
	%struct.DSOCacheEntry {
		i64 u0x55c25b4d27ae6f23, ; from name: libaot-System.Runtime.Loader.dll.so
		i64 u0x55c25b4d27ae6f23, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.188_name, ; name: libaot-System.Runtime.Loader.dll.so
		ptr null; void* handle
	}, ; 640
	%struct.DSOCacheEntry {
		i64 u0x55c7a9171dbf7ac6, ; from name: aot-Microsoft.Win32.Primitives.dll.so
		i64 u0x6f3638b02afc00cc, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.133_name, ; name: libaot-Microsoft.Win32.Primitives.dll.so
		ptr null; void* handle
	}, ; 641
	%struct.DSOCacheEntry {
		i64 u0x55fcf2ccc005141e, ; from name: aot-Microsoft.Extensions.DependencyInjection.Abstractions.dll.so
		i64 u0x4643d8f925d8e6b7, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.55_name, ; name: libaot-Microsoft.Extensions.DependencyInjection.Abstractions.dll.so
		ptr null; void* handle
	}, ; 642
	%struct.DSOCacheEntry {
		i64 u0x562760c15bec01ba, ; from name: System.Linq.Expressions.so
		i64 u0xda1d7acd827eb320, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.160_name, ; name: libaot-System.Linq.Expressions.dll.so
		ptr null; void* handle
	}, ; 643
	%struct.DSOCacheEntry {
		i64 u0x5633aba1fd262138, ; from name: System.ObjectModel.so
		i64 u0x914167d87d2ee1b1, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.177_name, ; name: libaot-System.ObjectModel.dll.so
		ptr null; void* handle
	}, ; 644
	%struct.DSOCacheEntry {
		i64 u0x56473d02d6886ce1, ; from name: System.Net.WebSockets.Client.dll.so
		i64 u0x0a18b49bebc33444, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.174_name, ; name: libaot-System.Net.WebSockets.Client.dll.so
		ptr null; void* handle
	}, ; 645
	%struct.DSOCacheEntry {
		i64 u0x564d5b8794d1d844, ; from name: System.Diagnostics.Process.so
		i64 u0x8657799bb82e0573, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.147_name, ; name: libaot-System.Diagnostics.Process.dll.so
		ptr null; void* handle
	}, ; 646
	%struct.DSOCacheEntry {
		i64 u0x564eb03d5e1253d4, ; from name: System.Net.Http.dll.so
		i64 u0xd925f85604802447, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.165_name, ; name: libaot-System.Net.Http.dll.so
		ptr null; void* handle
	}, ; 647
	%struct.DSOCacheEntry {
		i64 u0x56586153175e9a7b, ; from name: aot-Microsoft.Extensions.Logging.dll.so
		i64 u0x9b6f0babce2a1934, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.62_name, ; name: libaot-Microsoft.Extensions.Logging.dll.so
		ptr null; void* handle
	}, ; 648
	%struct.DSOCacheEntry {
		i64 u0x5691a1561f683d38, ; from name: aot-Microsoft.AspNetCore.Http.Connections.Common.dll.so
		i64 u0x726b54f946bf0d7f, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.30_name, ; name: libaot-Microsoft.AspNetCore.Http.Connections.Common.dll.so
		ptr null; void* handle
	}, ; 649
	%struct.DSOCacheEntry {
		i64 u0x5696a0b7c861221d, ; from name: libaot-Azure.Core
		i64 u0x821f528a92d55dea, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.12_name, ; name: libaot-Azure.Core.dll.so
		ptr null; void* handle
	}, ; 650
	%struct.DSOCacheEntry {
		i64 u0x56dfb6d308b9e745, ; from name: aot-System.Collections.Concurrent
		i64 u0x65cd21401fecc3dc, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.135_name, ; name: libaot-System.Collections.Concurrent.dll.so
		ptr null; void* handle
	}, ; 651
	%struct.DSOCacheEntry {
		i64 u0x56e8575851fa23df, ; from name: System.Diagnostics.DiagnosticSource.dll.so
		i64 u0x77156c94b5eff927, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.146_name, ; name: libaot-System.Diagnostics.DiagnosticSource.dll.so
		ptr null; void* handle
	}, ; 652
	%struct.DSOCacheEntry {
		i64 u0x570d69cf6a2de65b, ; from name: libaot-System.Net.WebSockets.Client
		i64 u0x0a18b49bebc33444, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.174_name, ; name: libaot-System.Net.WebSockets.Client.dll.so
		ptr null; void* handle
	}, ; 653
	%struct.DSOCacheEntry {
		i64 u0x5715f89db0aca1ea, ; from name: libaot-System.Runtime.InteropServices.so
		i64 u0x5ae6db1ddadc230b, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.187_name, ; name: libaot-System.Runtime.InteropServices.dll.so
		ptr null; void* handle
	}, ; 654
	%struct.DSOCacheEntry {
		i64 u0x571c5cfbec5ae8e2, ; from name: System.Private.Uri
		i64 u0xe57af9ab00f5c61d, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.179_name, ; name: libaot-System.Private.Uri.dll.so
		ptr null; void* handle
	}, ; 655
	%struct.DSOCacheEntry {
		i64 u0x573f908812386eb5, ; from name: aot-System.Diagnostics.TraceSource.dll.so
		i64 u0x2119cc81025daa05, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.149_name, ; name: libaot-System.Diagnostics.TraceSource.dll.so
		ptr null; void* handle
	}, ; 656
	%struct.DSOCacheEntry {
		i64 u0x5777ddba4d29c37e, ; from name: Xamarin.AndroidX.Fragment.dll.so
		i64 u0x8ab6d3431da5497e, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.113_name, ; name: libaot-Xamarin.AndroidX.Fragment.dll.so
		ptr null; void* handle
	}, ; 657
	%struct.DSOCacheEntry {
		i64 u0x579329846309faf9, ; from name: aot-Microsoft.Win32.Primitives
		i64 u0x6f3638b02afc00cc, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.133_name, ; name: libaot-Microsoft.Win32.Primitives.dll.so
		ptr null; void* handle
	}, ; 658
	%struct.DSOCacheEntry {
		i64 u0x579f7955a9783e96, ; from name: System.Linq.so
		i64 u0x2fb7a3952b307fae, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.162_name, ; name: libaot-System.Linq.dll.so
		ptr null; void* handle
	}, ; 659
	%struct.DSOCacheEntry {
		i64 u0x57c542c14049b66d, ; from name: System.Diagnostics.DiagnosticSource
		i64 u0x77156c94b5eff927, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.146_name, ; name: libaot-System.Diagnostics.DiagnosticSource.dll.so
		ptr null; void* handle
	}, ; 660
	%struct.DSOCacheEntry {
		i64 u0x57fcf7f6e8a50c14, ; from name: aot-Xamarin.AndroidX.Lifecycle.ViewModel.Android.so
		i64 u0xc06034423c0d320f, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.116_name, ; name: libaot-Xamarin.AndroidX.Lifecycle.ViewModel.Android.dll.so
		ptr null; void* handle
	}, ; 661
	%struct.DSOCacheEntry {
		i64 u0x587f59a16b329d9c, ; from name: Microsoft.Net.Http.Headers
		i64 u0xa81dfd6455f2dc19, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.80_name, ; name: libaot-Microsoft.Net.Http.Headers.dll.so
		ptr null; void* handle
	}, ; 662
	%struct.DSOCacheEntry {
		i64 u0x58bac2be1e1ca1a1, ; from name: Microsoft.IdentityModel.Abstractions.dll.so
		i64 u0x41c972d328f102fd, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.69_name, ; name: libaot-Microsoft.IdentityModel.Abstractions.dll.so
		ptr null; void* handle
	}, ; 663
	%struct.DSOCacheEntry {
		i64 u0x58bd3364febefd30, ; from name: SQLitePCLRaw.lib.e_sqlite3.android.dll.so
		i64 u0x6a03b775044080b2, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.87_name, ; name: libaot-SQLitePCLRaw.lib.e_sqlite3.android.dll.so
		ptr null; void* handle
	}, ; 664
	%struct.DSOCacheEntry {
		i64 u0x58cd310024b735d8, ; from name: libaot-Microsoft.Maui.dll.so
		i64 u0x58cd310024b735d8, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.77_name, ; name: libaot-Microsoft.Maui.dll.so
		ptr null; void* handle
	}, ; 665
	%struct.DSOCacheEntry {
		i64 u0x5932dbf572fab50a, ; from name: libaot-System.Linq.Queryable.dll.so
		i64 u0x5932dbf572fab50a, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.161_name, ; name: libaot-System.Linq.Queryable.dll.so
		ptr null; void* handle
	}, ; 666
	%struct.DSOCacheEntry {
		i64 u0x593c85b23968a244, ; from name: Microsoft.AspNetCore.Mvc.Core.so
		i64 u0xffcb4d21a593e637, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.34_name, ; name: libaot-Microsoft.AspNetCore.Mvc.Core.dll.so
		ptr null; void* handle
	}, ; 667
	%struct.DSOCacheEntry {
		i64 u0x593f142f8f2d8f9f, ; from name: aot-Microsoft.AspNetCore.Routing
		i64 u0x6872149aac83968a, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.36_name, ; name: libaot-Microsoft.AspNetCore.Routing.dll.so
		ptr null; void* handle
	}, ; 668
	%struct.DSOCacheEntry {
		i64 u0x5988bd4997e5d75f, ; from name: libaot-System.Buffers.dll.so
		i64 u0x5988bd4997e5d75f, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.134_name, ; name: libaot-System.Buffers.dll.so
		ptr null; void* handle
	}, ; 669
	%struct.DSOCacheEntry {
		i64 u0x59903efae9d3d723, ; from name: libaot-Microsoft.AspNetCore.Authentication.Abstractions.dll.so
		i64 u0x59903efae9d3d723, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.20_name, ; name: libaot-Microsoft.AspNetCore.Authentication.Abstractions.dll.so
		ptr null; void* handle
	}, ; 670
	%struct.DSOCacheEntry {
		i64 u0x59aee0bc92ee07e3, ; from name: libaot-System.Threading.Channels.dll.so
		i64 u0x59aee0bc92ee07e3, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.210_name, ; name: libaot-System.Threading.Channels.dll.so
		ptr null; void* handle
	}, ; 671
	%struct.DSOCacheEntry {
		i64 u0x59c270386bf40142, ; from name: Microsoft.AspNetCore.Hosting.Server.Abstractions
		i64 u0xdb28c2f2e5cda275, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.26_name, ; name: libaot-Microsoft.AspNetCore.Hosting.Server.Abstractions.dll.so
		ptr null; void* handle
	}, ; 672
	%struct.DSOCacheEntry {
		i64 u0x59d3d933aa8e5ff4, ; from name: libaot-System.ClientModel.so
		i64 u0xa4d336a75ab12937, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.95_name, ; name: libaot-System.ClientModel.dll.so
		ptr null; void* handle
	}, ; 673
	%struct.DSOCacheEntry {
		i64 u0x59f3986b3f0a35b1, ; from name: aot-Microsoft.Extensions.Features
		i64 u0xaebd3af6eeceb1eb, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.59_name, ; name: libaot-Microsoft.Extensions.Features.dll.so
		ptr null; void* handle
	}, ; 674
	%struct.DSOCacheEntry {
		i64 u0x5a196e3fd4834caf, ; from name: aot-Xamarin.AndroidX.Core
		i64 u0x28a319e875b39488, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.109_name, ; name: libaot-Xamarin.AndroidX.Core.dll.so
		ptr null; void* handle
	}, ; 675
	%struct.DSOCacheEntry {
		i64 u0x5a5c6ab02ef80786, ; from name: libaot-Microsoft.AspNetCore.Http.Connections.Client
		i64 u0x14283e2d731a896b, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.29_name, ; name: libaot-Microsoft.AspNetCore.Http.Connections.Client.dll.so
		ptr null; void* handle
	}, ; 676
	%struct.DSOCacheEntry {
		i64 u0x5a727bd04f5a269d, ; from name: libaot-Xamarin.AndroidX.Navigation.Common
		i64 u0x2ba3b197006b7954, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.119_name, ; name: libaot-Xamarin.AndroidX.Navigation.Common.dll.so
		ptr null; void* handle
	}, ; 677
	%struct.DSOCacheEntry {
		i64 u0x5aa0734711e008f6, ; from name: Microsoft.Extensions.Caching.Memory.dll.so
		i64 u0x331a7f0d6c2c08c9, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.51_name, ; name: libaot-Microsoft.Extensions.Caching.Memory.dll.so
		ptr null; void* handle
	}, ; 678
	%struct.DSOCacheEntry {
		i64 u0x5ac35edbbb84cc9f, ; from name: aot-Microsoft.Bcl.AsyncInterfaces.so
		i64 u0x9b7e93363193afd3, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.44_name, ; name: libaot-Microsoft.Bcl.AsyncInterfaces.dll.so
		ptr null; void* handle
	}, ; 679
	%struct.DSOCacheEntry {
		i64 u0x5ac455e0e08f158f, ; from name: aot-Refit
		i64 u0x00a2ced568899a5e, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.83_name, ; name: libaot-Refit.dll.so
		ptr null; void* handle
	}, ; 680
	%struct.DSOCacheEntry {
		i64 u0x5ae0816b6a39abe9, ; from name: aot-Microsoft.AspNetCore.Connections.Abstractions.so
		i64 u0xb92f532b40f35614, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.24_name, ; name: libaot-Microsoft.AspNetCore.Connections.Abstractions.dll.so
		ptr null; void* handle
	}, ; 681
	%struct.DSOCacheEntry {
		i64 u0x5ae596ea3df74ab6, ; from name: System.Runtime.Serialization.Formatters.dll.so
		i64 u0xc52860d1d6baa3ef, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.190_name, ; name: libaot-System.Runtime.Serialization.Formatters.dll.so
		ptr null; void* handle
	}, ; 682
	%struct.DSOCacheEntry {
		i64 u0x5ae6db1ddadc230b, ; from name: libaot-System.Runtime.InteropServices.dll.so
		i64 u0x5ae6db1ddadc230b, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.187_name, ; name: libaot-System.Runtime.InteropServices.dll.so
		ptr null; void* handle
	}, ; 683
	%struct.DSOCacheEntry {
		i64 u0x5ae9cd33b15841bf, ; from name: System.ComponentModel
		i64 u0x38a82198a4cd2a73, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.143_name, ; name: libaot-System.ComponentModel.dll.so
		ptr null; void* handle
	}, ; 684
	%struct.DSOCacheEntry {
		i64 u0x5af23c65728efd35, ; from name: System.ComponentModel.so
		i64 u0x38a82198a4cd2a73, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.143_name, ; name: libaot-System.ComponentModel.dll.so
		ptr null; void* handle
	}, ; 685
	%struct.DSOCacheEntry {
		i64 u0x5af7325b6c9fc231, ; from name: System.Runtime.Serialization.Xml.dll.so
		i64 u0xeb52548b17e702c6, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.193_name, ; name: libaot-System.Runtime.Serialization.Xml.dll.so
		ptr null; void* handle
	}, ; 686
	%struct.DSOCacheEntry {
		i64 u0x5afd29f4635f42a8, ; from name: libaot-System.Threading.Tasks.Extensions.so
		i64 u0x51aad7b1eaf4d2ae, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.211_name, ; name: libaot-System.Threading.Tasks.Extensions.dll.so
		ptr null; void* handle
	}, ; 687
	%struct.DSOCacheEntry {
		i64 u0x5b4292e687b69639, ; from name: aot-Xamarin.AndroidX.AppCompat.dll.so
		i64 u0x42c7eb0880ff24a4, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.103_name, ; name: libaot-Xamarin.AndroidX.AppCompat.dll.so
		ptr null; void* handle
	}, ; 688
	%struct.DSOCacheEntry {
		i64 u0x5b54391bdc6fcfe6, ; from name: System.Private.DataContractSerialization
		i64 u0x8fa52587768c02e7, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.178_name, ; name: libaot-System.Private.DataContractSerialization.dll.so
		ptr null; void* handle
	}, ; 689
	%struct.DSOCacheEntry {
		i64 u0x5b72f894faa7cbdd, ; from name: System.Net.WebClient.so
		i64 u0x4ce9b13ddea58a1b, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.172_name, ; name: libaot-System.Net.WebClient.dll.so
		ptr null; void* handle
	}, ; 690
	%struct.DSOCacheEntry {
		i64 u0x5b7d43cc7dd5f215, ; from name: Microsoft.Maui.Graphics.dll.so
		i64 u0x285d22da351d937a, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.79_name, ; name: libaot-Microsoft.Maui.Graphics.dll.so
		ptr null; void* handle
	}, ; 691
	%struct.DSOCacheEntry {
		i64 u0x5bacada79b845b29, ; from name: aot-System.ComponentModel.TypeConverter.dll.so
		i64 u0xcb7e41356728fd07, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.142_name, ; name: libaot-System.ComponentModel.TypeConverter.dll.so
		ptr null; void* handle
	}, ; 692
	%struct.DSOCacheEntry {
		i64 u0x5bf0c23bdb13c0d6, ; from name: libaot-System.Security.Cryptography.so
		i64 u0xd0e82017367ac826, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.203_name, ; name: libaot-System.Security.Cryptography.dll.so
		ptr null; void* handle
	}, ; 693
	%struct.DSOCacheEntry {
		i64 u0x5c09c211c5359c6b, ; from name: aot-System.Net.Sockets.dll.so
		i64 u0x4c5401149da6445e, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.171_name, ; name: libaot-System.Net.Sockets.dll.so
		ptr null; void* handle
	}, ; 694
	%struct.DSOCacheEntry {
		i64 u0x5c0e55995a579ade, ; from name: Microsoft.Extensions.Http.so
		i64 u0x24aa3d6e3cd1bcb7, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.61_name, ; name: libaot-Microsoft.Extensions.Http.dll.so
		ptr null; void* handle
	}, ; 695
	%struct.DSOCacheEntry {
		i64 u0x5c1698e757ccb953, ; from name: libaot-Microsoft.AspNetCore.Authentication.Abstractions
		i64 u0x59903efae9d3d723, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.20_name, ; name: libaot-Microsoft.AspNetCore.Authentication.Abstractions.dll.so
		ptr null; void* handle
	}, ; 696
	%struct.DSOCacheEntry {
		i64 u0x5c2774eef3bb77cb, ; from name: Microsoft.Maui.Essentials.dll.so
		i64 u0xdc3ba4771239be2d, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.78_name, ; name: libaot-Microsoft.Maui.Essentials.dll.so
		ptr null; void* handle
	}, ; 697
	%struct.DSOCacheEntry {
		i64 u0x5c326f66e33d6ed9, ; from name: Microsoft.AspNetCore.ResponseCaching.Abstractions.dll.so
		i64 u0x2eb68ca0cc467150, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.35_name, ; name: libaot-Microsoft.AspNetCore.ResponseCaching.Abstractions.dll.so
		ptr null; void* handle
	}, ; 698
	%struct.DSOCacheEntry {
		i64 u0x5c3422b677b99f64, ; from name: libaot-System.Memory.Data.so
		i64 u0xe03e3baaab589d1e, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.98_name, ; name: libaot-System.Memory.Data.dll.so
		ptr null; void* handle
	}, ; 699
	%struct.DSOCacheEntry {
		i64 u0x5c79a104cea274d1, ; from name: libaot-Xamarin.AndroidX.CursorAdapter.so
		i64 u0xdf3c491694996c7e, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.110_name, ; name: libaot-Xamarin.AndroidX.CursorAdapter.dll.so
		ptr null; void* handle
	}, ; 700
	%struct.DSOCacheEntry {
		i64 u0x5c7f546cc029c78e, ; from name: aot-Microsoft.AspNetCore.Authorization.dll.so
		i64 u0x93d2678ac2e76ce0, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.22_name, ; name: libaot-Microsoft.AspNetCore.Authorization.dll.so
		ptr null; void* handle
	}, ; 701
	%struct.DSOCacheEntry {
		i64 u0x5cbe0283eb598ee8, ; from name: Microsoft.AspNetCore.Routing
		i64 u0x6872149aac83968a, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.36_name, ; name: libaot-Microsoft.AspNetCore.Routing.dll.so
		ptr null; void* handle
	}, ; 702
	%struct.DSOCacheEntry {
		i64 u0x5cc157f14ad19fc0, ; from name: libaot-Xamarin.AndroidX.CoordinatorLayout.dll.so
		i64 u0x5cc157f14ad19fc0, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.108_name, ; name: libaot-Xamarin.AndroidX.CoordinatorLayout.dll.so
		ptr null; void* handle
	}, ; 703
	%struct.DSOCacheEntry {
		i64 u0x5ce43a590492daee, ; from name: aot-Xamarin.AndroidX.ViewPager2
		i64 u0x4595d9c27242b287, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.127_name, ; name: libaot-Xamarin.AndroidX.ViewPager2.dll.so
		ptr null; void* handle
	}, ; 704
	%struct.DSOCacheEntry {
		i64 u0x5cf2c11c2ae1eb7d, ; from name: System.Net.Sockets.so
		i64 u0x4c5401149da6445e, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.171_name, ; name: libaot-System.Net.Sockets.dll.so
		ptr null; void* handle
	}, ; 705
	%struct.DSOCacheEntry {
		i64 u0x5d095952aa5dc62d, ; from name: Xamarin.AndroidX.Navigation.Common.so
		i64 u0x2ba3b197006b7954, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.119_name, ; name: libaot-Xamarin.AndroidX.Navigation.Common.dll.so
		ptr null; void* handle
	}, ; 706
	%struct.DSOCacheEntry {
		i64 u0x5d131ff27d79bbb1, ; from name: aot-Microsoft.Extensions.Configuration.Abstractions.dll.so
		i64 u0xd6a1ce9f7ccd35cb, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.53_name, ; name: libaot-Microsoft.Extensions.Configuration.Abstractions.dll.so
		ptr null; void* handle
	}, ; 707
	%struct.DSOCacheEntry {
		i64 u0x5d39a4383290b1a5, ; from name: libaot-System.Transactions.Local
		i64 u0x5425eb433f599bc7, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.215_name, ; name: libaot-System.Transactions.Local.dll.so
		ptr null; void* handle
	}, ; 708
	%struct.DSOCacheEntry {
		i64 u0x5d3a5af149aed459, ; from name: libaot-System.Configuration.ConfigurationManager.dll.so
		i64 u0x5d3a5af149aed459, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.96_name, ; name: libaot-System.Configuration.ConfigurationManager.dll.so
		ptr null; void* handle
	}, ; 709
	%struct.DSOCacheEntry {
		i64 u0x5d9c2521942e02ea, ; from name: Microsoft.Extensions.Configuration.so
		i64 u0x07a45374fab68acc, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.52_name, ; name: libaot-Microsoft.Extensions.Configuration.dll.so
		ptr null; void* handle
	}, ; 710
	%struct.DSOCacheEntry {
		i64 u0x5da2908f19f785b8, ; from name: aot-Xamarin.AndroidX.CardView
		i64 u0xe9e6021e6533eb43, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.106_name, ; name: libaot-Xamarin.AndroidX.CardView.dll.so
		ptr null; void* handle
	}, ; 711
	%struct.DSOCacheEntry {
		i64 u0x5db5c5ff214153ed, ; from name: aot-System.Xml.Linq
		i64 u0xe89b56c5a60687e6, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.217_name, ; name: libaot-System.Xml.Linq.dll.so
		ptr null; void* handle
	}, ; 712
	%struct.DSOCacheEntry {
		i64 u0x5df94e9ba0421dd7, ; from name: libaot-System.Buffers
		i64 u0x5988bd4997e5d75f, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.134_name, ; name: libaot-System.Buffers.dll.so
		ptr null; void* handle
	}, ; 713
	%struct.DSOCacheEntry {
		i64 u0x5e2a92814ab74539, ; from name: aot-System.Security.AccessControl
		i64 u0x69dd3c9ffb9c24cd, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.195_name, ; name: libaot-System.Security.AccessControl.dll.so
		ptr null; void* handle
	}, ; 714
	%struct.DSOCacheEntry {
		i64 u0x5e7a8d60968d5c81, ; from name: libaot-Microsoft.IdentityModel.Logging.so
		i64 u0x1175872aaf2edbfe, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.71_name, ; name: libaot-Microsoft.IdentityModel.Logging.dll.so
		ptr null; void* handle
	}, ; 715
	%struct.DSOCacheEntry {
		i64 u0x5eb8046dd40e9ac3, ; from name: System.ComponentModel.Primitives
		i64 u0xccde8a4563eee10b, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.141_name, ; name: libaot-System.ComponentModel.Primitives.dll.so
		ptr null; void* handle
	}, ; 716
	%struct.DSOCacheEntry {
		i64 u0x5ed43e0e6c25eb42, ; from name: aot-System.Security.Principal.Windows
		i64 u0x29629cd3c238a2b4, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.204_name, ; name: libaot-System.Security.Principal.Windows.dll.so
		ptr null; void* handle
	}, ; 717
	%struct.DSOCacheEntry {
		i64 u0x5ede305ba0155984, ; from name: libaot-Syncfusion.Licensing
		i64 u0xe0ba2b05be11dec6, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.89_name, ; name: libaot-Syncfusion.Licensing.dll.so
		ptr null; void* handle
	}, ; 718
	%struct.DSOCacheEntry {
		i64 u0x5f39f9d4cad82935, ; from name: aot-System.Runtime.Serialization.Formatters.dll.so
		i64 u0xc52860d1d6baa3ef, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.190_name, ; name: libaot-System.Runtime.Serialization.Formatters.dll.so
		ptr null; void* handle
	}, ; 719
	%struct.DSOCacheEntry {
		i64 u0x5f4294b9b63cb842, ; from name: System.Data.Common
		i64 u0x426a5e4ee84b386c, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.145_name, ; name: libaot-System.Data.Common.dll.so
		ptr null; void* handle
	}, ; 720
	%struct.DSOCacheEntry {
		i64 u0x5f435aa7f5fde870, ; from name: libaot-System.Threading.dll.so
		i64 u0x5f435aa7f5fde870, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.214_name, ; name: libaot-System.Threading.dll.so
		ptr null; void* handle
	}, ; 721
	%struct.DSOCacheEntry {
		i64 u0x5f43f49a54df7354, ; from name: System.Threading.Tasks.Extensions.dll.so
		i64 u0x51aad7b1eaf4d2ae, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.211_name, ; name: libaot-System.Threading.Tasks.Extensions.dll.so
		ptr null; void* handle
	}, ; 722
	%struct.DSOCacheEntry {
		i64 u0x5f548bf177391893, ; from name: libaot-System.Configuration.ConfigurationManager.so
		i64 u0x5d3a5af149aed459, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.96_name, ; name: libaot-System.Configuration.ConfigurationManager.dll.so
		ptr null; void* handle
	}, ; 723
	%struct.DSOCacheEntry {
		i64 u0x5fab1f3cdba2317a, ; from name: DocumentFormat.OpenXml.Framework.so
		i64 u0xf959815fea0ec361, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.18_name, ; name: libaot-DocumentFormat.OpenXml.Framework.dll.so
		ptr null; void* handle
	}, ; 724
	%struct.DSOCacheEntry {
		i64 u0x5fc3bca990f46fb4, ; from name: libaot-Microsoft.Maui.Controls.Xaml.dll.so
		i64 u0x5fc3bca990f46fb4, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.76_name, ; name: libaot-Microsoft.Maui.Controls.Xaml.dll.so
		ptr null; void* handle
	}, ; 725
	%struct.DSOCacheEntry {
		i64 u0x5fd85e0923539039, ; from name: System.Xml.XDocument.so
		i64 u0x823af1c93e519784, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.219_name, ; name: libaot-System.Xml.XDocument.dll.so
		ptr null; void* handle
	}, ; 726
	%struct.DSOCacheEntry {
		i64 u0x5fec18d88009a455, ; from name: aot-System.Runtime.Loader
		i64 u0x55c25b4d27ae6f23, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.188_name, ; name: libaot-System.Runtime.Loader.dll.so
		ptr null; void* handle
	}, ; 727
	%struct.DSOCacheEntry {
		i64 u0x5ff8a747b135ea37, ; from name: libaot-System.ComponentModel
		i64 u0x38a82198a4cd2a73, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.143_name, ; name: libaot-System.ComponentModel.dll.so
		ptr null; void* handle
	}, ; 728
	%struct.DSOCacheEntry {
		i64 u0x6065d7ef54a29a4b, ; from name: aot-System.Numerics.Vectors.so
		i64 u0x37fbdff3aa18872d, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.176_name, ; name: libaot-System.Numerics.Vectors.dll.so
		ptr null; void* handle
	}, ; 729
	%struct.DSOCacheEntry {
		i64 u0x60718f16e9620460, ; from name: libaot-Microsoft.AspNetCore.Http.Extensions.so
		i64 u0xf01d9d74cda0b70d, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.31_name, ; name: libaot-Microsoft.AspNetCore.Http.Extensions.dll.so
		ptr null; void* handle
	}, ; 730
	%struct.DSOCacheEntry {
		i64 u0x607eec53d90fd31e, ; from name: System.Diagnostics.StackTrace.so
		i64 u0xb21e783430e22a93, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.148_name, ; name: libaot-System.Diagnostics.StackTrace.dll.so
		ptr null; void* handle
	}, ; 731
	%struct.DSOCacheEntry {
		i64 u0x60cd4e33d7e60134, ; from name: Xamarin.KotlinX.Coroutines.Core.Jvm
		i64 u0x811e0efc0e57d069, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.130_name, ; name: libaot-Xamarin.KotlinX.Coroutines.Core.Jvm.dll.so
		ptr null; void* handle
	}, ; 732
	%struct.DSOCacheEntry {
		i64 u0x60f62d786afcf130, ; from name: System.Memory
		i64 u0xad582851e7d05243, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.163_name, ; name: libaot-System.Memory.dll.so
		ptr null; void* handle
	}, ; 733
	%struct.DSOCacheEntry {
		i64 u0x60f63173addc9db7, ; from name: aot-System.Threading.Tasks.Extensions.so
		i64 u0x51aad7b1eaf4d2ae, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.211_name, ; name: libaot-System.Threading.Tasks.Extensions.dll.so
		ptr null; void* handle
	}, ; 734
	%struct.DSOCacheEntry {
		i64 u0x61133b086f6d1b38, ; from name: aot-Microsoft.AspNetCore.SignalR.Common
		i64 u0x1d711f330f5778d7, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.40_name, ; name: libaot-Microsoft.AspNetCore.SignalR.Common.dll.so
		ptr null; void* handle
	}, ; 735
	%struct.DSOCacheEntry {
		i64 u0x612dc7ca0bccd16f, ; from name: aot-Microsoft.AspNetCore.Connections.Abstractions
		i64 u0xb92f532b40f35614, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.24_name, ; name: libaot-Microsoft.AspNetCore.Connections.Abstractions.dll.so
		ptr null; void* handle
	}, ; 736
	%struct.DSOCacheEntry {
		i64 u0x61be8d1299194243, ; from name: Microsoft.Maui.Controls.Xaml
		i64 u0x5fc3bca990f46fb4, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.76_name, ; name: libaot-Microsoft.Maui.Controls.Xaml.dll.so
		ptr null; void* handle
	}, ; 737
	%struct.DSOCacheEntry {
		i64 u0x621a7dc81cc0c7fd, ; from name: libaot-System.Net.ServerSentEvents
		i64 u0x95302b4a91a9ea47, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.99_name, ; name: libaot-System.Net.ServerSentEvents.dll.so
		ptr null; void* handle
	}, ; 738
	%struct.DSOCacheEntry {
		i64 u0x621c21d9c3290da0, ; from name: libaot-Microsoft.AspNetCore.Http.Features.dll.so
		i64 u0x621c21d9c3290da0, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.32_name, ; name: libaot-Microsoft.AspNetCore.Http.Features.dll.so
		ptr null; void* handle
	}, ; 739
	%struct.DSOCacheEntry {
		i64 u0x622eef6f9e59068d, ; from name: System.Private.CoreLib
		i64 u0xe1af59ffe15719e2, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.227_name, ; name: libaot-System.Private.CoreLib.dll.so
		ptr null; void* handle
	}, ; 740
	%struct.DSOCacheEntry {
		i64 u0x6250af18a9734a88, ; from name: aot-System.Console.so
		i64 u0xc2da5dca6ccd8b0a, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.144_name, ; name: libaot-System.Console.dll.so
		ptr null; void* handle
	}, ; 741
	%struct.DSOCacheEntry {
		i64 u0x6260add1b87d7669, ; from name: netstandard.dll.so
		i64 u0xb6ab21527197f7f1, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.223_name, ; name: libaot-netstandard.dll.so
		ptr null; void* handle
	}, ; 742
	%struct.DSOCacheEntry {
		i64 u0x62900d67048c1f56, ; from name: aot-Microsoft.AspNetCore.Hosting.Server.Abstractions
		i64 u0xdb28c2f2e5cda275, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.26_name, ; name: libaot-Microsoft.AspNetCore.Hosting.Server.Abstractions.dll.so
		ptr null; void* handle
	}, ; 743
	%struct.DSOCacheEntry {
		i64 u0x62a90c2105a78f1a, ; from name: libaot-Microsoft.Net.Http.Headers
		i64 u0xa81dfd6455f2dc19, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.80_name, ; name: libaot-Microsoft.Net.Http.Headers.dll.so
		ptr null; void* handle
	}, ; 744
	%struct.DSOCacheEntry {
		i64 u0x62ca92ad8ae1ced2, ; from name: aot-Microsoft.AspNetCore.SignalR.Client.dll.so
		i64 u0xb9619c5bddc1c8f4, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.38_name, ; name: libaot-Microsoft.AspNetCore.SignalR.Client.dll.so
		ptr null; void* handle
	}, ; 745
	%struct.DSOCacheEntry {
		i64 u0x62ef93d6571f3a8a, ; from name: libaot-Microsoft.Maui.so
		i64 u0x58cd310024b735d8, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.77_name, ; name: libaot-Microsoft.Maui.dll.so
		ptr null; void* handle
	}, ; 746
	%struct.DSOCacheEntry {
		i64 u0x62f0a7158b84723e, ; from name: aot-Xamarin.AndroidX.SavedState
		i64 u0x039588659cdd2f6a, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.124_name, ; name: libaot-Xamarin.AndroidX.SavedState.dll.so
		ptr null; void* handle
	}, ; 747
	%struct.DSOCacheEntry {
		i64 u0x63174ba244dd139d, ; from name: libaot-SQLitePCLRaw.lib.e_sqlite3.android
		i64 u0x6a03b775044080b2, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.87_name, ; name: libaot-SQLitePCLRaw.lib.e_sqlite3.android.dll.so
		ptr null; void* handle
	}, ; 748
	%struct.DSOCacheEntry {
		i64 u0x6330028302d4bb44, ; from name: Microsoft.Extensions.Features.so
		i64 u0xaebd3af6eeceb1eb, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.59_name, ; name: libaot-Microsoft.Extensions.Features.dll.so
		ptr null; void* handle
	}, ; 749
	%struct.DSOCacheEntry {
		i64 u0x633a2b164f68bd62, ; from name: aot-System.Reflection.Emit.ILGeneration.so
		i64 u0xbba986a49febf640, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.182_name, ; name: libaot-System.Reflection.Emit.ILGeneration.dll.so
		ptr null; void* handle
	}, ; 750
	%struct.DSOCacheEntry {
		i64 u0x63553ce1241e47a4, ; from name: libaot-Syncfusion.Maui.ImageEditor.so
		i64 u0x70f8ca2f11ec3669, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.91_name, ; name: libaot-Syncfusion.Maui.ImageEditor.dll.so
		ptr null; void* handle
	}, ; 751
	%struct.DSOCacheEntry {
		i64 u0x6373255c90ccd5fb, ; from name: aot-System.Diagnostics.StackTrace
		i64 u0xb21e783430e22a93, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.148_name, ; name: libaot-System.Diagnostics.StackTrace.dll.so
		ptr null; void* handle
	}, ; 752
	%struct.DSOCacheEntry {
		i64 u0x639234c2f6635c01, ; from name: aot-System.Text.Encoding.CodePages.dll.so
		i64 u0x16262857ad9a2e54, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.205_name, ; name: libaot-System.Text.Encoding.CodePages.dll.so
		ptr null; void* handle
	}, ; 753
	%struct.DSOCacheEntry {
		i64 u0x63a3ded9739bc502, ; from name: aot-Microsoft.Identity.Client.dll.so
		i64 u0xd20e64387a412094, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.67_name, ; name: libaot-Microsoft.Identity.Client.dll.so
		ptr null; void* handle
	}, ; 754
	%struct.DSOCacheEntry {
		i64 u0x63aae4eb33215c80, ; from name: System.Net.WebSockets.so
		i64 u0x403cd01c6fb39d89, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.175_name, ; name: libaot-System.Net.WebSockets.dll.so
		ptr null; void* handle
	}, ; 755
	%struct.DSOCacheEntry {
		i64 u0x63acf7d3d1e69b2a, ; from name: Microsoft.Extensions.DependencyModel.so
		i64 u0x42c08831b421dece, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.56_name, ; name: libaot-Microsoft.Extensions.DependencyModel.dll.so
		ptr null; void* handle
	}, ; 756
	%struct.DSOCacheEntry {
		i64 u0x63f5eda9e78fe297, ; from name: aot-System.Net.Security.so
		i64 u0x1271045d1561acf0, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.170_name, ; name: libaot-System.Net.Security.dll.so
		ptr null; void* handle
	}, ; 757
	%struct.DSOCacheEntry {
		i64 u0x640863fe2bb7b680, ; from name: System.Memory.Data.so
		i64 u0xe03e3baaab589d1e, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.98_name, ; name: libaot-System.Memory.Data.dll.so
		ptr null; void* handle
	}, ; 758
	%struct.DSOCacheEntry {
		i64 u0x64124dac20f9924e, ; from name: libaot-System.Security.Cryptography
		i64 u0xd0e82017367ac826, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.203_name, ; name: libaot-System.Security.Cryptography.dll.so
		ptr null; void* handle
	}, ; 759
	%struct.DSOCacheEntry {
		i64 u0x6430220180998fc3, ; from name: Microsoft.IdentityModel.Tokens.dll.so
		i64 u0x4be8f991cb00f075, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.74_name, ; name: libaot-Microsoft.IdentityModel.Tokens.dll.so
		ptr null; void* handle
	}, ; 760
	%struct.DSOCacheEntry {
		i64 u0x643e9a6a4be5fcd7, ; from name: aot-System.Net.ServerSentEvents.so
		i64 u0x95302b4a91a9ea47, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.99_name, ; name: libaot-System.Net.ServerSentEvents.dll.so
		ptr null; void* handle
	}, ; 761
	%struct.DSOCacheEntry {
		i64 u0x646bdbe98d5e615d, ; from name: aot-System.IO.Compression.Brotli.so
		i64 u0x7b22585c66d48a81, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.154_name, ; name: libaot-System.IO.Compression.Brotli.dll.so
		ptr null; void* handle
	}, ; 762
	%struct.DSOCacheEntry {
		i64 u0x64ad53cc8f6e0a3f, ; from name: libaot-System.Private.DataContractSerialization
		i64 u0x8fa52587768c02e7, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.178_name, ; name: libaot-System.Private.DataContractSerialization.dll.so
		ptr null; void* handle
	}, ; 763
	%struct.DSOCacheEntry {
		i64 u0x64be874ebbce6bd2, ; from name: aot-System.Private.CoreLib.so
		i64 u0xe1af59ffe15719e2, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.227_name, ; name: libaot-System.Private.CoreLib.dll.so
		ptr null; void* handle
	}, ; 764
	%struct.DSOCacheEntry {
		i64 u0x64fe9ba8e3dca394, ; from name: Microsoft.IdentityModel.Logging.so
		i64 u0x1175872aaf2edbfe, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.71_name, ; name: libaot-Microsoft.IdentityModel.Logging.dll.so
		ptr null; void* handle
	}, ; 765
	%struct.DSOCacheEntry {
		i64 u0x65037a642d353597, ; from name: aot-System.dll.so
		i64 u0x7b91ac8ddc528deb, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.221_name, ; name: libaot-System.dll.so
		ptr null; void* handle
	}, ; 766
	%struct.DSOCacheEntry {
		i64 u0x6517f6ccff9ff068, ; from name: libaot-System.Security.Cryptography.ProtectedData.so
		i64 u0x67faf2828acf47d0, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.101_name, ; name: libaot-System.Security.Cryptography.ProtectedData.dll.so
		ptr null; void* handle
	}, ; 767
	%struct.DSOCacheEntry {
		i64 u0x654a1612f95f8409, ; from name: aot-_Microsoft.Android.Resource.Designer.dll.so
		i64 u0x9cbca1c74026e295, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.9_name, ; name: libaot-_Microsoft.Android.Resource.Designer.dll.so
		ptr null; void* handle
	}, ; 768
	%struct.DSOCacheEntry {
		i64 u0x6574726038bbfebf, ; from name: aot-System.Diagnostics.Process.dll.so
		i64 u0x8657799bb82e0573, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.147_name, ; name: libaot-System.Diagnostics.Process.dll.so
		ptr null; void* handle
	}, ; 769
	%struct.DSOCacheEntry {
		i64 u0x6589bb25c9e21fa7, ; from name: aot-Microsoft.Extensions.Caching.Memory
		i64 u0x331a7f0d6c2c08c9, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.51_name, ; name: libaot-Microsoft.Extensions.Caching.Memory.dll.so
		ptr null; void* handle
	}, ; 770
	%struct.DSOCacheEntry {
		i64 u0x659dc45417570048, ; from name: Refit
		i64 u0x00a2ced568899a5e, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.83_name, ; name: libaot-Refit.dll.so
		ptr null; void* handle
	}, ; 771
	%struct.DSOCacheEntry {
		i64 u0x65c027309e0dbe63, ; from name: libaot-System.Threading.ThreadPool.so
		i64 u0x7d7a84dcff7fdb59, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.213_name, ; name: libaot-System.Threading.ThreadPool.dll.so
		ptr null; void* handle
	}, ; 772
	%struct.DSOCacheEntry {
		i64 u0x65cd21401fecc3dc, ; from name: libaot-System.Collections.Concurrent.dll.so
		i64 u0x65cd21401fecc3dc, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.135_name, ; name: libaot-System.Collections.Concurrent.dll.so
		ptr null; void* handle
	}, ; 773
	%struct.DSOCacheEntry {
		i64 u0x6619888793b3b2dd, ; from name: libaot-System.Runtime.Numerics.dll.so
		i64 u0x6619888793b3b2dd, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.189_name, ; name: libaot-System.Runtime.Numerics.dll.so
		ptr null; void* handle
	}, ; 774
	%struct.DSOCacheEntry {
		i64 u0x663073929cb67ebe, ; from name: libaot-Xamarin.AndroidX.Navigation.UI
		i64 u0x21b741f2635aa744, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.122_name, ; name: libaot-Xamarin.AndroidX.Navigation.UI.dll.so
		ptr null; void* handle
	}, ; 775
	%struct.DSOCacheEntry {
		i64 u0x664698f375779ca3, ; from name: libaot-System.Runtime.Serialization.Primitives
		i64 u0xbd30caec9108afc1, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.192_name, ; name: libaot-System.Runtime.Serialization.Primitives.dll.so
		ptr null; void* handle
	}, ; 776
	%struct.DSOCacheEntry {
		i64 u0x66d13304ce1a3efa, ; from name: Xamarin.AndroidX.CursorAdapter
		i64 u0xdf3c491694996c7e, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.110_name, ; name: libaot-Xamarin.AndroidX.CursorAdapter.dll.so
		ptr null; void* handle
	}, ; 777
	%struct.DSOCacheEntry {
		i64 u0x66d73be3c1eef8a7, ; from name: libaot-Microsoft.Extensions.FileProviders.Abstractions
		i64 u0x82b65efc7b0bc50f, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.60_name, ; name: libaot-Microsoft.Extensions.FileProviders.Abstractions.dll.so
		ptr null; void* handle
	}, ; 778
	%struct.DSOCacheEntry {
		i64 u0x673b27e4a453abcd, ; from name: Syncfusion.Maui.Sliders.dll.so
		i64 u0x8e1c0d0116b3ef4b, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.92_name, ; name: libaot-Syncfusion.Maui.Sliders.dll.so
		ptr null; void* handle
	}, ; 779
	%struct.DSOCacheEntry {
		i64 u0x675935a1e3b604dc, ; from name: libaot-System.Threading.Thread.dll.so
		i64 u0x675935a1e3b604dc, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.212_name, ; name: libaot-System.Threading.Thread.dll.so
		ptr null; void* handle
	}, ; 780
	%struct.DSOCacheEntry {
		i64 u0x6764ffceffcb3bac, ; from name: aot-Microsoft.Extensions.Caching.Memory.so
		i64 u0x331a7f0d6c2c08c9, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.51_name, ; name: libaot-Microsoft.Extensions.Caching.Memory.dll.so
		ptr null; void* handle
	}, ; 781
	%struct.DSOCacheEntry {
		i64 u0x6799522a23e8ae63, ; from name: aot-Microsoft.Extensions.Options.dll.so
		i64 u0xeef607f38ca22ffc, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.65_name, ; name: libaot-Microsoft.Extensions.Options.dll.so
		ptr null; void* handle
	}, ; 782
	%struct.DSOCacheEntry {
		i64 u0x67a5a044eb971974, ; from name: aot-Xamarin.AndroidX.ViewPager2.so
		i64 u0x4595d9c27242b287, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.127_name, ; name: libaot-Xamarin.AndroidX.ViewPager2.dll.so
		ptr null; void* handle
	}, ; 783
	%struct.DSOCacheEntry {
		i64 u0x67afd0bf45d8aeec, ; from name: libaot-System.Threading
		i64 u0x5f435aa7f5fde870, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.214_name, ; name: libaot-System.Threading.dll.so
		ptr null; void* handle
	}, ; 784
	%struct.DSOCacheEntry {
		i64 u0x67b9e9e88f49bc96, ; from name: aot-System.Text.Encodings.Web
		i64 u0x209bcec5b3b022b8, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.207_name, ; name: libaot-System.Text.Encodings.Web.dll.so
		ptr null; void* handle
	}, ; 785
	%struct.DSOCacheEntry {
		i64 u0x67ef4c1a9d5f7c55, ; from name: libaot-System.Private.Xml.so
		i64 u0x52bbd048717682d4, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.181_name, ; name: libaot-System.Private.Xml.dll.so
		ptr null; void* handle
	}, ; 786
	%struct.DSOCacheEntry {
		i64 u0x67f2c869b5e2bd8b, ; from name: aot-System.Formats.Asn1.dll.so
		i64 u0x4a9bda0e8528b414, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.153_name, ; name: libaot-System.Formats.Asn1.dll.so
		ptr null; void* handle
	}, ; 787
	%struct.DSOCacheEntry {
		i64 u0x67faf2828acf47d0, ; from name: libaot-System.Security.Cryptography.ProtectedData.dll.so
		i64 u0x67faf2828acf47d0, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.101_name, ; name: libaot-System.Security.Cryptography.ProtectedData.dll.so
		ptr null; void* handle
	}, ; 788
	%struct.DSOCacheEntry {
		i64 u0x6826feb0fb5a8799, ; from name: System.Text.RegularExpressions.dll.so
		i64 u0x7c2c39dae387b52d, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.209_name, ; name: libaot-System.Text.RegularExpressions.dll.so
		ptr null; void* handle
	}, ; 789
	%struct.DSOCacheEntry {
		i64 u0x683e37cb6d54b02d, ; from name: libaot-System.Net.Security
		i64 u0x1271045d1561acf0, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.170_name, ; name: libaot-System.Net.Security.dll.so
		ptr null; void* handle
	}, ; 790
	%struct.DSOCacheEntry {
		i64 u0x686fb8f5e535a70c, ; from name: aot-System.Diagnostics.Tracing
		i64 u0x28371251d401372b, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.150_name, ; name: libaot-System.Diagnostics.Tracing.dll.so
		ptr null; void* handle
	}, ; 791
	%struct.DSOCacheEntry {
		i64 u0x6872149aac83968a, ; from name: libaot-Microsoft.AspNetCore.Routing.dll.so
		i64 u0x6872149aac83968a, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.36_name, ; name: libaot-Microsoft.AspNetCore.Routing.dll.so
		ptr null; void* handle
	}, ; 792
	%struct.DSOCacheEntry {
		i64 u0x68f3b8b1aeb8e58f, ; from name: libaot-System.so
		i64 u0x7b91ac8ddc528deb, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.221_name, ; name: libaot-System.dll.so
		ptr null; void* handle
	}, ; 793
	%struct.DSOCacheEntry {
		i64 u0x68fbbbe2eb455198, ; from name: System.Formats.Asn1
		i64 u0x4a9bda0e8528b414, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.153_name, ; name: libaot-System.Formats.Asn1.dll.so
		ptr null; void* handle
	}, ; 794
	%struct.DSOCacheEntry {
		i64 u0x692b7614ef55b568, ; from name: libaot-Microsoft.EntityFrameworkCore.so
		i64 u0x9694080faa394553, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.46_name, ; name: libaot-Microsoft.EntityFrameworkCore.dll.so
		ptr null; void* handle
	}, ; 795
	%struct.DSOCacheEntry {
		i64 u0x69962d87b2f44233, ; from name: aot-System.Diagnostics.Tracing.so
		i64 u0x28371251d401372b, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.150_name, ; name: libaot-System.Diagnostics.Tracing.dll.so
		ptr null; void* handle
	}, ; 796
	%struct.DSOCacheEntry {
		i64 u0x6998ff23a2164374, ; from name: System.Collections.Immutable.dll.so
		i64 u0x49e9602a3882bd40, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.136_name, ; name: libaot-System.Collections.Immutable.dll.so
		ptr null; void* handle
	}, ; 797
	%struct.DSOCacheEntry {
		i64 u0x69997307aa75ab1d, ; from name: Xamarin.KotlinX.Coroutines.Core.Jvm.dll.so
		i64 u0x811e0efc0e57d069, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.130_name, ; name: libaot-Xamarin.KotlinX.Coroutines.Core.Jvm.dll.so
		ptr null; void* handle
	}, ; 798
	%struct.DSOCacheEntry {
		i64 u0x699e7811846a3888, ; from name: Microsoft.AspNetCore.Http.Connections.Common.so
		i64 u0x726b54f946bf0d7f, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.30_name, ; name: libaot-Microsoft.AspNetCore.Http.Connections.Common.dll.so
		ptr null; void* handle
	}, ; 799
	%struct.DSOCacheEntry {
		i64 u0x69dd3c9ffb9c24cd, ; from name: libaot-System.Security.AccessControl.dll.so
		i64 u0x69dd3c9ffb9c24cd, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.195_name, ; name: libaot-System.Security.AccessControl.dll.so
		ptr null; void* handle
	}, ; 800
	%struct.DSOCacheEntry {
		i64 u0x69f8bcaead2613c0, ; from name: System.Runtime.InteropServices.so
		i64 u0x5ae6db1ddadc230b, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.187_name, ; name: libaot-System.Runtime.InteropServices.dll.so
		ptr null; void* handle
	}, ; 801
	%struct.DSOCacheEntry {
		i64 u0x6a039c1f557cc435, ; from name: System.Collections.so
		i64 u0xb3f9fc836ae7ebb5, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.139_name, ; name: libaot-System.Collections.dll.so
		ptr null; void* handle
	}, ; 802
	%struct.DSOCacheEntry {
		i64 u0x6a03b775044080b2, ; from name: libaot-SQLitePCLRaw.lib.e_sqlite3.android.dll.so
		i64 u0x6a03b775044080b2, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.87_name, ; name: libaot-SQLitePCLRaw.lib.e_sqlite3.android.dll.so
		ptr null; void* handle
	}, ; 803
	%struct.DSOCacheEntry {
		i64 u0x6a2d509d33b4c6ae, ; from name: SQLitePCLRaw.batteries_v2.dll.so
		i64 u0x418d89fb2901d219, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.85_name, ; name: libaot-SQLitePCLRaw.batteries_v2.dll.so
		ptr null; void* handle
	}, ; 804
	%struct.DSOCacheEntry {
		i64 u0x6a332e01293b6f72, ; from name: Microsoft.Extensions.Options.dll.so
		i64 u0xeef607f38ca22ffc, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.65_name, ; name: libaot-Microsoft.Extensions.Options.dll.so
		ptr null; void* handle
	}, ; 805
	%struct.DSOCacheEntry {
		i64 u0x6a37fb5146e53239, ; from name: aot-System.IO.FileSystem.Watcher.so
		i64 u0xf90aa99869639df6, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.157_name, ; name: libaot-System.IO.FileSystem.Watcher.dll.so
		ptr null; void* handle
	}, ; 806
	%struct.DSOCacheEntry {
		i64 u0x6a4a976b4a3a0992, ; from name: aot-Microsoft.AspNetCore.Routing.so
		i64 u0x6872149aac83968a, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.36_name, ; name: libaot-Microsoft.AspNetCore.Routing.dll.so
		ptr null; void* handle
	}, ; 807
	%struct.DSOCacheEntry {
		i64 u0x6aae90d5594500a9, ; from name: libaot-System.Runtime.InteropServices.RuntimeInformation.dll.so
		i64 u0x6aae90d5594500a9, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.186_name, ; name: libaot-System.Runtime.InteropServices.RuntimeInformation.dll.so
		ptr null; void* handle
	}, ; 808
	%struct.DSOCacheEntry {
		i64 u0x6ad3a068eb7ae92e, ; from name: Microsoft.AspNetCore.SignalR.Core.so
		i64 u0x73dd04543af2c841, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.41_name, ; name: libaot-Microsoft.AspNetCore.SignalR.Core.dll.so
		ptr null; void* handle
	}, ; 809
	%struct.DSOCacheEntry {
		i64 u0x6ae597fd7fbafbfa, ; from name: aot-System.IO.Compression.Brotli.dll.so
		i64 u0x7b22585c66d48a81, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.154_name, ; name: libaot-System.IO.Compression.Brotli.dll.so
		ptr null; void* handle
	}, ; 810
	%struct.DSOCacheEntry {
		i64 u0x6b08ee2009339a0a, ; from name: aot-Microsoft.Maui
		i64 u0x58cd310024b735d8, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.77_name, ; name: libaot-Microsoft.Maui.dll.so
		ptr null; void* handle
	}, ; 811
	%struct.DSOCacheEntry {
		i64 u0x6b191693b6226982, ; from name: Mono.Android.so
		i64 u0x359895a3c1bd5685, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.226_name, ; name: libaot-Mono.Android.dll.so
		ptr null; void* handle
	}, ; 812
	%struct.DSOCacheEntry {
		i64 u0x6b9ab6d29bea4f7c, ; from name: Microsoft.Maui.Controls.so
		i64 u0x7f174db5a2c913e7, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.75_name, ; name: libaot-Microsoft.Maui.Controls.dll.so
		ptr null; void* handle
	}, ; 813
	%struct.DSOCacheEntry {
		i64 u0x6beaf0280e98381f, ; from name: Microsoft.IdentityModel.JsonWebTokens.so
		i64 u0x0323e786c13d309d, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.70_name, ; name: libaot-Microsoft.IdentityModel.JsonWebTokens.dll.so
		ptr null; void* handle
	}, ; 814
	%struct.DSOCacheEntry {
		i64 u0x6c3e41346855f8e3, ; from name: libaot-System.ObjectModel.so
		i64 u0x914167d87d2ee1b1, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.177_name, ; name: libaot-System.ObjectModel.dll.so
		ptr null; void* handle
	}, ; 815
	%struct.DSOCacheEntry {
		i64 u0x6c4e830c0d79912d, ; from name: libaot-Xamarin.AndroidX.SwipeRefreshLayout.dll.so
		i64 u0x6c4e830c0d79912d, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.125_name, ; name: libaot-Xamarin.AndroidX.SwipeRefreshLayout.dll.so
		ptr null; void* handle
	}, ; 816
	%struct.DSOCacheEntry {
		i64 u0x6caedb1d96a79293, ; from name: libaot-Microsoft.AspNetCore.Http.dll.so
		i64 u0x6caedb1d96a79293, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.27_name, ; name: libaot-Microsoft.AspNetCore.Http.dll.so
		ptr null; void* handle
	}, ; 817
	%struct.DSOCacheEntry {
		i64 u0x6cb44f6f183157b8, ; from name: Microsoft.EntityFrameworkCore.Abstractions.dll.so
		i64 u0x98d96e0f4341bc32, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.47_name, ; name: libaot-Microsoft.EntityFrameworkCore.Abstractions.dll.so
		ptr null; void* handle
	}, ; 818
	%struct.DSOCacheEntry {
		i64 u0x6ccbe8938e382a5a, ; from name: libaot-Xamarin.AndroidX.Lifecycle.ViewModelSavedState.so
		i64 u0x9b809dc726e0140e, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.117_name, ; name: libaot-Xamarin.AndroidX.Lifecycle.ViewModelSavedState.dll.so
		ptr null; void* handle
	}, ; 819
	%struct.DSOCacheEntry {
		i64 u0x6cd97f370311a542, ; from name: Microsoft.EntityFrameworkCore.SqlServer
		i64 u0x9daa39a878308c98, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.49_name, ; name: libaot-Microsoft.EntityFrameworkCore.SqlServer.dll.so
		ptr null; void* handle
	}, ; 820
	%struct.DSOCacheEntry {
		i64 u0x6ce045494a545eab, ; from name: libaot-Java.Interop.dll.so
		i64 u0x6ce045494a545eab, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.224_name, ; name: libaot-Java.Interop.dll.so
		ptr null; void* handle
	}, ; 821
	%struct.DSOCacheEntry {
		i64 u0x6ce182a530e302c8, ; from name: libaot-System.Reflection.Emit
		i64 u0x868be26aba2eea6d, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.184_name, ; name: libaot-System.Reflection.Emit.dll.so
		ptr null; void* handle
	}, ; 822
	%struct.DSOCacheEntry {
		i64 u0x6ce6e23930239c29, ; from name: aot-Microsoft.EntityFrameworkCore.dll.so
		i64 u0x9694080faa394553, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.46_name, ; name: libaot-Microsoft.EntityFrameworkCore.dll.so
		ptr null; void* handle
	}, ; 823
	%struct.DSOCacheEntry {
		i64 u0x6d07304370515858, ; from name: aot-Azure.Core.dll.so
		i64 u0x821f528a92d55dea, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.12_name, ; name: libaot-Azure.Core.dll.so
		ptr null; void* handle
	}, ; 824
	%struct.DSOCacheEntry {
		i64 u0x6d79993361e10ef2, ; from name: Microsoft.Extensions.Primitives
		i64 u0x9df2f15d2ed44e61, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.66_name, ; name: libaot-Microsoft.Extensions.Primitives.dll.so
		ptr null; void* handle
	}, ; 825
	%struct.DSOCacheEntry {
		i64 u0x6d832fef5af453cb, ; from name: libaot-Microsoft.Extensions.ObjectPool.so
		i64 u0xa951cdbe6a05ef83, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.64_name, ; name: libaot-Microsoft.Extensions.ObjectPool.dll.so
		ptr null; void* handle
	}, ; 826
	%struct.DSOCacheEntry {
		i64 u0x6d8a2243175ebccb, ; from name: Microsoft.Data.SqlClient.dll.so
		i64 u0x0b7c60fbe9d8f09b, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.45_name, ; name: libaot-Microsoft.Data.SqlClient.dll.so
		ptr null; void* handle
	}, ; 827
	%struct.DSOCacheEntry {
		i64 u0x6dc4578914a34b1c, ; from name: aot-System.IdentityModel.Tokens.Jwt.so
		i64 u0xe05faae6d518aca9, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.97_name, ; name: libaot-System.IdentityModel.Tokens.Jwt.dll.so
		ptr null; void* handle
	}, ; 828
	%struct.DSOCacheEntry {
		i64 u0x6e322eb2f55c11c7, ; from name: libaot-System.Threading.Channels
		i64 u0x59aee0bc92ee07e3, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.210_name, ; name: libaot-System.Threading.Channels.dll.so
		ptr null; void* handle
	}, ; 829
	%struct.DSOCacheEntry {
		i64 u0x6e64b60d447b8c7e, ; from name: aot-System.Net.Http
		i64 u0xd925f85604802447, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.165_name, ; name: libaot-System.Net.Http.dll.so
		ptr null; void* handle
	}, ; 830
	%struct.DSOCacheEntry {
		i64 u0x6e8533480a9f71a6, ; from name: aot-System.Runtime.Serialization.Primitives.dll.so
		i64 u0xbd30caec9108afc1, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.192_name, ; name: libaot-System.Runtime.Serialization.Primitives.dll.so
		ptr null; void* handle
	}, ; 831
	%struct.DSOCacheEntry {
		i64 u0x6e894829e650209e, ; from name: aot-Xamarin.AndroidX.CoordinatorLayout.dll.so
		i64 u0x5cc157f14ad19fc0, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.108_name, ; name: libaot-Xamarin.AndroidX.CoordinatorLayout.dll.so
		ptr null; void* handle
	}, ; 832
	%struct.DSOCacheEntry {
		i64 u0x6e8d35737ec9d942, ; from name: System.Memory.so
		i64 u0xad582851e7d05243, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.163_name, ; name: libaot-System.Memory.dll.so
		ptr null; void* handle
	}, ; 833
	%struct.DSOCacheEntry {
		i64 u0x6ef00c5a40a84578, ; from name: libaot-System.Diagnostics.DiagnosticSource.so
		i64 u0x77156c94b5eff927, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.146_name, ; name: libaot-System.Diagnostics.DiagnosticSource.dll.so
		ptr null; void* handle
	}, ; 834
	%struct.DSOCacheEntry {
		i64 u0x6f3638b02afc00cc, ; from name: libaot-Microsoft.Win32.Primitives.dll.so
		i64 u0x6f3638b02afc00cc, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.133_name, ; name: libaot-Microsoft.Win32.Primitives.dll.so
		ptr null; void* handle
	}, ; 835
	%struct.DSOCacheEntry {
		i64 u0x6f7d52bca595ee57, ; from name: libaot-Xamarin.AndroidX.Lifecycle.LiveData.Core.so
		i64 u0x38e4553d8764fa45, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.115_name, ; name: libaot-Xamarin.AndroidX.Lifecycle.LiveData.Core.dll.so
		ptr null; void* handle
	}, ; 836
	%struct.DSOCacheEntry {
		i64 u0x6f97a62324fd184a, ; from name: System.Xml.Linq.so
		i64 u0xe89b56c5a60687e6, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.217_name, ; name: libaot-System.Xml.Linq.dll.so
		ptr null; void* handle
	}, ; 837
	%struct.DSOCacheEntry {
		i64 u0x6fd15fb6a42c9afc, ; from name: libaot-System.Collections.NonGeneric.dll.so
		i64 u0x6fd15fb6a42c9afc, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.137_name, ; name: libaot-System.Collections.NonGeneric.dll.so
		ptr null; void* handle
	}, ; 838
	%struct.DSOCacheEntry {
		i64 u0x702dd09bc06ea5a1, ; from name: Microsoft.Extensions.Http.dll.so
		i64 u0x24aa3d6e3cd1bcb7, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.61_name, ; name: libaot-Microsoft.Extensions.Http.dll.so
		ptr null; void* handle
	}, ; 839
	%struct.DSOCacheEntry {
		i64 u0x70680ffd8b50cafe, ; from name: libaot-System.Diagnostics.TraceSource.so
		i64 u0x2119cc81025daa05, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.149_name, ; name: libaot-System.Diagnostics.TraceSource.dll.so
		ptr null; void* handle
	}, ; 840
	%struct.DSOCacheEntry {
		i64 u0x70849ceb23f02ae5, ; from name: aot-Microsoft.Maui.Graphics.so
		i64 u0x285d22da351d937a, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.79_name, ; name: libaot-Microsoft.Maui.Graphics.dll.so
		ptr null; void* handle
	}, ; 841
	%struct.DSOCacheEntry {
		i64 u0x70912a56b48f8119, ; from name: libaot-Microsoft.EntityFrameworkCore.Relational
		i64 u0xc114e8a396f5423b, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.48_name, ; name: libaot-Microsoft.EntityFrameworkCore.Relational.dll.so
		ptr null; void* handle
	}, ; 842
	%struct.DSOCacheEntry {
		i64 u0x70b72d25fb59aac8, ; from name: aot-Microsoft.SqlServer.Server
		i64 u0x7b4f94432c52afad, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.81_name, ; name: libaot-Microsoft.SqlServer.Server.dll.so
		ptr null; void* handle
	}, ; 843
	%struct.DSOCacheEntry {
		i64 u0x70d1338ac19b983e, ; from name: Refit.HttpClientFactory.dll.so
		i64 u0xbf4b844c69db6ec0, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.84_name, ; name: libaot-Refit.HttpClientFactory.dll.so
		ptr null; void* handle
	}, ; 844
	%struct.DSOCacheEntry {
		i64 u0x70f8ca2f11ec3669, ; from name: libaot-Syncfusion.Maui.ImageEditor.dll.so
		i64 u0x70f8ca2f11ec3669, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.91_name, ; name: libaot-Syncfusion.Maui.ImageEditor.dll.so
		ptr null; void* handle
	}, ; 845
	%struct.DSOCacheEntry {
		i64 u0x71119f59fccb3f0b, ; from name: aot-System.ComponentModel.Primitives.dll.so
		i64 u0xccde8a4563eee10b, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.141_name, ; name: libaot-System.ComponentModel.Primitives.dll.so
		ptr null; void* handle
	}, ; 846
	%struct.DSOCacheEntry {
		i64 u0x714dada2662aac0b, ; from name: libaot-Microsoft.EntityFrameworkCore
		i64 u0x9694080faa394553, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.46_name, ; name: libaot-Microsoft.EntityFrameworkCore.dll.so
		ptr null; void* handle
	}, ; 847
	%struct.DSOCacheEntry {
		i64 u0x718d0267420f9ebd, ; from name: aot-System.Reflection.Emit.Lightweight.dll.so
		i64 u0x54f7fbd0a81833fe, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.183_name, ; name: libaot-System.Reflection.Emit.Lightweight.dll.so
		ptr null; void* handle
	}, ; 848
	%struct.DSOCacheEntry {
		i64 u0x71a72d2d998e2673, ; from name: libaot-CommunityToolkit.Maui.dll.so
		i64 u0x71a72d2d998e2673, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.14_name, ; name: libaot-CommunityToolkit.Maui.dll.so
		ptr null; void* handle
	}, ; 849
	%struct.DSOCacheEntry {
		i64 u0x71b24bb83d898dc3, ; from name: aot-System.Linq.Queryable.so
		i64 u0x5932dbf572fab50a, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.161_name, ; name: libaot-System.Linq.Queryable.dll.so
		ptr null; void* handle
	}, ; 850
	%struct.DSOCacheEntry {
		i64 u0x71ba5cfb90a38209, ; from name: libaot-Xamarin.AndroidX.SwipeRefreshLayout
		i64 u0x6c4e830c0d79912d, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.125_name, ; name: libaot-Xamarin.AndroidX.SwipeRefreshLayout.dll.so
		ptr null; void* handle
	}, ; 851
	%struct.DSOCacheEntry {
		i64 u0x71ce172a47b85dd6, ; from name: aot-Microsoft.Extensions.Options.so
		i64 u0xeef607f38ca22ffc, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.65_name, ; name: libaot-Microsoft.Extensions.Options.dll.so
		ptr null; void* handle
	}, ; 852
	%struct.DSOCacheEntry {
		i64 u0x71e364db63da2efa, ; from name: aot-Microsoft.Extensions.Diagnostics.Abstractions.dll.so
		i64 u0xd10bb63f997c45a2, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.58_name, ; name: libaot-Microsoft.Extensions.Diagnostics.Abstractions.dll.so
		ptr null; void* handle
	}, ; 853
	%struct.DSOCacheEntry {
		i64 u0x722810af5e4dd737, ; from name: libaot-Microsoft.IdentityModel.Protocols
		i64 u0x9037f9d64d16c443, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.72_name, ; name: libaot-Microsoft.IdentityModel.Protocols.dll.so
		ptr null; void* handle
	}, ; 854
	%struct.DSOCacheEntry {
		i64 u0x72390be79b9026fa, ; from name: libaot-System.Console.so
		i64 u0xc2da5dca6ccd8b0a, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.144_name, ; name: libaot-System.Console.dll.so
		ptr null; void* handle
	}, ; 855
	%struct.DSOCacheEntry {
		i64 u0x7242820f67bc4ad6, ; from name: Microsoft.AspNetCore.SignalR.Common
		i64 u0x1d711f330f5778d7, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.40_name, ; name: libaot-Microsoft.AspNetCore.SignalR.Common.dll.so
		ptr null; void* handle
	}, ; 856
	%struct.DSOCacheEntry {
		i64 u0x7247abfd5606ac26, ; from name: libaot-System.Diagnostics.DiagnosticSource
		i64 u0x77156c94b5eff927, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.146_name, ; name: libaot-System.Diagnostics.DiagnosticSource.dll.so
		ptr null; void* handle
	}, ; 857
	%struct.DSOCacheEntry {
		i64 u0x725f5a9e82a45c81, ; from name: System.Security.Cryptography.Encoding
		i64 u0x31145bf76e7d3b7a, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.200_name, ; name: libaot-System.Security.Cryptography.Encoding.dll.so
		ptr null; void* handle
	}, ; 858
	%struct.DSOCacheEntry {
		i64 u0x726b54f946bf0d7f, ; from name: libaot-Microsoft.AspNetCore.Http.Connections.Common.dll.so
		i64 u0x726b54f946bf0d7f, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.30_name, ; name: libaot-Microsoft.AspNetCore.Http.Connections.Common.dll.so
		ptr null; void* handle
	}, ; 859
	%struct.DSOCacheEntry {
		i64 u0x7283d275dec4b805, ; from name: aot-System.Linq.Queryable.dll.so
		i64 u0x5932dbf572fab50a, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.161_name, ; name: libaot-System.Linq.Queryable.dll.so
		ptr null; void* handle
	}, ; 860
	%struct.DSOCacheEntry {
		i64 u0x72a3521be7cc0bf9, ; from name: aot-System.Runtime.Serialization.Primitives.so
		i64 u0xbd30caec9108afc1, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.192_name, ; name: libaot-System.Runtime.Serialization.Primitives.dll.so
		ptr null; void* handle
	}, ; 861
	%struct.DSOCacheEntry {
		i64 u0x72a57903a2f2e910, ; from name: aot-Mono.HttpUtility.so
		i64 u0x475325afa16dbfe5, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.82_name, ; name: libaot-Mono.HttpUtility.dll.so
		ptr null; void* handle
	}, ; 862
	%struct.DSOCacheEntry {
		i64 u0x72de88ad1e1d7001, ; from name: System.so
		i64 u0x7b91ac8ddc528deb, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.221_name, ; name: libaot-System.dll.so
		ptr null; void* handle
	}, ; 863
	%struct.DSOCacheEntry {
		i64 u0x72f39c979143ac6a, ; from name: libaot-System.Net.NetworkInformation
		i64 u0xb1bf28cdcefab46b, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.167_name, ; name: libaot-System.Net.NetworkInformation.dll.so
		ptr null; void* handle
	}, ; 864
	%struct.DSOCacheEntry {
		i64 u0x73046072daa4b321, ; from name: aot-System.Net.NameResolution
		i64 u0x7f280e9be5453eba, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.166_name, ; name: libaot-System.Net.NameResolution.dll.so
		ptr null; void* handle
	}, ; 865
	%struct.DSOCacheEntry {
		i64 u0x736a7bdc357a3821, ; from name: aot-System.Diagnostics.Process.so
		i64 u0x8657799bb82e0573, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.147_name, ; name: libaot-System.Diagnostics.Process.dll.so
		ptr null; void* handle
	}, ; 866
	%struct.DSOCacheEntry {
		i64 u0x737c75d31bd01ca8, ; from name: aot-Xamarin.AndroidX.AppCompat.AppCompatResources.so
		i64 u0x456e37cd491657b0, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.104_name, ; name: libaot-Xamarin.AndroidX.AppCompat.AppCompatResources.dll.so
		ptr null; void* handle
	}, ; 867
	%struct.DSOCacheEntry {
		i64 u0x7393060acfd95c29, ; from name: aot-Xamarin.AndroidX.Activity.so
		i64 u0x8a05820e9e77c0c3, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.102_name, ; name: libaot-Xamarin.AndroidX.Activity.dll.so
		ptr null; void* handle
	}, ; 868
	%struct.DSOCacheEntry {
		i64 u0x73a4d87f2c6022fe, ; from name: CommunityToolkit.Maui.dll.so
		i64 u0x71a72d2d998e2673, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.14_name, ; name: libaot-CommunityToolkit.Maui.dll.so
		ptr null; void* handle
	}, ; 869
	%struct.DSOCacheEntry {
		i64 u0x73cc013549e3c965, ; from name: Xamarin.AndroidX.Lifecycle.ViewModel.Android.dll.so
		i64 u0xc06034423c0d320f, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.116_name, ; name: libaot-Xamarin.AndroidX.Lifecycle.ViewModel.Android.dll.so
		ptr null; void* handle
	}, ; 870
	%struct.DSOCacheEntry {
		i64 u0x73dd04543af2c841, ; from name: libaot-Microsoft.AspNetCore.SignalR.Core.dll.so
		i64 u0x73dd04543af2c841, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.41_name, ; name: libaot-Microsoft.AspNetCore.SignalR.Core.dll.so
		ptr null; void* handle
	}, ; 871
	%struct.DSOCacheEntry {
		i64 u0x73df3d198578cdda, ; from name: aot-Mono.HttpUtility
		i64 u0x475325afa16dbfe5, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.82_name, ; name: libaot-Mono.HttpUtility.dll.so
		ptr null; void* handle
	}, ; 872
	%struct.DSOCacheEntry {
		i64 u0x74123580a0ac87e4, ; from name: System.IO.Compression.Brotli.dll.so
		i64 u0x7b22585c66d48a81, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.154_name, ; name: libaot-System.IO.Compression.Brotli.dll.so
		ptr null; void* handle
	}, ; 873
	%struct.DSOCacheEntry {
		i64 u0x744138548d3e72ee, ; from name: System.Diagnostics.Process.dll.so
		i64 u0x8657799bb82e0573, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.147_name, ; name: libaot-System.Diagnostics.Process.dll.so
		ptr null; void* handle
	}, ; 874
	%struct.DSOCacheEntry {
		i64 u0x7465e066858b0423, ; from name: aot-Xamarin.KotlinX.Coroutines.Core.Jvm
		i64 u0x811e0efc0e57d069, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.130_name, ; name: libaot-Xamarin.KotlinX.Coroutines.Core.Jvm.dll.so
		ptr null; void* handle
	}, ; 875
	%struct.DSOCacheEntry {
		i64 u0x74b0aefe8f467d50, ; from name: libaot-Xamarin.AndroidX.Loader.dll.so
		i64 u0x74b0aefe8f467d50, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.118_name, ; name: libaot-Xamarin.AndroidX.Loader.dll.so
		ptr null; void* handle
	}, ; 876
	%struct.DSOCacheEntry {
		i64 u0x74d152f4236791c6, ; from name: SocialMediaMaui.Shared.dll.so
		i64 u0x12448631a200ce9a, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.10_name, ; name: libaot-SocialMediaMaui.Shared.dll.so
		ptr null; void* handle
	}, ; 877
	%struct.DSOCacheEntry {
		i64 u0x751236a36e5073c9, ; from name: aot-System.Net.WebHeaderCollection.so
		i64 u0x42b58ea66e808de7, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.173_name, ; name: libaot-System.Net.WebHeaderCollection.dll.so
		ptr null; void* handle
	}, ; 878
	%struct.DSOCacheEntry {
		i64 u0x7514f62a2e058f5d, ; from name: aot-System.Security.Cryptography.X509Certificates
		i64 u0x86ff945e422694f9, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.202_name, ; name: libaot-System.Security.Cryptography.X509Certificates.dll.so
		ptr null; void* handle
	}, ; 879
	%struct.DSOCacheEntry {
		i64 u0x7532cc5bf9c97227, ; from name: aot-System.IO.Pipelines
		i64 u0x027079cd6cbb2479, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.158_name, ; name: libaot-System.IO.Pipelines.dll.so
		ptr null; void* handle
	}, ; 880
	%struct.DSOCacheEntry {
		i64 u0x7539c045dd81cdac, ; from name: libaot-Microsoft.AspNetCore.SignalR.Protocols.Json
		i64 u0x53a8edd5eb823442, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.42_name, ; name: libaot-Microsoft.AspNetCore.SignalR.Protocols.Json.dll.so
		ptr null; void* handle
	}, ; 881
	%struct.DSOCacheEntry {
		i64 u0x75539c602a2554b5, ; from name: Microsoft.Extensions.Logging.Abstractions.so
		i64 u0xe6757a5fac324e53, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.63_name, ; name: libaot-Microsoft.Extensions.Logging.Abstractions.dll.so
		ptr null; void* handle
	}, ; 882
	%struct.DSOCacheEntry {
		i64 u0x7577967f509b9961, ; from name: Microsoft.Maui.Controls.dll.so
		i64 u0x7f174db5a2c913e7, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.75_name, ; name: libaot-Microsoft.Maui.Controls.dll.so
		ptr null; void* handle
	}, ; 883
	%struct.DSOCacheEntry {
		i64 u0x757898ba637db46e, ; from name: libaot-Xamarin.KotlinX.Serialization.Core.Jvm.dll.so
		i64 u0x757898ba637db46e, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.131_name, ; name: libaot-Xamarin.KotlinX.Serialization.Core.Jvm.dll.so
		ptr null; void* handle
	}, ; 884
	%struct.DSOCacheEntry {
		i64 u0x7648004a8fe5501d, ; from name: System.Diagnostics.DiagnosticSource.so
		i64 u0x77156c94b5eff927, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.146_name, ; name: libaot-System.Diagnostics.DiagnosticSource.dll.so
		ptr null; void* handle
	}, ; 885
	%struct.DSOCacheEntry {
		i64 u0x764e09afb7f22c1f, ; from name: libaot-System.Private.CoreLib
		i64 u0xe1af59ffe15719e2, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.227_name, ; name: libaot-System.Private.CoreLib.dll.so
		ptr null; void* handle
	}, ; 886
	%struct.DSOCacheEntry {
		i64 u0x76c6797565e08a42, ; from name: System.Net.Http.Json.dll.so
		i64 u0x36547dc653fb83c1, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.164_name, ; name: libaot-System.Net.Http.Json.dll.so
		ptr null; void* handle
	}, ; 887
	%struct.DSOCacheEntry {
		i64 u0x76d4774acb197657, ; from name: aot-Microsoft.EntityFrameworkCore.Abstractions.so
		i64 u0x98d96e0f4341bc32, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.47_name, ; name: libaot-Microsoft.EntityFrameworkCore.Abstractions.dll.so
		ptr null; void* handle
	}, ; 888
	%struct.DSOCacheEntry {
		i64 u0x77156c94b5eff927, ; from name: libaot-System.Diagnostics.DiagnosticSource.dll.so
		i64 u0x77156c94b5eff927, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.146_name, ; name: libaot-System.Diagnostics.DiagnosticSource.dll.so
		ptr null; void* handle
	}, ; 889
	%struct.DSOCacheEntry {
		i64 u0x7765806ca8ee326b, ; from name: Microsoft.AspNetCore.Http.dll.so
		i64 u0x6caedb1d96a79293, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.27_name, ; name: libaot-Microsoft.AspNetCore.Http.dll.so
		ptr null; void* handle
	}, ; 890
	%struct.DSOCacheEntry {
		i64 u0x77c0b65248310a08, ; from name: aot-Azure.Identity.so
		i64 u0xf309d7d68dc0ac48, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.13_name, ; name: libaot-Azure.Identity.dll.so
		ptr null; void* handle
	}, ; 891
	%struct.DSOCacheEntry {
		i64 u0x77d20fe258b675ac, ; from name: aot-Microsoft.IdentityModel.Tokens
		i64 u0x4be8f991cb00f075, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.74_name, ; name: libaot-Microsoft.IdentityModel.Tokens.dll.so
		ptr null; void* handle
	}, ; 892
	%struct.DSOCacheEntry {
		i64 u0x7803f1a136f3d0f0, ; from name: libaot-System.Security.Cryptography.Csp
		i64 u0xb259133b67649ff8, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.199_name, ; name: libaot-System.Security.Cryptography.Csp.dll.so
		ptr null; void* handle
	}, ; 893
	%struct.DSOCacheEntry {
		i64 u0x781c8723c428ecd1, ; from name: aot-System.Runtime.Numerics.so
		i64 u0x6619888793b3b2dd, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.189_name, ; name: libaot-System.Runtime.Numerics.dll.so
		ptr null; void* handle
	}, ; 894
	%struct.DSOCacheEntry {
		i64 u0x7854a68698583935, ; from name: aot-Microsoft.Data.SqlClient
		i64 u0x0b7c60fbe9d8f09b, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.45_name, ; name: libaot-Microsoft.Data.SqlClient.dll.so
		ptr null; void* handle
	}, ; 895
	%struct.DSOCacheEntry {
		i64 u0x785bad4f0559c250, ; from name: libaot-DocumentFormat.OpenXml.VariableReplacer.Core.dll.so
		i64 u0x785bad4f0559c250, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.19_name, ; name: libaot-DocumentFormat.OpenXml.VariableReplacer.Core.dll.so
		ptr null; void* handle
	}, ; 896
	%struct.DSOCacheEntry {
		i64 u0x7863331b6bb8dade, ; from name: aot-System.Reflection.Primitives
		i64 u0x8c58bd1a08c146f5, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.185_name, ; name: libaot-System.Reflection.Primitives.dll.so
		ptr null; void* handle
	}, ; 897
	%struct.DSOCacheEntry {
		i64 u0x78740426415b2618, ; from name: Xamarin.AndroidX.ViewPager2.so
		i64 u0x4595d9c27242b287, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.127_name, ; name: libaot-Xamarin.AndroidX.ViewPager2.dll.so
		ptr null; void* handle
	}, ; 898
	%struct.DSOCacheEntry {
		i64 u0x78a1938b89c96721, ; from name: Microsoft.AspNetCore.Http.Connections.Common
		i64 u0x726b54f946bf0d7f, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.30_name, ; name: libaot-Microsoft.AspNetCore.Http.Connections.Common.dll.so
		ptr null; void* handle
	}, ; 899
	%struct.DSOCacheEntry {
		i64 u0x78c330305e0da911, ; from name: aot-System.Net.WebClient
		i64 u0x4ce9b13ddea58a1b, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.172_name, ; name: libaot-System.Net.WebClient.dll.so
		ptr null; void* handle
	}, ; 900
	%struct.DSOCacheEntry {
		i64 u0x78f5da5f3dbb8df3, ; from name: libaot-System.ComponentModel.so
		i64 u0x38a82198a4cd2a73, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.143_name, ; name: libaot-System.ComponentModel.dll.so
		ptr null; void* handle
	}, ; 901
	%struct.DSOCacheEntry {
		i64 u0x794cf0aff152f5b3, ; from name: libaot-Microsoft.AspNetCore.SignalR.Core.so
		i64 u0x73dd04543af2c841, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.41_name, ; name: libaot-Microsoft.AspNetCore.SignalR.Core.dll.so
		ptr null; void* handle
	}, ; 902
	%struct.DSOCacheEntry {
		i64 u0x79a319cd6e76a263, ; from name: libaot-Xamarin.AndroidX.Navigation.Runtime.dll.so
		i64 u0x79a319cd6e76a263, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.121_name, ; name: libaot-Xamarin.AndroidX.Navigation.Runtime.dll.so
		ptr null; void* handle
	}, ; 903
	%struct.DSOCacheEntry {
		i64 u0x7a25bdb29108c6e7, ; from name: Microsoft.Extensions.Http
		i64 u0x24aa3d6e3cd1bcb7, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.61_name, ; name: libaot-Microsoft.Extensions.Http.dll.so
		ptr null; void* handle
	}, ; 904
	%struct.DSOCacheEntry {
		i64 u0x7a43b5f3b8291b83, ; from name: Azure.Identity.dll.so
		i64 u0xf309d7d68dc0ac48, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.13_name, ; name: libaot-Azure.Identity.dll.so
		ptr null; void* handle
	}, ; 905
	%struct.DSOCacheEntry {
		i64 u0x7a67353ca9d31ad1, ; from name: aot-Microsoft.AspNetCore.Authorization.Policy
		i64 u0x4d16f4a17e081b1e, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.23_name, ; name: libaot-Microsoft.AspNetCore.Authorization.Policy.dll.so
		ptr null; void* handle
	}, ; 906
	%struct.DSOCacheEntry {
		i64 u0x7a9260415814f17a, ; from name: libaot-Microsoft.AspNetCore.Authorization.Policy.so
		i64 u0x4d16f4a17e081b1e, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.23_name, ; name: libaot-Microsoft.AspNetCore.Authorization.Policy.dll.so
		ptr null; void* handle
	}, ; 907
	%struct.DSOCacheEntry {
		i64 u0x7aa7acc28fe6692d, ; from name: aot-System.ComponentModel.TypeConverter.so
		i64 u0xcb7e41356728fd07, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.142_name, ; name: libaot-System.ComponentModel.TypeConverter.dll.so
		ptr null; void* handle
	}, ; 908
	%struct.DSOCacheEntry {
		i64 u0x7aab0e827435486e, ; from name: aot-System.Memory.Data.so
		i64 u0xe03e3baaab589d1e, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.98_name, ; name: libaot-System.Memory.Data.dll.so
		ptr null; void* handle
	}, ; 909
	%struct.DSOCacheEntry {
		i64 u0x7aad0ea8ac24dbbd, ; from name: System.Buffers.so
		i64 u0x5988bd4997e5d75f, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.134_name, ; name: libaot-System.Buffers.dll.so
		ptr null; void* handle
	}, ; 910
	%struct.DSOCacheEntry {
		i64 u0x7ab5ae8ec46b7ec3, ; from name: libaot-System.Security.Cryptography.Csp.so
		i64 u0xb259133b67649ff8, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.199_name, ; name: libaot-System.Security.Cryptography.Csp.dll.so
		ptr null; void* handle
	}, ; 911
	%struct.DSOCacheEntry {
		i64 u0x7abe2531e9b9835b, ; from name: System.Private.Xml.dll.so
		i64 u0x52bbd048717682d4, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.181_name, ; name: libaot-System.Private.Xml.dll.so
		ptr null; void* handle
	}, ; 912
	%struct.DSOCacheEntry {
		i64 u0x7ac07a6713abaa3b, ; from name: aot-Microsoft.Maui.so
		i64 u0x58cd310024b735d8, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.77_name, ; name: libaot-Microsoft.Maui.dll.so
		ptr null; void* handle
	}, ; 913
	%struct.DSOCacheEntry {
		i64 u0x7adcf889f929072e, ; from name: libaot-Mono.Android.Runtime.so
		i64 u0x156ae2b2e8a39884, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.225_name, ; name: libaot-Mono.Android.Runtime.dll.so
		ptr null; void* handle
	}, ; 914
	%struct.DSOCacheEntry {
		i64 u0x7afb6c409bf9f32b, ; from name: libaot-Microsoft.AspNetCore.SignalR.Core
		i64 u0x73dd04543af2c841, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.41_name, ; name: libaot-Microsoft.AspNetCore.SignalR.Core.dll.so
		ptr null; void* handle
	}, ; 915
	%struct.DSOCacheEntry {
		i64 u0x7affa1c14b7318eb, ; from name: aot-Microsoft.AspNetCore.Mvc.Abstractions.dll.so
		i64 u0x8be639a423b6d017, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.33_name, ; name: libaot-Microsoft.AspNetCore.Mvc.Abstractions.dll.so
		ptr null; void* handle
	}, ; 916
	%struct.DSOCacheEntry {
		i64 u0x7b07e6f22884b91b, ; from name: System.Drawing.Primitives.dll.so
		i64 u0x934cbfda9b40e895, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.151_name, ; name: libaot-System.Drawing.Primitives.dll.so
		ptr null; void* handle
	}, ; 917
	%struct.DSOCacheEntry {
		i64 u0x7b22585c66d48a81, ; from name: libaot-System.IO.Compression.Brotli.dll.so
		i64 u0x7b22585c66d48a81, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.154_name, ; name: libaot-System.IO.Compression.Brotli.dll.so
		ptr null; void* handle
	}, ; 918
	%struct.DSOCacheEntry {
		i64 u0x7b3666e1845e7bb0, ; from name: Microsoft.Extensions.ObjectPool.dll.so
		i64 u0xa951cdbe6a05ef83, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.64_name, ; name: libaot-Microsoft.Extensions.ObjectPool.dll.so
		ptr null; void* handle
	}, ; 919
	%struct.DSOCacheEntry {
		i64 u0x7b40d36930a1c184, ; from name: aot-Microsoft.AspNetCore.Hosting.Abstractions
		i64 u0x8e5050b380b35b28, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.25_name, ; name: libaot-Microsoft.AspNetCore.Hosting.Abstractions.dll.so
		ptr null; void* handle
	}, ; 920
	%struct.DSOCacheEntry {
		i64 u0x7b4f94432c52afad, ; from name: libaot-Microsoft.SqlServer.Server.dll.so
		i64 u0x7b4f94432c52afad, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.81_name, ; name: libaot-Microsoft.SqlServer.Server.dll.so
		ptr null; void* handle
	}, ; 921
	%struct.DSOCacheEntry {
		i64 u0x7b6db0d2c226cbec, ; from name: aot-System.Transactions.Local.so
		i64 u0x5425eb433f599bc7, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.215_name, ; name: libaot-System.Transactions.Local.dll.so
		ptr null; void* handle
	}, ; 922
	%struct.DSOCacheEntry {
		i64 u0x7b91ac8ddc528deb, ; from name: libaot-System.dll.so
		i64 u0x7b91ac8ddc528deb, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.221_name, ; name: libaot-System.dll.so
		ptr null; void* handle
	}, ; 923
	%struct.DSOCacheEntry {
		i64 u0x7ba3051e267a5f2d, ; from name: aot-Microsoft.Net.Http.Headers.dll.so
		i64 u0xa81dfd6455f2dc19, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.80_name, ; name: libaot-Microsoft.Net.Http.Headers.dll.so
		ptr null; void* handle
	}, ; 924
	%struct.DSOCacheEntry {
		i64 u0x7bc3d53eeee718e3, ; from name: aot-Xamarin.AndroidX.Navigation.UI.dll.so
		i64 u0x21b741f2635aa744, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.122_name, ; name: libaot-Xamarin.AndroidX.Navigation.UI.dll.so
		ptr null; void* handle
	}, ; 925
	%struct.DSOCacheEntry {
		i64 u0x7bef86a4335c4870, ; from name: System.ComponentModel.TypeConverter
		i64 u0xcb7e41356728fd07, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.142_name, ; name: libaot-System.ComponentModel.TypeConverter.dll.so
		ptr null; void* handle
	}, ; 926
	%struct.DSOCacheEntry {
		i64 u0x7c0f521d29298aa3, ; from name: libaot-System.Net.WebClient.so
		i64 u0x4ce9b13ddea58a1b, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.172_name, ; name: libaot-System.Net.WebClient.dll.so
		ptr null; void* handle
	}, ; 927
	%struct.DSOCacheEntry {
		i64 u0x7c2c39dae387b52d, ; from name: libaot-System.Text.RegularExpressions.dll.so
		i64 u0x7c2c39dae387b52d, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.209_name, ; name: libaot-System.Text.RegularExpressions.dll.so
		ptr null; void* handle
	}, ; 928
	%struct.DSOCacheEntry {
		i64 u0x7c45ab7aeb5d0dbd, ; from name: aot-System.Security.Cryptography.Primitives.dll.so
		i64 u0x7d7dff41d9076267, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.201_name, ; name: libaot-System.Security.Cryptography.Primitives.dll.so
		ptr null; void* handle
	}, ; 929
	%struct.DSOCacheEntry {
		i64 u0x7c50efeb43b82ba1, ; from name: libaot-Microsoft.AspNetCore.Mvc.Core.so
		i64 u0xffcb4d21a593e637, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.34_name, ; name: libaot-Microsoft.AspNetCore.Mvc.Core.dll.so
		ptr null; void* handle
	}, ; 930
	%struct.DSOCacheEntry {
		i64 u0x7c894e02740d01a2, ; from name: aot-Microsoft.AspNetCore.ResponseCaching.Abstractions
		i64 u0x2eb68ca0cc467150, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.35_name, ; name: libaot-Microsoft.AspNetCore.ResponseCaching.Abstractions.dll.so
		ptr null; void* handle
	}, ; 931
	%struct.DSOCacheEntry {
		i64 u0x7c992c44ff255497, ; from name: libaot-Microsoft.Extensions.Caching.Abstractions
		i64 u0x988026893039cd51, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.50_name, ; name: libaot-Microsoft.Extensions.Caching.Abstractions.dll.so
		ptr null; void* handle
	}, ; 932
	%struct.DSOCacheEntry {
		i64 u0x7cc637f941f716d0, ; from name: CommunityToolkit.Maui.Core
		i64 u0x1f7f7b0e04fbedb0, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.15_name, ; name: libaot-CommunityToolkit.Maui.Core.dll.so
		ptr null; void* handle
	}, ; 933
	%struct.DSOCacheEntry {
		i64 u0x7ccac4648c0451f3, ; from name: System.Transactions.Local.so
		i64 u0x5425eb433f599bc7, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.215_name, ; name: libaot-System.Transactions.Local.dll.so
		ptr null; void* handle
	}, ; 934
	%struct.DSOCacheEntry {
		i64 u0x7d09412e094065be, ; from name: aot-Xamarin.AndroidX.Core.dll.so
		i64 u0x28a319e875b39488, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.109_name, ; name: libaot-Xamarin.AndroidX.Core.dll.so
		ptr null; void* handle
	}, ; 935
	%struct.DSOCacheEntry {
		i64 u0x7d13a780ac9c1725, ; from name: libaot-System.Numerics.Vectors
		i64 u0x37fbdff3aa18872d, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.176_name, ; name: libaot-System.Numerics.Vectors.dll.so
		ptr null; void* handle
	}, ; 936
	%struct.DSOCacheEntry {
		i64 u0x7d2d9bc1331b0af6, ; from name: libaot-Syncfusion.Maui.Toolkit.so
		i64 u0x2d6521795fa92605, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.93_name, ; name: libaot-Syncfusion.Maui.Toolkit.dll.so
		ptr null; void* handle
	}, ; 937
	%struct.DSOCacheEntry {
		i64 u0x7d349accb2b75347, ; from name: libaot-Microsoft.Extensions.Caching.Memory.so
		i64 u0x331a7f0d6c2c08c9, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.51_name, ; name: libaot-Microsoft.Extensions.Caching.Memory.dll.so
		ptr null; void* handle
	}, ; 938
	%struct.DSOCacheEntry {
		i64 u0x7d60adb413a03218, ; from name: aot-Microsoft.Extensions.Caching.Abstractions
		i64 u0x988026893039cd51, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.50_name, ; name: libaot-Microsoft.Extensions.Caching.Abstractions.dll.so
		ptr null; void* handle
	}, ; 939
	%struct.DSOCacheEntry {
		i64 u0x7d754fe8f5c4666b, ; from name: aot-System.Runtime.Serialization.Formatters
		i64 u0xc52860d1d6baa3ef, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.190_name, ; name: libaot-System.Runtime.Serialization.Formatters.dll.so
		ptr null; void* handle
	}, ; 940
	%struct.DSOCacheEntry {
		i64 u0x7d7a84dcff7fdb59, ; from name: libaot-System.Threading.ThreadPool.dll.so
		i64 u0x7d7a84dcff7fdb59, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.213_name, ; name: libaot-System.Threading.ThreadPool.dll.so
		ptr null; void* handle
	}, ; 941
	%struct.DSOCacheEntry {
		i64 u0x7d7dff41d9076267, ; from name: libaot-System.Security.Cryptography.Primitives.dll.so
		i64 u0x7d7dff41d9076267, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.201_name, ; name: libaot-System.Security.Cryptography.Primitives.dll.so
		ptr null; void* handle
	}, ; 942
	%struct.DSOCacheEntry {
		i64 u0x7d8ee2bdc8e3aad1, ; from name: System.Numerics.Vectors
		i64 u0x37fbdff3aa18872d, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.176_name, ; name: libaot-System.Numerics.Vectors.dll.so
		ptr null; void* handle
	}, ; 943
	%struct.DSOCacheEntry {
		i64 u0x7d996a621678709b, ; from name: libaot-Xamarin.AndroidX.Navigation.Fragment
		i64 u0xaa2eca1145f3a7cc, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.120_name, ; name: libaot-Xamarin.AndroidX.Navigation.Fragment.dll.so
		ptr null; void* handle
	}, ; 944
	%struct.DSOCacheEntry {
		i64 u0x7d9f5085bfa11590, ; from name: libaot-System.Text.Json
		i64 u0x9bb35aa4bcef7b80, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.208_name, ; name: libaot-System.Text.Json.dll.so
		ptr null; void* handle
	}, ; 945
	%struct.DSOCacheEntry {
		i64 u0x7dec6152c2473976, ; from name: libaot-_Microsoft.Android.Resource.Designer.so
		i64 u0x9cbca1c74026e295, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.9_name, ; name: libaot-_Microsoft.Android.Resource.Designer.dll.so
		ptr null; void* handle
	}, ; 946
	%struct.DSOCacheEntry {
		i64 u0x7dfc3d6d9d8d7b70, ; from name: System.Collections
		i64 u0xb3f9fc836ae7ebb5, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.139_name, ; name: libaot-System.Collections.dll.so
		ptr null; void* handle
	}, ; 947
	%struct.DSOCacheEntry {
		i64 u0x7e0fa910b6b3f665, ; from name: aot-SQLitePCLRaw.core
		i64 u0x110f85ed0e988dad, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.86_name, ; name: libaot-SQLitePCLRaw.core.dll.so
		ptr null; void* handle
	}, ; 948
	%struct.DSOCacheEntry {
		i64 u0x7e2a7dc5fa88338e, ; from name: libaot-Xamarin.AndroidX.CoordinatorLayout.so
		i64 u0x5cc157f14ad19fc0, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.108_name, ; name: libaot-Xamarin.AndroidX.CoordinatorLayout.dll.so
		ptr null; void* handle
	}, ; 949
	%struct.DSOCacheEntry {
		i64 u0x7e4bf0531e4abd0b, ; from name: Microsoft.AspNetCore.Mvc.Abstractions.so
		i64 u0x8be639a423b6d017, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.33_name, ; name: libaot-Microsoft.AspNetCore.Mvc.Abstractions.dll.so
		ptr null; void* handle
	}, ; 950
	%struct.DSOCacheEntry {
		i64 u0x7e53747ccecc28ec, ; from name: aot-System.Security.AccessControl.dll.so
		i64 u0x69dd3c9ffb9c24cd, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.195_name, ; name: libaot-System.Security.AccessControl.dll.so
		ptr null; void* handle
	}, ; 951
	%struct.DSOCacheEntry {
		i64 u0x7e7c9cbbad58344f, ; from name: aot-System.Private.DataContractSerialization.so
		i64 u0x8fa52587768c02e7, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.178_name, ; name: libaot-System.Private.DataContractSerialization.dll.so
		ptr null; void* handle
	}, ; 952
	%struct.DSOCacheEntry {
		i64 u0x7e87c842091063f5, ; from name: aot-System.Security.Cryptography.ProtectedData.so
		i64 u0x67faf2828acf47d0, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.101_name, ; name: libaot-System.Security.Cryptography.ProtectedData.dll.so
		ptr null; void* handle
	}, ; 953
	%struct.DSOCacheEntry {
		i64 u0x7edbb351f3f9be56, ; from name: libaot-System.Private.CoreLib.so
		i64 u0xe1af59ffe15719e2, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.227_name, ; name: libaot-System.Private.CoreLib.dll.so
		ptr null; void* handle
	}, ; 954
	%struct.DSOCacheEntry {
		i64 u0x7eff369f2e01cf95, ; from name: Microsoft.AspNetCore.Http.Features
		i64 u0x621c21d9c3290da0, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.32_name, ; name: libaot-Microsoft.AspNetCore.Http.Features.dll.so
		ptr null; void* handle
	}, ; 955
	%struct.DSOCacheEntry {
		i64 u0x7f174db5a2c913e7, ; from name: libaot-Microsoft.Maui.Controls.dll.so
		i64 u0x7f174db5a2c913e7, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.75_name, ; name: libaot-Microsoft.Maui.Controls.dll.so
		ptr null; void* handle
	}, ; 956
	%struct.DSOCacheEntry {
		i64 u0x7f280e9be5453eba, ; from name: libaot-System.Net.NameResolution.dll.so
		i64 u0x7f280e9be5453eba, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.166_name, ; name: libaot-System.Net.NameResolution.dll.so
		ptr null; void* handle
	}, ; 957
	%struct.DSOCacheEntry {
		i64 u0x7f46178b9416459c, ; from name: aot-System.IO.FileSystem.AccessControl
		i64 u0xf8af38e7ca3d5d78, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.156_name, ; name: libaot-System.IO.FileSystem.AccessControl.dll.so
		ptr null; void* handle
	}, ; 958
	%struct.DSOCacheEntry {
		i64 u0x7f8f286bea7d27c8, ; from name: libaot-System.Collections.Specialized.so
		i64 u0x355b66670e6bf2e4, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.138_name, ; name: libaot-System.Collections.Specialized.dll.so
		ptr null; void* handle
	}, ; 959
	%struct.DSOCacheEntry {
		i64 u0x7f9351cd44b1273f, ; from name: Microsoft.Extensions.Configuration.Abstractions
		i64 u0xd6a1ce9f7ccd35cb, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.53_name, ; name: libaot-Microsoft.Extensions.Configuration.Abstractions.dll.so
		ptr null; void* handle
	}, ; 960
	%struct.DSOCacheEntry {
		i64 u0x7fae0ef4dc4770fe, ; from name: Microsoft.Identity.Client
		i64 u0xd20e64387a412094, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.67_name, ; name: libaot-Microsoft.Identity.Client.dll.so
		ptr null; void* handle
	}, ; 961
	%struct.DSOCacheEntry {
		i64 u0x7fb3d22a29fb88db, ; from name: _Microsoft.Android.Resource.Designer.dll.so
		i64 u0x9cbca1c74026e295, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.9_name, ; name: libaot-_Microsoft.Android.Resource.Designer.dll.so
		ptr null; void* handle
	}, ; 962
	%struct.DSOCacheEntry {
		i64 u0x7fc88f1bd5db9c3e, ; from name: libaot-System.Runtime.Serialization.Primitives.so
		i64 u0xbd30caec9108afc1, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.192_name, ; name: libaot-System.Runtime.Serialization.Primitives.dll.so
		ptr null; void* handle
	}, ; 963
	%struct.DSOCacheEntry {
		i64 u0x7fd75077141d6658, ; from name: Microsoft.AspNetCore.Authorization.Policy
		i64 u0x4d16f4a17e081b1e, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.23_name, ; name: libaot-Microsoft.AspNetCore.Authorization.Policy.dll.so
		ptr null; void* handle
	}, ; 964
	%struct.DSOCacheEntry {
		i64 u0x7feafaeaaa627797, ; from name: libaot-Xamarin.AndroidX.DrawerLayout
		i64 u0x4bea014989424a56, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.112_name, ; name: libaot-Xamarin.AndroidX.DrawerLayout.dll.so
		ptr null; void* handle
	}, ; 965
	%struct.DSOCacheEntry {
		i64 u0x800dd28c71d7ee1d, ; from name: libaot-System.Collections.NonGeneric.so
		i64 u0x6fd15fb6a42c9afc, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.137_name, ; name: libaot-System.Collections.NonGeneric.dll.so
		ptr null; void* handle
	}, ; 966
	%struct.DSOCacheEntry {
		i64 u0x8020eb4ea0e9611b, ; from name: SocialMediaMaui.Shared.so
		i64 u0x12448631a200ce9a, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.10_name, ; name: libaot-SocialMediaMaui.Shared.dll.so
		ptr null; void* handle
	}, ; 967
	%struct.DSOCacheEntry {
		i64 u0x80f1973d3a1b588d, ; from name: aot-Microsoft.EntityFrameworkCore.so
		i64 u0x9694080faa394553, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.46_name, ; name: libaot-Microsoft.EntityFrameworkCore.dll.so
		ptr null; void* handle
	}, ; 968
	%struct.DSOCacheEntry {
		i64 u0x80f26a6b9b0a23cb, ; from name: aot-System.Text.Encoding.Extensions
		i64 u0xf89ed8fc2f5b4b33, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.206_name, ; name: libaot-System.Text.Encoding.Extensions.dll.so
		ptr null; void* handle
	}, ; 969
	%struct.DSOCacheEntry {
		i64 u0x80fa55b6d1b0be99, ; from name: SQLitePCLRaw.provider.e_sqlite3
		i64 u0xa5a20228c07e96ff, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.88_name, ; name: libaot-SQLitePCLRaw.provider.e_sqlite3.dll.so
		ptr null; void* handle
	}, ; 970
	%struct.DSOCacheEntry {
		i64 u0x8103076f09f20b43, ; from name: aot-Microsoft.Extensions.Diagnostics.so
		i64 u0xd34809bcacf156ee, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.57_name, ; name: libaot-Microsoft.Extensions.Diagnostics.dll.so
		ptr null; void* handle
	}, ; 971
	%struct.DSOCacheEntry {
		i64 u0x81119bd638dcee05, ; from name: libaot-Xamarin.Google.Android.Material
		i64 u0x937abea3fe5296af, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.128_name, ; name: libaot-Xamarin.Google.Android.Material.dll.so
		ptr null; void* handle
	}, ; 972
	%struct.DSOCacheEntry {
		i64 u0x811e0efc0e57d069, ; from name: libaot-Xamarin.KotlinX.Coroutines.Core.Jvm.dll.so
		i64 u0x811e0efc0e57d069, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.130_name, ; name: libaot-Xamarin.KotlinX.Coroutines.Core.Jvm.dll.so
		ptr null; void* handle
	}, ; 973
	%struct.DSOCacheEntry {
		i64 u0x8120a471d1efc091, ; from name: aot-System.Runtime.Serialization.Xml
		i64 u0xeb52548b17e702c6, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.193_name, ; name: libaot-System.Runtime.Serialization.Xml.dll.so
		ptr null; void* handle
	}, ; 974
	%struct.DSOCacheEntry {
		i64 u0x81881ac73f19d6e5, ; from name: System.Diagnostics.Tracing.dll.so
		i64 u0x28371251d401372b, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.150_name, ; name: libaot-System.Diagnostics.Tracing.dll.so
		ptr null; void* handle
	}, ; 975
	%struct.DSOCacheEntry {
		i64 u0x8196d5842b8a075e, ; from name: Microsoft.Extensions.Diagnostics.Abstractions.dll.so
		i64 u0xd10bb63f997c45a2, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.58_name, ; name: libaot-Microsoft.Extensions.Diagnostics.Abstractions.dll.so
		ptr null; void* handle
	}, ; 976
	%struct.DSOCacheEntry {
		i64 u0x81a26c71e1894b3e, ; from name: Microsoft.EntityFrameworkCore.so
		i64 u0x9694080faa394553, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.46_name, ; name: libaot-Microsoft.EntityFrameworkCore.dll.so
		ptr null; void* handle
	}, ; 977
	%struct.DSOCacheEntry {
		i64 u0x81ae5161ef344a32, ; from name: System.Numerics.Vectors.dll.so
		i64 u0x37fbdff3aa18872d, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.176_name, ; name: libaot-System.Numerics.Vectors.dll.so
		ptr null; void* handle
	}, ; 978
	%struct.DSOCacheEntry {
		i64 u0x8207bd5fd4488d4f, ; from name: libaot-Microsoft.Win32.Primitives.so
		i64 u0x6f3638b02afc00cc, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.133_name, ; name: libaot-Microsoft.Win32.Primitives.dll.so
		ptr null; void* handle
	}, ; 979
	%struct.DSOCacheEntry {
		i64 u0x821f528a92d55dea, ; from name: libaot-Azure.Core.dll.so
		i64 u0x821f528a92d55dea, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.12_name, ; name: libaot-Azure.Core.dll.so
		ptr null; void* handle
	}, ; 980
	%struct.DSOCacheEntry {
		i64 u0x822aa49008112ebe, ; from name: Microsoft.Extensions.ObjectPool
		i64 u0xa951cdbe6a05ef83, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.64_name, ; name: libaot-Microsoft.Extensions.ObjectPool.dll.so
		ptr null; void* handle
	}, ; 981
	%struct.DSOCacheEntry {
		i64 u0x823af1c93e519784, ; from name: libaot-System.Xml.XDocument.dll.so
		i64 u0x823af1c93e519784, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.219_name, ; name: libaot-System.Xml.XDocument.dll.so
		ptr null; void* handle
	}, ; 982
	%struct.DSOCacheEntry {
		i64 u0x825b78cb157ba9fe, ; from name: aot-Xamarin.AndroidX.ViewPager.so
		i64 u0xb5351dcbaf438cb6, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.126_name, ; name: libaot-Xamarin.AndroidX.ViewPager.dll.so
		ptr null; void* handle
	}, ; 983
	%struct.DSOCacheEntry {
		i64 u0x8277f2be6b5ce05f, ; from name: Xamarin.AndroidX.AppCompat
		i64 u0x42c7eb0880ff24a4, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.103_name, ; name: libaot-Xamarin.AndroidX.AppCompat.dll.so
		ptr null; void* handle
	}, ; 984
	%struct.DSOCacheEntry {
		i64 u0x82a2e2148ec96b41, ; from name: libaot-System.Linq.so
		i64 u0x2fb7a3952b307fae, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.162_name, ; name: libaot-System.Linq.dll.so
		ptr null; void* handle
	}, ; 985
	%struct.DSOCacheEntry {
		i64 u0x82a5e22b35324b28, ; from name: Syncfusion.Maui.ImageEditor.dll.so
		i64 u0x70f8ca2f11ec3669, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.91_name, ; name: libaot-Syncfusion.Maui.ImageEditor.dll.so
		ptr null; void* handle
	}, ; 986
	%struct.DSOCacheEntry {
		i64 u0x82b65efc7b0bc50f, ; from name: libaot-Microsoft.Extensions.FileProviders.Abstractions.dll.so
		i64 u0x82b65efc7b0bc50f, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.60_name, ; name: libaot-Microsoft.Extensions.FileProviders.Abstractions.dll.so
		ptr null; void* handle
	}, ; 987
	%struct.DSOCacheEntry {
		i64 u0x8346579d67a9d489, ; from name: aot-Azure.Core
		i64 u0x821f528a92d55dea, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.12_name, ; name: libaot-Azure.Core.dll.so
		ptr null; void* handle
	}, ; 988
	%struct.DSOCacheEntry {
		i64 u0x83a73aa9a520d52c, ; from name: aot-DocumentFormat.OpenXml.Framework.dll.so
		i64 u0xf959815fea0ec361, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.18_name, ; name: libaot-DocumentFormat.OpenXml.Framework.dll.so
		ptr null; void* handle
	}, ; 989
	%struct.DSOCacheEntry {
		i64 u0x83c0903aa890e2d6, ; from name: aot-System.Data.Common.so
		i64 u0x426a5e4ee84b386c, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.145_name, ; name: libaot-System.Data.Common.dll.so
		ptr null; void* handle
	}, ; 990
	%struct.DSOCacheEntry {
		i64 u0x83eb046987bae724, ; from name: Microsoft.Bcl.AsyncInterfaces.so
		i64 u0x9b7e93363193afd3, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.44_name, ; name: libaot-Microsoft.Bcl.AsyncInterfaces.dll.so
		ptr null; void* handle
	}, ; 991
	%struct.DSOCacheEntry {
		i64 u0x846f52335a832137, ; from name: Microsoft.Extensions.Features
		i64 u0xaebd3af6eeceb1eb, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.59_name, ; name: libaot-Microsoft.Extensions.Features.dll.so
		ptr null; void* handle
	}, ; 992
	%struct.DSOCacheEntry {
		i64 u0x8489bdbefca80cf7, ; from name: libaot-Microsoft.AspNetCore.Hosting.Abstractions
		i64 u0x8e5050b380b35b28, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.25_name, ; name: libaot-Microsoft.AspNetCore.Hosting.Abstractions.dll.so
		ptr null; void* handle
	}, ; 993
	%struct.DSOCacheEntry {
		i64 u0x84a855406853f510, ; from name: aot-System.IO.Compression
		i64 u0x07869dd1c492a791, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.155_name, ; name: libaot-System.IO.Compression.dll.so
		ptr null; void* handle
	}, ; 994
	%struct.DSOCacheEntry {
		i64 u0x84bb91257f7a6c6d, ; from name: Microsoft.Extensions.DependencyInjection.dll.so
		i64 u0xe8726752705c8ce9, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.54_name, ; name: libaot-Microsoft.Extensions.DependencyInjection.dll.so
		ptr null; void* handle
	}, ; 995
	%struct.DSOCacheEntry {
		i64 u0x84bd9c19df9a9d23, ; from name: System.Security.AccessControl.dll.so
		i64 u0x69dd3c9ffb9c24cd, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.195_name, ; name: libaot-System.Security.AccessControl.dll.so
		ptr null; void* handle
	}, ; 996
	%struct.DSOCacheEntry {
		i64 u0x84cf027e9ce632fa, ; from name: libaot-mscorlib.so
		i64 u0xd45fa2873eb303d5, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.222_name, ; name: libaot-mscorlib.dll.so
		ptr null; void* handle
	}, ; 997
	%struct.DSOCacheEntry {
		i64 u0x84f20950c4c7164b, ; from name: Microsoft.AspNetCore.Http
		i64 u0x6caedb1d96a79293, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.27_name, ; name: libaot-Microsoft.AspNetCore.Http.dll.so
		ptr null; void* handle
	}, ; 998
	%struct.DSOCacheEntry {
		i64 u0x8506adc22bb03c84, ; from name: Microsoft.Extensions.Logging.Abstractions.dll.so
		i64 u0xe6757a5fac324e53, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.63_name, ; name: libaot-Microsoft.Extensions.Logging.Abstractions.dll.so
		ptr null; void* handle
	}, ; 999
	%struct.DSOCacheEntry {
		i64 u0x8532df22d4a7f8dc, ; from name: System.ComponentModel.TypeConverter.dll.so
		i64 u0xcb7e41356728fd07, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.142_name, ; name: libaot-System.ComponentModel.TypeConverter.dll.so
		ptr null; void* handle
	}, ; 1000
	%struct.DSOCacheEntry {
		i64 u0x8542ec4b81a63264, ; from name: Refit.dll.so
		i64 u0x00a2ced568899a5e, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.83_name, ; name: libaot-Refit.dll.so
		ptr null; void* handle
	}, ; 1001
	%struct.DSOCacheEntry {
		i64 u0x8549e5e8920dcdd4, ; from name: libaot-Microsoft.AspNetCore.Authorization.Policy
		i64 u0x4d16f4a17e081b1e, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.23_name, ; name: libaot-Microsoft.AspNetCore.Authorization.Policy.dll.so
		ptr null; void* handle
	}, ; 1002
	%struct.DSOCacheEntry {
		i64 u0x8584a5172bd7d8bc, ; from name: Xamarin.AndroidX.Lifecycle.LiveData.Core.so
		i64 u0x38e4553d8764fa45, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.115_name, ; name: libaot-Xamarin.AndroidX.Lifecycle.LiveData.Core.dll.so
		ptr null; void* handle
	}, ; 1003
	%struct.DSOCacheEntry {
		i64 u0x8588c27c4ab35aae, ; from name: aot-System.Text.Encodings.Web.so
		i64 u0x209bcec5b3b022b8, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.207_name, ; name: libaot-System.Text.Encodings.Web.dll.so
		ptr null; void* handle
	}, ; 1004
	%struct.DSOCacheEntry {
		i64 u0x858cd519f13e3ea3, ; from name: aot-System.Security.Cryptography
		i64 u0xd0e82017367ac826, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.203_name, ; name: libaot-System.Security.Cryptography.dll.so
		ptr null; void* handle
	}, ; 1005
	%struct.DSOCacheEntry {
		i64 u0x859eafb521e1bf54, ; from name: libaot-System.Reflection.Primitives
		i64 u0x8c58bd1a08c146f5, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.185_name, ; name: libaot-System.Reflection.Primitives.dll.so
		ptr null; void* handle
	}, ; 1006
	%struct.DSOCacheEntry {
		i64 u0x85d66236b68f8b71, ; from name: libaot-System.Net.WebClient
		i64 u0x4ce9b13ddea58a1b, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.172_name, ; name: libaot-System.Net.WebClient.dll.so
		ptr null; void* handle
	}, ; 1007
	%struct.DSOCacheEntry {
		i64 u0x85dab7cad5f9d52a, ; from name: libaot-System.IO.Compression.Brotli.so
		i64 u0x7b22585c66d48a81, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.154_name, ; name: libaot-System.IO.Compression.Brotli.dll.so
		ptr null; void* handle
	}, ; 1008
	%struct.DSOCacheEntry {
		i64 u0x860313b837fc40ac, ; from name: System.Transactions.Local.dll.so
		i64 u0x5425eb433f599bc7, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.215_name, ; name: libaot-System.Transactions.Local.dll.so
		ptr null; void* handle
	}, ; 1009
	%struct.DSOCacheEntry {
		i64 u0x860cdf6da4b8d17f, ; from name: System.Security.AccessControl.so
		i64 u0x69dd3c9ffb9c24cd, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.195_name, ; name: libaot-System.Security.AccessControl.dll.so
		ptr null; void* handle
	}, ; 1010
	%struct.DSOCacheEntry {
		i64 u0x861ed7bf3f639730, ; from name: aot-System.Security.Principal.Windows.so
		i64 u0x29629cd3c238a2b4, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.204_name, ; name: libaot-System.Security.Principal.Windows.dll.so
		ptr null; void* handle
	}, ; 1011
	%struct.DSOCacheEntry {
		i64 u0x8636d45a3b98cdf7, ; from name: Syncfusion.Maui.ImageEditor
		i64 u0x70f8ca2f11ec3669, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.91_name, ; name: libaot-Syncfusion.Maui.ImageEditor.dll.so
		ptr null; void* handle
	}, ; 1012
	%struct.DSOCacheEntry {
		i64 u0x8657799bb82e0573, ; from name: libaot-System.Diagnostics.Process.dll.so
		i64 u0x8657799bb82e0573, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.147_name, ; name: libaot-System.Diagnostics.Process.dll.so
		ptr null; void* handle
	}, ; 1013
	%struct.DSOCacheEntry {
		i64 u0x868be26aba2eea6d, ; from name: libaot-System.Reflection.Emit.dll.so
		i64 u0x868be26aba2eea6d, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.184_name, ; name: libaot-System.Reflection.Emit.dll.so
		ptr null; void* handle
	}, ; 1014
	%struct.DSOCacheEntry {
		i64 u0x86abe3b01b43e43e, ; from name: libaot-CommunityToolkit.Maui.so
		i64 u0x71a72d2d998e2673, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.14_name, ; name: libaot-CommunityToolkit.Maui.dll.so
		ptr null; void* handle
	}, ; 1015
	%struct.DSOCacheEntry {
		i64 u0x86b62cb077ec4fd7, ; from name: System.Runtime.Serialization.Xml
		i64 u0xeb52548b17e702c6, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.193_name, ; name: libaot-System.Runtime.Serialization.Xml.dll.so
		ptr null; void* handle
	}, ; 1016
	%struct.DSOCacheEntry {
		i64 u0x86d3204bb2eb12c0, ; from name: aot-System.Reflection.Emit.ILGeneration
		i64 u0xbba986a49febf640, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.182_name, ; name: libaot-System.Reflection.Emit.ILGeneration.dll.so
		ptr null; void* handle
	}, ; 1017
	%struct.DSOCacheEntry {
		i64 u0x86ff945e422694f9, ; from name: libaot-System.Security.Cryptography.X509Certificates.dll.so
		i64 u0x86ff945e422694f9, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.202_name, ; name: libaot-System.Security.Cryptography.X509Certificates.dll.so
		ptr null; void* handle
	}, ; 1018
	%struct.DSOCacheEntry {
		i64 u0x8714f909546cdb5a, ; from name: aot-Xamarin.AndroidX.AppCompat.AppCompatResources.dll.so
		i64 u0x456e37cd491657b0, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.104_name, ; name: libaot-Xamarin.AndroidX.AppCompat.AppCompatResources.dll.so
		ptr null; void* handle
	}, ; 1019
	%struct.DSOCacheEntry {
		i64 u0x87206c2745e86bfc, ; from name: Microsoft.Extensions.DependencyModel.dll.so
		i64 u0x42c08831b421dece, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.56_name, ; name: libaot-Microsoft.Extensions.DependencyModel.dll.so
		ptr null; void* handle
	}, ; 1020
	%struct.DSOCacheEntry {
		i64 u0x8721821ed8968a78, ; from name: libaot-System.Diagnostics.StackTrace.so
		i64 u0xb21e783430e22a93, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.148_name, ; name: libaot-System.Diagnostics.StackTrace.dll.so
		ptr null; void* handle
	}, ; 1021
	%struct.DSOCacheEntry {
		i64 u0x87532963d7155867, ; from name: aot-System.Memory
		i64 u0xad582851e7d05243, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.163_name, ; name: libaot-System.Memory.dll.so
		ptr null; void* handle
	}, ; 1022
	%struct.DSOCacheEntry {
		i64 u0x876afda186003b2c, ; from name: aot-System.Private.Xml.Linq
		i64 u0x99ef7518b4544507, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.180_name, ; name: libaot-System.Private.Xml.Linq.dll.so
		ptr null; void* handle
	}, ; 1023
	%struct.DSOCacheEntry {
		i64 u0x878fe59536ab97c3, ; from name: libaot-System.Threading.Channels.so
		i64 u0x59aee0bc92ee07e3, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.210_name, ; name: libaot-System.Threading.Channels.dll.so
		ptr null; void* handle
	}, ; 1024
	%struct.DSOCacheEntry {
		i64 u0x87a46533394114bc, ; from name: libaot-System.Private.Xml.Linq.so
		i64 u0x99ef7518b4544507, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.180_name, ; name: libaot-System.Private.Xml.Linq.dll.so
		ptr null; void* handle
	}, ; 1025
	%struct.DSOCacheEntry {
		i64 u0x87a4f6a24a3cad9d, ; from name: aot-System.Formats.Asn1
		i64 u0x4a9bda0e8528b414, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.153_name, ; name: libaot-System.Formats.Asn1.dll.so
		ptr null; void* handle
	}, ; 1026
	%struct.DSOCacheEntry {
		i64 u0x87c4b8a492b176ad, ; from name: Microsoft.EntityFrameworkCore.Abstractions
		i64 u0x98d96e0f4341bc32, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.47_name, ; name: libaot-Microsoft.EntityFrameworkCore.Abstractions.dll.so
		ptr null; void* handle
	}, ; 1027
	%struct.DSOCacheEntry {
		i64 u0x87e71d68120b9580, ; from name: aot-Java.Interop.dll.so
		i64 u0x6ce045494a545eab, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.224_name, ; name: libaot-Java.Interop.dll.so
		ptr null; void* handle
	}, ; 1028
	%struct.DSOCacheEntry {
		i64 u0x87fc13318b10bda8, ; from name: libaot-Refit.HttpClientFactory.so
		i64 u0xbf4b844c69db6ec0, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.84_name, ; name: libaot-Refit.HttpClientFactory.dll.so
		ptr null; void* handle
	}, ; 1029
	%struct.DSOCacheEntry {
		i64 u0x882524d1bd9ad3bf, ; from name: libaot-System.Security.Cryptography.X509Certificates.so
		i64 u0x86ff945e422694f9, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.202_name, ; name: libaot-System.Security.Cryptography.X509Certificates.dll.so
		ptr null; void* handle
	}, ; 1030
	%struct.DSOCacheEntry {
		i64 u0x8842b3a5d2d3fb36, ; from name: Microsoft.Maui.Essentials
		i64 u0xdc3ba4771239be2d, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.78_name, ; name: libaot-Microsoft.Maui.Essentials.dll.so
		ptr null; void* handle
	}, ; 1031
	%struct.DSOCacheEntry {
		i64 u0x884ca78516a55666, ; from name: aot-System.IO.Pipelines.so
		i64 u0x027079cd6cbb2479, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.158_name, ; name: libaot-System.IO.Pipelines.dll.so
		ptr null; void* handle
	}, ; 1032
	%struct.DSOCacheEntry {
		i64 u0x8915d6eea348fe49, ; from name: libaot-Microsoft.Extensions.Configuration.Abstractions.so
		i64 u0xd6a1ce9f7ccd35cb, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.53_name, ; name: libaot-Microsoft.Extensions.Configuration.Abstractions.dll.so
		ptr null; void* handle
	}, ; 1033
	%struct.DSOCacheEntry {
		i64 u0x891c0e3e96c57379, ; from name: aot-System.Net.WebSockets
		i64 u0x403cd01c6fb39d89, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.175_name, ; name: libaot-System.Net.WebSockets.dll.so
		ptr null; void* handle
	}, ; 1034
	%struct.DSOCacheEntry {
		i64 u0x8930322c7bd8f768, ; from name: netstandard
		i64 u0xb6ab21527197f7f1, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.223_name, ; name: libaot-netstandard.dll.so
		ptr null; void* handle
	}, ; 1035
	%struct.DSOCacheEntry {
		i64 u0x89613433a5741fe7, ; from name: System.Drawing.dll.so
		i64 u0x366c3ed8a6266ffb, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.152_name, ; name: libaot-System.Drawing.dll.so
		ptr null; void* handle
	}, ; 1036
	%struct.DSOCacheEntry {
		i64 u0x89819731ab18abdf, ; from name: aot-Syncfusion.Maui.Toolkit.resources.dll.so
		i64 u0xa56606bb1f125004, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.94_name, ; name: libaot-Syncfusion.Maui.Toolkit.resources.dll.so
		ptr null; void* handle
	}, ; 1037
	%struct.DSOCacheEntry {
		i64 u0x89c94e0be2db3a34, ; from name: aot-Azure.Identity
		i64 u0xf309d7d68dc0ac48, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.13_name, ; name: libaot-Azure.Identity.dll.so
		ptr null; void* handle
	}, ; 1038
	%struct.DSOCacheEntry {
		i64 u0x89c9595aeecca3fc, ; from name: libaot-System.IO.Compression.so
		i64 u0x07869dd1c492a791, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.155_name, ; name: libaot-System.IO.Compression.dll.so
		ptr null; void* handle
	}, ; 1039
	%struct.DSOCacheEntry {
		i64 u0x8a01f254b2076350, ; from name: Syncfusion.Maui.Toolkit.resources.dll.so
		i64 u0xa56606bb1f125004, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.94_name, ; name: libaot-Syncfusion.Maui.Toolkit.resources.dll.so
		ptr null; void* handle
	}, ; 1040
	%struct.DSOCacheEntry {
		i64 u0x8a05820e9e77c0c3, ; from name: libaot-Xamarin.AndroidX.Activity.dll.so
		i64 u0x8a05820e9e77c0c3, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.102_name, ; name: libaot-Xamarin.AndroidX.Activity.dll.so
		ptr null; void* handle
	}, ; 1041
	%struct.DSOCacheEntry {
		i64 u0x8a399a706fcbce4b, ; from name: Microsoft.Extensions.Caching.Abstractions
		i64 u0x988026893039cd51, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.50_name, ; name: libaot-Microsoft.Extensions.Caching.Abstractions.dll.so
		ptr null; void* handle
	}, ; 1042
	%struct.DSOCacheEntry {
		i64 u0x8a3f010c5541c553, ; from name: System.Net.Http.Json.so
		i64 u0x36547dc653fb83c1, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.164_name, ; name: libaot-System.Net.Http.Json.dll.so
		ptr null; void* handle
	}, ; 1043
	%struct.DSOCacheEntry {
		i64 u0x8aa238a08da31f37, ; from name: System.Text.Json.so
		i64 u0x9bb35aa4bcef7b80, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.208_name, ; name: libaot-System.Text.Json.dll.so
		ptr null; void* handle
	}, ; 1044
	%struct.DSOCacheEntry {
		i64 u0x8aa449f043f26734, ; from name: System.Security.Cryptography.Csp.dll.so
		i64 u0xb259133b67649ff8, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.199_name, ; name: libaot-System.Security.Cryptography.Csp.dll.so
		ptr null; void* handle
	}, ; 1045
	%struct.DSOCacheEntry {
		i64 u0x8ab573a2f264ef6e, ; from name: libaot-Java.Interop
		i64 u0x6ce045494a545eab, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.224_name, ; name: libaot-Java.Interop.dll.so
		ptr null; void* handle
	}, ; 1046
	%struct.DSOCacheEntry {
		i64 u0x8ab6d3431da5497e, ; from name: libaot-Xamarin.AndroidX.Fragment.dll.so
		i64 u0x8ab6d3431da5497e, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.113_name, ; name: libaot-Xamarin.AndroidX.Fragment.dll.so
		ptr null; void* handle
	}, ; 1047
	%struct.DSOCacheEntry {
		i64 u0x8ac8d025b93e29e9, ; from name: Syncfusion.Licensing
		i64 u0xe0ba2b05be11dec6, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.89_name, ; name: libaot-Syncfusion.Licensing.dll.so
		ptr null; void* handle
	}, ; 1048
	%struct.DSOCacheEntry {
		i64 u0x8ace3d5d42a90acd, ; from name: aot-System.Runtime.Caching.so
		i64 u0x9a1f1aedbdf3f019, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.100_name, ; name: libaot-System.Runtime.Caching.dll.so
		ptr null; void* handle
	}, ; 1049
	%struct.DSOCacheEntry {
		i64 u0x8ad229ea26432ee2, ; from name: Xamarin.AndroidX.Loader
		i64 u0x74b0aefe8f467d50, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.118_name, ; name: libaot-Xamarin.AndroidX.Loader.dll.so
		ptr null; void* handle
	}, ; 1050
	%struct.DSOCacheEntry {
		i64 u0x8af5b19594f00d30, ; from name: libaot-Microsoft.AspNetCore.SignalR.Client
		i64 u0xb9619c5bddc1c8f4, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.38_name, ; name: libaot-Microsoft.AspNetCore.SignalR.Client.dll.so
		ptr null; void* handle
	}, ; 1051
	%struct.DSOCacheEntry {
		i64 u0x8b06991f459cf97b, ; from name: System.IO.Compression.so
		i64 u0x07869dd1c492a791, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.155_name, ; name: libaot-System.IO.Compression.dll.so
		ptr null; void* handle
	}, ; 1052
	%struct.DSOCacheEntry {
		i64 u0x8b541d476eb3774c, ; from name: System.Security.Principal.Windows
		i64 u0x29629cd3c238a2b4, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.204_name, ; name: libaot-System.Security.Principal.Windows.dll.so
		ptr null; void* handle
	}, ; 1053
	%struct.DSOCacheEntry {
		i64 u0x8b6114df08f5d8c7, ; from name: libaot-Microsoft.AspNetCore.Routing
		i64 u0x6872149aac83968a, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.36_name, ; name: libaot-Microsoft.AspNetCore.Routing.dll.so
		ptr null; void* handle
	}, ; 1054
	%struct.DSOCacheEntry {
		i64 u0x8b6737c4464ef9c9, ; from name: aot-System.Collections.Specialized
		i64 u0x355b66670e6bf2e4, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.138_name, ; name: libaot-System.Collections.Specialized.dll.so
		ptr null; void* handle
	}, ; 1055
	%struct.DSOCacheEntry {
		i64 u0x8b79f0c76c8538fd, ; from name: System.Security.Principal.Windows.so
		i64 u0x29629cd3c238a2b4, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.204_name, ; name: libaot-System.Security.Principal.Windows.dll.so
		ptr null; void* handle
	}, ; 1056
	%struct.DSOCacheEntry {
		i64 u0x8bdde98d31c34948, ; from name: libaot-Xamarin.AndroidX.Lifecycle.Common.Jvm.so
		i64 u0x2ec8d2dcf2c4a71b, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.114_name, ; name: libaot-Xamarin.AndroidX.Lifecycle.Common.Jvm.dll.so
		ptr null; void* handle
	}, ; 1057
	%struct.DSOCacheEntry {
		i64 u0x8be59e13bb5a337c, ; from name: aot-System.Net.WebSockets.so
		i64 u0x403cd01c6fb39d89, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.175_name, ; name: libaot-System.Net.WebSockets.dll.so
		ptr null; void* handle
	}, ; 1058
	%struct.DSOCacheEntry {
		i64 u0x8be639a423b6d017, ; from name: libaot-Microsoft.AspNetCore.Mvc.Abstractions.dll.so
		i64 u0x8be639a423b6d017, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.33_name, ; name: libaot-Microsoft.AspNetCore.Mvc.Abstractions.dll.so
		ptr null; void* handle
	}, ; 1059
	%struct.DSOCacheEntry {
		i64 u0x8bf1793fcfacff91, ; from name: aot-Microsoft.Extensions.DependencyModel.so
		i64 u0x42c08831b421dece, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.56_name, ; name: libaot-Microsoft.Extensions.DependencyModel.dll.so
		ptr null; void* handle
	}, ; 1060
	%struct.DSOCacheEntry {
		i64 u0x8c1da76084515ed9, ; from name: aot-System.Threading.ThreadPool
		i64 u0x7d7a84dcff7fdb59, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.213_name, ; name: libaot-System.Threading.ThreadPool.dll.so
		ptr null; void* handle
	}, ; 1061
	%struct.DSOCacheEntry {
		i64 u0x8c53ae18581b14f0, ; from name: Azure.Core
		i64 u0x821f528a92d55dea, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.12_name, ; name: libaot-Azure.Core.dll.so
		ptr null; void* handle
	}, ; 1062
	%struct.DSOCacheEntry {
		i64 u0x8c5723e53b1143d3, ; from name: libaot-SQLitePCLRaw.lib.e_sqlite3.android.so
		i64 u0x6a03b775044080b2, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.87_name, ; name: libaot-SQLitePCLRaw.lib.e_sqlite3.android.dll.so
		ptr null; void* handle
	}, ; 1063
	%struct.DSOCacheEntry {
		i64 u0x8c575135aa1ccef4, ; from name: Microsoft.Extensions.FileProviders.Abstractions
		i64 u0x82b65efc7b0bc50f, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.60_name, ; name: libaot-Microsoft.Extensions.FileProviders.Abstractions.dll.so
		ptr null; void* handle
	}, ; 1064
	%struct.DSOCacheEntry {
		i64 u0x8c58bd1a08c146f5, ; from name: libaot-System.Reflection.Primitives.dll.so
		i64 u0x8c58bd1a08c146f5, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.185_name, ; name: libaot-System.Reflection.Primitives.dll.so
		ptr null; void* handle
	}, ; 1065
	%struct.DSOCacheEntry {
		i64 u0x8c7e3176acf15364, ; from name: libaot-System.Reflection.Emit.ILGeneration
		i64 u0xbba986a49febf640, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.182_name, ; name: libaot-System.Reflection.Emit.ILGeneration.dll.so
		ptr null; void* handle
	}, ; 1066
	%struct.DSOCacheEntry {
		i64 u0x8caf78efaf45c305, ; from name: Xamarin.AndroidX.Lifecycle.ViewModelSavedState.dll.so
		i64 u0x9b809dc726e0140e, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.117_name, ; name: libaot-Xamarin.AndroidX.Lifecycle.ViewModelSavedState.dll.so
		ptr null; void* handle
	}, ; 1067
	%struct.DSOCacheEntry {
		i64 u0x8ce5133f826f156c, ; from name: aot-Xamarin.AndroidX.ViewPager2.dll.so
		i64 u0x4595d9c27242b287, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.127_name, ; name: libaot-Xamarin.AndroidX.ViewPager2.dll.so
		ptr null; void* handle
	}, ; 1068
	%struct.DSOCacheEntry {
		i64 u0x8d311eaba088f02f, ; from name: aot-Xamarin.AndroidX.Lifecycle.ViewModel.Android.dll.so
		i64 u0xc06034423c0d320f, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.116_name, ; name: libaot-Xamarin.AndroidX.Lifecycle.ViewModel.Android.dll.so
		ptr null; void* handle
	}, ; 1069
	%struct.DSOCacheEntry {
		i64 u0x8d5dd3ece1774de5, ; from name: System.Security.Claims.so
		i64 u0xd1ca18d995b9f417, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.196_name, ; name: libaot-System.Security.Claims.dll.so
		ptr null; void* handle
	}, ; 1070
	%struct.DSOCacheEntry {
		i64 u0x8d5f431bf67cc907, ; from name: SocialMediaMaui.Shared
		i64 u0x12448631a200ce9a, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.10_name, ; name: libaot-SocialMediaMaui.Shared.dll.so
		ptr null; void* handle
	}, ; 1071
	%struct.DSOCacheEntry {
		i64 u0x8d7b8ab4b3310ead, ; from name: System.Threading
		i64 u0x5f435aa7f5fde870, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.214_name, ; name: libaot-System.Threading.dll.so
		ptr null; void* handle
	}, ; 1072
	%struct.DSOCacheEntry {
		i64 u0x8da188285aadfe8e, ; from name: System.Collections.Concurrent
		i64 u0x65cd21401fecc3dc, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.135_name, ; name: libaot-System.Collections.Concurrent.dll.so
		ptr null; void* handle
	}, ; 1073
	%struct.DSOCacheEntry {
		i64 u0x8dfc8e7ddc866e85, ; from name: aot-System.ComponentModel.Annotations
		i64 u0xbf7d944f85fcd72c, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.140_name, ; name: libaot-System.ComponentModel.Annotations.dll.so
		ptr null; void* handle
	}, ; 1074
	%struct.DSOCacheEntry {
		i64 u0x8e1c0d0116b3ef4b, ; from name: libaot-Syncfusion.Maui.Sliders.dll.so
		i64 u0x8e1c0d0116b3ef4b, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.92_name, ; name: libaot-Syncfusion.Maui.Sliders.dll.so
		ptr null; void* handle
	}, ; 1075
	%struct.DSOCacheEntry {
		i64 u0x8e5050b380b35b28, ; from name: libaot-Microsoft.AspNetCore.Hosting.Abstractions.dll.so
		i64 u0x8e5050b380b35b28, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.25_name, ; name: libaot-Microsoft.AspNetCore.Hosting.Abstractions.dll.so
		ptr null; void* handle
	}, ; 1076
	%struct.DSOCacheEntry {
		i64 u0x8e7bcc98607276e4, ; from name: System.Collections.Concurrent.dll.so
		i64 u0x65cd21401fecc3dc, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.135_name, ; name: libaot-System.Collections.Concurrent.dll.so
		ptr null; void* handle
	}, ; 1077
	%struct.DSOCacheEntry {
		i64 u0x8eb518d6d33034be, ; from name: aot-Refit.HttpClientFactory.so
		i64 u0xbf4b844c69db6ec0, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.84_name, ; name: libaot-Refit.HttpClientFactory.dll.so
		ptr null; void* handle
	}, ; 1078
	%struct.DSOCacheEntry {
		i64 u0x8ed807bfe9858dfc, ; from name: Xamarin.AndroidX.Navigation.Common
		i64 u0x2ba3b197006b7954, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.119_name, ; name: libaot-Xamarin.AndroidX.Navigation.Common.dll.so
		ptr null; void* handle
	}, ; 1079
	%struct.DSOCacheEntry {
		i64 u0x8ef807d846707ba0, ; from name: aot-CommunityToolkit.Maui.Core
		i64 u0x1f7f7b0e04fbedb0, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.15_name, ; name: libaot-CommunityToolkit.Maui.Core.dll.so
		ptr null; void* handle
	}, ; 1080
	%struct.DSOCacheEntry {
		i64 u0x8f4b9a8c2c37695c, ; from name: aot-System.Net.Http.Json
		i64 u0x36547dc653fb83c1, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.164_name, ; name: libaot-System.Net.Http.Json.dll.so
		ptr null; void* handle
	}, ; 1081
	%struct.DSOCacheEntry {
		i64 u0x8f9a00b264ea8d22, ; from name: Microsoft.AspNetCore.WebUtilities.so
		i64 u0xa1fa4ded3d9c2cee, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.43_name, ; name: libaot-Microsoft.AspNetCore.WebUtilities.dll.so
		ptr null; void* handle
	}, ; 1082
	%struct.DSOCacheEntry {
		i64 u0x8f9cbb0d8be607ae, ; from name: aot-Microsoft.Extensions.DependencyInjection.so
		i64 u0xe8726752705c8ce9, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.54_name, ; name: libaot-Microsoft.Extensions.DependencyInjection.dll.so
		ptr null; void* handle
	}, ; 1083
	%struct.DSOCacheEntry {
		i64 u0x8fa52587768c02e7, ; from name: libaot-System.Private.DataContractSerialization.dll.so
		i64 u0x8fa52587768c02e7, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.178_name, ; name: libaot-System.Private.DataContractSerialization.dll.so
		ptr null; void* handle
	}, ; 1084
	%struct.DSOCacheEntry {
		i64 u0x8fd27d934d7b3a55, ; from name: SQLitePCLRaw.core
		i64 u0x110f85ed0e988dad, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.86_name, ; name: libaot-SQLitePCLRaw.core.dll.so
		ptr null; void* handle
	}, ; 1085
	%struct.DSOCacheEntry {
		i64 u0x900c844fa701040b, ; from name: aot-System.Net.NameResolution.dll.so
		i64 u0x7f280e9be5453eba, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.166_name, ; name: libaot-System.Net.NameResolution.dll.so
		ptr null; void* handle
	}, ; 1086
	%struct.DSOCacheEntry {
		i64 u0x90165fc5d6da6d5e, ; from name: aot-Xamarin.AndroidX.AppCompat.AppCompatResources
		i64 u0x456e37cd491657b0, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.104_name, ; name: libaot-Xamarin.AndroidX.AppCompat.AppCompatResources.dll.so
		ptr null; void* handle
	}, ; 1087
	%struct.DSOCacheEntry {
		i64 u0x903101b46fb73a04, ; from name: _Microsoft.Android.Resource.Designer
		i64 u0x9cbca1c74026e295, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.9_name, ; name: libaot-_Microsoft.Android.Resource.Designer.dll.so
		ptr null; void* handle
	}, ; 1088
	%struct.DSOCacheEntry {
		i64 u0x9037f9d64d16c443, ; from name: libaot-Microsoft.IdentityModel.Protocols.dll.so
		i64 u0x9037f9d64d16c443, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.72_name, ; name: libaot-Microsoft.IdentityModel.Protocols.dll.so
		ptr null; void* handle
	}, ; 1089
	%struct.DSOCacheEntry {
		i64 u0x903f32820b4c6f10, ; from name: aot-Syncfusion.Maui.Toolkit.resources
		i64 u0xa56606bb1f125004, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.94_name, ; name: libaot-Syncfusion.Maui.Toolkit.resources.dll.so
		ptr null; void* handle
	}, ; 1090
	%struct.DSOCacheEntry {
		i64 u0x90634f86c5ebe2b5, ; from name: Xamarin.AndroidX.Lifecycle.ViewModel.Android
		i64 u0xc06034423c0d320f, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.116_name, ; name: libaot-Xamarin.AndroidX.Lifecycle.ViewModel.Android.dll.so
		ptr null; void* handle
	}, ; 1091
	%struct.DSOCacheEntry {
		i64 u0x9074a5999bae75fc, ; from name: aot-System.Drawing.Primitives.dll.so
		i64 u0x934cbfda9b40e895, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.151_name, ; name: libaot-System.Drawing.Primitives.dll.so
		ptr null; void* handle
	}, ; 1092
	%struct.DSOCacheEntry {
		i64 u0x90874572fa920b19, ; from name: aot-System.Private.Xml.Linq.dll.so
		i64 u0x99ef7518b4544507, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.180_name, ; name: libaot-System.Private.Xml.Linq.dll.so
		ptr null; void* handle
	}, ; 1093
	%struct.DSOCacheEntry {
		i64 u0x90d9aa4c8cd014aa, ; from name: libaot-System.IO.Pipelines
		i64 u0x027079cd6cbb2479, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.158_name, ; name: libaot-System.IO.Pipelines.dll.so
		ptr null; void* handle
	}, ; 1094
	%struct.DSOCacheEntry {
		i64 u0x90ff1426bb7baacc, ; from name: libaot-System.Xml.Linq
		i64 u0xe89b56c5a60687e6, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.217_name, ; name: libaot-System.Xml.Linq.dll.so
		ptr null; void* handle
	}, ; 1095
	%struct.DSOCacheEntry {
		i64 u0x9138e616d89ed404, ; from name: aot-System.Xml.XDocument
		i64 u0x823af1c93e519784, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.219_name, ; name: libaot-System.Xml.XDocument.dll.so
		ptr null; void* handle
	}, ; 1096
	%struct.DSOCacheEntry {
		i64 u0x914167d87d2ee1b1, ; from name: libaot-System.ObjectModel.dll.so
		i64 u0x914167d87d2ee1b1, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.177_name, ; name: libaot-System.ObjectModel.dll.so
		ptr null; void* handle
	}, ; 1097
	%struct.DSOCacheEntry {
		i64 u0x91956ff1daa9687e, ; from name: libaot-Microsoft.Maui.Essentials
		i64 u0xdc3ba4771239be2d, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.78_name, ; name: libaot-Microsoft.Maui.Essentials.dll.so
		ptr null; void* handle
	}, ; 1098
	%struct.DSOCacheEntry {
		i64 u0x91bc907fb816ccff, ; from name: aot-SQLitePCLRaw.batteries_v2.so
		i64 u0x418d89fb2901d219, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.85_name, ; name: libaot-SQLitePCLRaw.batteries_v2.dll.so
		ptr null; void* handle
	}, ; 1099
	%struct.DSOCacheEntry {
		i64 u0x91d3ce88c87781b2, ; from name: System.Xml.ReaderWriter.dll.so
		i64 u0xdfabadcf47a52f12, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.218_name, ; name: libaot-System.Xml.ReaderWriter.dll.so
		ptr null; void* handle
	}, ; 1100
	%struct.DSOCacheEntry {
		i64 u0x9257ffaf6fffebcf, ; from name: System.Threading.Channels.so
		i64 u0x59aee0bc92ee07e3, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.210_name, ; name: libaot-System.Threading.Channels.dll.so
		ptr null; void* handle
	}, ; 1101
	%struct.DSOCacheEntry {
		i64 u0x9272f5045b8e273f, ; from name: aot-System.Net.WebSockets.Client.so
		i64 u0x0a18b49bebc33444, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.174_name, ; name: libaot-System.Net.WebSockets.Client.dll.so
		ptr null; void* handle
	}, ; 1102
	%struct.DSOCacheEntry {
		i64 u0x92dd6c6033393bf7, ; from name: Syncfusion.Maui.Toolkit.resources
		i64 u0xa56606bb1f125004, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.94_name, ; name: libaot-Syncfusion.Maui.Toolkit.resources.dll.so
		ptr null; void* handle
	}, ; 1103
	%struct.DSOCacheEntry {
		i64 u0x92e48325d1d30923, ; from name: Syncfusion.Maui.ImageEditor.so
		i64 u0x70f8ca2f11ec3669, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.91_name, ; name: libaot-Syncfusion.Maui.ImageEditor.dll.so
		ptr null; void* handle
	}, ; 1104
	%struct.DSOCacheEntry {
		i64 u0x92f59b0322cb246d, ; from name: System.Security.Principal.Windows.dll.so
		i64 u0x29629cd3c238a2b4, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.204_name, ; name: libaot-System.Security.Principal.Windows.dll.so
		ptr null; void* handle
	}, ; 1105
	%struct.DSOCacheEntry {
		i64 u0x930e6d6d72275658, ; from name: libaot-Xamarin.AndroidX.Navigation.Runtime.so
		i64 u0x79a319cd6e76a263, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.121_name, ; name: libaot-Xamarin.AndroidX.Navigation.Runtime.dll.so
		ptr null; void* handle
	}, ; 1106
	%struct.DSOCacheEntry {
		i64 u0x931e912b2d26be8b, ; from name: aot-Syncfusion.Maui.Core
		i64 u0x4cfc586bcbdc6c97, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.90_name, ; name: libaot-Syncfusion.Maui.Core.dll.so
		ptr null; void* handle
	}, ; 1107
	%struct.DSOCacheEntry {
		i64 u0x933c13d587fd4708, ; from name: aot-System.Collections.Specialized.so
		i64 u0x355b66670e6bf2e4, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.138_name, ; name: libaot-System.Collections.Specialized.dll.so
		ptr null; void* handle
	}, ; 1108
	%struct.DSOCacheEntry {
		i64 u0x9345748e3d9d87ff, ; from name: libaot-System.Linq.Expressions.so
		i64 u0xda1d7acd827eb320, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.160_name, ; name: libaot-System.Linq.Expressions.dll.so
		ptr null; void* handle
	}, ; 1109
	%struct.DSOCacheEntry {
		i64 u0x9346f1515a08cf4b, ; from name: DocumentFormat.OpenXml.VariableReplacer.Core.so
		i64 u0x785bad4f0559c250, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.19_name, ; name: libaot-DocumentFormat.OpenXml.VariableReplacer.Core.dll.so
		ptr null; void* handle
	}, ; 1110
	%struct.DSOCacheEntry {
		i64 u0x934cbfda9b40e895, ; from name: libaot-System.Drawing.Primitives.dll.so
		i64 u0x934cbfda9b40e895, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.151_name, ; name: libaot-System.Drawing.Primitives.dll.so
		ptr null; void* handle
	}, ; 1111
	%struct.DSOCacheEntry {
		i64 u0x937abea3fe5296af, ; from name: libaot-Xamarin.Google.Android.Material.dll.so
		i64 u0x937abea3fe5296af, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.128_name, ; name: libaot-Xamarin.Google.Android.Material.dll.so
		ptr null; void* handle
	}, ; 1112
	%struct.DSOCacheEntry {
		i64 u0x937c9e550da0827b, ; from name: aot-System.Data.Common.dll.so
		i64 u0x426a5e4ee84b386c, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.145_name, ; name: libaot-System.Data.Common.dll.so
		ptr null; void* handle
	}, ; 1113
	%struct.DSOCacheEntry {
		i64 u0x93b2bf77d26dbbcf, ; from name: Xamarin.AndroidX.Lifecycle.LiveData.Core.dll.so
		i64 u0x38e4553d8764fa45, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.115_name, ; name: libaot-Xamarin.AndroidX.Lifecycle.LiveData.Core.dll.so
		ptr null; void* handle
	}, ; 1114
	%struct.DSOCacheEntry {
		i64 u0x93d2678ac2e76ce0, ; from name: libaot-Microsoft.AspNetCore.Authorization.dll.so
		i64 u0x93d2678ac2e76ce0, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.22_name, ; name: libaot-Microsoft.AspNetCore.Authorization.dll.so
		ptr null; void* handle
	}, ; 1115
	%struct.DSOCacheEntry {
		i64 u0x93e4c54304a2e819, ; from name: libaot-System.Collections.Concurrent.so
		i64 u0x65cd21401fecc3dc, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.135_name, ; name: libaot-System.Collections.Concurrent.dll.so
		ptr null; void* handle
	}, ; 1116
	%struct.DSOCacheEntry {
		i64 u0x93f228fe901325a2, ; from name: libaot-System.Security.Cryptography.Algorithms.so
		i64 u0xd9a989573240dd9c, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.197_name, ; name: libaot-System.Security.Cryptography.Algorithms.dll.so
		ptr null; void* handle
	}, ; 1117
	%struct.DSOCacheEntry {
		i64 u0x9421414b56719ccd, ; from name: libaot-System.Reflection.Emit.ILGeneration.so
		i64 u0xbba986a49febf640, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.182_name, ; name: libaot-System.Reflection.Emit.ILGeneration.dll.so
		ptr null; void* handle
	}, ; 1118
	%struct.DSOCacheEntry {
		i64 u0x94215d4984079316, ; from name: System.Threading.Tasks.Extensions.so
		i64 u0x51aad7b1eaf4d2ae, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.211_name, ; name: libaot-System.Threading.Tasks.Extensions.dll.so
		ptr null; void* handle
	}, ; 1119
	%struct.DSOCacheEntry {
		i64 u0x942500f27fed8175, ; from name: libaot-Microsoft.SqlServer.Server
		i64 u0x7b4f94432c52afad, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.81_name, ; name: libaot-Microsoft.SqlServer.Server.dll.so
		ptr null; void* handle
	}, ; 1120
	%struct.DSOCacheEntry {
		i64 u0x9436f688a2526dff, ; from name: aot-Microsoft.AspNetCore.Hosting.Abstractions.dll.so
		i64 u0x8e5050b380b35b28, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.25_name, ; name: libaot-Microsoft.AspNetCore.Hosting.Abstractions.dll.so
		ptr null; void* handle
	}, ; 1121
	%struct.DSOCacheEntry {
		i64 u0x94395e785fdfa801, ; from name: aot-Microsoft.AspNetCore.WebUtilities.so
		i64 u0xa1fa4ded3d9c2cee, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.43_name, ; name: libaot-Microsoft.AspNetCore.WebUtilities.dll.so
		ptr null; void* handle
	}, ; 1122
	%struct.DSOCacheEntry {
		i64 u0x945436fe733eac24, ; from name: libaot-System.Net.Primitives
		i64 u0xaac4801194f87f4f, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.168_name, ; name: libaot-System.Net.Primitives.dll.so
		ptr null; void* handle
	}, ; 1123
	%struct.DSOCacheEntry {
		i64 u0x94576e001670739d, ; from name: libaot-System.Xml.XDocument
		i64 u0x823af1c93e519784, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.219_name, ; name: libaot-System.Xml.XDocument.dll.so
		ptr null; void* handle
	}, ; 1124
	%struct.DSOCacheEntry {
		i64 u0x945930f6eadb03da, ; from name: aot-Microsoft.AspNetCore.ResponseCaching.Abstractions.dll.so
		i64 u0x2eb68ca0cc467150, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.35_name, ; name: libaot-Microsoft.AspNetCore.ResponseCaching.Abstractions.dll.so
		ptr null; void* handle
	}, ; 1125
	%struct.DSOCacheEntry {
		i64 u0x9487c01f29d1b46b, ; from name: aot-Microsoft.AspNetCore.Connections.Abstractions.dll.so
		i64 u0xb92f532b40f35614, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.24_name, ; name: libaot-Microsoft.AspNetCore.Connections.Abstractions.dll.so
		ptr null; void* handle
	}, ; 1126
	%struct.DSOCacheEntry {
		i64 u0x94c36bd34f077936, ; from name: System.Private.Uri.dll.so
		i64 u0xe57af9ab00f5c61d, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.179_name, ; name: libaot-System.Private.Uri.dll.so
		ptr null; void* handle
	}, ; 1127
	%struct.DSOCacheEntry {
		i64 u0x94d27340300f66da, ; from name: aot-Microsoft.AspNetCore.Http.Abstractions.so
		i64 u0x96d2838521668c05, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.28_name, ; name: libaot-Microsoft.AspNetCore.Http.Abstractions.dll.so
		ptr null; void* handle
	}, ; 1128
	%struct.DSOCacheEntry {
		i64 u0x94dc416043aa28a5, ; from name: libaot-Microsoft.IdentityModel.Logging
		i64 u0x1175872aaf2edbfe, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.71_name, ; name: libaot-Microsoft.IdentityModel.Logging.dll.so
		ptr null; void* handle
	}, ; 1129
	%struct.DSOCacheEntry {
		i64 u0x94f58b52e536e8a3, ; from name: aot-Microsoft.Extensions.DependencyInjection.Abstractions
		i64 u0x4643d8f925d8e6b7, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.55_name, ; name: libaot-Microsoft.Extensions.DependencyInjection.Abstractions.dll.so
		ptr null; void* handle
	}, ; 1130
	%struct.DSOCacheEntry {
		i64 u0x9500d2d4e74dba2b, ; from name: libaot-Microsoft.AspNetCore.ResponseCaching.Abstractions
		i64 u0x2eb68ca0cc467150, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.35_name, ; name: libaot-Microsoft.AspNetCore.ResponseCaching.Abstractions.dll.so
		ptr null; void* handle
	}, ; 1131
	%struct.DSOCacheEntry {
		i64 u0x9527948cf7bb1991, ; from name: libaot-System.Threading.so
		i64 u0x5f435aa7f5fde870, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.214_name, ; name: libaot-System.Threading.dll.so
		ptr null; void* handle
	}, ; 1132
	%struct.DSOCacheEntry {
		i64 u0x95302b4a91a9ea47, ; from name: libaot-System.Net.ServerSentEvents.dll.so
		i64 u0x95302b4a91a9ea47, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.99_name, ; name: libaot-System.Net.ServerSentEvents.dll.so
		ptr null; void* handle
	}, ; 1133
	%struct.DSOCacheEntry {
		i64 u0x956232299e2dca42, ; from name: libaot-Microsoft.IdentityModel.JsonWebTokens
		i64 u0x0323e786c13d309d, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.70_name, ; name: libaot-Microsoft.IdentityModel.JsonWebTokens.dll.so
		ptr null; void* handle
	}, ; 1134
	%struct.DSOCacheEntry {
		i64 u0x956f26e96f96282b, ; from name: Mono.Android.Runtime.so
		i64 u0x156ae2b2e8a39884, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.225_name, ; name: libaot-Mono.Android.Runtime.dll.so
		ptr null; void* handle
	}, ; 1135
	%struct.DSOCacheEntry {
		i64 u0x95c87e08b3529dda, ; from name: aot-System.Security.Cryptography.Algorithms.so
		i64 u0xd9a989573240dd9c, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.197_name, ; name: libaot-System.Security.Cryptography.Algorithms.dll.so
		ptr null; void* handle
	}, ; 1136
	%struct.DSOCacheEntry {
		i64 u0x95ccfe1d9785405e, ; from name: aot-Xamarin.Kotlin.StdLib
		i64 u0x0c644d6a2b020c43, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.129_name, ; name: libaot-Xamarin.Kotlin.StdLib.dll.so
		ptr null; void* handle
	}, ; 1137
	%struct.DSOCacheEntry {
		i64 u0x95d1b04e08afdac9, ; from name: aot-Microsoft.Extensions.Primitives.dll.so
		i64 u0x9df2f15d2ed44e61, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.66_name, ; name: libaot-Microsoft.Extensions.Primitives.dll.so
		ptr null; void* handle
	}, ; 1138
	%struct.DSOCacheEntry {
		i64 u0x95ed0349cb4cb979, ; from name: System.Text.RegularExpressions.so
		i64 u0x7c2c39dae387b52d, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.209_name, ; name: libaot-System.Text.RegularExpressions.dll.so
		ptr null; void* handle
	}, ; 1139
	%struct.DSOCacheEntry {
		i64 u0x95f0ac6bcefe3d78, ; from name: aot-CommunityToolkit.Mvvm.dll.so
		i64 u0x324cedd7271c2c92, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.16_name, ; name: libaot-CommunityToolkit.Mvvm.dll.so
		ptr null; void* handle
	}, ; 1140
	%struct.DSOCacheEntry {
		i64 u0x962235ca61ea2173, ; from name: System.Xml.XDocument.dll.so
		i64 u0x823af1c93e519784, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.219_name, ; name: libaot-System.Xml.XDocument.dll.so
		ptr null; void* handle
	}, ; 1141
	%struct.DSOCacheEntry {
		i64 u0x963ee8bdd5b1c36f, ; from name: Xamarin.AndroidX.Activity.dll.so
		i64 u0x8a05820e9e77c0c3, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.102_name, ; name: libaot-Xamarin.AndroidX.Activity.dll.so
		ptr null; void* handle
	}, ; 1142
	%struct.DSOCacheEntry {
		i64 u0x96753d66e2619fc0, ; from name: aot-System.Security.Cryptography.dll.so
		i64 u0xd0e82017367ac826, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.203_name, ; name: libaot-System.Security.Cryptography.dll.so
		ptr null; void* handle
	}, ; 1143
	%struct.DSOCacheEntry {
		i64 u0x9681b5f892affe6c, ; from name: aot-CommunityToolkit.Maui
		i64 u0x71a72d2d998e2673, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.14_name, ; name: libaot-CommunityToolkit.Maui.dll.so
		ptr null; void* handle
	}, ; 1144
	%struct.DSOCacheEntry {
		i64 u0x968f35ac325b8151, ; from name: System.Reflection.Emit.ILGeneration.so
		i64 u0xbba986a49febf640, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.182_name, ; name: libaot-System.Reflection.Emit.ILGeneration.dll.so
		ptr null; void* handle
	}, ; 1145
	%struct.DSOCacheEntry {
		i64 u0x9694080faa394553, ; from name: libaot-Microsoft.EntityFrameworkCore.dll.so
		i64 u0x9694080faa394553, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.46_name, ; name: libaot-Microsoft.EntityFrameworkCore.dll.so
		ptr null; void* handle
	}, ; 1146
	%struct.DSOCacheEntry {
		i64 u0x96a4d6184eccecde, ; from name: libaot-Microsoft.Extensions.Diagnostics.so
		i64 u0xd34809bcacf156ee, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.57_name, ; name: libaot-Microsoft.Extensions.Diagnostics.dll.so
		ptr null; void* handle
	}, ; 1147
	%struct.DSOCacheEntry {
		i64 u0x96d2838521668c05, ; from name: libaot-Microsoft.AspNetCore.Http.Abstractions.dll.so
		i64 u0x96d2838521668c05, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.28_name, ; name: libaot-Microsoft.AspNetCore.Http.Abstractions.dll.so
		ptr null; void* handle
	}, ; 1148
	%struct.DSOCacheEntry {
		i64 u0x96e49b31fe33d427, ; from name: Microsoft.Identity.Client.Extensions.Msal
		i64 u0x9b88d00d863a5143, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.68_name, ; name: libaot-Microsoft.Identity.Client.Extensions.Msal.dll.so
		ptr null; void* handle
	}, ; 1149
	%struct.DSOCacheEntry {
		i64 u0x9706fc81d36c21c0, ; from name: aot-Microsoft.Maui.Essentials
		i64 u0xdc3ba4771239be2d, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.78_name, ; name: libaot-Microsoft.Maui.Essentials.dll.so
		ptr null; void* handle
	}, ; 1150
	%struct.DSOCacheEntry {
		i64 u0x970b8275af07721c, ; from name: System.Runtime.Serialization.Xml.so
		i64 u0xeb52548b17e702c6, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.193_name, ; name: libaot-System.Runtime.Serialization.Xml.dll.so
		ptr null; void* handle
	}, ; 1151
	%struct.DSOCacheEntry {
		i64 u0x970c8672bfd02cd0, ; from name: System.Threading.ThreadPool.dll.so
		i64 u0x7d7a84dcff7fdb59, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.213_name, ; name: libaot-System.Threading.ThreadPool.dll.so
		ptr null; void* handle
	}, ; 1152
	%struct.DSOCacheEntry {
		i64 u0x974407ee353a91bf, ; from name: libaot-Xamarin.Kotlin.StdLib.so
		i64 u0x0c644d6a2b020c43, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.129_name, ; name: libaot-Xamarin.Kotlin.StdLib.dll.so
		ptr null; void* handle
	}, ; 1153
	%struct.DSOCacheEntry {
		i64 u0x97529a82db270486, ; from name: aot-System.Runtime.InteropServices.dll.so
		i64 u0x5ae6db1ddadc230b, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.187_name, ; name: libaot-System.Runtime.InteropServices.dll.so
		ptr null; void* handle
	}, ; 1154
	%struct.DSOCacheEntry {
		i64 u0x9779a7876628f915, ; from name: aot-System.ComponentModel.Primitives
		i64 u0xccde8a4563eee10b, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.141_name, ; name: libaot-System.ComponentModel.Primitives.dll.so
		ptr null; void* handle
	}, ; 1155
	%struct.DSOCacheEntry {
		i64 u0x97854c52d5b4ef12, ; from name: aot-System.Security.Claims
		i64 u0xd1ca18d995b9f417, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.196_name, ; name: libaot-System.Security.Claims.dll.so
		ptr null; void* handle
	}, ; 1156
	%struct.DSOCacheEntry {
		i64 u0x9793febe657f5b29, ; from name: libaot-Microsoft.Extensions.DependencyInjection
		i64 u0xe8726752705c8ce9, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.54_name, ; name: libaot-Microsoft.Extensions.DependencyInjection.dll.so
		ptr null; void* handle
	}, ; 1157
	%struct.DSOCacheEntry {
		i64 u0x98477fddf5618a23, ; from name: SQLitePCLRaw.provider.e_sqlite3.so
		i64 u0xa5a20228c07e96ff, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.88_name, ; name: libaot-SQLitePCLRaw.provider.e_sqlite3.dll.so
		ptr null; void* handle
	}, ; 1158
	%struct.DSOCacheEntry {
		i64 u0x984a5bf1c8ad2a21, ; from name: libaot-System.Runtime.so
		i64 u0xbbc0e6e747d7877a, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.194_name, ; name: libaot-System.Runtime.dll.so
		ptr null; void* handle
	}, ; 1159
	%struct.DSOCacheEntry {
		i64 u0x9860f1c3075e6adc, ; from name: aot-Microsoft.CSharp.dll.so
		i64 u0xe38bfeec71b3b67d, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.132_name, ; name: libaot-Microsoft.CSharp.dll.so
		ptr null; void* handle
	}, ; 1160
	%struct.DSOCacheEntry {
		i64 u0x9865c0bf349d1465, ; from name: libaot-Xamarin.AndroidX.Browser.dll.so
		i64 u0x9865c0bf349d1465, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.105_name, ; name: libaot-Xamarin.AndroidX.Browser.dll.so
		ptr null; void* handle
	}, ; 1161
	%struct.DSOCacheEntry {
		i64 u0x988026893039cd51, ; from name: libaot-Microsoft.Extensions.Caching.Abstractions.dll.so
		i64 u0x988026893039cd51, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.50_name, ; name: libaot-Microsoft.Extensions.Caching.Abstractions.dll.so
		ptr null; void* handle
	}, ; 1162
	%struct.DSOCacheEntry {
		i64 u0x98834bb0d43301d2, ; from name: aot-System.Collections.Concurrent.dll.so
		i64 u0x65cd21401fecc3dc, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.135_name, ; name: libaot-System.Collections.Concurrent.dll.so
		ptr null; void* handle
	}, ; 1163
	%struct.DSOCacheEntry {
		i64 u0x9894cc04ddb732f3, ; from name: Xamarin.AndroidX.Collection.Jvm.dll.so
		i64 u0x1adc5c3038254713, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.107_name, ; name: libaot-Xamarin.AndroidX.Collection.Jvm.dll.so
		ptr null; void* handle
	}, ; 1164
	%struct.DSOCacheEntry {
		i64 u0x98a12871f8647716, ; from name: libaot-System.Runtime.InteropServices.RuntimeInformation
		i64 u0x6aae90d5594500a9, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.186_name, ; name: libaot-System.Runtime.InteropServices.RuntimeInformation.dll.so
		ptr null; void* handle
	}, ; 1165
	%struct.DSOCacheEntry {
		i64 u0x98a8c89b58a933bc, ; from name: libaot-Xamarin.AndroidX.CoordinatorLayout
		i64 u0x5cc157f14ad19fc0, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.108_name, ; name: libaot-Xamarin.AndroidX.CoordinatorLayout.dll.so
		ptr null; void* handle
	}, ; 1166
	%struct.DSOCacheEntry {
		i64 u0x98ba904da6358519, ; from name: libaot-Xamarin.AndroidX.DrawerLayout.so
		i64 u0x4bea014989424a56, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.112_name, ; name: libaot-Xamarin.AndroidX.DrawerLayout.dll.so
		ptr null; void* handle
	}, ; 1167
	%struct.DSOCacheEntry {
		i64 u0x98d03d6045943a7a, ; from name: System.Private.DataContractSerialization.so
		i64 u0x8fa52587768c02e7, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.178_name, ; name: libaot-System.Private.DataContractSerialization.dll.so
		ptr null; void* handle
	}, ; 1168
	%struct.DSOCacheEntry {
		i64 u0x98d96e0f4341bc32, ; from name: libaot-Microsoft.EntityFrameworkCore.Abstractions.dll.so
		i64 u0x98d96e0f4341bc32, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.47_name, ; name: libaot-Microsoft.EntityFrameworkCore.Abstractions.dll.so
		ptr null; void* handle
	}, ; 1169
	%struct.DSOCacheEntry {
		i64 u0x98e80e2cab6466ce, ; from name: Microsoft.AspNetCore.Http.Features.so
		i64 u0x621c21d9c3290da0, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.32_name, ; name: libaot-Microsoft.AspNetCore.Http.Features.dll.so
		ptr null; void* handle
	}, ; 1170
	%struct.DSOCacheEntry {
		i64 u0x98eaf0e33c1e8cd4, ; from name: libaot-Syncfusion.Maui.Toolkit
		i64 u0x2d6521795fa92605, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.93_name, ; name: libaot-Syncfusion.Maui.Toolkit.dll.so
		ptr null; void* handle
	}, ; 1171
	%struct.DSOCacheEntry {
		i64 u0x98f2b8ece52151ac, ; from name: aot-System.Runtime.InteropServices.RuntimeInformation
		i64 u0x6aae90d5594500a9, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.186_name, ; name: libaot-System.Runtime.InteropServices.RuntimeInformation.dll.so
		ptr null; void* handle
	}, ; 1172
	%struct.DSOCacheEntry {
		i64 u0x991d510397f92d9d, ; from name: System.Linq.Expressions
		i64 u0xda1d7acd827eb320, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.160_name, ; name: libaot-System.Linq.Expressions.dll.so
		ptr null; void* handle
	}, ; 1173
	%struct.DSOCacheEntry {
		i64 u0x9926fe4735a19436, ; from name: System.Security.Claims.dll.so
		i64 u0xd1ca18d995b9f417, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.196_name, ; name: libaot-System.Security.Claims.dll.so
		ptr null; void* handle
	}, ; 1174
	%struct.DSOCacheEntry {
		i64 u0x994b3e79d87be8c6, ; from name: Microsoft.AspNetCore.Http.Extensions.so
		i64 u0xf01d9d74cda0b70d, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.31_name, ; name: libaot-Microsoft.AspNetCore.Http.Extensions.dll.so
		ptr null; void* handle
	}, ; 1175
	%struct.DSOCacheEntry {
		i64 u0x9951ebda72b82022, ; from name: Xamarin.AndroidX.RecyclerView.dll.so
		i64 u0x34c6f5c746796bcc, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.123_name, ; name: libaot-Xamarin.AndroidX.RecyclerView.dll.so
		ptr null; void* handle
	}, ; 1176
	%struct.DSOCacheEntry {
		i64 u0x99671311da670a34, ; from name: libaot-DocumentFormat.OpenXml.so
		i64 u0x456cc421e6ef3bb7, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.17_name, ; name: libaot-DocumentFormat.OpenXml.dll.so
		ptr null; void* handle
	}, ; 1177
	%struct.DSOCacheEntry {
		i64 u0x9985d21e978d7fa5, ; from name: aot-Microsoft.Net.Http.Headers.so
		i64 u0xa81dfd6455f2dc19, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.80_name, ; name: libaot-Microsoft.Net.Http.Headers.dll.so
		ptr null; void* handle
	}, ; 1178
	%struct.DSOCacheEntry {
		i64 u0x998bbae1857d9abb, ; from name: libaot-System.Xml.XmlSerializer
		i64 u0xdfef1aaab339ffdb, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.220_name, ; name: libaot-System.Xml.XmlSerializer.dll.so
		ptr null; void* handle
	}, ; 1179
	%struct.DSOCacheEntry {
		i64 u0x99a00ca5270c6878, ; from name: Xamarin.AndroidX.Navigation.Runtime
		i64 u0x79a319cd6e76a263, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.121_name, ; name: libaot-Xamarin.AndroidX.Navigation.Runtime.dll.so
		ptr null; void* handle
	}, ; 1180
	%struct.DSOCacheEntry {
		i64 u0x99d01882ba964688, ; from name: libaot-Xamarin.AndroidX.Navigation.Fragment.so
		i64 u0xaa2eca1145f3a7cc, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.120_name, ; name: libaot-Xamarin.AndroidX.Navigation.Fragment.dll.so
		ptr null; void* handle
	}, ; 1181
	%struct.DSOCacheEntry {
		i64 u0x99e783e6676e7adf, ; from name: System.Runtime.InteropServices.dll.so
		i64 u0x5ae6db1ddadc230b, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.187_name, ; name: libaot-System.Runtime.InteropServices.dll.so
		ptr null; void* handle
	}, ; 1182
	%struct.DSOCacheEntry {
		i64 u0x99ef7518b4544507, ; from name: libaot-System.Private.Xml.Linq.dll.so
		i64 u0x99ef7518b4544507, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.180_name, ; name: libaot-System.Private.Xml.Linq.dll.so
		ptr null; void* handle
	}, ; 1183
	%struct.DSOCacheEntry {
		i64 u0x99f1d8e435c33314, ; from name: libaot-System.Security.Cryptography.Primitives.so
		i64 u0x7d7dff41d9076267, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.201_name, ; name: libaot-System.Security.Cryptography.Primitives.dll.so
		ptr null; void* handle
	}, ; 1184
	%struct.DSOCacheEntry {
		i64 u0x9a1900dd6f709117, ; from name: aot-Xamarin.AndroidX.Lifecycle.ViewModelSavedState.so
		i64 u0x9b809dc726e0140e, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.117_name, ; name: libaot-Xamarin.AndroidX.Lifecycle.ViewModelSavedState.dll.so
		ptr null; void* handle
	}, ; 1185
	%struct.DSOCacheEntry {
		i64 u0x9a1f1958a14a59c2, ; from name: aot-Xamarin.AndroidX.CustomView.so
		i64 u0xe7b2e898b68d9670, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.111_name, ; name: libaot-Xamarin.AndroidX.CustomView.dll.so
		ptr null; void* handle
	}, ; 1186
	%struct.DSOCacheEntry {
		i64 u0x9a1f1aedbdf3f019, ; from name: libaot-System.Runtime.Caching.dll.so
		i64 u0x9a1f1aedbdf3f019, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.100_name, ; name: libaot-System.Runtime.Caching.dll.so
		ptr null; void* handle
	}, ; 1187
	%struct.DSOCacheEntry {
		i64 u0x9a6f648da172667e, ; from name: _Microsoft.Android.Resource.Designer.so
		i64 u0x9cbca1c74026e295, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.9_name, ; name: libaot-_Microsoft.Android.Resource.Designer.dll.so
		ptr null; void* handle
	}, ; 1188
	%struct.DSOCacheEntry {
		i64 u0x9a71b627c376523e, ; from name: libaot-System.Net.WebSockets.so
		i64 u0x403cd01c6fb39d89, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.175_name, ; name: libaot-System.Net.WebSockets.dll.so
		ptr null; void* handle
	}, ; 1189
	%struct.DSOCacheEntry {
		i64 u0x9a73701fc85247c4, ; from name: aot-System.Net.Security.dll.so
		i64 u0x1271045d1561acf0, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.170_name, ; name: libaot-System.Net.Security.dll.so
		ptr null; void* handle
	}, ; 1190
	%struct.DSOCacheEntry {
		i64 u0x9b0176cb40ddab04, ; from name: System.Text.Encodings.Web.so
		i64 u0x209bcec5b3b022b8, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.207_name, ; name: libaot-System.Text.Encodings.Web.dll.so
		ptr null; void* handle
	}, ; 1191
	%struct.DSOCacheEntry {
		i64 u0x9b211a749105beac, ; from name: System.Transactions.Local
		i64 u0x5425eb433f599bc7, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.215_name, ; name: libaot-System.Transactions.Local.dll.so
		ptr null; void* handle
	}, ; 1192
	%struct.DSOCacheEntry {
		i64 u0x9b4cfa8aedf49dc1, ; from name: libaot-System.Web.HttpUtility
		i64 u0xcdab467c6caa8aba, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.216_name, ; name: libaot-System.Web.HttpUtility.dll.so
		ptr null; void* handle
	}, ; 1193
	%struct.DSOCacheEntry {
		i64 u0x9b65e43ab423b17d, ; from name: Microsoft.IdentityModel.Tokens.so
		i64 u0x4be8f991cb00f075, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.74_name, ; name: libaot-Microsoft.IdentityModel.Tokens.dll.so
		ptr null; void* handle
	}, ; 1194
	%struct.DSOCacheEntry {
		i64 u0x9b6f0babce2a1934, ; from name: libaot-Microsoft.Extensions.Logging.dll.so
		i64 u0x9b6f0babce2a1934, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.62_name, ; name: libaot-Microsoft.Extensions.Logging.dll.so
		ptr null; void* handle
	}, ; 1195
	%struct.DSOCacheEntry {
		i64 u0x9b7e93363193afd3, ; from name: libaot-Microsoft.Bcl.AsyncInterfaces.dll.so
		i64 u0x9b7e93363193afd3, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.44_name, ; name: libaot-Microsoft.Bcl.AsyncInterfaces.dll.so
		ptr null; void* handle
	}, ; 1196
	%struct.DSOCacheEntry {
		i64 u0x9b809dc726e0140e, ; from name: libaot-Xamarin.AndroidX.Lifecycle.ViewModelSavedState.dll.so
		i64 u0x9b809dc726e0140e, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.117_name, ; name: libaot-Xamarin.AndroidX.Lifecycle.ViewModelSavedState.dll.so
		ptr null; void* handle
	}, ; 1197
	%struct.DSOCacheEntry {
		i64 u0x9b88d00d863a5143, ; from name: libaot-Microsoft.Identity.Client.Extensions.Msal.dll.so
		i64 u0x9b88d00d863a5143, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.68_name, ; name: libaot-Microsoft.Identity.Client.Extensions.Msal.dll.so
		ptr null; void* handle
	}, ; 1198
	%struct.DSOCacheEntry {
		i64 u0x9bb084ac816d8cf7, ; from name: libaot-System.Security.Principal.Windows.so
		i64 u0x29629cd3c238a2b4, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.204_name, ; name: libaot-System.Security.Principal.Windows.dll.so
		ptr null; void* handle
	}, ; 1199
	%struct.DSOCacheEntry {
		i64 u0x9bb35aa4bcef7b80, ; from name: libaot-System.Text.Json.dll.so
		i64 u0x9bb35aa4bcef7b80, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.208_name, ; name: libaot-System.Text.Json.dll.so
		ptr null; void* handle
	}, ; 1200
	%struct.DSOCacheEntry {
		i64 u0x9bf1a2a0e4c6893b, ; from name: Microsoft.AspNetCore.WebUtilities.dll.so
		i64 u0xa1fa4ded3d9c2cee, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.43_name, ; name: libaot-Microsoft.AspNetCore.WebUtilities.dll.so
		ptr null; void* handle
	}, ; 1201
	%struct.DSOCacheEntry {
		i64 u0x9bf9aa134960cb34, ; from name: aot-Microsoft.AspNetCore.Http.Connections.Client.dll.so
		i64 u0x14283e2d731a896b, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.29_name, ; name: libaot-Microsoft.AspNetCore.Http.Connections.Client.dll.so
		ptr null; void* handle
	}, ; 1202
	%struct.DSOCacheEntry {
		i64 u0x9bff349ef0a39889, ; from name: aot-System.Security.Cryptography.Cng.so
		i64 u0xe4a5a519ffe8b5e9, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.198_name, ; name: libaot-System.Security.Cryptography.Cng.dll.so
		ptr null; void* handle
	}, ; 1203
	%struct.DSOCacheEntry {
		i64 u0x9c452e2fa9b9a40d, ; from name: aot-Xamarin.AndroidX.CardView.dll.so
		i64 u0xe9e6021e6533eb43, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.106_name, ; name: libaot-Xamarin.AndroidX.CardView.dll.so
		ptr null; void* handle
	}, ; 1204
	%struct.DSOCacheEntry {
		i64 u0x9c4cccb2ca01329b, ; from name: aot-System.Private.DataContractSerialization.dll.so
		i64 u0x8fa52587768c02e7, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.178_name, ; name: libaot-System.Private.DataContractSerialization.dll.so
		ptr null; void* handle
	}, ; 1205
	%struct.DSOCacheEntry {
		i64 u0x9c56ef96bf7f6191, ; from name: aot-SocialMediaMaui.Shared.so
		i64 u0x12448631a200ce9a, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.10_name, ; name: libaot-SocialMediaMaui.Shared.dll.so
		ptr null; void* handle
	}, ; 1206
	%struct.DSOCacheEntry {
		i64 u0x9c6a931d47f799df, ; from name: libaot-SocialMauiApp
		i64 u0xec957d270d230c6a, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.11_name, ; name: libaot-SocialMauiApp.dll.so
		ptr null; void* handle
	}, ; 1207
	%struct.DSOCacheEntry {
		i64 u0x9c7333fd91b4c899, ; from name: aot-Xamarin.Google.Android.Material
		i64 u0x937abea3fe5296af, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.128_name, ; name: libaot-Xamarin.Google.Android.Material.dll.so
		ptr null; void* handle
	}, ; 1208
	%struct.DSOCacheEntry {
		i64 u0x9cb1c43c4eb0fdb7, ; from name: aot-Microsoft.AspNetCore.Authorization
		i64 u0x93d2678ac2e76ce0, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.22_name, ; name: libaot-Microsoft.AspNetCore.Authorization.dll.so
		ptr null; void* handle
	}, ; 1209
	%struct.DSOCacheEntry {
		i64 u0x9cbca1c74026e295, ; from name: libaot-_Microsoft.Android.Resource.Designer.dll.so
		i64 u0x9cbca1c74026e295, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.9_name, ; name: libaot-_Microsoft.Android.Resource.Designer.dll.so
		ptr null; void* handle
	}, ; 1210
	%struct.DSOCacheEntry {
		i64 u0x9cbd1d72a9e5192f, ; from name: System.Runtime.dll.so
		i64 u0xbbc0e6e747d7877a, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.194_name, ; name: libaot-System.Runtime.dll.so
		ptr null; void* handle
	}, ; 1211
	%struct.DSOCacheEntry {
		i64 u0x9cc738620fcfc47e, ; from name: System.Net.ServerSentEvents.dll.so
		i64 u0x95302b4a91a9ea47, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.99_name, ; name: libaot-System.Net.ServerSentEvents.dll.so
		ptr null; void* handle
	}, ; 1212
	%struct.DSOCacheEntry {
		i64 u0x9cea5e0cbd4be75e, ; from name: libaot-CommunityToolkit.Mvvm
		i64 u0x324cedd7271c2c92, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.16_name, ; name: libaot-CommunityToolkit.Mvvm.dll.so
		ptr null; void* handle
	}, ; 1213
	%struct.DSOCacheEntry {
		i64 u0x9d0042ccbe5d4e14, ; from name: libaot-Microsoft.AspNetCore.Hosting.Server.Abstractions.so
		i64 u0xdb28c2f2e5cda275, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.26_name, ; name: libaot-Microsoft.AspNetCore.Hosting.Server.Abstractions.dll.so
		ptr null; void* handle
	}, ; 1214
	%struct.DSOCacheEntry {
		i64 u0x9d6f8482240cff0c, ; from name: aot-System.Buffers.dll.so
		i64 u0x5988bd4997e5d75f, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.134_name, ; name: libaot-System.Buffers.dll.so
		ptr null; void* handle
	}, ; 1215
	%struct.DSOCacheEntry {
		i64 u0x9d756aef7fc1c15d, ; from name: libaot-Microsoft.EntityFrameworkCore.Abstractions
		i64 u0x98d96e0f4341bc32, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.47_name, ; name: libaot-Microsoft.EntityFrameworkCore.Abstractions.dll.so
		ptr null; void* handle
	}, ; 1216
	%struct.DSOCacheEntry {
		i64 u0x9d80e11c193a6064, ; from name: aot-Microsoft.AspNetCore.SignalR.Client
		i64 u0xb9619c5bddc1c8f4, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.38_name, ; name: libaot-Microsoft.AspNetCore.SignalR.Client.dll.so
		ptr null; void* handle
	}, ; 1217
	%struct.DSOCacheEntry {
		i64 u0x9d9f81003ac80c44, ; from name: libaot-Microsoft.AspNetCore.SignalR.Common
		i64 u0x1d711f330f5778d7, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.40_name, ; name: libaot-Microsoft.AspNetCore.SignalR.Common.dll.so
		ptr null; void* handle
	}, ; 1218
	%struct.DSOCacheEntry {
		i64 u0x9daa39a878308c98, ; from name: libaot-Microsoft.EntityFrameworkCore.SqlServer.dll.so
		i64 u0x9daa39a878308c98, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.49_name, ; name: libaot-Microsoft.EntityFrameworkCore.SqlServer.dll.so
		ptr null; void* handle
	}, ; 1219
	%struct.DSOCacheEntry {
		i64 u0x9db2edaccd419be3, ; from name: aot-Microsoft.Extensions.Caching.Abstractions.dll.so
		i64 u0x988026893039cd51, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.50_name, ; name: libaot-Microsoft.Extensions.Caching.Abstractions.dll.so
		ptr null; void* handle
	}, ; 1220
	%struct.DSOCacheEntry {
		i64 u0x9dc65adbed31ca8c, ; from name: libaot-SQLitePCLRaw.provider.e_sqlite3.so
		i64 u0xa5a20228c07e96ff, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.88_name, ; name: libaot-SQLitePCLRaw.provider.e_sqlite3.dll.so
		ptr null; void* handle
	}, ; 1221
	%struct.DSOCacheEntry {
		i64 u0x9ddd789d1d5b5ca0, ; from name: aot-System.Threading.ThreadPool.so
		i64 u0x7d7a84dcff7fdb59, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.213_name, ; name: libaot-System.Threading.ThreadPool.dll.so
		ptr null; void* handle
	}, ; 1222
	%struct.DSOCacheEntry {
		i64 u0x9dea7ba8a000dd35, ; from name: System.IO.Pipelines.so
		i64 u0x027079cd6cbb2479, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.158_name, ; name: libaot-System.IO.Pipelines.dll.so
		ptr null; void* handle
	}, ; 1223
	%struct.DSOCacheEntry {
		i64 u0x9df2f15d2ed44e61, ; from name: libaot-Microsoft.Extensions.Primitives.dll.so
		i64 u0x9df2f15d2ed44e61, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.66_name, ; name: libaot-Microsoft.Extensions.Primitives.dll.so
		ptr null; void* handle
	}, ; 1224
	%struct.DSOCacheEntry {
		i64 u0x9e4ca9df67dd848c, ; from name: aot-SQLitePCLRaw.provider.e_sqlite3
		i64 u0xa5a20228c07e96ff, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.88_name, ; name: libaot-SQLitePCLRaw.provider.e_sqlite3.dll.so
		ptr null; void* handle
	}, ; 1225
	%struct.DSOCacheEntry {
		i64 u0x9e603f29cff39c67, ; from name: Microsoft.AspNetCore.Connections.Abstractions.dll.so
		i64 u0xb92f532b40f35614, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.24_name, ; name: libaot-Microsoft.AspNetCore.Connections.Abstractions.dll.so
		ptr null; void* handle
	}, ; 1226
	%struct.DSOCacheEntry {
		i64 u0x9e9e2038eb544e5b, ; from name: aot-System.IdentityModel.Tokens.Jwt
		i64 u0xe05faae6d518aca9, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.97_name, ; name: libaot-System.IdentityModel.Tokens.Jwt.dll.so
		ptr null; void* handle
	}, ; 1227
	%struct.DSOCacheEntry {
		i64 u0x9eb4ae89ecef09f8, ; from name: System.Diagnostics.TraceSource.so
		i64 u0x2119cc81025daa05, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.149_name, ; name: libaot-System.Diagnostics.TraceSource.dll.so
		ptr null; void* handle
	}, ; 1228
	%struct.DSOCacheEntry {
		i64 u0x9ed669484281002d, ; from name: libaot-System.Net.Sockets.so
		i64 u0x4c5401149da6445e, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.171_name, ; name: libaot-System.Net.Sockets.dll.so
		ptr null; void* handle
	}, ; 1229
	%struct.DSOCacheEntry {
		i64 u0x9ef542cf1f78c506, ; from name: Xamarin.AndroidX.Lifecycle.LiveData.Core
		i64 u0x38e4553d8764fa45, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.115_name, ; name: libaot-Xamarin.AndroidX.Lifecycle.LiveData.Core.dll.so
		ptr null; void* handle
	}, ; 1230
	%struct.DSOCacheEntry {
		i64 u0x9f473a65f10d6fa9, ; from name: aot-System.Console
		i64 u0xc2da5dca6ccd8b0a, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.144_name, ; name: libaot-System.Console.dll.so
		ptr null; void* handle
	}, ; 1231
	%struct.DSOCacheEntry {
		i64 u0x9f8721d76200e75a, ; from name: aot-Microsoft.Identity.Client
		i64 u0xd20e64387a412094, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.67_name, ; name: libaot-Microsoft.Identity.Client.dll.so
		ptr null; void* handle
	}, ; 1232
	%struct.DSOCacheEntry {
		i64 u0x9fb1b80a436d9000, ; from name: libaot-System.Runtime.Serialization.Xml.so
		i64 u0xeb52548b17e702c6, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.193_name, ; name: libaot-System.Runtime.Serialization.Xml.dll.so
		ptr null; void* handle
	}, ; 1233
	%struct.DSOCacheEntry {
		i64 u0xa02ff542e6494fb2, ; from name: libaot-Microsoft.AspNetCore.Http.so
		i64 u0x6caedb1d96a79293, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.27_name, ; name: libaot-Microsoft.AspNetCore.Http.dll.so
		ptr null; void* handle
	}, ; 1234
	%struct.DSOCacheEntry {
		i64 u0xa04512de3dd78c3a, ; from name: libaot-System.Runtime.Caching.so
		i64 u0x9a1f1aedbdf3f019, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.100_name, ; name: libaot-System.Runtime.Caching.dll.so
		ptr null; void* handle
	}, ; 1235
	%struct.DSOCacheEntry {
		i64 u0xa05475503f80b7d9, ; from name: Microsoft.AspNetCore.Connections.Abstractions
		i64 u0xb92f532b40f35614, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.24_name, ; name: libaot-Microsoft.AspNetCore.Connections.Abstractions.dll.so
		ptr null; void* handle
	}, ; 1236
	%struct.DSOCacheEntry {
		i64 u0xa0b53a9f101d3b25, ; from name: libaot-System.Security.Principal.Windows
		i64 u0x29629cd3c238a2b4, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.204_name, ; name: libaot-System.Security.Principal.Windows.dll.so
		ptr null; void* handle
	}, ; 1237
	%struct.DSOCacheEntry {
		i64 u0xa0ef08db5fd0f914, ; from name: aot-System.Runtime.InteropServices.RuntimeInformation.so
		i64 u0x6aae90d5594500a9, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.186_name, ; name: libaot-System.Runtime.InteropServices.RuntimeInformation.dll.so
		ptr null; void* handle
	}, ; 1238
	%struct.DSOCacheEntry {
		i64 u0xa11d36f87c530f82, ; from name: libaot-System.IO.Pipelines.so
		i64 u0x027079cd6cbb2479, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.158_name, ; name: libaot-System.IO.Pipelines.dll.so
		ptr null; void* handle
	}, ; 1239
	%struct.DSOCacheEntry {
		i64 u0xa1440773ee9d341e, ; from name: Xamarin.Google.Android.Material
		i64 u0x937abea3fe5296af, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.128_name, ; name: libaot-Xamarin.Google.Android.Material.dll.so
		ptr null; void* handle
	}, ; 1240
	%struct.DSOCacheEntry {
		i64 u0xa1683c1b0c5cdacc, ; from name: Mono.HttpUtility.so
		i64 u0x475325afa16dbfe5, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.82_name, ; name: libaot-Mono.HttpUtility.dll.so
		ptr null; void* handle
	}, ; 1241
	%struct.DSOCacheEntry {
		i64 u0xa1b6964c34f0f854, ; from name: aot-Xamarin.AndroidX.RecyclerView
		i64 u0x34c6f5c746796bcc, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.123_name, ; name: libaot-Xamarin.AndroidX.RecyclerView.dll.so
		ptr null; void* handle
	}, ; 1242
	%struct.DSOCacheEntry {
		i64 u0xa1fa4ded3d9c2cee, ; from name: libaot-Microsoft.AspNetCore.WebUtilities.dll.so
		i64 u0xa1fa4ded3d9c2cee, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.43_name, ; name: libaot-Microsoft.AspNetCore.WebUtilities.dll.so
		ptr null; void* handle
	}, ; 1243
	%struct.DSOCacheEntry {
		i64 u0xa21a33b950c8f6c7, ; from name: aot-Microsoft.AspNetCore.SignalR.Common.so
		i64 u0x1d711f330f5778d7, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.40_name, ; name: libaot-Microsoft.AspNetCore.SignalR.Common.dll.so
		ptr null; void* handle
	}, ; 1244
	%struct.DSOCacheEntry {
		i64 u0xa25ccb0ec942bbc0, ; from name: DocumentFormat.OpenXml.VariableReplacer.Core.dll.so
		i64 u0x785bad4f0559c250, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.19_name, ; name: libaot-DocumentFormat.OpenXml.VariableReplacer.Core.dll.so
		ptr null; void* handle
	}, ; 1245
	%struct.DSOCacheEntry {
		i64 u0xa2612ef086711418, ; from name: aot-System.Diagnostics.StackTrace.so
		i64 u0xb21e783430e22a93, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.148_name, ; name: libaot-System.Diagnostics.StackTrace.dll.so
		ptr null; void* handle
	}, ; 1246
	%struct.DSOCacheEntry {
		i64 u0xa295a6444da2bfd6, ; from name: aot-Microsoft.IdentityModel.Logging
		i64 u0x1175872aaf2edbfe, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.71_name, ; name: libaot-Microsoft.IdentityModel.Logging.dll.so
		ptr null; void* handle
	}, ; 1247
	%struct.DSOCacheEntry {
		i64 u0xa2b4fd670b3d1621, ; from name: libaot-System.ComponentModel.Primitives
		i64 u0xccde8a4563eee10b, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.141_name, ; name: libaot-System.ComponentModel.Primitives.dll.so
		ptr null; void* handle
	}, ; 1248
	%struct.DSOCacheEntry {
		i64 u0xa2bdab17c07b52cb, ; from name: Xamarin.AndroidX.AppCompat.AppCompatResources.so
		i64 u0x456e37cd491657b0, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.104_name, ; name: libaot-Xamarin.AndroidX.AppCompat.AppCompatResources.dll.so
		ptr null; void* handle
	}, ; 1249
	%struct.DSOCacheEntry {
		i64 u0xa2cd2fab4ebe5541, ; from name: libaot-System.Transactions.Local.so
		i64 u0x5425eb433f599bc7, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.215_name, ; name: libaot-System.Transactions.Local.dll.so
		ptr null; void* handle
	}, ; 1250
	%struct.DSOCacheEntry {
		i64 u0xa2d571bfa62e4377, ; from name: Microsoft.Extensions.Logging.so
		i64 u0x9b6f0babce2a1934, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.62_name, ; name: libaot-Microsoft.Extensions.Logging.dll.so
		ptr null; void* handle
	}, ; 1251
	%struct.DSOCacheEntry {
		i64 u0xa2d6fbf4ed6ba3e1, ; from name: aot-Microsoft.IdentityModel.Abstractions
		i64 u0x41c972d328f102fd, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.69_name, ; name: libaot-Microsoft.IdentityModel.Abstractions.dll.so
		ptr null; void* handle
	}, ; 1252
	%struct.DSOCacheEntry {
		i64 u0xa308814df197d206, ; from name: Azure.Core.so
		i64 u0x821f528a92d55dea, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.12_name, ; name: libaot-Azure.Core.dll.so
		ptr null; void* handle
	}, ; 1253
	%struct.DSOCacheEntry {
		i64 u0xa35142dbbab3920c, ; from name: libaot-System.Diagnostics.Process
		i64 u0x8657799bb82e0573, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.147_name, ; name: libaot-System.Diagnostics.Process.dll.so
		ptr null; void* handle
	}, ; 1254
	%struct.DSOCacheEntry {
		i64 u0xa3600d7904da7121, ; from name: libaot-System.ComponentModel.TypeConverter
		i64 u0xcb7e41356728fd07, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.142_name, ; name: libaot-System.ComponentModel.TypeConverter.dll.so
		ptr null; void* handle
	}, ; 1255
	%struct.DSOCacheEntry {
		i64 u0xa36762ce482f6584, ; from name: Java.Interop.so
		i64 u0x6ce045494a545eab, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.224_name, ; name: libaot-Java.Interop.dll.so
		ptr null; void* handle
	}, ; 1256
	%struct.DSOCacheEntry {
		i64 u0xa37169d11291ebb3, ; from name: libaot-Xamarin.AndroidX.Navigation.Common.so
		i64 u0x2ba3b197006b7954, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.119_name, ; name: libaot-Xamarin.AndroidX.Navigation.Common.dll.so
		ptr null; void* handle
	}, ; 1257
	%struct.DSOCacheEntry {
		i64 u0xa3b2ab9de505a84b, ; from name: aot-Microsoft.IdentityModel.Protocols.OpenIdConnect.so
		i64 u0xbe90bee1d67c825c, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.73_name, ; name: libaot-Microsoft.IdentityModel.Protocols.OpenIdConnect.dll.so
		ptr null; void* handle
	}, ; 1258
	%struct.DSOCacheEntry {
		i64 u0xa3d575b6be692297, ; from name: libaot-Microsoft.EntityFrameworkCore.Abstractions.so
		i64 u0x98d96e0f4341bc32, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.47_name, ; name: libaot-Microsoft.EntityFrameworkCore.Abstractions.dll.so
		ptr null; void* handle
	}, ; 1259
	%struct.DSOCacheEntry {
		i64 u0xa3dc3bd6aae2cea1, ; from name: Xamarin.AndroidX.Loader.dll.so
		i64 u0x74b0aefe8f467d50, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.118_name, ; name: libaot-Xamarin.AndroidX.Loader.dll.so
		ptr null; void* handle
	}, ; 1260
	%struct.DSOCacheEntry {
		i64 u0xa3f9e6298fdc33b5, ; from name: aot-System.Web.HttpUtility.so
		i64 u0xcdab467c6caa8aba, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.216_name, ; name: libaot-System.Web.HttpUtility.dll.so
		ptr null; void* handle
	}, ; 1261
	%struct.DSOCacheEntry {
		i64 u0xa40fc435d199e5e0, ; from name: libaot-Xamarin.AndroidX.CardView
		i64 u0xe9e6021e6533eb43, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.106_name, ; name: libaot-Xamarin.AndroidX.CardView.dll.so
		ptr null; void* handle
	}, ; 1262
	%struct.DSOCacheEntry {
		i64 u0xa473938c792db0b6, ; from name: Microsoft.AspNetCore.Routing.Abstractions
		i64 u0x03ea24da2517cfb9, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.37_name, ; name: libaot-Microsoft.AspNetCore.Routing.Abstractions.dll.so
		ptr null; void* handle
	}, ; 1263
	%struct.DSOCacheEntry {
		i64 u0xa4a372eecb9e4df0, ; from name: Microsoft.Extensions.Diagnostics
		i64 u0xd34809bcacf156ee, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.57_name, ; name: libaot-Microsoft.Extensions.Diagnostics.dll.so
		ptr null; void* handle
	}, ; 1264
	%struct.DSOCacheEntry {
		i64 u0xa4d336a75ab12937, ; from name: libaot-System.ClientModel.dll.so
		i64 u0xa4d336a75ab12937, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.95_name, ; name: libaot-System.ClientModel.dll.so
		ptr null; void* handle
	}, ; 1265
	%struct.DSOCacheEntry {
		i64 u0xa526035d994803cd, ; from name: aot-System.Net.Http.dll.so
		i64 u0xd925f85604802447, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.165_name, ; name: libaot-System.Net.Http.dll.so
		ptr null; void* handle
	}, ; 1266
	%struct.DSOCacheEntry {
		i64 u0xa5262af8b99b6fe7, ; from name: System.Runtime.Serialization.Primitives.dll.so
		i64 u0xbd30caec9108afc1, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.192_name, ; name: libaot-System.Runtime.Serialization.Primitives.dll.so
		ptr null; void* handle
	}, ; 1267
	%struct.DSOCacheEntry {
		i64 u0xa56606bb1f125004, ; from name: libaot-Syncfusion.Maui.Toolkit.resources.dll.so
		i64 u0xa56606bb1f125004, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.94_name, ; name: libaot-Syncfusion.Maui.Toolkit.resources.dll.so
		ptr null; void* handle
	}, ; 1268
	%struct.DSOCacheEntry {
		i64 u0xa569f665f1984c29, ; from name: aot-Xamarin.AndroidX.Navigation.Runtime
		i64 u0x79a319cd6e76a263, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.121_name, ; name: libaot-Xamarin.AndroidX.Navigation.Runtime.dll.so
		ptr null; void* handle
	}, ; 1269
	%struct.DSOCacheEntry {
		i64 u0xa575a707fff254b3, ; from name: libaot-Microsoft.AspNetCore.Hosting.Server.Abstractions
		i64 u0xdb28c2f2e5cda275, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.26_name, ; name: libaot-Microsoft.AspNetCore.Hosting.Server.Abstractions.dll.so
		ptr null; void* handle
	}, ; 1270
	%struct.DSOCacheEntry {
		i64 u0xa57746d2a371c785, ; from name: aot-System.Runtime.so
		i64 u0xbbc0e6e747d7877a, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.194_name, ; name: libaot-System.Runtime.dll.so
		ptr null; void* handle
	}, ; 1271
	%struct.DSOCacheEntry {
		i64 u0xa58e5c89fb869cde, ; from name: aot-System.Text.Encodings.Web.dll.so
		i64 u0x209bcec5b3b022b8, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.207_name, ; name: libaot-System.Text.Encodings.Web.dll.so
		ptr null; void* handle
	}, ; 1272
	%struct.DSOCacheEntry {
		i64 u0xa5a20228c07e96ff, ; from name: libaot-SQLitePCLRaw.provider.e_sqlite3.dll.so
		i64 u0xa5a20228c07e96ff, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.88_name, ; name: libaot-SQLitePCLRaw.provider.e_sqlite3.dll.so
		ptr null; void* handle
	}, ; 1273
	%struct.DSOCacheEntry {
		i64 u0xa5cc53eea2051128, ; from name: libaot-DocumentFormat.OpenXml.Framework
		i64 u0xf959815fea0ec361, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.18_name, ; name: libaot-DocumentFormat.OpenXml.Framework.dll.so
		ptr null; void* handle
	}, ; 1274
	%struct.DSOCacheEntry {
		i64 u0xa5d908557e4e7067, ; from name: aot-Microsoft.Extensions.ObjectPool.dll.so
		i64 u0xa951cdbe6a05ef83, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.64_name, ; name: libaot-Microsoft.Extensions.ObjectPool.dll.so
		ptr null; void* handle
	}, ; 1275
	%struct.DSOCacheEntry {
		i64 u0xa6143250fbdaa840, ; from name: aot-Xamarin.AndroidX.Navigation.Common.so
		i64 u0x2ba3b197006b7954, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.119_name, ; name: libaot-Xamarin.AndroidX.Navigation.Common.dll.so
		ptr null; void* handle
	}, ; 1276
	%struct.DSOCacheEntry {
		i64 u0xa66711e6890279dc, ; from name: aot-System.Drawing.Primitives
		i64 u0x934cbfda9b40e895, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.151_name, ; name: libaot-System.Drawing.Primitives.dll.so
		ptr null; void* handle
	}, ; 1277
	%struct.DSOCacheEntry {
		i64 u0xa6792e826db2954e, ; from name: libaot-Xamarin.AndroidX.AppCompat
		i64 u0x42c7eb0880ff24a4, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.103_name, ; name: libaot-Xamarin.AndroidX.AppCompat.dll.so
		ptr null; void* handle
	}, ; 1278
	%struct.DSOCacheEntry {
		i64 u0xa688b113f4653ddf, ; from name: aot-Xamarin.AndroidX.Navigation.Runtime.so
		i64 u0x79a319cd6e76a263, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.121_name, ; name: libaot-Xamarin.AndroidX.Navigation.Runtime.dll.so
		ptr null; void* handle
	}, ; 1279
	%struct.DSOCacheEntry {
		i64 u0xa6d29cffa841bf87, ; from name: Mono.Android.Runtime.dll.so
		i64 u0x156ae2b2e8a39884, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.225_name, ; name: libaot-Mono.Android.Runtime.dll.so
		ptr null; void* handle
	}, ; 1280
	%struct.DSOCacheEntry {
		i64 u0xa6d7c84e05400bac, ; from name: aot-System.Reflection.Emit.Lightweight
		i64 u0x54f7fbd0a81833fe, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.183_name, ; name: libaot-System.Reflection.Emit.Lightweight.dll.so
		ptr null; void* handle
	}, ; 1281
	%struct.DSOCacheEntry {
		i64 u0xa6e2830ef7cc986f, ; from name: aot-System.Runtime.Serialization.Xml.so
		i64 u0xeb52548b17e702c6, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.193_name, ; name: libaot-System.Runtime.Serialization.Xml.dll.so
		ptr null; void* handle
	}, ; 1282
	%struct.DSOCacheEntry {
		i64 u0xa70ff72cdbf28f6f, ; from name: System.Net.NetworkInformation.so
		i64 u0xb1bf28cdcefab46b, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.167_name, ; name: libaot-System.Net.NetworkInformation.dll.so
		ptr null; void* handle
	}, ; 1283
	%struct.DSOCacheEntry {
		i64 u0xa71fe7d6f6f93efd, ; from name: Microsoft.Data.SqlClient
		i64 u0x0b7c60fbe9d8f09b, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.45_name, ; name: libaot-Microsoft.Data.SqlClient.dll.so
		ptr null; void* handle
	}, ; 1284
	%struct.DSOCacheEntry {
		i64 u0xa7460d33c0d321de, ; from name: aot-Microsoft.EntityFrameworkCore
		i64 u0x9694080faa394553, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.46_name, ; name: libaot-Microsoft.EntityFrameworkCore.dll.so
		ptr null; void* handle
	}, ; 1285
	%struct.DSOCacheEntry {
		i64 u0xa78ce3745383236a, ; from name: Xamarin.AndroidX.Lifecycle.Common.Jvm
		i64 u0x2ec8d2dcf2c4a71b, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.114_name, ; name: libaot-Xamarin.AndroidX.Lifecycle.Common.Jvm.dll.so
		ptr null; void* handle
	}, ; 1286
	%struct.DSOCacheEntry {
		i64 u0xa7a0a8e9c88b0fe7, ; from name: aot-Microsoft.Extensions.FileProviders.Abstractions.so
		i64 u0x82b65efc7b0bc50f, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.60_name, ; name: libaot-Microsoft.Extensions.FileProviders.Abstractions.dll.so
		ptr null; void* handle
	}, ; 1287
	%struct.DSOCacheEntry {
		i64 u0xa7b7eaf43544b3a7, ; from name: System.Collections.Specialized.dll.so
		i64 u0x355b66670e6bf2e4, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.138_name, ; name: libaot-System.Collections.Specialized.dll.so
		ptr null; void* handle
	}, ; 1288
	%struct.DSOCacheEntry {
		i64 u0xa7be6cb26868970f, ; from name: libaot-System.Net.WebSockets
		i64 u0x403cd01c6fb39d89, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.175_name, ; name: libaot-System.Net.WebSockets.dll.so
		ptr null; void* handle
	}, ; 1289
	%struct.DSOCacheEntry {
		i64 u0xa80ec2cb31f87e1a, ; from name: System.Runtime.Caching.so
		i64 u0x9a1f1aedbdf3f019, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.100_name, ; name: libaot-System.Runtime.Caching.dll.so
		ptr null; void* handle
	}, ; 1290
	%struct.DSOCacheEntry {
		i64 u0xa81dfd6455f2dc19, ; from name: libaot-Microsoft.Net.Http.Headers.dll.so
		i64 u0xa81dfd6455f2dc19, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.80_name, ; name: libaot-Microsoft.Net.Http.Headers.dll.so
		ptr null; void* handle
	}, ; 1291
	%struct.DSOCacheEntry {
		i64 u0xa8270f1f775e21be, ; from name: libaot-System.Diagnostics.StackTrace
		i64 u0xb21e783430e22a93, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.148_name, ; name: libaot-System.Diagnostics.StackTrace.dll.so
		ptr null; void* handle
	}, ; 1292
	%struct.DSOCacheEntry {
		i64 u0xa83ecca0b6580b97, ; from name: System.Security.Cryptography.ProtectedData.dll.so
		i64 u0x67faf2828acf47d0, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.101_name, ; name: libaot-System.Security.Cryptography.ProtectedData.dll.so
		ptr null; void* handle
	}, ; 1293
	%struct.DSOCacheEntry {
		i64 u0xa84451db4a425556, ; from name: libaot-System.Net.NameResolution.so
		i64 u0x7f280e9be5453eba, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.166_name, ; name: libaot-System.Net.NameResolution.dll.so
		ptr null; void* handle
	}, ; 1294
	%struct.DSOCacheEntry {
		i64 u0xa86a1a01c3db8f2d, ; from name: Xamarin.AndroidX.Navigation.Fragment.dll.so
		i64 u0xaa2eca1145f3a7cc, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.120_name, ; name: libaot-Xamarin.AndroidX.Navigation.Fragment.dll.so
		ptr null; void* handle
	}, ; 1295
	%struct.DSOCacheEntry {
		i64 u0xa898d097ba612a32, ; from name: Xamarin.AndroidX.Navigation.Runtime.dll.so
		i64 u0x79a319cd6e76a263, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.121_name, ; name: libaot-Xamarin.AndroidX.Navigation.Runtime.dll.so
		ptr null; void* handle
	}, ; 1296
	%struct.DSOCacheEntry {
		i64 u0xa89dcbf7ffd87c31, ; from name: libaot-Xamarin.AndroidX.Lifecycle.ViewModel.Android
		i64 u0xc06034423c0d320f, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.116_name, ; name: libaot-Xamarin.AndroidX.Lifecycle.ViewModel.Android.dll.so
		ptr null; void* handle
	}, ; 1297
	%struct.DSOCacheEntry {
		i64 u0xa8d4d47d91d2e9d6, ; from name: Xamarin.AndroidX.Lifecycle.Common.Jvm.dll.so
		i64 u0x2ec8d2dcf2c4a71b, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.114_name, ; name: libaot-Xamarin.AndroidX.Lifecycle.Common.Jvm.dll.so
		ptr null; void* handle
	}, ; 1298
	%struct.DSOCacheEntry {
		i64 u0xa8dbb23eca3bd3e2, ; from name: aot-Microsoft.AspNetCore.Authentication.Abstractions
		i64 u0x59903efae9d3d723, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.20_name, ; name: libaot-Microsoft.AspNetCore.Authentication.Abstractions.dll.so
		ptr null; void* handle
	}, ; 1299
	%struct.DSOCacheEntry {
		i64 u0xa8fac201d340119f, ; from name: aot-System.Runtime.InteropServices.RuntimeInformation.dll.so
		i64 u0x6aae90d5594500a9, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.186_name, ; name: libaot-System.Runtime.InteropServices.RuntimeInformation.dll.so
		ptr null; void* handle
	}, ; 1300
	%struct.DSOCacheEntry {
		i64 u0xa951cdbe6a05ef83, ; from name: libaot-Microsoft.Extensions.ObjectPool.dll.so
		i64 u0xa951cdbe6a05ef83, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.64_name, ; name: libaot-Microsoft.Extensions.ObjectPool.dll.so
		ptr null; void* handle
	}, ; 1301
	%struct.DSOCacheEntry {
		i64 u0xa999b89f86f1fb32, ; from name: libaot-System.IO.FileSystem.AccessControl
		i64 u0xf8af38e7ca3d5d78, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.156_name, ; name: libaot-System.IO.FileSystem.AccessControl.dll.so
		ptr null; void* handle
	}, ; 1302
	%struct.DSOCacheEntry {
		i64 u0xa99fc710fdd6e008, ; from name: System.Threading.so
		i64 u0x5f435aa7f5fde870, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.214_name, ; name: libaot-System.Threading.dll.so
		ptr null; void* handle
	}, ; 1303
	%struct.DSOCacheEntry {
		i64 u0xaa0bfa4d3d3a8688, ; from name: System.Text.Encoding.Extensions.dll.so
		i64 u0xf89ed8fc2f5b4b33, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.206_name, ; name: libaot-System.Text.Encoding.Extensions.dll.so
		ptr null; void* handle
	}, ; 1304
	%struct.DSOCacheEntry {
		i64 u0xaa2219c8e3449ff5, ; from name: Microsoft.Extensions.Logging.Abstractions
		i64 u0xe6757a5fac324e53, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.63_name, ; name: libaot-Microsoft.Extensions.Logging.Abstractions.dll.so
		ptr null; void* handle
	}, ; 1305
	%struct.DSOCacheEntry {
		i64 u0xaa2eca1145f3a7cc, ; from name: libaot-Xamarin.AndroidX.Navigation.Fragment.dll.so
		i64 u0xaa2eca1145f3a7cc, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.120_name, ; name: libaot-Xamarin.AndroidX.Navigation.Fragment.dll.so
		ptr null; void* handle
	}, ; 1306
	%struct.DSOCacheEntry {
		i64 u0xaa3a7323464e7e80, ; from name: libaot-DocumentFormat.OpenXml
		i64 u0x456cc421e6ef3bb7, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.17_name, ; name: libaot-DocumentFormat.OpenXml.dll.so
		ptr null; void* handle
	}, ; 1307
	%struct.DSOCacheEntry {
		i64 u0xaa48c6cbbcb0e14b, ; from name: Microsoft.AspNetCore.SignalR.Common.dll.so
		i64 u0x1d711f330f5778d7, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.40_name, ; name: libaot-Microsoft.AspNetCore.SignalR.Common.dll.so
		ptr null; void* handle
	}, ; 1308
	%struct.DSOCacheEntry {
		i64 u0xaa52de307ef5d1dd, ; from name: System.Net.Http
		i64 u0xd925f85604802447, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.165_name, ; name: libaot-System.Net.Http.dll.so
		ptr null; void* handle
	}, ; 1309
	%struct.DSOCacheEntry {
		i64 u0xaaaa2178e8c85252, ; from name: aot-System.Net.WebSockets.Client.dll.so
		i64 u0x0a18b49bebc33444, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.174_name, ; name: libaot-System.Net.WebSockets.Client.dll.so
		ptr null; void* handle
	}, ; 1310
	%struct.DSOCacheEntry {
		i64 u0xaaba20554af6cac2, ; from name: System.ObjectModel.dll.so
		i64 u0x914167d87d2ee1b1, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.177_name, ; name: libaot-System.ObjectModel.dll.so
		ptr null; void* handle
	}, ; 1311
	%struct.DSOCacheEntry {
		i64 u0xaac4801194f87f4f, ; from name: libaot-System.Net.Primitives.dll.so
		i64 u0xaac4801194f87f4f, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.168_name, ; name: libaot-System.Net.Primitives.dll.so
		ptr null; void* handle
	}, ; 1312
	%struct.DSOCacheEntry {
		i64 u0xaace8b830d9ec31f, ; from name: Microsoft.Maui.dll.so
		i64 u0x58cd310024b735d8, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.77_name, ; name: libaot-Microsoft.Maui.dll.so
		ptr null; void* handle
	}, ; 1313
	%struct.DSOCacheEntry {
		i64 u0xaadcbb26ca54f7b3, ; from name: aot-Xamarin.AndroidX.Navigation.Common
		i64 u0x2ba3b197006b7954, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.119_name, ; name: libaot-Xamarin.AndroidX.Navigation.Common.dll.so
		ptr null; void* handle
	}, ; 1314
	%struct.DSOCacheEntry {
		i64 u0xab58dfeac8661c19, ; from name: libaot-System.Net.Primitives.so
		i64 u0xaac4801194f87f4f, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.168_name, ; name: libaot-System.Net.Primitives.dll.so
		ptr null; void* handle
	}, ; 1315
	%struct.DSOCacheEntry {
		i64 u0xab79a74d7a11ded0, ; from name: aot-System.Memory.Data
		i64 u0xe03e3baaab589d1e, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.98_name, ; name: libaot-System.Memory.Data.dll.so
		ptr null; void* handle
	}, ; 1316
	%struct.DSOCacheEntry {
		i64 u0xab9eda8d0021b93b, ; from name: libaot-System.Runtime.InteropServices.RuntimeInformation.so
		i64 u0x6aae90d5594500a9, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.186_name, ; name: libaot-System.Runtime.InteropServices.RuntimeInformation.dll.so
		ptr null; void* handle
	}, ; 1317
	%struct.DSOCacheEntry {
		i64 u0xabaabcb70f9474ff, ; from name: Microsoft.AspNetCore.Mvc.Abstractions
		i64 u0x8be639a423b6d017, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.33_name, ; name: libaot-Microsoft.AspNetCore.Mvc.Abstractions.dll.so
		ptr null; void* handle
	}, ; 1318
	%struct.DSOCacheEntry {
		i64 u0xac2af3fa195a15ce, ; from name: System.Runtime.Numerics
		i64 u0x6619888793b3b2dd, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.189_name, ; name: libaot-System.Runtime.Numerics.dll.so
		ptr null; void* handle
	}, ; 1319
	%struct.DSOCacheEntry {
		i64 u0xac3170a66a0fd436, ; from name: aot-DocumentFormat.OpenXml.VariableReplacer.Core
		i64 u0x785bad4f0559c250, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.19_name, ; name: libaot-DocumentFormat.OpenXml.VariableReplacer.Core.dll.so
		ptr null; void* handle
	}, ; 1320
	%struct.DSOCacheEntry {
		i64 u0xac349d00a07b46d2, ; from name: libaot-Microsoft.Maui.Graphics.so
		i64 u0x285d22da351d937a, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.79_name, ; name: libaot-Microsoft.Maui.Graphics.dll.so
		ptr null; void* handle
	}, ; 1321
	%struct.DSOCacheEntry {
		i64 u0xac58531de99ddcad, ; from name: aot-Syncfusion.Maui.Core.so
		i64 u0x4cfc586bcbdc6c97, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.90_name, ; name: libaot-Syncfusion.Maui.Core.dll.so
		ptr null; void* handle
	}, ; 1322
	%struct.DSOCacheEntry {
		i64 u0xac85a7e3562ecec4, ; from name: aot-Xamarin.AndroidX.Lifecycle.Common.Jvm.so
		i64 u0x2ec8d2dcf2c4a71b, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.114_name, ; name: libaot-Xamarin.AndroidX.Lifecycle.Common.Jvm.dll.so
		ptr null; void* handle
	}, ; 1323
	%struct.DSOCacheEntry {
		i64 u0xac98d31068e24591, ; from name: System.Xml.XDocument
		i64 u0x823af1c93e519784, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.219_name, ; name: libaot-System.Xml.XDocument.dll.so
		ptr null; void* handle
	}, ; 1324
	%struct.DSOCacheEntry {
		i64 u0xacf26ff6f185495f, ; from name: aot-Syncfusion.Licensing.dll.so
		i64 u0xe0ba2b05be11dec6, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.89_name, ; name: libaot-Syncfusion.Licensing.dll.so
		ptr null; void* handle
	}, ; 1325
	%struct.DSOCacheEntry {
		i64 u0xacf42eea7ef9cd12, ; from name: System.Threading.Channels
		i64 u0x59aee0bc92ee07e3, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.210_name, ; name: libaot-System.Threading.Channels.dll.so
		ptr null; void* handle
	}, ; 1326
	%struct.DSOCacheEntry {
		i64 u0xad037698fb492d93, ; from name: libaot-System.Net.Http.Json.so
		i64 u0x36547dc653fb83c1, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.164_name, ; name: libaot-System.Net.Http.Json.dll.so
		ptr null; void* handle
	}, ; 1327
	%struct.DSOCacheEntry {
		i64 u0xad1d21c99b78d198, ; from name: aot-System.Xml.XmlSerializer.dll.so
		i64 u0xdfef1aaab339ffdb, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.220_name, ; name: libaot-System.Xml.XmlSerializer.dll.so
		ptr null; void* handle
	}, ; 1328
	%struct.DSOCacheEntry {
		i64 u0xad27d487bd27a6ac, ; from name: libaot-Microsoft.Extensions.Primitives
		i64 u0x9df2f15d2ed44e61, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.66_name, ; name: libaot-Microsoft.Extensions.Primitives.dll.so
		ptr null; void* handle
	}, ; 1329
	%struct.DSOCacheEntry {
		i64 u0xad4654d8150b29a7, ; from name: Microsoft.Net.Http.Headers.dll.so
		i64 u0xa81dfd6455f2dc19, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.80_name, ; name: libaot-Microsoft.Net.Http.Headers.dll.so
		ptr null; void* handle
	}, ; 1330
	%struct.DSOCacheEntry {
		i64 u0xad582851e7d05243, ; from name: libaot-System.Memory.dll.so
		i64 u0xad582851e7d05243, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.163_name, ; name: libaot-System.Memory.dll.so
		ptr null; void* handle
	}, ; 1331
	%struct.DSOCacheEntry {
		i64 u0xadbb53caf78a79d2, ; from name: System.Web.HttpUtility
		i64 u0xcdab467c6caa8aba, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.216_name, ; name: libaot-System.Web.HttpUtility.dll.so
		ptr null; void* handle
	}, ; 1332
	%struct.DSOCacheEntry {
		i64 u0xadcfa6a960ee8b30, ; from name: aot-System.Security.Claims.dll.so
		i64 u0xd1ca18d995b9f417, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.196_name, ; name: libaot-System.Security.Claims.dll.so
		ptr null; void* handle
	}, ; 1333
	%struct.DSOCacheEntry {
		i64 u0xade24bc0b03d34bb, ; from name: libaot-System.Net.WebHeaderCollection.so
		i64 u0x42b58ea66e808de7, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.173_name, ; name: libaot-System.Net.WebHeaderCollection.dll.so
		ptr null; void* handle
	}, ; 1334
	%struct.DSOCacheEntry {
		i64 u0xadebeeabd33ae10b, ; from name: libaot-Microsoft.AspNetCore.Http.Connections.Common
		i64 u0x726b54f946bf0d7f, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.30_name, ; name: libaot-Microsoft.AspNetCore.Http.Connections.Common.dll.so
		ptr null; void* handle
	}, ; 1335
	%struct.DSOCacheEntry {
		i64 u0xadf511667bef3595, ; from name: System.Net.Security
		i64 u0x1271045d1561acf0, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.170_name, ; name: libaot-System.Net.Security.dll.so
		ptr null; void* handle
	}, ; 1336
	%struct.DSOCacheEntry {
		i64 u0xadfd3002707c5b3e, ; from name: System.Text.Json.dll.so
		i64 u0x9bb35aa4bcef7b80, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.208_name, ; name: libaot-System.Text.Json.dll.so
		ptr null; void* handle
	}, ; 1337
	%struct.DSOCacheEntry {
		i64 u0xadff56a34a4d04d7, ; from name: Xamarin.Google.Android.Material.so
		i64 u0x937abea3fe5296af, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.128_name, ; name: libaot-Xamarin.Google.Android.Material.dll.so
		ptr null; void* handle
	}, ; 1338
	%struct.DSOCacheEntry {
		i64 u0xae282bcd03739de7, ; from name: Java.Interop
		i64 u0x6ce045494a545eab, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.224_name, ; name: libaot-Java.Interop.dll.so
		ptr null; void* handle
	}, ; 1339
	%struct.DSOCacheEntry {
		i64 u0xae359db3d968bba3, ; from name: libaot-Microsoft.Bcl.AsyncInterfaces.so
		i64 u0x9b7e93363193afd3, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.44_name, ; name: libaot-Microsoft.Bcl.AsyncInterfaces.dll.so
		ptr null; void* handle
	}, ; 1340
	%struct.DSOCacheEntry {
		i64 u0xae4812e00c418b6e, ; from name: aot-System.Diagnostics.Process
		i64 u0x8657799bb82e0573, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.147_name, ; name: libaot-System.Diagnostics.Process.dll.so
		ptr null; void* handle
	}, ; 1341
	%struct.DSOCacheEntry {
		i64 u0xae8282b3068f87cd, ; from name: Xamarin.AndroidX.DrawerLayout.so
		i64 u0x4bea014989424a56, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.112_name, ; name: libaot-Xamarin.AndroidX.DrawerLayout.dll.so
		ptr null; void* handle
	}, ; 1342
	%struct.DSOCacheEntry {
		i64 u0xaeb953dee2155cf4, ; from name: aot-System.Net.WebClient.so
		i64 u0x4ce9b13ddea58a1b, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.172_name, ; name: libaot-System.Net.WebClient.dll.so
		ptr null; void* handle
	}, ; 1343
	%struct.DSOCacheEntry {
		i64 u0xaebd3af6eeceb1eb, ; from name: libaot-Microsoft.Extensions.Features.dll.so
		i64 u0xaebd3af6eeceb1eb, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.59_name, ; name: libaot-Microsoft.Extensions.Features.dll.so
		ptr null; void* handle
	}, ; 1344
	%struct.DSOCacheEntry {
		i64 u0xaec94df3f1a01f27, ; from name: aot-Xamarin.KotlinX.Coroutines.Core.Jvm.so
		i64 u0x811e0efc0e57d069, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.130_name, ; name: libaot-Xamarin.KotlinX.Coroutines.Core.Jvm.dll.so
		ptr null; void* handle
	}, ; 1345
	%struct.DSOCacheEntry {
		i64 u0xaef55035077cd01c, ; from name: System.ComponentModel.dll.so
		i64 u0x38a82198a4cd2a73, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.143_name, ; name: libaot-System.ComponentModel.dll.so
		ptr null; void* handle
	}, ; 1346
	%struct.DSOCacheEntry {
		i64 u0xaefcd08794660058, ; from name: aot-Xamarin.AndroidX.SwipeRefreshLayout.dll.so
		i64 u0x6c4e830c0d79912d, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.125_name, ; name: libaot-Xamarin.AndroidX.SwipeRefreshLayout.dll.so
		ptr null; void* handle
	}, ; 1347
	%struct.DSOCacheEntry {
		i64 u0xaf141c9703ea27c2, ; from name: libaot-Microsoft.Extensions.Configuration.so
		i64 u0x07a45374fab68acc, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.52_name, ; name: libaot-Microsoft.Extensions.Configuration.dll.so
		ptr null; void* handle
	}, ; 1348
	%struct.DSOCacheEntry {
		i64 u0xaf2fccd8d6eb63cb, ; from name: aot-System.Net.Primitives.dll.so
		i64 u0xaac4801194f87f4f, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.168_name, ; name: libaot-System.Net.Primitives.dll.so
		ptr null; void* handle
	}, ; 1349
	%struct.DSOCacheEntry {
		i64 u0xaf7449fb6e55b1bf, ; from name: Syncfusion.Maui.Toolkit.so
		i64 u0x2d6521795fa92605, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.93_name, ; name: libaot-Syncfusion.Maui.Toolkit.dll.so
		ptr null; void* handle
	}, ; 1350
	%struct.DSOCacheEntry {
		i64 u0xaf7b332d42ace05c, ; from name: libaot-System.Net.WebSockets.Client.so
		i64 u0x0a18b49bebc33444, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.174_name, ; name: libaot-System.Net.WebSockets.Client.dll.so
		ptr null; void* handle
	}, ; 1351
	%struct.DSOCacheEntry {
		i64 u0xaf94146bf4fefa0c, ; from name: Azure.Identity.so
		i64 u0xf309d7d68dc0ac48, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.13_name, ; name: libaot-Azure.Identity.dll.so
		ptr null; void* handle
	}, ; 1352
	%struct.DSOCacheEntry {
		i64 u0xafb00434cf085ca0, ; from name: aot-Microsoft.EntityFrameworkCore.SqlServer.dll.so
		i64 u0x9daa39a878308c98, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.49_name, ; name: libaot-Microsoft.EntityFrameworkCore.SqlServer.dll.so
		ptr null; void* handle
	}, ; 1353
	%struct.DSOCacheEntry {
		i64 u0xb070c3344d6ebc3b, ; from name: libaot-Microsoft.AspNetCore.SignalR.Client.Core.so
		i64 u0x0e46bd4e008c7b33, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.39_name, ; name: libaot-Microsoft.AspNetCore.SignalR.Client.Core.dll.so
		ptr null; void* handle
	}, ; 1354
	%struct.DSOCacheEntry {
		i64 u0xb10621098b80722c, ; from name: aot-Xamarin.Google.Android.Material.dll.so
		i64 u0x937abea3fe5296af, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.128_name, ; name: libaot-Xamarin.Google.Android.Material.dll.so
		ptr null; void* handle
	}, ; 1355
	%struct.DSOCacheEntry {
		i64 u0xb1267f747d003d17, ; from name: aot-Xamarin.AndroidX.RecyclerView.so
		i64 u0x34c6f5c746796bcc, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.123_name, ; name: libaot-Xamarin.AndroidX.RecyclerView.dll.so
		ptr null; void* handle
	}, ; 1356
	%struct.DSOCacheEntry {
		i64 u0xb18acbf41e20b96a, ; from name: aot-Microsoft.AspNetCore.Authentication.Core.dll.so
		i64 u0x2b7aae4ebbc0110d, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.21_name, ; name: libaot-Microsoft.AspNetCore.Authentication.Core.dll.so
		ptr null; void* handle
	}, ; 1357
	%struct.DSOCacheEntry {
		i64 u0xb19fddf876166658, ; from name: aot-System.IO.FileSystem.Watcher
		i64 u0xf90aa99869639df6, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.157_name, ; name: libaot-System.IO.FileSystem.Watcher.dll.so
		ptr null; void* handle
	}, ; 1358
	%struct.DSOCacheEntry {
		i64 u0xb1bf28cdcefab46b, ; from name: libaot-System.Net.NetworkInformation.dll.so
		i64 u0xb1bf28cdcefab46b, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.167_name, ; name: libaot-System.Net.NetworkInformation.dll.so
		ptr null; void* handle
	}, ; 1359
	%struct.DSOCacheEntry {
		i64 u0xb1c64a406148b0c8, ; from name: aot-System.Xml.XDocument.so
		i64 u0x823af1c93e519784, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.219_name, ; name: libaot-System.Xml.XDocument.dll.so
		ptr null; void* handle
	}, ; 1360
	%struct.DSOCacheEntry {
		i64 u0xb1dd05401aa8ee63, ; from name: System.Security.AccessControl
		i64 u0x69dd3c9ffb9c24cd, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.195_name, ; name: libaot-System.Security.AccessControl.dll.so
		ptr null; void* handle
	}, ; 1361
	%struct.DSOCacheEntry {
		i64 u0xb1e5721f1544bf98, ; from name: System.Data.Common.dll.so
		i64 u0x426a5e4ee84b386c, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.145_name, ; name: libaot-System.Data.Common.dll.so
		ptr null; void* handle
	}, ; 1362
	%struct.DSOCacheEntry {
		i64 u0xb21149716866b8b6, ; from name: libaot-System.Reflection.Primitives.so
		i64 u0x8c58bd1a08c146f5, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.185_name, ; name: libaot-System.Reflection.Primitives.dll.so
		ptr null; void* handle
	}, ; 1363
	%struct.DSOCacheEntry {
		i64 u0xb217ac0c4b509bf3, ; from name: aot-System.Private.DataContractSerialization
		i64 u0x8fa52587768c02e7, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.178_name, ; name: libaot-System.Private.DataContractSerialization.dll.so
		ptr null; void* handle
	}, ; 1364
	%struct.DSOCacheEntry {
		i64 u0xb21e783430e22a93, ; from name: libaot-System.Diagnostics.StackTrace.dll.so
		i64 u0xb21e783430e22a93, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.148_name, ; name: libaot-System.Diagnostics.StackTrace.dll.so
		ptr null; void* handle
	}, ; 1365
	%struct.DSOCacheEntry {
		i64 u0xb220631954820169, ; from name: System.Text.RegularExpressions
		i64 u0x7c2c39dae387b52d, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.209_name, ; name: libaot-System.Text.RegularExpressions.dll.so
		ptr null; void* handle
	}, ; 1366
	%struct.DSOCacheEntry {
		i64 u0xb2376e1dbf8b4ed7, ; from name: System.Security.Cryptography.Csp
		i64 u0xb259133b67649ff8, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.199_name, ; name: libaot-System.Security.Cryptography.Csp.dll.so
		ptr null; void* handle
	}, ; 1367
	%struct.DSOCacheEntry {
		i64 u0xb24f98555ce037d4, ; from name: aot-SocialMediaMaui.Shared.dll.so
		i64 u0x12448631a200ce9a, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.10_name, ; name: libaot-SocialMediaMaui.Shared.dll.so
		ptr null; void* handle
	}, ; 1368
	%struct.DSOCacheEntry {
		i64 u0xb259133b67649ff8, ; from name: libaot-System.Security.Cryptography.Csp.dll.so
		i64 u0xb259133b67649ff8, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.199_name, ; name: libaot-System.Security.Cryptography.Csp.dll.so
		ptr null; void* handle
	}, ; 1369
	%struct.DSOCacheEntry {
		i64 u0xb29024b995e4ccc2, ; from name: libaot-System.ComponentModel.TypeConverter.so
		i64 u0xcb7e41356728fd07, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.142_name, ; name: libaot-System.ComponentModel.TypeConverter.dll.so
		ptr null; void* handle
	}, ; 1370
	%struct.DSOCacheEntry {
		i64 u0xb2a3b0b9445d4908, ; from name: libaot-System.Private.Uri
		i64 u0xe57af9ab00f5c61d, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.179_name, ; name: libaot-System.Private.Uri.dll.so
		ptr null; void* handle
	}, ; 1371
	%struct.DSOCacheEntry {
		i64 u0xb2cfe48253b9259b, ; from name: System.Net.WebClient.dll.so
		i64 u0x4ce9b13ddea58a1b, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.172_name, ; name: libaot-System.Net.WebClient.dll.so
		ptr null; void* handle
	}, ; 1372
	%struct.DSOCacheEntry {
		i64 u0xb2d0ce1b008afb2a, ; from name: libaot-System.Linq
		i64 u0x2fb7a3952b307fae, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.162_name, ; name: libaot-System.Linq.dll.so
		ptr null; void* handle
	}, ; 1373
	%struct.DSOCacheEntry {
		i64 u0xb328cb1c75b50afd, ; from name: Xamarin.AndroidX.Navigation.Common.dll.so
		i64 u0x2ba3b197006b7954, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.119_name, ; name: libaot-Xamarin.AndroidX.Navigation.Common.dll.so
		ptr null; void* handle
	}, ; 1374
	%struct.DSOCacheEntry {
		i64 u0xb33effcdf11ddfd2, ; from name: libaot-System.Xml.XDocument.so
		i64 u0x823af1c93e519784, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.219_name, ; name: libaot-System.Xml.XDocument.dll.so
		ptr null; void* handle
	}, ; 1375
	%struct.DSOCacheEntry {
		i64 u0xb343b35350be6ef3, ; from name: DocumentFormat.OpenXml.Framework
		i64 u0xf959815fea0ec361, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.18_name, ; name: libaot-DocumentFormat.OpenXml.Framework.dll.so
		ptr null; void* handle
	}, ; 1376
	%struct.DSOCacheEntry {
		i64 u0xb34baf99392dc805, ; from name: libaot-System.Data.Common.so
		i64 u0x426a5e4ee84b386c, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.145_name, ; name: libaot-System.Data.Common.dll.so
		ptr null; void* handle
	}, ; 1377
	%struct.DSOCacheEntry {
		i64 u0xb373ed6de60e4cfc, ; from name: System.Linq.Expressions.dll.so
		i64 u0xda1d7acd827eb320, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.160_name, ; name: libaot-System.Linq.Expressions.dll.so
		ptr null; void* handle
	}, ; 1378
	%struct.DSOCacheEntry {
		i64 u0xb378d2b0172c537d, ; from name: libaot-Microsoft.AspNetCore.ResponseCaching.Abstractions.so
		i64 u0x2eb68ca0cc467150, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.35_name, ; name: libaot-Microsoft.AspNetCore.ResponseCaching.Abstractions.dll.so
		ptr null; void* handle
	}, ; 1379
	%struct.DSOCacheEntry {
		i64 u0xb3872ce262982921, ; from name: libaot-SocialMauiApp.so
		i64 u0xec957d270d230c6a, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.11_name, ; name: libaot-SocialMauiApp.dll.so
		ptr null; void* handle
	}, ; 1380
	%struct.DSOCacheEntry {
		i64 u0xb398860d6ed7ba2f, ; from name: System.Security.Cryptography.ProtectedData
		i64 u0x67faf2828acf47d0, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.101_name, ; name: libaot-System.Security.Cryptography.ProtectedData.dll.so
		ptr null; void* handle
	}, ; 1381
	%struct.DSOCacheEntry {
		i64 u0xb3c8b37c8e90ec36, ; from name: aot-Microsoft.IdentityModel.Protocols.OpenIdConnect
		i64 u0xbe90bee1d67c825c, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.73_name, ; name: libaot-Microsoft.IdentityModel.Protocols.OpenIdConnect.dll.so
		ptr null; void* handle
	}, ; 1382
	%struct.DSOCacheEntry {
		i64 u0xb3defeb12af4a148, ; from name: aot-Microsoft.EntityFrameworkCore.Abstractions.dll.so
		i64 u0x98d96e0f4341bc32, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.47_name, ; name: libaot-Microsoft.EntityFrameworkCore.Abstractions.dll.so
		ptr null; void* handle
	}, ; 1383
	%struct.DSOCacheEntry {
		i64 u0xb3f0a0fcda8d3ebc, ; from name: Xamarin.AndroidX.CardView
		i64 u0xe9e6021e6533eb43, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.106_name, ; name: libaot-Xamarin.AndroidX.CardView.dll.so
		ptr null; void* handle
	}, ; 1384
	%struct.DSOCacheEntry {
		i64 u0xb3f9fc836ae7ebb5, ; from name: libaot-System.Collections.dll.so
		i64 u0xb3f9fc836ae7ebb5, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.139_name, ; name: libaot-System.Collections.dll.so
		ptr null; void* handle
	}, ; 1385
	%struct.DSOCacheEntry {
		i64 u0xb3ff7b96f0f18625, ; from name: libaot-Xamarin.AndroidX.Lifecycle.ViewModel.Android.so
		i64 u0xc06034423c0d320f, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.116_name, ; name: libaot-Xamarin.AndroidX.Lifecycle.ViewModel.Android.dll.so
		ptr null; void* handle
	}, ; 1386
	%struct.DSOCacheEntry {
		i64 u0xb4159213fd7fbf45, ; from name: aot-System.Net.WebSockets.dll.so
		i64 u0x403cd01c6fb39d89, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.175_name, ; name: libaot-System.Net.WebSockets.dll.so
		ptr null; void* handle
	}, ; 1387
	%struct.DSOCacheEntry {
		i64 u0xb4672c4c84c1748d, ; from name: Microsoft.AspNetCore.Authorization.so
		i64 u0x93d2678ac2e76ce0, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.22_name, ; name: libaot-Microsoft.AspNetCore.Authorization.dll.so
		ptr null; void* handle
	}, ; 1388
	%struct.DSOCacheEntry {
		i64 u0xb48e9e71b06b9446, ; from name: aot-Mono.Android
		i64 u0x359895a3c1bd5685, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.226_name, ; name: libaot-Mono.Android.dll.so
		ptr null; void* handle
	}, ; 1389
	%struct.DSOCacheEntry {
		i64 u0xb49662abc254b87c, ; from name: aot-Microsoft.Extensions.Primitives.so
		i64 u0x9df2f15d2ed44e61, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.66_name, ; name: libaot-Microsoft.Extensions.Primitives.dll.so
		ptr null; void* handle
	}, ; 1390
	%struct.DSOCacheEntry {
		i64 u0xb4b713eeee3a2476, ; from name: libaot-Microsoft.IdentityModel.Tokens.so
		i64 u0x4be8f991cb00f075, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.74_name, ; name: libaot-Microsoft.IdentityModel.Tokens.dll.so
		ptr null; void* handle
	}, ; 1391
	%struct.DSOCacheEntry {
		i64 u0xb4bd7015ecee9d86, ; from name: System.IO.Pipelines
		i64 u0x027079cd6cbb2479, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.158_name, ; name: libaot-System.IO.Pipelines.dll.so
		ptr null; void* handle
	}, ; 1392
	%struct.DSOCacheEntry {
		i64 u0xb532f77e9aff3a8c, ; from name: Microsoft.AspNetCore.Hosting.Abstractions.dll.so
		i64 u0x8e5050b380b35b28, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.25_name, ; name: libaot-Microsoft.AspNetCore.Hosting.Abstractions.dll.so
		ptr null; void* handle
	}, ; 1393
	%struct.DSOCacheEntry {
		i64 u0xb5351dcbaf438cb6, ; from name: libaot-Xamarin.AndroidX.ViewPager.dll.so
		i64 u0xb5351dcbaf438cb6, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.126_name, ; name: libaot-Xamarin.AndroidX.ViewPager.dll.so
		ptr null; void* handle
	}, ; 1394
	%struct.DSOCacheEntry {
		i64 u0xb55c9d9f70cd24e6, ; from name: Syncfusion.Maui.Core.so
		i64 u0x4cfc586bcbdc6c97, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.90_name, ; name: libaot-Syncfusion.Maui.Core.dll.so
		ptr null; void* handle
	}, ; 1395
	%struct.DSOCacheEntry {
		i64 u0xb6268752f2c3d35c, ; from name: Xamarin.AndroidX.Lifecycle.ViewModel.Android.so
		i64 u0xc06034423c0d320f, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.116_name, ; name: libaot-Xamarin.AndroidX.Lifecycle.ViewModel.Android.dll.so
		ptr null; void* handle
	}, ; 1396
	%struct.DSOCacheEntry {
		i64 u0xb66a695203cc113a, ; from name: aot-Microsoft.AspNetCore.Mvc.Core.dll.so
		i64 u0xffcb4d21a593e637, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.34_name, ; name: libaot-Microsoft.AspNetCore.Mvc.Core.dll.so
		ptr null; void* handle
	}, ; 1397
	%struct.DSOCacheEntry {
		i64 u0xb67e551597f07b44, ; from name: libaot-System.Net.Http.Json
		i64 u0x36547dc653fb83c1, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.164_name, ; name: libaot-System.Net.Http.Json.dll.so
		ptr null; void* handle
	}, ; 1398
	%struct.DSOCacheEntry {
		i64 u0xb6933aa44041d152, ; from name: aot-Microsoft.IdentityModel.JsonWebTokens
		i64 u0x0323e786c13d309d, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.70_name, ; name: libaot-Microsoft.IdentityModel.JsonWebTokens.dll.so
		ptr null; void* handle
	}, ; 1399
	%struct.DSOCacheEntry {
		i64 u0xb6ab21527197f7f1, ; from name: libaot-netstandard.dll.so
		i64 u0xb6ab21527197f7f1, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.223_name, ; name: libaot-netstandard.dll.so
		ptr null; void* handle
	}, ; 1400
	%struct.DSOCacheEntry {
		i64 u0xb6acd8fe19d14664, ; from name: aot-Microsoft.AspNetCore.ResponseCaching.Abstractions.so
		i64 u0x2eb68ca0cc467150, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.35_name, ; name: libaot-Microsoft.AspNetCore.ResponseCaching.Abstractions.dll.so
		ptr null; void* handle
	}, ; 1401
	%struct.DSOCacheEntry {
		i64 u0xb6b360215a1ff397, ; from name: aot-System.Text.Encoding.Extensions.dll.so
		i64 u0xf89ed8fc2f5b4b33, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.206_name, ; name: libaot-System.Text.Encoding.Extensions.dll.so
		ptr null; void* handle
	}, ; 1402
	%struct.DSOCacheEntry {
		i64 u0xb6d775e06cf5d43d, ; from name: libaot-System.Drawing
		i64 u0x366c3ed8a6266ffb, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.152_name, ; name: libaot-System.Drawing.dll.so
		ptr null; void* handle
	}, ; 1403
	%struct.DSOCacheEntry {
		i64 u0xb71755f8ee9abc11, ; from name: System.Text.Encoding.Extensions.so
		i64 u0xf89ed8fc2f5b4b33, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.206_name, ; name: libaot-System.Text.Encoding.Extensions.dll.so
		ptr null; void* handle
	}, ; 1404
	%struct.DSOCacheEntry {
		i64 u0xb71bb9a8d392fa40, ; from name: System.Linq.dll.so
		i64 u0x2fb7a3952b307fae, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.162_name, ; name: libaot-System.Linq.dll.so
		ptr null; void* handle
	}, ; 1405
	%struct.DSOCacheEntry {
		i64 u0xb7212c4683a94afe, ; from name: System.Drawing.Primitives
		i64 u0x934cbfda9b40e895, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.151_name, ; name: libaot-System.Drawing.Primitives.dll.so
		ptr null; void* handle
	}, ; 1406
	%struct.DSOCacheEntry {
		i64 u0xb7447de56ee58a01, ; from name: libaot-mscorlib
		i64 u0xd45fa2873eb303d5, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.222_name, ; name: libaot-mscorlib.dll.so
		ptr null; void* handle
	}, ; 1407
	%struct.DSOCacheEntry {
		i64 u0xb7879ed14a810ab4, ; from name: Java.Interop.dll.so
		i64 u0x6ce045494a545eab, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.224_name, ; name: libaot-Java.Interop.dll.so
		ptr null; void* handle
	}, ; 1408
	%struct.DSOCacheEntry {
		i64 u0xb7e290e173bf47eb, ; from name: Microsoft.AspNetCore.SignalR.Client.so
		i64 u0xb9619c5bddc1c8f4, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.38_name, ; name: libaot-Microsoft.AspNetCore.SignalR.Client.dll.so
		ptr null; void* handle
	}, ; 1409
	%struct.DSOCacheEntry {
		i64 u0xb7ec9a9b7ef08a80, ; from name: libaot-System.Net.Http.so
		i64 u0xd925f85604802447, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.165_name, ; name: libaot-System.Net.Http.dll.so
		ptr null; void* handle
	}, ; 1410
	%struct.DSOCacheEntry {
		i64 u0xb7f547ba07c1b723, ; from name: libaot-Microsoft.Extensions.Options.so
		i64 u0xeef607f38ca22ffc, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.65_name, ; name: libaot-Microsoft.Extensions.Options.dll.so
		ptr null; void* handle
	}, ; 1411
	%struct.DSOCacheEntry {
		i64 u0xb80075262344d8c0, ; from name: aot-Xamarin.AndroidX.Lifecycle.LiveData.Core.so
		i64 u0x38e4553d8764fa45, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.115_name, ; name: libaot-Xamarin.AndroidX.Lifecycle.LiveData.Core.dll.so
		ptr null; void* handle
	}, ; 1412
	%struct.DSOCacheEntry {
		i64 u0xb804ec2e45f682de, ; from name: libaot-System.Net.Sockets
		i64 u0x4c5401149da6445e, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.171_name, ; name: libaot-System.Net.Sockets.dll.so
		ptr null; void* handle
	}, ; 1413
	%struct.DSOCacheEntry {
		i64 u0xb80e4cd92e569c19, ; from name: System.Collections.NonGeneric.so
		i64 u0x6fd15fb6a42c9afc, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.137_name, ; name: libaot-System.Collections.NonGeneric.dll.so
		ptr null; void* handle
	}, ; 1414
	%struct.DSOCacheEntry {
		i64 u0xb81a757409e06657, ; from name: aot-System.Security.Cryptography.Csp.dll.so
		i64 u0xb259133b67649ff8, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.199_name, ; name: libaot-System.Security.Cryptography.Csp.dll.so
		ptr null; void* handle
	}, ; 1415
	%struct.DSOCacheEntry {
		i64 u0xb84a0e1d2069c8de, ; from name: aot-System.Configuration.ConfigurationManager.so
		i64 u0x5d3a5af149aed459, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.96_name, ; name: libaot-System.Configuration.ConfigurationManager.dll.so
		ptr null; void* handle
	}, ; 1416
	%struct.DSOCacheEntry {
		i64 u0xb88aaf70962c6080, ; from name: aot-System.Linq.dll.so
		i64 u0x2fb7a3952b307fae, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.162_name, ; name: libaot-System.Linq.dll.so
		ptr null; void* handle
	}, ; 1417
	%struct.DSOCacheEntry {
		i64 u0xb88dcaf37dd4026e, ; from name: aot-Refit.dll.so
		i64 u0x00a2ced568899a5e, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.83_name, ; name: libaot-Refit.dll.so
		ptr null; void* handle
	}, ; 1418
	%struct.DSOCacheEntry {
		i64 u0xb88dd80872e6363c, ; from name: Microsoft.Maui.so
		i64 u0x58cd310024b735d8, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.77_name, ; name: libaot-Microsoft.Maui.dll.so
		ptr null; void* handle
	}, ; 1419
	%struct.DSOCacheEntry {
		i64 u0xb8a22d66f34ff0fd, ; from name: libaot-Microsoft.Identity.Client.so
		i64 u0xd20e64387a412094, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.67_name, ; name: libaot-Microsoft.Identity.Client.dll.so
		ptr null; void* handle
	}, ; 1420
	%struct.DSOCacheEntry {
		i64 u0xb8af35d774e84f71, ; from name: libaot-Microsoft.Extensions.DependencyInjection.so
		i64 u0xe8726752705c8ce9, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.54_name, ; name: libaot-Microsoft.Extensions.DependencyInjection.dll.so
		ptr null; void* handle
	}, ; 1421
	%struct.DSOCacheEntry {
		i64 u0xb8c4e6d79b2bf900, ; from name: System.Private.CoreLib.dll.so
		i64 u0xe1af59ffe15719e2, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.227_name, ; name: libaot-System.Private.CoreLib.dll.so
		ptr null; void* handle
	}, ; 1422
	%struct.DSOCacheEntry {
		i64 u0xb8da9b28d36cd607, ; from name: libaot-Microsoft.Identity.Client.Extensions.Msal.so
		i64 u0x9b88d00d863a5143, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.68_name, ; name: libaot-Microsoft.Identity.Client.Extensions.Msal.dll.so
		ptr null; void* handle
	}, ; 1423
	%struct.DSOCacheEntry {
		i64 u0xb92f532b40f35614, ; from name: libaot-Microsoft.AspNetCore.Connections.Abstractions.dll.so
		i64 u0xb92f532b40f35614, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.24_name, ; name: libaot-Microsoft.AspNetCore.Connections.Abstractions.dll.so
		ptr null; void* handle
	}, ; 1424
	%struct.DSOCacheEntry {
		i64 u0xb94c08b8d7e846e0, ; from name: libaot-System.Net.NetworkInformation.so
		i64 u0xb1bf28cdcefab46b, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.167_name, ; name: libaot-System.Net.NetworkInformation.dll.so
		ptr null; void* handle
	}, ; 1425
	%struct.DSOCacheEntry {
		i64 u0xb9619c5bddc1c8f4, ; from name: libaot-Microsoft.AspNetCore.SignalR.Client.dll.so
		i64 u0xb9619c5bddc1c8f4, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.38_name, ; name: libaot-Microsoft.AspNetCore.SignalR.Client.dll.so
		ptr null; void* handle
	}, ; 1426
	%struct.DSOCacheEntry {
		i64 u0xb97db6485ee8beb7, ; from name: libaot-Microsoft.Extensions.Logging.Abstractions.so
		i64 u0xe6757a5fac324e53, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.63_name, ; name: libaot-Microsoft.Extensions.Logging.Abstractions.dll.so
		ptr null; void* handle
	}, ; 1427
	%struct.DSOCacheEntry {
		i64 u0xb9f88e93036c52ae, ; from name: System.Text.Encoding.CodePages.so
		i64 u0x16262857ad9a2e54, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.205_name, ; name: libaot-System.Text.Encoding.CodePages.dll.so
		ptr null; void* handle
	}, ; 1428
	%struct.DSOCacheEntry {
		i64 u0xb9f94807fef7ac16, ; from name: aot-System.Security.Cryptography.Primitives.so
		i64 u0x7d7dff41d9076267, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.201_name, ; name: libaot-System.Security.Cryptography.Primitives.dll.so
		ptr null; void* handle
	}, ; 1429
	%struct.DSOCacheEntry {
		i64 u0xba0b89c8f85d2eb7, ; from name: aot-Microsoft.AspNetCore.SignalR.Client.Core.so
		i64 u0x0e46bd4e008c7b33, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.39_name, ; name: libaot-Microsoft.AspNetCore.SignalR.Client.Core.dll.so
		ptr null; void* handle
	}, ; 1430
	%struct.DSOCacheEntry {
		i64 u0xba519395d26d13c0, ; from name: Microsoft.Maui.Controls.Xaml.so
		i64 u0x5fc3bca990f46fb4, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.76_name, ; name: libaot-Microsoft.Maui.Controls.Xaml.dll.so
		ptr null; void* handle
	}, ; 1431
	%struct.DSOCacheEntry {
		i64 u0xba8901b864d5546e, ; from name: Xamarin.KotlinX.Serialization.Core.Jvm.dll.so
		i64 u0x757898ba637db46e, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.131_name, ; name: libaot-Xamarin.KotlinX.Serialization.Core.Jvm.dll.so
		ptr null; void* handle
	}, ; 1432
	%struct.DSOCacheEntry {
		i64 u0xba9767ca98b44381, ; from name: aot-System.Linq.Expressions
		i64 u0xda1d7acd827eb320, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.160_name, ; name: libaot-System.Linq.Expressions.dll.so
		ptr null; void* handle
	}, ; 1433
	%struct.DSOCacheEntry {
		i64 u0xba9c90b822ecc673, ; from name: System.Net.WebSockets.Client.so
		i64 u0x0a18b49bebc33444, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.174_name, ; name: libaot-System.Net.WebSockets.Client.dll.so
		ptr null; void* handle
	}, ; 1434
	%struct.DSOCacheEntry {
		i64 u0xbaa4c20ef6f8d83c, ; from name: aot-DocumentFormat.OpenXml.VariableReplacer.Core.so
		i64 u0x785bad4f0559c250, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.19_name, ; name: libaot-DocumentFormat.OpenXml.VariableReplacer.Core.dll.so
		ptr null; void* handle
	}, ; 1435
	%struct.DSOCacheEntry {
		i64 u0xbaaa3fd040ad8585, ; from name: aot-Syncfusion.Licensing
		i64 u0xe0ba2b05be11dec6, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.89_name, ; name: libaot-Syncfusion.Licensing.dll.so
		ptr null; void* handle
	}, ; 1436
	%struct.DSOCacheEntry {
		i64 u0xbaad7d87120b7b2e, ; from name: aot-System.Transactions.Local
		i64 u0x5425eb433f599bc7, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.215_name, ; name: libaot-System.Transactions.Local.dll.so
		ptr null; void* handle
	}, ; 1437
	%struct.DSOCacheEntry {
		i64 u0xbaf7e772d3d8e49a, ; from name: Syncfusion.Licensing.dll.so
		i64 u0xe0ba2b05be11dec6, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.89_name, ; name: libaot-Syncfusion.Licensing.dll.so
		ptr null; void* handle
	}, ; 1438
	%struct.DSOCacheEntry {
		i64 u0xbaf7f6c215e37989, ; from name: aot-Microsoft.Extensions.Configuration.dll.so
		i64 u0x07a45374fab68acc, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.52_name, ; name: libaot-Microsoft.Extensions.Configuration.dll.so
		ptr null; void* handle
	}, ; 1439
	%struct.DSOCacheEntry {
		i64 u0xbb1af0a7aa8398a5, ; from name: System.ComponentModel.Primitives.so
		i64 u0xccde8a4563eee10b, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.141_name, ; name: libaot-System.ComponentModel.Primitives.dll.so
		ptr null; void* handle
	}, ; 1440
	%struct.DSOCacheEntry {
		i64 u0xbb295bd4e1b78198, ; from name: aot-System.ObjectModel.dll.so
		i64 u0x914167d87d2ee1b1, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.177_name, ; name: libaot-System.ObjectModel.dll.so
		ptr null; void* handle
	}, ; 1441
	%struct.DSOCacheEntry {
		i64 u0xbb4d705a517249bc, ; from name: System.Linq.Queryable.dll.so
		i64 u0x5932dbf572fab50a, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.161_name, ; name: libaot-System.Linq.Queryable.dll.so
		ptr null; void* handle
	}, ; 1442
	%struct.DSOCacheEntry {
		i64 u0xbb65706fde942ce3, ; from name: System.Net.Sockets
		i64 u0x4c5401149da6445e, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.171_name, ; name: libaot-System.Net.Sockets.dll.so
		ptr null; void* handle
	}, ; 1443
	%struct.DSOCacheEntry {
		i64 u0xbba986a49febf640, ; from name: libaot-System.Reflection.Emit.ILGeneration.dll.so
		i64 u0xbba986a49febf640, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.182_name, ; name: libaot-System.Reflection.Emit.ILGeneration.dll.so
		ptr null; void* handle
	}, ; 1444
	%struct.DSOCacheEntry {
		i64 u0xbbc0e6e747d7877a, ; from name: libaot-System.Runtime.dll.so
		i64 u0xbbc0e6e747d7877a, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.194_name, ; name: libaot-System.Runtime.dll.so
		ptr null; void* handle
	}, ; 1445
	%struct.DSOCacheEntry {
		i64 u0xbbd180354b67271a, ; from name: System.Runtime.Serialization.Formatters
		i64 u0xc52860d1d6baa3ef, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.190_name, ; name: libaot-System.Runtime.Serialization.Formatters.dll.so
		ptr null; void* handle
	}, ; 1446
	%struct.DSOCacheEntry {
		i64 u0xbc0ec2ae62964c26, ; from name: aot-System.Net.WebClient.dll.so
		i64 u0x4ce9b13ddea58a1b, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.172_name, ; name: libaot-System.Net.WebClient.dll.so
		ptr null; void* handle
	}, ; 1447
	%struct.DSOCacheEntry {
		i64 u0xbc6b5d110b3fa1cd, ; from name: libaot-Microsoft.Bcl.AsyncInterfaces
		i64 u0x9b7e93363193afd3, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.44_name, ; name: libaot-Microsoft.Bcl.AsyncInterfaces.dll.so
		ptr null; void* handle
	}, ; 1448
	%struct.DSOCacheEntry {
		i64 u0xbc704dd581f2421c, ; from name: aot-System.Net.WebHeaderCollection.dll.so
		i64 u0x42b58ea66e808de7, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.173_name, ; name: libaot-System.Net.WebHeaderCollection.dll.so
		ptr null; void* handle
	}, ; 1449
	%struct.DSOCacheEntry {
		i64 u0xbc75b528ca3f8a01, ; from name: libaot-SQLitePCLRaw.provider.e_sqlite3
		i64 u0xa5a20228c07e96ff, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.88_name, ; name: libaot-SQLitePCLRaw.provider.e_sqlite3.dll.so
		ptr null; void* handle
	}, ; 1450
	%struct.DSOCacheEntry {
		i64 u0xbccafec87490651c, ; from name: aot-Microsoft.Extensions.Caching.Memory.dll.so
		i64 u0x331a7f0d6c2c08c9, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.51_name, ; name: libaot-Microsoft.Extensions.Caching.Memory.dll.so
		ptr null; void* handle
	}, ; 1451
	%struct.DSOCacheEntry {
		i64 u0xbcd9b362a4a5b78b, ; from name: aot-Microsoft.AspNetCore.Http.Abstractions
		i64 u0x96d2838521668c05, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.28_name, ; name: libaot-Microsoft.AspNetCore.Http.Abstractions.dll.so
		ptr null; void* handle
	}, ; 1452
	%struct.DSOCacheEntry {
		i64 u0xbcfa7c134d2089f3, ; from name: System.Runtime.Caching
		i64 u0x9a1f1aedbdf3f019, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.100_name, ; name: libaot-System.Runtime.Caching.dll.so
		ptr null; void* handle
	}, ; 1453
	%struct.DSOCacheEntry {
		i64 u0xbd092b8bea6544b5, ; from name: libaot-System.Net.ServerSentEvents.so
		i64 u0x95302b4a91a9ea47, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.99_name, ; name: libaot-System.Net.ServerSentEvents.dll.so
		ptr null; void* handle
	}, ; 1454
	%struct.DSOCacheEntry {
		i64 u0xbd30caec9108afc1, ; from name: libaot-System.Runtime.Serialization.Primitives.dll.so
		i64 u0xbd30caec9108afc1, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.192_name, ; name: libaot-System.Runtime.Serialization.Primitives.dll.so
		ptr null; void* handle
	}, ; 1455
	%struct.DSOCacheEntry {
		i64 u0xbd437a2cdb333d0d, ; from name: Xamarin.AndroidX.ViewPager2
		i64 u0x4595d9c27242b287, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.127_name, ; name: libaot-Xamarin.AndroidX.ViewPager2.dll.so
		ptr null; void* handle
	}, ; 1456
	%struct.DSOCacheEntry {
		i64 u0xbd4a002bce5adfca, ; from name: Xamarin.AndroidX.ViewPager2.dll.so
		i64 u0x4595d9c27242b287, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.127_name, ; name: libaot-Xamarin.AndroidX.ViewPager2.dll.so
		ptr null; void* handle
	}, ; 1457
	%struct.DSOCacheEntry {
		i64 u0xbd6f490f32036ae3, ; from name: aot-System
		i64 u0x7b91ac8ddc528deb, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.221_name, ; name: libaot-System.dll.so
		ptr null; void* handle
	}, ; 1458
	%struct.DSOCacheEntry {
		i64 u0xbdeefd92307ce27b, ; from name: libaot-SQLitePCLRaw.core
		i64 u0x110f85ed0e988dad, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.86_name, ; name: libaot-SQLitePCLRaw.core.dll.so
		ptr null; void* handle
	}, ; 1459
	%struct.DSOCacheEntry {
		i64 u0xbe29531c303a6a58, ; from name: libaot-System.Security.Cryptography.Cng
		i64 u0xe4a5a519ffe8b5e9, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.198_name, ; name: libaot-System.Security.Cryptography.Cng.dll.so
		ptr null; void* handle
	}, ; 1460
	%struct.DSOCacheEntry {
		i64 u0xbe5405e4431d560d, ; from name: libaot-Microsoft.Extensions.ObjectPool
		i64 u0xa951cdbe6a05ef83, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.64_name, ; name: libaot-Microsoft.Extensions.ObjectPool.dll.so
		ptr null; void* handle
	}, ; 1461
	%struct.DSOCacheEntry {
		i64 u0xbe5ea3f3d8c611a9, ; from name: libaot-System.IO.Compression
		i64 u0x07869dd1c492a791, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.155_name, ; name: libaot-System.IO.Compression.dll.so
		ptr null; void* handle
	}, ; 1462
	%struct.DSOCacheEntry {
		i64 u0xbe623527fb86a8ad, ; from name: Xamarin.AndroidX.CustomView.dll.so
		i64 u0xe7b2e898b68d9670, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.111_name, ; name: libaot-Xamarin.AndroidX.CustomView.dll.so
		ptr null; void* handle
	}, ; 1463
	%struct.DSOCacheEntry {
		i64 u0xbe7dc15cf48508a4, ; from name: libaot-System.Diagnostics.Tracing.so
		i64 u0x28371251d401372b, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.150_name, ; name: libaot-System.Diagnostics.Tracing.dll.so
		ptr null; void* handle
	}, ; 1464
	%struct.DSOCacheEntry {
		i64 u0xbe84f8732e7e09b2, ; from name: libaot-System.Collections.NonGeneric
		i64 u0x6fd15fb6a42c9afc, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.137_name, ; name: libaot-System.Collections.NonGeneric.dll.so
		ptr null; void* handle
	}, ; 1465
	%struct.DSOCacheEntry {
		i64 u0xbe865d14c2e4809a, ; from name: aot-Microsoft.AspNetCore.Http.Abstractions.dll.so
		i64 u0x96d2838521668c05, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.28_name, ; name: libaot-Microsoft.AspNetCore.Http.Abstractions.dll.so
		ptr null; void* handle
	}, ; 1466
	%struct.DSOCacheEntry {
		i64 u0xbe90bee1d67c825c, ; from name: libaot-Microsoft.IdentityModel.Protocols.OpenIdConnect.dll.so
		i64 u0xbe90bee1d67c825c, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.73_name, ; name: libaot-Microsoft.IdentityModel.Protocols.OpenIdConnect.dll.so
		ptr null; void* handle
	}, ; 1467
	%struct.DSOCacheEntry {
		i64 u0xbebcdd865485d332, ; from name: Refit.HttpClientFactory.so
		i64 u0xbf4b844c69db6ec0, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.84_name, ; name: libaot-Refit.HttpClientFactory.dll.so
		ptr null; void* handle
	}, ; 1468
	%struct.DSOCacheEntry {
		i64 u0xbee2e9172a00ac70, ; from name: Microsoft.Net.Http.Headers.so
		i64 u0xa81dfd6455f2dc19, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.80_name, ; name: libaot-Microsoft.Net.Http.Headers.dll.so
		ptr null; void* handle
	}, ; 1469
	%struct.DSOCacheEntry {
		i64 u0xbee38d4a88835966, ; from name: Xamarin.AndroidX.AppCompat.AppCompatResources
		i64 u0x456e37cd491657b0, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.104_name, ; name: libaot-Xamarin.AndroidX.AppCompat.AppCompatResources.dll.so
		ptr null; void* handle
	}, ; 1470
	%struct.DSOCacheEntry {
		i64 u0xbeef23a25818ef92, ; from name: aot-System.Collections.Concurrent.so
		i64 u0x65cd21401fecc3dc, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.135_name, ; name: libaot-System.Collections.Concurrent.dll.so
		ptr null; void* handle
	}, ; 1471
	%struct.DSOCacheEntry {
		i64 u0xbf0fe365aae3f4ac, ; from name: libaot-System.Security.Claims.so
		i64 u0xd1ca18d995b9f417, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.196_name, ; name: libaot-System.Security.Claims.dll.so
		ptr null; void* handle
	}, ; 1472
	%struct.DSOCacheEntry {
		i64 u0xbf17812f092168a8, ; from name: Xamarin.AndroidX.Navigation.Fragment.so
		i64 u0xaa2eca1145f3a7cc, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.120_name, ; name: libaot-Xamarin.AndroidX.Navigation.Fragment.dll.so
		ptr null; void* handle
	}, ; 1473
	%struct.DSOCacheEntry {
		i64 u0xbf2042d2ea6ae76c, ; from name: SQLitePCLRaw.core.so
		i64 u0x110f85ed0e988dad, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.86_name, ; name: libaot-SQLitePCLRaw.core.dll.so
		ptr null; void* handle
	}, ; 1474
	%struct.DSOCacheEntry {
		i64 u0xbf4b844c69db6ec0, ; from name: libaot-Refit.HttpClientFactory.dll.so
		i64 u0xbf4b844c69db6ec0, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.84_name, ; name: libaot-Refit.HttpClientFactory.dll.so
		ptr null; void* handle
	}, ; 1475
	%struct.DSOCacheEntry {
		i64 u0xbf7d944f85fcd72c, ; from name: libaot-System.ComponentModel.Annotations.dll.so
		i64 u0xbf7d944f85fcd72c, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.140_name, ; name: libaot-System.ComponentModel.Annotations.dll.so
		ptr null; void* handle
	}, ; 1476
	%struct.DSOCacheEntry {
		i64 u0xbf9968d40b8d7b41, ; from name: libaot-System.Text.Encodings.Web
		i64 u0x209bcec5b3b022b8, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.207_name, ; name: libaot-System.Text.Encodings.Web.dll.so
		ptr null; void* handle
	}, ; 1477
	%struct.DSOCacheEntry {
		i64 u0xbfbd7e9da1ea42b1, ; from name: System.Memory.Data.dll.so
		i64 u0xe03e3baaab589d1e, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.98_name, ; name: libaot-System.Memory.Data.dll.so
		ptr null; void* handle
	}, ; 1478
	%struct.DSOCacheEntry {
		i64 u0xbfe7e2e1145810d3, ; from name: libaot-Xamarin.AndroidX.Collection.Jvm
		i64 u0x1adc5c3038254713, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.107_name, ; name: libaot-Xamarin.AndroidX.Collection.Jvm.dll.so
		ptr null; void* handle
	}, ; 1479
	%struct.DSOCacheEntry {
		i64 u0xbfecb65e918a2b2c, ; from name: aot-CommunityToolkit.Maui.dll.so
		i64 u0x71a72d2d998e2673, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.14_name, ; name: libaot-CommunityToolkit.Maui.dll.so
		ptr null; void* handle
	}, ; 1480
	%struct.DSOCacheEntry {
		i64 u0xc001e0b5cf051ed8, ; from name: aot-Microsoft.IdentityModel.Protocols.OpenIdConnect.dll.so
		i64 u0xbe90bee1d67c825c, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.73_name, ; name: libaot-Microsoft.IdentityModel.Protocols.OpenIdConnect.dll.so
		ptr null; void* handle
	}, ; 1481
	%struct.DSOCacheEntry {
		i64 u0xc04083f5f9aaaaaa, ; from name: Xamarin.AndroidX.AppCompat.so
		i64 u0x42c7eb0880ff24a4, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.103_name, ; name: libaot-Xamarin.AndroidX.AppCompat.dll.so
		ptr null; void* handle
	}, ; 1482
	%struct.DSOCacheEntry {
		i64 u0xc04626b9fe870798, ; from name: libaot-Xamarin.AndroidX.ViewPager2
		i64 u0x4595d9c27242b287, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.127_name, ; name: libaot-Xamarin.AndroidX.ViewPager2.dll.so
		ptr null; void* handle
	}, ; 1483
	%struct.DSOCacheEntry {
		i64 u0xc06034423c0d320f, ; from name: libaot-Xamarin.AndroidX.Lifecycle.ViewModel.Android.dll.so
		i64 u0xc06034423c0d320f, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.116_name, ; name: libaot-Xamarin.AndroidX.Lifecycle.ViewModel.Android.dll.so
		ptr null; void* handle
	}, ; 1484
	%struct.DSOCacheEntry {
		i64 u0xc0a546d62767a5aa, ; from name: SocialMauiApp.so
		i64 u0xec957d270d230c6a, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.11_name, ; name: libaot-SocialMauiApp.dll.so
		ptr null; void* handle
	}, ; 1485
	%struct.DSOCacheEntry {
		i64 u0xc0aba87f31bcb1a6, ; from name: libaot-Microsoft.Extensions.DependencyModel.so
		i64 u0x42c08831b421dece, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.56_name, ; name: libaot-Microsoft.Extensions.DependencyModel.dll.so
		ptr null; void* handle
	}, ; 1486
	%struct.DSOCacheEntry {
		i64 u0xc0aeedd720e912f7, ; from name: System.Net.Requests.dll.so
		i64 u0x2a8da1e7722aaaff, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.169_name, ; name: libaot-System.Net.Requests.dll.so
		ptr null; void* handle
	}, ; 1487
	%struct.DSOCacheEntry {
		i64 u0xc1025af4a29781ab, ; from name: aot-Xamarin.AndroidX.Lifecycle.ViewModel.Android
		i64 u0xc06034423c0d320f, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.116_name, ; name: libaot-Xamarin.AndroidX.Lifecycle.ViewModel.Android.dll.so
		ptr null; void* handle
	}, ; 1488
	%struct.DSOCacheEntry {
		i64 u0xc114e8a396f5423b, ; from name: libaot-Microsoft.EntityFrameworkCore.Relational.dll.so
		i64 u0xc114e8a396f5423b, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.48_name, ; name: libaot-Microsoft.EntityFrameworkCore.Relational.dll.so
		ptr null; void* handle
	}, ; 1489
	%struct.DSOCacheEntry {
		i64 u0xc1303655f6b2546b, ; from name: libaot-Microsoft.Extensions.Primitives.so
		i64 u0x9df2f15d2ed44e61, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.66_name, ; name: libaot-Microsoft.Extensions.Primitives.dll.so
		ptr null; void* handle
	}, ; 1490
	%struct.DSOCacheEntry {
		i64 u0xc138988e54fdd76c, ; from name: aot-System.Text.Json
		i64 u0x9bb35aa4bcef7b80, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.208_name, ; name: libaot-System.Text.Json.dll.so
		ptr null; void* handle
	}, ; 1491
	%struct.DSOCacheEntry {
		i64 u0xc15b6fd586a45201, ; from name: Microsoft.AspNetCore.ResponseCaching.Abstractions.so
		i64 u0x2eb68ca0cc467150, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.35_name, ; name: libaot-Microsoft.AspNetCore.ResponseCaching.Abstractions.dll.so
		ptr null; void* handle
	}, ; 1492
	%struct.DSOCacheEntry {
		i64 u0xc15c72f1c3c8ad87, ; from name: Xamarin.AndroidX.CardView.dll.so
		i64 u0xe9e6021e6533eb43, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.106_name, ; name: libaot-Xamarin.AndroidX.CardView.dll.so
		ptr null; void* handle
	}, ; 1493
	%struct.DSOCacheEntry {
		i64 u0xc1a8940a587abf65, ; from name: aot-System.Collections.Immutable.so
		i64 u0x49e9602a3882bd40, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.136_name, ; name: libaot-System.Collections.Immutable.dll.so
		ptr null; void* handle
	}, ; 1494
	%struct.DSOCacheEntry {
		i64 u0xc1c2cb7af77b8858, ; from name: Microsoft.EntityFrameworkCore
		i64 u0x9694080faa394553, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.46_name, ; name: libaot-Microsoft.EntityFrameworkCore.dll.so
		ptr null; void* handle
	}, ; 1495
	%struct.DSOCacheEntry {
		i64 u0xc1c2ce397d083a5a, ; from name: libaot-System.Security.Cryptography.Encoding
		i64 u0x31145bf76e7d3b7a, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.200_name, ; name: libaot-System.Security.Cryptography.Encoding.dll.so
		ptr null; void* handle
	}, ; 1496
	%struct.DSOCacheEntry {
		i64 u0xc1e2f2216ad409b1, ; from name: aot-Microsoft.AspNetCore.SignalR.Common.dll.so
		i64 u0x1d711f330f5778d7, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.40_name, ; name: libaot-Microsoft.AspNetCore.SignalR.Common.dll.so
		ptr null; void* handle
	}, ; 1497
	%struct.DSOCacheEntry {
		i64 u0xc1ecba3ac926633c, ; from name: System.Private.Xml.Linq.dll.so
		i64 u0x99ef7518b4544507, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.180_name, ; name: libaot-System.Private.Xml.Linq.dll.so
		ptr null; void* handle
	}, ; 1498
	%struct.DSOCacheEntry {
		i64 u0xc21640dba528f7e0, ; from name: aot-SQLitePCLRaw.core.so
		i64 u0x110f85ed0e988dad, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.86_name, ; name: libaot-SQLitePCLRaw.core.dll.so
		ptr null; void* handle
	}, ; 1499
	%struct.DSOCacheEntry {
		i64 u0xc242bbad57886fdb, ; from name: aot-Xamarin.AndroidX.Navigation.Common.dll.so
		i64 u0x2ba3b197006b7954, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.119_name, ; name: libaot-Xamarin.AndroidX.Navigation.Common.dll.so
		ptr null; void* handle
	}, ; 1500
	%struct.DSOCacheEntry {
		i64 u0xc278de356ad8a9e3, ; from name: Microsoft.IdentityModel.Logging
		i64 u0x1175872aaf2edbfe, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.71_name, ; name: libaot-Microsoft.IdentityModel.Logging.dll.so
		ptr null; void* handle
	}, ; 1501
	%struct.DSOCacheEntry {
		i64 u0xc28472d0626d3032, ; from name: libaot-Syncfusion.Maui.Core
		i64 u0x4cfc586bcbdc6c97, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.90_name, ; name: libaot-Syncfusion.Maui.Core.dll.so
		ptr null; void* handle
	}, ; 1502
	%struct.DSOCacheEntry {
		i64 u0xc2a3bca55b573141, ; from name: System.IO.FileSystem.Watcher
		i64 u0xf90aa99869639df6, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.157_name, ; name: libaot-System.IO.FileSystem.Watcher.dll.so
		ptr null; void* handle
	}, ; 1503
	%struct.DSOCacheEntry {
		i64 u0xc2b46ace5ffdf725, ; from name: aot-Java.Interop.so
		i64 u0x6ce045494a545eab, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.224_name, ; name: libaot-Java.Interop.dll.so
		ptr null; void* handle
	}, ; 1504
	%struct.DSOCacheEntry {
		i64 u0xc2da5dca6ccd8b0a, ; from name: libaot-System.Console.dll.so
		i64 u0xc2da5dca6ccd8b0a, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.144_name, ; name: libaot-System.Console.dll.so
		ptr null; void* handle
	}, ; 1505
	%struct.DSOCacheEntry {
		i64 u0xc312ad31e76f5ad4, ; from name: libaot-Xamarin.AndroidX.ViewPager.so
		i64 u0xb5351dcbaf438cb6, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.126_name, ; name: libaot-Xamarin.AndroidX.ViewPager.dll.so
		ptr null; void* handle
	}, ; 1506
	%struct.DSOCacheEntry {
		i64 u0xc331f3da3c16c6e8, ; from name: Xamarin.AndroidX.Navigation.UI.so
		i64 u0x21b741f2635aa744, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.122_name, ; name: libaot-Xamarin.AndroidX.Navigation.UI.dll.so
		ptr null; void* handle
	}, ; 1507
	%struct.DSOCacheEntry {
		i64 u0xc33d984c84dd2123, ; from name: Xamarin.KotlinX.Coroutines.Core.Jvm.so
		i64 u0x811e0efc0e57d069, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.130_name, ; name: libaot-Xamarin.KotlinX.Coroutines.Core.Jvm.dll.so
		ptr null; void* handle
	}, ; 1508
	%struct.DSOCacheEntry {
		i64 u0xc355689a757de932, ; from name: Microsoft.Extensions.FileProviders.Abstractions.dll.so
		i64 u0x82b65efc7b0bc50f, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.60_name, ; name: libaot-Microsoft.Extensions.FileProviders.Abstractions.dll.so
		ptr null; void* handle
	}, ; 1509
	%struct.DSOCacheEntry {
		i64 u0xc3b501bdf4608508, ; from name: aot-System.ComponentModel.so
		i64 u0x38a82198a4cd2a73, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.143_name, ; name: libaot-System.ComponentModel.dll.so
		ptr null; void* handle
	}, ; 1510
	%struct.DSOCacheEntry {
		i64 u0xc419b3385a331963, ; from name: aot-Microsoft.AspNetCore.Http.so
		i64 u0x6caedb1d96a79293, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.27_name, ; name: libaot-Microsoft.AspNetCore.Http.dll.so
		ptr null; void* handle
	}, ; 1511
	%struct.DSOCacheEntry {
		i64 u0xc423b88904a6141e, ; from name: System.Private.Uri.so
		i64 u0xe57af9ab00f5c61d, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.179_name, ; name: libaot-System.Private.Uri.dll.so
		ptr null; void* handle
	}, ; 1512
	%struct.DSOCacheEntry {
		i64 u0xc463e077917aa21d, ; from name: System.Runtime.Serialization.Json
		i64 u0xe012402cc380eac2, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.191_name, ; name: libaot-System.Runtime.Serialization.Json.dll.so
		ptr null; void* handle
	}, ; 1513
	%struct.DSOCacheEntry {
		i64 u0xc4846655abe50016, ; from name: System.ComponentModel.Primitives.dll.so
		i64 u0xccde8a4563eee10b, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.141_name, ; name: libaot-System.ComponentModel.Primitives.dll.so
		ptr null; void* handle
	}, ; 1514
	%struct.DSOCacheEntry {
		i64 u0xc49d1cb598738118, ; from name: aot-System.Security.Cryptography.Algorithms
		i64 u0xd9a989573240dd9c, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.197_name, ; name: libaot-System.Security.Cryptography.Algorithms.dll.so
		ptr null; void* handle
	}, ; 1515
	%struct.DSOCacheEntry {
		i64 u0xc4cd649a98dcb34d, ; from name: libaot-Microsoft.SqlServer.Server.so
		i64 u0x7b4f94432c52afad, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.81_name, ; name: libaot-Microsoft.SqlServer.Server.dll.so
		ptr null; void* handle
	}, ; 1516
	%struct.DSOCacheEntry {
		i64 u0xc4faef92f365cca8, ; from name: System.Text.Encodings.Web.dll.so
		i64 u0x209bcec5b3b022b8, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.207_name, ; name: libaot-System.Text.Encodings.Web.dll.so
		ptr null; void* handle
	}, ; 1517
	%struct.DSOCacheEntry {
		i64 u0xc52860d1d6baa3ef, ; from name: libaot-System.Runtime.Serialization.Formatters.dll.so
		i64 u0xc52860d1d6baa3ef, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.190_name, ; name: libaot-System.Runtime.Serialization.Formatters.dll.so
		ptr null; void* handle
	}, ; 1518
	%struct.DSOCacheEntry {
		i64 u0xc52910bc16fb2ff2, ; from name: Xamarin.AndroidX.Browser.dll.so
		i64 u0x9865c0bf349d1465, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.105_name, ; name: libaot-Xamarin.AndroidX.Browser.dll.so
		ptr null; void* handle
	}, ; 1519
	%struct.DSOCacheEntry {
		i64 u0xc5293b19e4dc230e, ; from name: Xamarin.AndroidX.Navigation.Fragment
		i64 u0xaa2eca1145f3a7cc, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.120_name, ; name: libaot-Xamarin.AndroidX.Navigation.Fragment.dll.so
		ptr null; void* handle
	}, ; 1520
	%struct.DSOCacheEntry {
		i64 u0xc555328858f6cc44, ; from name: aot-Xamarin.AndroidX.DrawerLayout.dll.so
		i64 u0x4bea014989424a56, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.112_name, ; name: libaot-Xamarin.AndroidX.DrawerLayout.dll.so
		ptr null; void* handle
	}, ; 1521
	%struct.DSOCacheEntry {
		i64 u0xc55b7fd2ef4cfb0e, ; from name: aot-Syncfusion.Maui.Sliders.dll.so
		i64 u0x8e1c0d0116b3ef4b, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.92_name, ; name: libaot-Syncfusion.Maui.Sliders.dll.so
		ptr null; void* handle
	}, ; 1522
	%struct.DSOCacheEntry {
		i64 u0xc57583a38ef18e16, ; from name: Microsoft.SqlServer.Server.so
		i64 u0x7b4f94432c52afad, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.81_name, ; name: libaot-Microsoft.SqlServer.Server.dll.so
		ptr null; void* handle
	}, ; 1523
	%struct.DSOCacheEntry {
		i64 u0xc5ba0a4c7df4fb9d, ; from name: libaot-Syncfusion.Maui.Toolkit.resources
		i64 u0xa56606bb1f125004, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.94_name, ; name: libaot-Syncfusion.Maui.Toolkit.resources.dll.so
		ptr null; void* handle
	}, ; 1524
	%struct.DSOCacheEntry {
		i64 u0xc5de3dcae13c325f, ; from name: Microsoft.AspNetCore.SignalR.Client
		i64 u0xb9619c5bddc1c8f4, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.38_name, ; name: libaot-Microsoft.AspNetCore.SignalR.Client.dll.so
		ptr null; void* handle
	}, ; 1525
	%struct.DSOCacheEntry {
		i64 u0xc5df0b3f3dfa1900, ; from name: aot-Microsoft.IdentityModel.Abstractions.dll.so
		i64 u0x41c972d328f102fd, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.69_name, ; name: libaot-Microsoft.IdentityModel.Abstractions.dll.so
		ptr null; void* handle
	}, ; 1526
	%struct.DSOCacheEntry {
		i64 u0xc62658c348b6fcc9, ; from name: Xamarin.AndroidX.SwipeRefreshLayout.dll.so
		i64 u0x6c4e830c0d79912d, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.125_name, ; name: libaot-Xamarin.AndroidX.SwipeRefreshLayout.dll.so
		ptr null; void* handle
	}, ; 1527
	%struct.DSOCacheEntry {
		i64 u0xc65e1dd115430466, ; from name: libaot-System.Security.AccessControl.so
		i64 u0x69dd3c9ffb9c24cd, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.195_name, ; name: libaot-System.Security.AccessControl.dll.so
		ptr null; void* handle
	}, ; 1528
	%struct.DSOCacheEntry {
		i64 u0xc67499861cb31679, ; from name: Microsoft.Extensions.Primitives.so
		i64 u0x9df2f15d2ed44e61, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.66_name, ; name: libaot-Microsoft.Extensions.Primitives.dll.so
		ptr null; void* handle
	}, ; 1529
	%struct.DSOCacheEntry {
		i64 u0xc683d9076e24e0e9, ; from name: libaot-Microsoft.AspNetCore.SignalR.Common.so
		i64 u0x1d711f330f5778d7, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.40_name, ; name: libaot-Microsoft.AspNetCore.SignalR.Common.dll.so
		ptr null; void* handle
	}, ; 1530
	%struct.DSOCacheEntry {
		i64 u0xc6e945a52e0bb21a, ; from name: aot-Xamarin.AndroidX.Collection.Jvm.dll.so
		i64 u0x1adc5c3038254713, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.107_name, ; name: libaot-Xamarin.AndroidX.Collection.Jvm.dll.so
		ptr null; void* handle
	}, ; 1531
	%struct.DSOCacheEntry {
		i64 u0xc6e979123cbb64c1, ; from name: aot-Microsoft.Extensions.Features.dll.so
		i64 u0xaebd3af6eeceb1eb, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.59_name, ; name: libaot-Microsoft.Extensions.Features.dll.so
		ptr null; void* handle
	}, ; 1532
	%struct.DSOCacheEntry {
		i64 u0xc71cbf09d1338f8c, ; from name: Xamarin.Kotlin.StdLib.so
		i64 u0x0c644d6a2b020c43, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.129_name, ; name: libaot-Xamarin.Kotlin.StdLib.dll.so
		ptr null; void* handle
	}, ; 1533
	%struct.DSOCacheEntry {
		i64 u0xc75c0471a25b1f6a, ; from name: libaot-Microsoft.AspNetCore.WebUtilities.so
		i64 u0xa1fa4ded3d9c2cee, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.43_name, ; name: libaot-Microsoft.AspNetCore.WebUtilities.dll.so
		ptr null; void* handle
	}, ; 1534
	%struct.DSOCacheEntry {
		i64 u0xc7d12fdb26a6c6e0, ; from name: aot-System.Reflection.Emit.dll.so
		i64 u0x868be26aba2eea6d, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.184_name, ; name: libaot-System.Reflection.Emit.dll.so
		ptr null; void* handle
	}, ; 1535
	%struct.DSOCacheEntry {
		i64 u0xc8069c736078c2aa, ; from name: libaot-Microsoft.AspNetCore.Http.Extensions
		i64 u0xf01d9d74cda0b70d, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.31_name, ; name: libaot-Microsoft.AspNetCore.Http.Extensions.dll.so
		ptr null; void* handle
	}, ; 1536
	%struct.DSOCacheEntry {
		i64 u0xc8267ba5ccc8128c, ; from name: libaot-System.Text.Json.so
		i64 u0x9bb35aa4bcef7b80, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.208_name, ; name: libaot-System.Text.Json.dll.so
		ptr null; void* handle
	}, ; 1537
	%struct.DSOCacheEntry {
		i64 u0xc84057afeecfc9cd, ; from name: Microsoft.AspNetCore.Hosting.Server.Abstractions.so
		i64 u0xdb28c2f2e5cda275, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.26_name, ; name: libaot-Microsoft.AspNetCore.Hosting.Server.Abstractions.dll.so
		ptr null; void* handle
	}, ; 1538
	%struct.DSOCacheEntry {
		i64 u0xc857104b7d4acd16, ; from name: aot-Microsoft.AspNetCore.Authentication.Core
		i64 u0x2b7aae4ebbc0110d, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.21_name, ; name: libaot-Microsoft.AspNetCore.Authentication.Core.dll.so
		ptr null; void* handle
	}, ; 1539
	%struct.DSOCacheEntry {
		i64 u0xc863d8e02cb11ca0, ; from name: aot-Microsoft.IdentityModel.Protocols
		i64 u0x9037f9d64d16c443, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.72_name, ; name: libaot-Microsoft.IdentityModel.Protocols.dll.so
		ptr null; void* handle
	}, ; 1540
	%struct.DSOCacheEntry {
		i64 u0xc8914d714ccff201, ; from name: aot-System.Private.Uri
		i64 u0xe57af9ab00f5c61d, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.179_name, ; name: libaot-System.Private.Uri.dll.so
		ptr null; void* handle
	}, ; 1541
	%struct.DSOCacheEntry {
		i64 u0xc923182c07880991, ; from name: Microsoft.IdentityModel.Protocols.dll.so
		i64 u0x9037f9d64d16c443, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.72_name, ; name: libaot-Microsoft.IdentityModel.Protocols.dll.so
		ptr null; void* handle
	}, ; 1542
	%struct.DSOCacheEntry {
		i64 u0xc949921e23b9fa61, ; from name: Microsoft.Extensions.Primitives.dll.so
		i64 u0x9df2f15d2ed44e61, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.66_name, ; name: libaot-Microsoft.Extensions.Primitives.dll.so
		ptr null; void* handle
	}, ; 1543
	%struct.DSOCacheEntry {
		i64 u0xc94a5bba3d99dc4e, ; from name: libaot-Xamarin.AndroidX.Activity.so
		i64 u0x8a05820e9e77c0c3, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.102_name, ; name: libaot-Xamarin.AndroidX.Activity.dll.so
		ptr null; void* handle
	}, ; 1544
	%struct.DSOCacheEntry {
		i64 u0xc970f380d453a21d, ; from name: Microsoft.SqlServer.Server.dll.so
		i64 u0x7b4f94432c52afad, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.81_name, ; name: libaot-Microsoft.SqlServer.Server.dll.so
		ptr null; void* handle
	}, ; 1545
	%struct.DSOCacheEntry {
		i64 u0xc9743c0e4f6b49d1, ; from name: Mono.HttpUtility.dll.so
		i64 u0x475325afa16dbfe5, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.82_name, ; name: libaot-Mono.HttpUtility.dll.so
		ptr null; void* handle
	}, ; 1546
	%struct.DSOCacheEntry {
		i64 u0xc97ebcf260fa2ea1, ; from name: Microsoft.AspNetCore.Routing.so
		i64 u0x6872149aac83968a, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.36_name, ; name: libaot-Microsoft.AspNetCore.Routing.dll.so
		ptr null; void* handle
	}, ; 1547
	%struct.DSOCacheEntry {
		i64 u0xc9af4b4c9aeeef27, ; from name: Xamarin.AndroidX.CoordinatorLayout.dll.so
		i64 u0x5cc157f14ad19fc0, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.108_name, ; name: libaot-Xamarin.AndroidX.CoordinatorLayout.dll.so
		ptr null; void* handle
	}, ; 1548
	%struct.DSOCacheEntry {
		i64 u0xc9bc2a8752f335d9, ; from name: aot-System.Net.ServerSentEvents.dll.so
		i64 u0x95302b4a91a9ea47, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.99_name, ; name: libaot-System.Net.ServerSentEvents.dll.so
		ptr null; void* handle
	}, ; 1549
	%struct.DSOCacheEntry {
		i64 u0xca54e64259b1bf9e, ; from name: aot-Xamarin.AndroidX.Navigation.UI.so
		i64 u0x21b741f2635aa744, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.122_name, ; name: libaot-Xamarin.AndroidX.Navigation.UI.dll.so
		ptr null; void* handle
	}, ; 1550
	%struct.DSOCacheEntry {
		i64 u0xca5fd9917ecbba04, ; from name: DocumentFormat.OpenXml.Framework.dll.so
		i64 u0xf959815fea0ec361, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.18_name, ; name: libaot-DocumentFormat.OpenXml.Framework.dll.so
		ptr null; void* handle
	}, ; 1551
	%struct.DSOCacheEntry {
		i64 u0xca7202ee7ecfc36e, ; from name: aot-Microsoft.AspNetCore.Http.Connections.Client.so
		i64 u0x14283e2d731a896b, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.29_name, ; name: libaot-Microsoft.AspNetCore.Http.Connections.Client.dll.so
		ptr null; void* handle
	}, ; 1552
	%struct.DSOCacheEntry {
		i64 u0xca77c6b959d737b7, ; from name: System.Reflection.Primitives.dll.so
		i64 u0x8c58bd1a08c146f5, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.185_name, ; name: libaot-System.Reflection.Primitives.dll.so
		ptr null; void* handle
	}, ; 1553
	%struct.DSOCacheEntry {
		i64 u0xcab94f8009dca58e, ; from name: aot-System.Numerics.Vectors.dll.so
		i64 u0x37fbdff3aa18872d, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.176_name, ; name: libaot-System.Numerics.Vectors.dll.so
		ptr null; void* handle
	}, ; 1554
	%struct.DSOCacheEntry {
		i64 u0xcae6c58f39948621, ; from name: aot-Microsoft.AspNetCore.WebUtilities.dll.so
		i64 u0xa1fa4ded3d9c2cee, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.43_name, ; name: libaot-Microsoft.AspNetCore.WebUtilities.dll.so
		ptr null; void* handle
	}, ; 1555
	%struct.DSOCacheEntry {
		i64 u0xcb072e7f77deac3a, ; from name: Microsoft.EntityFrameworkCore.dll.so
		i64 u0x9694080faa394553, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.46_name, ; name: libaot-Microsoft.EntityFrameworkCore.dll.so
		ptr null; void* handle
	}, ; 1556
	%struct.DSOCacheEntry {
		i64 u0xcb0c13d562c0b850, ; from name: libaot-_Microsoft.Android.Resource.Designer
		i64 u0x9cbca1c74026e295, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.9_name, ; name: libaot-_Microsoft.Android.Resource.Designer.dll.so
		ptr null; void* handle
	}, ; 1557
	%struct.DSOCacheEntry {
		i64 u0xcb2e7317c87dabec, ; from name: aot-System.Text.Encoding.CodePages.so
		i64 u0x16262857ad9a2e54, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.205_name, ; name: libaot-System.Text.Encoding.CodePages.dll.so
		ptr null; void* handle
	}, ; 1558
	%struct.DSOCacheEntry {
		i64 u0xcb35920e94d958ec, ; from name: libaot-Microsoft.Maui.Essentials.so
		i64 u0xdc3ba4771239be2d, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.78_name, ; name: libaot-Microsoft.Maui.Essentials.dll.so
		ptr null; void* handle
	}, ; 1559
	%struct.DSOCacheEntry {
		i64 u0xcb45618372c47127, ; from name: Microsoft.EntityFrameworkCore.Relational
		i64 u0xc114e8a396f5423b, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.48_name, ; name: libaot-Microsoft.EntityFrameworkCore.Relational.dll.so
		ptr null; void* handle
	}, ; 1560
	%struct.DSOCacheEntry {
		i64 u0xcb5e8c0ac13058b9, ; from name: libaot-Microsoft.Extensions.Diagnostics.Abstractions
		i64 u0xd10bb63f997c45a2, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.58_name, ; name: libaot-Microsoft.Extensions.Diagnostics.Abstractions.dll.so
		ptr null; void* handle
	}, ; 1561
	%struct.DSOCacheEntry {
		i64 u0xcb7e41356728fd07, ; from name: libaot-System.ComponentModel.TypeConverter.dll.so
		i64 u0xcb7e41356728fd07, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.142_name, ; name: libaot-System.ComponentModel.TypeConverter.dll.so
		ptr null; void* handle
	}, ; 1562
	%struct.DSOCacheEntry {
		i64 u0xcb94afc7294aab32, ; from name: libaot-Microsoft.Identity.Client
		i64 u0xd20e64387a412094, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.67_name, ; name: libaot-Microsoft.Identity.Client.dll.so
		ptr null; void* handle
	}, ; 1563
	%struct.DSOCacheEntry {
		i64 u0xcc0b9faeaf1ae9cf, ; from name: aot-Microsoft.AspNetCore.Http.Features.so
		i64 u0x621c21d9c3290da0, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.32_name, ; name: libaot-Microsoft.AspNetCore.Http.Features.dll.so
		ptr null; void* handle
	}, ; 1564
	%struct.DSOCacheEntry {
		i64 u0xcc182c3afdc374d6, ; from name: Microsoft.Bcl.AsyncInterfaces
		i64 u0x9b7e93363193afd3, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.44_name, ; name: libaot-Microsoft.Bcl.AsyncInterfaces.dll.so
		ptr null; void* handle
	}, ; 1565
	%struct.DSOCacheEntry {
		i64 u0xcc579b7a6e965d12, ; from name: DocumentFormat.OpenXml.VariableReplacer.Core
		i64 u0x785bad4f0559c250, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.19_name, ; name: libaot-DocumentFormat.OpenXml.VariableReplacer.Core.dll.so
		ptr null; void* handle
	}, ; 1566
	%struct.DSOCacheEntry {
		i64 u0xcca4402beeb8c8a3, ; from name: aot-System.Text.RegularExpressions.dll.so
		i64 u0x7c2c39dae387b52d, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.209_name, ; name: libaot-System.Text.RegularExpressions.dll.so
		ptr null; void* handle
	}, ; 1567
	%struct.DSOCacheEntry {
		i64 u0xcca5b1eb1cdf4b7d, ; from name: aot-System.Threading.Thread.so
		i64 u0x675935a1e3b604dc, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.212_name, ; name: libaot-System.Threading.Thread.dll.so
		ptr null; void* handle
	}, ; 1568
	%struct.DSOCacheEntry {
		i64 u0xccb9deba381482ff, ; from name: aot-Microsoft.AspNetCore.SignalR.Protocols.Json
		i64 u0x53a8edd5eb823442, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.42_name, ; name: libaot-Microsoft.AspNetCore.SignalR.Protocols.Json.dll.so
		ptr null; void* handle
	}, ; 1569
	%struct.DSOCacheEntry {
		i64 u0xccd1eb7d978c0e91, ; from name: System.IO.Pipes.so
		i64 u0x370b7031653c1807, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.159_name, ; name: libaot-System.IO.Pipes.dll.so
		ptr null; void* handle
	}, ; 1570
	%struct.DSOCacheEntry {
		i64 u0xccde8a4563eee10b, ; from name: libaot-System.ComponentModel.Primitives.dll.so
		i64 u0xccde8a4563eee10b, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.141_name, ; name: libaot-System.ComponentModel.Primitives.dll.so
		ptr null; void* handle
	}, ; 1571
	%struct.DSOCacheEntry {
		i64 u0xcce5f0b382db16b7, ; from name: Microsoft.AspNetCore.Http.Connections.Client
		i64 u0x14283e2d731a896b, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.29_name, ; name: libaot-Microsoft.AspNetCore.Http.Connections.Client.dll.so
		ptr null; void* handle
	}, ; 1572
	%struct.DSOCacheEntry {
		i64 u0xccf8b00f02a26598, ; from name: DocumentFormat.OpenXml.so
		i64 u0x456cc421e6ef3bb7, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.17_name, ; name: libaot-DocumentFormat.OpenXml.dll.so
		ptr null; void* handle
	}, ; 1573
	%struct.DSOCacheEntry {
		i64 u0xcd0d76494bb47209, ; from name: System.Data.Common.so
		i64 u0x426a5e4ee84b386c, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.145_name, ; name: libaot-System.Data.Common.dll.so
		ptr null; void* handle
	}, ; 1574
	%struct.DSOCacheEntry {
		i64 u0xcd0e416f27e82ba1, ; from name: aot-Microsoft.Extensions.ObjectPool.so
		i64 u0xa951cdbe6a05ef83, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.64_name, ; name: libaot-Microsoft.Extensions.ObjectPool.dll.so
		ptr null; void* handle
	}, ; 1575
	%struct.DSOCacheEntry {
		i64 u0xcd10a42808629144, ; from name: System.Net.Requests
		i64 u0x2a8da1e7722aaaff, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.169_name, ; name: libaot-System.Net.Requests.dll.so
		ptr null; void* handle
	}, ; 1576
	%struct.DSOCacheEntry {
		i64 u0xcd4697cd83e3de55, ; from name: aot-Microsoft.IdentityModel.Abstractions.so
		i64 u0x41c972d328f102fd, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.69_name, ; name: libaot-Microsoft.IdentityModel.Abstractions.dll.so
		ptr null; void* handle
	}, ; 1577
	%struct.DSOCacheEntry {
		i64 u0xcd4be898cec9c8a4, ; from name: libaot-Microsoft.AspNetCore.Authentication.Core.so
		i64 u0x2b7aae4ebbc0110d, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.21_name, ; name: libaot-Microsoft.AspNetCore.Authentication.Core.dll.so
		ptr null; void* handle
	}, ; 1578
	%struct.DSOCacheEntry {
		i64 u0xcdab467c6caa8aba, ; from name: libaot-System.Web.HttpUtility.dll.so
		i64 u0xcdab467c6caa8aba, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.216_name, ; name: libaot-System.Web.HttpUtility.dll.so
		ptr null; void* handle
	}, ; 1579
	%struct.DSOCacheEntry {
		i64 u0xcdd0c48b6937b21c, ; from name: Xamarin.AndroidX.SwipeRefreshLayout
		i64 u0x6c4e830c0d79912d, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.125_name, ; name: libaot-Xamarin.AndroidX.SwipeRefreshLayout.dll.so
		ptr null; void* handle
	}, ; 1580
	%struct.DSOCacheEntry {
		i64 u0xcdff3275738f5439, ; from name: CommunityToolkit.Mvvm.so
		i64 u0x324cedd7271c2c92, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.16_name, ; name: libaot-CommunityToolkit.Mvvm.dll.so
		ptr null; void* handle
	}, ; 1581
	%struct.DSOCacheEntry {
		i64 u0xce1ac61bf5846469, ; from name: aot-Refit.so
		i64 u0x00a2ced568899a5e, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.83_name, ; name: libaot-Refit.dll.so
		ptr null; void* handle
	}, ; 1582
	%struct.DSOCacheEntry {
		i64 u0xce1faa8870b8190a, ; from name: aot-System.Net.Requests
		i64 u0x2a8da1e7722aaaff, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.169_name, ; name: libaot-System.Net.Requests.dll.so
		ptr null; void* handle
	}, ; 1583
	%struct.DSOCacheEntry {
		i64 u0xce2df5cc02bd8e97, ; from name: aot-System.Reflection.Emit.Lightweight.so
		i64 u0x54f7fbd0a81833fe, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.183_name, ; name: libaot-System.Reflection.Emit.Lightweight.dll.so
		ptr null; void* handle
	}, ; 1584
	%struct.DSOCacheEntry {
		i64 u0xce32c0b2a26b8950, ; from name: aot-Microsoft.Extensions.Options
		i64 u0xeef607f38ca22ffc, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.65_name, ; name: libaot-Microsoft.Extensions.Options.dll.so
		ptr null; void* handle
	}, ; 1585
	%struct.DSOCacheEntry {
		i64 u0xce79b63646d4ede2, ; from name: Microsoft.IdentityModel.JsonWebTokens.dll.so
		i64 u0x0323e786c13d309d, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.70_name, ; name: libaot-Microsoft.IdentityModel.JsonWebTokens.dll.so
		ptr null; void* handle
	}, ; 1586
	%struct.DSOCacheEntry {
		i64 u0xceb64d4330a8af93, ; from name: Microsoft.Data.SqlClient.so
		i64 u0x0b7c60fbe9d8f09b, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.45_name, ; name: libaot-Microsoft.Data.SqlClient.dll.so
		ptr null; void* handle
	}, ; 1587
	%struct.DSOCacheEntry {
		i64 u0xced51368186e7002, ; from name: aot-Microsoft.AspNetCore.Hosting.Server.Abstractions.so
		i64 u0xdb28c2f2e5cda275, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.26_name, ; name: libaot-Microsoft.AspNetCore.Hosting.Server.Abstractions.dll.so
		ptr null; void* handle
	}, ; 1588
	%struct.DSOCacheEntry {
		i64 u0xcf07d50965be005c, ; from name: aot-System.Collections.NonGeneric.dll.so
		i64 u0x6fd15fb6a42c9afc, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.137_name, ; name: libaot-System.Collections.NonGeneric.dll.so
		ptr null; void* handle
	}, ; 1589
	%struct.DSOCacheEntry {
		i64 u0xcf37a833127bfcfc, ; from name: aot-System.Net.Sockets.so
		i64 u0x4c5401149da6445e, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.171_name, ; name: libaot-System.Net.Sockets.dll.so
		ptr null; void* handle
	}, ; 1590
	%struct.DSOCacheEntry {
		i64 u0xcf4209703d981910, ; from name: aot-System.Security.Cryptography.Encoding
		i64 u0x31145bf76e7d3b7a, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.200_name, ; name: libaot-System.Security.Cryptography.Encoding.dll.so
		ptr null; void* handle
	}, ; 1591
	%struct.DSOCacheEntry {
		i64 u0xcf6894d4f4314765, ; from name: aot-Xamarin.AndroidX.CustomView
		i64 u0xe7b2e898b68d9670, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.111_name, ; name: libaot-Xamarin.AndroidX.CustomView.dll.so
		ptr null; void* handle
	}, ; 1592
	%struct.DSOCacheEntry {
		i64 u0xcf8fc898f98b0d34, ; from name: System.Private.Xml.Linq
		i64 u0x99ef7518b4544507, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.180_name, ; name: libaot-System.Private.Xml.Linq.dll.so
		ptr null; void* handle
	}, ; 1593
	%struct.DSOCacheEntry {
		i64 u0xcf9831f228353535, ; from name: libaot-Xamarin.AndroidX.ViewPager
		i64 u0xb5351dcbaf438cb6, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.126_name, ; name: libaot-Xamarin.AndroidX.ViewPager.dll.so
		ptr null; void* handle
	}, ; 1594
	%struct.DSOCacheEntry {
		i64 u0xcfcceaa3180e9f15, ; from name: libaot-System.Security.Claims
		i64 u0xd1ca18d995b9f417, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.196_name, ; name: libaot-System.Security.Claims.dll.so
		ptr null; void* handle
	}, ; 1595
	%struct.DSOCacheEntry {
		i64 u0xd00ab911f3bb07ec, ; from name: Xamarin.Kotlin.StdLib.dll.so
		i64 u0x0c644d6a2b020c43, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.129_name, ; name: libaot-Xamarin.Kotlin.StdLib.dll.so
		ptr null; void* handle
	}, ; 1596
	%struct.DSOCacheEntry {
		i64 u0xd030f32762b3d78f, ; from name: Microsoft.AspNetCore.SignalR.Core
		i64 u0x73dd04543af2c841, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.41_name, ; name: libaot-Microsoft.AspNetCore.SignalR.Core.dll.so
		ptr null; void* handle
	}, ; 1597
	%struct.DSOCacheEntry {
		i64 u0xd03465e00602461b, ; from name: aot-Microsoft.EntityFrameworkCore.Relational.so
		i64 u0xc114e8a396f5423b, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.48_name, ; name: libaot-Microsoft.EntityFrameworkCore.Relational.dll.so
		ptr null; void* handle
	}, ; 1598
	%struct.DSOCacheEntry {
		i64 u0xd03744c4cfadcfb4, ; from name: Microsoft.Extensions.DependencyInjection.Abstractions.dll.so
		i64 u0x4643d8f925d8e6b7, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.55_name, ; name: libaot-Microsoft.Extensions.DependencyInjection.Abstractions.dll.so
		ptr null; void* handle
	}, ; 1599
	%struct.DSOCacheEntry {
		i64 u0xd042075e5c1f43f1, ; from name: libaot-System.Linq.Expressions
		i64 u0xda1d7acd827eb320, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.160_name, ; name: libaot-System.Linq.Expressions.dll.so
		ptr null; void* handle
	}, ; 1600
	%struct.DSOCacheEntry {
		i64 u0xd09fa589a39c6f4e, ; from name: aot-System.Net.NameResolution.so
		i64 u0x7f280e9be5453eba, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.166_name, ; name: libaot-System.Net.NameResolution.dll.so
		ptr null; void* handle
	}, ; 1601
	%struct.DSOCacheEntry {
		i64 u0xd0ab1ba27ca6ab69, ; from name: aot-System.Text.Json.dll.so
		i64 u0x9bb35aa4bcef7b80, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.208_name, ; name: libaot-System.Text.Json.dll.so
		ptr null; void* handle
	}, ; 1602
	%struct.DSOCacheEntry {
		i64 u0xd0e82017367ac826, ; from name: libaot-System.Security.Cryptography.dll.so
		i64 u0xd0e82017367ac826, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.203_name, ; name: libaot-System.Security.Cryptography.dll.so
		ptr null; void* handle
	}, ; 1603
	%struct.DSOCacheEntry {
		i64 u0xd0fc7ac60a41b4c9, ; from name: System.Memory.dll.so
		i64 u0xad582851e7d05243, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.163_name, ; name: libaot-System.Memory.dll.so
		ptr null; void* handle
	}, ; 1604
	%struct.DSOCacheEntry {
		i64 u0xd10bb63f997c45a2, ; from name: libaot-Microsoft.Extensions.Diagnostics.Abstractions.dll.so
		i64 u0xd10bb63f997c45a2, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.58_name, ; name: libaot-Microsoft.Extensions.Diagnostics.Abstractions.dll.so
		ptr null; void* handle
	}, ; 1605
	%struct.DSOCacheEntry {
		i64 u0xd11cfc57ceff8be8, ; from name: Xamarin.AndroidX.SwipeRefreshLayout.so
		i64 u0x6c4e830c0d79912d, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.125_name, ; name: libaot-Xamarin.AndroidX.SwipeRefreshLayout.dll.so
		ptr null; void* handle
	}, ; 1606
	%struct.DSOCacheEntry {
		i64 u0xd16fd7fb9bbcd43e, ; from name: Microsoft.Extensions.Diagnostics.Abstractions
		i64 u0xd10bb63f997c45a2, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.58_name, ; name: libaot-Microsoft.Extensions.Diagnostics.Abstractions.dll.so
		ptr null; void* handle
	}, ; 1607
	%struct.DSOCacheEntry {
		i64 u0xd1868c1d514955d6, ; from name: aot-Xamarin.AndroidX.Lifecycle.Common.Jvm
		i64 u0x2ec8d2dcf2c4a71b, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.114_name, ; name: libaot-Xamarin.AndroidX.Lifecycle.Common.Jvm.dll.so
		ptr null; void* handle
	}, ; 1608
	%struct.DSOCacheEntry {
		i64 u0xd1b0f71bd2716b9b, ; from name: aot-System.Security.Cryptography.X509Certificates.so
		i64 u0x86ff945e422694f9, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.202_name, ; name: libaot-System.Security.Cryptography.X509Certificates.dll.so
		ptr null; void* handle
	}, ; 1609
	%struct.DSOCacheEntry {
		i64 u0xd1ca18d995b9f417, ; from name: libaot-System.Security.Claims.dll.so
		i64 u0xd1ca18d995b9f417, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.196_name, ; name: libaot-System.Security.Claims.dll.so
		ptr null; void* handle
	}, ; 1610
	%struct.DSOCacheEntry {
		i64 u0xd1d253eb41908cb5, ; from name: aot-Xamarin.AndroidX.Fragment
		i64 u0x8ab6d3431da5497e, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.113_name, ; name: libaot-Xamarin.AndroidX.Fragment.dll.so
		ptr null; void* handle
	}, ; 1611
	%struct.DSOCacheEntry {
		i64 u0xd1dd937e219b0e6a, ; from name: Microsoft.Extensions.Configuration.Abstractions.so
		i64 u0xd6a1ce9f7ccd35cb, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.53_name, ; name: libaot-Microsoft.Extensions.Configuration.Abstractions.dll.so
		ptr null; void* handle
	}, ; 1612
	%struct.DSOCacheEntry {
		i64 u0xd1e2c6018c16f4d9, ; from name: aot-Microsoft.AspNetCore.Mvc.Abstractions
		i64 u0x8be639a423b6d017, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.33_name, ; name: libaot-Microsoft.AspNetCore.Mvc.Abstractions.dll.so
		ptr null; void* handle
	}, ; 1613
	%struct.DSOCacheEntry {
		i64 u0xd1ecf89ac84cbff0, ; from name: aot-SocialMediaMaui.Shared
		i64 u0x12448631a200ce9a, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.10_name, ; name: libaot-SocialMediaMaui.Shared.dll.so
		ptr null; void* handle
	}, ; 1614
	%struct.DSOCacheEntry {
		i64 u0xd20e64387a412094, ; from name: libaot-Microsoft.Identity.Client.dll.so
		i64 u0xd20e64387a412094, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.67_name, ; name: libaot-Microsoft.Identity.Client.dll.so
		ptr null; void* handle
	}, ; 1615
	%struct.DSOCacheEntry {
		i64 u0xd21400fda411ca3f, ; from name: aot-System.Drawing.so
		i64 u0x366c3ed8a6266ffb, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.152_name, ; name: libaot-System.Drawing.dll.so
		ptr null; void* handle
	}, ; 1616
	%struct.DSOCacheEntry {
		i64 u0xd23982a3d889538e, ; from name: aot-System.Diagnostics.StackTrace.dll.so
		i64 u0xb21e783430e22a93, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.148_name, ; name: libaot-System.Diagnostics.StackTrace.dll.so
		ptr null; void* handle
	}, ; 1617
	%struct.DSOCacheEntry {
		i64 u0xd24573ad15205bc1, ; from name: Xamarin.AndroidX.Core.so
		i64 u0x28a319e875b39488, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.109_name, ; name: libaot-Xamarin.AndroidX.Core.dll.so
		ptr null; void* handle
	}, ; 1618
	%struct.DSOCacheEntry {
		i64 u0xd2475965a9e31837, ; from name: aot-System.Threading.so
		i64 u0x5f435aa7f5fde870, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.214_name, ; name: libaot-System.Threading.dll.so
		ptr null; void* handle
	}, ; 1619
	%struct.DSOCacheEntry {
		i64 u0xd27577a51350fead, ; from name: aot-Syncfusion.Maui.Toolkit.dll.so
		i64 u0x2d6521795fa92605, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.93_name, ; name: libaot-Syncfusion.Maui.Toolkit.dll.so
		ptr null; void* handle
	}, ; 1620
	%struct.DSOCacheEntry {
		i64 u0xd284b7f38a15a64e, ; from name: libaot-System.Net.Security.so
		i64 u0x1271045d1561acf0, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.170_name, ; name: libaot-System.Net.Security.dll.so
		ptr null; void* handle
	}, ; 1621
	%struct.DSOCacheEntry {
		i64 u0xd29891b97b859f98, ; from name: aot-System.Xml.XDocument.dll.so
		i64 u0x823af1c93e519784, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.219_name, ; name: libaot-System.Xml.XDocument.dll.so
		ptr null; void* handle
	}, ; 1622
	%struct.DSOCacheEntry {
		i64 u0xd2ea9e8ecceb80ec, ; from name: libaot-System.IO.FileSystem.Watcher.so
		i64 u0xf90aa99869639df6, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.157_name, ; name: libaot-System.IO.FileSystem.Watcher.dll.so
		ptr null; void* handle
	}, ; 1623
	%struct.DSOCacheEntry {
		i64 u0xd2edb7e5a131e66e, ; from name: aot-Xamarin.AndroidX.Navigation.Runtime.dll.so
		i64 u0x79a319cd6e76a263, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.121_name, ; name: libaot-Xamarin.AndroidX.Navigation.Runtime.dll.so
		ptr null; void* handle
	}, ; 1624
	%struct.DSOCacheEntry {
		i64 u0xd2fdff8f4deb4b53, ; from name: aot-System.Net.Http.so
		i64 u0xd925f85604802447, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.165_name, ; name: libaot-System.Net.Http.dll.so
		ptr null; void* handle
	}, ; 1625
	%struct.DSOCacheEntry {
		i64 u0xd333d0af9e423810, ; from name: System.Runtime.InteropServices
		i64 u0x5ae6db1ddadc230b, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.187_name, ; name: libaot-System.Runtime.InteropServices.dll.so
		ptr null; void* handle
	}, ; 1626
	%struct.DSOCacheEntry {
		i64 u0xd34809bcacf156ee, ; from name: libaot-Microsoft.Extensions.Diagnostics.dll.so
		i64 u0xd34809bcacf156ee, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.57_name, ; name: libaot-Microsoft.Extensions.Diagnostics.dll.so
		ptr null; void* handle
	}, ; 1627
	%struct.DSOCacheEntry {
		i64 u0xd39ab212f0d7ac2d, ; from name: aot-SocialMauiApp.so
		i64 u0xec957d270d230c6a, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.11_name, ; name: libaot-SocialMauiApp.dll.so
		ptr null; void* handle
	}, ; 1628
	%struct.DSOCacheEntry {
		i64 u0xd3b374a020395487, ; from name: libaot-Xamarin.AndroidX.Core
		i64 u0x28a319e875b39488, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.109_name, ; name: libaot-Xamarin.AndroidX.Core.dll.so
		ptr null; void* handle
	}, ; 1629
	%struct.DSOCacheEntry {
		i64 u0xd3edcc1f25459a50, ; from name: System.Reflection.Emit
		i64 u0x868be26aba2eea6d, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.184_name, ; name: libaot-System.Reflection.Emit.dll.so
		ptr null; void* handle
	}, ; 1630
	%struct.DSOCacheEntry {
		i64 u0xd41deae9023bd65f, ; from name: libaot-System.Runtime.Caching
		i64 u0x9a1f1aedbdf3f019, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.100_name, ; name: libaot-System.Runtime.Caching.dll.so
		ptr null; void* handle
	}, ; 1631
	%struct.DSOCacheEntry {
		i64 u0xd4257a83001f39b1, ; from name: aot-System.Reflection.Emit.ILGeneration.dll.so
		i64 u0xbba986a49febf640, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.182_name, ; name: libaot-System.Reflection.Emit.ILGeneration.dll.so
		ptr null; void* handle
	}, ; 1632
	%struct.DSOCacheEntry {
		i64 u0xd45fa2873eb303d5, ; from name: libaot-mscorlib.dll.so
		i64 u0xd45fa2873eb303d5, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.222_name, ; name: libaot-mscorlib.dll.so
		ptr null; void* handle
	}, ; 1633
	%struct.DSOCacheEntry {
		i64 u0xd491cf6b917c2312, ; from name: aot-System.Drawing.dll.so
		i64 u0x366c3ed8a6266ffb, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.152_name, ; name: libaot-System.Drawing.dll.so
		ptr null; void* handle
	}, ; 1634
	%struct.DSOCacheEntry {
		i64 u0xd499c9a0b985ce58, ; from name: libaot-System.Xml.ReaderWriter.so
		i64 u0xdfabadcf47a52f12, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.218_name, ; name: libaot-System.Xml.ReaderWriter.dll.so
		ptr null; void* handle
	}, ; 1635
	%struct.DSOCacheEntry {
		i64 u0xd4b0f0a84d93fec7, ; from name: aot-DocumentFormat.OpenXml
		i64 u0x456cc421e6ef3bb7, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.17_name, ; name: libaot-DocumentFormat.OpenXml.dll.so
		ptr null; void* handle
	}, ; 1636
	%struct.DSOCacheEntry {
		i64 u0xd4bb298a95f7827b, ; from name: aot-Xamarin.AndroidX.DrawerLayout.so
		i64 u0x4bea014989424a56, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.112_name, ; name: libaot-Xamarin.AndroidX.DrawerLayout.dll.so
		ptr null; void* handle
	}, ; 1637
	%struct.DSOCacheEntry {
		i64 u0xd4ca367710a2ffa1, ; from name: System.Collections.NonGeneric.dll.so
		i64 u0x6fd15fb6a42c9afc, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.137_name, ; name: libaot-System.Collections.NonGeneric.dll.so
		ptr null; void* handle
	}, ; 1638
	%struct.DSOCacheEntry {
		i64 u0xd4d27f08b1450804, ; from name: System.Runtime.so
		i64 u0xbbc0e6e747d7877a, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.194_name, ; name: libaot-System.Runtime.dll.so
		ptr null; void* handle
	}, ; 1639
	%struct.DSOCacheEntry {
		i64 u0xd4e4ee3194e8b282, ; from name: System.Security.Cryptography.Algorithms.dll.so
		i64 u0xd9a989573240dd9c, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.197_name, ; name: libaot-System.Security.Cryptography.Algorithms.dll.so
		ptr null; void* handle
	}, ; 1640
	%struct.DSOCacheEntry {
		i64 u0xd4f83afd39b27ac3, ; from name: Xamarin.AndroidX.Collection.Jvm.so
		i64 u0x1adc5c3038254713, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.107_name, ; name: libaot-Xamarin.AndroidX.Collection.Jvm.dll.so
		ptr null; void* handle
	}, ; 1641
	%struct.DSOCacheEntry {
		i64 u0xd4ff4c88bc659a62, ; from name: libaot-Xamarin.AndroidX.SwipeRefreshLayout.so
		i64 u0x6c4e830c0d79912d, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.125_name, ; name: libaot-Xamarin.AndroidX.SwipeRefreshLayout.dll.so
		ptr null; void* handle
	}, ; 1642
	%struct.DSOCacheEntry {
		i64 u0xd52767571e1f65af, ; from name: aot-System.Runtime.dll.so
		i64 u0xbbc0e6e747d7877a, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.194_name, ; name: libaot-System.Runtime.dll.so
		ptr null; void* handle
	}, ; 1643
	%struct.DSOCacheEntry {
		i64 u0xd53dbbc20753aa5b, ; from name: aot-Azure.Core.so
		i64 u0x821f528a92d55dea, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.12_name, ; name: libaot-Azure.Core.dll.so
		ptr null; void* handle
	}, ; 1644
	%struct.DSOCacheEntry {
		i64 u0xd54015e1158450eb, ; from name: libaot-System.Net.WebHeaderCollection
		i64 u0x42b58ea66e808de7, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.173_name, ; name: libaot-System.Net.WebHeaderCollection.dll.so
		ptr null; void* handle
	}, ; 1645
	%struct.DSOCacheEntry {
		i64 u0xd5507e11a2b2839f, ; from name: Xamarin.AndroidX.Lifecycle.ViewModelSavedState
		i64 u0x9b809dc726e0140e, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.117_name, ; name: libaot-Xamarin.AndroidX.Lifecycle.ViewModelSavedState.dll.so
		ptr null; void* handle
	}, ; 1646
	%struct.DSOCacheEntry {
		i64 u0xd571447114c5aacb, ; from name: aot-System.Linq.Expressions.dll.so
		i64 u0xda1d7acd827eb320, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.160_name, ; name: libaot-System.Linq.Expressions.dll.so
		ptr null; void* handle
	}, ; 1647
	%struct.DSOCacheEntry {
		i64 u0xd5a32aabca66733e, ; from name: System.Security.Cryptography.Csp.so
		i64 u0xb259133b67649ff8, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.199_name, ; name: libaot-System.Security.Cryptography.Csp.dll.so
		ptr null; void* handle
	}, ; 1648
	%struct.DSOCacheEntry {
		i64 u0xd5b70d100fbba437, ; from name: aot-Microsoft.Extensions.Configuration.so
		i64 u0x07a45374fab68acc, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.52_name, ; name: libaot-Microsoft.Extensions.Configuration.dll.so
		ptr null; void* handle
	}, ; 1649
	%struct.DSOCacheEntry {
		i64 u0xd5c7ef9eda8c3f92, ; from name: System.Runtime.Loader.so
		i64 u0x55c25b4d27ae6f23, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.188_name, ; name: libaot-System.Runtime.Loader.dll.so
		ptr null; void* handle
	}, ; 1650
	%struct.DSOCacheEntry {
		i64 u0xd5e140227aa0bc45, ; from name: aot-System.Xml.ReaderWriter.so
		i64 u0xdfabadcf47a52f12, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.218_name, ; name: libaot-System.Xml.ReaderWriter.dll.so
		ptr null; void* handle
	}, ; 1651
	%struct.DSOCacheEntry {
		i64 u0xd60daf7bc27d5a9e, ; from name: aot-System.IdentityModel.Tokens.Jwt.dll.so
		i64 u0xe05faae6d518aca9, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.97_name, ; name: libaot-System.IdentityModel.Tokens.Jwt.dll.so
		ptr null; void* handle
	}, ; 1652
	%struct.DSOCacheEntry {
		i64 u0xd61d04ec1e3f44d3, ; from name: Xamarin.Google.Android.Material.dll.so
		i64 u0x937abea3fe5296af, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.128_name, ; name: libaot-Xamarin.Google.Android.Material.dll.so
		ptr null; void* handle
	}, ; 1653
	%struct.DSOCacheEntry {
		i64 u0xd665e322112a3399, ; from name: Microsoft.CSharp.so
		i64 u0xe38bfeec71b3b67d, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.132_name, ; name: libaot-Microsoft.CSharp.dll.so
		ptr null; void* handle
	}, ; 1654
	%struct.DSOCacheEntry {
		i64 u0xd6694f8359737e4e, ; from name: Xamarin.AndroidX.SavedState
		i64 u0x039588659cdd2f6a, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.124_name, ; name: libaot-Xamarin.AndroidX.SavedState.dll.so
		ptr null; void* handle
	}, ; 1655
	%struct.DSOCacheEntry {
		i64 u0xd6a1ce9f7ccd35cb, ; from name: libaot-Microsoft.Extensions.Configuration.Abstractions.dll.so
		i64 u0xd6a1ce9f7ccd35cb, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.53_name, ; name: libaot-Microsoft.Extensions.Configuration.Abstractions.dll.so
		ptr null; void* handle
	}, ; 1656
	%struct.DSOCacheEntry {
		i64 u0xd6a7a25e912a138e, ; from name: libaot-System
		i64 u0x7b91ac8ddc528deb, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.221_name, ; name: libaot-System.dll.so
		ptr null; void* handle
	}, ; 1657
	%struct.DSOCacheEntry {
		i64 u0xd706634cb48c7836, ; from name: System.Buffers.dll.so
		i64 u0x5988bd4997e5d75f, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.134_name, ; name: libaot-System.Buffers.dll.so
		ptr null; void* handle
	}, ; 1658
	%struct.DSOCacheEntry {
		i64 u0xd7209536fbc31446, ; from name: System.Numerics.Vectors.so
		i64 u0x37fbdff3aa18872d, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.176_name, ; name: libaot-System.Numerics.Vectors.dll.so
		ptr null; void* handle
	}, ; 1659
	%struct.DSOCacheEntry {
		i64 u0xd73c93ec71579d1d, ; from name: aot-System.Security.Cryptography.ProtectedData.dll.so
		i64 u0x67faf2828acf47d0, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.101_name, ; name: libaot-System.Security.Cryptography.ProtectedData.dll.so
		ptr null; void* handle
	}, ; 1660
	%struct.DSOCacheEntry {
		i64 u0xd73d5f2325f4e10a, ; from name: libaot-System.ComponentModel.Primitives.so
		i64 u0xccde8a4563eee10b, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.141_name, ; name: libaot-System.ComponentModel.Primitives.dll.so
		ptr null; void* handle
	}, ; 1661
	%struct.DSOCacheEntry {
		i64 u0xd74a91803276a8a5, ; from name: SQLitePCLRaw.batteries_v2.so
		i64 u0x418d89fb2901d219, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.85_name, ; name: libaot-SQLitePCLRaw.batteries_v2.dll.so
		ptr null; void* handle
	}, ; 1662
	%struct.DSOCacheEntry {
		i64 u0xd768c9ea2be5db37, ; from name: libaot-Microsoft.AspNetCore.Authorization
		i64 u0x93d2678ac2e76ce0, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.22_name, ; name: libaot-Microsoft.AspNetCore.Authorization.dll.so
		ptr null; void* handle
	}, ; 1663
	%struct.DSOCacheEntry {
		i64 u0xd7845c8bf07d04e9, ; from name: aot-System.Console.dll.so
		i64 u0xc2da5dca6ccd8b0a, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.144_name, ; name: libaot-System.Console.dll.so
		ptr null; void* handle
	}, ; 1664
	%struct.DSOCacheEntry {
		i64 u0xd788c113da082c63, ; from name: libaot-Mono.Android
		i64 u0x359895a3c1bd5685, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.226_name, ; name: libaot-Mono.Android.dll.so
		ptr null; void* handle
	}, ; 1665
	%struct.DSOCacheEntry {
		i64 u0xd7b6ffebc4046e48, ; from name: aot-System.Security.Principal.Windows.dll.so
		i64 u0x29629cd3c238a2b4, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.204_name, ; name: libaot-System.Security.Principal.Windows.dll.so
		ptr null; void* handle
	}, ; 1666
	%struct.DSOCacheEntry {
		i64 u0xd7cc1f038316cd73, ; from name: aot-Microsoft.AspNetCore.Hosting.Abstractions.so
		i64 u0x8e5050b380b35b28, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.25_name, ; name: libaot-Microsoft.AspNetCore.Hosting.Abstractions.dll.so
		ptr null; void* handle
	}, ; 1667
	%struct.DSOCacheEntry {
		i64 u0xd820f7778b6dda67, ; from name: libaot-Xamarin.AndroidX.Fragment.so
		i64 u0x8ab6d3431da5497e, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.113_name, ; name: libaot-Xamarin.AndroidX.Fragment.dll.so
		ptr null; void* handle
	}, ; 1668
	%struct.DSOCacheEntry {
		i64 u0xd86251721c84b1ee, ; from name: aot-System.Diagnostics.DiagnosticSource.dll.so
		i64 u0x77156c94b5eff927, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.146_name, ; name: libaot-System.Diagnostics.DiagnosticSource.dll.so
		ptr null; void* handle
	}, ; 1669
	%struct.DSOCacheEntry {
		i64 u0xd86d28f8c7e102bc, ; from name: libaot-Microsoft.Maui.Controls.Xaml
		i64 u0x5fc3bca990f46fb4, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.76_name, ; name: libaot-Microsoft.Maui.Controls.Xaml.dll.so
		ptr null; void* handle
	}, ; 1670
	%struct.DSOCacheEntry {
		i64 u0xd8a5fce77ac8880f, ; from name: libaot-Microsoft.Maui.Controls
		i64 u0x7f174db5a2c913e7, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.75_name, ; name: libaot-Microsoft.Maui.Controls.dll.so
		ptr null; void* handle
	}, ; 1671
	%struct.DSOCacheEntry {
		i64 u0xd8b23283eb26ad3e, ; from name: aot-System.Linq.so
		i64 u0x2fb7a3952b307fae, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.162_name, ; name: libaot-System.Linq.dll.so
		ptr null; void* handle
	}, ; 1672
	%struct.DSOCacheEntry {
		i64 u0xd8f9f521c4bf6067, ; from name: Microsoft.Extensions.Caching.Memory.so
		i64 u0x331a7f0d6c2c08c9, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.51_name, ; name: libaot-Microsoft.Extensions.Caching.Memory.dll.so
		ptr null; void* handle
	}, ; 1673
	%struct.DSOCacheEntry {
		i64 u0xd925f85604802447, ; from name: libaot-System.Net.Http.dll.so
		i64 u0xd925f85604802447, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.165_name, ; name: libaot-System.Net.Http.dll.so
		ptr null; void* handle
	}, ; 1674
	%struct.DSOCacheEntry {
		i64 u0xd9412bb184347733, ; from name: aot-System.Memory.Data.dll.so
		i64 u0xe03e3baaab589d1e, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.98_name, ; name: libaot-System.Memory.Data.dll.so
		ptr null; void* handle
	}, ; 1675
	%struct.DSOCacheEntry {
		i64 u0xd950d7e2c7cce3f2, ; from name: libaot-Microsoft.IdentityModel.Tokens
		i64 u0x4be8f991cb00f075, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.74_name, ; name: libaot-Microsoft.IdentityModel.Tokens.dll.so
		ptr null; void* handle
	}, ; 1676
	%struct.DSOCacheEntry {
		i64 u0xd9a989573240dd9c, ; from name: libaot-System.Security.Cryptography.Algorithms.dll.so
		i64 u0xd9a989573240dd9c, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.197_name, ; name: libaot-System.Security.Cryptography.Algorithms.dll.so
		ptr null; void* handle
	}, ; 1677
	%struct.DSOCacheEntry {
		i64 u0xd9f772c73b7aa267, ; from name: aot-Xamarin.AndroidX.DrawerLayout
		i64 u0x4bea014989424a56, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.112_name, ; name: libaot-Xamarin.AndroidX.DrawerLayout.dll.so
		ptr null; void* handle
	}, ; 1678
	%struct.DSOCacheEntry {
		i64 u0xda0d95c14abe3cf5, ; from name: Xamarin.AndroidX.AppCompat.AppCompatResources.dll.so
		i64 u0x456e37cd491657b0, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.104_name, ; name: libaot-Xamarin.AndroidX.AppCompat.AppCompatResources.dll.so
		ptr null; void* handle
	}, ; 1679
	%struct.DSOCacheEntry {
		i64 u0xda1d7acd827eb320, ; from name: libaot-System.Linq.Expressions.dll.so
		i64 u0xda1d7acd827eb320, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.160_name, ; name: libaot-System.Linq.Expressions.dll.so
		ptr null; void* handle
	}, ; 1680
	%struct.DSOCacheEntry {
		i64 u0xda1dfa4c534a9251, ; from name: Microsoft.Extensions.DependencyInjection
		i64 u0xe8726752705c8ce9, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.54_name, ; name: libaot-Microsoft.Extensions.DependencyInjection.dll.so
		ptr null; void* handle
	}, ; 1681
	%struct.DSOCacheEntry {
		i64 u0xda2e35ea217c418e, ; from name: libaot-Azure.Identity.so
		i64 u0xf309d7d68dc0ac48, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.13_name, ; name: libaot-Azure.Identity.dll.so
		ptr null; void* handle
	}, ; 1682
	%struct.DSOCacheEntry {
		i64 u0xda3e4fae2b1e564e, ; from name: aot-Microsoft.Extensions.Caching.Abstractions.so
		i64 u0x988026893039cd51, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.50_name, ; name: libaot-Microsoft.Extensions.Caching.Abstractions.dll.so
		ptr null; void* handle
	}, ; 1683
	%struct.DSOCacheEntry {
		i64 u0xda3e671b21710f18, ; from name: aot-Java.Interop
		i64 u0x6ce045494a545eab, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.224_name, ; name: libaot-Java.Interop.dll.so
		ptr null; void* handle
	}, ; 1684
	%struct.DSOCacheEntry {
		i64 u0xda57789a55e0db56, ; from name: System.ComponentModel.Annotations.dll.so
		i64 u0xbf7d944f85fcd72c, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.140_name, ; name: libaot-System.ComponentModel.Annotations.dll.so
		ptr null; void* handle
	}, ; 1685
	%struct.DSOCacheEntry {
		i64 u0xda7a08baa1b4483f, ; from name: aot-Xamarin.AndroidX.CoordinatorLayout
		i64 u0x5cc157f14ad19fc0, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.108_name, ; name: libaot-Xamarin.AndroidX.CoordinatorLayout.dll.so
		ptr null; void* handle
	}, ; 1686
	%struct.DSOCacheEntry {
		i64 u0xda8a2534b06f63e2, ; from name: libaot-System.Runtime.Loader
		i64 u0x55c25b4d27ae6f23, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.188_name, ; name: libaot-System.Runtime.Loader.dll.so
		ptr null; void* handle
	}, ; 1687
	%struct.DSOCacheEntry {
		i64 u0xdac304cff0994622, ; from name: libaot-Xamarin.AndroidX.Navigation.Runtime
		i64 u0x79a319cd6e76a263, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.121_name, ; name: libaot-Xamarin.AndroidX.Navigation.Runtime.dll.so
		ptr null; void* handle
	}, ; 1688
	%struct.DSOCacheEntry {
		i64 u0xdae159d1e3379aad, ; from name: aot-Microsoft.AspNetCore.Authorization.so
		i64 u0x93d2678ac2e76ce0, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.22_name, ; name: libaot-Microsoft.AspNetCore.Authorization.dll.so
		ptr null; void* handle
	}, ; 1689
	%struct.DSOCacheEntry {
		i64 u0xdb0ba396e671b593, ; from name: System.Runtime.Caching.dll.so
		i64 u0x9a1f1aedbdf3f019, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.100_name, ; name: libaot-System.Runtime.Caching.dll.so
		ptr null; void* handle
	}, ; 1690
	%struct.DSOCacheEntry {
		i64 u0xdb28c2f2e5cda275, ; from name: libaot-Microsoft.AspNetCore.Hosting.Server.Abstractions.dll.so
		i64 u0xdb28c2f2e5cda275, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.26_name, ; name: libaot-Microsoft.AspNetCore.Hosting.Server.Abstractions.dll.so
		ptr null; void* handle
	}, ; 1691
	%struct.DSOCacheEntry {
		i64 u0xdb433c9db2de9c49, ; from name: Xamarin.AndroidX.SavedState.dll.so
		i64 u0x039588659cdd2f6a, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.124_name, ; name: libaot-Xamarin.AndroidX.SavedState.dll.so
		ptr null; void* handle
	}, ; 1692
	%struct.DSOCacheEntry {
		i64 u0xdbb9e1e0ecaa9f17, ; from name: System.IO.Compression.dll.so
		i64 u0x07869dd1c492a791, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.155_name, ; name: libaot-System.IO.Compression.dll.so
		ptr null; void* handle
	}, ; 1693
	%struct.DSOCacheEntry {
		i64 u0xdbe0faf6eb033056, ; from name: aot-Microsoft.Maui.Controls
		i64 u0x7f174db5a2c913e7, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.75_name, ; name: libaot-Microsoft.Maui.Controls.dll.so
		ptr null; void* handle
	}, ; 1694
	%struct.DSOCacheEntry {
		i64 u0xdbf9607a441b4505, ; from name: System.Linq
		i64 u0x2fb7a3952b307fae, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.162_name, ; name: libaot-System.Linq.dll.so
		ptr null; void* handle
	}, ; 1695
	%struct.DSOCacheEntry {
		i64 u0xdbfb2c2ca5e333d9, ; from name: System.IO.FileSystem.AccessControl.dll.so
		i64 u0xf8af38e7ca3d5d78, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.156_name, ; name: libaot-System.IO.FileSystem.AccessControl.dll.so
		ptr null; void* handle
	}, ; 1696
	%struct.DSOCacheEntry {
		i64 u0xdc0230ef3b6efdb3, ; from name: aot-Xamarin.AndroidX.Loader.dll.so
		i64 u0x74b0aefe8f467d50, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.118_name, ; name: libaot-Xamarin.AndroidX.Loader.dll.so
		ptr null; void* handle
	}, ; 1697
	%struct.DSOCacheEntry {
		i64 u0xdc3ba4771239be2d, ; from name: libaot-Microsoft.Maui.Essentials.dll.so
		i64 u0xdc3ba4771239be2d, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.78_name, ; name: libaot-Microsoft.Maui.Essentials.dll.so
		ptr null; void* handle
	}, ; 1698
	%struct.DSOCacheEntry {
		i64 u0xdc4eb3decb8cc572, ; from name: System.Runtime.Loader.dll.so
		i64 u0x55c25b4d27ae6f23, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.188_name, ; name: libaot-System.Runtime.Loader.dll.so
		ptr null; void* handle
	}, ; 1699
	%struct.DSOCacheEntry {
		i64 u0xdc7bcd87fe2562e2, ; from name: aot-System.Xml.XmlSerializer
		i64 u0xdfef1aaab339ffdb, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.220_name, ; name: libaot-System.Xml.XmlSerializer.dll.so
		ptr null; void* handle
	}, ; 1700
	%struct.DSOCacheEntry {
		i64 u0xdce2c53525640bf3, ; from name: Microsoft.Extensions.Logging
		i64 u0x9b6f0babce2a1934, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.62_name, ; name: libaot-Microsoft.Extensions.Logging.dll.so
		ptr null; void* handle
	}, ; 1701
	%struct.DSOCacheEntry {
		i64 u0xdd5311b58beccf63, ; from name: aot-Microsoft.Extensions.FileProviders.Abstractions
		i64 u0x82b65efc7b0bc50f, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.60_name, ; name: libaot-Microsoft.Extensions.FileProviders.Abstractions.dll.so
		ptr null; void* handle
	}, ; 1702
	%struct.DSOCacheEntry {
		i64 u0xdd5fd03cebd709b4, ; from name: libaot-System.Linq.Queryable
		i64 u0x5932dbf572fab50a, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.161_name, ; name: libaot-System.Linq.Queryable.dll.so
		ptr null; void* handle
	}, ; 1703
	%struct.DSOCacheEntry {
		i64 u0xddad01cc8c176e15, ; from name: aot-Microsoft.Win32.Primitives.so
		i64 u0x6f3638b02afc00cc, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.133_name, ; name: libaot-Microsoft.Win32.Primitives.dll.so
		ptr null; void* handle
	}, ; 1704
	%struct.DSOCacheEntry {
		i64 u0xdddbbba2c8f1029a, ; from name: aot-System.Web.HttpUtility.dll.so
		i64 u0xcdab467c6caa8aba, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.216_name, ; name: libaot-System.Web.HttpUtility.dll.so
		ptr null; void* handle
	}, ; 1705
	%struct.DSOCacheEntry {
		i64 u0xde184ce6bf07deab, ; from name: libaot-Microsoft.AspNetCore.Http.Features
		i64 u0x621c21d9c3290da0, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.32_name, ; name: libaot-Microsoft.AspNetCore.Http.Features.dll.so
		ptr null; void* handle
	}, ; 1706
	%struct.DSOCacheEntry {
		i64 u0xde5702cd751b5645, ; from name: System.Security.Cryptography.so
		i64 u0xd0e82017367ac826, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.203_name, ; name: libaot-System.Security.Cryptography.dll.so
		ptr null; void* handle
	}, ; 1707
	%struct.DSOCacheEntry {
		i64 u0xde5d170254f0df18, ; from name: System.Threading.ThreadPool.so
		i64 u0x7d7a84dcff7fdb59, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.213_name, ; name: libaot-System.Threading.ThreadPool.dll.so
		ptr null; void* handle
	}, ; 1708
	%struct.DSOCacheEntry {
		i64 u0xdeb6eae109943010, ; from name: libaot-System.Threading.Tasks.Extensions
		i64 u0x51aad7b1eaf4d2ae, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.211_name, ; name: libaot-System.Threading.Tasks.Extensions.dll.so
		ptr null; void* handle
	}, ; 1709
	%struct.DSOCacheEntry {
		i64 u0xdee23b28d10c8286, ; from name: System.Drawing.Primitives.so
		i64 u0x934cbfda9b40e895, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.151_name, ; name: libaot-System.Drawing.Primitives.dll.so
		ptr null; void* handle
	}, ; 1710
	%struct.DSOCacheEntry {
		i64 u0xdef4bac276b1de25, ; from name: libaot-Microsoft.Extensions.Diagnostics
		i64 u0xd34809bcacf156ee, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.57_name, ; name: libaot-Microsoft.Extensions.Diagnostics.dll.so
		ptr null; void* handle
	}, ; 1711
	%struct.DSOCacheEntry {
		i64 u0xdf3c491694996c7e, ; from name: libaot-Xamarin.AndroidX.CursorAdapter.dll.so
		i64 u0xdf3c491694996c7e, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.110_name, ; name: libaot-Xamarin.AndroidX.CursorAdapter.dll.so
		ptr null; void* handle
	}, ; 1712
	%struct.DSOCacheEntry {
		i64 u0xdf40a0b735ed4041, ; from name: Microsoft.Extensions.FileProviders.Abstractions.so
		i64 u0x82b65efc7b0bc50f, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.60_name, ; name: libaot-Microsoft.Extensions.FileProviders.Abstractions.dll.so
		ptr null; void* handle
	}, ; 1713
	%struct.DSOCacheEntry {
		i64 u0xdf4908a7c69b51d1, ; from name: aot-Xamarin.AndroidX.ViewPager
		i64 u0xb5351dcbaf438cb6, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.126_name, ; name: libaot-Xamarin.AndroidX.ViewPager.dll.so
		ptr null; void* handle
	}, ; 1714
	%struct.DSOCacheEntry {
		i64 u0xdf6f3ba08463afc0, ; from name: Microsoft.Extensions.Features.dll.so
		i64 u0xaebd3af6eeceb1eb, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.59_name, ; name: libaot-Microsoft.Extensions.Features.dll.so
		ptr null; void* handle
	}, ; 1715
	%struct.DSOCacheEntry {
		i64 u0xdf9c7682560a9629, ; from name: System.Net.ServerSentEvents
		i64 u0x95302b4a91a9ea47, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.99_name, ; name: libaot-System.Net.ServerSentEvents.dll.so
		ptr null; void* handle
	}, ; 1716
	%struct.DSOCacheEntry {
		i64 u0xdfa4850418b6c99a, ; from name: Microsoft.AspNetCore.Hosting.Abstractions
		i64 u0x8e5050b380b35b28, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.25_name, ; name: libaot-Microsoft.AspNetCore.Hosting.Abstractions.dll.so
		ptr null; void* handle
	}, ; 1717
	%struct.DSOCacheEntry {
		i64 u0xdfabadcf47a52f12, ; from name: libaot-System.Xml.ReaderWriter.dll.so
		i64 u0xdfabadcf47a52f12, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.218_name, ; name: libaot-System.Xml.ReaderWriter.dll.so
		ptr null; void* handle
	}, ; 1718
	%struct.DSOCacheEntry {
		i64 u0xdfef1aaab339ffdb, ; from name: libaot-System.Xml.XmlSerializer.dll.so
		i64 u0xdfef1aaab339ffdb, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.220_name, ; name: libaot-System.Xml.XmlSerializer.dll.so
		ptr null; void* handle
	}, ; 1719
	%struct.DSOCacheEntry {
		i64 u0xe00250491fd061db, ; from name: aot-Microsoft.Extensions.Configuration
		i64 u0x07a45374fab68acc, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.52_name, ; name: libaot-Microsoft.Extensions.Configuration.dll.so
		ptr null; void* handle
	}, ; 1720
	%struct.DSOCacheEntry {
		i64 u0xe012402cc380eac2, ; from name: libaot-System.Runtime.Serialization.Json.dll.so
		i64 u0xe012402cc380eac2, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.191_name, ; name: libaot-System.Runtime.Serialization.Json.dll.so
		ptr null; void* handle
	}, ; 1721
	%struct.DSOCacheEntry {
		i64 u0xe03e3baaab589d1e, ; from name: libaot-System.Memory.Data.dll.so
		i64 u0xe03e3baaab589d1e, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.98_name, ; name: libaot-System.Memory.Data.dll.so
		ptr null; void* handle
	}, ; 1722
	%struct.DSOCacheEntry {
		i64 u0xe047cec24633c1a6, ; from name: aot-System.ComponentModel.dll.so
		i64 u0x38a82198a4cd2a73, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.143_name, ; name: libaot-System.ComponentModel.dll.so
		ptr null; void* handle
	}, ; 1723
	%struct.DSOCacheEntry {
		i64 u0xe05faae6d518aca9, ; from name: libaot-System.IdentityModel.Tokens.Jwt.dll.so
		i64 u0xe05faae6d518aca9, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.97_name, ; name: libaot-System.IdentityModel.Tokens.Jwt.dll.so
		ptr null; void* handle
	}, ; 1724
	%struct.DSOCacheEntry {
		i64 u0xe08585cfb038b415, ; from name: System.Net.Requests.so
		i64 u0x2a8da1e7722aaaff, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.169_name, ; name: libaot-System.Net.Requests.dll.so
		ptr null; void* handle
	}, ; 1725
	%struct.DSOCacheEntry {
		i64 u0xe0ba2b05be11dec6, ; from name: libaot-Syncfusion.Licensing.dll.so
		i64 u0xe0ba2b05be11dec6, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.89_name, ; name: libaot-Syncfusion.Licensing.dll.so
		ptr null; void* handle
	}, ; 1726
	%struct.DSOCacheEntry {
		i64 u0xe0cd163e7f1530e6, ; from name: Xamarin.AndroidX.Navigation.UI.dll.so
		i64 u0x21b741f2635aa744, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.122_name, ; name: libaot-Xamarin.AndroidX.Navigation.UI.dll.so
		ptr null; void* handle
	}, ; 1727
	%struct.DSOCacheEntry {
		i64 u0xe0d8b9e508c9da57, ; from name: aot-Microsoft.CSharp.so
		i64 u0xe38bfeec71b3b67d, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.132_name, ; name: libaot-Microsoft.CSharp.dll.so
		ptr null; void* handle
	}, ; 1728
	%struct.DSOCacheEntry {
		i64 u0xe0f4e292613cec4f, ; from name: aot-System.Security.AccessControl.so
		i64 u0x69dd3c9ffb9c24cd, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.195_name, ; name: libaot-System.Security.AccessControl.dll.so
		ptr null; void* handle
	}, ; 1729
	%struct.DSOCacheEntry {
		i64 u0xe106423bc739c2b2, ; from name: aot-_Microsoft.Android.Resource.Designer.so
		i64 u0x9cbca1c74026e295, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.9_name, ; name: libaot-_Microsoft.Android.Resource.Designer.dll.so
		ptr null; void* handle
	}, ; 1730
	%struct.DSOCacheEntry {
		i64 u0xe125cb42da1b888c, ; from name: aot-System.Security.Cryptography.so
		i64 u0xd0e82017367ac826, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.203_name, ; name: libaot-System.Security.Cryptography.dll.so
		ptr null; void* handle
	}, ; 1731
	%struct.DSOCacheEntry {
		i64 u0xe13ed4ed9359be66, ; from name: aot-System.Web.HttpUtility
		i64 u0xcdab467c6caa8aba, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.216_name, ; name: libaot-System.Web.HttpUtility.dll.so
		ptr null; void* handle
	}, ; 1732
	%struct.DSOCacheEntry {
		i64 u0xe1a08bd3fa539e0d, ; from name: System.Runtime.Loader
		i64 u0x55c25b4d27ae6f23, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.188_name, ; name: libaot-System.Runtime.Loader.dll.so
		ptr null; void* handle
	}, ; 1733
	%struct.DSOCacheEntry {
		i64 u0xe1af59ffe15719e2, ; from name: libaot-System.Private.CoreLib.dll.so
		i64 u0xe1af59ffe15719e2, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.227_name, ; name: libaot-System.Private.CoreLib.dll.so
		ptr null; void* handle
	}, ; 1734
	%struct.DSOCacheEntry {
		i64 u0xe1c75f0323dd69e9, ; from name: Microsoft.AspNetCore.Mvc.Abstractions.dll.so
		i64 u0x8be639a423b6d017, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.33_name, ; name: libaot-Microsoft.AspNetCore.Mvc.Abstractions.dll.so
		ptr null; void* handle
	}, ; 1735
	%struct.DSOCacheEntry {
		i64 u0xe1cfd231ae870b4e, ; from name: System.Configuration.ConfigurationManager.dll.so
		i64 u0x5d3a5af149aed459, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.96_name, ; name: libaot-System.Configuration.ConfigurationManager.dll.so
		ptr null; void* handle
	}, ; 1736
	%struct.DSOCacheEntry {
		i64 u0xe1d75968b4edb383, ; from name: System.Xml.Linq.dll.so
		i64 u0xe89b56c5a60687e6, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.217_name, ; name: libaot-System.Xml.Linq.dll.so
		ptr null; void* handle
	}, ; 1737
	%struct.DSOCacheEntry {
		i64 u0xe23490edb1937ce1, ; from name: libaot-System.Runtime.Serialization.Json.so
		i64 u0xe012402cc380eac2, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.191_name, ; name: libaot-System.Runtime.Serialization.Json.dll.so
		ptr null; void* handle
	}, ; 1738
	%struct.DSOCacheEntry {
		i64 u0xe2378db9a424392f, ; from name: Xamarin.AndroidX.CardView.so
		i64 u0xe9e6021e6533eb43, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.106_name, ; name: libaot-Xamarin.AndroidX.CardView.dll.so
		ptr null; void* handle
	}, ; 1739
	%struct.DSOCacheEntry {
		i64 u0xe29b7559d8668b8d, ; from name: aot-Xamarin.AndroidX.Fragment.dll.so
		i64 u0x8ab6d3431da5497e, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.113_name, ; name: libaot-Xamarin.AndroidX.Fragment.dll.so
		ptr null; void* handle
	}, ; 1740
	%struct.DSOCacheEntry {
		i64 u0xe2b1c3ec2df68a04, ; from name: aot-Microsoft.AspNetCore.Authentication.Abstractions.dll.so
		i64 u0x59903efae9d3d723, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.20_name, ; name: libaot-Microsoft.AspNetCore.Authentication.Abstractions.dll.so
		ptr null; void* handle
	}, ; 1741
	%struct.DSOCacheEntry {
		i64 u0xe2cd76bdc12a5237, ; from name: libaot-System.Drawing.so
		i64 u0x366c3ed8a6266ffb, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.152_name, ; name: libaot-System.Drawing.dll.so
		ptr null; void* handle
	}, ; 1742
	%struct.DSOCacheEntry {
		i64 u0xe2cf8c52e543554c, ; from name: aot-Xamarin.Kotlin.StdLib.so
		i64 u0x0c644d6a2b020c43, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.129_name, ; name: libaot-Xamarin.Kotlin.StdLib.dll.so
		ptr null; void* handle
	}, ; 1743
	%struct.DSOCacheEntry {
		i64 u0xe2ee754535ca6dd6, ; from name: SocialMauiApp
		i64 u0xec957d270d230c6a, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.11_name, ; name: libaot-SocialMauiApp.dll.so
		ptr null; void* handle
	}, ; 1744
	%struct.DSOCacheEntry {
		i64 u0xe2f7d507f1784b25, ; from name: System.Threading.Channels.dll.so
		i64 u0x59aee0bc92ee07e3, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.210_name, ; name: libaot-System.Threading.Channels.dll.so
		ptr null; void* handle
	}, ; 1745
	%struct.DSOCacheEntry {
		i64 u0xe33e3f6598ef4348, ; from name: aot-SQLitePCLRaw.batteries_v2.dll.so
		i64 u0x418d89fb2901d219, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.85_name, ; name: libaot-SQLitePCLRaw.batteries_v2.dll.so
		ptr null; void* handle
	}, ; 1746
	%struct.DSOCacheEntry {
		i64 u0xe341d7977bf27fd7, ; from name: aot-DocumentFormat.OpenXml.dll.so
		i64 u0x456cc421e6ef3bb7, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.17_name, ; name: libaot-DocumentFormat.OpenXml.dll.so
		ptr null; void* handle
	}, ; 1747
	%struct.DSOCacheEntry {
		i64 u0xe358cebbe517a454, ; from name: aot-Microsoft.Maui.Controls.so
		i64 u0x7f174db5a2c913e7, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.75_name, ; name: libaot-Microsoft.Maui.Controls.dll.so
		ptr null; void* handle
	}, ; 1748
	%struct.DSOCacheEntry {
		i64 u0xe37eee0db1282aa3, ; from name: aot-netstandard.so
		i64 u0xb6ab21527197f7f1, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.223_name, ; name: libaot-netstandard.dll.so
		ptr null; void* handle
	}, ; 1749
	%struct.DSOCacheEntry {
		i64 u0xe3841c505d4455cb, ; from name: libaot-Microsoft.EntityFrameworkCore.Relational.so
		i64 u0xc114e8a396f5423b, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.48_name, ; name: libaot-Microsoft.EntityFrameworkCore.Relational.dll.so
		ptr null; void* handle
	}, ; 1750
	%struct.DSOCacheEntry {
		i64 u0xe38bfeec71b3b67d, ; from name: libaot-Microsoft.CSharp.dll.so
		i64 u0xe38bfeec71b3b67d, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.132_name, ; name: libaot-Microsoft.CSharp.dll.so
		ptr null; void* handle
	}, ; 1751
	%struct.DSOCacheEntry {
		i64 u0xe38e8ac420aab422, ; from name: Microsoft.AspNetCore.Mvc.Core
		i64 u0xffcb4d21a593e637, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.34_name, ; name: libaot-Microsoft.AspNetCore.Mvc.Core.dll.so
		ptr null; void* handle
	}, ; 1752
	%struct.DSOCacheEntry {
		i64 u0xe425a7f41d0131b8, ; from name: aot-Xamarin.AndroidX.Browser.dll.so
		i64 u0x9865c0bf349d1465, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.105_name, ; name: libaot-Xamarin.AndroidX.Browser.dll.so
		ptr null; void* handle
	}, ; 1753
	%struct.DSOCacheEntry {
		i64 u0xe42764432fcebad4, ; from name: aot-Microsoft.Maui.Graphics
		i64 u0x285d22da351d937a, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.79_name, ; name: libaot-Microsoft.Maui.Graphics.dll.so
		ptr null; void* handle
	}, ; 1754
	%struct.DSOCacheEntry {
		i64 u0xe456dd9cd8a3e128, ; from name: System.Security.Cryptography.dll.so
		i64 u0xd0e82017367ac826, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.203_name, ; name: libaot-System.Security.Cryptography.dll.so
		ptr null; void* handle
	}, ; 1755
	%struct.DSOCacheEntry {
		i64 u0xe46e6cae617ce2ae, ; from name: Xamarin.AndroidX.CustomView.so
		i64 u0xe7b2e898b68d9670, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.111_name, ; name: libaot-Xamarin.AndroidX.CustomView.dll.so
		ptr null; void* handle
	}, ; 1756
	%struct.DSOCacheEntry {
		i64 u0xe46fab35c2efc155, ; from name: Microsoft.AspNetCore.Http.Connections.Common.dll.so
		i64 u0x726b54f946bf0d7f, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.30_name, ; name: libaot-Microsoft.AspNetCore.Http.Connections.Common.dll.so
		ptr null; void* handle
	}, ; 1757
	%struct.DSOCacheEntry {
		i64 u0xe482202fa8ca5075, ; from name: aot-System.Threading.Channels.so
		i64 u0x59aee0bc92ee07e3, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.210_name, ; name: libaot-System.Threading.Channels.dll.so
		ptr null; void* handle
	}, ; 1758
	%struct.DSOCacheEntry {
		i64 u0xe489f8a9fa342aab, ; from name: libaot-System.Text.Encodings.Web.so
		i64 u0x209bcec5b3b022b8, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.207_name, ; name: libaot-System.Text.Encodings.Web.dll.so
		ptr null; void* handle
	}, ; 1759
	%struct.DSOCacheEntry {
		i64 u0xe48a80fd73f25271, ; from name: System.Net.Security.so
		i64 u0x1271045d1561acf0, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.170_name, ; name: libaot-System.Net.Security.dll.so
		ptr null; void* handle
	}, ; 1760
	%struct.DSOCacheEntry {
		i64 u0xe4a5a519ffe8b5e9, ; from name: libaot-System.Security.Cryptography.Cng.dll.so
		i64 u0xe4a5a519ffe8b5e9, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.198_name, ; name: libaot-System.Security.Cryptography.Cng.dll.so
		ptr null; void* handle
	}, ; 1761
	%struct.DSOCacheEntry {
		i64 u0xe4bfd449583d5fa2, ; from name: aot-System.IO.FileSystem.AccessControl.so
		i64 u0xf8af38e7ca3d5d78, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.156_name, ; name: libaot-System.IO.FileSystem.AccessControl.dll.so
		ptr null; void* handle
	}, ; 1762
	%struct.DSOCacheEntry {
		i64 u0xe4f74a0b5bf9703f, ; from name: System.Runtime.Serialization.Primitives
		i64 u0xbd30caec9108afc1, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.192_name, ; name: libaot-System.Runtime.Serialization.Primitives.dll.so
		ptr null; void* handle
	}, ; 1763
	%struct.DSOCacheEntry {
		i64 u0xe507a39cbb7478a4, ; from name: aot-Xamarin.KotlinX.Serialization.Core.Jvm.dll.so
		i64 u0x757898ba637db46e, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.131_name, ; name: libaot-Xamarin.KotlinX.Serialization.Core.Jvm.dll.so
		ptr null; void* handle
	}, ; 1764
	%struct.DSOCacheEntry {
		i64 u0xe54cb3594fbc963f, ; from name: libaot-System.Reflection.Emit.Lightweight
		i64 u0x54f7fbd0a81833fe, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.183_name, ; name: libaot-System.Reflection.Emit.Lightweight.dll.so
		ptr null; void* handle
	}, ; 1765
	%struct.DSOCacheEntry {
		i64 u0xe55c2c77d7d4c2b7, ; from name: aot-Microsoft.AspNetCore.Hosting.Server.Abstractions.dll.so
		i64 u0xdb28c2f2e5cda275, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.26_name, ; name: libaot-Microsoft.AspNetCore.Hosting.Server.Abstractions.dll.so
		ptr null; void* handle
	}, ; 1766
	%struct.DSOCacheEntry {
		i64 u0xe57af9ab00f5c61d, ; from name: libaot-System.Private.Uri.dll.so
		i64 u0xe57af9ab00f5c61d, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.179_name, ; name: libaot-System.Private.Uri.dll.so
		ptr null; void* handle
	}, ; 1767
	%struct.DSOCacheEntry {
		i64 u0xe57d22ca4aeb4900, ; from name: System.Configuration.ConfigurationManager
		i64 u0x5d3a5af149aed459, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.96_name, ; name: libaot-System.Configuration.ConfigurationManager.dll.so
		ptr null; void* handle
	}, ; 1768
	%struct.DSOCacheEntry {
		i64 u0xe5d77ea7e8e1d0e8, ; from name: libaot-System.Web.HttpUtility.so
		i64 u0xcdab467c6caa8aba, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.216_name, ; name: libaot-System.Web.HttpUtility.dll.so
		ptr null; void* handle
	}, ; 1769
	%struct.DSOCacheEntry {
		i64 u0xe5f29bede3f5fdf4, ; from name: libaot-Microsoft.Maui.Controls.so
		i64 u0x7f174db5a2c913e7, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.75_name, ; name: libaot-Microsoft.Maui.Controls.dll.so
		ptr null; void* handle
	}, ; 1770
	%struct.DSOCacheEntry {
		i64 u0xe64fe3dfe237662a, ; from name: aot-System.Runtime.Serialization.Json
		i64 u0xe012402cc380eac2, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.191_name, ; name: libaot-System.Runtime.Serialization.Json.dll.so
		ptr null; void* handle
	}, ; 1771
	%struct.DSOCacheEntry {
		i64 u0xe674cb4ab6b2450f, ; from name: aot-SQLitePCLRaw.provider.e_sqlite3.dll.so
		i64 u0xa5a20228c07e96ff, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.88_name, ; name: libaot-SQLitePCLRaw.provider.e_sqlite3.dll.so
		ptr null; void* handle
	}, ; 1772
	%struct.DSOCacheEntry {
		i64 u0xe6757a5fac324e53, ; from name: libaot-Microsoft.Extensions.Logging.Abstractions.dll.so
		i64 u0xe6757a5fac324e53, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.63_name, ; name: libaot-Microsoft.Extensions.Logging.Abstractions.dll.so
		ptr null; void* handle
	}, ; 1773
	%struct.DSOCacheEntry {
		i64 u0xe6818c8a68e2e4a4, ; from name: libaot-System.Drawing.Primitives
		i64 u0x934cbfda9b40e895, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.151_name, ; name: libaot-System.Drawing.Primitives.dll.so
		ptr null; void* handle
	}, ; 1774
	%struct.DSOCacheEntry {
		i64 u0xe6ff6995c50a770e, ; from name: Xamarin.KotlinX.Serialization.Core.Jvm.so
		i64 u0x757898ba637db46e, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.131_name, ; name: libaot-Xamarin.KotlinX.Serialization.Core.Jvm.dll.so
		ptr null; void* handle
	}, ; 1775
	%struct.DSOCacheEntry {
		i64 u0xe7391feabf472121, ; from name: libaot-System.Runtime.Serialization.Xml
		i64 u0xeb52548b17e702c6, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.193_name, ; name: libaot-System.Runtime.Serialization.Xml.dll.so
		ptr null; void* handle
	}, ; 1776
	%struct.DSOCacheEntry {
		i64 u0xe768406b6d0aec1d, ; from name: aot-System.Security.Cryptography.ProtectedData
		i64 u0x67faf2828acf47d0, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.101_name, ; name: libaot-System.Security.Cryptography.ProtectedData.dll.so
		ptr null; void* handle
	}, ; 1777
	%struct.DSOCacheEntry {
		i64 u0xe7b2e898b68d9670, ; from name: libaot-Xamarin.AndroidX.CustomView.dll.so
		i64 u0xe7b2e898b68d9670, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.111_name, ; name: libaot-Xamarin.AndroidX.CustomView.dll.so
		ptr null; void* handle
	}, ; 1778
	%struct.DSOCacheEntry {
		i64 u0xe7b4faf9ab700b98, ; from name: aot-Syncfusion.Maui.ImageEditor
		i64 u0x70f8ca2f11ec3669, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.91_name, ; name: libaot-Syncfusion.Maui.ImageEditor.dll.so
		ptr null; void* handle
	}, ; 1779
	%struct.DSOCacheEntry {
		i64 u0xe7d717da53600ab0, ; from name: libaot-Microsoft.AspNetCore.Connections.Abstractions.so
		i64 u0xb92f532b40f35614, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.24_name, ; name: libaot-Microsoft.AspNetCore.Connections.Abstractions.dll.so
		ptr null; void* handle
	}, ; 1780
	%struct.DSOCacheEntry {
		i64 u0xe7e7d98eda944101, ; from name: Syncfusion.Maui.Sliders
		i64 u0x8e1c0d0116b3ef4b, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.92_name, ; name: libaot-Syncfusion.Maui.Sliders.dll.so
		ptr null; void* handle
	}, ; 1781
	%struct.DSOCacheEntry {
		i64 u0xe7ecc35c0bac3998, ; from name: aot-Microsoft.AspNetCore.Authentication.Core.so
		i64 u0x2b7aae4ebbc0110d, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.21_name, ; name: libaot-Microsoft.AspNetCore.Authentication.Core.dll.so
		ptr null; void* handle
	}, ; 1782
	%struct.DSOCacheEntry {
		i64 u0xe7fb811d00b98871, ; from name: aot-System.Runtime
		i64 u0xbbc0e6e747d7877a, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.194_name, ; name: libaot-System.Runtime.dll.so
		ptr null; void* handle
	}, ; 1783
	%struct.DSOCacheEntry {
		i64 u0xe81c9c9e8683ad33, ; from name: aot-Xamarin.AndroidX.CoordinatorLayout.so
		i64 u0x5cc157f14ad19fc0, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.108_name, ; name: libaot-Xamarin.AndroidX.CoordinatorLayout.dll.so
		ptr null; void* handle
	}, ; 1784
	%struct.DSOCacheEntry {
		i64 u0xe86c841e47a44eb4, ; from name: libaot-Microsoft.IdentityModel.Protocols.so
		i64 u0x9037f9d64d16c443, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.72_name, ; name: libaot-Microsoft.IdentityModel.Protocols.dll.so
		ptr null; void* handle
	}, ; 1785
	%struct.DSOCacheEntry {
		i64 u0xe8726752705c8ce9, ; from name: libaot-Microsoft.Extensions.DependencyInjection.dll.so
		i64 u0xe8726752705c8ce9, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.54_name, ; name: libaot-Microsoft.Extensions.DependencyInjection.dll.so
		ptr null; void* handle
	}, ; 1786
	%struct.DSOCacheEntry {
		i64 u0xe87cd702d4b9ea6e, ; from name: System.Security.Cryptography.Cng.so
		i64 u0xe4a5a519ffe8b5e9, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.198_name, ; name: libaot-System.Security.Cryptography.Cng.dll.so
		ptr null; void* handle
	}, ; 1787
	%struct.DSOCacheEntry {
		i64 u0xe89b56c5a60687e6, ; from name: libaot-System.Xml.Linq.dll.so
		i64 u0xe89b56c5a60687e6, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.217_name, ; name: libaot-System.Xml.Linq.dll.so
		ptr null; void* handle
	}, ; 1788
	%struct.DSOCacheEntry {
		i64 u0xe89e46346500aa20, ; from name: aot-Microsoft.Extensions.DependencyInjection.Abstractions.so
		i64 u0x4643d8f925d8e6b7, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.55_name, ; name: libaot-Microsoft.Extensions.DependencyInjection.Abstractions.dll.so
		ptr null; void* handle
	}, ; 1789
	%struct.DSOCacheEntry {
		i64 u0xe937380fb4202c99, ; from name: aot-System.Diagnostics.TraceSource
		i64 u0x2119cc81025daa05, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.149_name, ; name: libaot-System.Diagnostics.TraceSource.dll.so
		ptr null; void* handle
	}, ; 1790
	%struct.DSOCacheEntry {
		i64 u0xe9e6021e6533eb43, ; from name: libaot-Xamarin.AndroidX.CardView.dll.so
		i64 u0xe9e6021e6533eb43, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.106_name, ; name: libaot-Xamarin.AndroidX.CardView.dll.so
		ptr null; void* handle
	}, ; 1791
	%struct.DSOCacheEntry {
		i64 u0xe9e6701e93ec4116, ; from name: aot-Microsoft.Bcl.AsyncInterfaces
		i64 u0x9b7e93363193afd3, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.44_name, ; name: libaot-Microsoft.Bcl.AsyncInterfaces.dll.so
		ptr null; void* handle
	}, ; 1792
	%struct.DSOCacheEntry {
		i64 u0xe9f5223a75f1726d, ; from name: System.Net.Http.so
		i64 u0xd925f85604802447, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.165_name, ; name: libaot-System.Net.Http.dll.so
		ptr null; void* handle
	}, ; 1793
	%struct.DSOCacheEntry {
		i64 u0xea008206567504c4, ; from name: Syncfusion.Maui.Toolkit
		i64 u0x2d6521795fa92605, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.93_name, ; name: libaot-Syncfusion.Maui.Toolkit.dll.so
		ptr null; void* handle
	}, ; 1794
	%struct.DSOCacheEntry {
		i64 u0xea0ab7fb8be2840c, ; from name: libaot-System.Memory.so
		i64 u0xad582851e7d05243, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.163_name, ; name: libaot-System.Memory.dll.so
		ptr null; void* handle
	}, ; 1795
	%struct.DSOCacheEntry {
		i64 u0xea12c5d98b86f01a, ; from name: System.IO.FileSystem.Watcher.so
		i64 u0xf90aa99869639df6, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.157_name, ; name: libaot-System.IO.FileSystem.Watcher.dll.so
		ptr null; void* handle
	}, ; 1796
	%struct.DSOCacheEntry {
		i64 u0xea16cb1cc73e225d, ; from name: Microsoft.Extensions.Options.so
		i64 u0xeef607f38ca22ffc, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.65_name, ; name: libaot-Microsoft.Extensions.Options.dll.so
		ptr null; void* handle
	}, ; 1797
	%struct.DSOCacheEntry {
		i64 u0xea8ae788340cbe4a, ; from name: CommunityToolkit.Mvvm.dll.so
		i64 u0x324cedd7271c2c92, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.16_name, ; name: libaot-CommunityToolkit.Mvvm.dll.so
		ptr null; void* handle
	}, ; 1798
	%struct.DSOCacheEntry {
		i64 u0xeac0fe1b2ebde769, ; from name: aot-System.Net.WebHeaderCollection
		i64 u0x42b58ea66e808de7, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.173_name, ; name: libaot-System.Net.WebHeaderCollection.dll.so
		ptr null; void* handle
	}, ; 1799
	%struct.DSOCacheEntry {
		i64 u0xead570ded3a79231, ; from name: Xamarin.AndroidX.CursorAdapter.so
		i64 u0xdf3c491694996c7e, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.110_name, ; name: libaot-Xamarin.AndroidX.CursorAdapter.dll.so
		ptr null; void* handle
	}, ; 1800
	%struct.DSOCacheEntry {
		i64 u0xeae71533bbcc308e, ; from name: Syncfusion.Maui.Core.dll.so
		i64 u0x4cfc586bcbdc6c97, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.90_name, ; name: libaot-Syncfusion.Maui.Core.dll.so
		ptr null; void* handle
	}, ; 1801
	%struct.DSOCacheEntry {
		i64 u0xeb2eb87760c7a2f5, ; from name: libaot-System.Collections
		i64 u0xb3f9fc836ae7ebb5, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.139_name, ; name: libaot-System.Collections.dll.so
		ptr null; void* handle
	}, ; 1802
	%struct.DSOCacheEntry {
		i64 u0xeb517ff0052bfdc5, ; from name: aot-Microsoft.Identity.Client.Extensions.Msal.so
		i64 u0x9b88d00d863a5143, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.68_name, ; name: libaot-Microsoft.Identity.Client.Extensions.Msal.dll.so
		ptr null; void* handle
	}, ; 1803
	%struct.DSOCacheEntry {
		i64 u0xeb52548b17e702c6, ; from name: libaot-System.Runtime.Serialization.Xml.dll.so
		i64 u0xeb52548b17e702c6, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.193_name, ; name: libaot-System.Runtime.Serialization.Xml.dll.so
		ptr null; void* handle
	}, ; 1804
	%struct.DSOCacheEntry {
		i64 u0xeb850bc056ae4318, ; from name: aot-System.Formats.Asn1.so
		i64 u0x4a9bda0e8528b414, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.153_name, ; name: libaot-System.Formats.Asn1.dll.so
		ptr null; void* handle
	}, ; 1805
	%struct.DSOCacheEntry {
		i64 u0xeb966ab1418b4ef2, ; from name: aot-SQLitePCLRaw.core.dll.so
		i64 u0x110f85ed0e988dad, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.86_name, ; name: libaot-SQLitePCLRaw.core.dll.so
		ptr null; void* handle
	}, ; 1806
	%struct.DSOCacheEntry {
		i64 u0xebb4a75d319d7e89, ; from name: aot-Microsoft.Maui.Controls.dll.so
		i64 u0x7f174db5a2c913e7, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.75_name, ; name: libaot-Microsoft.Maui.Controls.dll.so
		ptr null; void* handle
	}, ; 1807
	%struct.DSOCacheEntry {
		i64 u0xebdedd1a3723593f, ; from name: aot-Xamarin.AndroidX.Browser
		i64 u0x9865c0bf349d1465, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.105_name, ; name: libaot-Xamarin.AndroidX.Browser.dll.so
		ptr null; void* handle
	}, ; 1808
	%struct.DSOCacheEntry {
		i64 u0xec347664df77ecf8, ; from name: libaot-System.Collections.Immutable.so
		i64 u0x49e9602a3882bd40, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.136_name, ; name: libaot-System.Collections.Immutable.dll.so
		ptr null; void* handle
	}, ; 1809
	%struct.DSOCacheEntry {
		i64 u0xec380a9d3e7a67d6, ; from name: aot-Microsoft.AspNetCore.Http.Extensions.dll.so
		i64 u0xf01d9d74cda0b70d, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.31_name, ; name: libaot-Microsoft.AspNetCore.Http.Extensions.dll.so
		ptr null; void* handle
	}, ; 1810
	%struct.DSOCacheEntry {
		i64 u0xec4c7707356551bf, ; from name: libaot-Microsoft.AspNetCore.Http.Abstractions.so
		i64 u0x96d2838521668c05, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.28_name, ; name: libaot-Microsoft.AspNetCore.Http.Abstractions.dll.so
		ptr null; void* handle
	}, ; 1811
	%struct.DSOCacheEntry {
		i64 u0xec8abb68d340aac6, ; from name: Microsoft.AspNetCore.Authorization
		i64 u0x93d2678ac2e76ce0, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.22_name, ; name: libaot-Microsoft.AspNetCore.Authorization.dll.so
		ptr null; void* handle
	}, ; 1812
	%struct.DSOCacheEntry {
		i64 u0xec8d0cdc2bedf4f6, ; from name: libaot-System.Collections.Specialized
		i64 u0x355b66670e6bf2e4, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.138_name, ; name: libaot-System.Collections.Specialized.dll.so
		ptr null; void* handle
	}, ; 1813
	%struct.DSOCacheEntry {
		i64 u0xec957d270d230c6a, ; from name: libaot-SocialMauiApp.dll.so
		i64 u0xec957d270d230c6a, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.11_name, ; name: libaot-SocialMauiApp.dll.so
		ptr null; void* handle
	}, ; 1814
	%struct.DSOCacheEntry {
		i64 u0xecd78ed4818f3e83, ; from name: System.Threading.Thread.so
		i64 u0x675935a1e3b604dc, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.212_name, ; name: libaot-System.Threading.Thread.dll.so
		ptr null; void* handle
	}, ; 1815
	%struct.DSOCacheEntry {
		i64 u0xed1db8af46101fe3, ; from name: libaot-Microsoft.Extensions.Configuration
		i64 u0x07a45374fab68acc, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.52_name, ; name: libaot-Microsoft.Extensions.Configuration.dll.so
		ptr null; void* handle
	}, ; 1816
	%struct.DSOCacheEntry {
		i64 u0xed29bc6c141f82b6, ; from name: Microsoft.AspNetCore.Http.Features.dll.so
		i64 u0x621c21d9c3290da0, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.32_name, ; name: libaot-Microsoft.AspNetCore.Http.Features.dll.so
		ptr null; void* handle
	}, ; 1817
	%struct.DSOCacheEntry {
		i64 u0xed4191e57023378a, ; from name: aot-Mono.Android.Runtime.dll.so
		i64 u0x156ae2b2e8a39884, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.225_name, ; name: libaot-Mono.Android.Runtime.dll.so
		ptr null; void* handle
	}, ; 1818
	%struct.DSOCacheEntry {
		i64 u0xed46da2e8bc1b60c, ; from name: libaot-System.Runtime.InteropServices
		i64 u0x5ae6db1ddadc230b, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.187_name, ; name: libaot-System.Runtime.InteropServices.dll.so
		ptr null; void* handle
	}, ; 1819
	%struct.DSOCacheEntry {
		i64 u0xed5f5d2e04c4243b, ; from name: libaot-Microsoft.AspNetCore.SignalR.Client.Core
		i64 u0x0e46bd4e008c7b33, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.39_name, ; name: libaot-Microsoft.AspNetCore.SignalR.Client.Core.dll.so
		ptr null; void* handle
	}, ; 1820
	%struct.DSOCacheEntry {
		i64 u0xedcf3c5d1d40caa8, ; from name: aot-System.Xml.Linq.so
		i64 u0xe89b56c5a60687e6, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.217_name, ; name: libaot-System.Xml.Linq.dll.so
		ptr null; void* handle
	}, ; 1821
	%struct.DSOCacheEntry {
		i64 u0xee16be917646703b, ; from name: aot-CommunityToolkit.Mvvm
		i64 u0x324cedd7271c2c92, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.16_name, ; name: libaot-CommunityToolkit.Mvvm.dll.so
		ptr null; void* handle
	}, ; 1822
	%struct.DSOCacheEntry {
		i64 u0xee5683070469efb4, ; from name: aot-System.Runtime.Serialization.Formatters.so
		i64 u0xc52860d1d6baa3ef, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.190_name, ; name: libaot-System.Runtime.Serialization.Formatters.dll.so
		ptr null; void* handle
	}, ; 1823
	%struct.DSOCacheEntry {
		i64 u0xee80fa0a431cd737, ; from name: aot-System.IO.Pipes
		i64 u0x370b7031653c1807, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.159_name, ; name: libaot-System.IO.Pipes.dll.so
		ptr null; void* handle
	}, ; 1824
	%struct.DSOCacheEntry {
		i64 u0xee81f5b3f1c4f83b, ; from name: System.Threading.ThreadPool
		i64 u0x7d7a84dcff7fdb59, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.213_name, ; name: libaot-System.Threading.ThreadPool.dll.so
		ptr null; void* handle
	}, ; 1825
	%struct.DSOCacheEntry {
		i64 u0xeeb7133e6a5d7e67, ; from name: Microsoft.AspNetCore.Http.so
		i64 u0x6caedb1d96a79293, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.27_name, ; name: libaot-Microsoft.AspNetCore.Http.dll.so
		ptr null; void* handle
	}, ; 1826
	%struct.DSOCacheEntry {
		i64 u0xeecf660a30866900, ; from name: libaot-Microsoft.Maui.Controls.Xaml.so
		i64 u0x5fc3bca990f46fb4, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.76_name, ; name: libaot-Microsoft.Maui.Controls.Xaml.dll.so
		ptr null; void* handle
	}, ; 1827
	%struct.DSOCacheEntry {
		i64 u0xeeddd4342de9da38, ; from name: aot-Microsoft.Extensions.Features.so
		i64 u0xaebd3af6eeceb1eb, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.59_name, ; name: libaot-Microsoft.Extensions.Features.dll.so
		ptr null; void* handle
	}, ; 1828
	%struct.DSOCacheEntry {
		i64 u0xeeebcc3e64ef8b19, ; from name: aot-Xamarin.AndroidX.Loader.so
		i64 u0x74b0aefe8f467d50, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.118_name, ; name: libaot-Xamarin.AndroidX.Loader.dll.so
		ptr null; void* handle
	}, ; 1829
	%struct.DSOCacheEntry {
		i64 u0xeef607f38ca22ffc, ; from name: libaot-Microsoft.Extensions.Options.dll.so
		i64 u0xeef607f38ca22ffc, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.65_name, ; name: libaot-Microsoft.Extensions.Options.dll.so
		ptr null; void* handle
	}, ; 1830
	%struct.DSOCacheEntry {
		i64 u0xeef61c587cf48e31, ; from name: aot-System.Net.NetworkInformation
		i64 u0xb1bf28cdcefab46b, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.167_name, ; name: libaot-System.Net.NetworkInformation.dll.so
		ptr null; void* handle
	}, ; 1831
	%struct.DSOCacheEntry {
		i64 u0xeefc635595ef57f0, ; from name: System.Security.Cryptography.Cng
		i64 u0xe4a5a519ffe8b5e9, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.198_name, ; name: libaot-System.Security.Cryptography.Cng.dll.so
		ptr null; void* handle
	}, ; 1832
	%struct.DSOCacheEntry {
		i64 u0xef4f6acb2a118eb6, ; from name: aot-netstandard.dll.so
		i64 u0xb6ab21527197f7f1, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.223_name, ; name: libaot-netstandard.dll.so
		ptr null; void* handle
	}, ; 1833
	%struct.DSOCacheEntry {
		i64 u0xef90223c90a530d8, ; from name: Microsoft.Extensions.Logging.dll.so
		i64 u0x9b6f0babce2a1934, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.62_name, ; name: libaot-Microsoft.Extensions.Logging.dll.so
		ptr null; void* handle
	}, ; 1834
	%struct.DSOCacheEntry {
		i64 u0xef9379055a2ca34c, ; from name: aot-System.Runtime.Serialization.Primitives
		i64 u0xbd30caec9108afc1, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.192_name, ; name: libaot-System.Runtime.Serialization.Primitives.dll.so
		ptr null; void* handle
	}, ; 1835
	%struct.DSOCacheEntry {
		i64 u0xef943bd5d45a93c6, ; from name: System.Text.Encoding.CodePages.dll.so
		i64 u0x16262857ad9a2e54, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.205_name, ; name: libaot-System.Text.Encoding.CodePages.dll.so
		ptr null; void* handle
	}, ; 1836
	%struct.DSOCacheEntry {
		i64 u0xef9620acf899e160, ; from name: Microsoft.Extensions.Caching.Abstractions.so
		i64 u0x988026893039cd51, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.50_name, ; name: libaot-Microsoft.Extensions.Caching.Abstractions.dll.so
		ptr null; void* handle
	}, ; 1837
	%struct.DSOCacheEntry {
		i64 u0xef97437d9f4d48d7, ; from name: aot-Microsoft.AspNetCore.Routing.dll.so
		i64 u0x6872149aac83968a, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.36_name, ; name: libaot-Microsoft.AspNetCore.Routing.dll.so
		ptr null; void* handle
	}, ; 1838
	%struct.DSOCacheEntry {
		i64 u0xefc42f09d02ec824, ; from name: aot-System.IO.Pipelines.dll.so
		i64 u0x027079cd6cbb2479, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.158_name, ; name: libaot-System.IO.Pipelines.dll.so
		ptr null; void* handle
	}, ; 1839
	%struct.DSOCacheEntry {
		i64 u0xefdc45d9474bd3e8, ; from name: libaot-Xamarin.AndroidX.Core.so
		i64 u0x28a319e875b39488, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.109_name, ; name: libaot-Xamarin.AndroidX.Core.dll.so
		ptr null; void* handle
	}, ; 1840
	%struct.DSOCacheEntry {
		i64 u0xefec0b7fdc57ec42, ; from name: Xamarin.AndroidX.Activity
		i64 u0x8a05820e9e77c0c3, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.102_name, ; name: libaot-Xamarin.AndroidX.Activity.dll.so
		ptr null; void* handle
	}, ; 1841
	%struct.DSOCacheEntry {
		i64 u0xefedcbe674d5eacb, ; from name: aot-System.IO.Compression.dll.so
		i64 u0x07869dd1c492a791, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.155_name, ; name: libaot-System.IO.Compression.dll.so
		ptr null; void* handle
	}, ; 1842
	%struct.DSOCacheEntry {
		i64 u0xf01cdfa063f0ca6f, ; from name: SQLitePCLRaw.core.dll.so
		i64 u0x110f85ed0e988dad, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.86_name, ; name: libaot-SQLitePCLRaw.core.dll.so
		ptr null; void* handle
	}, ; 1843
	%struct.DSOCacheEntry {
		i64 u0xf01d9d74cda0b70d, ; from name: libaot-Microsoft.AspNetCore.Http.Extensions.dll.so
		i64 u0xf01d9d74cda0b70d, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.31_name, ; name: libaot-Microsoft.AspNetCore.Http.Extensions.dll.so
		ptr null; void* handle
	}, ; 1844
	%struct.DSOCacheEntry {
		i64 u0xf0203d6ded30c54e, ; from name: Microsoft.AspNetCore.SignalR.Client.Core.so
		i64 u0x0e46bd4e008c7b33, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.39_name, ; name: libaot-Microsoft.AspNetCore.SignalR.Client.Core.dll.so
		ptr null; void* handle
	}, ; 1845
	%struct.DSOCacheEntry {
		i64 u0xf058d5bd4657f9f7, ; from name: aot-SQLitePCLRaw.lib.e_sqlite3.android
		i64 u0x6a03b775044080b2, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.87_name, ; name: libaot-SQLitePCLRaw.lib.e_sqlite3.android.dll.so
		ptr null; void* handle
	}, ; 1846
	%struct.DSOCacheEntry {
		i64 u0xf09a32a89e20282a, ; from name: libaot-Xamarin.AndroidX.Browser.so
		i64 u0x9865c0bf349d1465, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.105_name, ; name: libaot-Xamarin.AndroidX.Browser.dll.so
		ptr null; void* handle
	}, ; 1847
	%struct.DSOCacheEntry {
		i64 u0xf09e47b6ae914f6e, ; from name: System.Net.NameResolution
		i64 u0x7f280e9be5453eba, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.166_name, ; name: libaot-System.Net.NameResolution.dll.so
		ptr null; void* handle
	}, ; 1848
	%struct.DSOCacheEntry {
		i64 u0xf0de58d3ec4a1a08, ; from name: System.Reflection.Emit.so
		i64 u0x868be26aba2eea6d, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.184_name, ; name: libaot-System.Reflection.Emit.dll.so
		ptr null; void* handle
	}, ; 1849
	%struct.DSOCacheEntry {
		i64 u0xf0ec9bb1b696d67c, ; from name: aot-System.Private.Uri.dll.so
		i64 u0xe57af9ab00f5c61d, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.179_name, ; name: libaot-System.Private.Uri.dll.so
		ptr null; void* handle
	}, ; 1850
	%struct.DSOCacheEntry {
		i64 u0xf1136a512f613f6b, ; from name: aot-Xamarin.AndroidX.Lifecycle.LiveData.Core
		i64 u0x38e4553d8764fa45, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.115_name, ; name: libaot-Xamarin.AndroidX.Lifecycle.LiveData.Core.dll.so
		ptr null; void* handle
	}, ; 1851
	%struct.DSOCacheEntry {
		i64 u0xf1884ee8b8ff602f, ; from name: libaot-Microsoft.Identity.Client.Extensions.Msal
		i64 u0x9b88d00d863a5143, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.68_name, ; name: libaot-Microsoft.Identity.Client.Extensions.Msal.dll.so
		ptr null; void* handle
	}, ; 1852
	%struct.DSOCacheEntry {
		i64 u0xf1b1bb30c92ec2a7, ; from name: SQLitePCLRaw.provider.e_sqlite3.dll.so
		i64 u0xa5a20228c07e96ff, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.88_name, ; name: libaot-SQLitePCLRaw.provider.e_sqlite3.dll.so
		ptr null; void* handle
	}, ; 1853
	%struct.DSOCacheEntry {
		i64 u0xf1d732e81fca3e40, ; from name: libaot-Xamarin.KotlinX.Coroutines.Core.Jvm
		i64 u0x811e0efc0e57d069, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.130_name, ; name: libaot-Xamarin.KotlinX.Coroutines.Core.Jvm.dll.so
		ptr null; void* handle
	}, ; 1854
	%struct.DSOCacheEntry {
		i64 u0xf200b204a81ea5e3, ; from name: System.Runtime.Numerics.so
		i64 u0x6619888793b3b2dd, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.189_name, ; name: libaot-System.Runtime.Numerics.dll.so
		ptr null; void* handle
	}, ; 1855
	%struct.DSOCacheEntry {
		i64 u0xf209056ebc6e4f47, ; from name: Microsoft.Extensions.Diagnostics.so
		i64 u0xd34809bcacf156ee, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.57_name, ; name: libaot-Microsoft.Extensions.Diagnostics.dll.so
		ptr null; void* handle
	}, ; 1856
	%struct.DSOCacheEntry {
		i64 u0xf21ecfbd8f9ac5ae, ; from name: libaot-System.Runtime.Numerics.so
		i64 u0x6619888793b3b2dd, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.189_name, ; name: libaot-System.Runtime.Numerics.dll.so
		ptr null; void* handle
	}, ; 1857
	%struct.DSOCacheEntry {
		i64 u0xf2adcbbeba5f2118, ; from name: aot-Xamarin.AndroidX.CursorAdapter.dll.so
		i64 u0xdf3c491694996c7e, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.110_name, ; name: libaot-Xamarin.AndroidX.CursorAdapter.dll.so
		ptr null; void* handle
	}, ; 1858
	%struct.DSOCacheEntry {
		i64 u0xf2d0d87ceaea5788, ; from name: aot-Microsoft.Data.SqlClient.so
		i64 u0x0b7c60fbe9d8f09b, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.45_name, ; name: libaot-Microsoft.Data.SqlClient.dll.so
		ptr null; void* handle
	}, ; 1859
	%struct.DSOCacheEntry {
		i64 u0xf2ef5805d2fb66d3, ; from name: aot-Microsoft.SqlServer.Server.so
		i64 u0x7b4f94432c52afad, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.81_name, ; name: libaot-Microsoft.SqlServer.Server.dll.so
		ptr null; void* handle
	}, ; 1860
	%struct.DSOCacheEntry {
		i64 u0xf2effec8dbe652c4, ; from name: libaot-Azure.Identity
		i64 u0xf309d7d68dc0ac48, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.13_name, ; name: libaot-Azure.Identity.dll.so
		ptr null; void* handle
	}, ; 1861
	%struct.DSOCacheEntry {
		i64 u0xf309d7d68dc0ac48, ; from name: libaot-Azure.Identity.dll.so
		i64 u0xf309d7d68dc0ac48, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.13_name, ; name: libaot-Azure.Identity.dll.so
		ptr null; void* handle
	}, ; 1862
	%struct.DSOCacheEntry {
		i64 u0xf36c3f6378789376, ; from name: libaot-Microsoft.EntityFrameworkCore.SqlServer
		i64 u0x9daa39a878308c98, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.49_name, ; name: libaot-Microsoft.EntityFrameworkCore.SqlServer.dll.so
		ptr null; void* handle
	}, ; 1863
	%struct.DSOCacheEntry {
		i64 u0xf3b2f2d1fe4d753b, ; from name: aot-Microsoft.Extensions.Configuration.Abstractions.so
		i64 u0xd6a1ce9f7ccd35cb, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.53_name, ; name: libaot-Microsoft.Extensions.Configuration.Abstractions.dll.so
		ptr null; void* handle
	}, ; 1864
	%struct.DSOCacheEntry {
		i64 u0xf3ddfe05336abf29, ; from name: System
		i64 u0x7b91ac8ddc528deb, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.221_name, ; name: libaot-System.dll.so
		ptr null; void* handle
	}, ; 1865
	%struct.DSOCacheEntry {
		i64 u0xf3f9a9021a345fb2, ; from name: System.Diagnostics.TraceSource.dll.so
		i64 u0x2119cc81025daa05, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.149_name, ; name: libaot-System.Diagnostics.TraceSource.dll.so
		ptr null; void* handle
	}, ; 1866
	%struct.DSOCacheEntry {
		i64 u0xf474e0221d4d0414, ; from name: aot-System.ClientModel
		i64 u0xa4d336a75ab12937, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.95_name, ; name: libaot-System.ClientModel.dll.so
		ptr null; void* handle
	}, ; 1867
	%struct.DSOCacheEntry {
		i64 u0xf4c1dd70a5496a17, ; from name: System.IO.Compression
		i64 u0x07869dd1c492a791, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.155_name, ; name: libaot-System.IO.Compression.dll.so
		ptr null; void* handle
	}, ; 1868
	%struct.DSOCacheEntry {
		i64 u0xf4f773473398d696, ; from name: aot-System.Net.Requests.so
		i64 u0x2a8da1e7722aaaff, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.169_name, ; name: libaot-System.Net.Requests.dll.so
		ptr null; void* handle
	}, ; 1869
	%struct.DSOCacheEntry {
		i64 u0xf4fa59b00364ce58, ; from name: aot-_Microsoft.Android.Resource.Designer
		i64 u0x9cbca1c74026e295, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.9_name, ; name: libaot-_Microsoft.Android.Resource.Designer.dll.so
		ptr null; void* handle
	}, ; 1870
	%struct.DSOCacheEntry {
		i64 u0xf513c17b11103f36, ; from name: aot-System.Runtime.Loader.dll.so
		i64 u0x55c25b4d27ae6f23, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.188_name, ; name: libaot-System.Runtime.Loader.dll.so
		ptr null; void* handle
	}, ; 1871
	%struct.DSOCacheEntry {
		i64 u0xf531528a98ae39cf, ; from name: libaot-Microsoft.IdentityModel.Abstractions.so
		i64 u0x41c972d328f102fd, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.69_name, ; name: libaot-Microsoft.IdentityModel.Abstractions.dll.so
		ptr null; void* handle
	}, ; 1872
	%struct.DSOCacheEntry {
		i64 u0xf56fba8789171dc1, ; from name: System.Collections.Concurrent.so
		i64 u0x65cd21401fecc3dc, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.135_name, ; name: libaot-System.Collections.Concurrent.dll.so
		ptr null; void* handle
	}, ; 1873
	%struct.DSOCacheEntry {
		i64 u0xf572fe3a0d8cdd90, ; from name: aot-Microsoft.Net.Http.Headers
		i64 u0xa81dfd6455f2dc19, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.80_name, ; name: libaot-Microsoft.Net.Http.Headers.dll.so
		ptr null; void* handle
	}, ; 1874
	%struct.DSOCacheEntry {
		i64 u0xf579706cb81f7ce7, ; from name: libaot-Xamarin.AndroidX.CustomView
		i64 u0xe7b2e898b68d9670, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.111_name, ; name: libaot-Xamarin.AndroidX.CustomView.dll.so
		ptr null; void* handle
	}, ; 1875
	%struct.DSOCacheEntry {
		i64 u0xf5898253edb9e034, ; from name: libaot-System.Reflection.Emit.Lightweight.so
		i64 u0x54f7fbd0a81833fe, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.183_name, ; name: libaot-System.Reflection.Emit.Lightweight.dll.so
		ptr null; void* handle
	}, ; 1876
	%struct.DSOCacheEntry {
		i64 u0xf58f696dbe7d20c8, ; from name: CommunityToolkit.Maui.so
		i64 u0x71a72d2d998e2673, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.14_name, ; name: libaot-CommunityToolkit.Maui.dll.so
		ptr null; void* handle
	}, ; 1877
	%struct.DSOCacheEntry {
		i64 u0xf5a730d00455611c, ; from name: aot-Microsoft.AspNetCore.Http
		i64 u0x6caedb1d96a79293, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.27_name, ; name: libaot-Microsoft.AspNetCore.Http.dll.so
		ptr null; void* handle
	}, ; 1878
	%struct.DSOCacheEntry {
		i64 u0xf5e5ace884bd7ee0, ; from name: System.Console.so
		i64 u0xc2da5dca6ccd8b0a, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.144_name, ; name: libaot-System.Console.dll.so
		ptr null; void* handle
	}, ; 1879
	%struct.DSOCacheEntry {
		i64 u0xf5e78832f397b612, ; from name: System.Reflection.Primitives.so
		i64 u0x8c58bd1a08c146f5, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.185_name, ; name: libaot-System.Reflection.Primitives.dll.so
		ptr null; void* handle
	}, ; 1880
	%struct.DSOCacheEntry {
		i64 u0xf5fc7602fe27b333, ; from name: System.Net.WebHeaderCollection
		i64 u0x42b58ea66e808de7, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.173_name, ; name: libaot-System.Net.WebHeaderCollection.dll.so
		ptr null; void* handle
	}, ; 1881
	%struct.DSOCacheEntry {
		i64 u0xf6077741019d7428, ; from name: Xamarin.AndroidX.CoordinatorLayout
		i64 u0x5cc157f14ad19fc0, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.108_name, ; name: libaot-Xamarin.AndroidX.CoordinatorLayout.dll.so
		ptr null; void* handle
	}, ; 1882
	%struct.DSOCacheEntry {
		i64 u0xf651fd929c72d073, ; from name: aot-Microsoft.AspNetCore.Http.Connections.Common
		i64 u0x726b54f946bf0d7f, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.30_name, ; name: libaot-Microsoft.AspNetCore.Http.Connections.Common.dll.so
		ptr null; void* handle
	}, ; 1883
	%struct.DSOCacheEntry {
		i64 u0xf676602fe451a58e, ; from name: aot-Xamarin.AndroidX.ViewPager.dll.so
		i64 u0xb5351dcbaf438cb6, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.126_name, ; name: libaot-Xamarin.AndroidX.ViewPager.dll.so
		ptr null; void* handle
	}, ; 1884
	%struct.DSOCacheEntry {
		i64 u0xf67a0acfbb42c76f, ; from name: libaot-Microsoft.Data.SqlClient.so
		i64 u0x0b7c60fbe9d8f09b, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.45_name, ; name: libaot-Microsoft.Data.SqlClient.dll.so
		ptr null; void* handle
	}, ; 1885
	%struct.DSOCacheEntry {
		i64 u0xf6946c26ba893a5b, ; from name: Microsoft.AspNetCore.Authentication.Core.dll.so
		i64 u0x2b7aae4ebbc0110d, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.21_name, ; name: libaot-Microsoft.AspNetCore.Authentication.Core.dll.so
		ptr null; void* handle
	}, ; 1886
	%struct.DSOCacheEntry {
		i64 u0xf6c0e7d55a7a4e4f, ; from name: Microsoft.IdentityModel.JsonWebTokens
		i64 u0x0323e786c13d309d, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.70_name, ; name: libaot-Microsoft.IdentityModel.JsonWebTokens.dll.so
		ptr null; void* handle
	}, ; 1887
	%struct.DSOCacheEntry {
		i64 u0xf6d927cee645b8e6, ; from name: libaot-System.Runtime.Loader.so
		i64 u0x55c25b4d27ae6f23, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.188_name, ; name: libaot-System.Runtime.Loader.dll.so
		ptr null; void* handle
	}, ; 1888
	%struct.DSOCacheEntry {
		i64 u0xf6fe7610381ffd77, ; from name: Microsoft.Extensions.Configuration.dll.so
		i64 u0x07a45374fab68acc, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.52_name, ; name: libaot-Microsoft.Extensions.Configuration.dll.so
		ptr null; void* handle
	}, ; 1889
	%struct.DSOCacheEntry {
		i64 u0xf72a2d6ef04e4fba, ; from name: aot-Microsoft.AspNetCore.Authentication.Abstractions.so
		i64 u0x59903efae9d3d723, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.20_name, ; name: libaot-Microsoft.AspNetCore.Authentication.Abstractions.dll.so
		ptr null; void* handle
	}, ; 1890
	%struct.DSOCacheEntry {
		i64 u0xf755ce286774e5e0, ; from name: aot-Microsoft.AspNetCore.SignalR.Core.dll.so
		i64 u0x73dd04543af2c841, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.41_name, ; name: libaot-Microsoft.AspNetCore.SignalR.Core.dll.so
		ptr null; void* handle
	}, ; 1891
	%struct.DSOCacheEntry {
		i64 u0xf75b0cefedfb6ad3, ; from name: Microsoft.Identity.Client.Extensions.Msal.so
		i64 u0x9b88d00d863a5143, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.68_name, ; name: libaot-Microsoft.Identity.Client.Extensions.Msal.dll.so
		ptr null; void* handle
	}, ; 1892
	%struct.DSOCacheEntry {
		i64 u0xf7b87a0e6230d6b7, ; from name: aot-System.Reflection.Emit
		i64 u0x868be26aba2eea6d, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.184_name, ; name: libaot-System.Reflection.Emit.dll.so
		ptr null; void* handle
	}, ; 1893
	%struct.DSOCacheEntry {
		i64 u0xf8179c501c11c943, ; from name: libaot-Syncfusion.Maui.ImageEditor
		i64 u0x70f8ca2f11ec3669, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.91_name, ; name: libaot-Syncfusion.Maui.ImageEditor.dll.so
		ptr null; void* handle
	}, ; 1894
	%struct.DSOCacheEntry {
		i64 u0xf89ed8fc2f5b4b33, ; from name: libaot-System.Text.Encoding.Extensions.dll.so
		i64 u0xf89ed8fc2f5b4b33, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.206_name, ; name: libaot-System.Text.Encoding.Extensions.dll.so
		ptr null; void* handle
	}, ; 1895
	%struct.DSOCacheEntry {
		i64 u0xf8a538251053b91b, ; from name: aot-System.Text.Encoding.CodePages
		i64 u0x16262857ad9a2e54, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.205_name, ; name: libaot-System.Text.Encoding.CodePages.dll.so
		ptr null; void* handle
	}, ; 1896
	%struct.DSOCacheEntry {
		i64 u0xf8aac5ea82de1348, ; from name: System.Linq.Queryable
		i64 u0x5932dbf572fab50a, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.161_name, ; name: libaot-System.Linq.Queryable.dll.so
		ptr null; void* handle
	}, ; 1897
	%struct.DSOCacheEntry {
		i64 u0xf8af38e7ca3d5d78, ; from name: libaot-System.IO.FileSystem.AccessControl.dll.so
		i64 u0xf8af38e7ca3d5d78, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.156_name, ; name: libaot-System.IO.FileSystem.AccessControl.dll.so
		ptr null; void* handle
	}, ; 1898
	%struct.DSOCacheEntry {
		i64 u0xf8d4c0161116b60c, ; from name: System.Security.Cryptography.Encoding.so
		i64 u0x31145bf76e7d3b7a, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.200_name, ; name: libaot-System.Security.Cryptography.Encoding.dll.so
		ptr null; void* handle
	}, ; 1899
	%struct.DSOCacheEntry {
		i64 u0xf8f24a66d78ef161, ; from name: libaot-Microsoft.AspNetCore.Http.Connections.Common.so
		i64 u0x726b54f946bf0d7f, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.30_name, ; name: libaot-Microsoft.AspNetCore.Http.Connections.Common.dll.so
		ptr null; void* handle
	}, ; 1900
	%struct.DSOCacheEntry {
		i64 u0xf90aa99869639df6, ; from name: libaot-System.IO.FileSystem.Watcher.dll.so
		i64 u0xf90aa99869639df6, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.157_name, ; name: libaot-System.IO.FileSystem.Watcher.dll.so
		ptr null; void* handle
	}, ; 1901
	%struct.DSOCacheEntry {
		i64 u0xf92f42ca289ae65b, ; from name: libaot-Xamarin.AndroidX.CustomView.so
		i64 u0xe7b2e898b68d9670, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.111_name, ; name: libaot-Xamarin.AndroidX.CustomView.dll.so
		ptr null; void* handle
	}, ; 1902
	%struct.DSOCacheEntry {
		i64 u0xf930862f055eb8ae, ; from name: libaot-CommunityToolkit.Maui.Core.so
		i64 u0x1f7f7b0e04fbedb0, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.15_name, ; name: libaot-CommunityToolkit.Maui.Core.dll.so
		ptr null; void* handle
	}, ; 1903
	%struct.DSOCacheEntry {
		i64 u0xf93b1aed9c81cdbf, ; from name: libaot-Xamarin.AndroidX.CardView.so
		i64 u0xe9e6021e6533eb43, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.106_name, ; name: libaot-Xamarin.AndroidX.CardView.dll.so
		ptr null; void* handle
	}, ; 1904
	%struct.DSOCacheEntry {
		i64 u0xf959815fea0ec361, ; from name: libaot-DocumentFormat.OpenXml.Framework.dll.so
		i64 u0xf959815fea0ec361, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.18_name, ; name: libaot-DocumentFormat.OpenXml.Framework.dll.so
		ptr null; void* handle
	}, ; 1905
	%struct.DSOCacheEntry {
		i64 u0xf9632a718cdedd92, ; from name: System.Diagnostics.StackTrace.dll.so
		i64 u0xb21e783430e22a93, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.148_name, ; name: libaot-System.Diagnostics.StackTrace.dll.so
		ptr null; void* handle
	}, ; 1906
	%struct.DSOCacheEntry {
		i64 u0xf96e35400a890997, ; from name: System.Security.Cryptography.Primitives.so
		i64 u0x7d7dff41d9076267, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.201_name, ; name: libaot-System.Security.Cryptography.Primitives.dll.so
		ptr null; void* handle
	}, ; 1907
	%struct.DSOCacheEntry {
		i64 u0xf97257b8dee8cb79, ; from name: libaot-System.Xml.ReaderWriter
		i64 u0xdfabadcf47a52f12, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.218_name, ; name: libaot-System.Xml.ReaderWriter.dll.so
		ptr null; void* handle
	}, ; 1908
	%struct.DSOCacheEntry {
		i64 u0xf972e0dd3a069316, ; from name: libaot-Microsoft.AspNetCore.Http.Abstractions
		i64 u0x96d2838521668c05, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.28_name, ; name: libaot-Microsoft.AspNetCore.Http.Abstractions.dll.so
		ptr null; void* handle
	}, ; 1909
	%struct.DSOCacheEntry {
		i64 u0xf97b3be67493f28c, ; from name: aot-Microsoft.IdentityModel.Logging.so
		i64 u0x1175872aaf2edbfe, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.71_name, ; name: libaot-Microsoft.IdentityModel.Logging.dll.so
		ptr null; void* handle
	}, ; 1910
	%struct.DSOCacheEntry {
		i64 u0xf9bf03574ec0c456, ; from name: aot-Xamarin.AndroidX.SwipeRefreshLayout
		i64 u0x6c4e830c0d79912d, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.125_name, ; name: libaot-Xamarin.AndroidX.SwipeRefreshLayout.dll.so
		ptr null; void* handle
	}, ; 1911
	%struct.DSOCacheEntry {
		i64 u0xf9bf40d25a597fa6, ; from name: aot-Microsoft.Identity.Client.Extensions.Msal.dll.so
		i64 u0x9b88d00d863a5143, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.68_name, ; name: libaot-Microsoft.Identity.Client.Extensions.Msal.dll.so
		ptr null; void* handle
	}, ; 1912
	%struct.DSOCacheEntry {
		i64 u0xf9c1a523cc802b26, ; from name: aot-Xamarin.AndroidX.Lifecycle.Common.Jvm.dll.so
		i64 u0x2ec8d2dcf2c4a71b, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.114_name, ; name: libaot-Xamarin.AndroidX.Lifecycle.Common.Jvm.dll.so
		ptr null; void* handle
	}, ; 1913
	%struct.DSOCacheEntry {
		i64 u0xf9cf3eb6b014d601, ; from name: System.Private.Xml.so
		i64 u0x52bbd048717682d4, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.181_name, ; name: libaot-System.Private.Xml.dll.so
		ptr null; void* handle
	}, ; 1914
	%struct.DSOCacheEntry {
		i64 u0xf9e17ce036b79ce2, ; from name: aot-Microsoft.Extensions.ObjectPool
		i64 u0xa951cdbe6a05ef83, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.64_name, ; name: libaot-Microsoft.Extensions.ObjectPool.dll.so
		ptr null; void* handle
	}, ; 1915
	%struct.DSOCacheEntry {
		i64 u0xf9ebb9dec3ac46d7, ; from name: libaot-System.ComponentModel.Annotations
		i64 u0xbf7d944f85fcd72c, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.140_name, ; name: libaot-System.ComponentModel.Annotations.dll.so
		ptr null; void* handle
	}, ; 1916
	%struct.DSOCacheEntry {
		i64 u0xf9eec5bb3a6aedc6, ; from name: Microsoft.Extensions.Options
		i64 u0xeef607f38ca22ffc, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.65_name, ; name: libaot-Microsoft.Extensions.Options.dll.so
		ptr null; void* handle
	}, ; 1917
	%struct.DSOCacheEntry {
		i64 u0xf9f2b80dd027f4bc, ; from name: aot-System.Threading.Thread.dll.so
		i64 u0x675935a1e3b604dc, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.212_name, ; name: libaot-System.Threading.Thread.dll.so
		ptr null; void* handle
	}, ; 1918
	%struct.DSOCacheEntry {
		i64 u0xfa0181b691198f1c, ; from name: aot-Microsoft.IdentityModel.Tokens.dll.so
		i64 u0x4be8f991cb00f075, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.74_name, ; name: libaot-Microsoft.IdentityModel.Tokens.dll.so
		ptr null; void* handle
	}, ; 1919
	%struct.DSOCacheEntry {
		i64 u0xfa019834165135fe, ; from name: libaot-Microsoft.EntityFrameworkCore.SqlServer.so
		i64 u0x9daa39a878308c98, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.49_name, ; name: libaot-Microsoft.EntityFrameworkCore.SqlServer.dll.so
		ptr null; void* handle
	}, ; 1920
	%struct.DSOCacheEntry {
		i64 u0xfa1ebea86287e9d5, ; from name: aot-Microsoft.Identity.Client.Extensions.Msal
		i64 u0x9b88d00d863a5143, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.68_name, ; name: libaot-Microsoft.Identity.Client.Extensions.Msal.dll.so
		ptr null; void* handle
	}, ; 1921
	%struct.DSOCacheEntry {
		i64 u0xfa22315368656094, ; from name: libaot-SQLitePCLRaw.core.so
		i64 u0x110f85ed0e988dad, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.86_name, ; name: libaot-SQLitePCLRaw.core.dll.so
		ptr null; void* handle
	}, ; 1922
	%struct.DSOCacheEntry {
		i64 u0xfa2e658a43fa453c, ; from name: libaot-System.Formats.Asn1.so
		i64 u0x4a9bda0e8528b414, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.153_name, ; name: libaot-System.Formats.Asn1.dll.so
		ptr null; void* handle
	}, ; 1923
	%struct.DSOCacheEntry {
		i64 u0xfa3e9689d43a7593, ; from name: aot-Microsoft.Extensions.Logging.so
		i64 u0x9b6f0babce2a1934, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.62_name, ; name: libaot-Microsoft.Extensions.Logging.dll.so
		ptr null; void* handle
	}, ; 1924
	%struct.DSOCacheEntry {
		i64 u0xfa41cf18ec70f863, ; from name: libaot-System.ClientModel
		i64 u0xa4d336a75ab12937, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.95_name, ; name: libaot-System.ClientModel.dll.so
		ptr null; void* handle
	}, ; 1925
	%struct.DSOCacheEntry {
		i64 u0xfa49cb1ddb1e1555, ; from name: aot-System.Linq.Queryable
		i64 u0x5932dbf572fab50a, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.161_name, ; name: libaot-System.Linq.Queryable.dll.so
		ptr null; void* handle
	}, ; 1926
	%struct.DSOCacheEntry {
		i64 u0xfa4b92db682ca945, ; from name: SQLitePCLRaw.lib.e_sqlite3.android.so
		i64 u0x6a03b775044080b2, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.87_name, ; name: libaot-SQLitePCLRaw.lib.e_sqlite3.android.dll.so
		ptr null; void* handle
	}, ; 1927
	%struct.DSOCacheEntry {
		i64 u0xfa630b8b0c4e56af, ; from name: Microsoft.Extensions.Diagnostics.Abstractions.so
		i64 u0xd10bb63f997c45a2, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.58_name, ; name: libaot-Microsoft.Extensions.Diagnostics.Abstractions.dll.so
		ptr null; void* handle
	}, ; 1928
	%struct.DSOCacheEntry {
		i64 u0xfa645d91e9fc4cba, ; from name: System.Threading.Thread
		i64 u0x675935a1e3b604dc, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.212_name, ; name: libaot-System.Threading.Thread.dll.so
		ptr null; void* handle
	}, ; 1929
	%struct.DSOCacheEntry {
		i64 u0xfa78950e7697d68f, ; from name: System.Formats.Asn1.so
		i64 u0x4a9bda0e8528b414, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.153_name, ; name: libaot-System.Formats.Asn1.dll.so
		ptr null; void* handle
	}, ; 1930
	%struct.DSOCacheEntry {
		i64 u0xfafb1fad69ede972, ; from name: aot-Syncfusion.Maui.Toolkit.so
		i64 u0x2d6521795fa92605, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.93_name, ; name: libaot-Syncfusion.Maui.Toolkit.dll.so
		ptr null; void* handle
	}, ; 1931
	%struct.DSOCacheEntry {
		i64 u0xfb1a532bcacd61cf, ; from name: aot-Refit.HttpClientFactory.dll.so
		i64 u0xbf4b844c69db6ec0, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.84_name, ; name: libaot-Refit.HttpClientFactory.dll.so
		ptr null; void* handle
	}, ; 1932
	%struct.DSOCacheEntry {
		i64 u0xfb35e5944d5f4c71, ; from name: libaot-System.Reflection.Emit.so
		i64 u0x868be26aba2eea6d, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.184_name, ; name: libaot-System.Reflection.Emit.dll.so
		ptr null; void* handle
	}, ; 1933
	%struct.DSOCacheEntry {
		i64 u0xfb50e82b59a182ea, ; from name: aot-SocialMauiApp.dll.so
		i64 u0xec957d270d230c6a, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.11_name, ; name: libaot-SocialMauiApp.dll.so
		ptr null; void* handle
	}, ; 1934
	%struct.DSOCacheEntry {
		i64 u0xfb641158a5aae610, ; from name: System.Threading.Thread.dll.so
		i64 u0x675935a1e3b604dc, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.212_name, ; name: libaot-System.Threading.Thread.dll.so
		ptr null; void* handle
	}, ; 1935
	%struct.DSOCacheEntry {
		i64 u0xfb6c5bf10b32568e, ; from name: System.Runtime.Serialization.Formatters.so
		i64 u0xc52860d1d6baa3ef, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.190_name, ; name: libaot-System.Runtime.Serialization.Formatters.dll.so
		ptr null; void* handle
	}, ; 1936
	%struct.DSOCacheEntry {
		i64 u0xfb9774e5346637f9, ; from name: aot-Xamarin.AndroidX.CardView.so
		i64 u0xe9e6021e6533eb43, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.106_name, ; name: libaot-Xamarin.AndroidX.CardView.dll.so
		ptr null; void* handle
	}, ; 1937
	%struct.DSOCacheEntry {
		i64 u0xfbad3e4ce4b98145, ; from name: System.Security.Cryptography.X509Certificates
		i64 u0x86ff945e422694f9, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.202_name, ; name: libaot-System.Security.Cryptography.X509Certificates.dll.so
		ptr null; void* handle
	}, ; 1938
	%struct.DSOCacheEntry {
		i64 u0xfbbca9bc0e6a2a2f, ; from name: aot-System.Drawing.Primitives.so
		i64 u0x934cbfda9b40e895, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.151_name, ; name: libaot-System.Drawing.Primitives.dll.so
		ptr null; void* handle
	}, ; 1939
	%struct.DSOCacheEntry {
		i64 u0xfbd82601c804070a, ; from name: System.Net.WebHeaderCollection.so
		i64 u0x42b58ea66e808de7, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.173_name, ; name: libaot-System.Net.WebHeaderCollection.dll.so
		ptr null; void* handle
	}, ; 1940
	%struct.DSOCacheEntry {
		i64 u0xfc371df5e64d693f, ; from name: libaot-System.Private.DataContractSerialization.so
		i64 u0x8fa52587768c02e7, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.178_name, ; name: libaot-System.Private.DataContractSerialization.dll.so
		ptr null; void* handle
	}, ; 1941
	%struct.DSOCacheEntry {
		i64 u0xfc73bf198508f0f1, ; from name: libaot-Microsoft.Extensions.Diagnostics.Abstractions.so
		i64 u0xd10bb63f997c45a2, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.58_name, ; name: libaot-Microsoft.Extensions.Diagnostics.Abstractions.dll.so
		ptr null; void* handle
	}, ; 1942
	%struct.DSOCacheEntry {
		i64 u0xfc99ea2a0aaa809c, ; from name: System.ComponentModel.Annotations.so
		i64 u0xbf7d944f85fcd72c, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.140_name, ; name: libaot-System.ComponentModel.Annotations.dll.so
		ptr null; void* handle
	}, ; 1943
	%struct.DSOCacheEntry {
		i64 u0xfcc17343369674ce, ; from name: aot-Xamarin.AndroidX.SwipeRefreshLayout.so
		i64 u0x6c4e830c0d79912d, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.125_name, ; name: libaot-Xamarin.AndroidX.SwipeRefreshLayout.dll.so
		ptr null; void* handle
	}, ; 1944
	%struct.DSOCacheEntry {
		i64 u0xfcd6cd6402cdab41, ; from name: libaot-Microsoft.Extensions.DependencyInjection.Abstractions.so
		i64 u0x4643d8f925d8e6b7, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.55_name, ; name: libaot-Microsoft.Extensions.DependencyInjection.Abstractions.dll.so
		ptr null; void* handle
	}, ; 1945
	%struct.DSOCacheEntry {
		i64 u0xfcded304bdc526af, ; from name: aot-Microsoft.AspNetCore.Http.Features.dll.so
		i64 u0x621c21d9c3290da0, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.32_name, ; name: libaot-Microsoft.AspNetCore.Http.Features.dll.so
		ptr null; void* handle
	}, ; 1946
	%struct.DSOCacheEntry {
		i64 u0xfce39976f66263cc, ; from name: libaot-Syncfusion.Maui.Sliders
		i64 u0x8e1c0d0116b3ef4b, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.92_name, ; name: libaot-Syncfusion.Maui.Sliders.dll.so
		ptr null; void* handle
	}, ; 1947
	%struct.DSOCacheEntry {
		i64 u0xfd49b3c1a76e2748, ; from name: System.Runtime.InteropServices.RuntimeInformation
		i64 u0x6aae90d5594500a9, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.186_name, ; name: libaot-System.Runtime.InteropServices.RuntimeInformation.dll.so
		ptr null; void* handle
	}, ; 1948
	%struct.DSOCacheEntry {
		i64 u0xfd536c702f64dc47, ; from name: System.Text.Encoding.Extensions
		i64 u0xf89ed8fc2f5b4b33, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.206_name, ; name: libaot-System.Text.Encoding.Extensions.dll.so
		ptr null; void* handle
	}, ; 1949
	%struct.DSOCacheEntry {
		i64 u0xfd583f7657b6a1cb, ; from name: Xamarin.AndroidX.Fragment
		i64 u0x8ab6d3431da5497e, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.113_name, ; name: libaot-Xamarin.AndroidX.Fragment.dll.so
		ptr null; void* handle
	}, ; 1950
	%struct.DSOCacheEntry {
		i64 u0xfd81ea8f8cb53189, ; from name: libaot-System.Private.Xml.Linq
		i64 u0x99ef7518b4544507, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.180_name, ; name: libaot-System.Private.Xml.Linq.dll.so
		ptr null; void* handle
	}, ; 1951
	%struct.DSOCacheEntry {
		i64 u0xfd983385bfb2d605, ; from name: System.Security.Cryptography.Primitives.dll.so
		i64 u0x7d7dff41d9076267, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.201_name, ; name: libaot-System.Security.Cryptography.Primitives.dll.so
		ptr null; void* handle
	}, ; 1952
	%struct.DSOCacheEntry {
		i64 u0xfda36abccf05cf5c, ; from name: System.Net.WebSockets.Client
		i64 u0x0a18b49bebc33444, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.174_name, ; name: libaot-System.Net.WebSockets.Client.dll.so
		ptr null; void* handle
	}, ; 1953
	%struct.DSOCacheEntry {
		i64 u0xfdb9df46aedd5238, ; from name: libaot-Xamarin.AndroidX.AppCompat.so
		i64 u0x42c7eb0880ff24a4, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.103_name, ; name: libaot-Xamarin.AndroidX.AppCompat.dll.so
		ptr null; void* handle
	}, ; 1954
	%struct.DSOCacheEntry {
		i64 u0xfdbe4710aa9beeff, ; from name: CommunityToolkit.Maui
		i64 u0x71a72d2d998e2673, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.14_name, ; name: libaot-CommunityToolkit.Maui.dll.so
		ptr null; void* handle
	}, ; 1955
	%struct.DSOCacheEntry {
		i64 u0xfde0667e2fbb5bf8, ; from name: libaot-Microsoft.AspNetCore.SignalR.Client.so
		i64 u0xb9619c5bddc1c8f4, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.38_name, ; name: libaot-Microsoft.AspNetCore.SignalR.Client.dll.so
		ptr null; void* handle
	}, ; 1956
	%struct.DSOCacheEntry {
		i64 u0xfe7484c7056f3117, ; from name: libaot-Xamarin.AndroidX.Loader.so
		i64 u0x74b0aefe8f467d50, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.118_name, ; name: libaot-Xamarin.AndroidX.Loader.dll.so
		ptr null; void* handle
	}, ; 1957
	%struct.DSOCacheEntry {
		i64 u0xfe7538e4cca3352f, ; from name: aot-System.ComponentModel.Primitives.so
		i64 u0xccde8a4563eee10b, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.141_name, ; name: libaot-System.ComponentModel.Primitives.dll.so
		ptr null; void* handle
	}, ; 1958
	%struct.DSOCacheEntry {
		i64 u0xfe7a39592f04d90a, ; from name: libaot-Microsoft.AspNetCore.Mvc.Core
		i64 u0xffcb4d21a593e637, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.34_name, ; name: libaot-Microsoft.AspNetCore.Mvc.Core.dll.so
		ptr null; void* handle
	}, ; 1959
	%struct.DSOCacheEntry {
		i64 u0xfe8712d3a8c736cb, ; from name: Syncfusion.Maui.Toolkit.resources.so
		i64 u0xa56606bb1f125004, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.94_name, ; name: libaot-Syncfusion.Maui.Toolkit.resources.dll.so
		ptr null; void* handle
	}, ; 1960
	%struct.DSOCacheEntry {
		i64 u0xfeadf370e8ea3973, ; from name: aot-mscorlib.dll.so
		i64 u0xd45fa2873eb303d5, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.222_name, ; name: libaot-mscorlib.dll.so
		ptr null; void* handle
	}, ; 1961
	%struct.DSOCacheEntry {
		i64 u0xfebb9e5645b72270, ; from name: libaot-Microsoft.Win32.Primitives
		i64 u0x6f3638b02afc00cc, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.133_name, ; name: libaot-Microsoft.Win32.Primitives.dll.so
		ptr null; void* handle
	}, ; 1962
	%struct.DSOCacheEntry {
		i64 u0xfec3a2442806908e, ; from name: libaot-System.Runtime.Serialization.Formatters.so
		i64 u0xc52860d1d6baa3ef, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.190_name, ; name: libaot-System.Runtime.Serialization.Formatters.dll.so
		ptr null; void* handle
	}, ; 1963
	%struct.DSOCacheEntry {
		i64 u0xfee05718917cdb11, ; from name: libaot-Microsoft.Extensions.DependencyInjection.Abstractions
		i64 u0x4643d8f925d8e6b7, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.55_name, ; name: libaot-Microsoft.Extensions.DependencyInjection.Abstractions.dll.so
		ptr null; void* handle
	}, ; 1964
	%struct.DSOCacheEntry {
		i64 u0xfee35b8d2be7dc6b, ; from name: libaot-Xamarin.KotlinX.Serialization.Core.Jvm.so
		i64 u0x757898ba637db46e, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.131_name, ; name: libaot-Xamarin.KotlinX.Serialization.Core.Jvm.dll.so
		ptr null; void* handle
	}, ; 1965
	%struct.DSOCacheEntry {
		i64 u0xff27d1555b432263, ; from name: libaot-System.Memory.Data
		i64 u0xe03e3baaab589d1e, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.98_name, ; name: libaot-System.Memory.Data.dll.so
		ptr null; void* handle
	}, ; 1966
	%struct.DSOCacheEntry {
		i64 u0xff9b54613e0d2cc8, ; from name: System.Net.Http.Json
		i64 u0x36547dc653fb83c1, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.164_name, ; name: libaot-System.Net.Http.Json.dll.so
		ptr null; void* handle
	}, ; 1967
	%struct.DSOCacheEntry {
		i64 u0xff9efb5e73c80352, ; from name: aot-Microsoft.EntityFrameworkCore.Relational.dll.so
		i64 u0xc114e8a396f5423b, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.48_name, ; name: libaot-Microsoft.EntityFrameworkCore.Relational.dll.so
		ptr null; void* handle
	}, ; 1968
	%struct.DSOCacheEntry {
		i64 u0xffb1eaf13769e291, ; from name: aot-Xamarin.AndroidX.Navigation.Fragment
		i64 u0xaa2eca1145f3a7cc, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.120_name, ; name: libaot-Xamarin.AndroidX.Navigation.Fragment.dll.so
		ptr null; void* handle
	}, ; 1969
	%struct.DSOCacheEntry {
		i64 u0xffcb4d21a593e637, ; from name: libaot-Microsoft.AspNetCore.Mvc.Core.dll.so
		i64 u0xffcb4d21a593e637, ; uint64_t real_name_hash
		i1 false, ; bool ignore
		ptr @.DSOCacheEntry.34_name, ; name: libaot-Microsoft.AspNetCore.Mvc.Core.dll.so
		ptr null; void* handle
	} ; 1970
], align 8

@dso_apk_entries = dso_local local_unnamed_addr global [228 x %struct.DSOApkEntry] zeroinitializer, align 8

; Bundled assembly name buffers, all empty (unused when assembly stores are enabled)
@bundled_assemblies = dso_local local_unnamed_addr global [0 x %struct.XamarinAndroidBundledAssembly] zeroinitializer, align 8

@assembly_store_bundled_assemblies = dso_local local_unnamed_addr global [254 x %struct.AssemblyStoreSingleAssemblyRuntimeData] zeroinitializer, align 8

@assembly_store = dso_local local_unnamed_addr global %struct.AssemblyStoreRuntimeData {
	ptr null, ; uint8_t* data_start
	i32 0, ; uint32_t assembly_count
	i32 0, ; uint32_t index_entry_count
	ptr null; AssemblyStoreAssemblyDescriptor* assemblies
}, align 8

; Strings
@.str.0 = private unnamed_addr constant [7 x i8] c"normal\00", align 1

; Application environment variables name:value pairs
@.env.0 = private unnamed_addr constant [15 x i8] c"MONO_GC_PARAMS\00", align 1
@.env.1 = private unnamed_addr constant [21 x i8] c"major=marksweep-conc\00", align 1
@.env.2 = private unnamed_addr constant [28 x i8] c"XA_HTTP_CLIENT_HANDLER_TYPE\00", align 1
@.env.3 = private unnamed_addr constant [42 x i8] c"Xamarin.Android.Net.AndroidMessageHandler\00", align 1

;ApplicationConfig
@.ApplicationConfig.0_android_package_name = private unnamed_addr constant [30 x i8] c"com.companyname.socialmauiapp\00", align 1

;DSOCacheEntry
@.DSOCacheEntry.0_name = private unnamed_addr constant [16 x i8] c"libe_sqlite3.so\00", align 1
@.DSOCacheEntry.1_name = private unnamed_addr constant [34 x i8] c"libSystem.Globalization.Native.so\00", align 1
@.DSOCacheEntry.2_name = private unnamed_addr constant [35 x i8] c"libSystem.IO.Compression.Native.so\00", align 1
@.DSOCacheEntry.3_name = private unnamed_addr constant [20 x i8] c"libSystem.Native.so\00", align 1
@.DSOCacheEntry.4_name = private unnamed_addr constant [50 x i8] c"libSystem.Security.Cryptography.Native.Android.so\00", align 1
@.DSOCacheEntry.5_name = private unnamed_addr constant [35 x i8] c"libmono-component-marshal-ilgen.so\00", align 1
@.DSOCacheEntry.6_name = private unnamed_addr constant [19 x i8] c"libmonosgen-2.0.so\00", align 1
@.DSOCacheEntry.7_name = private unnamed_addr constant [16 x i8] c"libmonodroid.so\00", align 1
@.DSOCacheEntry.8_name = private unnamed_addr constant [16 x i8] c"libSkiaSharp.so\00", align 1
@.DSOCacheEntry.9_name = private unnamed_addr constant [51 x i8] c"libaot-_Microsoft.Android.Resource.Designer.dll.so\00", align 1
@.DSOCacheEntry.10_name = private unnamed_addr constant [37 x i8] c"libaot-SocialMediaMaui.Shared.dll.so\00", align 1
@.DSOCacheEntry.11_name = private unnamed_addr constant [28 x i8] c"libaot-SocialMauiApp.dll.so\00", align 1
@.DSOCacheEntry.12_name = private unnamed_addr constant [25 x i8] c"libaot-Azure.Core.dll.so\00", align 1
@.DSOCacheEntry.13_name = private unnamed_addr constant [29 x i8] c"libaot-Azure.Identity.dll.so\00", align 1
@.DSOCacheEntry.14_name = private unnamed_addr constant [36 x i8] c"libaot-CommunityToolkit.Maui.dll.so\00", align 1
@.DSOCacheEntry.15_name = private unnamed_addr constant [41 x i8] c"libaot-CommunityToolkit.Maui.Core.dll.so\00", align 1
@.DSOCacheEntry.16_name = private unnamed_addr constant [36 x i8] c"libaot-CommunityToolkit.Mvvm.dll.so\00", align 1
@.DSOCacheEntry.17_name = private unnamed_addr constant [37 x i8] c"libaot-DocumentFormat.OpenXml.dll.so\00", align 1
@.DSOCacheEntry.18_name = private unnamed_addr constant [47 x i8] c"libaot-DocumentFormat.OpenXml.Framework.dll.so\00", align 1
@.DSOCacheEntry.19_name = private unnamed_addr constant [59 x i8] c"libaot-DocumentFormat.OpenXml.VariableReplacer.Core.dll.so\00", align 1
@.DSOCacheEntry.20_name = private unnamed_addr constant [63 x i8] c"libaot-Microsoft.AspNetCore.Authentication.Abstractions.dll.so\00", align 1
@.DSOCacheEntry.21_name = private unnamed_addr constant [55 x i8] c"libaot-Microsoft.AspNetCore.Authentication.Core.dll.so\00", align 1
@.DSOCacheEntry.22_name = private unnamed_addr constant [49 x i8] c"libaot-Microsoft.AspNetCore.Authorization.dll.so\00", align 1
@.DSOCacheEntry.23_name = private unnamed_addr constant [56 x i8] c"libaot-Microsoft.AspNetCore.Authorization.Policy.dll.so\00", align 1
@.DSOCacheEntry.24_name = private unnamed_addr constant [60 x i8] c"libaot-Microsoft.AspNetCore.Connections.Abstractions.dll.so\00", align 1
@.DSOCacheEntry.25_name = private unnamed_addr constant [56 x i8] c"libaot-Microsoft.AspNetCore.Hosting.Abstractions.dll.so\00", align 1
@.DSOCacheEntry.26_name = private unnamed_addr constant [63 x i8] c"libaot-Microsoft.AspNetCore.Hosting.Server.Abstractions.dll.so\00", align 1
@.DSOCacheEntry.27_name = private unnamed_addr constant [40 x i8] c"libaot-Microsoft.AspNetCore.Http.dll.so\00", align 1
@.DSOCacheEntry.28_name = private unnamed_addr constant [53 x i8] c"libaot-Microsoft.AspNetCore.Http.Abstractions.dll.so\00", align 1
@.DSOCacheEntry.29_name = private unnamed_addr constant [59 x i8] c"libaot-Microsoft.AspNetCore.Http.Connections.Client.dll.so\00", align 1
@.DSOCacheEntry.30_name = private unnamed_addr constant [59 x i8] c"libaot-Microsoft.AspNetCore.Http.Connections.Common.dll.so\00", align 1
@.DSOCacheEntry.31_name = private unnamed_addr constant [51 x i8] c"libaot-Microsoft.AspNetCore.Http.Extensions.dll.so\00", align 1
@.DSOCacheEntry.32_name = private unnamed_addr constant [49 x i8] c"libaot-Microsoft.AspNetCore.Http.Features.dll.so\00", align 1
@.DSOCacheEntry.33_name = private unnamed_addr constant [52 x i8] c"libaot-Microsoft.AspNetCore.Mvc.Abstractions.dll.so\00", align 1
@.DSOCacheEntry.34_name = private unnamed_addr constant [44 x i8] c"libaot-Microsoft.AspNetCore.Mvc.Core.dll.so\00", align 1
@.DSOCacheEntry.35_name = private unnamed_addr constant [64 x i8] c"libaot-Microsoft.AspNetCore.ResponseCaching.Abstractions.dll.so\00", align 1
@.DSOCacheEntry.36_name = private unnamed_addr constant [43 x i8] c"libaot-Microsoft.AspNetCore.Routing.dll.so\00", align 1
@.DSOCacheEntry.37_name = private unnamed_addr constant [56 x i8] c"libaot-Microsoft.AspNetCore.Routing.Abstractions.dll.so\00", align 1
@.DSOCacheEntry.38_name = private unnamed_addr constant [50 x i8] c"libaot-Microsoft.AspNetCore.SignalR.Client.dll.so\00", align 1
@.DSOCacheEntry.39_name = private unnamed_addr constant [55 x i8] c"libaot-Microsoft.AspNetCore.SignalR.Client.Core.dll.so\00", align 1
@.DSOCacheEntry.40_name = private unnamed_addr constant [50 x i8] c"libaot-Microsoft.AspNetCore.SignalR.Common.dll.so\00", align 1
@.DSOCacheEntry.41_name = private unnamed_addr constant [48 x i8] c"libaot-Microsoft.AspNetCore.SignalR.Core.dll.so\00", align 1
@.DSOCacheEntry.42_name = private unnamed_addr constant [58 x i8] c"libaot-Microsoft.AspNetCore.SignalR.Protocols.Json.dll.so\00", align 1
@.DSOCacheEntry.43_name = private unnamed_addr constant [48 x i8] c"libaot-Microsoft.AspNetCore.WebUtilities.dll.so\00", align 1
@.DSOCacheEntry.44_name = private unnamed_addr constant [44 x i8] c"libaot-Microsoft.Bcl.AsyncInterfaces.dll.so\00", align 1
@.DSOCacheEntry.45_name = private unnamed_addr constant [39 x i8] c"libaot-Microsoft.Data.SqlClient.dll.so\00", align 1
@.DSOCacheEntry.46_name = private unnamed_addr constant [44 x i8] c"libaot-Microsoft.EntityFrameworkCore.dll.so\00", align 1
@.DSOCacheEntry.47_name = private unnamed_addr constant [57 x i8] c"libaot-Microsoft.EntityFrameworkCore.Abstractions.dll.so\00", align 1
@.DSOCacheEntry.48_name = private unnamed_addr constant [55 x i8] c"libaot-Microsoft.EntityFrameworkCore.Relational.dll.so\00", align 1
@.DSOCacheEntry.49_name = private unnamed_addr constant [54 x i8] c"libaot-Microsoft.EntityFrameworkCore.SqlServer.dll.so\00", align 1
@.DSOCacheEntry.50_name = private unnamed_addr constant [56 x i8] c"libaot-Microsoft.Extensions.Caching.Abstractions.dll.so\00", align 1
@.DSOCacheEntry.51_name = private unnamed_addr constant [50 x i8] c"libaot-Microsoft.Extensions.Caching.Memory.dll.so\00", align 1
@.DSOCacheEntry.52_name = private unnamed_addr constant [49 x i8] c"libaot-Microsoft.Extensions.Configuration.dll.so\00", align 1
@.DSOCacheEntry.53_name = private unnamed_addr constant [62 x i8] c"libaot-Microsoft.Extensions.Configuration.Abstractions.dll.so\00", align 1
@.DSOCacheEntry.54_name = private unnamed_addr constant [55 x i8] c"libaot-Microsoft.Extensions.DependencyInjection.dll.so\00", align 1
@.DSOCacheEntry.55_name = private unnamed_addr constant [68 x i8] c"libaot-Microsoft.Extensions.DependencyInjection.Abstractions.dll.so\00", align 1
@.DSOCacheEntry.56_name = private unnamed_addr constant [51 x i8] c"libaot-Microsoft.Extensions.DependencyModel.dll.so\00", align 1
@.DSOCacheEntry.57_name = private unnamed_addr constant [47 x i8] c"libaot-Microsoft.Extensions.Diagnostics.dll.so\00", align 1
@.DSOCacheEntry.58_name = private unnamed_addr constant [60 x i8] c"libaot-Microsoft.Extensions.Diagnostics.Abstractions.dll.so\00", align 1
@.DSOCacheEntry.59_name = private unnamed_addr constant [44 x i8] c"libaot-Microsoft.Extensions.Features.dll.so\00", align 1
@.DSOCacheEntry.60_name = private unnamed_addr constant [62 x i8] c"libaot-Microsoft.Extensions.FileProviders.Abstractions.dll.so\00", align 1
@.DSOCacheEntry.61_name = private unnamed_addr constant [40 x i8] c"libaot-Microsoft.Extensions.Http.dll.so\00", align 1
@.DSOCacheEntry.62_name = private unnamed_addr constant [43 x i8] c"libaot-Microsoft.Extensions.Logging.dll.so\00", align 1
@.DSOCacheEntry.63_name = private unnamed_addr constant [56 x i8] c"libaot-Microsoft.Extensions.Logging.Abstractions.dll.so\00", align 1
@.DSOCacheEntry.64_name = private unnamed_addr constant [46 x i8] c"libaot-Microsoft.Extensions.ObjectPool.dll.so\00", align 1
@.DSOCacheEntry.65_name = private unnamed_addr constant [43 x i8] c"libaot-Microsoft.Extensions.Options.dll.so\00", align 1
@.DSOCacheEntry.66_name = private unnamed_addr constant [46 x i8] c"libaot-Microsoft.Extensions.Primitives.dll.so\00", align 1
@.DSOCacheEntry.67_name = private unnamed_addr constant [40 x i8] c"libaot-Microsoft.Identity.Client.dll.so\00", align 1
@.DSOCacheEntry.68_name = private unnamed_addr constant [56 x i8] c"libaot-Microsoft.Identity.Client.Extensions.Msal.dll.so\00", align 1
@.DSOCacheEntry.69_name = private unnamed_addr constant [51 x i8] c"libaot-Microsoft.IdentityModel.Abstractions.dll.so\00", align 1
@.DSOCacheEntry.70_name = private unnamed_addr constant [52 x i8] c"libaot-Microsoft.IdentityModel.JsonWebTokens.dll.so\00", align 1
@.DSOCacheEntry.71_name = private unnamed_addr constant [46 x i8] c"libaot-Microsoft.IdentityModel.Logging.dll.so\00", align 1
@.DSOCacheEntry.72_name = private unnamed_addr constant [48 x i8] c"libaot-Microsoft.IdentityModel.Protocols.dll.so\00", align 1
@.DSOCacheEntry.73_name = private unnamed_addr constant [62 x i8] c"libaot-Microsoft.IdentityModel.Protocols.OpenIdConnect.dll.so\00", align 1
@.DSOCacheEntry.74_name = private unnamed_addr constant [45 x i8] c"libaot-Microsoft.IdentityModel.Tokens.dll.so\00", align 1
@.DSOCacheEntry.75_name = private unnamed_addr constant [38 x i8] c"libaot-Microsoft.Maui.Controls.dll.so\00", align 1
@.DSOCacheEntry.76_name = private unnamed_addr constant [43 x i8] c"libaot-Microsoft.Maui.Controls.Xaml.dll.so\00", align 1
@.DSOCacheEntry.77_name = private unnamed_addr constant [29 x i8] c"libaot-Microsoft.Maui.dll.so\00", align 1
@.DSOCacheEntry.78_name = private unnamed_addr constant [40 x i8] c"libaot-Microsoft.Maui.Essentials.dll.so\00", align 1
@.DSOCacheEntry.79_name = private unnamed_addr constant [38 x i8] c"libaot-Microsoft.Maui.Graphics.dll.so\00", align 1
@.DSOCacheEntry.80_name = private unnamed_addr constant [41 x i8] c"libaot-Microsoft.Net.Http.Headers.dll.so\00", align 1
@.DSOCacheEntry.81_name = private unnamed_addr constant [41 x i8] c"libaot-Microsoft.SqlServer.Server.dll.so\00", align 1
@.DSOCacheEntry.82_name = private unnamed_addr constant [31 x i8] c"libaot-Mono.HttpUtility.dll.so\00", align 1
@.DSOCacheEntry.83_name = private unnamed_addr constant [20 x i8] c"libaot-Refit.dll.so\00", align 1
@.DSOCacheEntry.84_name = private unnamed_addr constant [38 x i8] c"libaot-Refit.HttpClientFactory.dll.so\00", align 1
@.DSOCacheEntry.85_name = private unnamed_addr constant [40 x i8] c"libaot-SQLitePCLRaw.batteries_v2.dll.so\00", align 1
@.DSOCacheEntry.86_name = private unnamed_addr constant [32 x i8] c"libaot-SQLitePCLRaw.core.dll.so\00", align 1
@.DSOCacheEntry.87_name = private unnamed_addr constant [49 x i8] c"libaot-SQLitePCLRaw.lib.e_sqlite3.android.dll.so\00", align 1
@.DSOCacheEntry.88_name = private unnamed_addr constant [46 x i8] c"libaot-SQLitePCLRaw.provider.e_sqlite3.dll.so\00", align 1
@.DSOCacheEntry.89_name = private unnamed_addr constant [35 x i8] c"libaot-Syncfusion.Licensing.dll.so\00", align 1
@.DSOCacheEntry.90_name = private unnamed_addr constant [35 x i8] c"libaot-Syncfusion.Maui.Core.dll.so\00", align 1
@.DSOCacheEntry.91_name = private unnamed_addr constant [42 x i8] c"libaot-Syncfusion.Maui.ImageEditor.dll.so\00", align 1
@.DSOCacheEntry.92_name = private unnamed_addr constant [38 x i8] c"libaot-Syncfusion.Maui.Sliders.dll.so\00", align 1
@.DSOCacheEntry.93_name = private unnamed_addr constant [38 x i8] c"libaot-Syncfusion.Maui.Toolkit.dll.so\00", align 1
@.DSOCacheEntry.94_name = private unnamed_addr constant [48 x i8] c"libaot-Syncfusion.Maui.Toolkit.resources.dll.so\00", align 1
@.DSOCacheEntry.95_name = private unnamed_addr constant [33 x i8] c"libaot-System.ClientModel.dll.so\00", align 1
@.DSOCacheEntry.96_name = private unnamed_addr constant [56 x i8] c"libaot-System.Configuration.ConfigurationManager.dll.so\00", align 1
@.DSOCacheEntry.97_name = private unnamed_addr constant [46 x i8] c"libaot-System.IdentityModel.Tokens.Jwt.dll.so\00", align 1
@.DSOCacheEntry.98_name = private unnamed_addr constant [33 x i8] c"libaot-System.Memory.Data.dll.so\00", align 1
@.DSOCacheEntry.99_name = private unnamed_addr constant [42 x i8] c"libaot-System.Net.ServerSentEvents.dll.so\00", align 1
@.DSOCacheEntry.100_name = private unnamed_addr constant [37 x i8] c"libaot-System.Runtime.Caching.dll.so\00", align 1
@.DSOCacheEntry.101_name = private unnamed_addr constant [57 x i8] c"libaot-System.Security.Cryptography.ProtectedData.dll.so\00", align 1
@.DSOCacheEntry.102_name = private unnamed_addr constant [40 x i8] c"libaot-Xamarin.AndroidX.Activity.dll.so\00", align 1
@.DSOCacheEntry.103_name = private unnamed_addr constant [41 x i8] c"libaot-Xamarin.AndroidX.AppCompat.dll.so\00", align 1
@.DSOCacheEntry.104_name = private unnamed_addr constant [60 x i8] c"libaot-Xamarin.AndroidX.AppCompat.AppCompatResources.dll.so\00", align 1
@.DSOCacheEntry.105_name = private unnamed_addr constant [39 x i8] c"libaot-Xamarin.AndroidX.Browser.dll.so\00", align 1
@.DSOCacheEntry.106_name = private unnamed_addr constant [40 x i8] c"libaot-Xamarin.AndroidX.CardView.dll.so\00", align 1
@.DSOCacheEntry.107_name = private unnamed_addr constant [46 x i8] c"libaot-Xamarin.AndroidX.Collection.Jvm.dll.so\00", align 1
@.DSOCacheEntry.108_name = private unnamed_addr constant [49 x i8] c"libaot-Xamarin.AndroidX.CoordinatorLayout.dll.so\00", align 1
@.DSOCacheEntry.109_name = private unnamed_addr constant [36 x i8] c"libaot-Xamarin.AndroidX.Core.dll.so\00", align 1
@.DSOCacheEntry.110_name = private unnamed_addr constant [45 x i8] c"libaot-Xamarin.AndroidX.CursorAdapter.dll.so\00", align 1
@.DSOCacheEntry.111_name = private unnamed_addr constant [42 x i8] c"libaot-Xamarin.AndroidX.CustomView.dll.so\00", align 1
@.DSOCacheEntry.112_name = private unnamed_addr constant [44 x i8] c"libaot-Xamarin.AndroidX.DrawerLayout.dll.so\00", align 1
@.DSOCacheEntry.113_name = private unnamed_addr constant [40 x i8] c"libaot-Xamarin.AndroidX.Fragment.dll.so\00", align 1
@.DSOCacheEntry.114_name = private unnamed_addr constant [52 x i8] c"libaot-Xamarin.AndroidX.Lifecycle.Common.Jvm.dll.so\00", align 1
@.DSOCacheEntry.115_name = private unnamed_addr constant [55 x i8] c"libaot-Xamarin.AndroidX.Lifecycle.LiveData.Core.dll.so\00", align 1
@.DSOCacheEntry.116_name = private unnamed_addr constant [59 x i8] c"libaot-Xamarin.AndroidX.Lifecycle.ViewModel.Android.dll.so\00", align 1
@.DSOCacheEntry.117_name = private unnamed_addr constant [61 x i8] c"libaot-Xamarin.AndroidX.Lifecycle.ViewModelSavedState.dll.so\00", align 1
@.DSOCacheEntry.118_name = private unnamed_addr constant [38 x i8] c"libaot-Xamarin.AndroidX.Loader.dll.so\00", align 1
@.DSOCacheEntry.119_name = private unnamed_addr constant [49 x i8] c"libaot-Xamarin.AndroidX.Navigation.Common.dll.so\00", align 1
@.DSOCacheEntry.120_name = private unnamed_addr constant [51 x i8] c"libaot-Xamarin.AndroidX.Navigation.Fragment.dll.so\00", align 1
@.DSOCacheEntry.121_name = private unnamed_addr constant [50 x i8] c"libaot-Xamarin.AndroidX.Navigation.Runtime.dll.so\00", align 1
@.DSOCacheEntry.122_name = private unnamed_addr constant [45 x i8] c"libaot-Xamarin.AndroidX.Navigation.UI.dll.so\00", align 1
@.DSOCacheEntry.123_name = private unnamed_addr constant [44 x i8] c"libaot-Xamarin.AndroidX.RecyclerView.dll.so\00", align 1
@.DSOCacheEntry.124_name = private unnamed_addr constant [42 x i8] c"libaot-Xamarin.AndroidX.SavedState.dll.so\00", align 1
@.DSOCacheEntry.125_name = private unnamed_addr constant [50 x i8] c"libaot-Xamarin.AndroidX.SwipeRefreshLayout.dll.so\00", align 1
@.DSOCacheEntry.126_name = private unnamed_addr constant [41 x i8] c"libaot-Xamarin.AndroidX.ViewPager.dll.so\00", align 1
@.DSOCacheEntry.127_name = private unnamed_addr constant [42 x i8] c"libaot-Xamarin.AndroidX.ViewPager2.dll.so\00", align 1
@.DSOCacheEntry.128_name = private unnamed_addr constant [46 x i8] c"libaot-Xamarin.Google.Android.Material.dll.so\00", align 1
@.DSOCacheEntry.129_name = private unnamed_addr constant [36 x i8] c"libaot-Xamarin.Kotlin.StdLib.dll.so\00", align 1
@.DSOCacheEntry.130_name = private unnamed_addr constant [50 x i8] c"libaot-Xamarin.KotlinX.Coroutines.Core.Jvm.dll.so\00", align 1
@.DSOCacheEntry.131_name = private unnamed_addr constant [53 x i8] c"libaot-Xamarin.KotlinX.Serialization.Core.Jvm.dll.so\00", align 1
@.DSOCacheEntry.132_name = private unnamed_addr constant [31 x i8] c"libaot-Microsoft.CSharp.dll.so\00", align 1
@.DSOCacheEntry.133_name = private unnamed_addr constant [41 x i8] c"libaot-Microsoft.Win32.Primitives.dll.so\00", align 1
@.DSOCacheEntry.134_name = private unnamed_addr constant [29 x i8] c"libaot-System.Buffers.dll.so\00", align 1
@.DSOCacheEntry.135_name = private unnamed_addr constant [44 x i8] c"libaot-System.Collections.Concurrent.dll.so\00", align 1
@.DSOCacheEntry.136_name = private unnamed_addr constant [43 x i8] c"libaot-System.Collections.Immutable.dll.so\00", align 1
@.DSOCacheEntry.137_name = private unnamed_addr constant [44 x i8] c"libaot-System.Collections.NonGeneric.dll.so\00", align 1
@.DSOCacheEntry.138_name = private unnamed_addr constant [45 x i8] c"libaot-System.Collections.Specialized.dll.so\00", align 1
@.DSOCacheEntry.139_name = private unnamed_addr constant [33 x i8] c"libaot-System.Collections.dll.so\00", align 1
@.DSOCacheEntry.140_name = private unnamed_addr constant [48 x i8] c"libaot-System.ComponentModel.Annotations.dll.so\00", align 1
@.DSOCacheEntry.141_name = private unnamed_addr constant [47 x i8] c"libaot-System.ComponentModel.Primitives.dll.so\00", align 1
@.DSOCacheEntry.142_name = private unnamed_addr constant [50 x i8] c"libaot-System.ComponentModel.TypeConverter.dll.so\00", align 1
@.DSOCacheEntry.143_name = private unnamed_addr constant [36 x i8] c"libaot-System.ComponentModel.dll.so\00", align 1
@.DSOCacheEntry.144_name = private unnamed_addr constant [29 x i8] c"libaot-System.Console.dll.so\00", align 1
@.DSOCacheEntry.145_name = private unnamed_addr constant [33 x i8] c"libaot-System.Data.Common.dll.so\00", align 1
@.DSOCacheEntry.146_name = private unnamed_addr constant [50 x i8] c"libaot-System.Diagnostics.DiagnosticSource.dll.so\00", align 1
@.DSOCacheEntry.147_name = private unnamed_addr constant [41 x i8] c"libaot-System.Diagnostics.Process.dll.so\00", align 1
@.DSOCacheEntry.148_name = private unnamed_addr constant [44 x i8] c"libaot-System.Diagnostics.StackTrace.dll.so\00", align 1
@.DSOCacheEntry.149_name = private unnamed_addr constant [45 x i8] c"libaot-System.Diagnostics.TraceSource.dll.so\00", align 1
@.DSOCacheEntry.150_name = private unnamed_addr constant [41 x i8] c"libaot-System.Diagnostics.Tracing.dll.so\00", align 1
@.DSOCacheEntry.151_name = private unnamed_addr constant [40 x i8] c"libaot-System.Drawing.Primitives.dll.so\00", align 1
@.DSOCacheEntry.152_name = private unnamed_addr constant [29 x i8] c"libaot-System.Drawing.dll.so\00", align 1
@.DSOCacheEntry.153_name = private unnamed_addr constant [34 x i8] c"libaot-System.Formats.Asn1.dll.so\00", align 1
@.DSOCacheEntry.154_name = private unnamed_addr constant [43 x i8] c"libaot-System.IO.Compression.Brotli.dll.so\00", align 1
@.DSOCacheEntry.155_name = private unnamed_addr constant [36 x i8] c"libaot-System.IO.Compression.dll.so\00", align 1
@.DSOCacheEntry.156_name = private unnamed_addr constant [49 x i8] c"libaot-System.IO.FileSystem.AccessControl.dll.so\00", align 1
@.DSOCacheEntry.157_name = private unnamed_addr constant [43 x i8] c"libaot-System.IO.FileSystem.Watcher.dll.so\00", align 1
@.DSOCacheEntry.158_name = private unnamed_addr constant [34 x i8] c"libaot-System.IO.Pipelines.dll.so\00", align 1
@.DSOCacheEntry.159_name = private unnamed_addr constant [30 x i8] c"libaot-System.IO.Pipes.dll.so\00", align 1
@.DSOCacheEntry.160_name = private unnamed_addr constant [38 x i8] c"libaot-System.Linq.Expressions.dll.so\00", align 1
@.DSOCacheEntry.161_name = private unnamed_addr constant [36 x i8] c"libaot-System.Linq.Queryable.dll.so\00", align 1
@.DSOCacheEntry.162_name = private unnamed_addr constant [26 x i8] c"libaot-System.Linq.dll.so\00", align 1
@.DSOCacheEntry.163_name = private unnamed_addr constant [28 x i8] c"libaot-System.Memory.dll.so\00", align 1
@.DSOCacheEntry.164_name = private unnamed_addr constant [35 x i8] c"libaot-System.Net.Http.Json.dll.so\00", align 1
@.DSOCacheEntry.165_name = private unnamed_addr constant [30 x i8] c"libaot-System.Net.Http.dll.so\00", align 1
@.DSOCacheEntry.166_name = private unnamed_addr constant [40 x i8] c"libaot-System.Net.NameResolution.dll.so\00", align 1
@.DSOCacheEntry.167_name = private unnamed_addr constant [44 x i8] c"libaot-System.Net.NetworkInformation.dll.so\00", align 1
@.DSOCacheEntry.168_name = private unnamed_addr constant [36 x i8] c"libaot-System.Net.Primitives.dll.so\00", align 1
@.DSOCacheEntry.169_name = private unnamed_addr constant [34 x i8] c"libaot-System.Net.Requests.dll.so\00", align 1
@.DSOCacheEntry.170_name = private unnamed_addr constant [34 x i8] c"libaot-System.Net.Security.dll.so\00", align 1
@.DSOCacheEntry.171_name = private unnamed_addr constant [33 x i8] c"libaot-System.Net.Sockets.dll.so\00", align 1
@.DSOCacheEntry.172_name = private unnamed_addr constant [35 x i8] c"libaot-System.Net.WebClient.dll.so\00", align 1
@.DSOCacheEntry.173_name = private unnamed_addr constant [45 x i8] c"libaot-System.Net.WebHeaderCollection.dll.so\00", align 1
@.DSOCacheEntry.174_name = private unnamed_addr constant [43 x i8] c"libaot-System.Net.WebSockets.Client.dll.so\00", align 1
@.DSOCacheEntry.175_name = private unnamed_addr constant [36 x i8] c"libaot-System.Net.WebSockets.dll.so\00", align 1
@.DSOCacheEntry.176_name = private unnamed_addr constant [38 x i8] c"libaot-System.Numerics.Vectors.dll.so\00", align 1
@.DSOCacheEntry.177_name = private unnamed_addr constant [33 x i8] c"libaot-System.ObjectModel.dll.so\00", align 1
@.DSOCacheEntry.178_name = private unnamed_addr constant [55 x i8] c"libaot-System.Private.DataContractSerialization.dll.so\00", align 1
@.DSOCacheEntry.179_name = private unnamed_addr constant [33 x i8] c"libaot-System.Private.Uri.dll.so\00", align 1
@.DSOCacheEntry.180_name = private unnamed_addr constant [38 x i8] c"libaot-System.Private.Xml.Linq.dll.so\00", align 1
@.DSOCacheEntry.181_name = private unnamed_addr constant [33 x i8] c"libaot-System.Private.Xml.dll.so\00", align 1
@.DSOCacheEntry.182_name = private unnamed_addr constant [50 x i8] c"libaot-System.Reflection.Emit.ILGeneration.dll.so\00", align 1
@.DSOCacheEntry.183_name = private unnamed_addr constant [49 x i8] c"libaot-System.Reflection.Emit.Lightweight.dll.so\00", align 1
@.DSOCacheEntry.184_name = private unnamed_addr constant [37 x i8] c"libaot-System.Reflection.Emit.dll.so\00", align 1
@.DSOCacheEntry.185_name = private unnamed_addr constant [43 x i8] c"libaot-System.Reflection.Primitives.dll.so\00", align 1
@.DSOCacheEntry.186_name = private unnamed_addr constant [64 x i8] c"libaot-System.Runtime.InteropServices.RuntimeInformation.dll.so\00", align 1
@.DSOCacheEntry.187_name = private unnamed_addr constant [45 x i8] c"libaot-System.Runtime.InteropServices.dll.so\00", align 1
@.DSOCacheEntry.188_name = private unnamed_addr constant [36 x i8] c"libaot-System.Runtime.Loader.dll.so\00", align 1
@.DSOCacheEntry.189_name = private unnamed_addr constant [38 x i8] c"libaot-System.Runtime.Numerics.dll.so\00", align 1
@.DSOCacheEntry.190_name = private unnamed_addr constant [54 x i8] c"libaot-System.Runtime.Serialization.Formatters.dll.so\00", align 1
@.DSOCacheEntry.191_name = private unnamed_addr constant [48 x i8] c"libaot-System.Runtime.Serialization.Json.dll.so\00", align 1
@.DSOCacheEntry.192_name = private unnamed_addr constant [54 x i8] c"libaot-System.Runtime.Serialization.Primitives.dll.so\00", align 1
@.DSOCacheEntry.193_name = private unnamed_addr constant [47 x i8] c"libaot-System.Runtime.Serialization.Xml.dll.so\00", align 1
@.DSOCacheEntry.194_name = private unnamed_addr constant [29 x i8] c"libaot-System.Runtime.dll.so\00", align 1
@.DSOCacheEntry.195_name = private unnamed_addr constant [44 x i8] c"libaot-System.Security.AccessControl.dll.so\00", align 1
@.DSOCacheEntry.196_name = private unnamed_addr constant [37 x i8] c"libaot-System.Security.Claims.dll.so\00", align 1
@.DSOCacheEntry.197_name = private unnamed_addr constant [54 x i8] c"libaot-System.Security.Cryptography.Algorithms.dll.so\00", align 1
@.DSOCacheEntry.198_name = private unnamed_addr constant [47 x i8] c"libaot-System.Security.Cryptography.Cng.dll.so\00", align 1
@.DSOCacheEntry.199_name = private unnamed_addr constant [47 x i8] c"libaot-System.Security.Cryptography.Csp.dll.so\00", align 1
@.DSOCacheEntry.200_name = private unnamed_addr constant [52 x i8] c"libaot-System.Security.Cryptography.Encoding.dll.so\00", align 1
@.DSOCacheEntry.201_name = private unnamed_addr constant [54 x i8] c"libaot-System.Security.Cryptography.Primitives.dll.so\00", align 1
@.DSOCacheEntry.202_name = private unnamed_addr constant [60 x i8] c"libaot-System.Security.Cryptography.X509Certificates.dll.so\00", align 1
@.DSOCacheEntry.203_name = private unnamed_addr constant [43 x i8] c"libaot-System.Security.Cryptography.dll.so\00", align 1
@.DSOCacheEntry.204_name = private unnamed_addr constant [48 x i8] c"libaot-System.Security.Principal.Windows.dll.so\00", align 1
@.DSOCacheEntry.205_name = private unnamed_addr constant [45 x i8] c"libaot-System.Text.Encoding.CodePages.dll.so\00", align 1
@.DSOCacheEntry.206_name = private unnamed_addr constant [46 x i8] c"libaot-System.Text.Encoding.Extensions.dll.so\00", align 1
@.DSOCacheEntry.207_name = private unnamed_addr constant [40 x i8] c"libaot-System.Text.Encodings.Web.dll.so\00", align 1
@.DSOCacheEntry.208_name = private unnamed_addr constant [31 x i8] c"libaot-System.Text.Json.dll.so\00", align 1
@.DSOCacheEntry.209_name = private unnamed_addr constant [45 x i8] c"libaot-System.Text.RegularExpressions.dll.so\00", align 1
@.DSOCacheEntry.210_name = private unnamed_addr constant [40 x i8] c"libaot-System.Threading.Channels.dll.so\00", align 1
@.DSOCacheEntry.211_name = private unnamed_addr constant [48 x i8] c"libaot-System.Threading.Tasks.Extensions.dll.so\00", align 1
@.DSOCacheEntry.212_name = private unnamed_addr constant [38 x i8] c"libaot-System.Threading.Thread.dll.so\00", align 1
@.DSOCacheEntry.213_name = private unnamed_addr constant [42 x i8] c"libaot-System.Threading.ThreadPool.dll.so\00", align 1
@.DSOCacheEntry.214_name = private unnamed_addr constant [31 x i8] c"libaot-System.Threading.dll.so\00", align 1
@.DSOCacheEntry.215_name = private unnamed_addr constant [40 x i8] c"libaot-System.Transactions.Local.dll.so\00", align 1
@.DSOCacheEntry.216_name = private unnamed_addr constant [37 x i8] c"libaot-System.Web.HttpUtility.dll.so\00", align 1
@.DSOCacheEntry.217_name = private unnamed_addr constant [30 x i8] c"libaot-System.Xml.Linq.dll.so\00", align 1
@.DSOCacheEntry.218_name = private unnamed_addr constant [38 x i8] c"libaot-System.Xml.ReaderWriter.dll.so\00", align 1
@.DSOCacheEntry.219_name = private unnamed_addr constant [35 x i8] c"libaot-System.Xml.XDocument.dll.so\00", align 1
@.DSOCacheEntry.220_name = private unnamed_addr constant [39 x i8] c"libaot-System.Xml.XmlSerializer.dll.so\00", align 1
@.DSOCacheEntry.221_name = private unnamed_addr constant [21 x i8] c"libaot-System.dll.so\00", align 1
@.DSOCacheEntry.222_name = private unnamed_addr constant [23 x i8] c"libaot-mscorlib.dll.so\00", align 1
@.DSOCacheEntry.223_name = private unnamed_addr constant [26 x i8] c"libaot-netstandard.dll.so\00", align 1
@.DSOCacheEntry.224_name = private unnamed_addr constant [27 x i8] c"libaot-Java.Interop.dll.so\00", align 1
@.DSOCacheEntry.225_name = private unnamed_addr constant [35 x i8] c"libaot-Mono.Android.Runtime.dll.so\00", align 1
@.DSOCacheEntry.226_name = private unnamed_addr constant [27 x i8] c"libaot-Mono.Android.dll.so\00", align 1
@.DSOCacheEntry.227_name = private unnamed_addr constant [37 x i8] c"libaot-System.Private.CoreLib.dll.so\00", align 1

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
