using MeuPet.Domain.Model.Administrativo;
using MeuPet.Domain.Model.Configuracao;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Options;

namespace MeuPet.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AutenticacaoController : ControllerBase
    {
        private readonly SignInManager<IdentityUser> _signInManager;
        private readonly UserManager<IdentityUser> _userManager;
        private readonly AppSettings _appSettings;

        public AutenticacaoController(SignInManager<IdentityUser> signInManager, UserManager<IdentityUser> userManager,
          IOptions<AppSettings> appSettings)
        {
            _signInManager = signInManager;
            _userManager = userManager;
            _appSettings = appSettings.Value;
        }

        [HttpPost("nova-conta")]
        public async Task<ActionResult> Registrar(RegistrarUsuario registrarUsuario)
        {
            if (!ModelState.IsValid) return BadRequest(ModelState.Values.SelectMany(e => e.Errors));

            // processo para criar o usuário do identity
            var usuarioIdentity = new IdentityUser
            {
                UserName = registrarUsuario.Email,
                Email = registrarUsuario.Email,
                EmailConfirmed = true
            };

            var result = await _userManager.CreateAsync(usuarioIdentity, registrarUsuario.Password);

            if (!result.Succeeded)
            {
                return BadRequest(result.Errors);
            }
            else
            {
                Usuario modelUsuario = new Usuario();

                modelUsuario.AspNetUserId = usuarioIdentity.Id;
                modelUsuario.Nome = usuarioIdentity.NormalizedUserName

            }


            await _signInManager.SignInAsync(user, false);

            return Ok();
        }

    }
}
