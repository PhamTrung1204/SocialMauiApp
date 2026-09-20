using Microsoft.EntityFrameworkCore;
using SocialMauiApp.Api.Data.Entities;

namespace SocialMauiApp.Api.Data
{
    public class DataContext : DbContext
    {
        public DataContext(DbContextOptions<DataContext> options) : base(options) { }

        public DbSet<Bookmarks> Bookmarks { get; set; }
        public DbSet<Comment> Comments { get; set; }
        public DbSet<Likes> Likes { get; set; }
        public DbSet<Notification> Notifications { get; set; }
        public DbSet<Post> Posts { get; set; }
        public DbSet<User> Users { get; set; }
        public DbSet<SyncMetadata> SyncMetadatas { get; set; }
        public DbSet<Friendship> Friendships { get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            base.OnConfiguring(optionsBuilder);
            optionsBuilder.UseQueryTrackingBehavior(QueryTrackingBehavior.NoTracking);
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            modelBuilder.Entity<User>(e =>
            {
                e.HasIndex(u => u.Email).IsUnique();
            });

            modelBuilder.Entity<Bookmarks>(e =>
            {
                e.HasKey(b => new { b.PostId, b.UserId });
                e.HasOne(b => b.User).WithMany().OnDelete(DeleteBehavior.Restrict);
            });

            modelBuilder.Entity<Likes>(e =>
            {
                e.HasKey(b => new { b.PostId, b.UserId });
                e.HasOne(b => b.User).WithMany().OnDelete(DeleteBehavior.Restrict);
            });

            modelBuilder.Entity<Comment>(e =>
            {
                e.HasOne(b => b.User).WithMany().OnDelete(DeleteBehavior.Restrict);
            });

            modelBuilder.Entity<Notification>(e =>
            {
                e.HasOne(b => b.User).WithMany().OnDelete(DeleteBehavior.Restrict);
                e.HasOne(b => b.Post).WithMany().OnDelete(DeleteBehavior.Restrict);
            });

            modelBuilder.Entity<Friendship>(e =>
            {
                e.HasKey(f => new { f.RequesterId, f.AddresseeId });
                e.Property(f => f.Status).HasConversion<string>().HasMaxLength(20);
                e.HasIndex(f => f.AddresseeId);
                e.HasIndex(f => f.Status);
                e.HasOne(f => f.Requester).WithMany().HasForeignKey(f => f.RequesterId).OnDelete(DeleteBehavior.Restrict);
                e.HasOne(f => f.Addressee).WithMany().HasForeignKey(f => f.AddresseeId).OnDelete(DeleteBehavior.Restrict);
            });

            modelBuilder.Entity<SyncMetadata>(e =>
            {
                e.ToTable("SyncMetadata");
                e.Property(x => x.ConcurrencyToken).IsConcurrencyToken();
            });

            modelBuilder.ApplyUtcDateTimeConversion();
        }
    }
}
