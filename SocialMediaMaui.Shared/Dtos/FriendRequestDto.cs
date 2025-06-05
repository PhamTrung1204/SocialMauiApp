using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SocialMediaMaui.Shared.Dtos
{
    public record FriendRequestDto(Guid FromUserId, Guid ToUserId, string Status);
}
