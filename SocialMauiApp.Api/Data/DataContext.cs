using Microsoft.EntityFrameworkCore;
using SocialMauiApp.Api.Data.Entities;
using SocialMediaMaui.Shared.Dtos;

namespace SocialMauiApp.Api.Data
{
    public class DataContext:DbContext
    {
        public DataContext(DbContextOptions<DataContext> options) : base(options) 
        {

        }
        public DbSet<Bookmarks> Bookmarks { get; set; }
        public DbSet<Comment> Comments { get; set; }
        public DbSet<Likes> Likes { get; set; }
        public DbSet<Notification> Notifications { get; set; }
        public DbSet<Post> Posts { get; set; }
        public DbSet<User> Users { get; set; }
        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            base.OnConfiguring(optionsBuilder);
            optionsBuilder.UseQueryTrackingBehavior(QueryTrackingBehavior.NoTracking);
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            // Đăng ký PostDto là keyless entity
            modelBuilder.Entity<PostDto>().HasNoKey();

            // Cấu hình chuyển đổi cho IsLiked: chuyển bool thành int khi lưu, và int thành bool khi đọc
            modelBuilder.Entity<PostDto>()
                .Property(p => p.IsLiked)
                .HasConversion(
                    v => v ? 1 : 0,   // Khi lưu: true -> 1, false -> 0
                    v => v == 1       // Khi đọc: 1 -> true, 0 -> false
                );

            // Tương tự cho IsBookmarked
            modelBuilder.Entity<PostDto>()
                .Property(p => p.IsBookmarked)
                .HasConversion(
                    v => v ? 1 : 0,
                    v => v == 1
                );

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
            });
        }

    }
}
