using MeuPet.API.Data;
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
        private DataContext _dataContext;

        public AutenticacaoController(SignInManager<IdentityUser> signInManager, UserManager<IdentityUser> userManager,
          IOptions<AppSettings> appSettings, DataContext dataContext)
        {
            _signInManager = signInManager;
            _userManager = userManager;
            _appSettings = appSettings.Value;
            _dataContext = dataContext;
        }

        [HttpPost("nova-conta")]
        public async Task<ActionResult> Registrar(Usuario usuario)
        {
            if (!ModelState.IsValid) return BadRequest(ModelState.Values.SelectMany(e => e.Errors));

            // processo para criar o usuário do identity
            var usuarioIdentity = new IdentityUser
            {
                UserName = usuario.Email,
                Email = usuario.Email,
                EmailConfirmed = true
            };

            var result = await _userManager.CreateAsync(usuarioIdentity, usuario.Senha);
            usuario.AspNetUserId = usuarioIdentity.Id;

            if (!result.Succeeded)
            {
                return BadRequest(result.Errors);
            }
            else
            {
                await _signInManager.SignInAsync(usuarioIdentity, false);

                var retorno = await _dataContext.CriarUsuario(usuario);

                return Ok();

            }

        }

    }
}
