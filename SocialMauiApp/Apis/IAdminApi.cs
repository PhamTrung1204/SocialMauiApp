using Refit;
using SocialMediaMaui.Shared.Dtos;
using System;
using System.Threading.Tasks;

namespace SocialMauiApp.Apis
{
    [Headers("Authorization: Bearer")]
    public interface IAdminApi
    {
        [Get("/api/admin/dashboard")]
        Task<DashboardDto> GetDashboardAsync();

        [Get("/api/admin/users")]
        Task<UserDto[]> GetUsersAsync([Query] string? search, [Query] string? role, [Query] int page, [Query] int pageSize);

        [Post("/api/admin/users/{userId}/lock")]
        Task<ApiResult> LockUserAsync(Guid userId);

        [Post("/api/admin/users/{userId}/unlock")]
        Task<ApiResult> UnlockUserAsync(Guid userId);

        [Delete("/api/admin/users/{userId}")]
        Task<ApiResult> DeleteUserAsync(Guid userId);
    }
}