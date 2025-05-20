using SQLite;

namespace SocialMauiApp.Data
{
    [Table("SyncMetadata")]
    public class SyncMetadata
    {
        [PrimaryKey]
        public int Id { get; set; }
        public DateTime LastSyncTime { get; set; }
    }
}