using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Linq;

namespace MeuPet.Domain.Model.Administrativo
{
    public class Empresa : spConsultarEmpresa
    {
        #region Parâmetros Internos

        private string _entidade { get { return "Empresas"; } }
        public string Usuario { get; set; }
        public string UsuarioToken { get; set; }

        #endregion

        #region Contrutores

        public Empresa()
        {
            Usuario = string.Empty;
            UsuarioToken = string.Empty;
        }

        public Empresa(string usuario, string usuarioToken)
        {
            Usuario = usuario;
            UsuarioToken = usuarioToken;
        }

        #endregion

    }

    public class spConsultarEmpresa
    {

        [Key]
        [Required(ErrorMessage = "* O campo {0} é obrigatório")]
        [Display(Name = "Empresa Id")]
        public int EmpresaId { get; set; }

        [Display(Name = "Token")]
        public string Token { get; set; }

        [Required(ErrorMessage = "* O campo {0} é obrigatório")]
        [MaxLength(100, ErrorMessage = "* máximo {0} caracteres")]
        [Display(Name = "Nome")]
        public string Nome { get; set; }

        [Required(ErrorMessage = "* O campo {0} é obrigatório")]
        [MaxLength(18, ErrorMessage = "* máximo {0} caracteres")]
        [Display(Name = "CNPJ")]
        public string CNPJ { get; set; }

        [Display(Name = "Data Abertura")]
        public DateTime? DataAbertura { get; set; }

        [Required(ErrorMessage = "* O campo {0} é obrigatório")]
        [MaxLength(256, ErrorMessage = "* máximo {0} caracteres")]
        [Display(Name = "E-mail")]
        public string Email { get; set; }

        [Required(ErrorMessage = "* O campo {0} é obrigatório")]
        [MaxLength(9, ErrorMessage = "* máximo {0} caracteres")]
        [Display(Name = "CEP")]
        public string CEP { get; set; }

        [Required(ErrorMessage = "* O campo {0} é obrigatório")]
        [MaxLength(100, ErrorMessage = "* máximo {0} caracteres")]
        [Display(Name = "Endereço")]
        public string Endereco { get; set; }

        [Required(ErrorMessage = "* O campo {0} é obrigatório")]
        [MaxLength(5, ErrorMessage = "* máximo {0} caracteres")]
        [Display(Name = "Número")]
        public string Numero { get; set; }

        [Display(Name = "Complemento")]
        public string? Complemento { get; set; }

        [Required(ErrorMessage = "* O campo {0} é obrigatório")]
        [MaxLength(100, ErrorMessage = "* máximo {0} caracteres")]
        [Display(Name = "Bairro")]
        public string Bairro { get; set; }

        [Required(ErrorMessage = "* O campo {0} é obrigatório")]
        [MaxLength(100, ErrorMessage = "* máximo {0} caracteres")]
        [Display(Name = "Cidade")]
        public string Cidade { get; set; }

        [Required(ErrorMessage = "* O campo {0} é obrigatório")]
        [MaxLength(100, ErrorMessage = "* máximo {0} caracteres")]
        [Display(Name = "Estado")]
        public string Estado { get; set; }

        [Display(Name = "Whatsapp")]
        public string? Whatsapp { get; set; }


        [Display(Name = "Logo")]
        public string? Logo { get; set; }

    
    }
}
