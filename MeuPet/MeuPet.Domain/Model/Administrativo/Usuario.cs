using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MeuPet.Domain.Model.Administrativo
{
    public class Usuario : spConsultarUsuario
    {
        #region Parâmetros Internos

        private string _entidade { get { return "Empresas"; } }
        public string UsuarioEntidade { get; set; }
        public string UsuarioToken { get; set; }

        #endregion

        #region Contrutores

        public Usuario()
        {
            UsuarioEntidade = string.Empty;
            UsuarioToken = string.Empty;
        }

        public Usuario(string usuario, string usuarioToken)
        {
            UsuarioEntidade = usuario;
            UsuarioToken = usuarioToken;
        }

        #endregion
    }

    public class spConsultarUsuario
    {
        [Key]
        [Required(ErrorMessage = "* O campo {0} é obrigatório")]
        [Display(Name = "Usuario Id")]
        public int UsuarioId { get; set; }

        [Required(ErrorMessage = "* O campo {0} é obrigatório")]
        [Display(Name = "Empresa Id")]
        public int EmpresaId { get; set; }

        [Required(ErrorMessage = "* O campo {0} é obrigatório")]
        [Display(Name = "AspNetUserId")]
        public string AspNetUserId { get; set; }

        [Display(Name = "Token")]
        public string Token { get; set; }

        [Required(ErrorMessage = "* O campo {0} é obrigatório")]
        [MaxLength(100, ErrorMessage = "* máximo {0} caracteres")]
        [Display(Name = "Nome")]
        public string Nome { get; set; }

        [Required(ErrorMessage = "* O campo {0} é obrigatório")]
        [MaxLength(100, ErrorMessage = "* máximo {0} caracteres")]
        [Display(Name = "Sobrenome")]
        public string Sobrenome { get; set; }

        [Required(ErrorMessage = "O campo {0} é obrigatório")]
        [EmailAddress(ErrorMessage = "O campo {0} é inválido")]
        [Display(Name = "E-mail")]
        public string Email { get; set; }

        [Required(ErrorMessage = "O campo {0} é obrigatório")]
        [StringLength(100, ErrorMessage = "O campo {0} precisa ter de {2} e {1 caracteres}")]
        [Display(Name = "Senha")]
        public string Senha { get; set; }

        [Compare("Senha", ErrorMessage = "As senhas não conferem.")]
        public string ConfirmarSenha { get; set; }

        public bool Ativo { get; set; }
    }

}
