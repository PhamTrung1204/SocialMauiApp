namespace SocialMauiApp.Api.Data.Entities
{
    public class SyncMetadata
    {
        public int Id { get; set; }
        public DateTime LastSyncTime { get; set; }

        // Token đồng thời do ứng dụng quản lý: hoạt động giống nhau trên cả
        // PostgreSQL và SQLite (SQL Server rowversion không có tương đương).
        public Guid ConcurrencyToken { get; set; }
    }
}
