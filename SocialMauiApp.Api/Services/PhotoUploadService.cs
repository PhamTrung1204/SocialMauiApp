using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;

namespace SocialMauiApp.Api.Services
{
    public class PhotoUploadService
    {
        private readonly IWebHostEnvironment _webHostEnvironment;
        private readonly IConfiguration _configuration;
        private readonly string[] _allowedExtensions = { ".jpg", ".jpeg", ".png", ".gif", ".bmp" };
        private const long _maxFileSize = 5 * 1024 * 1024; // 5MB

        public PhotoUploadService(IWebHostEnvironment webHostEnvironment, IConfiguration configuration)
        {
            _webHostEnvironment = webHostEnvironment ?? throw new ArgumentNullException(nameof(webHostEnvironment));
            _configuration = configuration ?? throw new ArgumentNullException(nameof(configuration));
        }

        public async Task<(string PhotoPath, string PhotoUrl)> SavePhotoAsync(IFormFile photo, params string[] folderPaths)
        {
            // 1. Xây dựng đường dẫn vật lý để lưu file
            var physicalPaths = new List<string> { _webHostEnvironment.WebRootPath };
            physicalPaths.AddRange(folderPaths);
            var targetFolderPath = Path.Combine(physicalPaths.ToArray());

            if (!Directory.Exists(targetFolderPath))
            {
                Directory.CreateDirectory(targetFolderPath);
            }

            // 2. Tạo tên file mới (dùng GUID để đảm bảo duy nhất)
            var extension = Path.GetExtension(photo.FileName);
            var newPhotoName = $"{Guid.NewGuid()}_{DateTime.UtcNow.Ticks}{extension}";
            var fullPhotoPath = Path.Combine(targetFolderPath, newPhotoName);

            // 3. Lưu file ảnh vào đường dẫn vật lý
            using (var fs = new FileStream(fullPhotoPath, FileMode.Create))
            {
                await photo.CopyToAsync(fs);
            }

            // 4. Tạo URL công khai cho ảnh
            var domainUrl = _configuration.GetValue<string>("Domain")?.TrimEnd('/');
            var relativePath = Path.Combine(folderPaths).Replace("\\", "/"); // Đảm bảo URL đúng
            var photoUrl = $"{domainUrl}/{relativePath}/{newPhotoName}";

            return (fullPhotoPath, photoUrl); // Chỉ trả về 2 giá trị, đúng với phương thức gọi nó
        }

    }
}
