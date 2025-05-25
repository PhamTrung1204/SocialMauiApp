using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SocialMauiApp.Services
{
    public interface IDeepLinkService
    {
        Uri? GetPendingDeepLink();
        void ClearPendingDeepLink();
    }
}
