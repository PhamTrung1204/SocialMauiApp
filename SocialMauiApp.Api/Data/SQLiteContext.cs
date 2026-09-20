using Microsoft.EntityFrameworkCore;
using SocialMauiApp.Api.Data.Entities;

namespace SocialMauiApp.Api.Data
{
    public class SQLiteContext : DbContext
    {
        public DbSet<Post> Posts { get; set; }
        public DbSet<Comment> Comments { get; set; }
        public DbSet<SyncMetadata> SyncMetadata { get; set; }
        public DbSet<User> Users { get; set; }

        public SQLiteContext(DbContextOptions<SQLiteContext> options) : base(options) { }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            modelBuilder.Entity<Post>().ToTable("Posts");
            modelBuilder.Entity<Comment>().ToTable("Comments");
            modelBuilder.Entity<User>().ToTable("Users");

            modelBuilder.Entity<SyncMetadata>(e =>
            {
                e.ToTable("SyncMetadata");
                e.Property(x => x.ConcurrencyToken).IsConcurrencyToken();
            });

            modelBuilder.ApplyUtcDateTimeConversion();
        }
    }
}
