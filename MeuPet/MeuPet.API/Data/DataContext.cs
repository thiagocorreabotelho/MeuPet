
using MeuPet.Domain.Model.Administrativo;
using MeuPet.Domain.Model.Configuracao;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;

namespace MeuPet.API.Data
{
    public class ApplicationDbContext : IdentityDbContext
    {

        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options)
           : base(options)
        {
        }

    }

    /// <summary>
    /// O DataContext tem como função de executar procedures das nossas entidades.
    /// </summary>
    public class DataContext : DbContext
    {
        public DataContext(DbContextOptions<DataContext> options)
                       : base(options)
        {
            Database.SetCommandTimeout(150000);
        }

        #region Validar token ativo
        private DbSet<Token> Token { get; set; }

        public bool ValidarToken(string usuario, string token)
        {
            if (string.IsNullOrWhiteSpace(usuario) || string.IsNullOrWhiteSpace(token))
            {
                return false;
            }

            var validarTokenUsuario = Token.FromSqlInterpolated($"Exec [Administrativo].[spValidarTokenUsuario]{token}, {usuario}").AsEnumerable().FirstOrDefault();
            if (validarTokenUsuario.EhValido.Equals("True") == null) return false;

            return true;
        }

        #endregion

        #region Utilitários

        private DbSet<RetornarIdentificador> ValorId { get; set; }

        #endregion

        #region Empresa

        private DbSet<spConsultarEmpresa> _spConsultarEmpresa { get; set; }

        public spConsultarEmpresa ConsultarEmpresa(string token, string usuario)
        {

            var retorno = _spConsultarEmpresa.FromSqlInterpolated($"Exec [Administrativo].[spConsultarEmpresa]  {token}, {usuario} ").AsEnumerable().FirstOrDefault();

            return retorno;

        }

        public string EditarEmpresa(Empresa empresa)
        {
            try
            {
                Database.ExecuteSqlInterpolated($"Exec Administrativo.spEditarEmpresa {empresa.Token}, {empresa.Nome}, {empresa.CNPJ}, {empresa.DataAbertura}, {empresa.Email}, {empresa.CEP}, {empresa.Endereco}, {empresa.Numero}, {empresa.Complemento}, {empresa.Bairro}, {empresa.Cidade}, {empresa.Estado}, {empresa.Whatsapp}, {empresa.Logo}, {empresa.Usuario}");

                return "Dados Editados";
            }
            catch (Exception ex)
            {

                throw;
            }
        }


        #endregion

        //#region Usuarios

        //private DbSet<RegistrarUsuario> _registrarUsuario { get; set; }

        //public int CriarUsuario(RegistrarUsuario registrarUsuario)
        //{
        //    try
        //    {
        //        if (registrarUsuario == null) return 00;

        //        var retorno = ValorId.FromSqlInterpolated($"Exec [Administrativo].[spCriarUsuarios] {registrarUsuario.EmpresaToken}, {registrarUsuario.AspNetUserId}, {registrarUsuario.Nome}, {registrarUsuario.Sobrenome}, ");
        //    }
        //    catch (Exception ex)
        //    {
        //        return ex.Message;
        //    }
        //}
        //#endregion
    }
}
