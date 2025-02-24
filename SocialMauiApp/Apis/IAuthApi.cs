using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Refit;
using SocialMediaMaui.Shared.Dtos;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;



namespace SocialMauiApp.Apis;

public interface IAuthApi
{
    [Post("/api/auth/register")]
    Task<ApiResult<Guid>> RegisterAsync(RegisterDto dto);
    [Multipart]
    [Post("/api/auth/register/{userId}/add-photo")]
    Task<ApiResult> UploadPhotoAsync(Guid userId, StreamPart photo);
    [Post("/api/auth/login")]
    Task<ApiResult<LoginResponseDto>> LoginAsync(LoginDto dto);

}
