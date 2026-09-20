namespace SocialMauiApp.Api.Services
{
    public class PhotoUploadService
    {
        private static readonly string[] ImageExtensions = [".jpg", ".jpeg", ".png", ".gif", ".bmp", ".webp"];
        private static readonly string[] VideoExtensions = [".mp4", ".mov", ".m4v", ".webm"];

        private const long MaxImageBytes = 5 * 1024 * 1024;    // 5 MB
        private const long MaxVideoBytes = 60 * 1024 * 1024;   // 60 MB

        private readonly IWebHostEnvironment _webHostEnvironment;
        private readonly IConfiguration _configuration;

        public PhotoUploadService(IWebHostEnvironment webHostEnvironment, IConfiguration configuration)
        {
            _webHostEnvironment = webHostEnvironment ?? throw new ArgumentNullException(nameof(webHostEnvironment));
            _configuration = configuration ?? throw new ArgumentNullException(nameof(configuration));
        }

        public async Task<(string PhotoPath, string PhotoUrl)> SavePhotoAsync(IFormFile photo, params string[] folderPaths) =>
            await SaveFileAsync(photo, ImageExtensions, MaxImageBytes, folderPaths);

        public async Task<(string VideoPath, string VideoUrl)> SaveVideoAsync(IFormFile video, params string[] folderPaths) =>
            await SaveFileAsync(video, VideoExtensions, MaxVideoBytes, folderPaths);

        public bool IsVideo(IFormFile file) =>
            !string.IsNullOrEmpty(file.FileName)
            && VideoExtensions.Contains(Path.GetExtension(file.FileName).ToLowerInvariant());

        private async Task<(string FilePath, string FileUrl)> SaveFileAsync(
            IFormFile file,
            string[] allowedExtensions,
            long maxBytes,
            string[] folderPaths)
        {
            if (file is null || string.IsNullOrEmpty(file.FileName))
                throw new ArgumentNullException(nameof(file), "File is null or invalid.");

            if (folderPaths is null || folderPaths.Length == 0)
                throw new ArgumentNullException(nameof(folderPaths), "Folder paths cannot be null or empty.");

            if (string.IsNullOrEmpty(_webHostEnvironment?.WebRootPath))
                throw new InvalidOperationException("WebRootPath is not set.");

            var extension = Path.GetExtension(file.FileName).ToLowerInvariant();
            if (!allowedExtensions.Contains(extension))
                throw new InvalidOperationException($"Invalid file type. Allowed types are: {string.Join(", ", allowedExtensions)}");

            if (file.Length > maxBytes)
                throw new InvalidOperationException($"File size exceeds the limit of {maxBytes / (1024 * 1024)} MB.");

            var physicalPaths = new List<string> { _webHostEnvironment.WebRootPath };
            physicalPaths.AddRange(folderPaths);
            var targetFolderPath = Path.Combine([.. physicalPaths]);
            Directory.CreateDirectory(targetFolderPath);

            var newFileName = $"{Guid.NewGuid()}_{DateTime.UtcNow.Ticks}{extension}";
            var fullPath = Path.Combine(targetFolderPath, newFileName);

            await using (var fs = new FileStream(fullPath, FileMode.Create))
            {
                await file.CopyToAsync(fs);
            }

            var domainUrl = _configuration.GetValue<string>("Domain")?.TrimEnd('/');
            if (string.IsNullOrEmpty(domainUrl))
                throw new InvalidOperationException("Domain is not configured properly.");

            var relativePath = Path.Combine(folderPaths).Replace("\\", "/").Trim('/');
            return (fullPath, $"{domainUrl}/{relativePath}/{newFileName}");
        }
    }
}
