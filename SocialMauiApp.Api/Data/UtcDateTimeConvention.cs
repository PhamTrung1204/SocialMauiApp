using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;

namespace SocialMauiApp.Api.Data
{
    public static class UtcDateTimeConvention
    {
        // PostgreSQL 'timestamp with time zone' chỉ nhận DateTime có Kind=Utc.
        // Giá trị Local được đổi sang UTC; giá trị Unspecified (ví dụ đọc từ
        // SQLite hoặc từ query string) được coi là đã ở UTC.
        private static readonly ValueConverter<DateTime, DateTime> ToUtc = new(
            v => v.Kind == DateTimeKind.Utc
                ? v
                : v.Kind == DateTimeKind.Local
                    ? v.ToUniversalTime()
                    : DateTime.SpecifyKind(v, DateTimeKind.Utc),
            v => DateTime.SpecifyKind(v, DateTimeKind.Utc));

        private static readonly ValueConverter<DateTime?, DateTime?> ToUtcNullable = new(
            v => !v.HasValue
                ? v
                : v.Value.Kind == DateTimeKind.Utc
                    ? v
                    : v.Value.Kind == DateTimeKind.Local
                        ? v.Value.ToUniversalTime()
                        : DateTime.SpecifyKind(v.Value, DateTimeKind.Utc),
            v => v.HasValue ? DateTime.SpecifyKind(v.Value, DateTimeKind.Utc) : v);

        public static void ApplyUtcDateTimeConversion(this ModelBuilder modelBuilder)
        {
            foreach (var entityType in modelBuilder.Model.GetEntityTypes())
            {
                foreach (var property in entityType.GetProperties())
                {
                    if (property.ClrType == typeof(DateTime))
                    {
                        property.SetValueConverter(ToUtc);
                    }
                    else if (property.ClrType == typeof(DateTime?))
                    {
                        property.SetValueConverter(ToUtcNullable);
                    }
                }
            }
        }
    }
}
