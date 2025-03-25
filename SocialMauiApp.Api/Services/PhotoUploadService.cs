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
            // Kiểm tra file có tồn tại và tên hợp lệ hay không
            if (photo == null || string.IsNullOrEmpty(photo.FileName))
                throw new ArgumentNullException(nameof(photo), "Photo file is null or invalid.");

            // Kiểm tra folderPaths có hợp lệ không
            if (folderPaths == null || !folderPaths.Any())
                throw new ArgumentNullException(nameof(folderPaths), "Folder paths cannot be null or empty.");

            // Kiểm tra WebRootPath đã được thiết lập chưa
            if (string.IsNullOrEmpty(_webHostEnvironment?.WebRootPath))
                throw new InvalidOperationException("WebRootPath is not set.");

            // Validate extension: chuyển về chữ thường để so sánh
            var extension = Path.GetExtension(photo.FileName).ToLower();
            if (!_allowedExtensions.Contains(extension))
                throw new InvalidOperationException($"Invalid file type. Allowed types are: {string.Join(", ", _allowedExtensions)}");

            // Validate kích thước file
            if (photo.Length > _maxFileSize)
                throw new InvalidOperationException($"File size exceeds the limit of {_maxFileSize / (1024 * 1024)} MB.");

            // Xây dựng đường dẫn vật lý để lưu file
            var physicalPaths = new List<string> { _webHostEnvironment.WebRootPath };
            physicalPaths.AddRange(folderPaths);
            var targetFolderPath = Path.Combine(physicalPaths.ToArray());

            // Tạo thư mục nếu chưa tồn tại
            if (!Directory.Exists(targetFolderPath))
                Directory.CreateDirectory(targetFolderPath);

            // Tạo tên file mới duy nhất
            var newPhotoName = $"{Guid.NewGuid()}_{DateTime.UtcNow.Ticks}{extension}";
            var fullPhotoPath = Path.Combine(targetFolderPath, newPhotoName);

            // Lưu file ảnh vào đường dẫn vật lý
            using (var fs = new FileStream(fullPhotoPath, FileMode.Create))
            {
                await photo.CopyToAsync(fs);
            }

            // Lấy domain từ cấu hình
            var domainUrl = _configuration.GetValue<string>("Domain")?.TrimEnd('/');
            if (string.IsNullOrEmpty(domainUrl))
                throw new InvalidOperationException("Domain is not configured properly.");

            // Tạo URL công khai cho ảnh
            var relativePath = Path.Combine(folderPaths).Replace("\\", "/").Trim('/');
            var photoUrl = $"{domainUrl}/{relativePath}/{newPhotoName}";

            Console.WriteLine($"\ud83d\udcf8 Full Photo Path: {fullPhotoPath}");
            Console.WriteLine($"\ud83c\udf10 Public Photo URL: {photoUrl}");

            return (fullPhotoPath, photoUrl);
        }
    }
}
