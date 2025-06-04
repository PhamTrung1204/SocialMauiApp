using Microsoft.EntityFrameworkCore;
using SocialMauiApp.Api.Data.Entities;
using System.IO;

namespace SocialMauiApp.Api.Data
{
    public class SQLiteContext : DbContext
    {
        public DbSet<Post> Posts { get; set; }
        public DbSet<Comment> Comments { get; set; }
        public DbSet<SyncMetadata> SyncMetadata { get; set; }
        public DbSet<User> Users { get; set; }
        public SQLiteContext(DbContextOptions<SQLiteContext> options) : base(options)
        {
            // Ensure the database and tables are created
            Database.EnsureCreated();
            Console.WriteLine($"SQLite database ensured created at {DateTime.Now:HH:mm:ss} +07, 04/06/2025.");
        }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
                var dataDirectory = Path.Combine(Directory.GetCurrentDirectory(), "Data");
                if (!Directory.Exists(dataDirectory))
                {
                    Directory.CreateDirectory(dataDirectory);
                    Console.WriteLine($"Created Data directory at {dataDirectory} at {DateTime.Now:HH:mm:ss} +07, 04/06/2025.");
                }

                var dbPath = Path.Combine(dataDirectory, "socialmauiapp.db");
                Console.WriteLine($"SQLite database path: {dbPath} at {DateTime.Now:HH:mm:ss} +07, 04/06/2025.");
                optionsBuilder.UseSqlite($"Filename={dbPath}");
            }
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<SyncMetadata>().ToTable("SyncMetadata");
            modelBuilder.Entity<SyncMetadata>().Property(x => x.RowVersion).IsRowVersion(); // Cấu hình RowVersion
            modelBuilder.Entity<Post>().ToTable("Posts");
            modelBuilder.Entity<Comment>().ToTable("Comments");
            modelBuilder.Entity<User>().ToTable("Users");
        }
    }
}