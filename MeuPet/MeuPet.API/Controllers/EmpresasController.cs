using MeuPet.API.Data;
using MeuPet.Domain.Model.Administrativo;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace MeuPet.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class EmpresasController : Controller
    {
        private DataContext _dataContext;

        public EmpresasController(DataContext dataContext)
        {
            _dataContext = dataContext;
        }

        // GET api/controller/5																						
        [HttpGet("{entidadeToken}")]
        public IActionResult Get(string entidadeToken, string usuario, string usuarioToken)
        {

            // Validação dos parâmetros																				
            if (usuarioToken == null || usuario == null)
            {
                return BadRequest("Parâmetros ausentes (usuario ou token)");
            }

            // Validação do token																						
            if (_dataContext.ValidarToken(usuario, usuarioToken) == false)
            {
                return Unauthorized();
            }

            try
            {

                // Operação de Consulta																				
                var valor = _dataContext.ConsultarEmpresa(entidadeToken, usuario);

                return Json(valor);

            }
            catch (Exception ex)
            {
                return StatusCode(500, ex.Message);
            }
        }

        [HttpPut("{entidadeToken}")]
        public IActionResult Put(string entidadeToken, [FromBody] Empresa empresa)
        {
            if (empresa == null)
                return BadRequest("Parâmetro(s) ausente(s).");

            if (entidadeToken != empresa.Token)
                return BadRequest("Parâmetro(s) inválidos.");

            if (!empresa.Usuario.Contains("@"))
                return BadRequest("Usuário é inválido");

            // Validação do token																						
            if (_dataContext.ValidarToken(empresa.Usuario, empresa.UsuarioToken) == false)
                return Unauthorized();

            try
            {
                var dados = _dataContext.EditarEmpresa(empresa);

                if (dados != "Dados Editados")
                    return StatusCode(500);

                return Ok();
            }
            catch (Exception ex)
            {
                return StatusCode(500, ex.Message);
            }
        }
    }
}
