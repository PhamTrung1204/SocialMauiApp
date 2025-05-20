using Microsoft.EntityFrameworkCore;
using SocialMauiApp.Api.Data.Entities;

namespace SocialMauiApp.Api.Data
{
    public class SQLiteContext : DbContext
    {
        public DbSet<Post> Posts { get; set; }
        public DbSet<Comment> Comments { get; set; }
        public DbSet<SyncMetadata> SyncMetadata { get; set; }

        public SQLiteContext(DbContextOptions<SQLiteContext> options) : base(options) { }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
                var dbPath = Path.Combine(Directory.GetCurrentDirectory(), "Data", "socialmauiapp.db");
                optionsBuilder.UseSqlite($"Filename={dbPath}");
            }
        }
    }
}