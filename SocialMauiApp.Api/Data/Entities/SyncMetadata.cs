using System.ComponentModel.DataAnnotations;

namespace SocialMauiApp.Api.Data.Entities
{
    public class SyncMetadata
    {
        public int Id { get; set; }
        public DateTime LastSyncTime { get; set; }
        [Timestamp] // Đánh dấu thuộc tính này là token đồng thời
        public byte[] RowVersion { get; set; } // Thêm thuộc tính này cho kiểm soát đồng thời
    }
}
